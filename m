Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2CAD1A632
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDeb-0001G1-EI; Fri, 09 Jan 2026 09:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veDeY-0001Er-Hf
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:39:51 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veDeX-0006DM-0m
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:39:50 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso26562005e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 06:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767969587; x=1768574387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Phirb2EQn5JlaXP6PiRo738HQOTnjGZUyN20Gs7XLeM=;
 b=y/Ptxe6iurL1tM7m5G2IIJuaohSR1ipwtIqNKLmxjbdKgbcY+kZN39EHc3r39112p9
 ziYEEZm78ERd9G6i6FHljwrk3PTe9Ky2YC6lMeZP9WnnMJYz78W9JYODmLNylMwWC6xz
 SaZy6JeICu1UZdg7zbCTaMAr4XAcND7y9xVLeYL2VOXa9f+/bOZiQAD8yhpgaD7b1v+R
 C6iNqATEUehob3GzS4pRRe7ywmuey0BBEnxX5q1vdhQfv4GF1nMRglYsPvYE+zcE/XOz
 zSMxQY7NXOV3UV4UjHq5nx/gBPLdve704H/ap/WMjVkSDLPM7cXUjk/fG/fF7Ff7/7wZ
 /F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767969587; x=1768574387;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Phirb2EQn5JlaXP6PiRo738HQOTnjGZUyN20Gs7XLeM=;
 b=JIfuh+AXXkILpcFqFn1KEL7rvTWE3C2jSayN5PkWeqKG4lqMKYsFQJn+F6PPyl1/0D
 6/OMvAgCXpO1s/97YeSUpHwoR7nXH7yA6A4nnf3YDLGK9iJQHRRD0f03U/7V0DfiA7SM
 pswxs5m9WV6R0iFwzgUV12YSU2w5Qc4o88IDW5BabwqiY0FIaoBUZ5uwv7zHbW/8aIcT
 4PCyMb6N3oi0HxymGJpT0yULO5Vc9U+TATPvoE8AxvzJ13YDLHj8EiglIHH1qpQLbrNF
 /8bnLrb6qr092HnDj8kEFNE6DcxaychydhK6WpYieV7EsCPH/r0n1PG3QbbYM/Gm8/8j
 MUUg==
X-Gm-Message-State: AOJu0Ywbp+T6OcWCqgWHaBgt3fo4hlE4hqOakRk50CXlVoxIuy4zh0ZO
 XM2edRLYW2iYGX+b153c4SYJdOcqVD9S5giJCNCZ3FMEZ1TfUm6eYnT2PVsbqhKa5Tc=
X-Gm-Gg: AY/fxX5yBE6mBDZcqO4YzwPNOlLaH6o6ZM0AnFDkm6mr8oInAcrS7F2pYRz57Nc6HBM
 s3YOLok+4F3gC8Q4fWI4O+sgfm0cHrMsjYLHlJuaFvMJ4AGGlUybLqt5HT587+YYBhxy2ydN64D
 B2mKJGBrRjENOBT9rk0JVYW8n9EBnSu6YU8vTKcFyn/0DKVk8DHKxI/Y5jYEyJnK6z4kUrjzwdd
 3PAbR2bZmeT/11capQ5aExRrLE33AHUo39ZrnYZ9Gm0Ba9Mm0PbnSObZCc4OeYhjP7biBUBHygM
 qMeZrkAupsqEg8i3mmnAwLhFRGTAxO3ZNoTtJ009vdecwCZsACbmco9ggC9i77wPtI7V+S++KfP
 CUCuNZAzg8mgdlWwTzfF2E6TzJDVYPxfvC+0uLBmzmq4J+G8XCePH/duYUfTy3jyyqKmoywNdS8
 ApJjhKM62VjHV0iU78JwGg5SFeoRsYvEsvcwNBlrx1IsflVC5P1n2sxg==
X-Google-Smtp-Source: AGHT+IE7GoXb4XudOqtStZlKRPybi5etDNIEnAwvVLD73qy6lEGwIollGfkC6MmLHs1+MH6/tnsXbw==
X-Received: by 2002:a05:600c:1392:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-47d84b34673mr118205565e9.23.1767969587259; 
 Fri, 09 Jan 2026 06:39:47 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df90dsm22626129f8f.20.2026.01.09.06.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 06:39:46 -0800 (PST)
Message-ID: <2dcae9f5-b306-4e32-b9e2-7ae83aafc14a@linaro.org>
Date: Fri, 9 Jan 2026 15:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] system/memory: Rename unaligned load/store API
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, "Michael S. Tsirkin"
 <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org
References: <20260109063504.71576-1-philmd@linaro.org>
 <20260109063504.71576-5-philmd@linaro.org>
 <f36ff8f3-98a5-8f8c-c6c7-069130e5a64c@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f36ff8f3-98a5-8f8c-c6c7-069130e5a64c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 9/1/26 14:48, BALATON Zoltan wrote:
> On Fri, 9 Jan 2026, Philippe Mathieu-Daudé wrote:
>> Rename the API methods using the explicit 'unaligned'
>> description instead of 'he' which stands for 'host
>> endianness'.
> 
> I still think it would be easier to add a comment somewhere (or in 
> documentation) that host endian stands for no swap just use what the 
> host uses (that also explains what be|le will swap relative to) and then 
> not rename any of these. The le|be variants are also based he so do you 
> rename those to lduw_le_unaligned_p too? This gets unwieldy. If you want 
> to get rid of he at any rate then maybe just drop it and make the host 
> endian variants lduw_p without any endian notation but I see no problem 

lduw_p() implicitly uses *guest* endianness... If we remove it first,
then w can have lduw_unaligned_p() become it. Quite some churn rework,
but I'm OK to pay the price if the community is willing to go in this
direction and we eventually get a clearer API.

> keeping he and save the curn. Probably you only want to get rid of 
> target endian or native endian and could leave the rest?
> 
> Regards,
> BALATON Zoltan
> 
>> Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> docs/devel/loads-stores.rst    | 19 +++++++++----------
>> include/qemu/bswap.h           | 34 +++++++++++++++++-----------------
>> include/qemu/ldst_unaligned.h  | 16 ++++++++--------
>> accel/tcg/translator.c         |  6 +++---
>> hw/display/ati_2d.c            |  2 +-
>> hw/display/sm501.c             | 19 +++++++++++--------
>> hw/remote/vfio-user-obj.c      |  4 ++--
>> hw/vmapple/virtio-blk.c        |  2 +-
>> net/checksum.c                 |  6 +++---
>> system/memory.c                |  4 ++--
>> system/physmem.c               |  8 ++++----
>> ui/vnc-enc-tight.c             |  2 +-
>> util/bufferiszero.c            |  6 +++---
>> accel/tcg/ldst_atomicity.c.inc | 10 +++++-----
>> 14 files changed, 70 insertions(+), 68 deletions(-)


