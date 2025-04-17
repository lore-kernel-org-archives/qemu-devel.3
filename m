Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE84EC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SJl-0005Wd-LH; Thu, 17 Apr 2025 12:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SJi-0005W3-20
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:42:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SJf-0001mr-Sh
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:42:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so7900645e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744908136; x=1745512936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xAGVG2cs8Y16eR/ev25u9kwLxmJoGJy//385ktuSMwA=;
 b=myowZ9dyhXRTjBjd6OrD1LTDpAvG8hwYSzi1RHZvkIKsnGZUe2yiZBA+x6L8oQXIQX
 AwX6K8w3az+RKV90E5qxPPQoPLdtIaRWDSs55492gGGJiiLIc7BPcYVr2XOaaS+hbv4g
 4Lw5p6hSCdlOMcpeQfGyyDUAr3WPnoq6UYAG2CXn3/G4/Q/sIpH7AMIGy8Hs9oIDfuJW
 b+w0RtkncC23OIugNpvDov3GmHdq2q6154DpGZpMnhem910Xqvx03GfuAM+M2Fg9JZPB
 aom0zAWMTZPvCdyU9KliNbNDYrNCnK418nqfArk6xprZN1JuLzW+OffKiYzaj56A45d7
 VxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744908136; x=1745512936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xAGVG2cs8Y16eR/ev25u9kwLxmJoGJy//385ktuSMwA=;
 b=P8bLIG1yVorxxGfPeqArn9UceiGNI0VCG5ZNjOiJCIpUGyBHa6fj+0c/EAGwHNsGL8
 dmU0tQ5zqy9eHo/5Uzf1U9IMTN1xXpzzHD1PAdXmoybu/qqO1FxGQTSvTzSZyLEpwyZ4
 xy7vmJ2INHgi+/70ieXUi3YsQQpNWUwDyBrBNpWLkeAx670Dkd3bJ8FZ18SJyHpgRNUW
 3Qna58RuzU9Q0fOwpxkXFXN0TzNZnDOHGUGtwODH8nxBC4UhD8wy5lucb7OHyYWzmSQ0
 5Q5Mxp50hJ9ydis2lrBCX8GJDsI9XnqzjUDsmWxTwWyiJ0kkhdYt2+KSlfOzFHyGRkBd
 An9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVvd7Jo7wfQNLVxiIzcXc8dxTaI9ncX+uSVMvaVJQ7VcjXPfTMaIznvQc1cetMvRbirjWbCS83UESi@nongnu.org
X-Gm-Message-State: AOJu0YyfQe4h79TLuHDujzF+UgKUCuvpdBSJgElcBAmWxU8gIw50iB2d
 WqkYMKCs98ZJAWi6GYQCA+STZHyoL5pnuLQQTw84eJ9ihsp/wkm+8T99F1kfFTg=
X-Gm-Gg: ASbGncuQhf/mSqiEgPuvgPlv1HWc7uochoCRgxK61VNMOsxYSzVJneQk04oWT8AmbLt
 TetToBsciuVw05VDV+EPQFfbJrEe/w9pMcirjDKRvOZuwT4pHNklltKPQp6OxAtsiaeZLupsl2y
 PMXmbWmPPszRVtb4/S8oxNWYX928b50GKSwOzL5W1StcOP/BWsq72cScoeWzg+XxOlEBLFmSQ4d
 ipJV2f5nstsGAYPm5XUfryfI+YAbHwfnAO7mW23CdcTX0utFeonAFMHo+GfLfKt+KrdZZAB/8uZ
 7aR+z7fW15w3IuR2yN95KMdsspjPWaGSswKmt0ylP15AoQzwtqAn33TPXdgTzam0/WL5eif0r+S
 1dnGIAx1r
X-Google-Smtp-Source: AGHT+IEcXPQ+XSnuor5Qz+1T7qrMqoqzNuWJb/Cq0rNQq+yMHCtPnrcLCra3F81vzI8KXcnckbaJOQ==
X-Received: by 2002:a05:600c:350e:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-4405f2fae8fmr71045645e9.10.1744908136564; 
 Thu, 17 Apr 2025 09:42:16 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433429sm114754f8f.37.2025.04.17.09.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 09:42:16 -0700 (PDT)
Message-ID: <a71d784e-f016-479f-a34d-f9c19d9d10d6@linaro.org>
Date: Thu, 17 Apr 2025 18:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 17/19] accel: Move target-agnostic code from
 accel-target.c -> accel-common.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-18-philmd@linaro.org>
 <0b4376ee-504b-4096-a590-8a509ec7894d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0b4376ee-504b-4096-a590-8a509ec7894d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 4/4/25 18:59, Pierrick Bouvier wrote:
> On 4/3/25 16:49, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/accel-common.c | 142 +++++++++++++++++++++++++++++++++++++++++++
>>   accel/accel-target.c | 129 ---------------------------------------
>>   accel/meson.build    |   1 +
>>   3 files changed, 143 insertions(+), 129 deletions(-)
>>   create mode 100644 accel/accel-common.c


> It seems that only accel_cpu_type is left in accel-target.c after that.
> Couldn't we move that to TargetInfo, so the whole accel-target.c file 
> can become common instead?

IIUC "accel/accel-cpu-target.h" defines the AccelCPUClass QOM
CLASS_CHECKERS macros based on CPU_RESOLVING_TYPE.

> If there is something I missed, I'm ok with the current change.

Thanks.

> I just feel the last 3 commits, and this one, are a bit disconnected 
> from the series.

OK, will do.


