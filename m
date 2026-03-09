Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64768F3C24C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaGo-00058D-LD; Mon, 09 Mar 2026 09:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzaGW-00055C-IU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:03:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzaGT-0007FZ-8D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:03:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so7807555e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773061395; x=1773666195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2sbWLZI3Ewf2CI20TeRLZAU9LjbWKLFrWe3IPLsY3m0=;
 b=Dzxl7/wevtH4zbeEB7XaRCuqtipUogIwqVsJEgU+1qbZVNXsay88hv8+OdLA1kZ3Me
 Pf9ybuQLZkSIu9OVqq5GZtjmNNe98vMgiQLOhmZ29kQv5OPovVn6ZneCRs0qmQOR8rR1
 Ts4DF0zjrDo0Ntqi93YDmxQVEfMbmIubI2fxzI5tFnMWdBDkdNy8s5XdzhtV7KjOybcW
 tVNuG9a7XGEdhlD3P3hX1V+gozng97VQw9jWvqfjAdYPpVOK6r6I3bkPPlv+K4InHkZ9
 JYuV6kTH/QRdVWJq8Q2M3V/8hRoZzmHmOmc2kEaY01jgkmiDBpOQhCITO40bhwj/hzyf
 /kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773061395; x=1773666195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2sbWLZI3Ewf2CI20TeRLZAU9LjbWKLFrWe3IPLsY3m0=;
 b=n2i92QKXa9rjscf0/m3E3ezK6XWRFNVnKh7JX4ZrLmZVnlPnrrreTRN3w2vLsbS3Uo
 cCAgxv9iRf0eXwsWa6NuAUEmO0dhBULB5ojk/3g4mADiUhhLemxHp6mZK3QVTpqi21+C
 BjZY7R4oKlE2PD4r7i3L8Q1EOaRN82JFr0I9KCG0wPrHgAjhTbnDIIUGsAc5mghHI+ZU
 bmeC+elXg3dA0CRo4AIFCLQ/mTBNTBsFySECOWemSeKKQeEi25P+7HCr/xnwJY0JkhUB
 PHcxW+s/N9smszIkTtszjQ+mbkCeKx70YRk0mUJXzBeRJLbF7J1ef/s13bUNk8RApHan
 h8Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA8ItHS+Z5ZJv3UMsC4sTfh3AfKlHYSFTUZwyD0USP/G/1KcF0nvuWLNfMB5sGgAgmLLCNYygpTSWF@nongnu.org
X-Gm-Message-State: AOJu0Yx04AX3rnZu9v6C2BPm2hgusJyjvKgUscFpgSyJYPl63YIjIhR8
 1kuQ4l4Lka42E025wWwBUbFquBdwoJ0gI0C9KSeUa3n7QlZZJKup7VxyphVqQHBe4cM=
X-Gm-Gg: ATEYQzxv5lD9bpML02Gtu0hnFspgMG5U76sz4fc9KEOY0E+CcUoWvc4avkHFO3tiruf
 MG2JGwoZ6Kvy4y+lGQ3/4C5KQBUgFjwN18MrE+wt84xfs4TQCuWWZbR7A9c5yjNeu1pl88p2SUR
 emNzr/n8wnP83FjALEE+pOGT229zKhT++J5EIH50R1bb9fSHtyzJeDSCcHmD1OWzlBlis+nBWKp
 9rDzNi/z3OKfS1P30tewVy4KFF2KM6twVYYSu1/sz3FSUlYCl9OPYuNaWgAAh/EbryxUtHr9+zE
 4tIvbb+EBted91T8XjEYDUpZFVHs37dkgtRvFX/tB7NneDbQH/TkzXCQgsp8Pla4NWz7PjCCPK1
 MXorMJZgqjC62VXQvDiHha46DINcVg5NU88KudNG28S5tw4WPV2uova8+qCh5zgywR+/hHZJs7v
 oQ+ufKS4cUXAuSda7CAYOEC4uGu22lGKS2ucSdt5H+DlSfWnBR1k4W2S6OXrUahmnX9A==
X-Received: by 2002:a05:600c:4e4f:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-4853f7233f7mr21354555e9.14.1773061395277; 
 Mon, 09 Mar 2026 06:03:15 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48531818b5asm83317045e9.3.2026.03.09.06.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 06:03:14 -0700 (PDT)
Message-ID: <4afcf7e0-5ff0-49c3-9f5c-965454737550@linaro.org>
Date: Mon, 9 Mar 2026 14:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/9] ati-vga: Implement HOST_DATA transfers to enable
 X.org text rendering
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
References: <cover.1773020351.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1773020351.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 9/3/26 02:47, BALATON Zoltan wrote:
> Changes from v11:
> - Drop already merged patches in [PULL 00/49] Misc HW patches for 2026-03-08
> Based-on: 20260308223433.25503-1-philmd@linaro.org

This didn't apply on this tag:

Applying: ati-vga: Remove src and dst stride mutation in ati_2d_blt
Applying: ati-vga: Use local variables for register values in ati_2d_blt
Applying: ati-vga: Introduce ATI2DCtx struct for 2D blit context
Patch failed at 0003 ati-vga: Introduce ATI2DCtx struct for 2D blit context
error: patch failed: hw/display/ati_2d.c:43
error: hw/display/ati_2d.c: patch does not apply

But I figured it out (minor checkpatch change).

Series queued, thanks.

> - Fix build without pixman
> 
> Chad Jablonski (9):
>    ati-vga: Remove src and dst stride mutation in ati_2d_blt
>    ati-vga: Use local variables for register values in ati_2d_blt
>    ati-vga: Introduce ATI2DCtx struct for 2D blit context
>    ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
>    ati-vga: Split ati_2d_do_blt from ati_2d_blt
>    ati-vga: Remove ATIVGAState param from ati_2d_do_blt
>    ati-vga: Implement scissor rectangle clipping for 2D operations
>    ati-vga: Implement HOST_DATA register writes
>    ati-vga: Implement HOST_DATA flush to VRAM

