Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A69E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 17:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSJAE-0003j3-Fv; Mon, 30 Dec 2024 12:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSJAC-0003f3-3q
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 12:02:44 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSJA8-0002dN-Le
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 12:02:43 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436ae3e14b4so4703945e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 09:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735578159; x=1736182959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eHAeyoDd4nM0hxt81QHUEEBBjCfN8mngG8+vR6Tcg88=;
 b=u/Vb62ed1RCH6qqnCnM8b7QQ5G5oQd5+/sGU9C8L3uaKq9y07eB3jTeEcvanbMst/X
 q3Nj+qhKo1zbDaWq085wYm81GstbfxZH3NJmb33APdhSWvwB7xTcuGlZbtWYljGYsbjY
 /0sco1NYGQ20pwPcI73uGx/Dm2vN9FAXqN9d3Nfs3I8RaCACJ7wGtpOYiCx6nhZ5brx+
 cHIRc+xI8MFfd1tMoJQ6KIU3cRJAIZKK8kHj/boBHIibzrB8l5qvs+s8UEiQQXX7AP1a
 D/hENWg0U/RaueqGbopRcVz6Yjx3vie964AmT6cNS5PDn8nIr1RxkktcOcTfL//PzFb1
 6Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735578159; x=1736182959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eHAeyoDd4nM0hxt81QHUEEBBjCfN8mngG8+vR6Tcg88=;
 b=EGTM05RrQ4oNVBhyBXPCAefS977r13jvY8+fz1pJpCMtBTzO5rm0OL6I5Wu98xuyTH
 YuF4FUHAPtKTpNlRp/vXMq3pWXueYrm8wqDzyLyWzvl4QhRMkulMSxqW7Z9Qy27jhTEu
 ijMv4KkAFoEm29A2ysqZgTFo1/2GkOtj7ZedWG195fmVB0fzVihxwVtyM15eZBI+D7qh
 l9+R2Dz9E/cRmsFDGk7ZTOujmRxfWJ9/Re54Jei4WnKBzTS9+9lkMRDdbpJQC68hi6WX
 UMNtH0rwJ4Rwi9iSEIwN7tNrVbWBSWGBG8piuRZfK5o0nDV0frorXRU73z85fc41M3/L
 2mgQ==
X-Gm-Message-State: AOJu0Yyjy5JR6fSWQdfNLFxRuw+mskYnzBlaLMabPjHkzZDzkDa3hsX7
 uJehIVnt8/AydZz7+kGrDkD/7vNccE6jxOoPSFUPPcdx/phyKykGa4TllY26lWnzjG38W2lAyKU
 5
X-Gm-Gg: ASbGncvUkg9tTjR+X8kAqZItB1mjJthXDsdsQSjyPc4m1E6li+FHT6uGON2ODioEOaJ
 30f0l5iAY1lIRByK/yY7OPbO6r7bH6nwV9X1DSL6U1x0Y/khq2PcwKdr/OqlzC5JFdvQIr66lyv
 T93pdZCEwOUeP3XosFmT7vHmvj+Jd/OEBcExkXOO8vR5yUw0qtfg4XFAXD0FSXG0UWSAXEIiY17
 VGnFUzpSLNrLUIlReiAUyDIO5rMKLcwvn90J26K2y7H+Kec81YeSXF/JddsaqBrnv9BhtN7dGpY
 sIwuefmvwnP9dYakNHxkKoMs
X-Google-Smtp-Source: AGHT+IHl/VjWIyWlNKr+HfCfHyxHmPWSJ9rcmILnXdkjSeUdxAWZ35cA7PNcW7qk3RUkNP1HpmINzg==
X-Received: by 2002:a5d:584b:0:b0:385:fb40:e57b with SMTP id
 ffacd0b85a97d-38a221ea3a0mr32516856f8f.15.1735578158400; 
 Mon, 30 Dec 2024 09:02:38 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a8d32sm30752858f8f.99.2024.12.30.09.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 09:02:37 -0800 (PST)
Message-ID: <d005f227-cf46-4a62-a152-668030ad7e49@linaro.org>
Date: Mon, 30 Dec 2024 18:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/s390x: Declare loadparm as char[LOADPARM_LEN]
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>
References: <20241120085300.49866-1-philmd@linaro.org>
 <20241120085300.49866-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120085300.49866-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

ping for this single cleanup patch?

On 20/11/24 09:52, Philippe Mathieu-Daudé wrote:
> "hw/s390x/ipl/qipl.h" defines loadparm[] length as LOADPARM_LEN,
> use that instead of the magic '8' value. Use a char type for
> char buffer.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/s390x/ccw-device.h               | 5 +++--
>   hw/s390x/ipl.h                      | 2 +-
>   include/hw/qdev-properties-system.h | 2 +-
>   include/hw/s390x/s390-virtio-ccw.h  | 3 ++-
>   hw/core/qdev-properties-system.c    | 8 +++++---
>   hw/s390x/ipl.c                      | 6 +++---
>   hw/scsi/scsi-disk.c                 | 2 +-
>   7 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
> index 4439feb140..94a9b35714 100644
> --- a/hw/s390x/ccw-device.h
> +++ b/hw/s390x/ccw-device.h
> @@ -15,6 +15,7 @@
>   #include "hw/qdev-core.h"
>   #include "hw/s390x/css.h"
>   #include "hw/s390x/css-bridge.h"
> +#include "hw/s390x/ipl/qipl.h"
>   
>   struct CcwDevice {
>       DeviceState parent_obj;
> @@ -27,7 +28,7 @@ struct CcwDevice {
>       /* The actual busid of the virtual subchannel. */
>       CssDevId subch_id;
>       /* If set, use this loadparm value when device is boot target */
> -    uint8_t loadparm[8];
> +    char loadparm[LOADPARM_LEN];
>   };
>   typedef struct CcwDevice CcwDevice;
>   
> @@ -54,6 +55,6 @@ OBJECT_DECLARE_TYPE(CcwDevice, CCWDeviceClass, CCW_DEVICE)
>   extern const PropertyInfo ccw_loadparm;
>   
>   #define DEFINE_PROP_CCW_LOADPARM(_n, _s, _f) \
> -    DEFINE_PROP(_n, _s, _f, ccw_loadparm, typeof(uint8_t[8]))
> +    DEFINE_PROP(_n, _s, _f, ccw_loadparm, typeof(char[LOADPARM_LEN]))
>   
>   #endif
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index d7d0b7bfd2..014b530ad2 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -23,7 +23,7 @@
>   #define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
>   
>   void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
> -void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
> +void s390_ipl_fmt_loadparm(char *loadparm, char *str, Error **errp);
>   void s390_rebuild_iplb(uint16_t index, IplParameterBlock *iplb);
>   void s390_ipl_update_diag308(IplParameterBlock *iplb);
>   int s390_ipl_prepare_pv_header(Error **errp);
> diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
> index 7ec37f6316..844af7a200 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -3,7 +3,7 @@
>   
>   #include "hw/qdev-properties.h"
>   
> -bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
> +bool qdev_prop_sanitize_s390x_loadparm(char *loadparm, const char *str,
>                                          Error **errp);
>   
>   extern const PropertyInfo qdev_prop_chr;
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index 996864a34e..9d4e00b0c7 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -14,6 +14,7 @@
>   #include "hw/boards.h"
>   #include "qom/object.h"
>   #include "hw/s390x/sclp.h"
> +#include "hw/s390x/ipl/qipl.h"
>   
>   #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
>   
> @@ -28,7 +29,7 @@ struct S390CcwMachineState {
>       bool aes_key_wrap;
>       bool dea_key_wrap;
>       bool pv;
> -    uint8_t loadparm[8];
> +    char loadparm[LOADPARM_LEN];
>   
>       SCLPDevice *sclp;
>   };
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index a61c5ee6dd..e8e9cd8e04 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -35,6 +35,7 @@
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pcie.h"
>   #include "hw/i386/x86.h"
> +#include "hw/s390x/ipl/qipl.h"
>   #include "util/block-helpers.h"
>   
>   static bool check_prop_still_unset(Object *obj, const char *name,
> @@ -58,14 +59,15 @@ static bool check_prop_still_unset(Object *obj, const char *name,
>       return false;
>   }
>   
> -bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
> +bool qdev_prop_sanitize_s390x_loadparm(char *loadparm, const char *str,
>                                          Error **errp)
>   {
>       int i, len;
>   
>       len = strlen(str);
> -    if (len > 8) {
> -        error_setg(errp, "'loadparm' can only contain up to 8 characters");
> +    if (len > LOADPARM_LEN) {
> +        error_setg(errp, "'loadparm' can only contain up to %u characters",
> +                         LOADPARM_LEN);
>           return false;
>       }
>   
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 30734661ad..6fd3774c7d 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -416,7 +416,7 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>       return chain_addr;
>   }
>   
> -void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
> +void s390_ipl_fmt_loadparm(char *loadparm, char *str, Error **errp)
>   {
>       /* Initialize the loadparm with spaces */
>       memset(loadparm, ' ', LOADPARM_LEN);
> @@ -439,8 +439,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>       CcwDevice *ccw_dev = NULL;
>       SCSIDevice *sd;
>       int devtype;
> -    uint8_t *lp;
> -    g_autofree void *scsi_lp = NULL;
> +    char *lp;
> +    g_autofree char *scsi_lp = NULL;
>   
>       /*
>        * Currently allow IPL only from CCW devices.
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 8e553487d5..96a09fe170 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -3145,7 +3145,7 @@ static char *scsi_property_get_loadparm(Object *obj, Error **errp)
>   static void scsi_property_set_loadparm(Object *obj, const char *value,
>                                          Error **errp)
>   {
> -    void *lp_str;
> +    char *lp_str;
>   
>       if (object_property_get_int(obj, "bootindex", NULL) < 0) {
>           error_setg(errp, "'loadparm' is only valid for boot devices");


