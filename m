Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE91C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Pq-0003Pt-TB; Sat, 08 Mar 2025 18:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Pn-0003Ok-8v
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:17:07 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Pk-0002hh-DA
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:17:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso292645e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475823; x=1742080623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=INW01CuM2OwxyeZ3NmWM0knJinOt8Ggn1MBxQ2GRxd4=;
 b=m1RF+Quq4CHd+TMetiRP6IG6y9RQstB5vuAOIcQGPL+TXBtJ2QX+IccHb+lrevt2pX
 w1akoEgrl1J0qsdIa+3rsUCKuIBt/ataro1uqePNnKC3ATWVPylc0KAmWUwBTpJJ220G
 wtozlSmCBKGWe0ScBTDmUBvfx8guLPSrbZrpIAqR+bg9kIbFNIH3SmjYLzEtdPklC4QM
 mohvl4l8f/3EasQ8N805k3qAsX33a11zZGPry6U+4mphLtS7KXJ9k5WmbeVxFX80gSjz
 2PoJlDLUQ6hNGH/9V8rtWZyvejjfyD2Z7Sg1makz57vlCCpSrz29hz51YPt1eNl5lrIF
 HivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475823; x=1742080623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=INW01CuM2OwxyeZ3NmWM0knJinOt8Ggn1MBxQ2GRxd4=;
 b=HWzLZaJ39Mh7lL4mYsEEGTr7CCvakIMzmatHac4GbPIgUuqb/PXizNimYyd8IvPFyn
 2Efd1190GBITbQx73uRBHfHCHeCOzDPqRxylTz1nT2wBvVQkTvh97yde/x+wdrYmg45r
 2esFimiVZPXql8pG/gVVI+GXeq+U/odLN4VFR0Y8d1kAy9eD8ZN5phKfW0foxyPVuzsK
 ehu6XXHng7mQF6C9TFEBiQtWa4gdIh97Qf2Uc0d7I9bIRcxq/S9h9xP8hxrZO6flFfOh
 GEtGg+BDAeNfBgs4JEOoYkScwzYmXU95LcFraNX8nUi3Ec5assXRkTlXNRcc9KlmbKHX
 3TBg==
X-Gm-Message-State: AOJu0YyI5wwDs5zDw7+uR0TDtaprjvayet7xtIcr6JoFi1fN/bveHu+u
 RxS4Hs01FZYEY8OosmdFGHutZQFEQ+zlRG6t/aXbXEpAyWUPS5EJLXJ6af664D8=
X-Gm-Gg: ASbGncs7oLpQ97Nxk7FHCFJj/ncJmFpUnB7ufuRmutADbhnGb7GnNSS3gdgh2FnmCeG
 oCzhMMmeGrUV29PMw0z9j1OSnRGTqZQReLDm+PuFplPPSFttNfb5oMW/5UCr/Mzyx/PkojS0cou
 oWz/OyhbLGocU5PArfDQsEOMT+kgWhxIiwkUtP6DejpgRqXkMU6XxE6q8TlRGPlK33ps+wLUbUj
 LpxD9u61ZIfTqJuFmcoO5g1alyFR78ZD2914gqJtxFOLXIJ66TfIE79TelcAvB1xUyXLWGLEyVS
 ul84GF9D/GLXjGYQrNbGmmyOK3l8Nj5msOHIuYwQmzpbwL25021VB/9LZAWwMVQeFYTWjljIoni
 rQahzj6prjf3f
X-Google-Smtp-Source: AGHT+IH3RKRQm0i4b3ozgtKHah6fNeUEEJ3R+EjLH4rIYDBdVWX58b8/Upk1EQciUfWiMN5InSk8Mw==
X-Received: by 2002:a05:600c:3510:b0:43b:cf12:2ca5 with SMTP id
 5b1f17b1804b1-43c601d9145mr51835285e9.8.1741475822874; 
 Sat, 08 Mar 2025 15:17:02 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01de21sm10244448f8f.59.2025.03.08.15.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Mar 2025 15:17:01 -0800 (PST)
Message-ID: <142807a2-9536-4483-80ab-5f24793c841f@linaro.org>
Date: Sun, 9 Mar 2025 00:16:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] hw/sd/sdhci: Introduce SDHCIClass stub
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-4-philmd@linaro.org>
 <1839f9de-2370-50bd-7003-ade92707f137@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1839f9de-2370-50bd-7003-ade92707f137@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/3/25 23:34, BALATON Zoltan wrote:
> On Sat, 8 Mar 2025, Philippe Mathieu-Daudé wrote:
>> TYPE_SYSBUS_SDHCI is a bit odd because it uses an union
>> to work with both SysBus / PCI parent. As this is not a
>> normal use, introduce SDHCIClass in its own commit.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/hw/sd/sdhci.h | 9 +++++++++
>> hw/sd/sdhci.c         | 1 +
>> 2 files changed, 10 insertions(+)
>>
>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>> index 48247e9a20f..c4b20db3877 100644
>> --- a/include/hw/sd/sdhci.h
>> +++ b/include/hw/sd/sdhci.h
>> @@ -107,6 +107,13 @@ struct SDHCIState {
>> };
>> typedef struct SDHCIState SDHCIState;
>>
>> +typedef struct SDHCIClass {
>> +    union {
>> +        PCIDeviceClass pci_parent_class;
>> +        SysBusDeviceClass sbd_parent_class;
>> +    };
>> +} SDHCIClass;
>> +
>> /*
>>  * Controller does not provide transfer-complete interrupt when not
>>  * busy.
>> @@ -123,6 +130,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
>> #define TYPE_SYSBUS_SDHCI "generic-sdhci"
>> DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
>>                          TYPE_SYSBUS_SDHCI)
>> +DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
>> +                       TYPE_SYSBUS_SDHCI)
> 
> Are these two together just OBJECT_DECLARE_TYPE? Then the above typedefs 
> are also not needed just the struct definitions.

I'd like to but it isn't possible because the same object state/class is
used by distinct types (PCI & SysBus).

The following (expected to be correct) change ...:
-- >8 --
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 966a1751f50..341b130995b 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -155,10 +155,6 @@ typedef struct SDHCIClass {
  #define TYPE_PCI_SDHCI "sdhci-pci"
-DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
-                         TYPE_PCI_SDHCI)
+OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, PCI_SDHCI)

  #define TYPE_SYSBUS_SDHCI "generic-sdhci"
-DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
-                         TYPE_SYSBUS_SDHCI)
-DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
-                       TYPE_SYSBUS_SDHCI)
+OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
---

... produces:

FAILED: libqemu-aarch64-softmmu.a.p/hw_arm_mcimx6ul-evk.c.o
In file included from ../../hw/arm/mcimx6ul-evk.c:15:
In file included from include/hw/arm/fsl-imx6ul.h:31:
include/hw/sd/sdhci.h:165:1: error: redefinition of 
'glib_autoptr_clear_SDHCIState'
   165 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1360:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1360 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) (TypeName *_ptr) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1343:49: note: expanded from macro 
'_GLIB_AUTOPTR_CLEAR_FUNC_NAME'
  1343 | #define _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) 
glib_autoptr_clear_##TypeName
       |                                                 ^
<scratch space>:77:1: note: expanded from here
    77 | glib_autoptr_clear_SDHCIState
       | ^
include/hw/sd/sdhci.h:158:1: note: previous definition is here
   158 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, PCI_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1360:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1360 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) (TypeName *_ptr) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1343:49: note: expanded from macro 
'_GLIB_AUTOPTR_CLEAR_FUNC_NAME'
  1343 | #define _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) 
glib_autoptr_clear_##TypeName
       |                                                 ^
<scratch space>:48:1: note: expanded from here
    48 | glib_autoptr_clear_SDHCIState
       | ^
In file included from ../../hw/arm/mcimx6ul-evk.c:15:
In file included from include/hw/arm/fsl-imx6ul.h:31:
include/hw/sd/sdhci.h:165:1: error: redefinition of 
'glib_autoptr_cleanup_SDHCIState'
   165 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1362:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1362 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_FUNC_NAME(TypeName) (TypeName **_ptr) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1342:43: note: expanded from macro 
'_GLIB_AUTOPTR_FUNC_NAME'
  1342 | #define _GLIB_AUTOPTR_FUNC_NAME(TypeName) 
glib_autoptr_cleanup_##TypeName
       |                                           ^
<scratch space>:78:1: note: expanded from here
    78 | glib_autoptr_cleanup_SDHCIState
       | ^
include/hw/sd/sdhci.h:158:1: note: previous definition is here
   158 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, PCI_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1362:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1362 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_FUNC_NAME(TypeName) (TypeName **_ptr) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1342:43: note: expanded from macro 
'_GLIB_AUTOPTR_FUNC_NAME'
  1342 | #define _GLIB_AUTOPTR_FUNC_NAME(TypeName) 
glib_autoptr_cleanup_##TypeName
       |                                           ^
<scratch space>:49:1: note: expanded from here
    49 | glib_autoptr_cleanup_SDHCIState
       | ^
In file included from ../../hw/arm/mcimx6ul-evk.c:15:
In file included from include/hw/arm/fsl-imx6ul.h:31:
include/hw/sd/sdhci.h:165:1: error: redefinition of 
'glib_autoptr_destroy_SDHCIState'
   165 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1364:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1364 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_DESTROY_FUNC_NAME(TypeName) (void *_ptr) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1344:51: note: expanded from macro 
'_GLIB_AUTOPTR_DESTROY_FUNC_NAME'
  1344 | #define _GLIB_AUTOPTR_DESTROY_FUNC_NAME(TypeName) 
glib_autoptr_destroy_##TypeName
       |                                                   ^
<scratch space>:80:1: note: expanded from here
    80 | glib_autoptr_destroy_SDHCIState
       | ^
include/hw/sd/sdhci.h:158:1: note: previous definition is here
   158 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, PCI_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1364:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1364 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_DESTROY_FUNC_NAME(TypeName) (void *_ptr) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1344:51: note: expanded from macro 
'_GLIB_AUTOPTR_DESTROY_FUNC_NAME'
  1344 | #define _GLIB_AUTOPTR_DESTROY_FUNC_NAME(TypeName) 
glib_autoptr_destroy_##TypeName
       |                                                   ^
<scratch space>:51:1: note: expanded from here
    51 | glib_autoptr_destroy_SDHCIState
       | ^
In file included from ../../hw/arm/mcimx6ul-evk.c:15:
In file included from include/hw/arm/fsl-imx6ul.h:31:
include/hw/sd/sdhci.h:165:1: error: redefinition of 
'glib_listautoptr_cleanup_SDHCIState'
   165 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1366:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1366 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList **_l) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1346:48: note: expanded from macro 
'_GLIB_AUTOPTR_LIST_FUNC_NAME'
  1346 | #define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) 
glib_listautoptr_cleanup_##TypeName
       |                                                ^
<scratch space>:81:1: note: expanded from here
    81 | glib_listautoptr_cleanup_SDHCIState
       | ^
include/hw/sd/sdhci.h:158:1: note: previous definition is here
   158 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, PCI_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1366:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1366 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList **_l) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1346:48: note: expanded from macro 
'_GLIB_AUTOPTR_LIST_FUNC_NAME'
  1346 | #define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) 
glib_listautoptr_cleanup_##TypeName
       |                                                ^
<scratch space>:52:1: note: expanded from here
    52 | glib_listautoptr_cleanup_SDHCIState
       | ^
In file included from ../../hw/arm/mcimx6ul-evk.c:15:
In file included from include/hw/arm/fsl-imx6ul.h:31:
include/hw/sd/sdhci.h:165:1: error: redefinition of 
'glib_slistautoptr_cleanup_SDHCIState'
   165 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1368:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1368 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName) (GSList **_l) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1348:49: note: expanded from macro 
'_GLIB_AUTOPTR_SLIST_FUNC_NAME'
  1348 | #define _GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName) 
glib_slistautoptr_cleanup_##TypeName
       |                                                 ^
<scratch space>:83:1: note: expanded from here
    83 | glib_slistautoptr_cleanup_SDHCIState
       | ^
include/hw/sd/sdhci.h:158:1: note: previous definition is here
   158 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, PCI_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1368:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1368 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName) (GSList **_l) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1348:49: note: expanded from macro 
'_GLIB_AUTOPTR_SLIST_FUNC_NAME'
  1348 | #define _GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName) 
glib_slistautoptr_cleanup_##TypeName
       |                                                 ^
<scratch space>:54:1: note: expanded from here
    54 | glib_slistautoptr_cleanup_SDHCIState
       | ^
In file included from ../../hw/arm/mcimx6ul-evk.c:15:
In file included from include/hw/arm/fsl-imx6ul.h:31:
include/hw/sd/sdhci.h:165:1: error: redefinition of 
'glib_queueautoptr_cleanup_SDHCIState'
   165 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1370:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1370 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_QUEUE_FUNC_NAME(TypeName) (GQueue **_q) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1350:49: note: expanded from macro 
'_GLIB_AUTOPTR_QUEUE_FUNC_NAME'
  1350 | #define _GLIB_AUTOPTR_QUEUE_FUNC_NAME(TypeName) 
glib_queueautoptr_cleanup_##TypeName
       |                                                 ^
<scratch space>:85:1: note: expanded from here
    85 | glib_queueautoptr_cleanup_SDHCIState
       | ^
include/hw/sd/sdhci.h:158:1: note: previous definition is here
   158 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, PCI_SDHCI)
       | ^
include/qom/object.h:238:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
   238 |     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
       |     ^
/usr/include/glib-2.0/glib/gmacros.h:1379:3: note: expanded from macro 
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
  1379 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
       |   ^
/usr/include/glib-2.0/glib/gmacros.h:1370:36: note: expanded from macro 
'_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
  1370 |   static G_GNUC_UNUSED inline void 
_GLIB_AUTOPTR_QUEUE_FUNC_NAME(TypeName) (GQueue **_q) 
     \
       |                                    ^
/usr/include/glib-2.0/glib/gmacros.h:1350:49: note: expanded from macro 
'_GLIB_AUTOPTR_QUEUE_FUNC_NAME'
  1350 | #define _GLIB_AUTOPTR_QUEUE_FUNC_NAME(TypeName) 
glib_queueautoptr_cleanup_##TypeName
       |                                                 ^
<scratch space>:56:1: note: expanded from here
    56 | glib_queueautoptr_cleanup_SDHCIState
       | ^
6 errors generated.
ninja: build stopped: subcommand failed.

Don't ask me why it is so verbose...

Meanwhile the current legacy macros seems good enough for soft freeze ;)

