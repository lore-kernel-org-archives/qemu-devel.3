Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89004C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 06:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWsWf-0005EJ-UX; Mon, 05 Feb 2024 01:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWsWe-0005EA-EF
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 01:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWsWc-0000A5-2C
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 01:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707114732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7/hOTX4Q5H3KERf/DBeTkPVp+IFXB54ziNh9niLiWE=;
 b=RL+pJwARmsyINKvsd/EX8qRyHRH1LquFSo5zfbh7wHn8+0b9IGySbVTwgAybKcpK9vEVcS
 cZKBXwuHeH0vUM688MoywTSh0BNOr+4O7SvcmKkXc7VoyA+zunKbeM82cpmt8U3sQIn6Wr
 yzSWHdd26fU2pNvWpQuiQZf/XQrpFb4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-QglxT5VFPmqjJIxsrPEvEA-1; Mon, 05 Feb 2024 01:32:10 -0500
X-MC-Unique: QglxT5VFPmqjJIxsrPEvEA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf8663f2d6so1295321a12.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 22:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707114730; x=1707719530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7/hOTX4Q5H3KERf/DBeTkPVp+IFXB54ziNh9niLiWE=;
 b=OtSU9u3sWdfZKQBpislS5t8Z7b4QL6ZXv+EW55ZtlIloJtN+6dWt+Jxj0/FwOxPRCS
 79McM8ffHvLV3RyfS4VgbAiR4ZIx4O2DG4vVoM8gTUuEVucQ+lDOU8+hxfJLrMLZltDc
 OxUYtLLzJrfMMjooifclc9V5EP3GRy637MK4mdFsvOsMUm+W6CuMeHjozpb0SJfk2SBl
 3E42mmsnhAznrS5PCz13tu3Nl5+yiBfs3Cgzf3KX5pvv/uPYA8I5dACRETSosZZ4rx7/
 WgmbklTBdDz6/ls4QEikgIfKI7TA7nnuc63lqGfnupxNgvHyzGI2BC+mSdZzLB73+F/L
 S3GQ==
X-Gm-Message-State: AOJu0YwP3886E3g5sYTeykWgGTG6mFm2Vz6AsHyUClo3afby2f1AnPSA
 ZCRvNNHzfg+I4LzKhoIhvPkxWLjgxIeeYWZPcXGjbtjbTC8ba4E1ogMd83rdj30IZ3DMpX/XbAL
 FDnVQlqmtL1yVBT1ubU2TPjTixBWH2/c7X1UWnBfPM+lthVnI3zb+
X-Received: by 2002:a17:90b:1bcf:b0:296:18d4:4af with SMTP id
 oa15-20020a17090b1bcf00b0029618d404afmr12225383pjb.3.1707114729773; 
 Sun, 04 Feb 2024 22:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFujMCLxi0M1BjWOYHArA0xVh0bjF9psQRxSQIGSXr9CkmQO65k8NWRKNfbPgbytv0SKCcHQA==
X-Received: by 2002:a17:90b:1bcf:b0:296:18d4:4af with SMTP id
 oa15-20020a17090b1bcf00b0029618d404afmr12225372pjb.3.1707114729422; 
 Sun, 04 Feb 2024 22:32:09 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX2sSHGRGWLwss4qQv2r58vRaZtZuAsttt2h7AbJMFrhmt81QWp1gnAGVdUb8UWOwsqxDwMsFxxvDsH1HXBRmff3GxQNX+33jNvZZOKLP4eGWpJrFAe0zw=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p4-20020a17090ad30400b00296a6ace54bsm578960pju.38.2024.02.04.22.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 22:32:09 -0800 (PST)
Date: Mon, 5 Feb 2024 14:32:00 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 0/5] migration/multifd: Fix channel creation vs. cleanup
 races
Message-ID: <ZcCA4OIVZuPrQiSM@x1n>
References: <20240202191128.1901-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202191128.1901-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Feb 02, 2024 at 04:11:23PM -0300, Fabiano Rosas wrote:
> Hi,
> 
> This contains 2 patches from my previous series addressing the
> p->running misuse and the TLS thread leak and 3 new patches to fix the
> cleanup-while-creating-threads race.
> 
> For the p->running I'm keeping the idea from the other series to
> remove p->running and use a more narrow p->thread_created flag. This
> flag is used only inform whether the thread has been created so we can
> join it.
> 
> For the cleanup race I have moved some code around and added a
> semaphore to make multifd_save_setup() only return once all channel
> creation tasks have started.
> 
> The idea is that after multifd_save_setup() returns, no new creations
> are in flight and the p->thread_created flags will never change again,
> so they're enough to cause the cleanup code to wait for the threads to
> join.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1162798843
> 
> @Peter: I can rebase this on top of your series once we decide about
> it.

I have one thing to double check with you in patch 5, besides that the
whole set looks all good to me.  Copy Dan here in case he has any input.

If you confirm both sides (my replies to last patch of both this set and
the other lockless change of mine), feel free to repost directly based on
that series for v2.

Thanks,

-- 
Peter Xu


