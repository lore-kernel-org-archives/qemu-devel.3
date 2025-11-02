Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537B8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 22:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFgY0-0001Ek-An; Sun, 02 Nov 2025 17:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFgXy-0001EK-IS
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:27:38 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFgXp-0005zh-7y
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:27:38 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7aace33b75bso422433b3a.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762122445; x=1762727245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=zuTp1xspAKXFfWyLC4sZ/WuqQxt6o2cj27dUxnO9too=;
 b=Sl8R+U/Li1VZRmlBjqj0Px1Rqd9I9dNjgfKACCua4cjlgx5Ngz5qmyqRbF6663AaUq
 1AMW7zd7rWVl7+ez/tyUxI0XhcOMT8CSxFdX6FYA3evH9X2/i2AUThi+As9U55NM2oxW
 FqRG38AAUO/Kh6vzlPAhVIAguqs80Yf68FJ1zEqqU92rtFgqQgzn+nInLqJ8a7mc1OK9
 4KjlgnBgnyphlsc/yE8TwNtn4+Nvk61EhKSp4pfL85qTR8cddhJiri5K9O60qNM+KHlM
 5NHRrnnb23p7GzIrf/HsFnc2WATu89uUiXfQlpwVtc+lm/B8w1RczPhaeuhNGdN1gHsn
 ZCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762122445; x=1762727245;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuTp1xspAKXFfWyLC4sZ/WuqQxt6o2cj27dUxnO9too=;
 b=CsuzPWqvQohkrq+MUTWgwvtfQLDStnIxZqJyRBnIrS8oq8aDdSOjJGO0vAZnBBBJUU
 9lzzksk32nqXCDPdBvhWgOEZ4+PktpjHdH+oGq24tp13cu2FCVqKw14wZzw6GrtbOe+j
 C8I5BAENrxUVqXHSkEJULHX4DBtmuQFkYW6+2YMZ+ZlvMJpaQQgJ48OnFh5WxF2g4l9Z
 FQJrPV2Sk+eidM56go+H0m82FhmKwKibWZ4e0k5rdm64RPVQZuc41HaSUYDC3DhuWtYF
 6aPYMf+FpYIcXxbjHI+XZGbdh2geS2uNJb3LdwTJeXnuqj+y5SN1SSw4/iswMOeTalEV
 XIyQ==
X-Gm-Message-State: AOJu0YwUOyJm99Bs4AXuxc/zQQMEl/OS/G8DT/jLDxg62W16ZmUCQJZc
 oKAFaPZ2y+F9KiKmghdg5u0+57OjwUg7PzQTQ0LpaQuMiok1Hs+JM9OEGqzRiA==
X-Gm-Gg: ASbGncv2fl2nnRMUmxaVhNntf3Y9gaDd4E2CCdn8eqK4SFBNC5lbQ2FcH/qUkTBsWrz
 Pytfyn3FUWNHcQfU/sSpxGkglRCskWRruDrr7TCFJc7gMPCzhNj4HAS2hva6AlevXJMZo5E6EEz
 rFfGgLLBhs+1Mu5lcQyNGiigp8YFOEA7Z81CAqe0UQZcD6yP+uxNYCjDKzFQWsFDJ7KrO0Yr8dn
 362vgJvSaGuXVtGvRV6tJcIICxpMKH8IPyAspaNzj+49hWcvaMYBOun5Wl80+uVOtNM5snUbZSf
 /+JbvWX44YrF0t+cvw3k5J78St2Impa1i6yg6+2Zwvge6dBT39jjpEa68fLOhLSUnxaXqLKCKxN
 l5vJE18UKLbvXV1ZrKXSLx1DwJBB8KkjCtSCyYZTiPqa/LPgMEuzYNJc76Dd+4490pSOUYBrOUR
 1Yw9/H9+GSfzWLlLbsO47nJa3TWyosVxfBpjOduQCrwV8Fcw96
X-Google-Smtp-Source: AGHT+IERkCMfflza849tBAa6UJsO95pQTfpVlHJzChaF/5rdYYj5CNIwUwWFLz59r3LcoDesK/TB/Q==
X-Received: by 2002:a05:6a20:5483:b0:343:3d3c:4685 with SMTP id
 adf61e73a8af0-348ca75c003mr14123469637.18.1762122445470; 
 Sun, 02 Nov 2025 14:27:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b995a439df3sm3243978a12.2.2025.11.02.14.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 14:27:24 -0800 (PST)
Message-ID: <eed77eb0-175d-4853-81ad-4a5a7390f96c@roeck-us.net>
Date: Sun, 2 Nov 2025 14:27:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
To: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 Jason Wang <jasowang@redhat.com>, sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251101125726.45912-1-soumyajyotisarkar23@gmail.com>
 <07200388-ae9b-4021-afb6-5fd93584d39a@roeck-us.net>
 <5b672b32-cc09-4e9e-8961-efe362991a87@gmx.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <5b672b32-cc09-4e9e-8961-efe362991a87@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/2/25 14:11, Helge Deller wrote:
> Hi Guenter,
> 
> On 11/2/25 18:31, Guenter Roeck wrote:
>> On Sat, Nov 01, 2025 at 06:27:25PM +0530, Soumyajyotii Ssarkar wrote:
>>> From: RemZapCypher <soumyajyotisarkar23@gmail.com>
>>>
>>> Enable the i82596 network chip which is included in the LASI
>>> multi I/O chip. Since LASI has different start addresses on
>>> the various machines, always initialize the LASI components
>>> by their offsets.
>>>
>>> As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Changes since v1:
>>> Added proper Qemu device initialization for LASI
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> Signed-off-by: is missing. Other than that,
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thank you so much for testing the series!
> 
>> Only on 715, though. The LASI Ethernet interface on B160L no longer
>> instantiates for me after the SeaBIOS update to version 19.
> Have you actually used LASI Ethernet with B160L, or just enabled it?

I do basic testing - instantiate and get an IP address. That works
(or, rather, used to work in 10.1) just as good as the 715 emulation,
meaning it gets an IP address and then complains about

Received frame too small, 60 vs. 64 bytes
qemu-system-hppa: Slirp: Failed to send packet, ret: -1

I fix this up locally with

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index c1ff3e6c56..26224645fc 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -522,7 +522,8 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
      }

      /* Received frame smaller than configured "min frame len"? */
-    if (sz < s->config[10]) {
+    /* Note: Add CRC to packet size */
+    if (sz + 4 < s->config[10]) {
          printf("Received frame too small, %zu vs. %u bytes\n",
                 sz, s->config[10]);
          return -1;

With that, my basic LASI network interface test on B160L works with qemu 10.1.

Guenter

> I'm asking, because the current breakage of LASI Ethernet on B160L is intentional.
> LASI ethernet was mostly broken up to now. It was not enabled by default on B160L.
> Now, with Soumyajyotii's work on LASI ethernet and LASI SCSI, the goal is
> to make the LASI chip fully functional including ethernet and SCSI.
> To not break the already existing functional B160L machine for most users,
> I introduced the 715 as testbed and new machine to independently fix LASI.
> The goal is to make the virtual machines ideally 100% like the physical
> machines in the long run, so when we have LASI fully working I plan to bring
> it back to B160L again.
> 
> Helge


