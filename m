Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EB6F3C266
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzb7R-0004Vr-9H; Mon, 09 Mar 2026 09:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzb7N-0004UR-Ez
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:57:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzb7L-0007Jz-M0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:57:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso12747515e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773064674; x=1773669474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XD7AG/7XUD7HGuQc1h1iptBQuiYPSIU4YzmAdPy/m94=;
 b=E/91ZZQV46ovSsksg+KMvP7VTkjHG+JJmtQFK3XHhtFdNSosGm8++f1vwm/k7lCcLC
 dUdB8z8TRbtaJkIHkJvcG5yRzbP8YyCzlxjme+TGecG+w2EdfLHrvIKXkVFWeVHXbJpD
 xDJhSvY8jPaAvFbSUEF5XTcIoCi1JpzCRpL+mUwi6rQhHjssWzrHglFp1ohIUbPxqJYc
 PZv3Nl29jp0f1vjT3HOX9YQGrmN5XV8IVnz3rbgh6B8LWlxicU/oakAkpy7yzCAOhZLg
 zSbUv40dYET7sxX+8H5oUuArF4zzHDICp58scPE+M1PLuN1FODj2hjSZ0CPsCYTWoBBd
 azgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773064674; x=1773669474;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XD7AG/7XUD7HGuQc1h1iptBQuiYPSIU4YzmAdPy/m94=;
 b=H0qI0Aa2AsEsa3a5hbyGN8D/Y2E2yYSK1fwPjmVXntOZhI5DZhc+rETdy81Mo4T2s6
 5MUjs3mIzOS+iqpD3fROA07VN0Jn6pWE6GY2QeFXgd5/gxAlRCntfHMr9nWyk2tZCBZ6
 yhdq7nWGz4iR4ulfAc4ETxjJ3nOlMAKaLtyb6dU7Gjfjc2bC5TL+PNDor0xGqdK1JEJ1
 IUz3w753NxAg+mDRoNOPYwPxCPbNI2/OOq1JTChJUd549yqRAFWA/GX/2siK64IbU5Yt
 EpbpfsqAL13gwdYcKKmFt9KIk7Ipt5/0rHw68/wElnqyteijSnHthDsurZhq6VnmI/5i
 ngkw==
X-Gm-Message-State: AOJu0YxiABug51NYno62gqtftOUYs34nXhKVO0XGeSKYuiRzS/8JQRL3
 AhvKOuUcSrs+uaUjEm6j0AtHgcehwPioknJKQBuiDQRAzbde7nib26lYUtyV6esFavQ=
X-Gm-Gg: ATEYQzwFxfC6aFHWfNvcdrHMJTIZcstkBmW0gcz/FbLmhU40mjJ1hC6mrv/jtdxF4h7
 6sbBVRN2to4CptVH4KtTCIUbBQPJqkQoesX1h0fWYJJzFCt/Pd/gV0YXyeF4tAyzQklrbevTmpC
 6n2sftGkRbcpnuLT6Q+GcJcruz7LZjjdBKiiHu2lQ+Fsi8kqny4eIfWR1G8oUuOlGyzc0vDU+BO
 D8FsFVuSVhzOMIoLGINxA00fS9o49dtMDRxEwQYPuKi200zg0+7eN5aiUV0NcfLppAlkT3tGdZj
 LewyYMjJIoYqKC2cb+G/Syv5pUSupy47HMT/5Sj4z7cd1tdDnYUrRH9rT+o/mgjWdBQyz/K2oe9
 owmcS/RX/jCsZ7uGH+VVn9uBoiLXg6aq2GUJ4YR/4r5jPcjIMbEHbxMD0wtLldeSh42gTZyjJZa
 758k+7MeBtwxmqb8HQVjxHEc0chwQJDVoN6i0di9qKsdZjYRfZRjIVsFU6I3dZPorGgKtXHnksc
 U2FPQsLzg==
X-Received: by 2002:a05:600c:8597:b0:485:33b7:573d with SMTP id
 5b1f17b1804b1-48533b7577fmr88516405e9.1.1773064673759; 
 Mon, 09 Mar 2026 06:57:53 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ff886sm89805135e9.24.2026.03.09.06.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 06:57:53 -0700 (PDT)
Message-ID: <2ad41172-f06b-4854-adf1-bfd59fb10206@linaro.org>
Date: Mon, 9 Mar 2026 14:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/9] ati-vga: Implement HOST_DATA transfers to enable
 X.org text rendering
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>
References: <cover.1773020351.git.balaton@eik.bme.hu>
 <4afcf7e0-5ff0-49c3-9f5c-965454737550@linaro.org>
 <b0f48520-08f6-be11-db53-2b7481c76594@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b0f48520-08f6-be11-db53-2b7481c76594@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 9/3/26 14:13, BALATON Zoltan wrote:
> On Mon, 9 Mar 2026, Philippe Mathieu-Daudé wrote:
>> On 9/3/26 02:47, BALATON Zoltan wrote:
>>> Changes from v11:
>>> - Drop already merged patches in [PULL 00/49] Misc HW patches for 
>>> 2026-03-08
>>> Based-on: 20260308223433.25503-1-philmd@linaro.org
>>
>> This didn't apply on this tag:
>>
>> Applying: ati-vga: Remove src and dst stride mutation in ati_2d_blt
>> Applying: ati-vga: Use local variables for register values in ati_2d_blt
>> Applying: ati-vga: Introduce ATI2DCtx struct for 2D blit context
>> Patch failed at 0003 ati-vga: Introduce ATI2DCtx struct for 2D blit 
>> context
>> error: patch failed: hw/display/ati_2d.c:43
>> error: hw/display/ati_2d.c: patch does not apply
>>
>> But I figured it out (minor checkpatch change).
> 
> Checkpatch did not complain to me before but there seem to have been a 
> white space change in you pull request. I noticed that now and sent v13 
> for that patch but looks like you were faster. Thanks a lot again for 
> your help.

The errors were:

46/57 Checking commit 7ebf5e5ac2ad (ati-vga: Consolidate dirty region 
tracking in ati_2d_blt)
ERROR: "foo * bar" should be "foo *bar"
#38: FILE: hw/display/ati_2d.c:59:
+                                s->regs.dst_offset + dst_y * 
surface_stride(ds),

48/57 Checking commit 360cf823d841 (ati-vga: Use local variables for 
register values in ati_2d_blt)
ERROR: suspect code indent for conditional statements (8, 8)
#196: FILE: hw/display/ati_2d.c:212:
+        if (!use_pixman_fill ||
[...]
          {

I marked the first one as spurious, and am going to ignore the
second (some refactor could avoid the #ifdef'ry, but no time for
that change before the soft-freeze).

> 
>> Series queued, thanks.
>>
>>> - Fix build without pixman
>>>
>>> Chad Jablonski (9):
>>>    ati-vga: Remove src and dst stride mutation in ati_2d_blt
>>>    ati-vga: Use local variables for register values in ati_2d_blt
>>>    ati-vga: Introduce ATI2DCtx struct for 2D blit context
>>>    ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
>>>    ati-vga: Split ati_2d_do_blt from ati_2d_blt
>>>    ati-vga: Remove ATIVGAState param from ati_2d_do_blt
>>>    ati-vga: Implement scissor rectangle clipping for 2D operations
>>>    ati-vga: Implement HOST_DATA register writes
>>>    ati-vga: Implement HOST_DATA flush to VRAM
> 
> There was the other two patch series to fix guest_hwcursor will you 
> queue that too?

Yep!


