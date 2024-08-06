Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECC2C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 07:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbEe9-0001jY-Gf; Tue, 06 Aug 2024 03:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEe8-0001hs-37
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:30:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEe6-00042M-4F
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:30:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso2011245e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722929411; x=1723534211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZnUmBX+GDk8OwHXl+k75e97JhXqBQqgMo1hpYTnOb6Q=;
 b=SmzTmHTqGzc+zqEbz28sVulev59p6ZLWDFJF077ppyA7o4OJdT66L9+Z4wvPEhsGxb
 yvtiOWnVdR81v21TuLnSXy5eRy6HM8Jtk4QWZYqzMyOApd0cSVPpGojH2zQ0OddSY5lU
 Kf8dGal+QL7ZIL+enjCh/B1qp6sheNYh4t6YJ8OLjn9UQ4gmF+HqnMNO0cjar0MGHUAu
 8a2/NGbuAjk4JDMjRZiXRiV4Fy/bkIPUQAVYzDosUMI/pwO+9OZipKxouo0FimAxx3PD
 fukXldY6GKSgBg5ScCVWh2P1rJp1BsLzjFGzc5889jGZ3hBBd5/ffAE+zaXz/h2I3LXp
 VgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722929411; x=1723534211;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnUmBX+GDk8OwHXl+k75e97JhXqBQqgMo1hpYTnOb6Q=;
 b=wU/CU6JKKac72mGq6cjX6bIQ1fFM/Lo0Yqmeo1A2ytXV9xpPwmwImUwWekwK4RQ7VE
 FCbZPYV3daeXl36d+IawadFMHZFjyoBrog1JNtHdw0YllwcLN9PNIweud0u/+CyL9iEU
 NGnNseiCmjDDcvuuwuw1oI2Km8mcHccXnKbmVYdEkKGKpa/de6G76LP2gPLoD50UzO75
 5xygjUw/br0RflYmWt1xGZ8Bd3h7lH7xql7o5uELfFV3ll1Cm7a0QkceT68nJ4SKTWB/
 6insWsbvEbFUGh/YcYX0hXMnTT2V9nUBqzXZj9z+JP4f4TquzrR2y27rAlfk7RtWMuUo
 vECw==
X-Gm-Message-State: AOJu0YyQPD8+h/RDc6NIdH4pzW+iRhz5gNotnZOJv/oewmjbcbKPuT0/
 UohHRYPU0QPA1CokOia4WpIXe3Jr8FXxz5yOmzvBVw9d+//nuSpXWaqYmkiVlri8Vq5obLSydQS
 z
X-Google-Smtp-Source: AGHT+IGtS8u61V0epICoQEXEItArGaS0GsAdpvAfl4VSPD7iAZgFzDiovxMrzku4voZXVfV5Agy6TA==
X-Received: by 2002:a05:600c:4fc9:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-428e6b08fc5mr92799435e9.13.1722929411133; 
 Tue, 06 Aug 2024 00:30:11 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e4073f7bsm188940965e9.18.2024.08.06.00.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 00:30:10 -0700 (PDT)
Message-ID: <7d9e81cc-7609-4073-adb3-325d7580afe9@linaro.org>
Date: Tue, 6 Aug 2024 09:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 0/5] hw/sd: SDcard & SDHCI fixes
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org
References: <20240730092138.32443-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730092138.32443-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 30/7/24 11:21, Philippe Mathieu-Daudé wrote:
> 3 fixes (2 fuzzed).
> 
> Philippe Mathieu-Daudé (5):
>    hw/sd/sdcard: Explicit dummy byte value
>    hw/sd/sdcard: Do not abort when reading DAT lines on invalid cmd state
>    hw/sd/sdhci: Reset @data_count index on invalid ADMA transfers

Patches #1-3 queued (removing 'static' in patch #1).


