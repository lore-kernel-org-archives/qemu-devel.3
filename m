Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E029DC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FXA-0008LT-VN; Wed, 09 Sep 2026 06:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x4FX9-0008Ky-Mo
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:28:03 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x4FX7-0000lB-EP
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:28:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4843e9c5960so5411092f8f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788949679; x=1789554479; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lVqlMRpzOHjcNY+RRZZ1A0W8t4bxE7Pxtdv5lBOhUDY=;
 b=ZUB4kqS/5O/1OOrtVY5xCRl14MBSrc1iTxxArsLQvu+noEzt2sOZWVoiCCJwxVgVqk
 IerK6ae/hyWcDO1AMXINi9gXjtx1qLmaSWxailTuho06ogihevYF6VvAu7oVAQcFaNZ9
 T5zNI4VbhzcLzQsDORXzkhzS8izuvUPMwySec3IvFkZMu8dE0UI0HedNOGQ00zpoD8/Q
 AOHdCmCdMr2lyv51g6hbkOylKFs2umOm/oBxcpTpGrMjrixARpzKiIak6IUTtA6LKJbr
 hggAOLMDKje7htgxKpO9bF11XuZAgj1LcGvMDhqFwPoosgGXRejfJquNDVbCrJehx89T
 t3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788949679; x=1789554479;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lVqlMRpzOHjcNY+RRZZ1A0W8t4bxE7Pxtdv5lBOhUDY=;
 b=cpanZDfgHndjdb5SCTpomJnk+Y4dyJ/fR4MVQHn4nUmbacdtWHpU1DU/bts1v1X5Ao
 SYzf6jEh52S+GgfJXFGCsxCM/hSbsnfnsvOG+j+83Sk+pNz2K9cqjhDPpG6nJSYjg5ui
 0Drlb3WFqOSKlf7n2qLJVLbVDUU3pomK5j/T9rJ489jvrn6Ay5JN9hZSvGeSgy7mQquk
 rXSkxyOaMzx40zI1JqHLBPFFuRkAkmjGXX8Ty8nrDdPC1ldYeeqVCfCh6CMUGqVtgO+B
 zGZpfoXOzcQL//Y8X5lIjCf6oy0/VULeXQ2JMahUnF8fzqSsJfUHieqQ9nex8EH3+fR+
 5VIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUI7e7lPVDEeX9cuLzRSk6oW7Uh/9LPYbeW03aUi06DN8qlediGJwwW5YURSkAWgtQRNHEgMim806N@nongnu.org
X-Gm-Message-State: AFuF++n0yMhCDGE7/CpUc29fcoywN4dVOJMB2QVoXyJGQOO9ujBglkY/
 bMecamEuhkE8NZIkmjPva69GD9TXMQIXaUSVaZQHZ4ScpRrhhtUWC8AmGBlbhA==
X-Gm-Gg: AYBFou1OOvNqNXDPIhFCn734G7NAhtiitcrshaB+Io9EOXJHkE7Q5NGA33J2aG2NeHJ
 mt6itG7WI17K0m3OK32f6lsKSxShhtqUijMDMs/F8GAPLE2H+eZ9c0E/bld6EV7hhxa+g6OWcc4
 GEAIv3pV1oYHnFnfaiJtzjjsq+OQuX6jczy34ODDB9clmZIHgwgzzMhEV59Ir75b3n5pMGh8vnl
 NimQbLBZ3HRXYsQXsf20oVjPFCrkz3k0vNsruO9WgZiNx8YQ/ldkbZwwlRBreTJekUZZh4UhQQH
 6z2NDiB4ks+FEzs5lTeucrWrqKSG20VokMafoe4arxaUq8p3jdW9YjwtE9e1IaoDpGaTYTaw4dv
 BxaOC6jRoSIjKDsB69lhDRofIwWjbvMvSKNzWmgd3y1UsNSAz+zWQjZwDnXxLKWXEWTOh0gZ5Xo
 WBrRcXJ31RTE8gTDJVAahmHsahYrfQ/31mM3DzMUb9sG0GIlj9HjDHEwYpMsYNGdCh4yiLWf8HV
 KlJ
X-Received: by 2002:a05:6000:2287:b0:485:8b5c:da39 with SMTP id
 ffacd0b85a97d-4858b5ce1bdmr32496229f8f.12.1788949679193; 
 Wed, 09 Sep 2026 03:27:59 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859162f354sm35595207f8f.20.2026.09.09.03.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 03:27:58 -0700 (PDT)
Date: Wed, 09 Sep 2026 10:27:57 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>
CC: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_03/10=5D_hw/arm=3A_fsl-imx6ul=3A_M?=
 =?US-ASCII?Q?ap_early_firmware_register_placeholders?=
In-Reply-To: <20260812013619.2134092-4-bin.meng@processmission.com>
References: <20260812013619.2134092-1-bin.meng@processmission.com>
 <20260812013619.2134092-4-bin.meng@processmission.com>
Message-ID: <768450BF-240E-4E73-99FF-E234915C066A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
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



Am 12=2E August 2026 01:36:06 UTC schrieb Bin Meng <bin=2Emeng@processmiss=
ion=2Ecom>:
>U-Boot configures the AIPS bus access controls and the i=2EMX6UL SNVS
>low-power registers before its console is available=2E Its timer setup
>also enables the system counter through the control window on AIPS2=2E
>
>These blocks are not modeled yet=2E Map unimplemented regions at their
>documented addresses so early firmware accesses complete without
>falling through to unmapped memory=2E

Hi Bin,

You could try setting

   mc->ignore_memory_transaction_failures =3D true;

in mcimx6ul_evk_machine_init() instead and check if that prevents these (a=
nd any future such) failures=2E

Best regards,
Bernhard

>
>Signed-off-by: Bin Meng <bin=2Emeng@processmission=2Ecom>
>---
>
> hw/arm/fsl-imx6ul=2Ec | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/hw/arm/fsl-imx6ul=2Ec b/hw/arm/fsl-imx6ul=2Ec
>index d6f662efe4=2E=2E74c1a30959 100644
>--- a/hw/arm/fsl-imx6ul=2Ec
>+++ b/hw/arm/fsl-imx6ul=2Ec
>@@ -210,6 +210,21 @@ static void fsl_imx6ul_realize(DeviceState *dev, Err=
or **errp)
>     create_unimplemented_device("a7mpcore-dap", FSL_IMX6UL_A7MPCORE_DAP_=
ADDR,
>                                 FSL_IMX6UL_A7MPCORE_DAP_SIZE);
>=20
>+    /* AIPS bus configuration */
>+    create_unimplemented_device("aips1-config", FSL_IMX6UL_AIPS1_CFG_ADD=
R,
>+                                FSL_IMX6UL_AIPS1_CFG_SIZE);
>+    create_unimplemented_device("aips2-config", FSL_IMX6UL_AIPS2_CFG_ADD=
R,
>+                                FSL_IMX6UL_AIPS2_CFG_SIZE);
>+
>+    /* SNVS low-power general-purpose registers */
>+    create_unimplemented_device("snvs-lp", FSL_IMX6UL_SNVS_LP_ADDR,
>+                                FSL_IMX6UL_SNVS_LP_SIZE);
>+
>+    /* System counter control */
>+    create_unimplemented_device("sys-counter-control",
>+                                FSL_IMX6UL_SYS_CNT_CTRL_ADDR,
>+                                FSL_IMX6UL_SYS_CNT_CTRL_SIZE);
>+
>     /*
>      * MMDC
>      */

