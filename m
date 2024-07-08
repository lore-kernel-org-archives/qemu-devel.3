Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB2BC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 04:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQfoU-0007fP-Tp; Mon, 08 Jul 2024 00:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQfoP-0007YZ-Qj; Mon, 08 Jul 2024 00:17:15 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQfoO-0008Rz-7j; Mon, 08 Jul 2024 00:17:13 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-81014df3028so1010150241.3; 
 Sun, 07 Jul 2024 21:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720412230; x=1721017030; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgS+tC40bbSUGfrHjNXrIbzvCY5/v5MKld6YKCNg/o4=;
 b=gNt3ITjGdiU38G4Ci/HEkQeCql2QwXEDSIgHLRvOcnhNAOF3Zy0l42GH9s6cOCloug
 sBbd19OHxhK64DBhbddSmqkNA1rsxa7i6ww1dfF9hfQWh8LT8ODPO6cGKZGURQvrATQq
 FWUSLpvjzGynnjBiQaVG9PjzB+yiGGEP7iMndIjorUys5SfOda09tPJpQcuCSy38y8uh
 /f/WwpVi3roQPRqLwk/eDrXsaDVWwrxB/tzE8ktJXKeCngBOF0nSsR7SprNyulFRumTJ
 G0MRDJiwQq01YkKown0ve2oCz4KPgp03HkJ4EjrJNltcIQUgPsT2gvHwnNh25zh+tQ+s
 QE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720412230; x=1721017030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgS+tC40bbSUGfrHjNXrIbzvCY5/v5MKld6YKCNg/o4=;
 b=szLAc5BD3EfVMzW4dYNqJu2G8CRIc07Rb8lBeQOdJI33ngzFRNdDtyDQDO9/GXXRLt
 ZwYkeFq7MprnzqBHZC+JP0n32e6QVuxuDDhhUbHHxHrS4q8y4pXIglAOMdyHaekDU3m6
 ktNhyt4GBlFwNVSvV6+te0WnuyqMrbLcKC+TTWH+uxhNLhdoP+rSFQ8arhUdW+gIGOHn
 fCItS9i6GpzdhxlX1K4Dqe0czub8tczaYOobJLKeYsb5fX4yle38MpH5DbQqYU+ZqhUm
 k3hh0aN/6A8HBf8iZyexLUi3As6XvLtBI4X6BwnuUCY3cHoXOwcWhki2+2z5CFapMbDR
 nrPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcaYscu/G8z9q/WPg/BtvqBek99zjIlIm5Dl9tbfuoj2FCEpap8YUa403Ob8uSn2blPN3KFioqdO3m35o4E5XDkz5ZXhk=
X-Gm-Message-State: AOJu0YwnBzRgo3B90WYwA7bHhNTaz0x6ths6GtfzB5LxSAktUFxl3qOD
 a+WMUEtRtvcq89yV9xficiFEsgzTBxdMFOiatcE2okCQTecRTANFsGoqaxWIwcudIpVMM4dy03P
 X3SFyW7nRJopsaY4KKfRGZA7a0YQ=
X-Google-Smtp-Source: AGHT+IE4Q+3mBX9WqJhDadGOTA39TEpJx09cg3UsUtNaBmYnwy16b13gylARmr+Nxnf4M6zx6vnS9n/kQaLzwfHn3Ec=
X-Received: by 2002:a05:6102:21c9:b0:48f:90be:78a8 with SMTP id
 ada2fe7eead31-48fee871505mr10017922137.9.1720412230401; Sun, 07 Jul 2024
 21:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240628094003.94182-1-jiangzw@tecorigin.com>
In-Reply-To: <20240628094003.94182-1-jiangzw@tecorigin.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 14:16:44 +1000
Message-ID: <CAKmqyKMUa+_puqeEBA-KqxrvYgdobrqddnhYftrCpxYTTyU9=w@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix the check with vector register
 multiples of LMUL
To: Zhiwei Jiang <jiangzw@tecorigin.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Fri, Jun 28, 2024 at 7:46=E2=80=AFPM Zhiwei Jiang <jiangzw@tecorigin.com=
> wrote:
>
> In the original extract32(val, 0, lmul) logic, when lmul is 2 and val is =
v10 or v12,
> there is an issue with this check condition. I think a simple mod operati=
on is sufficient.

Overall looks ok. Do you mind updating the commit message to describe
what exactly this fixes (as in what issue you had) and why this fixes
it

Alistair

>
> Signed-off-by: Zhiwei Jiang <jiangzw@tecorigin.com>
> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 3a3896ba06..e89b0f2b1e 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -118,7 +118,7 @@ static bool require_nf(int vd, int nf, int lmul)
>   */
>  static bool require_align(const int8_t val, const int8_t lmul)
>  {
> -    return lmul <=3D 0 || extract32(val, 0, lmul) =3D=3D 0;
> +    return lmul <=3D 0 || val % lmul =3D=3D 0;
>  }
>
>  /*
> --
> 2.17.1
>
>

