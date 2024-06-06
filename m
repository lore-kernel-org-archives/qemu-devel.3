Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2492EC27C53
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 01:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF2ND-00044q-Ma; Wed, 05 Jun 2024 21:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sF2NC-00044a-4M; Wed, 05 Jun 2024 21:57:02 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sF2NA-0004yq-FE; Wed, 05 Jun 2024 21:57:01 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4df550a4d4fso142863e0c.2; 
 Wed, 05 Jun 2024 18:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717639018; x=1718243818; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SP+vVrIwRCRG7mN+7o5EnuHdYeiRLLD5qwMlqFx44Yc=;
 b=Cw/xMurmi8agh+fFyDGeTvSMvVb9WnJc5ABJadLyr25uboocIy8DTGwgJb9Zb+7hnT
 oTDLZoNBj3M4wcE88z7bMw07+OwUqNjZjer7j3FAnjzH7rUjfpF38duWQOI5nPyNmC+o
 kAspR9IBsejdhoY2W20QariITfRSA8SL9tK3fmY9XT41FDCdYZMpUlKdsIWC1aWCtmP7
 KymngL2xr2thtyvx+fo6ooZMRptAubTvvNl371EoI381ol1KT40qUSulC9vlcJn5CaL2
 VCGw2+/yLdnfRwNt+tP0iReOfj8fmo1GUqCH54Q9SGKsW4BCZJbOqSjtvB79i+ompigW
 ghsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717639018; x=1718243818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SP+vVrIwRCRG7mN+7o5EnuHdYeiRLLD5qwMlqFx44Yc=;
 b=duHBgsNMP1cLl/4THVTG+qzoIubmbpdWDOuLjNQscrS/nHOfeTCjmI6qHReUBH/7zF
 zD/VDJ9jxgDfWnQnc1rxh07arIJbJznR/8BzwB+4HIKG07/ktPNpG7CVp9aWffGuBve1
 joHc6k3x9ImiZ4QsMWsfH3vz2tXkQj2ked13n3/VaZVCsLdWuF7X21wyPrdclQHkdqfM
 i3dnPfVfwI2LiZOnbTd6zalGIACo4Jus00H9uQkLPXOWD0HjFaz3ihq5xE4cy+kBTCGQ
 XeqHQzfT7N/VwkNlnyKEbCSOXoixpKedTiCSmVqh5bXS43SQBYn2AynX4guPS4fCOjoW
 CkNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPlFFaw9i6GjTgXP4t1NoHcy5XDIkfECqQlyrd3XC4cSDJ1AsJTlnqqlCRbhMMN+6NgptBPzA6NrnJxWatjAGnEJsjvsw=
X-Gm-Message-State: AOJu0YzHXyS9z3EsOGTycagSru4UuPaDGQrI9zI6OIopR+heJGLC79b+
 1x3tEP/k/Cx23Vo3v0MwKtxpKRubMsu4ktrPraTDZWPz4qBgq7bgx1mBhks3vA1XZIOjDs8S3Jz
 pArh1sYThlRvpk4kC3Qn22GEErPA=
X-Google-Smtp-Source: AGHT+IFI+O5yLJAOj8GKdBSd074WkX2JHGTdZ7/PKnhGbBDupebrxr+pmZ2VI++BlXGs8hV+LkoNGF3kyZlXfwQw7/A=
X-Received: by 2002:a1f:f20c:0:b0:4d8:7339:4c35 with SMTP id
 71dfb90a1353d-4eb3a4ec692mr4369778e0c.13.1717639016899; Wed, 05 Jun 2024
 18:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240606014501.20763-1-duchao@eswincomputing.com>
In-Reply-To: <20240606014501.20763-1-duchao@eswincomputing.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Jun 2024 11:56:30 +1000
Message-ID: <CAKmqyKPM2H7CWdO=NPEwiZhuLS7SENr_s9EvXx2cQDxw=AFe2w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] target/riscv/kvm: QEMU support for KVM Guest Debug
 on RISC-V
To: Chao Du <duchao@eswincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 ajones@ventanamicro.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, duchao713@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Thu, Jun 6, 2024 at 11:50=E2=80=AFAM Chao Du <duchao@eswincomputing.com>=
 wrote:
>
> This series implements QEMU KVM Guest Debug on RISC-V, with which we
> could debug RISC-V KVM guest from the host side, using software
> breakpoints.
>
> This series is based on riscv-to-apply.next branch and is also
> available at:
> https://github.com/Du-Chao/alistair23-qemu/tree/riscv-to-apply.next.0606
>
> The corresponding KVM side patches have been merged already:
> https://lore.kernel.org/kvm/20240402062628.5425-1-duchao@eswincomputing.c=
om/
>
> A TODO list which will be added later:
> 1. HW breakpoints support
> 2. A 'corner case' in which the debug exception is not inserted by the
> debugger, need to be re-injected to the guest.
>
> v3,v4:
> - rebased.
>
> v2->v2 resend:
> - add the type conversion in patch #1 to avoid warnings
>
> v1->v2:
> - squash patch #2 into #1
> - check the instruction length from the tail two bits, instead of passing=
 the
>   length information by parameters.
>
> RFC->v1:
> - Rebased on riscv-to-apply.next
> - use configs/ definition to conditionalize debug support
>
> v2 link:
> https://lore.kernel.org/qemu-riscv/20240528080759.26439-1-duchao@eswincom=
puting.com/
> v1 link:
> https://lore.kernel.org/qemu-riscv/20240527021916.12953-1-duchao@eswincom=
puting.com/
> RFC link:
> https://lore.kernel.org/qemu-riscv/20231221094923.7349-1-duchao@eswincomp=
uting.com/
>
> Chao Du (3):
>   target/riscv/kvm: add software breakpoints support
>   target/riscv/kvm: handle the exit with debug reason
>   target/riscv/kvm: define TARGET_KVM_HAVE_GUEST_DEBUG

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  configs/targets/riscv64-softmmu.mak |  1 +
>  target/riscv/kvm/kvm-cpu.c          | 89 +++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+)
>
> --
> 2.17.1
>

