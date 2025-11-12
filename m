Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9C5CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 08:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ67k-0004Tq-M0; Wed, 12 Nov 2025 03:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ66h-00040n-K4
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:21:35 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ66g-0007nm-0b
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:21:35 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4775638d819so2768305e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 00:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762935692; x=1763540492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qH8ciBPiYP4qTrr6MlWxogBRhrjrYItQMLpGGH6YH/Y=;
 b=Sn/EqrYQJL7KA6fmpS4zGW/twAP1TIOlgxGkuG7YdmuX+xRbxgcgPz8NCzgfvVwdFc
 X2t2mYmZThkcvKulPIwrryEwZonYLEnfSEy4fPkL/+OX3twlkSdDpTbBecz4ZGVwCtiR
 OkxX/HfOiRYwaHVJzfJ6/KRJg9BZhMS4D8fzWaq82Cg70qI/le3USPKA3LmlDgyL/QdK
 SPUBVMccs8HpSGNlsnMhDEnGDb8z/NtkML+/PZ192lnaG8Q17Z2G+sfu3o8rDq2/KlpL
 MbfF//dJdiEWUX2QsfHOzyFiCTCshIWoHSGVNE41Lx0sOvNkDZ0nA0vva5lZeiAbG6yq
 9xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762935692; x=1763540492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qH8ciBPiYP4qTrr6MlWxogBRhrjrYItQMLpGGH6YH/Y=;
 b=ESsmqRfVelx9TMHWRlpMSSUeIXbwj11C6X2F7W7btOOeVMfNm0kGtxnfRQc2YCCGFE
 xR8VYmkS1kzYnZtygH/LrTnJSnsJmVTkthy3HPXoz47Bf4oNBfIMlpye2o5JG722b4SO
 MPfiTkhJt5j/emQqnu7t+lQQtuy7T3jxc9mOi10rQ2o+Ue327L5oyquZl/M6xD3x4tZW
 Zak6PuFnYwY2C4LS5zreV6inXBCZ/nmJadi/iMohNuvFfFtwyVMK8pHVWA+L0K1f3Los
 5YtNq5pDr9F7m0V5wIw17MRBc7OxO++7M0lOk1XZm5A6AdcIes5692cdF/MlG/IbtoYk
 7aag==
X-Gm-Message-State: AOJu0Yw08Jf57dboJzYiE41fCWbL61z7smPOS5KRd7W6kU014jxjG7jF
 34+iZXeGZXbuWkuaUNkZQCr6eWRH37s71kU/CykDJLEcv6UPX7k4M4WnsRInEqS4euY=
X-Gm-Gg: ASbGncv6LJqHQ5uXpMG+0wk3t28z62LPNlXA3JtaQ8kciNrqNjRpzXE8Lx4QGW6NGD5
 A5XZ7gahVUs2lchbmbikBB1D7N5ohhuomEZ5zuXmWgKDWAXclBxaxV65Uf41d1ux8NY8bVUHzb9
 nJNem8/v/9n5Kbyv3OCH8hLOCR1oXvF24WHmbXfErp9xzJdTqGFM1f6jlz1587TdmW/TOLWP8NJ
 HMFJce8MB4jfhd4HL1oIx+2jsVZaqvmBEGTfsVN9YuolfNkXuW6fyhIZlhKjZPQuY8EnI0bOzfn
 cwRJAoa0l79D9U8wC/OXqJh8WAhttVzlfXv5ieJb+6xAZimc+u8HxYMRw4lmLN63/h1PUU6E49M
 izCk3IVWaQ5SZGZT1QQJoLJQr4jJ+2d/99QAdjT4xxiKPbx1u9dhtWnMOfiBQMGBO5JInCY/Hyc
 KAfsxrHG4R+DaJN9y25mN05N3KjTqKVD24Zi6OE6vdxRI=
X-Google-Smtp-Source: AGHT+IEwYyOPzWvvsyZ9DfQBUPVAoUbXt4aj9HlMYrl5w7n4+sSw3BCoX29cOGNINjkVE1x10f+4gA==
X-Received: by 2002:a05:600c:3546:b0:477:fcb:226b with SMTP id
 5b1f17b1804b1-47787070774mr19154345e9.2.1762935692249; 
 Wed, 12 Nov 2025 00:21:32 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b316775f2sm22565926f8f.16.2025.11.12.00.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 00:21:31 -0800 (PST)
Message-ID: <26e9622f-2390-4a30-9c63-2374a1068093@linaro.org>
Date: Wed, 12 Nov 2025 09:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/19] config/target: Implement per-binary TargetInfo
 structure (ARM, AARCH64)
Content-Language: en-US
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson
 <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Luc Michel <luc.michel@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
References: <20251021205741.57109-1-philmd@linaro.org>
 <20251021205741.57109-7-philmd@linaro.org>
 <CAJy5ezqRdrpLvN5T_hZ2ec2FzQfQJvd+Osa9TpcFrOg=v8QW+Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJy5ezqRdrpLvN5T_hZ2ec2FzQfQJvd+Osa9TpcFrOg=v8QW+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Edgar,

On 11/11/25 22:28, Edgar E. Iglesias wrote:
> On Tue, Oct 21, 2025 at 2:59 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     Implement the TargetInfo structure for qemu-system-arm
>     and qemu-system-aarch64 binaries.
> 
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
>     Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org
>     <mailto:pierrick.bouvier@linaro.org>>
>     Reviewed-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
> 
> 
> 
> Hi Phil!
> 
> Trying to run xenpvh guests with latest QEMU but running into trouble, 
> the xenpvh does get built into qemu-system-aarch64 any more.
> Bisecting pointed me to this patch.
> 
> To reproduce --enable-xen, and see if xenpvh shows up in -M \? or not.
> 
> Any ideas?

Oops, sorry for that :/

I suppose I missed the following in commit 38c5ab40031 ("hw/arm: Filter
machine types for qemu-system-arm/aarch64 binaries"):

-- >8 --
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 1a9eeb01c8e..86a02966161 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -12,2 +12,3 @@
  #include "hw/xen/xen-pvh-common.h"
+#include "hw/arm/machines-qom.h"

@@ -97,2 +98,3 @@ static const TypeInfo xen_arm_machine_type = {
      .instance_init = xen_arm_instance_init,
+    .interfaces = arm_aarch64_machine_interfaces,
  };
---

I don't have a handy Aarch64 machine with Xen anymore, I'll see
tomorrow if I can get access to one. Do you mind testing this hunk
meanwhile?

Thanks,

Phil.

