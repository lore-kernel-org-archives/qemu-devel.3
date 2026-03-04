Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AFEEFCE38
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxr4v-0001rO-Js; Wed, 04 Mar 2026 13:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr4u-0001pK-Bl
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:36:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr4s-0001UO-Qd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772649369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kz2OmI5L8xNc+A3jsHmTyZnNyHtU1xRswOp/RBVs4BM=;
 b=BBoqP1XLCfaTNnBts+6SwSlJhZZEaNTFh+g9XLQA5zh5Q3JVyJxq4QoU2N/Ch/03i85P/o
 lxQDmIR1NjYQjCIlG7+Cljw8xdA/axX8j74vQUxRJZfFwz077CUpjtK/+poslfpL9TX34R
 LFCJZ33ziQdU1epcITkIIM9YhTpPk9A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-vY9hQuOhObOxH4AOLg9IJA-1; Wed, 04 Mar 2026 13:36:08 -0500
X-MC-Unique: vY9hQuOhObOxH4AOLg9IJA-1
X-Mimecast-MFC-AGG-ID: vY9hQuOhObOxH4AOLg9IJA_1772649368
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c70d16d5a9so4100018885a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772649368; x=1773254168; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kz2OmI5L8xNc+A3jsHmTyZnNyHtU1xRswOp/RBVs4BM=;
 b=jivn/2lLGyW+fIrotVpd6KkTQkdu9Td5R7e6eo8fOg7oxzeaAo4GEOvav6vtvIfFVg
 TqkHWmsmqX3WRvYR6FrY85i0Ed2JqZQsuJg5d7I4udCEbtfvve7fZhIh9NxXvpwSNh2y
 QkgxP0Y4aBqmd8936wwP9o7kaKSIcoXtK8Z+sy/3/bfjdaMw5GoXlrjqMg+0cH4N7ocd
 BPdGmDwilG+7bBzRKTT6v740wwdmAgSgkzSLptOIG1IfZeguvuyEQkwk/2XvXN93h8oX
 zrlREVfpIPw2Q09nYMRa6LW4neSjVajZsryrL2NTdJ2XDTkF4qYpLLjBHdK/oXWjxTsp
 o8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772649368; x=1773254168;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kz2OmI5L8xNc+A3jsHmTyZnNyHtU1xRswOp/RBVs4BM=;
 b=OZZVfenBU9qNnzgfMr3Cxijg8zQLT2cTkTDvKUYifzlLpB8Ceeaw48E6wNA3h++akB
 sKWb5Zl9aipkgGv0rTxQ+Em+2XqmAu4PUmnNCKljfgDkVcP0rV1XCx/Gr5JG71mZw892
 yfqide50cvp88iW1Fe8EgA6A2cdHfdwf6ydQ8j8tDkYONS2UAvwvTw/QwjBvnsTYacXq
 h3xkHdopHsuD9cWvZLlQYp4aUzpcde1TQxLxGWlDuwQFd71fqx52D1e/r8fd6o8Vqc4D
 2fSK6Dyk4vVLzYW9laWt8xtOiTyVrhHriZWFCUjhNTvGiiFMorbMrHJOPB54FSIfZtHe
 ryiA==
X-Gm-Message-State: AOJu0YzmEp/YNlf1X2EK81yoKKUlyuGLIMJJzFc8v7ncx9Y4IewfPra4
 AEOAzynTPJzd+Z8w0K8suHAN21WE1jmz+J/DjV+TQV7ucSWSqCCEGL7vBIrm7nFCpcVWJACPXX9
 fi4HAn0xNlH7n+rzsN/DTKd3XSJbJsx8Ra+CUeVrKOJ+xsGYy9MdBSdgC
X-Gm-Gg: ATEYQzxEzA12U5nAdvGxadtKQiS9qO7OIKkyb5zMz7UlpjKP6+2FDGxh7kjtCcIwEh0
 8QYm/lsoL1vDluFIlyvUPt8xTQ667+Piz6dWwME3/fG94s/aVT3WxvhKYDQL0qfgX2ZLAyIeQUE
 DhLUzbRD0SOX/Sp1A9vqNziw3to7F4U/EM9HRgwm1fITVyr1Qe46Kd6rufFqwhNzf6caI/SUFBd
 rl1RexX3jW2n+I+ZrBl2QWMpd4Fj5A7G0bzaDz9770Pxx7lCyJ+hpayjRt10UwHAmTNTmqFfJPT
 mERHd6jyxB2FWZP2sXNCa7RnXzgn12wtKvuZJ39gVQyKWh8VWzmUVv+F1BG4rOJJMa8EmZS4R0l
 LIxIdhZYQye6bhw==
X-Received: by 2002:a05:620a:29d2:b0:8c6:db3a:3735 with SMTP id
 af79cd13be357-8cd5aec6946mr381623385a.5.1772649367789; 
 Wed, 04 Mar 2026 10:36:07 -0800 (PST)
X-Received: by 2002:a05:620a:29d2:b0:8c6:db3a:3735 with SMTP id
 af79cd13be357-8cd5aec6946mr381617185a.5.1772649367222; 
 Wed, 04 Mar 2026 10:36:07 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf66c515sm1708613385a.11.2026.03.04.10.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:36:06 -0800 (PST)
Date: Wed, 4 Mar 2026 13:35:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 7/7] system/memory: Have 'info mtree' display addresses
 nicely
Message-ID: <aah7i1iaoRb9yh7X@x1.local>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226220226.20164-8-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 11:02:25PM +0100, Philippe Mathieu-Daudé wrote:
> Use the size of a MR / AS to decide how many address chars
> need to be used.
> 
> For example, using 'qemu-system-x86_64 -M q35 -S -monitor stdio'
> to run 'info mtree' displays before:
> 
>   address-space: I/O
>     0000000000000000-000000000000ffff (prio 0, i/o): io
>         0000000000000000-0000000000000003 (prio 0, i/o): acpi-evt
>         0000000000000004-0000000000000005 (prio 0, i/o): acpi-cnt
>         0000000000000008-000000000000000b (prio 0, i/o): acpi-tmr
>         0000000000000020-000000000000002f (prio 0, i/o): acpi-gpe0
>         0000000000000030-0000000000000037 (prio 0, i/o): acpi-smi
>         0000000000000060-000000000000007f (prio 0, i/o): sm-tco
>       0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
>       0000000000000008-000000000000000f (prio 0, i/o): dma-cont
>       0000000000000020-0000000000000021 (prio 0, i/o): pic
>       0000000000000040-0000000000000043 (prio 0, i/o): pit
>       ...
>   memory-region: pc.ram
>     0000000000000000-0000000007ffffff (prio 0, ram): pc.ram
>   memory-region: pc.bios
>     00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>   memory-region: pci
>     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>       00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>       00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>       00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
>       00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>   ...
> 
> and after:
> 
>   address-space: I/O
>     0000-ffff (prio 0, container): io
>         0000-0003 (prio 0, i/o): acpi-evt
>         0004-0005 (prio 0, i/o): acpi-cnt
>         0008-000b (prio 0, i/o): acpi-tmr
>         0020-002f (prio 0, i/o): acpi-gpe0
>         0030-0037 (prio 0, i/o): acpi-smi
>         0060-007f (prio 0, i/o): sm-tco
>       0000-0007 (prio 0, i/o): dma-chan
>       0008-000f (prio 0, i/o): dma-cont
>       0020-0021 (prio 0, i/o): pic
>       0040-0043 (prio 0, i/o): pit
>       ...
>   memory-region: pc.ram
>     00000000-07ffffff (prio 0, ram): pc.ram
>   memory-region: pc.bios
>     fffc0000-ffffffff (prio 0, rom): pc.bios
>   memory-region: pci
>     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>       00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>       00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>       00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
>       00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>   ...
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  system/memory.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 4d276307da5..abcbdaadcd7 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3321,7 +3321,26 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
>  
>  #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
>                             int128_sub((size), int128_one())) : 0)
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

Is there any case this can happen?  I thought we don't have MR larger than
1<<64.  Not a huge deal, though.

Reviewed-by: Peter Xu <peterx@redhat.com>

> +    }
> +    return width;
> +}
> +
>  #define MTREE_INDENT "  "
>  
>  static void mtree_expand_owner(const char *label, Object *obj)
> @@ -3513,7 +3532,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>          return;
>      }
>  
> -    width = MR_ADDR_WIDTH;
> +    width = mr_addr_fmt_width(view->root);
>      while (n--) {
>          const MemoryRegion *mr = range->mr;
>  
> @@ -3643,7 +3662,7 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
>      MemoryRegion *mr = key;
>      GSList *as_same_root_mr_list = value;
>      struct AddressSpaceInfo *asi = user_data;
> -    const unsigned int width = MR_ADDR_WIDTH;
> +    const unsigned int width = mr_addr_fmt_width(mr);
>  
>      g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
>      mtree_print_mr(mr, 1, width, -mr->addr, false,
> @@ -3692,7 +3711,7 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
>      /* print aliased regions */
>      QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>          const MemoryRegion *mr = ml->mr;
> -        const unsigned int width = MR_ADDR_WIDTH;
> +        const unsigned int width = mr_addr_fmt_width(mr);
>  
>          qemu_printf("memory-region: %s\n", memory_region_name(mr));
>          mtree_print_mr(mr, 1, width, 0, false, &ml_head, owner, disabled);
> -- 
> 2.52.0
> 

-- 
Peter Xu


