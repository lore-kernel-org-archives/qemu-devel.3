Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02760A2607
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LM59REBt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1c3-0003de-I3; Thu, 22 Oct 2026 18:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xK1c1-0003c6-BL
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:50:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xK1bz-0000De-G1
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:50:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1e34ecb02so1742495e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792709414; x=1793314214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tLCX0MFq2lPBGxec7+w1MDWPAWgf45VNplsQexTDOeM=;
 b=LM59REBtE6arJOsjhJiRoGp1+3Y//OUG5wDPDkQkNbDL6D4+/kdJF/060Pe90LFENJ
 dweVeTVh1tQeM/hnGl2vD/Af0Pn9hPxuZng3OMH4TjjVJDhGMnCcJ9g1iHT4Gp6MG9uW
 MLGDxqlxla9+3/fCdDUkIpm8HnaO1p2JvZm+jJC4eZqWLDnS8fnOa7Vb+ULkCakzAIwb
 GOg54wbEpPGkMl9o7Prd5jn8NLoILg1fO3K6nYHWhzgCAFcntIZs/AW8xZ2nI0aESutZ
 51oKR/hgnKCSDChW3MNCp17b3ViIKrrSgQTrSZO2flNmGT6L/dTcYVGK96YGr9skt6Fc
 fAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792709414; x=1793314214;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tLCX0MFq2lPBGxec7+w1MDWPAWgf45VNplsQexTDOeM=;
 b=zg0OZ7BLCo2Y+u+LeYNgE+QMmtf0Xwy1NmGKggIsAF9exJ6cPx28OhKdda5kK6BE9f
 kSICe31HRkVWm5hTt6Wr0BuN0XofQcufhcxGGqmJBu7+hPB4b2BKkSsS4CrsNFgjxXMh
 wv0XWA/qYfiY7LcZOM9e/e5x83dcPtjqrxgu10KIGFieOvv85dFbX7EPIl3v3f4SQo6y
 SEXv2Nc8SoKG+gllArTVRkqew+IKJ7VDPY0FVwzc4XI6NrjG4aq5ThifYP5qcOOeR7/R
 gq5V+HLRBL4ummI5Kh87PP6jG3uSYuhJXqTZ4pqnvhn1ua539p/y5eqcMRqiR41yC2iq
 NKbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxENZCFEW5D2vql8ieB5diWjVe4nTHZJw2y7i1gvVXOiYsjajSKL3Xi5b8oNuiGA57e3cyvrC5N7M4u@nongnu.org
X-Gm-Message-State: AFq9FYKn2nSj4wuJ2ktYQ8TE50HHrJ1pKV0Ci91XiCAsLFBl57WDnbnZ
 ZNQgqJVYbWwGCo8wvVFWIUBfMqay6hLvcisS78qs/zZ0za1FrnokH6NLJ1lJlA==
X-Gm-Gg: AYBFou0bSOIg6xi9RUWBMXyYHnE9m8Ef3XGUmFgKwZvmH2yU/n8huf1dlmtae80F3cP
 ySr2lw2MEQf2aNOlz8VfqapNVmigaNTiBDThIUAL9XxLOzhsFOiaAsx5IkFBJGpEszqjWGsRSjB
 cRiCjwv3KhE/5DOKwLwyZKTQFawR3v/sfUJ0Pf9G4CEY2PcsBxIMMRJtsL8uXOOBelLDveMhEzf
 eItltxJtOMnhP0UYIPck/1fatA47GbM2CR2z0HnIUSixTxjAFwBB/xPOQvv0wwa/qQCIcfx/DC0
 bZD5d+MfxJnc7A5DKvgiKkrM+ZubAaGCEQw1lgAjNhOUBY7/ja+81j5OxGPhp93qOdzKkKW94l4
 +M3ZtqwHcorEkwObNVm1K+0V7o1e5NdWqtbA4OYFCL5LLJ82A1kVk6sJkYf2i6YHMeCz5J1r+/Z
 Odx/fVcvb9X5jT5+K0iibUw6h6PN0s/DVd2yZmNa9HCCzo38Dv/WnYnoDregH0GKu/QoJvY1Teq
 p522++J189jTbqvf8PG++ZxtWVQ0E7tJhcG+7N7y7x1ycehaKXTrTSP5GST7OhlqcJ+j+qjhcKF
 pcPgBhaM7AcCrPnY4YwN9SgSS5gckaz+c+6QA44I+5NelfCzylwbf4H66I38cSr5srHYCyNoky5
 SRalGS30Zr8UX+UWsNw==
X-Received: by 2002:a05:600c:1c1b:b0:4a1:e11f:b2d5 with SMTP id
 5b1f17b1804b1-4a211c7870cmr7849325e9.2.1792709413578; 
 Thu, 22 Oct 2026 15:50:13 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1dba-0000-ec6b-a832-f355-434e.310.pool.telefonica.de.
 [2a02:3100:1dba:0:ec6b:a832:f355:434e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a210487d16sm29273725e9.15.2026.10.22.15.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 15:50:12 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:50:11 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>
CC: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_09/10=5D_docs/system/arm=3A?=
 =?US-ASCII?Q?_Document_MCIMX6UL-EVK_Buildroot_boot?=
In-Reply-To: <20261014045605.399684-10-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
 <20261014045605.399684-10-bin.meng@processmission.com>
Message-ID: <8713C764-0DB7-4C17-ACB8-F2A4987963C1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 14=2E Oktober 2026 04:55:59 UTC schrieb Bin Meng <bin=2Emeng@processmis=
sion=2Ecom>:
>Provide verified instructions for U-Boot and direct Linux boot using
>Buildroot images=2E
>
>Signed-off-by: Bin Meng <bin=2Emeng@processmission=2Ecom>
>
>---
>
>(no changes since v3)
>
>Changes in v3:
>- Document the RAM limits and firmware geometry rounding
>
> docs/system/arm/mcimx6ul-evk=2Erst | 72 ++++++++++++++++++++++++++++++++
> 1 file changed, 72 insertions(+)
>
>diff --git a/docs/system/arm/mcimx6ul-evk=2Erst b/docs/system/arm/mcimx6u=
l-evk=2Erst
>index 8871138ab3=2E=2Ea84b447019 100644
>--- a/docs/system/arm/mcimx6ul-evk=2Erst
>+++ b/docs/system/arm/mcimx6ul-evk=2Erst
>@@ -3,3 +3,75 @@ NXP MCIMX6UL-EVK (``mcimx6ul-evk``)
>=20
> The ``mcimx6ul-evk`` machine models the NXP i=2EMX6UltraLite Evaluation =
Kit
> MCIMX6UL-EVK development board=2E It has a single Cortex-A7 CPU=2E
>+
>+The minimum RAM size is 16 MiB and the maximum is 2 GiB=2E
>+The MMDC geometry reports the largest power-of-two capacity
>+not exceeding the configured RAM size to firmware=2E Direct Linux
>+boot uses the full configured RAM size=2E
>+
>+Booting Buildroot images
>+------------------------
>+
>+Build the SD card image with the tested Buildroot version:
>+
>+=2E=2E code-block:: bash
>+
>+  $ git clone https://gitlab=2Ecom/buildroot=2Eorg/buildroot=2Egit
>+  $ cd buildroot
>+  $ git checkout 2026=2E05
>+  $ make imx6ulevk_defconfig
>+  $ make
>+
>+The following examples use images generated by Buildroot::
>+
>+  IMAGES=3D/path/to/buildroot/output/images
>+  QEMU_BUILD=3D/path/to/qemu/build
>+
>+The generated raw ``sdcard=2Eimg`` is about 84 MiB, which is not a capac=
ity
>+supported by QEMU's SD card model=2E Resize the image in place to 128 Mi=
B::
>+
>+  "$QEMU_BUILD/qemu-img" resize -f raw "$IMAGES/sdcard=2Eimg" 128M
>+
>+This modifies the Buildroot output image; rebuilding the image restores =
its
>+original size=2E
>+
>+The SD card must be attached to USDHC2 with ``index=3D1``=2E It is conse=
quently
>+named ``mmc1`` by U-Boot and ``mmcblk1`` by Linux=2E The first partition=
 contains
>+the kernel and device tree, while the second partition contains the root=
 file
>+system=2E
>+
>+U-Boot boot
>+~~~~~~~~~~~
>+
>+The machine does not model the i=2EMX6UL Boot ROM or its SPL loading seq=
uence=2E
>+Load U-Boot proper at its linked address::

Extra ':' which prevents the code block being rendered correctly=2E Removi=
ng it fixes it=2E

>+
>+=2E=2E code-block:: bash
>+
>+  "$QEMU_BUILD/qemu-system-arm" \
>+      -M mcimx6ul-evk -m 512M \

The `-m 512M` will become redundant once my imx cleanup series lands=2E Sa=
me in the command below=2E

>+      -device loader,file=3D"$IMAGES/u-boot=2Ebin",addr=3D0x87800000,cpu=
-num=3D0 \
>+      -drive file=3D"$IMAGES/sdcard=2Eimg",if=3Dsd,index=3D1,format=3Dra=
w \
>+      -nographic
>+
>+The default Buildroot U-Boot environment selects ``mmc1``, loads ``zImag=
e``
>+and ``imx6ul-14x14-evk=2Edtb`` from the first partition, and starts Linu=
x with
>+``/dev/mmcblk1p2`` as the root file system=2E A ``bad CRC`` warning whil=
e loading
>+an uninitialized persistent U-Boot environment is expected; U-Boot conti=
nues
>+with its compiled-in defaults=2E
>+
>+Direct Linux boot
>+~~~~~~~~~~~~~~~~~
>+
>+QEMU can load the Buildroot kernel and device tree directly=2E The kerne=
l then
>+mounts the second SD card partition as its root file system::

Extra ':' here, too=2E

Best regards,
Bernhard

>+
>+=2E=2E code-block:: bash
>+
>+  "$QEMU_BUILD/qemu-system-arm" \
>+      -M mcimx6ul-evk -m 512M \
>+      -kernel "$IMAGES/zImage" \
>+      -dtb "$IMAGES/imx6ul-14x14-evk=2Edtb" \
>+      -append "console=3Dttymxc0,115200 root=3D/dev/mmcblk1p2 rootwait r=
w" \
>+      -drive file=3D"$IMAGES/sdcard=2Eimg",if=3Dsd,index=3D1,format=3Dra=
w \
>+      -nographic

