Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D9FC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 05:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u37HN-0005Oc-H3; Fri, 11 Apr 2025 01:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u37HK-0005OP-Vk
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 01:50:15 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u37HJ-0001VM-As
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 01:50:14 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso2860524a12.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744350610; x=1744955410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Fdp/FVIgkYOdnbPHtW8FxgITkJJUE4uFwBiTz8ZIeQ=;
 b=lsBK7YJOSzfolrWyGCuSBCOmlh1RJtpy19IEZFwWdvko5WapPV8grd/jedk3KIdinr
 Slv4t+jlj/uSBCj7jGPChcKBkRQVYF9niIdtm2Ei83xbXSxa3c6i99v+81c3VE/XP6Jd
 ezM592OMcx7iyzoMwcKDcymcD32WYsczIco6fCugKbZkc9O1PS00ElC2R2p6H8s2DIwK
 KoDKPiM8aDRvebdYHl0eFDjS/MIiYiNTWV/lZS7DBcFw0E+dn/AlWQrl/lWys32Z3VW9
 ZGUMGLPQUo17WcrbrD5xzZDe8M9H0qhujpl5XOD75Li8DHoqEH5GAEZ2SCp21Jo6GJLI
 GLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744350610; x=1744955410;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Fdp/FVIgkYOdnbPHtW8FxgITkJJUE4uFwBiTz8ZIeQ=;
 b=qYO81PRW0v+Jhi4iR0WV6sNdYx7oczt7sUOHmQZjDxU2+n7LFbxdse1mz6U3WEHequ
 Q0B+DHihTJWQoa8qCfMH6VmCtzqZdiYnEHYuhPFmQJLbJgO1thq+2tDczuKBxguyU+nY
 Gv8gJ/Hn/WDIgirUsdyJ2pFbImUtMHcu7rgJ3CKhfKX7e8kkR8FW7u2BcYRFYgMOCVvl
 ou99X3VjUHanMv888jnb7IqgxZ+U/m7hPC7myWGmB/h1+I4PD3rjbcvT60LyAnDo1CEI
 ULZ2wjWALBdpDai6UOYtqvN6v4hqrcefMh7fS8Bwe/EIHQudD9FBUUMBxEaatuyi2GHA
 S3DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9n8Y/KksWs+/TDZJMSD4EGCc3EEj8DmmohKylPR3dOX7Uu1/yBk67csiSBbP9CsyafBYraQ/sgpHG@nongnu.org
X-Gm-Message-State: AOJu0YysnDUr79jO9r6K9bQODZNSbsQZRsX7jkc4DHt9oPSXehWpIqvW
 fJjRytgTkmaTeDFfaEtMkIcpmSZTNjrYw0eNwVqg9MAuVYUkOLb5ndqUbw==
X-Gm-Gg: ASbGncu5nUmBFEx+RLjyrtinrR96a8gZWfWsCpRRIVccNa8/IFiVo+VpdVIzTpy0gLI
 KrtSbiyWtPyHJ4nRlPqgkRwb3JfHoeTx47kBBow9LZPfr+ZX1MB2+En0+r36Hvewb7oaaTBvnaq
 1LUqcoz0mxJvBCzviqjboaBoLOe1WDzJ2RdlHJue22TdFxYjx52QCqnsEkCk++hKiDi/IIHithw
 RNNyYXx2lGFUM13Ozg48sPUDlgO018p5gpfnzEZnhCn+V1CWpblzQ0ZOpjz9sGln3X15znnewv3
 04SiAlOYK7H+nyQgSb7LSX0yXBKUtCVg6b0=
X-Google-Smtp-Source: AGHT+IHoY+AIhitII95ferf2VdrvCC13eEWJtp9o1s6Yuz34tvOE8fYIJ2dR/RmO/o1k6Bp8gPPfPg==
X-Received: by 2002:a17:907:970d:b0:abf:750b:93b8 with SMTP id
 a640c23a62f3a-acad3491f22mr105245266b.22.1744350609803; 
 Thu, 10 Apr 2025 22:50:09 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1bb2e15sm393880466b.17.2025.04.10.22.50.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 22:50:09 -0700 (PDT)
Date: Fri, 11 Apr 2025 05:50:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_Add_property_to_supp?=
 =?US-ASCII?Q?ort_writing_ERSTBA_in_high-low_order?=
In-Reply-To: <d7f43c28-e328-4b19-b045-3b6fde881c89@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
 <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
 <42a82455-7fa1-4890-a9e8-690fec3433c3@roeck-us.net>
 <9239BBD2-DCB8-4B97-9EAA-FFB06CAB660C@gmail.com>
 <89b70bdd-00e3-46ee-8810-099da032f485@roeck-us.net>
 <C5389B31-E7B2-43E0-A10D-368571DAD081@gmail.com>
 <cd6dafe1-f291-46f4-8fb1-7555dc6a60db@roeck-us.net>
 <6A2167BC-910A-4801-8FB0-24C114EF5181@gmail.com>
 <3b0367ca-7242-4555-a6b2-ddf546374138@roeck-us.net>
 <A3422A32-92AB-4D53-A53F-DD9D0FD5C1EE@gmail.com>
 <d7f43c28-e328-4b19-b045-3b6fde881c89@roeck-us.net>
Message-ID: <B4D8DAAE-862D-43F2-8B88-18F93B094783@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 11=2E April 2025 03:53:27 UTC schrieb Guenter Roeck <linux@roeck-us=2En=
et>:
>On 4/8/25 14:56, Bernhard Beschow wrote:
>
>>>>> Tt turns out that sabrelite has the same problem=2E
>>>>=20
>>>> Did it work with QEMU 9=2E2?
>>>>=20
>>>=20
>>> No, the pcie interfaces on sabrelite don't instantiate for me with qem=
u 9=2E2 (9=2E2=2E3,
>>> more specifically)=2E I see the pcie root port, but nothing behind it=
=2E
>>=20
>> You need to add `bus=3Ddw-pcie` to the pci devices' options in QEMU 9=
=2E2=2Ex and earler, otherwise it will end up on the wrong bus=2E This is f=
ixed in master=2E
>>=20
>
>Just to give you a quick update, I needed the diff below to get virtio-ne=
t-pci
>to work on sabrelite=2E
>
>No luck with any other non-virtio PCI controllers, though=2E
>
>Guenter
>
>---
>diff --git a/include/hw/arm/fsl-imx6=2Eh b/include/hw/arm/fsl-imx6=2Eh
>index 9da32fc189=2E=2E7325f3f2c4 100644
>--- a/include/hw/arm/fsl-imx6=2Eh
>+++ b/include/hw/arm/fsl-imx6=2Eh
>@@ -456,10 +456,10 @@ struct FslIMX6State {
> #define FSL_IMX6_MLB150_LOW_IRQ 117
> #define FSL_IMX6_ENET_MAC_IRQ 118
> #define FSL_IMX6_ENET_MAC_1588_IRQ 119
>-#define FSL_IMX6_PCIE1_IRQ 120
>-#define FSL_IMX6_PCIE2_IRQ 121
>-#define FSL_IMX6_PCIE3_IRQ 122
>-#define FSL_IMX6_PCIE4_MSI_IRQ 123
>+#define FSL_IMX6_PCIE1_IRQ 123
>+#define FSL_IMX6_PCIE2_IRQ 122
>+#define FSL_IMX6_PCIE3_IRQ 121
>+#define FSL_IMX6_PCIE4_MSI_IRQ 120
> #define FSL_IMX6_DCIC1_IRQ 124
> #define FSL_IMX6_DCIC2_IRQ 125
> #define FSL_IMX6_MLB150_HIGH_IRQ 126
>

Yeah, that matches the device tree=2E Mind sending a patch?

