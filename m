Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DDCC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 05:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWrcm-0008Ud-CJ; Mon, 05 Feb 2024 00:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWrck-0008U9-NC
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 00:34:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWrcj-0006p8-DX
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 00:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707111268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qiGMWC6sgjtLUAmRiaOSLyjmm0AzgeFhH+U3EdmlPVg=;
 b=a6onH1Genc60cHPFjDlBLmmUIJcFPI/4AWcyjGtOQfS6YaZUYRMUxCPyMJvAt1f8cK3x4u
 Alges4pgALjb5ef2HLgwqVCaayTBeS5aLDfq9tKoS6XShPj1MTt7AlRJDgf0cjv5iFfZfg
 gwTEjro2ehUYD+wYisi5nqsYsPli/nI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-sGBP2Bh5O2uYLEFOronpkg-1; Mon, 05 Feb 2024 00:34:26 -0500
X-MC-Unique: sGBP2Bh5O2uYLEFOronpkg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e0441dce0fso231971b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 21:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707111265; x=1707716065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qiGMWC6sgjtLUAmRiaOSLyjmm0AzgeFhH+U3EdmlPVg=;
 b=u7JwwAz+rwqdUVfp5a8QByWmaJRjKnX6U1bsSs/zR8mEfbvDs30Qw+ahGZjJkmh+sc
 +4H/isyYEVOlfVxtgFfdmQDEcvEFzjFZS/C9t2buP9PIrhQi1/DyxP7OWqrYFQa85cIR
 wmq0av5RXyfDUMKe4PJ8kiyr/byajYDXy5fExyZcH/y5JSRtCep8le5nqh9E5ez/s6sl
 SlIsLrFTL7Jb7yd0p9SQLAEkqEpiG3TkWHd79G9Kuj4g2NY8KsJPnzPb0zxhi8bSecnu
 FStvGfQgm7XX8k+L24xqjgH4H/tVHkK7kEtVG9FszSF85bZ5YNRw7/y6SyL4X+pBpk9X
 /UYg==
X-Gm-Message-State: AOJu0Yy6NsjaUJYGjIBwSepzoeRXRSHd0L+kzfGnICT32OloTywscjuo
 wQ7C8gJFQ8exlNknQBGDm7gkijZrxB9Vr3af0WdemSyVnhR0LFqLi508sQXaQMk6vP31zBTL2l5
 1q76LdOerhKbY3CFQlJcixIrC708Cw5umadOllKFCOJwO7XUZ8VdN
X-Received: by 2002:a05:6a21:a598:b0:19e:578c:2aab with SMTP id
 gd24-20020a056a21a59800b0019e578c2aabmr8209510pzc.4.1707111265252; 
 Sun, 04 Feb 2024 21:34:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKM4f1m1OI0/baDcNAME/xLRjy2jqEIqiNEP3gTmo/IrSAlt28HOUXCZcsmTtX8KEAUEy1ew==
X-Received: by 2002:a05:6a21:a598:b0:19e:578c:2aab with SMTP id
 gd24-20020a056a21a59800b0019e578c2aabmr8209498pzc.4.1707111264919; 
 Sun, 04 Feb 2024 21:34:24 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVX740IIpeY2Pgt2jepsenfBzSfvMHCAg2SjrXJ1oD5u+safHLceQnEu+9aIdCeLunXhVtg+YgZ52+5vRuGMti3sKtNvxcSRpGd2W832pNzuOeLMK+6SY5vrw==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fh18-20020a17090b035200b00296885dcef7sm1831302pjb.16.2024.02.04.21.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 21:34:24 -0800 (PST)
Date: Mon, 5 Feb 2024 13:34:15 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 chenyuhui5@huawei.com
Subject: Re: [PATCH 2/5] migration/multifd: Remove p->running
Message-ID: <ZcBzV8VL5-3CwBpf@x1n>
References: <20240202191128.1901-1-farosas@suse.de>
 <20240202191128.1901-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202191128.1901-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Feb 02, 2024 at 04:11:25PM -0300, Fabiano Rosas wrote:
> We currently only need p->running to avoid calling qemu_thread_join()
> on a non existent thread if the thread has never been created.
> 
> However, there are at least two bugs in this logic:
> 
> 1) On the sending side, p->running is set too early and
> qemu_thread_create() can be skipped due to an error during TLS
> handshake, leaving the flag set and leading to a crash when
> multifd_save_cleanup() calls qemu_thread_join().
> 
> 2) During exit, the multifd thread clears the flag while holding the
> channel lock. The counterpart at multifd_save_cleanup() reads the flag
> outside of the lock and might free the mutex while the multifd thread
> still has it locked.
> 
> Fix the first issue by setting the flag right before creating the
> thread. Rename it from p->running to p->thread_created to clarify its
> usage.
> 
> Fix the second issue by not clearing the flag at the multifd thread
> exit. We don't have any use for that.
> 
> Note that these bugs are straight-forward logic issues and not race
> conditions. There is still a gap for races to affect this code due to
> multifd_save_cleanup() being allowed to run concurrently with the
> thread creation loop. This issue is solved in the next patch.
> 

Cc: qemu-stable <qemu-stable@nongnu.org>

> Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
> Reported-by: Avihai Horon <avihaih@nvidia.com>
> Reported-by: <chenyuhui5@huawei.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


