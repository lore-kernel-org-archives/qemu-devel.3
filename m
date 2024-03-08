Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB38C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riaZx-000818-0c; Fri, 08 Mar 2024 08:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riaZu-00080b-Lr
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:48:02 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riaZs-0000ZZ-RR
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:48:02 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-568241f40e9so1042217a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709905678; x=1710510478; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hlJKeHuliWcDUbk17OKyfKYAWXWxnwxLDrZDjVS3SFg=;
 b=JsH9WNTzF9xIKSyOk1FVVkHUqxvGQWux52GDP7vUFLZ1+flgA5LDPQW24WDKI0fbgA
 wI/Qxxb1wY7ofhE7hpioBr34A5FgbhQWzmHyhC9WqWyjrdi7/B6EymTIdnyi/QtXLbWm
 3nqU9Db4eCe8SVrr/BOngNz9/p7hfXIwkYXq52fEd5cnSaV/dqFriLbCYiHRg9xwtIbE
 RNZOSJAhu0F8FikNSh+UtO76Us5C5XN2G+zXSm3NL5pRPmhuN+jt8zeIKrdqYCK+8qxY
 B0Lk5H0sezjo3ncZcrKEAQjpwaFoFF6BFE7hmWgoytuwebJIwDPxS/+D7TTonZ1BZdsj
 dxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709905678; x=1710510478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hlJKeHuliWcDUbk17OKyfKYAWXWxnwxLDrZDjVS3SFg=;
 b=oI5BELGtBc/0W8XKT6ZbetfebNU+uJ9VsIo9pA6ooeS81X8cTHx/gFpVTk2E98xTiG
 wirp7gGZrd7Ov3RZi1eBQsF44arybQs6PliGr8SHZq9DJx3D7WJBhyH1JFk2+BtgWSEP
 ume0wnjxnfbxPp+uP49CO9mCu+KTFkOe7OWkRG0wREntWqnrhQONZXnBTV+TwkmFY+94
 hH2Mf6img5xKSNJGug24X4+KiuAHGbiNpbFyQ/X7jQpKbJA33wfSR/G6O0NBatNFIiPr
 hfPYJiBV7qGtoyISH8IurF1FAcFMNdCGRIpmQVXcEBDQHzWUM4jbroXhRQUb9Rs4edA1
 DpJg==
X-Gm-Message-State: AOJu0Yz+r1r31y2MBcaG6QxqrrUJb4plXG4r0xkmsLJvHG+UNGg3pvMp
 4579EFnFzKRMigJtlw3eXXcEq9Xv8GLr1mgJfK+hz84pPO9zpVzaIHeqv82x126rp3+T73UBzjw
 yv+wmXdwNxJGNIi2MPtnkBAGOOOInKP3vJRKRsw==
X-Google-Smtp-Source: AGHT+IHEBM8fsNpcF8p6yrwpR9ILcXeyV1VsdP3DXQe0uyhVh1k3TbL1/3QVFBBtCW4tJc0cpiRjYiPJb09PpHZIBJk=
X-Received: by 2002:a50:d603:0:b0:566:2f24:b063 with SMTP id
 x3-20020a50d603000000b005662f24b063mr2075479edi.23.1709905678526; Fri, 08 Mar
 2024 05:47:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1707909001.git.mst@redhat.com>
 <8700ee15de465a55e5c7281f87618ca4b4827441.1707909001.git.mst@redhat.com>
In-Reply-To: <8700ee15de465a55e5c7281f87618ca4b4827441.1707909001.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 13:47:47 +0000
Message-ID: <CAFEAcA_W8BxG6rpcao2hCYntfU9aQfAzHQiy6RJQ-v3ZB4sNZg@mail.gmail.com>
Subject: Re: [PULL 53/60] hw/cxl: Standardize all references on CXL r3.1 and
 minor updates
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 14 Feb 2024 at 11:16, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Previously not all references mentioned any spec version at all.
> Given r3.1 is the current specification available for evaluation at
> www.computeexpresslink.org update references to refer to that.
> Hopefully this won't become a never ending job.
>
> A few structure definitions have been updated to add new fields.
> Defaults of 0 and read only are valid choices for these new DVSEC
> registers so go with that for now.
>
> There are additional error codes and some of the 'questions' in
> the comments are resolved now.
>
> Update documentation reference to point to the CXL r3.1 specification
> with naming closer to what is on the cover.
>
> For cases where there are structure version numbers, add defines
> so they can be found next to the register definitions.

Hi; Coverity points out that this change has introduced a
buffer overrun (CID 1534905). In hw/mem/cxl_type3.c:build_dvsecs()
we create a local struct of type CXLDVSecDevice, and then we
pass it to cxl_component_create_dvsec() as the body parameter,
passing it a length argument PCIE_CXL_DEVICE_DVSEC_LENGTH.

Before this change, both sizeof(CXLDVSecDevice) and
PCIE_CXL_DEVICE_DVSEC_LENGTH were 0x38, so this was fine.
But now...

> diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> index ddf01a543b..265db6c407 100644
> --- a/include/hw/cxl/cxl_pci.h
> +++ b/include/hw/cxl/cxl_pci.h
> @@ -16,9 +16,8 @@
>  #define PCIE_DVSEC_HEADER1_OFFSET 0x4 /* Offset from start of extend cap */
>  #define PCIE_DVSEC_ID_OFFSET 0x8
>
> -#define PCIE_CXL_DEVICE_DVSEC_LENGTH 0x38
> -#define PCIE_CXL1_DEVICE_DVSEC_REVID 0
> -#define PCIE_CXL2_DEVICE_DVSEC_REVID 1
> +#define PCIE_CXL_DEVICE_DVSEC_LENGTH 0x3C
> +#define PCIE_CXL31_DEVICE_DVSEC_REVID 3
>
>  #define EXTENSIONS_PORT_DVSEC_LENGTH 0x28
>  #define EXTENSIONS_PORT_DVSEC_REVID 0

...PCIE_CXL_DEVICE_DVSEC_LENGTH is 0x3C...

> -/* CXL 2.0 - 8.1.3 (ID 0001) */
> +/*
> + * CXL r3.1 Section 8.1.3: PCIe DVSEC for Devices
> + * DVSEC ID: 0, Revision: 3
> + */
>  typedef struct CXLDVSECDevice {
>      DVSECHeader hdr;
>      uint16_t cap;
> @@ -82,10 +91,14 @@ typedef struct CXLDVSECDevice {
>      uint32_t range2_size_lo;
>      uint32_t range2_base_hi;
>      uint32_t range2_base_lo;
> -} CXLDVSECDevice;
> -QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x38);
> +    uint16_t cap3;
> +} QEMU_PACKED CXLDVSECDevice;
> +QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x3A);

...and CXLDVSECDevice is only size 0x3A, so we try to read off the
end of the struct.

What was supposed to happen here?

> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -319,7 +319,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
>                                 PCIE_CXL_DEVICE_DVSEC_LENGTH,
>                                 PCIE_CXL_DEVICE_DVSEC,
> -                               PCIE_CXL2_DEVICE_DVSEC_REVID, dvsec);
> +                               PCIE_CXL31_DEVICE_DVSEC_REVID, dvsec);
>
>      dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
>          .rsvd         = 0,

Perhaps this call to cxl_component_create_dvsec() was
supposed to have the length argument changed, as seems
to have been done with this other call:

> @@ -346,9 +346,9 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>          .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
>      };
>      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> -                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
> +                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
>                                 PCIE_FLEXBUS_PORT_DVSEC,
> -                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
> +                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
>  }

 static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)


and with similar other calls in the commit ?

Is there a way we could write this that would catch this error?
I'm thinking maybe something like

#define CXL_CREATE_DVSEC(CXL, DEVTYPE, TYPE, DATA) do { \
     assert(sizeof(*DATA) == TYPE##_LENGTH); \
     cxl_component_create_dvsec(CXL, DEVTYPE, TYPE##_LENGTH, \
                                TYPE, TYPE##_REVID, (uint8_t*)DATA); \
     } while (0)

thanks
-- PMM

