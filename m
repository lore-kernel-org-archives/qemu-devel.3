Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF4EC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 05:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVPtJ-0004tD-VN; Thu, 01 Feb 2024 00:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rVPtJ-0004t5-1b
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rVPtH-0006Kw-21
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706766334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrZJ/AowMt6oQJfUgFFl0nMCFgpFOf67HDJhCz5Bl3o=;
 b=bPvtd1aGhWr7+kPAb+7PVPoULFuxTWCxXOrOCOseFtspgjMWHujUs24qEha/1m2MVpr85E
 aiCfG1xqXs4hlVoaxjHF/n4t2z+e3BPkddkhUWZyHNHM/zbFiM5cnK1xdXogqwJO+DiP8C
 kB46ZA/KcNV22u60HM9GUXxF+ig7Oj0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-R-i_GEIWOIiJuuqoQGpnSg-1; Thu, 01 Feb 2024 00:45:33 -0500
X-MC-Unique: R-i_GEIWOIiJuuqoQGpnSg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-295f98e03ccso314615a91.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 21:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706766332; x=1707371132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrZJ/AowMt6oQJfUgFFl0nMCFgpFOf67HDJhCz5Bl3o=;
 b=lAMNK4mUcs82seYTxKUR7jVuxOGutLdi2qXvSCBrmS87VQC5lgYZi0k+BKfEYlmBTH
 lZ5y6U5zWwxIsJXUDSZlPUxj8xgGE4TFHHtTFlD3ZwsZbJjr+OhAS2//rYP8LTkhnCs6
 KXCuhV02AkJq2NBm0ISVD22KUWB43TiCbWF9CkGYqnyRLLtL/QJj7AX0jHL1uGUcwADA
 FGAUR64kvVE0OBcFmY64ZEGpNXvLwrKIMpzz3kOHZ3R4Ce6oRzz1BTM549QU7y+ytzTY
 bSs9BNnLAiF5KzwVcfhhkVWAF0Fb5PbSdPwt2JwS/L50igDlEWucse/qLT8+6Vie+Tmc
 Pq8g==
X-Gm-Message-State: AOJu0YziHyVau5/1L3Q2toWjjnG+To3uslRA3Mg2YEQn91HVm10YT48y
 9wjjnEhPCvDfR8YsO/J/D+sEhLL2670gLIeX4qk3LiSfsg3+8M8WVuztnGIqVs86OD6y/nVtKkQ
 rKt9aUvaZa97YyM8E/u7kyY0F/hvAWiW4AXSatvRkqFWlfF49/mD0AOu68XJ31IkHgG2f+naWz0
 xpUK8OLYwVShwdG0M3laAZa1Kt1r8=
X-Received: by 2002:a17:90a:f417:b0:295:b364:58f with SMTP id
 ch23-20020a17090af41700b00295b364058fmr3733108pjb.26.1706766332060; 
 Wed, 31 Jan 2024 21:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyhRk+MFlQ64TqcWIVK7QuYw9pi9mcqa+n+OZ6blJukqh9bvv9FkXyiOb2PaC5x1B8LaicvpCB+pBoeW+1WgI=
X-Received: by 2002:a17:90a:f417:b0:295:b364:58f with SMTP id
 ch23-20020a17090af41700b00295b364058fmr3733098pjb.26.1706766331826; Wed, 31
 Jan 2024 21:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20240124102904.334595-1-lvivier@redhat.com>
In-Reply-To: <20240124102904.334595-1-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Feb 2024 13:45:20 +0800
Message-ID: <CACGkMEuijE=r_AavGpCDgsbFx42czcFHkLcadZXmJ7os2YGuBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] igb: fix link state on resume
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 24, 2024 at 6:30=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> On resume igb_vm_state_change() always calls igb_autoneg_resume()
> that sets link_down to false, and thus activates the link even
> if we have disabled it.
>
> The problem can be reproduced starting qemu in paused state (-S) and
> then set the link to down. When we resume the machine the link appears
> to be up.
>
> Reproducer:
>
>    # qemu-system-x86_64 ... -device igb,netdev=3Dnetdev0,id=3Dnet0 -S
>
>    {"execute": "qmp_capabilities" }
>    {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
>    {"execute": "cont" }
>
> To fix the problem, merge the content of igb_vm_state_change()
> into igb_core_post_load() as e1000 does.
>
> Buglink: https://issues.redhat.com/browse/RHEL-21867
> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
> Cc: akihiko.odaki@daynix.com
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>
> Notes:
>     v2: Add Fixes: and a comment about igb_intrmgr_resume() purpose.
>

Queued.

Thanks


