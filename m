Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A233EF364A4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAswd-00041P-A4; Thu, 09 Apr 2026 13:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAswb-000419-DU
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAswZ-00006o-Of
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775754806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6uJ6P1y8FNDsY+hG+DSCcGyx1T+cYPq5W7WdzsZtzY=;
 b=Z26yn3RNeUmbR/NOVLerq96IB2IyxR+c6IE7kUvxo01JOrsTpHaqhkDV3yCt+NMnqn7C4L
 2gpWmqDyEHJRfTma9BeF2Yz4n8fTyrYQsVulTYKKEGPUImVDqxC0uWkM3E09nIi/q4UozO
 Wk2oF+t25r5PeRGeKHqjSUYtnjwcG4s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-l2grSCPXMgqzhx9Dyu-G6w-1; Thu, 09 Apr 2026 13:13:25 -0400
X-MC-Unique: l2grSCPXMgqzhx9Dyu-G6w-1
X-Mimecast-MFC-AGG-ID: l2grSCPXMgqzhx9Dyu-G6w_1775754804
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d121c4271so753534f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775754804; x=1776359604; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v6uJ6P1y8FNDsY+hG+DSCcGyx1T+cYPq5W7WdzsZtzY=;
 b=sv5O0ViQUa9Iz+sAVSbjE6SzDIB4wmUPwLSniMMwCDQt2lTLreBidGEWE9eFYtd4Ks
 +LErJzfZwJqTKJtLwQ7o80js2gjeuQLcmCJvdFo6MtMW8WM652MlYqznersvEAAZzU4G
 q9jwo48CPi+9QQKSHpyWusy4TLNo3Z+HMUMCIDYhcdOOOe7vIFElXLpu2Dz7F9jfLuL7
 hY0kUapp+PfMdxU5QnxfaJ/ZLRNaJ6CNGj0DIldyzTbEG7yCGSnndv4wGo6lssocJIKZ
 1bDentF2dcu7zcwL60vMnwZycEJ3cgS1yvMEv06brMr8mqWc/+mR5Xc/wPS7GhHdEDs9
 Ucow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775754804; x=1776359604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6uJ6P1y8FNDsY+hG+DSCcGyx1T+cYPq5W7WdzsZtzY=;
 b=cv394W8aLuEgt2O1vO7bY6GxSpsDrQjuIBfiwnV+HPFCd3/6+Zk77aVkNvecfpz4Fw
 l837RnZcaVrG26vDR9ur8d3LrxVIMKdSk5sMZFSojyPGY1MH9z4gPy0KkERu7kjalTkx
 rs4qjDITE0+BkbG2ujgBjEu5ZSvaA3zTGQcwhUzZzlTYs8WxOBkh7xPUGko61u43e7os
 eslEfa0p13CldWTBDHdP4bMWHqqwwQpbkQb4wQjI/t2kN6mU/CxX7tNEQ/eNKxG9aXNU
 XkpjbmRvcABqVp6SLsXohPVu1GgUfWO2MyLKNYF9CydTQu2k8B7a81glc/WaLdJk6mGn
 EXmg==
X-Gm-Message-State: AOJu0YyKe97UjPYeXKR2//lP0nc6wsc4+02WdRhLS9omrRA4YCznDFEc
 wRAvbfGMVf6e5OUYdNImkEk6qlaAfbXTLFg6Vu9rTtBIMWh0Tehv12pTJcnYh7ox3i7cIlrI9El
 hcTf4GfOBZMplYX1nwh46FKYJ1swI8wZQQK7+y56iwkCfVqKWVQMUcfsC
X-Gm-Gg: AeBDietQG6q58mSCjMviT7dlq/INxvNa2CtxwQjfnYfAo5478aO1zkljOF9CPxVGgIQ
 doETGErTo7WX427MHF2dvCfaa1PSi1Yk2aNc+0riAnaEOXcJI9/GQqstdLQrNlyrOCIrXBnQQ/s
 P0VImP7iuNjQLhlvazCa7FIHc6lG13S6qv7+r0aOjVOXArYYR8KvCsh2CBWRlTGuceMBy782dg+
 UW8iBwbNzRblGzoP/g5cgLZsBRjSLfJDwVIb6KkqW6bgVO7YEvRTzKWSJ0FsmljzwoF5V9By6GY
 yOWtQRT8U/zdewk59/SZGKst7DbdpyhYmZAVoTj2YFT5WQsJPn6ZJpIJvSRxyVbc74+NYIHg4OF
 S33hp46qj+gKinij86Pg5ZCQtCLplQSlcN8n8lCk=
X-Received: by 2002:a05:6000:2585:b0:439:a95b:3c43 with SMTP id
 ffacd0b85a97d-43d5a14af20mr5500818f8f.21.1775754804228; 
 Thu, 09 Apr 2026 10:13:24 -0700 (PDT)
X-Received: by 2002:a05:6000:2585:b0:439:a95b:3c43 with SMTP id
 ffacd0b85a97d-43d5a14af20mr5500775f8f.21.1775754803708; 
 Thu, 09 Apr 2026 10:13:23 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2a69sm278492f8f.4.2026.04.09.10.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:13:23 -0700 (PDT)
Date: Thu, 9 Apr 2026 19:13:20 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 06/14] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <adfd21izXQ_6MJmy@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408165559.157108-7-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-04-08 12:55, Peter Xu wrote:
> Allow modules to report data that can only be migrated after VM is stopped.
> 
> When this concept is introduced, we will need to account stopcopy size to
> be part of pending_size as before.
> 
> However, when there're data only can be migrated in stopcopy phase, it
> means the old "pending_size" may not always be able to reach low enough to
> kickoff an slow version of query sync.
> 
> It used to be almost guaranteed to happen as all prior iterative modules
> doesn't have stopcopy only data.  VFIO may change that fact by having some
> data that must be copied during stop phase.
> 
> So we need to make sure QEMU will kickoff a synchronized version of query
> pending when all precopy data is migrated.  This might be important to VFIO
> to keep making progress even if the downtime cannot yet be satisfied.
> 
> So far, this patch should introduce no functional change, as no module yet
> report stopcopy size.
> 
> This paves way for VFIO to properly report its pending data sizes, which
> will start to include stop-only data.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/register.h |  7 +++++
>  migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
>  migration/savevm.c           |  7 +++--
>  migration/trace-events       |  2 +-
>  4 files changed, 57 insertions(+), 11 deletions(-)
> 

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


