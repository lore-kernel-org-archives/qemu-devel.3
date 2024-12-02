Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6047AE69E86
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tICPb-0007xr-3F; Mon, 02 Dec 2024 14:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tICPZ-0007xR-Gb
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:48:49 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tICPX-0007qi-TR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:48:49 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-211fb27cc6bso37285715ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 11:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733168926; x=1733773726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=03oETA9PrrgCkZ8r42nuCuA2jAaAjqZqfK+QbzmOD+s=;
 b=cgIt/McYZoJVQJj3+yJHK8zz4a7FS/Qz3awDT6Fo2Z4JOt2GZmHu78wBiD3BXBv+Au
 Rt3+YmvYuMG+4vZFTAHbocuQsJp79AIBtL6W1OfHDkVSHvMYaeNonFTzDduY+9glIFkj
 SMrJ9XT3rqDtjJIDKM1Aoyc4yR4n9YIjV40RYFT0+OxLFVXMav+6kcO5Myv0Vtndc3rx
 0vicMgki8d0yqOQkPvLr5EnOBxTnUh/nIvTaiHSFOV2F6AhKRiUCr10LRdEnPC/lTj57
 oBTEwsjf+/ek6uufzdZh92bcF7y5JbYoZXDaJa746YVenttCxtL/P6r/r5BxSkbWoUKM
 fzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733168926; x=1733773726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=03oETA9PrrgCkZ8r42nuCuA2jAaAjqZqfK+QbzmOD+s=;
 b=ir7tENwSmNbyAC1+DOp0bdKMQBv8orMDTMyX8kHcdmo9nvKu7cVAAidvcdnlxrGcO1
 gqGAKTuR2h7Fh2Ki1UCUkjAJV7BgJVLO2N0V3uWRNb57xtQQXKbAqbvApxOqQLFX6J07
 u5vvk230fdQHVzmMUZDXLVsNQetAjddQtXKE0oNltmLodk0UMY0s384zsQkpy7qfaqkG
 tq+to/nxjYAyLQjXdFNVu+AZl4aqaCcgN4JgPyTDVA7UGWrKYKUJRTwvKEmDzxX5ALHA
 sUw6TaysTtgV6TtDlvL+y6QydLNzqbUb8hvTyY54o5Zbp0l0IkSzpvkJjgD2l0Sv4Al0
 u/xA==
X-Gm-Message-State: AOJu0Yz4bJHfXi/E/v+pLUujHEKjuqJpQcplX81jTPqoxcBzrg99u/MF
 v564jiAn6IJvZe1eUsr8gPb9toPgm4yyd9Gf5yFVn0VKVZs/rvGyI12Ko9OyZTpIKKo5dPlE6xb
 CkHs=
X-Gm-Gg: ASbGncsuWLj8qFQ42SwHC03yKJQcVcQ+azchg8J7vKWjyhSk4Pu6bYtYeqv63n8vxJb
 YqKAD2/MnzBYHshw4Qn9RJQd6MM6VJLjz/Qo4IHAEccgITj2MCwO6nJ04gSRslNqy6pR2zuKvG0
 h6OL3N5wS5oDZbi/PQCOw5Qo6OxK67fCpjEuVSpKkfBKwB5exemAnAGblXdUxlZHTw41fa0pv/Q
 e+8Nmf8ck/SmqrjlN1DC45LvzwEsckGxP5a14YF1ZWgxmmzAcnVAyHDQtazgTtEUI3RfiZZF4hg
 l+LQzppi4gU2zJkGqnW4
X-Google-Smtp-Source: AGHT+IFIE/5tsHLGaJK+BoI7gJXBIR1a6xfvxEdBDx8/jGa5G3uORChIYoxhlD/f85LOFkxvWjZY5A==
X-Received: by 2002:a17:903:8c5:b0:215:9894:5670 with SMTP id
 d9443c01a7336-21598945873mr78390035ad.16.1733168926106; 
 Mon, 02 Dec 2024 11:48:46 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2153a70bbd1sm67501975ad.231.2024.12.02.11.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 11:48:45 -0800 (PST)
Message-ID: <21c5e930-d7ee-4dd8-a238-862f4db87849@linaro.org>
Date: Mon, 2 Dec 2024 20:48:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2? v2 1/2] hw/display/vga: Do not reset
 'big_endian_fb' in vga_common_reset()
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241129101721.17836-1-philmd@linaro.org>
 <20241129101721.17836-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241129101721.17836-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62e.google.com
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

ping?

On 29/11/24 11:17, Philippe Mathieu-Daudé wrote:
> The 'pci-vga' device allow setting a 'big-endian-framebuffer'
> property since commit 3c2784fc864 ("vga: Expose framebuffer
> byteorder as a QOM property"). Similarly, the 'virtio-vga'
> device since commit 8be61ce2ce3 ("virtio-vga: implement
> big-endian-framebuffer property").
> 
> Both call vga_common_reset() in their reset handler, respectively
> pci_secondary_vga_reset() and virtio_vga_base_reset_hold(), which
> reset 'big_endian_fb', overwritting the property. This is not
> correct: the hardware is expected to keep its configured
> endianness during resets.
> 
> Move 'big_endian_fb' assignment from vga_common_reset() to
> vga_common_init() which is called once when the common VGA state
> is initialized.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/display/vga.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 892fedc8dce..b074b58c90d 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1873,7 +1873,6 @@ void vga_common_reset(VGACommonState *s)
>       s->cursor_start = 0;
>       s->cursor_end = 0;
>       s->cursor_offset = 0;
> -    s->big_endian_fb = s->default_endian_fb;
>       memset(s->invalidated_y_table, '\0', sizeof(s->invalidated_y_table));
>       memset(s->last_palette, '\0', sizeof(s->last_palette));
>       memset(s->last_ch_attr, '\0', sizeof(s->last_ch_attr));
> @@ -2266,6 +2265,7 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
>        * all target endian dependencies from this file.
>        */
>       s->default_endian_fb = target_words_bigendian();
> +    s->big_endian_fb = s->default_endian_fb;
>   
>       vga_dirty_log_start(s);
>   


