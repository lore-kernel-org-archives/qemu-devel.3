Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9683DC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAM0-0008W7-1h; Tue, 12 Mar 2024 18:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkALt-0008VA-5o
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkALq-0001UX-44
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710281519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xRHj6FmvwJqpyKuUQNp7sgDUjZnDE4YgpWOSWT+kIYc=;
 b=EgZB6RmdFk2h3+/vb6pt7kWD5BgacK1foZz0BCez7j3pUtuJVBLpqR/DVuZoO6+0wOLFLR
 AojC+ube3BuVljgrgoSfK8t5GYeHAw8glwas/bhfYQ1fMT9RuAktfMsTZ53sCY/0EAON6I
 F4IFeCXxsJ7ZNrUNaBhOSBlS9ja5SP4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-lrEo-MkAN5GXl-JNakHeEQ-1; Tue, 12 Mar 2024 18:11:58 -0400
X-MC-Unique: lrEo-MkAN5GXl-JNakHeEQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5a31ad8cdbaso23734eaf.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710281517; x=1710886317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRHj6FmvwJqpyKuUQNp7sgDUjZnDE4YgpWOSWT+kIYc=;
 b=ElQ6I0TAOOiFVYly4g7b1gSo2UabVg1/98byJtvn70cc4yNGSip205OwDc8bWyO+eg
 zXOdZobhLAQtXBqofmLpAKHzBUWCJFmhkC10RgNFWdh8LRwN0O6NrjVIg3d7jLjbdAIv
 g8W+pvoA9HYwKGAXDqckOkInIi6YttPpvqxf78pUxt4jyby0d0q5tnHGY7qO7yWjzSgx
 BXq/sV3ZxnP5okPTkPIriBclS8Q4nhSUD14ZBeY1pG73lOCSwdu2MBr32l2uAqBRJYZS
 o7ugfrqg3o944r5eiuZ5EmfDK30Sbm4jrsNnHbGMEtCGdUcGpt2N5IT/ohKCiSvcGSqZ
 luDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk5AObGxoszkq3yVUySKXnt4touP40hwE/Y9CdexDLwavfaHKKpC+3u5RVceRZpa5FUj2UExeeyE5n+O6yrRnsVJOeiIw=
X-Gm-Message-State: AOJu0YzOabg6lFgh/2ESDjOqiHLiGJcvVzazGa4wKSTWhykIq46GUh//
 IVw2Y5e+EBYZOjX9BgsQVZjxVLOjrjiJitsrUC68uFJADoRebHGnfwf6yddKyVFUF6I1+pHpIAQ
 6niPQqemkU2EnBmSqOTJJiLO51CC88RtFsgoKD3cX9GcqdHprq8Ie
X-Received: by 2002:a05:6808:1a1a:b0:3c2:4e43:7a56 with SMTP id
 bk26-20020a0568081a1a00b003c24e437a56mr38152oib.4.1710281517361; 
 Tue, 12 Mar 2024 15:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFojK8Vr08et1St1tQmhmmfG84y8ZEMs+G7aHS50S58BH6gwNgrfVhETjiToAJDDaRnHBiVJw==
X-Received: by 2002:a05:6808:1a1a:b0:3c2:4e43:7a56 with SMTP id
 bk26-20020a0568081a1a00b003c24e437a56mr38137oib.4.1710281517064; 
 Tue, 12 Mar 2024 15:11:57 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 b5-20020ac844c5000000b0042c61b99f42sm4145815qto.46.2024.03.12.15.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:11:56 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:11:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for 9.0] migration: Skip only empty block devices
Message-ID: <ZfDTKkksgW-HdnkF@x1n>
References: <20240312120431.550054-1-clg@redhat.com>
 <20240312184106.GC389553@fedora>
 <1b9016a1-ad58-47ba-9dda-96095c1e59bc@redhat.com>
 <20240312213426.GA449817@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312213426.GA449817@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 12, 2024 at 05:34:26PM -0400, Stefan Hajnoczi wrote:
> I understand now. I missed that returning from init_blk_migration_it()
> did not abort iteration. Thank you!

I queued it, thanks both!

-- 
Peter Xu


