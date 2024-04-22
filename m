Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB0EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryt46-0007Z9-54; Mon, 22 Apr 2024 08:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryt3m-0007WL-GU
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:46:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryt3h-0005Q1-0z
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:46:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41a1d2a7b81so7119765e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713789966; x=1714394766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=39Acx84dTQ3hN2yMfKWcH9znaBkPeHgCHhH+12hyjQ8=;
 b=Oh457p1C62GQMS0N+Z4dF7Es3EdFOAotZO5sYLavO82PhDsoqo798j3C86oBFUhNC1
 v2MVhfwGl1s1nnc+W4QAj/0VrYO8cSdohYKer3lvDgBKoVGruUemJS88lrP2lF5B3ama
 XWTqJ//3wvN5EgwsoWVd5Ik7fDIjmvyF1Yu8NQfPOSKh2p0z7a8orUY9UNN7U02MDCcz
 s98XefnxYaHM2wKJZcyan9odOqLsE5g0E4JDsXljTi2AnCZ62VdDGPeJ/G7hIXwcMVkH
 jypuhJ+oD8r9WJUmyl85dVWK5euc8xXLFKZEzEiklQLpWekJmNyyWuBfrPCTwXlWo2/a
 3Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713789966; x=1714394766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=39Acx84dTQ3hN2yMfKWcH9znaBkPeHgCHhH+12hyjQ8=;
 b=tVvRUCAhvchZUYmATmc2xIsyk/6A231smYM6UFCXMkI0u5hyNdRT3sgBvHceFf2q6R
 drn0te7j3CVJ6OPU+hUwnXgKFzBCOb0saDoTEEC0bCr00a0lmEWYiQD4Iym4n3S+9JYx
 u1RZ7fGlY6ZVyRhFELytnaG3c97KfN6AaocozbuzgvUXBGWRtAQDE/BLVeglb6NSLlbz
 A//WjBBT5SYOxmEkOJ4dOfIzhGGJoG3TSg7CPv/dyh3f+JkabEFbFITtenaFshvoR5Iy
 Rj93KeFVq2w7vHhw6uBuZa7ZKf5NpQhkso7/c0PW+GAjsSk8eQMTG/L7K4QGr7mXGbjg
 IyZg==
X-Gm-Message-State: AOJu0YzDsVDVWNC8t9/Lf0nUBCzWu3xrb+GhVOBTJdQ+Dd5/9nOFxcr6
 8FUHMs18SZ46PB5QzijB0gTTG196rOWWRGePlb1t4MTv3t+jdXNHfKO8XmtxAd4=
X-Google-Smtp-Source: AGHT+IF6ekSDYQxE6y/nkKThKaQm3zn/4i7UQcySSVjovWfJ/Lif57cfa79EBDVO51EtY1b9jhV+aw==
X-Received: by 2002:a05:600c:1e15:b0:41a:7c1d:3326 with SMTP id
 ay21-20020a05600c1e1500b0041a7c1d3326mr1187471wmb.8.1713789966552; 
 Mon, 22 Apr 2024 05:46:06 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 bd25-20020a05600c1f1900b00419f7d6879dsm8198662wmb.8.2024.04.22.05.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 05:46:05 -0700 (PDT)
Message-ID: <7492ef2d-1ea1-472d-baf3-ad8236fcf62a@linaro.org>
Date: Mon, 22 Apr 2024 14:46:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.0 3/3] hw/net/xilinx_ethlite: Replace tswap32()
 by be32_to_cpu()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alistair Francis <alistair@alistair23.me>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Wang
 <jasowang@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Greg Kurz <groug@kaod.org>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org
References: <20221213125218.39868-1-philmd@linaro.org>
 <20221213125218.39868-4-philmd@linaro.org>
 <CAFEAcA-iouFJgu_2cG2TapxYVr-_ZK1Uuwa4mqSL5zNKg6Jq+Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-iouFJgu_2cG2TapxYVr-_ZK1Uuwa4mqSL5zNKg6Jq+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/12/22 14:53, Peter Maydell wrote:
> On Tue, 13 Dec 2022 at 12:52, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> This partly revert commit d48751ed4f ("xilinx-ethlite:
>> Simplify byteswapping to/from brams") which states the
>> packet data is stored in big-endian.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> @@ -102,8 +102,8 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>>               D(qemu_log("%s " TARGET_FMT_plx "=%x\n", __func__, addr * 4, r));
>>               break;
>>
>> -        default:
>> -            r = tswap32(s->regs[addr]);
>> +        default: /* Packet data */
>> +            r = be32_to_cpu(s->regs[addr]);
>>               break;
>>       }
>>       return r;
>> @@ -160,8 +160,8 @@ eth_write(void *opaque, hwaddr addr,
>>               s->regs[addr] = value;
>>               break;
>>
>> -        default:
>> -            s->regs[addr] = tswap32(value);
>> +        default: /* Packet data */
>> +            s->regs[addr] = cpu_to_be32(value);
>>               break;
>>       }
>>   }
> 
> This is a change of behaviour for this device in the
> qemu-system-microblazeel petalogix-s3adsp1800 board, because
> previously on that system the bytes of the rx buffer would
> appear in the registers in little-endian order and now they
> will appear in big-endian order.

Maybe to simplify we could choose to only model the Big
Endian variant of this device?

-- >8 --
@@ -169,7 +169,7 @@ eth_write(void *opaque, hwaddr addr,
  static const MemoryRegionOps eth_ops = {
      .read = eth_read,
      .write = eth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
      .valid = {
          .min_access_size = 4,
          .max_access_size = 4
---

