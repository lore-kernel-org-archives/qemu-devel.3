Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8F6C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFvP-00082D-Do; Wed, 14 May 2025 13:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFFvL-0007m9-9Z
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFFvJ-0002bh-Ld
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747243780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8QSixm0bm9djZ6dFN+wfoKnT4AYnjqbzBBaht/B2LA=;
 b=AxIgN762fCT1BVFflayS+q9mR8ppyGpTdzWq2oKdzkHM3sj33zsP4B0H6xAHXQKNIwd8K5
 W7k0gi9CDSml5nMjht6MGbXV6JZrgfhaJkC3PZY3n/4gTnOx+fTiqNrSR+zi4JV2GEzqAz
 x09ry3QX9XtTlnnO1nIiZ/k9GYc8S6I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-yMJywiL3NHuoORgYiqwnlA-1; Wed, 14 May 2025 13:29:39 -0400
X-MC-Unique: yMJywiL3NHuoORgYiqwnlA-1
X-Mimecast-MFC-AGG-ID: yMJywiL3NHuoORgYiqwnlA_1747243778
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22e815dd332so758205ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 10:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747243778; x=1747848578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8QSixm0bm9djZ6dFN+wfoKnT4AYnjqbzBBaht/B2LA=;
 b=nQ/0Z4oFinjqAcFucIMg3+sv66a6gz/LNGOGTHnoSt6st4pUycyuYG/9BiLuN2yGG6
 Be7nBySbF2M6JVNTNkUW8cFUI3YFXUuixOTBNGg9bIm/b2KexSJUBEJ5UWgV6w60NyuL
 Q+9ISeUwv+emSMgLsyI8Ek9C+fiRHDPHFOJhdTCG8TACoWg0heB7gsTm6s7vQ3vS1OWp
 Qtw9MDwjnxXYfglRmUn2ucqznuBeGlTh0NVSzkLabmHWIx8kcA4EupQurwjHYPPOiZrv
 a05pY5U1uz2dQ0mgLHbyhEhQjdFt8lFWSLuv1CGnsoWrrtuTjomm9n9Cvs2TzQdM8HhS
 pYug==
X-Gm-Message-State: AOJu0YyBk8GW7LAsZ5dmKUzmoy24n6sN6q5vNoi7VYa1Mh6RnU9w40FV
 1T3qUTUfgmKz5vcKjEMgnLk4cKeFolvkyWarr0oDkacqXBpRlPtEJ8sSRcSiq1fmp5p5x+oSCxr
 l2J+gwJ+JLVxljfT2mUFmiFQ3JPA0kMgakHWTJo2eEmLrreDftzEpUUW+Ke3d
X-Gm-Gg: ASbGncuyJ/muRlIbV6RZLpW4Au/R2dIYYzax2Fi/sjEH8CHpdM88stk6fFLCoxBHr/e
 FlDbm2rjOUxkAnx6u9BcjnlttxUirsRKQbAXrREjLBrpxghrzJkJUSO5Ona4GVA8cLg4Q3rUU/k
 EAo5j7hXV929vpB9yUXEErv9FvFO/4iJOD/x6boYezO1F5PheVgvPugm/tT4oWjHCBr6vXsBNA5
 LCyoiu7HQBbLLJK4WWBrB/aNrRuWvd32CNPxGLSKxLH6CPqTbYxSw+3lwuxxsqXnQ8TdEu3Cm3t
 CHA=
X-Received: by 2002:a17:902:db10:b0:21f:7a8b:d675 with SMTP id
 d9443c01a7336-23198116744mr67583435ad.4.1747243777744; 
 Wed, 14 May 2025 10:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpAFXZp93RM6kir7+7G9sbA0uzrJ1hwpIoJXG6lcz9AYFAusqTEqIS92lkaMPbL3WsIyJg6Q==
X-Received: by 2002:a05:620a:45a5:b0:7c3:d711:6ffb with SMTP id
 af79cd13be357-7cd2887804dmr665092485a.41.1747243766582; 
 Wed, 14 May 2025 10:29:26 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00f4d797sm877963085a.11.2025.05.14.10.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 10:29:26 -0700 (PDT)
Date: Wed, 14 May 2025 13:29:17 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/3] migration/hmp: Dump global in "info
 migrate_parameters" instead
Message-ID: <aCTS7UkAqMnHitlo@x1.local>
References: <20250513220923.518025-1-peterx@redhat.com>
 <20250513220923.518025-3-peterx@redhat.com>
 <aCSZsXvHy0u_5LaP@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCSZsXvHy0u_5LaP@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 14, 2025 at 01:25:05PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > "info migrate" is the command people would frequently use to query
> > migration status.  We may not want it to dump global configurations because
> > dumping the same things over and over won't help.
> > 
> > The globals are just more suitable for a parameter dump instead.  Hence
> > move it over.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> I think this is a *little* odd, since 'info migrate_parameters'
> is a list of the things you can set with 'migrate_set_parameters'
> Perhaps it would be better to add it under the 'info migrate -a' option
> you add in the next patch?

Makes sense.

> 
> However, one other thing, the globals stuff prints a
> 'globals:'  at the start,  but doesn't print anything at the end,
> so if you make this change, you end up with out being able to tell
> where the globals end and the parameters start, so maybe a
> 'parameters:' after it?

I'll drop this patch, but only dump the globals if "-a" is specified in the
next patch.

Thanks!

-- 
Peter Xu


