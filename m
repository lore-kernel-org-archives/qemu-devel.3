Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ABAC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhgZ3-0003bo-Ck; Tue, 05 Mar 2024 20:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgZ2-0003bc-1K; Tue, 05 Mar 2024 20:59:24 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgZ0-0003oR-BZ; Tue, 05 Mar 2024 20:59:23 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7dacc916452so216638241.0; 
 Tue, 05 Mar 2024 17:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709690361; x=1710295161; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGrJ2BF1+ey8NvHOUwfR5vFjUWMNc1LkpEO3oRTYOq4=;
 b=IvNEmnM7/t2y4TIgBAiUBsN9BUpHe5zkiIt7vMkfM+EVXtnrbOiSkYzeVeJTFt+v0O
 wo6X1Ob8F6GxdrzdAZLyv87UA9/SJvnmFQlYGqqnnzUyEynQbyezLiRKzUuBlUwB9PA3
 sYg3Z0shEKDFLV6DsFONF7bbVSdWUbIgPNuJ6k9oKpmAActdVKIq3XQh4IY3NUpkCDsw
 JUH0jWdVdhKKe5uw5W17BnmgeiEtyGp4yNj890wfsnneJ3UfCWTkfHQ3TEQ+ShpNaR+Q
 eRzuuJyG7valNKjmtwhASvkWBEZdbsshleyiCGyLl5yg59Ovq1vuOKXksZKEUdUqSQmx
 MJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709690361; x=1710295161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGrJ2BF1+ey8NvHOUwfR5vFjUWMNc1LkpEO3oRTYOq4=;
 b=ey6nNPTzKFVRc/vBeulpGzNfmsFa5HN92bKaJvj9kLK8sNGvsMDyZ6gtKtYgWWwsgl
 ZYjyojO4P86iRyEH9KQc7w6tP1ODQUTxxu00VOKgV1OFSpw68tJxlU2VH5Ogau8gSEiR
 atiOQDaW93yN+rjxMDn6WJSvnPzYjuxT1/3/7X8n85+OgLpLjULbKdQoW8ZOFMyBigWy
 taz9WXUylMDxNTeu3fISkLOgv4M7JXciBEybD9cZHTBJJmmKTY7x/rW9zhSKGY/bZG69
 ppkF1oxlEkrPkl+FHaUSWNp0CUqJ/ZHB8jisPYB0ufpYQOYIGXtQHqBlK5IMt/+UNEhK
 YJBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdaQtLQ/GFMOo2RfTS5IlplEeHAOqbbBL6Bws0iuC0pXe5oUIaw1ifPUZPknhP5J5tF5BKDGJ6pkSfaKs5ymaF/z3C3xY=
X-Gm-Message-State: AOJu0Yy8sDXb5oXJQBQBDOz58LV9DDhKhzPMiF9oadgAI3r6Zq4RsvST
 AR/u3uLpJzfPSc3gXdXC4yIvGtdcu5R95e+pTFXQh8AKx3AC4a8r94q/tHxJ8FXZl209PGpQ8sm
 vRNeSjUdCQQCcUDhD+ElVip1Ar10=
X-Google-Smtp-Source: AGHT+IF7QtMrMWpP8mbAgP8ArZPqZWRVaRB1WJnNPJojl1Oq7+rc6wu9hnqyn9j0DBekD1x7IP23tY/RogrTG7VMU2k=
X-Received: by 2002:a05:6122:2a0d:b0:4d3:3d2a:6553 with SMTP id
 fw13-20020a0561222a0d00b004d33d2a6553mr3649965vkb.14.1709690360940; Tue, 05
 Mar 2024 17:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240221213140.365232-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:58:55 +1000
Message-ID: <CAKmqyKMPgyE9pEQ2d8L9E47zoXudGfb=ges0q6RoA3NGb_vDFA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] riscv: set vstart_eq_zero on mark_vs_dirty
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Thu, Feb 22, 2024 at 7:33=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this version 2 new patches were added:
>
> - patch 5 eliminates the 'cpu_vl' global, and do_vsetvl() now loads 'vl'
>   directly from env. This was suggested by Richard in the v5 review;
>
> - patch 9 does a change in how we're doing the loops in ldst helpers.
>   This was also proposed by Richard but back in v2.
>
> Patch 9 is not related to what we're fixing here but let's fold it in
> and avoid leaving any code suggestions behind.
>
> Series based on alistair/riscv-to-apply.next.
>
> Patches missing acks/reviews: 5 and 9
>
> Changes from v5:
> - patch 5 (new): remove 'cpu_vl' global
> - patch 9 (new): change the loop in ldst helpers
> - v5 link: https://lore.kernel.org/qemu-riscv/20240221022252.252872-1-dba=
rboza@ventanamicro.com/
>
> Daniel Henrique Barboza (8):
>   trans_rvv.c.inc: mark_vs_dirty() before loads and stores
>   trans_rvv.c.inc: remove 'is_store' bool from load/store fns
>   target/riscv: remove 'over' brconds from vector trans
>   target/riscv/translate.c: remove 'cpu_vstart' global
>   target/riscv: remove 'cpu_vl' global
>   target/riscv/vector_helper.c: set vstart =3D 0 in GEN_VEXT_VSLIDEUP_VX(=
)
>   trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
>   target/riscv/vector_helper.c: optimize loops in ldst helpers
>
> Ivan Klokov (1):
>   target/riscv: Clear vstart_qe_zero flag

Looks good! Just conflicts with the Ztso extension support that was
recently added in the RISC-V tree

Alistair

>
>  target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
>  target/riscv/insn_trans/trans_rvv.c.inc    | 294 ++++++---------------
>  target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +--
>  target/riscv/translate.c                   |  11 +-
>  target/riscv/vector_helper.c               |   7 +-
>  5 files changed, 104 insertions(+), 256 deletions(-)
>
> --
> 2.43.2
>
>

