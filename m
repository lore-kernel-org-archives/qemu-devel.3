Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0C6C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 04:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2NS1-0001H7-SU; Wed, 09 Apr 2025 00:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u2NRz-0001GQ-9X
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 00:54:11 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u2NRx-0002zZ-NN
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 00:54:11 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86d6fd581f4so361712241.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 21:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744174447; x=1744779247; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9VJemA18ywwF/ziFGdOY4+YqeKDlR+50zHLyOBQhy8=;
 b=KMeFcnpWwwyviZl4MI2FP46Gu/fWyT4BdeFE8qdnXw0LbN2AaUdQbeNq+YNWklPpi6
 CB0SXjlIKP0S42xsn4Uu8ZCTkGTydPmMUxbnnOQQmTVqF2Eji3QMCEqzBFxo0Rp20ND5
 8W3oV70p9CK//PwZwjJw50FECVKhXrTLWunZ/5RJwHzc4njLrtlYK9CVuQbm7NER+F6T
 QoR02UBZmRw2/TYVfoMVLMq5+B5nLXbiSUsBF+Rv7aTdH788dAN8APTPJz3djUpTKyGm
 AXiKgUcvORYiCqSFkOykaUEVHiW9RQBSiArc34xHWNC/lojtLuu7HZPD51DyjkLpv/hW
 Fd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744174447; x=1744779247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9VJemA18ywwF/ziFGdOY4+YqeKDlR+50zHLyOBQhy8=;
 b=Prmdo5iWQRjmO4X2VDsBg1Xy5/8YRhc1pQY+Q8PLidHyNXBWcvfn3tA0BKQWwqOVV+
 tx3rEJV5lieyzittTJVS/Zzqbas9Qr4acKt9tA2rPWyFn0bW0+3YNB8rLZKCTOIESk1l
 pA7Ry5NH+WFOpoHAH72iUD2cu5uONrNfa9D8IvtQPAo75iLvyHIvR73tVfL+4hIfDO3z
 7zm2VZfMDmrAy5Iv6ZkBe/yrIyGhJBgEzNPXbv3pU2N3/zF8bgaLOvO/ePSbFeyC79x1
 MSgL/eHENPetidjkvXYCU2yPA34he/phwSgRPKOxtNtMmyJ/n0zv1juc/W3LHjOJdAnO
 pVAQ==
X-Gm-Message-State: AOJu0Yx4xQdmSuQ1kqb2j45BpE8U3xktA00AFe5ciML8B+3mIDMVj4sG
 yhCTCclT9gaQyhkJpv4Sag0Fg4rLbTw8ItebMAFA/q+EFk7eivJFpgMIafdGGcZyJ/gI1Kt3Y2/
 urhzcsg5qIZhLBeXuIhjGAkiKmJU=
X-Gm-Gg: ASbGncs0DRNBMppPGCDsvOMyx/Hlt4Xu7fig/SH+VCLmPI1pjJq+cV0ON4CP88tgQoc
 3DMfhvD6oH+ID4RfeuBoEsZE0l7BHmmu9IYf/KDB3qjAeqHh9Z448uRIGPdoQtfVaSdYi/FzQnq
 aNe4i2OGMCyF23FdbDPKBHctgrDrE0VhwWRGrgSDVAQuAfWTJpOHOnUyk4
X-Google-Smtp-Source: AGHT+IGjHsToK8mEmP/UQoyvJksWEexD817ohQb4noglg0DSt5jIrhDxLfagHkCrKpYHOeL4oHq5Qp5kIELdtcxa7DE=
X-Received: by 2002:a05:6102:3e88:b0:4b3:fee3:2820 with SMTP id
 ada2fe7eead31-4c9c48a8cc9mr853915137.9.1744174447051; Tue, 08 Apr 2025
 21:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-12-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-12-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 9 Apr 2025 14:53:40 +1000
X-Gm-Features: ATxdqUFXXqnxKtS5Pcm72yp1LnsQFwGGHuYBURkEMgTqaXJReWajNJub4PDQMbQ
Message-ID: <CAKmqyKMEdMwsVTnd2qnAdTqbQQGmuHq=3cPt5uQ=4BUMpukQHA@mail.gmail.com>
Subject: Re: [PATCH 11/27] target/riscv: include default value in
 cpu_cfg_fields.h.inc
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Apr 6, 2025 at 5:03=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> In preparation for adding a function to merge two RISCVCPUConfigs
> (pulling values from the parent if they are not overridden) annotate
> cpu_cfg_fields.h.inc with the default value of the fields.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg.h            |  2 +-
>  target/riscv/cpu_cfg_fields.h.inc | 22 +++++++++++-----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e9bf75730a6..aa28dc8d7e6 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -23,7 +23,7 @@
>
>  struct RISCVCPUConfig {
>  #define BOOL_FIELD(x) bool x;
> -#define TYPED_FIELD(type, x) type x;
> +#define TYPED_FIELD(type, x, default) type x;
>  #include "cpu_cfg_fields.h.inc"
>  };
>
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index bbc68276737..ef58826b2bc 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -2,7 +2,7 @@
>   * Required definitions before including this file:
>   *
>   * #define BOOL_FIELD(x)
> - * #define TYPED_FIELD(type, x)
> + * #define TYPED_FIELD(type, x, default)
>   */
>
>  BOOL_FIELD(ext_zba)
> @@ -153,19 +153,19 @@ BOOL_FIELD(misa_w)
>
>  BOOL_FIELD(short_isa_string)
>
> -TYPED_FIELD(uint32_t, mvendorid)
> -TYPED_FIELD(uint64_t, marchid)
> -TYPED_FIELD(uint64_t, mimpid)
> +TYPED_FIELD(uint32_t, mvendorid, 0)
> +TYPED_FIELD(uint64_t, marchid, 0)
> +TYPED_FIELD(uint64_t, mimpid, 0)
>
> -TYPED_FIELD(uint32_t, pmu_mask)
> -TYPED_FIELD(uint16_t, vlenb)
> -TYPED_FIELD(uint16_t, elen)
> -TYPED_FIELD(uint16_t, cbom_blocksize)
> -TYPED_FIELD(uint16_t, cbop_blocksize)
> -TYPED_FIELD(uint16_t, cboz_blocksize)
> +TYPED_FIELD(uint32_t, pmu_mask, 0)
> +TYPED_FIELD(uint16_t, vlenb, 0)
> +TYPED_FIELD(uint16_t, elen, 0)
> +TYPED_FIELD(uint16_t, cbom_blocksize, 0)
> +TYPED_FIELD(uint16_t, cbop_blocksize, 0)
> +TYPED_FIELD(uint16_t, cboz_blocksize, 0)
>
>  #ifndef CONFIG_USER_ONLY
> -TYPED_FIELD(int8_t, max_satp_mode)
> +TYPED_FIELD(int8_t, max_satp_mode, -1)
>  #endif
>
>  #undef BOOL_FIELD
> --
> 2.49.0
>

