Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83F9D29C32
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 17:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhsxD-00048e-9Z; Mon, 19 Jan 2026 12:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhsxB-00048K-21
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:22:13 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhsx8-0007As-9k
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:22:12 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4327778df7fso2847184f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768843328; x=1769448128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/wgF+H9GfM+z8bC8gU+mH2o00CJyhPHg4kxrg6q5FE=;
 b=X564E1My25C4crAsUD/eKnTU+Jqzo3sDCYXPsBC/bMsVDIMBVVtC/g7iLjd9XJfq6J
 UtG6tn/a5e0j2Lm41eEt7c7oMGN8fHbTODebCQenGYyiQ2MxfWWhg8KQyGAt7ZlUoBZw
 rmObHue84A7l9wpT21oXks4/WhVPnaF6nRbud+oau+zFis7O7P0cf+EcTaRjLexMFceo
 pm0nVf/B7A7Ur4B8gKa7R3zBrqpQnjkq6kvzX4asOwBMGztaHWegtBsQo7XoIpD5zx8R
 Lyi5a20ayt8f0D7pWI2ZVyaU3RTAUTevLmLfQgrwYMr5lbb3j2C4WwKhDUEsDs8NwZVY
 Es+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768843328; x=1769448128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/wgF+H9GfM+z8bC8gU+mH2o00CJyhPHg4kxrg6q5FE=;
 b=Wlc11oK+ONMJg06JkRt6JoaXNmCYlOyYK5sh3SFlTfOOVHHmyjZFKV/c9O8O/BWzIM
 zpDA4M8MgxbMO25QVejuyeY9AeXKgzthcYxgHHUGDu/2s4CLTU+cdNKU2RZ0vbtOrGkr
 LZFWrp4+/c3XlnUz46HFtsjNzRrQ6hUZNF2I5PO4PWI+rEEhuceIQPUN8cIwxtfxigpf
 LkxhPn0zSPxb8SnzfjkeZlGLONfgqZAMyH4Tx3XxnNP97CvT529hPgFYW8KZescYbsZh
 SpG3/qeSp1jXZF/at+FOS0BZ9NlO3zarjq1dsUTWZ8RYq1weCTVUoX+q1Mt1xhpkWt7s
 PFtQ==
X-Gm-Message-State: AOJu0YyHTcbNBdkeOYlWmrUGh+a++gu1VQlCCH/WrNpEEiJZvwYVx5fD
 9GBdyQHEQQcnVWDZnrpDq5R2vV3upIPBXVF/0AfB0oAJuNyPZ19D6Es8IesACV5dzo4=
X-Gm-Gg: AZuq6aI9FMA2Gz6tm2Wb73FTi+AJRcSJjmWdjjo7oVr9JfDRb0/getd3lSWoZZEovGX
 JUOSfh0HzG6p/SnpCMlaadI+hq6Ka7at7QGxbd4sqrvei41H8C28LTN/+CqzXEWXQsze0P9e3Ne
 V5lEpEDmBa6lgBd7QheAsC3dEHqCMuSDKaH3N6xJWU2JmTv/e4O3cgOFGg0gQkoSZVVlrKD/5II
 mPPzfjUARwuRjC+Esh4YpOHwB3Mhy6Ht1hnJ6MnpXo/pXWzlLinn2okDrPWGelHVcKHbcz4r7Ma
 aq9Imc70Dq15Wd+9flGKvtwNxPOADX6QfZ04hZmRSiA88EsVYddmMQKRwaC8TD33GmIKursJmLK
 zNu2+R38WUYl+hnWHoKixDHEWXoS4GsNyNnYN1q2440i6NAZi4gMvTZJp6EYPuUj/7BVHMv2Met
 rXKUJVLwht1zIMQr/5hP/Q0k5MCGIW6C2CXbiEN0wxweFR46Dec6X7oQ==
X-Received: by 2002:a05:6000:22c4:b0:431:9f1:e4c7 with SMTP id
 ffacd0b85a97d-4356a02c777mr14382497f8f.21.1768843328398; 
 Mon, 19 Jan 2026 09:22:08 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996dad0sm24251241f8f.27.2026.01.19.09.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 09:22:07 -0800 (PST)
Message-ID: <ad975568-9ff4-420f-9b98-725d0c3e7c64@linaro.org>
Date: Mon, 19 Jan 2026 18:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v9 2/8] hw/arm/smmuv3-common: Define STE/CD fields via
 registerfields
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
 <20260119161112.3841386-3-tangtao1634@phytium.com.cn>
 <fa73ef10-4a1e-486d-9d80-550c91eef11f@linaro.org>
 <0e71fdee-3569-4f83-afc8-46e0cbe565d0@phytium.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0e71fdee-3569-4f83-afc8-46e0cbe565d0@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/1/26 17:51, Tao Tang wrote:
> Hi Philippe,
> 
> On 2026/1/20 00:38, Philippe Mathieu-Daudé wrote:
>> On 19/1/26 17:11, Tao Tang wrote:
>>> Switch STE/CD bitfield definitions and accessors to the
>>> 'registerfields.h' REG/FIELD API.
>>>
>>> FOLLOW-UP: Fix CTXPTR_HI/S2TTB_HI/TTB0_HI/TTB1_HI high bits width
>>> (should be 24 bits, not 16).
>>
>> Right, but ...
>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>   include/hw/arm/smmuv3-common.h | 169 +++++++++++++++++++++++----------
>>>   1 file changed, 120 insertions(+), 49 deletions(-)
>>
>>
>>> -#define STE_VALID(x) extract32((x)->word[0], 0, 1)
>>> +REG32(STE_0, 0)
>>> +    FIELD(STE_0, VALID, 0, 1)
>>> +    FIELD(STE_0, CONFIG, 1, 3)
>>> +    FIELD(STE_0, S1FMT, 4, 2)
>>> +    FIELD(STE_0, CTXPTR_LO, 6, 26)
>>> +REG32(STE_1, 4)
>>> +    FIELD(STE_1, CTXPTR_HI, 0, 16)
>>
>> ... not followed up?
> 
> 
> Sorry, there's a typo here. What I was thinking at the time was that I 
> would submit a separate patch follow this series.

I squashed:

--  >8 --
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 6b48b5414dd..db30331441a 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -43,7 +43,7 @@ REG32(STE_0, 0)
      FIELD(STE_0, S1FMT, 4, 2)
      FIELD(STE_0, CTXPTR_LO, 6, 26)
  REG32(STE_1, 4)
-    FIELD(STE_1, CTXPTR_HI, 0, 16)
+    FIELD(STE_1, CTXPTR_HI, 0, 24)
      FIELD(STE_1, S1CDMAX, 27, 5)
  REG32(STE_2, 8)
      FIELD(STE_2, S1STALLD, 27, 1)
(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? y
@@ -66,7 +66,7 @@ REG32(STE_5, 20)
  REG32(STE_6, 24)
      FIELD(STE_6, S2TTB_LO, 4, 28)
  REG32(STE_7, 28)
-    FIELD(STE_7, S2TTB_HI, 0, 16)
+    FIELD(STE_7, S2TTB_HI, 0, 24)

---

Is that OK with you? Do TTB0_HI/TTB1_HI need update too?

> 
> Do you need me to resend this series?

Hopefully no :)

Regards,

Phil.

