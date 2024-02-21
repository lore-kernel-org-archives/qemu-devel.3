Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987EFC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoVu-0004cd-6w; Wed, 21 Feb 2024 10:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcoMr-0004vi-5i
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:18:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcjN4-00085m-Oo
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 04:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708509514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tQq2OGiEvUR13+YGwxea3l3F67Nk2MzZ6m4iHz1Wq60=;
 b=Zcs60qdinuldoKIJlBp3LyqVEccxJuhA2a+uNLburv8+RISM2fCabM0PkYo4zM5bSLx7k/
 460rRNr6vrQPy21Gs8dnfi+AuwlUTIJxRkEtwlpWJ6P3rrYuGFrfVuBxX6zRA28bLgvTk9
 nfgKqlUEG18faev56hY2LPuBi7B5yqY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-HuCYohnkNsaVK7zufSTYIQ-1; Wed, 21 Feb 2024 04:58:32 -0500
X-MC-Unique: HuCYohnkNsaVK7zufSTYIQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5ce9b15f4ccso2810042a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 01:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708509511; x=1709114311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQq2OGiEvUR13+YGwxea3l3F67Nk2MzZ6m4iHz1Wq60=;
 b=f7DVjK13syebTN9OoWxa6rNYmal0odxyGcd8A4yjhQkdC1AGh56thhcn3UlPO4iB9R
 vxI+XGdB2G5CFxoEV8uz5pyWW0/UEhsZJl1cf9H8MD0uXDXWBiPaE7WxHY9/MEAQUw5w
 EqXmMr6IJ5pc6bet9731Mb4pOYg9VJqluq2x3HiQhlcV8OwRKh3FsL8x66npGlhYylGA
 Kyot3jhFtipKrXbdOwtudy70nf4bpPGhApQhRx6jd+RDMyas/fgurt70NwakW6aLk7e7
 P2I8igEq4maOsSFpTPZrS4THOy3OpEZbv4/aCrJwkG+76nmL9lj96nFjjluM2fIMTOd0
 De+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1FIi4zU/r8CBo7h+/cLqRFTzB/pnSpsBnbFGmN447QC+Hw3xyz9yC0coWRs6Tc/1kucHXOfi52a/kHcQURdysMGyIcrw=
X-Gm-Message-State: AOJu0YzoZXxC3npFWizZ9Hb/4Hr/xMi3WBCsPEm2Qz6Zh8YO9UgjNMB2
 U/COen39qHzHvj2RChZuWMUkMiSaqdssNMVmraWxyiq5l2nPOLxrhuqi5CcUJ9BTfkL6hJiPJl3
 /taCsnk6OxpmcxDt8FOuwLp2M7pdMeOh1oqU+aRot6KtAzHWwLlKC
X-Received: by 2002:a05:6a20:72a5:b0:1a0:b3c0:a080 with SMTP id
 o37-20020a056a2072a500b001a0b3c0a080mr5303689pzk.4.1708509511417; 
 Wed, 21 Feb 2024 01:58:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVNbfgzu+D14nGvoXEMtul3WAzdFIrhuIYWZii7HbKGziAkmdU7hbJIzn9A6t25J9w/gK59g==
X-Received: by 2002:a05:6a20:72a5:b0:1a0:b3c0:a080 with SMTP id
 o37-20020a056a2072a500b001a0b3c0a080mr5303678pzk.4.1708509511062; 
 Wed, 21 Feb 2024 01:58:31 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 bn23-20020a056a00325700b006e0416c42c3sm8456508pfb.198.2024.02.21.01.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 01:58:30 -0800 (PST)
Date: Wed, 21 Feb 2024 17:58:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] qapi: Misc cleanups to migrate QAPIs
Message-ID: <ZdXJQEK5jd_nVyWo@x1n>
References: <20240216195659.189091-1-het.gala@nutanix.com>
 <87edd61ezt.fsf@pond.sub.org>
 <b1ce8254-24e8-487e-8da0-d8916f53fcb4@nutanix.com>
 <ZdWzmbOuCVk8GZMn@x1n> <87sf1mxlqb.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf1mxlqb.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Feb 21, 2024 at 09:30:52AM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Thanks, Markus.
> 
> [...]
> 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > Markus, do you want us to pick it up, or let it go via qapi?
> 
> I can stick it into my next qapi PR in a few days, if you guys don't
> beat me to the punch.

That works, thanks!

-- 
Peter Xu


