Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C92C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 04:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmnzJ-0006dh-RT; Wed, 20 Mar 2024 00:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rmnzH-0006aK-Sb; Wed, 20 Mar 2024 00:55:39 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rmnzG-0008UV-4G; Wed, 20 Mar 2024 00:55:39 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4d43c633fecso1812474e0c.3; 
 Tue, 19 Mar 2024 21:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710910536; x=1711515336; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIDewJjTRJw+8XwTOGg/nyEY1+qiHPhh6s0eVWkqr8k=;
 b=Y7ITVVHAhk0AjaqKxyxdKj0w7uHXYGOMP7QnELmL7PAZ5wpTizaovEFFuANK4IAH6i
 jyBa6ESZFL4am3ao/1lXF0mQgbAQPzpdtFyjfBd0sS2mWigndOQBLgJ4tS9nbdPRHVaR
 LgtKHzSVHsWEoM8BVF9pW+e+YHHCZgm7xX8XIkI/eEmf7O+pp7PsIUTOgrtuz3lQUI/O
 3Z7lhp8pMDV/rj8RXx4B+KFrSsQ/yDvkTXqeH/8IuXplAC2HFsysUjD8qJfTPh7jJ8qi
 snLGdQZCrvlSGl7CRGLNk/Fktp2uBnvIccU9m9LMVZ9+rUhgpnp6BkkF+UPIJ/Y/+0oJ
 OHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710910536; x=1711515336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIDewJjTRJw+8XwTOGg/nyEY1+qiHPhh6s0eVWkqr8k=;
 b=YVhKhoiEj8OFDFHKNDBqP9pcCVACpivfc/rw9avJexAwCvEi1JSjwe8b3VxJhxu9c6
 aQPOwRH1DuGUPplTHUmNrqZKjSfRuG+V6Dg9vW8yX3LaN/lXaL5DzhwTRzrafQd0EPiu
 eYAdeNe6jn7p8A08oNrYaVLac9z4XlSVpymXjyTvs6O6X3dddfSDrz4YqwkznjMul+S0
 3pT1/KXwHLKkdpPNV0QAyNdOmMhLm/P+X4un2do/8meZKbBS3C5mEwDfvlH8b8iNAYY/
 WqXESTV/e8T3RKDPb1k4e+nRfVQ99EUkTQrqlxws/JfFCn3iDdq/x3UjCwNvmxSRHI+x
 RKGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9azSrxuXHIeUf6wYsTMKK25+wAbiFpa35VufvdZ/eP5in1MwgsZFzspdj9oyiHFdOH4TY+sVEkNNFfL1vZ5BP/kYqMmY=
X-Gm-Message-State: AOJu0Yxb36/MAMBmc2VFHI86H6MmqByUtlO2r80le/W+zfYD4WngiPAO
 rihjIEamJ4kB7x1CwK8cgDTmh3yhzvNqqsJsUyvVuiak0I5+DNfCzy3EKokJO6b7YIHsZHcPshj
 vHhMPFsEvI99B8ds3M5VQ8xv8w24EjZBycbw=
X-Google-Smtp-Source: AGHT+IEglcq+8xFDB3B9NRFeqQtm9cmb+3P7iAoivnQqgFM9iM3fhVD54hxy8WagzKed7UFSgrtHkcQuxF86tfXYo8o=
X-Received: by 2002:a05:6122:200f:b0:4ca:615e:1b61 with SMTP id
 l15-20020a056122200f00b004ca615e1b61mr4996667vkd.10.1710910536132; Tue, 19
 Mar 2024 21:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240314175704.478276-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 Mar 2024 14:55:10 +1000
Message-ID: <CAKmqyKMYiA3CoE4H=YMho-Udzji=kv=w_5N56RM4BEyN-Y0osA@mail.gmail.com>
Subject: Re: [PATCH for 9.0 v15 00/10] target/riscv: vector fixes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, max.chou@sifive.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 15, 2024 at 3:59=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> The series was renamed to reflect that at this point we're fixing more
> things than just vstart management.
>
> In this new version a couple fixes were added:
>
> - patch 3 (new) fixes the memcpy endianess in 'vmvr_v', as suggested by
>   Richard;
>
> - patch 5 (new) fixes ldst_whole insns to now clear vstart in all cases.
>   The fix was proposed by Max.
>
> Another notable change was made in patch 6 (patch 4 from v14). We're not
> doing early exits in helpers that are gated by vstart_eq_zero. This was
> found to cause side-effects with insns that wants to send faults if vl =
=3D
> 0, and for the rest it becomes a moot check since vstart is granted to
> be zero beforehand.
>
> Series based on master.
>
> Patches missing acks: 3, 4, 5
>
> Changes from v14:
> - patch 3 (new):
>   - make 'vmvr_v' big endian compliant
> - patch 5 (new):
>   - make ldst_whole insns clear vstart in all code paths
> - patch 6 (patch 4 from v14):
>   - do not add early exits on helpers that are gated with vstart_eq_zero
> - v14 link: https://lore.kernel.org/qemu-riscv/20240313220141.427730-1-db=
arboza@ventanamicro.com/
>
> Daniel Henrique Barboza (9):
>   target/riscv/vector_helper.c: set vstart =3D 0 in GEN_VEXT_VSLIDEUP_VX(=
)
>   trans_rvv.c.inc: set vstart =3D 0 in int scalar move insns
>   target/riscv/vector_helper.c: fix 'vmvr_v' memcpy endianess
>   target/riscv: always clear vstart in whole vec move insns
>   target/riscv: always clear vstart for ldst_whole insns
>   target/riscv/vector_helpers: do early exit when vstart >=3D vl
>   target/riscv: remove 'over' brconds from vector trans
>   trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
>   target/riscv/vector_helper.c: optimize loops in ldst helpers
>
> Ivan Klokov (1):
>   target/riscv: enable 'vstart_eq_zero' in the end of insns

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
>  target/riscv/insn_trans/trans_rvv.c.inc    | 244 ++++++---------------
>  target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +--
>  target/riscv/translate.c                   |   6 +
>  target/riscv/vcrypto_helper.c              |  32 +++
>  target/riscv/vector_helper.c               |  93 +++++++-
>  target/riscv/vector_internals.c            |   4 +
>  target/riscv/vector_internals.h            |   9 +
>  8 files changed, 220 insertions(+), 216 deletions(-)
>
> --
> 2.44.0
>
>

