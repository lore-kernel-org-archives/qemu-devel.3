Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7178D0EE18
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0w3-0006gH-Cj; Tue, 25 Nov 2025 16:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0vb-0006Kl-V3
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:50:28 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0vZ-0005bc-7f
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:50:27 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-42b427cda88so4112401f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107424; x=1764712224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UC7sfSHb4yzl/h/C3a4s5MrLYGM73JIMWnz1nW+xFU0=;
 b=YWyBEgAoHuciUtwoG3eKs0iBMF9nu/rMaHwDIdTj3Wc0lpjRdmBkJctfbBDCmj+2U2
 VJEuT5nTj//rTkPKsKOHCGxlKDDxXEXNw4Gl7wN4fVYFPrNlmULvIIi2dvu9YWfCaEIQ
 ZCqy+X9iWEs1OE5SDJcLLMRFd0mc4oIJPilRTSqIRbNCNh53e/O1JTGjHRMMESN3CZGG
 lRuJVl8SXZ+d9oDXJMhzlzHKHE/tM0Kevg5SCnq7ciI0oFXYtKCwGzEMnSAKWAyNstfJ
 fk4RW1SbjvTV4mlfZYB3uU1LSNdgTMVgRaLR/GhzYTKW2A9JCm6BNyATe7YZrnls9P2r
 FhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107424; x=1764712224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UC7sfSHb4yzl/h/C3a4s5MrLYGM73JIMWnz1nW+xFU0=;
 b=lOOU6ktrjAl8XK4ZbjChx19ttKacLpCG2FnfFzEkWbBGtz2I4fZ3ZDjTNB5R15rbiZ
 ILNFdZY7dFH9Z+t0eNX4PD8KbsICcsXkh1aF4yG2puAfMRjqEIukuEm4/mb7Y6I+UiWO
 F/HphHqHtLznLnRiJUk0VEcscQ8TmNrpA4WafLdwWXa5B7g7tq8ueGKs2JVw/8qFufg1
 3B8TD4Z85wpUbC1huiZxlfFxwTLzmwNdtrgpcfI/gpz/6Ks2k11Cso59RNijSyb2XwR+
 lcu3N18PLIdJdjZ1gj9MV2D6lKU6TlIf3VS+gDT9EnXqgRwefTYncjjpHo9EAccHqu+R
 15Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg98ABn1/4jVr9BmRL9i6hr9Q7QrvbodqSLx7Z/HWPCKyG+6V9SmiZjfr5k8xoO5SlmYrL+j1IYlBL@nongnu.org
X-Gm-Message-State: AOJu0YwMgwK2LURAo8sZjkq/oD14hTJXTmABC6Aq0eTPR9LilLhJc/Ul
 SjOpPsqCrOf4jrrm8ImI696EGN/A/2bOlcJukmTVn3cpmo3Y9ug7vKQgsW1ReJOxaeQ=
X-Gm-Gg: ASbGncvVn21gfmEJLrQ/CgivhEViuB+tcFmh5EgBaiti7Y6Dk+mPIF+XpSiWfwboTid
 hFe+Cx64gu6dWwc139p98EX8lUy0wataIuuofwrTqbzC6Pa82dbNpFjqHPgB5EDiaGUaXmRPK8o
 kjiphYvYykmoE2+30jnxxLxPByrRsXXeP7J5B5UVnNV5kbvbSrbhF1MAQ7n0WgMWCKceSO9GIUQ
 bVQ9ho3vPv2Ifd0pJRgI1mUJPKjOgNpl6yyrrDE6FsIQ2IHJ+Y8xkGWXymVCw10+/wbzngbYaZv
 ZKdDTccim0MiD72nBKm6HPWBNZ5PI/ixqalx8TwRU1jG/tdIwJ5RTI0OZZg5kTXMDvbkVT1WuZy
 czxJgB/YWQrDjzGSA1bvX1MHCm10BEyPY1GnBkP9CfifTl+HEFvZlcu68rCfpjNbt8rtHbCdsSx
 thHKmPp5d3MtVe4deVFAVZ8ZBKPHc+yipK+9G7ZGJJAuIe5NIbz+WGtLPj5noAcfy4
X-Google-Smtp-Source: AGHT+IGnrRT3QMmVDHHx7fmnCZSHNobtlBSSxYFTY+GYT8ha79Eh3M2RrFrUQg6xd8pxFNpL8iITNA==
X-Received: by 2002:a05:6000:2411:b0:42b:3131:542f with SMTP id
 ffacd0b85a97d-42cc1cbcfd6mr19781643f8f.24.1764107423748; 
 Tue, 25 Nov 2025 13:50:23 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363b0sm37040969f8f.13.2025.11.25.13.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 13:50:23 -0800 (PST)
Message-ID: <2aa92f1f-7d01-44ab-b29b-a3f22ad631af@linaro.org>
Date: Tue, 25 Nov 2025 22:50:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: Make msix_init take a uint32_t for nentries
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20251107131044.1321637-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107131044.1321637-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

On 7/11/25 14:10, Peter Maydell wrote:
> msix_init() and msix_init_exclusive_bar() take an "unsigned short"
> argument for the number of MSI-X vectors to try to use.  This is big
> enough for the maximum permitted number of vectors, which is 2048.
> Unfortunately, we have several devices (most notably virtio) which
> allow the user to specify the desired number of vectors, and which
> use uint32_t properties for this.  If the user sets the property to a
> value that is too big for a uint16_t, the value will be truncated
> when it is passed to msix_init(), and msix_init() may then return
> success if the truncated value is a valid one.
> 
> The resulting mismatch between the number of vectors the msix code
> thinks the device has and the number of vectors the device itself
> thinks it has can cause assertions, such as the one in issue 2631,
> where "-device virtio-mouse-pci,vectors=19923041" is interpreted by
> msix as "97 vectors" and by the virtio-pci layer as "19923041
> vectors"; a guest attempt to access vector 97 thus passes the
> virtio-pci bounds checking and hits an essertion in
> msix_vector_use().
> 
> Avoid this by making msix_init() and its wrapper function
> msix_init_exclusive_bar() take the number of vectors as a uint32_t.
> The erroneous command line will now produce the warning
> 
>   qemu-system-i386: -device virtio-mouse-pci,vectors=19923041:
>     warning: unable to init msix vectors to 19923041
> 
> and proceed without crashing.  (The virtio device warns and falls
> back to not using MSIX, rather than complaining that the option is
> not a valid value this is the same as the existing behaviour for
> values that are beyond the MSI-X maximum possible value but fit into
> a 16-bit integer, like 2049.)
> 
> To ensure this doesn't result in potential overflows in calculation
> of the BAR size in msix_init_exclusive_bar(), we duplicate the
> nentries error-check from msix_init() at the top of
> msix_init_exclusive_bar(), so we know nentries is sane before we
> start using it.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2631
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Technically this fixes an assertion, but only if the command
> line is daft, so I didn't think it worth backporting to stable.
> ---
>   include/hw/pci/msix.h |  4 ++--
>   hw/pci/msix.c         | 10 ++++++++--
>   2 files changed, 10 insertions(+), 4 deletions(-)

Queued, thanks.

