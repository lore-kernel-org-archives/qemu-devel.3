Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A88AC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 01:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxEE1-0003P8-8W; Thu, 20 Aug 2026 21:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wxEE0-0003OK-HE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 21:39:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wxEDz-0002ID-3W
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 21:39:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cf452def93so11636005ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787276353; x=1787881153; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sS5teeV0L1N5cqks17enGc8q90XbDEHWweqKaW5VI1Q=;
 b=MpqJGFjU1vwuanlhIMfoOBULRPAIM3bD1G4/Gw+xoOoaQNLAeaJ20D6+DmK7jgisx0
 8ry5RQ9NeedpQkOxJH7icamGoLDhGuNyRS5HTBbIc1ZfpdrfIPEUNFamcEO+n3vN/b06
 RYZjrpGBUzj+VAMWkCP9aLFDaYPg6od6ee1gbOppEhz9IghCtGA5rnbJBuvAsXr8fRMv
 jht22HIyUhIJcIMWnhSd8I7SJxZ6OL0EOx5w8TU4LHWgIvEqIJ2okIo1O8oiF+Q4HHbU
 ZYG9+iDbFhYTAxco3JSrYyopl7Vqd+8Al2RFyxsrNlKhObl8HrGQ6VLf4XMe2gQlul6Z
 Go2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787276353; x=1787881153;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sS5teeV0L1N5cqks17enGc8q90XbDEHWweqKaW5VI1Q=;
 b=WKSM9E4yn/TbPYMUzmnJNy54F/gpMRbBcdlCokyg8W8Zu4QiwPWLTlxB+tI2BtveC/
 8MVwgefpcAAkpiD3eL1N6xtcUR2cwoJST4RySOm3uRaQLZ+S5bKA7f19sMcW9DZPxuA2
 SbYDK/Hk06PMVjYONdmfPd9oWjmYyg2OCaZU18JoidiOUPuex2djqHu5PKYYeJuDPMs3
 tgYDKLmWpxQk3As3jtZ1iZXGvDxsAkWhGutFzlmOLFaUj7QWCOyZqJT4Hmv48LcN1KkJ
 DlsNfcW5XRQGSPfUwhPIGSp5WtVLlUMrLT/lvQdm5FdpMjN26v98CXUUVWufhxr7Qzfa
 ahMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkwMJClLGz9GkQxmnvyr1FMLAQtJtX09lkkwAUKCfk0SicJU/xNmeKIK0dc2B2ft9kaUJLvwIVs5sa@nongnu.org
X-Gm-Message-State: AFuF++lXXvOvc4SoZygQo22bekDKi8zgCtCv/dymQyhpCLkkJPTTlF/3
 AiCqJViNYEVVUEpsGXv3d5xC3RqILaNPxh+CiX0m/JczmWKd02l+JCgn
X-Gm-Gg: AR+sD11Bcg5parJ1sAvgQpiGy83x0IWblxkoSMTCYvb+J8V12+kXpov1flNibeBWPqQ
 HiU7/X+za+GOH9H8EwRpJsT9nIcC5UVazgEUHQZNnuCpy6nOBex2ZD8gN63zuP7dwkxPwIZXuAb
 tU7p8/gPJqMPlw78QFwHcg9sVeOhJcV6J4lvu9jO0XM5QSvBrwUHPjdelAga2mkd2PEUoVL3ITs
 hR2a6QiRo4TAmc9F93SRwL+SYa2fYgriu6ywmeaH/QpNPfaRlBy59nUFg7ronMtbgNFTo1LHYvd
 FxxCH/k8XMjhSZUtP7M+t3eORt/GsP70T/AARKPdbFvjn+OpHFIHq+l+k/A6bLW+aBiZfq93F+F
 2y2RPczIaTx78tCk1Vy+RFv7Tnf84y68i/i7SMNfuGmrLIPu9Z5A7kmhtxlRBHLM0SRuEUEMmpZ
 C2N2GfH+H8y9uspgntha+PSP4CNVRQQDgDVw4P+QZivHBLDX9K3b4+8R1keR4hYTOO
X-Received: by 2002:a17:90b:57c3:b0:395:8124:ac53 with SMTP id
 98e67ed59e1d1-395c4fa443fmr1938540a91.6.1787276353472; 
 Thu, 20 Aug 2026 18:39:13 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4be666bsm981873a91.11.2026.08.20.18.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 18:39:12 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 6/7] ufs/aspeed: Add AST2700 UFS host controller
To: Mikail Sadic <mikail.sadic@ibm.com>
Cc: clg@kaod.org, peter.maydell@linaro.org, pbonzini@redhat.com, 
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com, 
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com, 
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com, 
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 j-young.choi@samsung.com
In-Reply-To: <20260813193040.669533-7-mikail.sadic@ibm.com>
References: <20260813193040.669533-1-mikail.sadic@ibm.com>
 <20260813193040.669533-7-mikail.sadic@ibm.com>
Date: Fri, 21 Aug 2026 10:38:44 +0900
Message-Id: <178727632471.917875.628695860358940242.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 13 Aug 2026 14:30:38 -0500, Mikail Sadic <mikail.sadic@ibm.com> wrote:
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index a9238e6217..c1052c74a8 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -187,6 +187,31 @@ static void aspeed_machine_init(MachineState *machine)
>      aspeed_connect_serial_hds_to_uarts(bmc);
>      qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
>  
> +    /*
> +     * If the SoC instantiated a UFS host controller (AST2700), attach the
> +     * first backend drive to it as logical unit 0.  The controller and its
> +     * UFS bus only exist once the SoC has been realized, so the ufs-lu is
> +     * created here rather than through a controller drive property.
> +     */
> +    if (object_resolve_path_component(OBJECT(bmc->soc), "ufs")) {

This appears to implicitly attach the first if=none backend to UFS LU
0. Why is this needed?

if=none backends are normally left unattached for explicit -device
use, so this may claim a drive intended for another device.

Wouldn't it be better to remove this and require users to attach
the LU explicitly, for example:
-drive if=none,id=ufs0,file=ufs.img,format=raw \
-device ufs-lu,bus=ufs-bus.0,drive=ufs0,lun=0

>
> diff --git a/hw/ufs/aspeed_ufs.c b/hw/ufs/aspeed_ufs.c
> new file mode 100644
> index 0000000000..bfe540b929
> --- /dev/null
> +++ b/hw/ufs/aspeed_ufs.c
> @@ -0,0 +1,67 @@
> [ ... skip 22 lines ... ]
> +struct AspeedUfsState {
> +    SysbusUfsState parent_obj;
> +};
> +
> +struct AspeedUfsClass {
> +    DeviceClass parent_class;

The parent class layout is SysBusDeviceClass, so this should be
`SysBusDeviceClass parent_class`

>
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index a00238ed74..dedc784926 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -62,6 +62,7 @@ struct AspeedMachineClass {
>      uint32_t uart_default;
>      bool sdhci_wp_inverted;
>      bool vbootrom;
> +    uint32_t ufs_block_size;

As noted on the previous patch, UFS does not permit 512-byte
logical blocks. Please drop this field and the corresponding 512-byte
configuration and documentation.

>
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index cd68c7f1ca..ae986dea12 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -118,6 +119,7 @@ struct AspeedSoCState {
>      AspeedAPB2OPBState fsi[2];
>      AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
>      AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];
> +    SysbusUfsState ufs;

Since this child is initialized as TYPE_ASPEED_UFS, shouldn't this be
AspeedUfsState rather than SysbusUfsState?

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

