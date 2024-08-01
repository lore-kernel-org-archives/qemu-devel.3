Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9C8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZFj-0007Wy-19; Thu, 01 Aug 2024 13:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sZZFh-0007Rg-IY
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:06:09 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sZZFd-0006Cw-He
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:06:09 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6518f8bc182so18624787b3.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722531964; x=1723136764;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eY6Ubvv6M8lR4NWjGUMKFCdsqLroyChhBLGdXW61ziY=;
 b=kfnMEmTHKieXkB+dTpyGii4x0nBtT7eUho0X1EiylQUHjTjafhDfgdQziZ3rHeuojr
 AnnloF1IiHGXDtmjqCP2VzCJvpKtzehe+NLBPT9h6HrlezlKaJiATPFUfw7vQy4xECJn
 TLBRvstoKFIJvVClysaOmNA7klxXvihzhZZhX1hVJdbjOJMPehyjzmNkIkUSsX4wmvjO
 rBu9HBPkJ2Ks+2nDVxBPhqze3X32gZ3EwwNFtzGJhDG3/fEiepWS3W5JqGLM9vlc26GC
 mubK1mWdE7HlcHOhB+lP/8axhBZxIiQhXddUFmipnTs7BfmVC+iSmuT4ZM55eIRO0Kdn
 J5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722531964; x=1723136764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eY6Ubvv6M8lR4NWjGUMKFCdsqLroyChhBLGdXW61ziY=;
 b=pgOLi//r0Wg0fnihQxGtBv9nIWjQIRbcTyheTWUYr5Hnzvltt7BF4bsr/WmYVorQz+
 2z2G50EjV/NNRH0y4kMwHtg91PIhzfJKg/WMIHlNlqPF+C7+bxc0TpsEEks6bPyww9hN
 es4dlk4kJ/EQPzkxXpY/yfFTrnMgqWbQAD5HLyYeEBSTaiL6wzaJmDPNSMdMkeXorxER
 1jBZXgNo1ulQOORwfPfnzZ5aRo2/PklvWPL0qmx5Nj1OBHAYxOZMEUwdPR1Pv5vOAvxm
 ol6zqxGTLKO3DmNnw9SvPPgRqTWkcOUCyi+7B371c0d1rR9qytf8Y2k87+da7Dh/MRTJ
 UCWw==
X-Gm-Message-State: AOJu0Yw8SMPwbnSReAg5fU6jJgQ7KIWzdyCDYvyOShqydrCA4eJrFn2Z
 tEGtAUfxSlEQvWkgWFpl4eU9SM2nm0/O53NAh6Gdk9nXkNoH8PJo3L1Y+dihSrFbYw/n3+uI2wK
 NQlGDOnLzR7CNl2HkH4gvkfRAp3tm1jH45IMNFQ==
X-Google-Smtp-Source: AGHT+IHpy7NrG+YFFdyiD3Qr8RwGzFNQKnP3LaDQceE9uorTp19Cf8dJBpUt4ru0YCtYft99KTlw8WvogeSPJkGCwFk=
X-Received: by 2002:a0d:d084:0:b0:61a:e979:427e with SMTP id
 00721157ae682-68851ae081emr18208337b3.11.1722531964065; Thu, 01 Aug 2024
 10:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-6-debug@rivosinc.com>
 <ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org>
 <CAKC1njQJiNHT1b2jD009zsNeXrUZ9OG2S4VTeFmnAS4c_f-kAA@mail.gmail.com>
 <0cbb34e8-fa32-469a-a516-4f9ac91a6eff@linaro.org>
In-Reply-To: <0cbb34e8-fa32-469a-a516-4f9ac91a6eff@linaro.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 1 Aug 2024 10:05:46 -0700
Message-ID: <CAKC1njQqfOrzodxSYK93vQGb_g0oQA4EK7_q-zi4bW5pERvv2g@mail.gmail.com>
Subject: Re: [PATCH v2 05/24] target/riscv: tracking indirect branches (fcfi)
 for zicfilp
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=debug@rivosinc.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 1, 2024 at 2:12=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/1/24 16:59, Deepak Gupta wrote:
> > hmm... you've suggested below to use `aarch64_tr_translate_insn` and
> > check if it's the first instruction.
> > and put the check there.
> > In that case I won't need FCFI_LP_EXPECTED TB flag.
> > Then I would rather use it as FCFI_ENABLED TB flag.
>
> You will need both bits.

I was thinking of following logic and wanted to run by you to check if
I am missing something
obvious.

---Recording fcfi_enabled in disascontext---
Add a FCFI_ENABLED TB flag which gets set (or not set) in `cpu_get_tb_cpu_s=
tate`

And `riscv_tr_init_disas_context` does
DisasContext->fcfi_enabled =3D extracts FCFI_ENABLED TB flag.


---Set elp on translation of indirect jump/call----
translation for jalr (instruction which triggers elp state) does following

trans_jalr:
if (DisasContext->fcfi_enabled)
    env->elp =3D LP_EXPECTED

---Check if first instruction is not a landing pad----
In `riscv_tr_translate_insn`

if (first instruction of TB && env->elp) {
      if (`insn` is not a `lpad` (landing pad) encoding)
         raise_exception();
}

---label check embedded in landing pad instruction---
In `trans_lpad`

env->elp =3D  NO_LP_EXPECTED
invoke a helper which will check embedded label value against value in
ISA defined register (x7)

I think this will work with just one TB flag (FCFI_ENABLED). Let me
know if I am missing something.

>
>
> r~

