Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E665DC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0QC-0004Sq-Bk; Wed, 05 Jun 2024 19:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sF0QA-0004SP-Up; Wed, 05 Jun 2024 19:51:58 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sF0Q9-0000KG-BD; Wed, 05 Jun 2024 19:51:58 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4eb2b07f660so126996e0c.0; 
 Wed, 05 Jun 2024 16:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717631515; x=1718236315; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/otAz/3UoNcr66COi2pXQHUN3MAshJlRuUFHqqaOs0=;
 b=lEAA5pke6o9HQ1OyFpgk+hBHyx5a1CoE62oFU5k5036XL4vOyIdybJfdmSUFVAM7GP
 r8zjDSGBVI9q5iJE9RCs0PNXJeWoEBzshp9k0QLr4a1KwkhpRVXTrltxQFOZR885YRdf
 IiNYBUQx8FEEfSQ8iVmUDIG7R2px4typdABrYTTuhR7MnDuxhzbTyibxq7Vayt9icLOe
 HPjmrS/pBxO6fsz3NNBl1q9QQ5Lhixwcx7cKpaElKuiYsVG1aU8n1+8bd9cZ+mLBvl2w
 2JGfJ6cx0lgrB8ZsFjzBU4HjtecOQs03jLN/otvy4gbVh1zTjNp3E0m612++hdqeRUUi
 Wkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717631515; x=1718236315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/otAz/3UoNcr66COi2pXQHUN3MAshJlRuUFHqqaOs0=;
 b=n+uHirvuX79L8t1DXG2iqkR267ju+2TUHt+oQWXI+rkBCAw7fp4p+1mYUukLoaD5tV
 y/oUOCVaHec59ibjsAJXwKu0LKyx099H5RCoyEdXqOzRSVJCDJrtP/cYqdb04pBTZDAa
 nL+lWgd1VyXq71oLRsflhL8/QBrc9KrfCImMzKwvX3iRN6IlbqNxsbCQk+1ZhtR+qh9B
 Vhc8AGyVkK5YKdWt3ljEtEjZmvd5LdxCFSJF1yLe/nSljJCsh1X6czM7dijdVn6juAbO
 fKXgMt22gGBZ6ftvI/RKtyq+tF+f5EvWEsetTdYdDsZ120z1CclpsxR6Y8fCur9WDcNZ
 auHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/S9ny1uIqzVZUUQnil3q9Q7GyOsD8p93XSpFQktqxS+lYg2CWgy/6zh7djRR4qBdpS6zU+htZyYtN4SzIfn/pA6Ovano=
X-Gm-Message-State: AOJu0YzYgQ+AOZb1o7l+IfEBgm8WOhsxrIRMWIfDvBhqecLWqQ68dZoB
 NMDBptQ/eafZwC0cCdAvizk1KvnHgVIlAzUJHxkFjBs7yWVYjfnWJuLmY+CloAdKZQtopAJUbS+
 BzQrRg9XUN6LtrTm/DyTWUb34GDI=
X-Google-Smtp-Source: AGHT+IGIm7QNkfb8hZiMWXeJYAj/y4lnWIZu4ebxbaGgfzbj6Zi2yi1/kJ4ZQvbSGEl3DTS5pYbCanY5IcabYKTQ5Nk=
X-Received: by 2002:a05:6122:25dc:b0:4da:ced8:b09a with SMTP id
 71dfb90a1353d-4eb3a26beefmr4174896e0c.0.1717631515500; Wed, 05 Jun 2024
 16:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240605025527.11711-1-duchao@eswincomputing.com>
In-Reply-To: <20240605025527.11711-1-duchao@eswincomputing.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Jun 2024 09:51:29 +1000
Message-ID: <CAKmqyKNL5xtB-XPqC1Yma6v7_T=dFp1edDmf6oE0dTr5nctd0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/riscv/kvm: QEMU support for KVM Guest Debug
 on RISC-V
To: Chao Du <duchao@eswincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 ajones@ventanamicro.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, duchao713@qq.com
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

On Wed, Jun 5, 2024 at 1:00=E2=80=AFPM Chao Du <duchao@eswincomputing.com> =
wrote:
>
> This series implements QEMU KVM Guest Debug on RISC-V, with which we
> could debug RISC-V KVM guest from the host side, using software
> breakpoints.
>
> This series is based on riscv-to-apply.next branch and is also
> available at:
> https://github.com/Du-Chao/alistair23-qemu/tree/riscv-to-apply.next.0605
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
> v2 resend->v3:
> - rebased.

I think you rebased on the wrong tree. Do you mind rebasing on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Alistair

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
>
>  configs/targets/riscv64-softmmu.mak |  1 +
>  target/riscv/kvm/kvm-cpu.c          | 90 +++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>
> --
> 2.17.1
>

