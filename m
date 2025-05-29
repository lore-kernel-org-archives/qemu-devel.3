Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACF4C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 23:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKmLs-0004mN-ID; Thu, 29 May 2025 19:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKmLq-0004m5-6x; Thu, 29 May 2025 19:07:54 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKmLo-0004nm-Mp; Thu, 29 May 2025 19:07:53 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-525da75d902so433457e0c.3; 
 Thu, 29 May 2025 16:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748560071; x=1749164871; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XA3WbUPKYypPg3U/frQttAvme9NxPp9qOD20cCwC3Kc=;
 b=gpz61bHh4jMrOJfYKnZlNkp/x7ZaxVenmj7yh1riiJ8CGB3Ravl6lZUmLyoOp6IdVT
 BzCwLm5xd6EBkWn13Q29w9qq6+kjbqXi8OHlHO1BPfTxuKFZdWLAG6GZ/M1oUepnk6O+
 CrY7L66UUxhEn4BlkST9Hl+4PZ4k8lQWy5bMo66OAUvYL1nbUZxGJ8+1g4fNB0ewdw4D
 Tw2YDpL1JcyxqO3p+kfzfAX95TM3JRlZeqx84J3hljdjjaZG9NitlvGqzUeJN/+iHb6A
 SvVFzPcGJ9WmES2j9a0/SVlTElbA0Caly7d5nHXVD7mwdauk3uYUNcyUgDRjnhPBBMwR
 HJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748560071; x=1749164871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XA3WbUPKYypPg3U/frQttAvme9NxPp9qOD20cCwC3Kc=;
 b=VVf7YZElmJSqhqT1ltJuKgv0JLRNG1enGim1enuddaVlw+T/qtaBIZ+ij25WagrhKZ
 IbbQ76RV+KoE2IkUyxa7K85PSd+cOUORiIsRNyh3lMD+r2E9HHGp+/rYJZAgv/80CDMD
 EtgF9kjApNlWx1hwcJdzeEygaEfhi4CfLMI7NY1Ik1+aAcAsP8uC7dQiqNE3g1gsAavj
 DRn1b56QTiWV5mj82ZlazE0lG47NiXuZMfqvW5qMamKtjX3cmuVoDtTqLzTQpVm2W7Dp
 2w6X3+EGxAfSakYVZBBh+4FMbLtVNQ/NnUmjQivsZSU2GM5+2g6Q8uecqlI/lOdzMVS7
 afsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/noz9OIAb7lOI9NazMyc4iz0fB6L4rugosSpj/MSZ+8vu+12Y8DoHnNV3ghxDc8WFZ0iWd+tGMOkT@nongnu.org
X-Gm-Message-State: AOJu0YzY2qucURFpF+kR+nwdeWKdRO3oFLdPjMCC7SNmPK7nXj/HdHST
 7OZsqy+PADGq+lNpyaB/UpTSSNy7+nIL0PYZ6XxjRQzFzrOrIj6eWG6E0fJWxsjmcc2ctg1F9Av
 zv5mhrX289SuGVhAEBRnr48NqGjjTtjc=
X-Gm-Gg: ASbGncsQd9lYCxbnOOa17EfLBFAH4NX3+26Kea/tfNrbOgG5nDm/+eU8X28JFBJ2wlf
 keMcTVlDTr6zoAAkilXC7jxGT8tbttgO8Fliq5xeeH2wLPZk8FBYdB2nLnu4KG4LgZmHRjSt+67
 OSyylv2C0mHmS6w6w8/PSIyLW/FglC+sIEitNjoyIuIzdzxcQdmaO3ItUGpe49FYAy8hFQFzqcw
 g==
X-Google-Smtp-Source: AGHT+IGzAnUFb54ieWCYQAJ0qdcx1PeKfiVf+17fSA/Qsf+ZQlCQJU5MiK07ElUvKIM+X2YwXmVUaBeKydd+EzHBfW0=
X-Received: by 2002:a05:6122:790:b0:52a:7787:53d7 with SMTP id
 71dfb90a1353d-5308109f849mr1676966e0c.6.1748560071117; Thu, 29 May 2025
 16:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250522081236.4050-1-jay.chang@sifive.com>
In-Reply-To: <20250522081236.4050-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 May 2025 09:07:25 +1000
X-Gm-Features: AX0GCFs8QVsWw5gXshylmO1pdoosxJYqXHcAh__StM9MZq-3rmDwsAUWyjsRXqI
Message-ID: <CAKmqyKOCcyoPWbDJyWvZKeeWfBi7yPDSn9R4k3rwtz4HiZv6ig@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Extend and configure PMP region count
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Thu, May 22, 2025 at 6:14=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
>
> The first patch extends the number of PMP regions supported up to 64,
> following the RISC-V Privileged Specification (version >1.12), where
> RV32 can have up to 64 PMP regions configured through 16 CSRs.
>
> The second patch makes the PMP region count configurable via a new
> CPU parameter `num-pmp-regions`. This allows platforms to adjust
> the number of PMP regions without relying on a fixed default value.
> If unspecified, the default remains 16 to preserve compatibility.
>
> Change log:
>   V4:
>   * Changed `pmp_regions` type from `uint16_t` to `uint8_t`
>   * Introduced `OLD_MAX_RISCV_PMPS` macro
>
> Jay Chang (2):
>   target/riscv: Extend PMP region up to 64
>   target/riscv: Make PMP region count configurable

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c                |  54 ++++++++++++-
>  target/riscv/cpu.h                |   3 +-
>  target/riscv/cpu_bits.h           |  60 ++++++++++++++
>  target/riscv/cpu_cfg_fields.h.inc |   1 +
>  target/riscv/csr.c                | 129 +++++++++++++++++++++++++++++-
>  target/riscv/machine.c            |   3 +-
>  target/riscv/pmp.c                |  28 ++++---
>  7 files changed, 262 insertions(+), 16 deletions(-)
>
> --
> 2.48.1
>
>

