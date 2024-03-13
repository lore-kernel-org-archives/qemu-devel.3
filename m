Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CE3C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkK6s-0006sy-8H; Wed, 13 Mar 2024 04:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rkK6q-0006sN-Kh
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:37:12 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rkK6o-0006La-OK
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:37:12 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5e4613f2b56so4597870a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1710319026; x=1710923826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OK61FivsCBElmpmwVI6MTI8ERfhHOBNDTs4an9AI+pI=;
 b=Jbe6E8r+/WVVhlK8Y9UFzK7ijqxCLFcsnu37fPPRMkacViY2uOcO+syFTkhL1Sq0bs
 JTn8Bsba9lPLX+pYXk8gTTqo8hQtyVY3cFBU325R1hGbfKRS5oXP5jvGbFCvnHGfqsik
 ulZqnUkOUDJsUq+qHYqNyWIyjr6IQ+9PnfIqWjXE43U4hqUkMBKXbI6X6ZsJArDS2hO3
 DKbc8ACXZ4XSddEihoQuH7d4SxHv6+YIwu/XtlRaBQZAxRymQJ2qPlfha6+kJzu+sFWW
 gTU63ksRHwQQhBYcnO1CNVKyMpkZVuqqXQF2ovypdE922blMzoBw0+CWQ+Q161UZw4az
 lc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710319026; x=1710923826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OK61FivsCBElmpmwVI6MTI8ERfhHOBNDTs4an9AI+pI=;
 b=JE6krQVJxpnkVCEhJOCQFGSViwYtmJ2nKNipv9I6PWJMtZsSnHt4/aPXWFo3nkIGU8
 da6JnNiateoL9fFjb3FmMEaY4LhQvSsd60HQWocept2UgmnZQ5u1mCaRH7dsDyG5Lkvl
 mYSVKDruEa8GUGNEa3yYgqCAXTVGeMgs46bVenn9FMm9+DGdCZpqsbLt8Di8Oo97Zh8u
 Z3VLLWUnYhFUzOU1o8tl9R1ytMpvhNPN62R9762j7/j8nFqDRC8EJHMnV7osciA/UZTY
 qjwehdmyAm9xSnRD20JLjSShGb/ktlFAzb4GoHqkj2ZVrgG7HiganrWXVa4bCjVT7n58
 y8Qw==
X-Gm-Message-State: AOJu0Yy7VzgbwwgGyBFXUge/v2VImMd+be0tPUx2h48ZY7U5mGiaWJfz
 fmpzinZr3reMBWV7GLM1xH1qje83jXqhTZJPqcFVcqAKX7aZ3wBUd7uGX9Y+kFbn+LGnXdgLa2N
 3xNzBNifwDzW/lMG/UuMqLaUt4/vpSrE+cJck
X-Google-Smtp-Source: AGHT+IEv95omhyPb0xTbMhrK27GyWzsnfBe8Fp6rBiKId23nRSD7GE0ZOJZ1wWDRnPlEuabQUpiGRY+NlN9gLh1sh/8=
X-Received: by 2002:a17:90b:60f:b0:29b:af8a:d9fb with SMTP id
 gb15-20020a17090b060f00b0029baf8ad9fbmr9046235pjb.12.1710319026564; Wed, 13
 Mar 2024 01:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240312203214.350980-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240312203214.350980-1-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 13 Mar 2024 09:36:55 +0100
Message-ID: <CAJ307Eg7rSEh0_L1pTHu+GXh0tAiY7uUbv0iDpaO=KgGx6_w2g@mail.gmail.com>
Subject: Re: [PATCH for-9.0] target/riscv: do not enable all named features by
 default
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 12, 2024 at 9:32=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit 3b8022269c added the capability of named features/profile
> extensions to be added in riscv,isa. To do that we had to assign priv
> versions for each one of them in isa_edata_arr[]. But this resulted in a
> side-effect: vendor CPUs that aren't running priv_version_latest started
> to experience warnings for these profile extensions [1]:
>
>   | $ qemu-system-riscv32  -M sifive_e
>   | qemu-system-riscv32: warning: disabling zic64b extension for hart
> 0x00000000 because privilege spec version does not match
>   | qemu-system-riscv32: warning: disabling ziccamoa extension for
> hart 0x00000000 because privilege spec version does not match
>
> This is benign as far as the CPU behavior is concerned since disabling
> both extensions is a no-op (aside from riscv,isa). But the warnings are
> unpleasant to deal with, especially because we're sending user warnings
> for extensions that users can't enable/disable.
>
> Instead of enabling all named features all the time, separate them by
> priv version. During finalize() time, after we decided which
> priv_version the CPU is running, enable/disable all the named extensions
> based on the priv spec chosen. This will be enough for a bug fix, but as
> a future work we should look into how we can name these extensions in a
> way that we don't need an explicit ext_name =3D> priv_ver as we're doing
> here.
>
> The named extensions being added in isa_edata_arr[] that will be
> enabled/disabled based solely on priv version can be removed from
> riscv_cpu_named_features[]. 'zic64b' is an extension that can be
> disabled based on block sizes so it'll retain its own flag and entry.
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg02592.html
>
> Reported-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> Fixes: 3b8022269c ("target/riscv: add riscv,isa to named features")
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 40 +++++++++-----------------------------
>  target/riscv/cpu_cfg.h     |  8 +++++---
>  target/riscv/tcg/tcg-cpu.c | 14 ++++++++++---
>  3 files changed, 25 insertions(+), 37 deletions(-)

Thanks for the quick patch !

Tested-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

