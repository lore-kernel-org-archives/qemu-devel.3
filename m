Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3848C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 05:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkH0J-0004Xw-0G; Wed, 13 Mar 2024 01:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkH0A-0004Wp-Pg
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:18:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkH09-0008Aw-9d
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:18:06 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6aa5c5a6fso638548b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 22:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710307083; x=1710911883; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GE8hhN1a7ibH5O1+4As36+w6TzTJvEkL7Nqc428usZU=;
 b=gQuy/N3K81Ycg+2ydbEhapecwnVaIFI54ZgnwPa/tKPhkpGpE6jiYRWEFk2GBPWGyD
 83rdVjlZ5hw2dZyEOWgR/TcCVQ9ILtXe3gOdWRd13nf9cH7C746rczt+OarOTg3DV6vm
 kPoukrqRrcITnOeo6h/qYwlMY7rPspmS5sKaZlUad4+wo0bklMiT7QhR7Xk82lBhpUKI
 UY7AmsOxLDcaVXqrpMn1wXlbGCLh+bdCDcPKIWFKrlWTRa0OPEUiEGqyMGJ6kbkKEuVN
 dPlKQ8vQRnnfnC5LB+vCn3yDDaHON2PlEb0fJQ1GKLZrGXz6DmoZBP2vb5jwciFUQtvK
 WQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710307083; x=1710911883;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GE8hhN1a7ibH5O1+4As36+w6TzTJvEkL7Nqc428usZU=;
 b=Cg1ht2hyPR7u3n6LInGsxRxjqgUqC1M6X+BVkrkQ1FXpDmxJ204qTLmA+yRbQVXZC9
 4abEL3aZrrNNwLlkI6OqwIdspOUJzyHoySJy0R84kIWzdwrs6jR47aqnxmD/ursg6LZn
 glZAkAb5lijBw3XmpY1RzYh9g28MLUrubGgV3C0xlfymFSrivDbd922v+XHE0ZJZcmmM
 e9yANjCiW+Y7EeJF/4JHXbJfhSZiANqe6epFY/6Z7OPbHDXYEEjWEx7i7pITYomeBb24
 Z/1BFXS+sDmIG7o+MGUOIa9Rrrk79Hi0ld6a/nowcpBjmwoyJGQd5rRa7ABJYN43ZA1k
 vhBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQKT0wxaoUBNwcxJzup3A0cDrroLcXo87daMba5GmA4nj58nrm17Up7NYswVpo6P5ynNz2BQql2HT25VFgfJWNj/z2gZE=
X-Gm-Message-State: AOJu0Yz05nx9RcO2F0CbhTLfJ1UhE1hcT9DrvIjnD5/rhOOLHdppZNM6
 MaQ5kCTv3ZX5xkVjb6Ukx4W29gVVBlv97z8N9cB1MVaDFjpfIeT6
X-Google-Smtp-Source: AGHT+IFnRnlppiw+LHReegp6IdP1+J2Kxs0b1EqKanCyrVp2Qu9Qoytxmld4FzzjJYgtSU+N1VNF3g==
X-Received: by 2002:a05:6a21:1aa:b0:1a1:492a:d6a0 with SMTP id
 le42-20020a056a2101aa00b001a1492ad6a0mr6096389pzb.47.1710307083134; 
 Tue, 12 Mar 2024 22:18:03 -0700 (PDT)
Received: from localhost ([1.146.20.17]) by smtp.gmail.com with ESMTPSA id
 l16-20020a170902f69000b001dd8cfd9933sm6070804plg.151.2024.03.12.22.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 22:18:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 15:17:55 +1000
Message-Id: <CZSD9BNHUXII.2Q6EMCDYLUSF1@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "David Hildenbrand" <david@redhat.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Peter Xu" <peterx@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH-for-9.0 v2 1/3] physmem: Expose tlb_reset_dirty_range_all()
X-Mailer: aerc 0.15.2
References: <20240312201458.79532-1-philmd@linaro.org>
 <20240312201458.79532-2-philmd@linaro.org>
In-Reply-To: <20240312201458.79532-2-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed Mar 13, 2024 at 6:14 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> In order to call tlb_reset_dirty_range_all() outside of
> system/physmem.c, expose its prototype.
>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/exec/exec-all.h | 1 +
>  system/physmem.c        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index ce36bb10d4..3e53501691 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -655,6 +655,7 @@ static inline void mmap_unlock(void) {}
> =20
>  void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length=
);
>  void tlb_set_dirty(CPUState *cpu, vaddr addr);
> +void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
> =20
>  MemoryRegionSection *
>  address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
> diff --git a/system/physmem.c b/system/physmem.c
> index 6cfb7a80ab..5441480ff0 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -819,7 +819,7 @@ found:
>      return block;
>  }
> =20
> -static void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t lengt=
h)
> +void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
>  {
>      CPUState *cpu;
>      ram_addr_t start1;


