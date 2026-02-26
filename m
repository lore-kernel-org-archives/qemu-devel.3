Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B18FD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjoF-0007k7-RM; Thu, 26 Feb 2026 17:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjoE-0007jj-F0
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:26:14 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjoC-0006U4-Mw
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:26:14 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so791777a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772144771; x=1772749571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o/OEHDyfcrpJjd9xBUVwuWiP15shi86UCO8ZwRmhmEM=;
 b=D+q4Dn6MkXHOBW0vFqMSlBDAkVrCWirK8ohlohbg7Qmqjat74nBHn6uF9LhSB8N+Mf
 fOaMGgAE9PTM6mPOye1WPCNKQzz5TbvSR2qmV628YCS+jVZy6d6tedZTUF5H1cOkPXSD
 8nr6tNMIlEwPesZ1Uz6/CfpmYFMvLUjKahRjRT8Gl/BFzX0CszXWFjunL+Xr3Cre/ZF3
 ZkqMmPSvoScj8XIg3rXw/ZYEAGaHX7/cWCRQ2C+olEJJSFzafYMcDg3uIYUcUG2UuTDV
 WNNU2r9fj/T4WSTj/mBKSkWaRp89cXWLvNIInvwH+zECVbiI4cmUXl01AVB/3/NlR+sI
 8Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772144771; x=1772749571;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o/OEHDyfcrpJjd9xBUVwuWiP15shi86UCO8ZwRmhmEM=;
 b=wMJK1nq3UxOM1M+sYl4G6g1zO0uYCQXwGDyzSa4m1BMx4oDelyyTT16qnnwCQRzVKs
 Xr46OFJY2HtvJvapCOP+383ltB8VaOknmx/JZnUpygeHe0Z2iaODjL9Z9b0RiJ1WPnLJ
 RC/0S9ER8JhruHmE2I1PIwASG8GsIYmzxxN5p8Eir/Ir9MQz+0VFLSLk2BrCcJ0uNgwT
 34WN5UYgKB3EbTPxrEbW3fYUh9UOxE9FNGEEcb9taCdEe2Hecmj0LReYZ7ve4Dp7NWd2
 ae3kZ1TgnBYIxAazIZatkLELFvmKDNPFJuRAcydNNodVGdsb8i166/XoiEKVaxeNwns8
 0rSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNkJ8E9OAeWUKDI5oZRsYimf/mMsZx3wUmaW3UlE8IUpMTDBKCTO52LexjFitZ2lFKAMYYA+5zvwMi@nongnu.org
X-Gm-Message-State: AOJu0Yyi1DRjSo3DqqD7au1la7Ec/b9DlzytTJYLNMywsZZLqo3vDL9F
 yrY8zWjiRSCg1hhwF4s2U6X6jdEEdh46Uq0OhJsA0tsh+wEjo6+BLwlubtWKfRNVckk=
X-Gm-Gg: ATEYQzzST1m8TFEeT+KNdlzNlFWZZrJ+Xa7pEnrQdk52x0VKhe6PT18g1xMeOIIn3jU
 0FXE704MteLJLmu2zWH6zROAVK0Q28Z4S11MyXEt1fcOegDFVZrIwu+ZVpk+b5ouV9tcwRBKvbL
 lGrk1dKuAcpXtrAGOrHcdhKit2+X1pH5oqUOXB8YcFNkgalwH9xJhriLkcsqDFRB9KGWOY2xVq6
 qZyedNZ+Mw+xf/6WPQ2ugPmNhzdxR6Q6Q8BEwN+/jZTtJiDyGxWVfaJKht8F9nM2GozA69918Ps
 /InmjtEhGj3bl4mAEbYcxUkId5r7J+oNuZ+2LXnKuZwPBy2ark4tJ9KV8Xh3MI/5tmY8OEYAD4W
 utmmiXP6sYvbx9hfuW/9Zn0lrAlkAnDabgn2rm17tjzlQKwVJyDFON1LuzDPt0MGNkPTrxgWrii
 yayQZA/s6HhuSUL6MegLwP6cr/9ahXSEeI9Dx/NbAhzG7ib7W/4AcfB3J1Hmzn7X+yOEfK
X-Received: by 2002:a17:90b:524a:b0:359:df9:c9f9 with SMTP id
 98e67ed59e1d1-35965c3af23mr604243a91.7.1772144771020; 
 Thu, 26 Feb 2026 14:26:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359034bb172sm6642250a91.11.2026.02.26.14.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 14:26:10 -0800 (PST)
Message-ID: <8f1b5aa3-50e7-4f64-a423-23c4e9cec48f@linaro.org>
Date: Thu, 26 Feb 2026 14:26:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] system/memory: Have 'info mtree' display addresses
 nicely
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260226220226.20164-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

On 2/26/26 2:02 PM, Philippe Mathieu-Daudé wrote:
> Use the size of a MR / AS to decide how many address chars
> need to be used.
> 
> For example, using 'qemu-system-x86_64 -M q35 -S -monitor stdio'
> to run 'info mtree' displays before:
> 
>    address-space: I/O
>      0000000000000000-000000000000ffff (prio 0, i/o): io
>          0000000000000000-0000000000000003 (prio 0, i/o): acpi-evt
>          0000000000000004-0000000000000005 (prio 0, i/o): acpi-cnt
>          0000000000000008-000000000000000b (prio 0, i/o): acpi-tmr
>          0000000000000020-000000000000002f (prio 0, i/o): acpi-gpe0
>          0000000000000030-0000000000000037 (prio 0, i/o): acpi-smi
>          0000000000000060-000000000000007f (prio 0, i/o): sm-tco
>        0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
>        0000000000000008-000000000000000f (prio 0, i/o): dma-cont
>        0000000000000020-0000000000000021 (prio 0, i/o): pic
>        0000000000000040-0000000000000043 (prio 0, i/o): pit
>        ...
>    memory-region: pc.ram
>      0000000000000000-0000000007ffffff (prio 0, ram): pc.ram
>    memory-region: pc.bios
>      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>    memory-region: pci
>      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>        00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
>        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>    ...
> 
> and after:
> 
>    address-space: I/O
>      0000-ffff (prio 0, container): io
>          0000-0003 (prio 0, i/o): acpi-evt
>          0004-0005 (prio 0, i/o): acpi-cnt
>          0008-000b (prio 0, i/o): acpi-tmr
>          0020-002f (prio 0, i/o): acpi-gpe0
>          0030-0037 (prio 0, i/o): acpi-smi
>          0060-007f (prio 0, i/o): sm-tco
>        0000-0007 (prio 0, i/o): dma-chan
>        0008-000f (prio 0, i/o): dma-cont
>        0020-0021 (prio 0, i/o): pic
>        0040-0043 (prio 0, i/o): pit
>        ...
>    memory-region: pc.ram
>      00000000-07ffffff (prio 0, ram): pc.ram
>    memory-region: pc.bios
>      fffc0000-ffffffff (prio 0, rom): pc.bios
>    memory-region: pci
>      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>        00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
>        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>    ...
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/memory.c | 27 +++++++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 4d276307da5..abcbdaadcd7 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3321,7 +3321,26 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
>   
>   #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
>                              int128_sub((size), int128_one())) : 0)
> -#define MR_ADDR_WIDTH   16
> +
> +static unsigned mr_addr_fmt_width(const MemoryRegion *mr)
> +{
> +    const unsigned int bits = 127 - clz128(mr->size);
> +    unsigned int width;
> +
> +    if (bits <= 8) {
> +        width = 2;
> +    } else if (bits <= 16) {
> +        width = 4;
> +    } else if (bits <= 32) {
> +        width = 8;
> +    } else if (bits <= 64) {
> +        width = 16;
> +    } else {
> +        width = 20;
> +    }
> +    return width;
> +}
> +
>   #define MTREE_INDENT "  "
>   
>   static void mtree_expand_owner(const char *label, Object *obj)
> @@ -3513,7 +3532,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>           return;
>       }
>   
> -    width = MR_ADDR_WIDTH;
> +    width = mr_addr_fmt_width(view->root);
>       while (n--) {
>           const MemoryRegion *mr = range->mr;
>   
> @@ -3643,7 +3662,7 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
>       MemoryRegion *mr = key;
>       GSList *as_same_root_mr_list = value;
>       struct AddressSpaceInfo *asi = user_data;
> -    const unsigned int width = MR_ADDR_WIDTH;
> +    const unsigned int width = mr_addr_fmt_width(mr);
>   
>       g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
>       mtree_print_mr(mr, 1, width, -mr->addr, false,
> @@ -3692,7 +3711,7 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
>       /* print aliased regions */
>       QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>           const MemoryRegion *mr = ml->mr;
> -        const unsigned int width = MR_ADDR_WIDTH;
> +        const unsigned int width = mr_addr_fmt_width(mr);
>   
>           qemu_printf("memory-region: %s\n", memory_region_name(mr));
>           mtree_print_mr(mr, 1, width, 0, false, &ml_head, owner, disabled);

That is so neat!
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

