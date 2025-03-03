Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0175FC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9xf-0001RU-2s; Mon, 03 Mar 2025 12:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9xa-0001Pq-7w
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:11 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9xX-00007V-1u
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:09 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390edaee0cfso2429240f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741024323; x=1741629123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KicCcYq2UjveTCard+1fZS3y1dRe4jB0t9s67fyte/A=;
 b=ciPZivczLbHN4nYeJyPHgb33oNZtBkwKFJ4hW3GqMlHQXAEN9PzV48W7lNhw4UmQYJ
 KaNtbhZ+rEwAGsOVheDjpt+U477I8FYbBR5wBkY8ebxxnQ26TPxL6476qDjVTm32OVj6
 9/GoCT6K2R/1slwcCmj/9Sj+I4kQWvcscvU9qLEbVZPmny/MtEDNL7pCFdTSrGT9vTDt
 nprp11FX72H/qy5ubk59biMPUdRPG5/tdRLN2HjCtIUGaPUOc4y6418ERCa+DSZpM6ss
 uBQD5EpY2EwRdFaAHUA+UmOC3tGEoUVi+HbwLlkqJeY48+nG/tHQ3y+4L9kG6HWk89vR
 p4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024323; x=1741629123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KicCcYq2UjveTCard+1fZS3y1dRe4jB0t9s67fyte/A=;
 b=MeAaS+wDAkKa29Yz+yF4Ifys22WUveXptWk07bPlwwPNRljfWeNliPJGq25+JIJWS6
 n6cORqFaJJoFNuTx1Abdh/ONqir1E1NdfQBcf+pCQvpBGx5weYiBUuJhmHUKLc5fPvWr
 RYHDpqKwSWPd/c+uWZGdg+w+6soiIqIkeAm0tqgkMTNYK+YnQmqulP1tf1z1jzqBpRN1
 TLPbOSBufv+ZSplHGW2LxBfSisFb3igyRwIVESAMisxCXr+hF2e+kKNhyk6pr3QTqgCz
 WzDhbzuRxbOcNdCckvg/HDXLhY1oZkLg7hmJRNg1u3AHZXgsTHXRmJdcAP7Mk5mQVLdj
 fLKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3vyVSF8ew1zMT+4rkPaTiD3f+wESS8BdWUP0hxY/XkgyGJrpbPH3jxU4z1qe3lQMr/Wu8IrKWfivG@nongnu.org
X-Gm-Message-State: AOJu0YyNkh/r42rd28Qbt6z/V8lGAzCSXZZc0oC6I8FGrEdiiJ1JO/DA
 RvL867X+bC8GEewAO1MxvEq/1NSWhy7Pd/+mV3+7/veC2Ct6finh8XdKcz75XYQ=
X-Gm-Gg: ASbGnctaZUeicFtk0GbQkLuqtqqA2Yi8CFQGec+CnI0WQCNsDP/jG1/Y2GAre9eQCe+
 BZKjNLuGxntArDHORksTi7Unofcdxwc6DzFv5mSSDYD+5hOuyUfKoqDNItNIE5XdyHD7Rapuhy7
 TKVgtn2ohw703doBLiPNErvpGJS4ZEtWaC7ebyFsgtESFATQzK2u5fZ87e51XMpIOaIYMT3hkrJ
 NamItJOjhfzDRksVnDFJ4WwFPVxsv/ir57Klcn3T/HwC2dR6GseCCHzZ0cxLErB9h/PD9e8/0Pw
 +aWm+h1kNe75P8OKlVz79PjNjPmlGd3Kt6Wn7hf4WnWMcITFBKUQOkejAQfw4b7kNvsLKiOkEs8
 oKs8zunOS85ri
X-Google-Smtp-Source: AGHT+IGjQ1gyNntzN2iQrVia3p09h+QbF/mZqrbbEIF8zSdRw+mmhv0R8876CvtApbAx6w5bFWCDCg==
X-Received: by 2002:a05:6000:401f:b0:38d:d664:67d8 with SMTP id
 ffacd0b85a97d-390ec7c6738mr13564263f8f.11.1741024323384; 
 Mon, 03 Mar 2025 09:52:03 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b73703f83sm169668265e9.13.2025.03.03.09.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 09:52:02 -0800 (PST)
Message-ID: <d97172e5-b8ae-4852-ae2b-b430cca53288@linaro.org>
Date: Mon, 3 Mar 2025 18:52:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 03/11] hw: Add vmapple subdir
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Alexander Graf
 <graf@amazon.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250112210056.16658-1-phil@philjordan.eu>
 <20250112210056.16658-4-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250112210056.16658-4-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 12/1/25 22:00, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> We will introduce a number of devices that are specific to the vmapple
> target machine. To keep them all tidily together, let's put them into
> a single target directory.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   MAINTAINERS             | 7 +++++++
>   hw/Kconfig              | 1 +
>   hw/meson.build          | 1 +
>   hw/vmapple/Kconfig      | 1 +
>   hw/vmapple/meson.build  | 0
>   hw/vmapple/trace-events | 2 ++
>   hw/vmapple/trace.h      | 1 +
>   meson.build             | 1 +
>   8 files changed, 14 insertions(+)
>   create mode 100644 hw/vmapple/Kconfig
>   create mode 100644 hw/vmapple/meson.build
>   create mode 100644 hw/vmapple/trace-events
>   create mode 100644 hw/vmapple/trace.h


> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> new file mode 100644
> index 0000000000..8b13789179
> --- /dev/null
> +++ b/hw/vmapple/Kconfig
> @@ -0,0 +1 @@
> +
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
> new file mode 100644
> index 0000000000..9ccc579048
> --- /dev/null
> +++ b/hw/vmapple/trace-events
> @@ -0,0 +1,2 @@
> +# See docs/devel/tracing.rst for syntax documentation.
> +
> diff --git a/hw/vmapple/trace.h b/hw/vmapple/trace.h
> new file mode 100644
> index 0000000000..572adbefe0
> --- /dev/null
> +++ b/hw/vmapple/trace.h
> @@ -0,0 +1 @@
> +#include "trace/trace-hw_vmapple.h"
> diff --git a/meson.build b/meson.build
> index d06f59095c..812ef33550 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3588,6 +3588,7 @@ if have_system
>       'hw/usb',
>       'hw/vfio',
>       'hw/virtio',
> +    'hw/vmapple',
>       'hw/watchdog',
>       'hw/xen',
>       'hw/gpio',

Alex, Phil, we now mandate a SPDX tag. Due to the license used in
vmapple.c in this patch, are you OK with me squashing here:

-- >8 --
diff --git a/hw/vmapple/trace.h b/hw/vmapple/trace.h
index 572adbefe04..d099d5ecd9e 100644
--- a/hw/vmapple/trace.h
+++ b/hw/vmapple/trace.h
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index 8b137891791..315c06b689c 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -1 +1 @@
-
+# SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
index e69de29bb2d..315c06b689c 100644
--- a/hw/vmapple/meson.build
+++ b/hw/vmapple/meson.build
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
index 9ccc5790487..21125794121 100644
--- a/hw/vmapple/trace-events
+++ b/hw/vmapple/trace-events
@@ -2 +2 @@
-
+# SPDX-License-Identifier: GPL-2.0-or-later
---

?


