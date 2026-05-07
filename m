Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE28CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKysS-0004D7-08; Thu, 07 May 2026 09:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKysN-0004Cn-7o
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:34:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKysL-0001Sn-5B
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:34:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso6160735e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778160887; x=1778765687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uLCQ00C6JYUtQfArcbwuQKiLB78KUIO7od2YMNVbIvA=;
 b=Rt6sjkdWvTppURTdMqQfah6DddrcOF0ljqVylpN+I7BSrxe7RvdDQIZi7wvdTBN0Sa
 A7v3bFDBSYBoHeILijxOQ0nsfGJ4kUkyvDpRqT55cT+lxWS1dLNfPjbr9+7OSHygu2KT
 bQTKDO31gYISKrDj1qKztIM5zTR9RHwGchma/FAJdzL5F26Ut0yc0iASc8zV3iEX7Fqd
 cVAt0IF00QM6FTBC3eQCvQWDB/4vi+QPnRqnc3F9AUQN2/iLiBue5+sJIMHn/q0RzEB0
 ZUxwS4Sie++4MPKmDa7QGk0fIHeR8FaDw73JfPtBwOGHvnA4LOrpPjFyAWYk0z3WWc39
 rOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778160887; x=1778765687;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uLCQ00C6JYUtQfArcbwuQKiLB78KUIO7od2YMNVbIvA=;
 b=Qm0m/taqlbRprsBYwnEe4FYGndhr1GA+wGDLZcAwgCutQa1iYMOQkP1bvZvUw32/Pg
 /UWpXn7LNUFHNPqbPL0izZynfusy29ttU0IOuZsTXF3W2EDVRXA3n4HUGxkjqNa13dx/
 L1qaeJS337SElR1qHmMBCouMymX3Jx2qhjRrCJZBfuj0KeiMPk1tVejazZtFatgTzxLn
 9aiEuoFL+NXqCk9e3vVNwth/UCs/O1bbxhalCvhzfV1SbVIPix/ZVtJKVJ/O2VXJIl6a
 wVPeI5xyU3v5xsag8BpZfdl2CUoPkzw04EJTme2FgXhNRZvQvagBaiyc8bQbXNeYPVtH
 tXRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wjgYuW8J4E7Aj6qp35lQPE9taGF7HrG4TK44eBv8fRNd6kaUdBAJ20rC+TtvrYHtenPdE6wdM89B4@nongnu.org
X-Gm-Message-State: AOJu0YwaCwuAwYB6fS2SUpcgyPAIVrF0k+8/CEnNIhRHWcIQrlCOv+3B
 FSu/MgDT7jmVoY2OzH0aWUrZy+Y/MdPFoYCDaglTToee240MN3N7QoEqdgX3z7SdFi0=
X-Gm-Gg: AeBDieu6iOMWGO721vQxBSFJ5njVBetC4GDoccN+3BWA3OiMtImNhOMOK2r4fen1cx6
 7Y+lKL3V742WASzBlpphFzoW3tQNIf787B+Ke+5MMQYAOGlUq83edw2iGjsFy8qpkmt462zKrFz
 BpZuxYFZxr35YsjSjUqTkCuXHOVmR4qpfNqC4yYjUuIgGSN8z5uY4VC7jlIGNVmQbKArc0br5nU
 zgNQDMiha7QWqd56m6vAHcN2/jNR8qbjp6IiDxuFoimz6JvaeT0yOm9+QnnN8mmQ+FH07rGbb44
 tjdCjkr72nYnktvBteC9/hAAz505Fp6x+htym4XxINM6FB+vRRPUpGBdmuGsno0jztZO7c/p2TS
 AsdPW6MjZ+B6ZDbV3AOGurMWz02jENvZhBvCGVyN2i5aiW2h+XZ1MpppucpsgP89eE4F+VypTRn
 rCdS8c8SJPpsegh1wazLYraYlNQhrw6lKkTWATenYPP/i9RmLTTlZwHxp+9o6x2xYVfBLY4eyOM
 ALt
X-Received: by 2002:a05:600c:4f53:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-48e51f44577mr128236885e9.22.1778160887226; 
 Thu, 07 May 2026 06:34:47 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53891163sm137774145e9.2.2026.05.07.06.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 06:34:46 -0700 (PDT)
Message-ID: <e454a3c4-5d9c-4482-9f99-553f799a6d39@linaro.org>
Date: Thu, 7 May 2026 15:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ati-vga: fix ati_set_dirty address calculation
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>, qemu-stable@nongnu.org
References: <20260506153920.C6B27596978@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260506153920.C6B27596978@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 6/5/26 17:39, BALATON Zoltan wrote:
> From: Chad Jablonski <chad@jablonski.xyz>
> 
> This fixes three bugs with the ati_set_dirty address calculation.
> 
> First, vbe_start_addr is a word offset. All other values in the
> calculation are byte offsets. It must be converted to bytes.
> 
> Second, when setting the dirty region with memory_region_set_dirty
> the vbe_start_addr is used to calculate the start of the dirty region.
> This is a problem because the vbe_start_addr is the offset at which scan out
> begins. This puts it in the visible screen coordinate system. The dirty
> region however is in the virtual screen coordinate system. This can cause both
> overmarking and missed updates. This is removed from the calculation.
> 
> Third, when the start address of a blit is outside of the bounds check
> the entire blit is missed and not set to dirty. This happens even if the
> blit does partially overlap with the visible screen. The fix here is to
> find the intersection of the visible screen and the blit and mark only
> that region as dirty.
> 
> This does not attempt to apply clipping to the blit. So there will be
> overmarking in some cases.
> 
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> [balaton: drop excess parenthesis, use offsets instead of pointers]
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Queued, thanks.

