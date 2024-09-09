Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08E1ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniX7-00076Y-57; Mon, 09 Sep 2024 13:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniX5-00071G-Qn
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:50:35 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniX3-0008Ob-M6
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:50:35 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c241feb80dso10929026a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904232; x=1726509032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eAUOxZe966TlxARsKeOC4lr7RqNe2cdFRFO3nUSWr6w=;
 b=w4lVuWTnERO7mszwAmUAzJ2VcJrurRngjYtmj2blk3ZtjHqfls5PKr0B0OPC9XJLxr
 BwPOolBr2LnyNoMM3vxy0k9YcvWVlt/gQAuAIXaewDrA/hA3GLReiRgtQFF/9L+rm64N
 mhyBbhxiFZtL7mqITpTHm3cxS7bP9wRPdG4AgyuZ6KuZIoOF/QLxVb4Q9mGavDTmbw/N
 f5V1xbHekhPp9J5k3Vu5YcA6HTHgLCyUOflzlyHtOCkp/qd8Qxxw3iZ1wmEubW4W2/Lv
 moBkyS4/BKmZekGQ+IAowvSocSx2ymA1PsAng8Xhx8cgSqNNdL/yhH1AwWi/U/7yUBtk
 5BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904232; x=1726509032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eAUOxZe966TlxARsKeOC4lr7RqNe2cdFRFO3nUSWr6w=;
 b=ge3rKrjkq2XnJ7aKUrcPjoxpynIcBMQt7+kWYXI7r45HlskwROdKYA1TgrPrCUvj5x
 KS/QqixV78TswULaOjjzakRS2toyoSZW9ao5sbKAMiJunfl8d4BD9IW+qd+6jnsXf5EM
 gLs1pJ9eXXQIBTVR+ApiCKf5vxGbugZ4dUyhoYsh4hHFbalGd/PNsC3dW6wwVnHdm1SP
 T75xi1GfX64U7emlaZ4CfKC7Rs1mJPshvrKyPBh+oCjzWbn04f6XiM2g0pegigxpaRao
 UOzl4TvI3VPoMGnyfkiBLvpQ5FFtE1MTLLoVMRY1fRnPkqCdrkb4EZS+mYolqqOyywxL
 6Iug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVynxtigLcD6FaBhbiTeAJvZ1V7H3oftWk+6xPz2EK/b8T54pqO+p3LXMtq8zbQWxtNW8gkNgseZB8i@nongnu.org
X-Gm-Message-State: AOJu0Yy6eOU8qoucttiapAIa7NC/gWOoEFY6rlhPdFntXLbZxKC31gKK
 Bo2O1rquEIsQVKklQ5A76C+mRkfJTGaxpMf0iDkcTTcnLilPjJRc/gKfZbLQzpw=
X-Google-Smtp-Source: AGHT+IGg6BOeuO8B4a+kN14NkgnCCKFFsmYy87BkLQS+sOTsWgjjs1mtTZ8xPGFU3bsnKT8qrmKJOQ==
X-Received: by 2002:a17:907:7d8b:b0:a8a:754a:e1c1 with SMTP id
 a640c23a62f3a-a8d72c08cbemr51158266b.8.1725904231583; 
 Mon, 09 Sep 2024 10:50:31 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d66ba1sm369859766b.223.2024.09.09.10.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:50:31 -0700 (PDT)
Message-ID: <f870b3f6-0a75-43fa-a65a-e681174e340d@linaro.org>
Date: Mon, 9 Sep 2024 19:50:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 23/53] hw/timer: Remove pxa27x-timer
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-24-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/9/24 18:07, Peter Maydell wrote:
> The pxa27x-timer can be removed now we have removed the PXA2xx
> SoC models. The pxa25x-timer device must remain as it is still
> used by strongarm.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/pxa2xx_timer.c | 24 ------------------------
>   1 file changed, 24 deletions(-)
> 
> diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
> index d1a3ecac2b5..3234bbb1f4a 100644
> --- a/hw/timer/pxa2xx_timer.c
> +++ b/hw/timer/pxa2xx_timer.c
> @@ -54,7 +54,6 @@
>   #define OSNR	0x20
>   
>   #define PXA25X_FREQ	3686400	/* 3.6864 MHz */
> -#define PXA27X_FREQ	3250000	/* 3.25 MHz */
>   
>   static int pxa2xx_timer4_freq[8] = {
>       [0] = 0,
> @@ -572,28 +571,6 @@ static const TypeInfo pxa25x_timer_dev_info = {
>       .class_init    = pxa25x_timer_dev_class_init,
>   };
>   
> -static Property pxa27x_timer_dev_properties[] = {
> -    DEFINE_PROP_UINT32("freq", PXA2xxTimerInfo, freq, PXA27X_FREQ),
> -    DEFINE_PROP_BIT("tm4", PXA2xxTimerInfo, flags,
> -                    PXA2XX_TIMER_HAVE_TM4, true),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static void pxa27x_timer_dev_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -
> -    dc->desc = "PXA27x timer";
> -    device_class_set_props(dc, pxa27x_timer_dev_properties);
> -}
> -
> -static const TypeInfo pxa27x_timer_dev_info = {
> -    .name          = "pxa27x-timer",
> -    .parent        = TYPE_PXA2XX_TIMER,
> -    .instance_size = sizeof(PXA2xxTimerInfo),
> -    .class_init    = pxa27x_timer_dev_class_init,
> -};
> -
>   static void pxa2xx_timer_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -615,7 +592,6 @@ static void pxa2xx_timer_register_types(void)
>   {
>       type_register_static(&pxa2xx_timer_type_info);
>       type_register_static(&pxa25x_timer_dev_info);
> -    type_register_static(&pxa27x_timer_dev_info);
>   }
>   
>   type_init(pxa2xx_timer_register_types)

We could also remove the abstract parent:

-- >8 --
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 3234bbb1f4..b379b621cc 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -65,7 +65,7 @@ static int pxa2xx_timer4_freq[8] = {
      [5 ... 7] = 0,
  };

-#define TYPE_PXA2XX_TIMER "pxa2xx-timer"
+#define TYPE_PXA2XX_TIMER "pxa25x-timer"
  OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxTimerInfo, PXA2XX_TIMER)


@@ -561,36 +561,21 @@ static void 
pxa25x_timer_dev_class_init(ObjectClass *klass, void *data)
      DeviceClass *dc = DEVICE_CLASS(klass);

      dc->desc = "PXA25x timer";
+    dc->realize  = pxa2xx_timer_realize;
+    dc->vmsd = &vmstate_pxa2xx_timer_regs;
      device_class_set_props(dc, pxa25x_timer_dev_properties);
  }

  static const TypeInfo pxa25x_timer_dev_info = {
      .name          = "pxa25x-timer",
-    .parent        = TYPE_PXA2XX_TIMER,
-    .instance_size = sizeof(PXA2xxTimerInfo),
-    .class_init    = pxa25x_timer_dev_class_init,
-};
-
-static void pxa2xx_timer_class_init(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-
-    dc->realize  = pxa2xx_timer_realize;
-    dc->vmsd = &vmstate_pxa2xx_timer_regs;
-}
-
-static const TypeInfo pxa2xx_timer_type_info = {
-    .name          = TYPE_PXA2XX_TIMER,
      .parent        = TYPE_SYS_BUS_DEVICE,
      .instance_size = sizeof(PXA2xxTimerInfo),
      .instance_init = pxa2xx_timer_init,
-    .abstract      = true,
-    .class_init    = pxa2xx_timer_class_init,
+    .class_init    = pxa25x_timer_dev_class_init,
  };

  static void pxa2xx_timer_register_types(void)
  {
-    type_register_static(&pxa2xx_timer_type_info);
      type_register_static(&pxa25x_timer_dev_info);
  }

---

I can post a follow-up patch but not sure it is worth it.

Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

