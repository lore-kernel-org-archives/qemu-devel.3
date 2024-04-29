Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEA6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1H2n-0005mP-5d; Sun, 28 Apr 2024 22:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1H2l-0005m3-Lk; Sun, 28 Apr 2024 22:47:03 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1H2h-00064u-CP; Sun, 28 Apr 2024 22:47:02 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7eb7f34f36dso1977937241.1; 
 Sun, 28 Apr 2024 19:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714358817; x=1714963617; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiRI/5tgmJJ+4M7kHgex6t2sUf3vRniZ+ouPkn5CWjg=;
 b=QgJyOmANtBreQTiPwBSqDZtqRV1/BekwVolv6VQ/NAtLF3F8u8stVaS7NJWrQj5RiK
 kcH0txUzn7GV93AQiocYNpKIHXWKrwYBg2nkk/JBudWFZY+oudjIVX5eQr/Owkz0mInj
 dDm8mmrL7Y0AJdAdPDiIc4ueAZekenfCywcuOUn5bYFP0eXkG/mEjvcjgocQGj/fkzeF
 ZEeFuTGDETzVGa+PBrRHV3WP34QzrilR3hEhO+Y29M9jiCasL6tBwtScB/xNd4pCi6xW
 D2smlAzgccd17f096Qxfr8JwkPFbvdSxHpy80CnKUGzy99Rwr8JAw0h0EVpwSsq71yQR
 6xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714358817; x=1714963617;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiRI/5tgmJJ+4M7kHgex6t2sUf3vRniZ+ouPkn5CWjg=;
 b=t3vLR+EiojjoKKKfS8nDEO8tlwB3eaye0njoyXUUqyr9UuTxf+I8khK0LBYq4jx2Hb
 /lvdtABFAZMApW+zwNszmO+aSVD32eer2DgA+BcXQToY1AsrishUuiE37CBr4XfdbGQs
 7GAYqcq7dEsBdifsQfG4Q5nNb60JSW9o4ELn3HHdpoQSdAOhHMR+72NzQnZdmn+DYiHv
 RRw8CsDvEq8nxE+Bs616irWJxEaa+mbahtdYJOIKWlehkern7wocc8XH4srCjI71yay2
 u4DitYQTkeq6e2zkrUr8+4VqRR/XPkQaxqRenyt1eGrwQ53Otp9EVQ19Y1uN+eqE6ma9
 jKIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAfCDVw06WYfBG9vb2gV/9359Zlqi04Eqj7tcf6NofTja7R6DeMRe2gTRuvZPn6QTKdYpgiWRM3KUQCDf9sZrzuDYDz05XOFo4Baq+ghRL8Vbkf+ObN4UPKSU2bA==
X-Gm-Message-State: AOJu0YzFPkgjdze29FlumBBtfKz2ZJeXu+cmUgprgUSHeZbXQnVoDefz
 z1uR3nPpDYjK0eLSi95q412vMNU1hqEL3j9Aw9HNDqNDtbIs15d4E99NlV8Cg8cUrmpEPQAlMNH
 lAavs++tn7G0Osrg1OKbze6gNrZaipFln
X-Google-Smtp-Source: AGHT+IEQ+3KTSn0uqOCKXXDNub20gPDnGEmDqrvg3047z7ejOf5m2jb7B47tQwRn/dJek9ytpUPunAZWcunAi6mtsIA=
X-Received: by 2002:a05:6122:a22:b0:4d3:35ac:3553 with SMTP id
 34-20020a0561220a2200b004d335ac3553mr8677188vkn.10.1714358817573; Sun, 28 Apr
 2024 19:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240422135840.1959967-1-cleger@rivosinc.com>
In-Reply-To: <20240422135840.1959967-1-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 12:46:31 +1000
Message-ID: <CAKmqyKNtCiYxJr1fONpaE9xW=E2itaZ9u2nM2aZRRT-OqV_U1Q@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: change RISCV_EXCP_SEMIHOST exception number
 to 63
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
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

On Mon, Apr 22, 2024 at 11:59=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> The current semihost exception number (16) is a reserved number (range
> [16-17]). The upcoming double trap specification uses that number for
> the double trap exception. Since the privileged spec (Table 22) defines
> ranges for custom uses change the semihosting exception number to 63
> which belongs to the range [48-63] in order to avoid any future
> collisions with reserved exception.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>  target/riscv/cpu_bits.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index fc2068ee4d..74318a925c 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -670,11 +670,11 @@ typedef enum RISCVException {
>      RISCV_EXCP_INST_PAGE_FAULT =3D 0xc, /* since: priv-1.10.0 */
>      RISCV_EXCP_LOAD_PAGE_FAULT =3D 0xd, /* since: priv-1.10.0 */
>      RISCV_EXCP_STORE_PAGE_FAULT =3D 0xf, /* since: priv-1.10.0 */
> -    RISCV_EXCP_SEMIHOST =3D 0x10,
>      RISCV_EXCP_INST_GUEST_PAGE_FAULT =3D 0x14,
>      RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT =3D 0x15,
>      RISCV_EXCP_VIRT_INSTRUCTION_FAULT =3D 0x16,
>      RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT =3D 0x17,
> +    RISCV_EXCP_SEMIHOST =3D 0x3f,
>  } RISCVException;
>
>  #define RISCV_EXCP_INT_FLAG                0x80000000
> --
> 2.43.0
>
>

