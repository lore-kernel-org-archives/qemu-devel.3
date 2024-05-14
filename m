Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0123C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 06:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6lT8-0007PY-0I; Tue, 14 May 2024 02:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lSo-0007Cl-3r; Tue, 14 May 2024 02:16:39 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lSl-0002SF-DP; Tue, 14 May 2024 02:16:37 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4df1cb51866so1353709e0c.3; 
 Mon, 13 May 2024 23:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715667394; x=1716272194; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2SNVns/DbZGXiQ13OOIqVkxGTAHh1V3gyQ9FzsBB9w=;
 b=fnWUEh5z8liZ/ECUzxI1T8nsET41b1CGX6APOHeBjH5Z7l9dNgp9tBQ9bmBu16oKts
 L40iXou1MCBXcow6ZuxefQvK/y9NARmjjmADWgb+w9fOYm45OihAT6q0y1XqgVojKAhf
 /Ld6QWqddgMC2rPwuWBL3Uogus+ZAq18Vj6hcbmsm5CQ7acTnSXL5uPG+9J8aPZ41JLL
 gVGkVOzre1rKrfg4HI6rZzzEtx+nXFwF/uA8OMfZpRZGk/1o7xxeyjmYGOvAWbb/yObb
 bEZULRKFGh8WRY1TwdKm+0+JFzRRmn1XHi39YkXZQEBx4etbq/ViaRhobtUgs90BT8xq
 NtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715667394; x=1716272194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2SNVns/DbZGXiQ13OOIqVkxGTAHh1V3gyQ9FzsBB9w=;
 b=xR/WOepE9izhPAdXG1kjjIKh87aId+ILppbH0vb183oBGRHixRndynPvTnx/s2R2Aj
 icaniFTe3PpeoBgJ9DbrL6IMFsfV9qDbW8OKl5B+Hr0O9aecYKzfKqGSRSnhzQqcFivm
 2YmZnBa6XCfXqRfQjLqYsQFD7dgAwLNEUWvVSVhDWOzSh82W4uMTquLuYWjbEB3z5wrR
 8jJAEfZMY6QET1uXD8GXZWYkprb+jvEDiVfVNf7dOIpJniRMtbJWqYrPX3/foVJ3x77U
 anivVyuH+8YDZIWEpCWvObb0OM4wD+wtI0CVdtaGQRH1IgXjvXF0v/XI4LzeVXGvspVp
 cJPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeRYyZD4OqyZvl+8OvnyrBVhFndm5U+T+oX3zR73Qj/cmy8h9ELAcUdzA4Hq3jsLUDuiquVRLnhFwQG1ce/nEF+ChlHHhIDQF5tDUtb43vs8RkPnE1oEYW7wW2DQ==
X-Gm-Message-State: AOJu0YxXvBfC8ABh/lCd/Ejyz8VuiCFfN2afQ77U0pZdTy6UC7NLNuDa
 iWIvJ8MjoWRZLcRqzEIDgRQkMRfiynpnrE9chXI4ix28BLY+xujQbiCbAD0W2OZXOouKEML1QIZ
 JR5seeYJhHIXRDMmn7jGy9twQcCc=
X-Google-Smtp-Source: AGHT+IEYlP/IdeutQEHdWRaxEYw4R2zK/T1CLhzJ8U2xaiOICpuOgLPjeIVZUXZb+xXrj11qs/GT3+Cti43+aWmA+Co=
X-Received: by 2002:a05:6122:369c:b0:4da:9d3e:a7df with SMTP id
 71dfb90a1353d-4df882c0793mr10028468e0c.5.1715667393851; Mon, 13 May 2024
 23:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <ca275792-36c9-4ccd-b7b2-24d9fd837b24@ventanamicro.com>
 <20240503103052.6819-1-alexei.filippov@syntacore.com>
In-Reply-To: <20240503103052.6819-1-alexei.filippov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2024 16:16:07 +1000
Message-ID: <CAKmqyKNgYPqtSaTdNkYcbErqv8+0LW9k5cyf9e46RosZ1W0Fhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: do not set mtval2 for non guest-page
 faults
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, palmer@dabbelt.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Fri, May 3, 2024 at 8:32=E2=80=AFPM Alexei Filippov
<alexei.filippov@syntacore.com> wrote:
>
> Previous patch fixed the PMP priority in raise_mmu_exception() but we're =
still
> setting mtval2 incorrectly. In riscv_cpu_tlb_fill(), after pmp check in 2=
 stage
> translation part, mtval2 will be set in case of successes 2 stage transla=
tion but
> failed pmp check.
>
> In this case we gonna set mtval2 via env->guest_phys_fault_addr in contex=
t of
> riscv_cpu_tlb_fill(), as this was a guest-page-fault, but it didn't and m=
tval2
> should be zero, according to RISCV privileged spec sect. 9.4.4: When a gu=
est
> page-fault is taken into M-mode, mtval2 is written with either zero or gu=
est
> physical address that faulted, shifted by 2 bits. *For other traps, mtval=
2
> is set to zero...*
>
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes since v1:
>                 -Added Reviewed-by tag.
>  target/riscv/cpu_helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e3a7797d00..484edad900 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1375,17 +1375,17 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr addre=
ss, int size,
>                                __func__, pa, ret, prot_pmp, tlb_size);
>
>                  prot &=3D prot_pmp;
> -            }
> -
> -            if (ret !=3D TRANSLATE_SUCCESS) {
> +            } else {
>                  /*
>                   * Guest physical address translation failed, this is a =
HS
>                   * level exception
>                   */
>                  first_stage_error =3D false;
> -                env->guest_phys_fault_addr =3D (im_address |
> -                                              (address &
> -                                               (TARGET_PAGE_SIZE - 1))) =
>> 2;
> +                if (ret !=3D TRANSLATE_PMP_FAIL) {
> +                    env->guest_phys_fault_addr =3D (im_address |
> +                                                  (address &
> +                                                   (TARGET_PAGE_SIZE - 1=
))) >> 2;
> +                }
>              }
>          }
>      } else {
> --
> 2.34.1
>
>

