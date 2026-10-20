Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43526606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UIws4tEP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBJ8-0005gM-VN; Tue, 20 Oct 2026 10:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJBIn-0005b5-PE
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:59:01 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJBIi-0003UQ-C0
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:58:56 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c2acc1e170cso491680666b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 07:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792508331; cv=none;
 d=google.com; s=arc-20260327;
 b=eM9IjvCr/d5CaIhEWjn/zJIBxOCA8296pDxyLe1lW5M8JHVfg9dFVM+N233bPbJR6S
 RscdwEW+R7VuC6AF/gDKv7DIMYCL2uhf1jBci81zYfFOyaZn3musmgHobKY7G+MJ9Lod
 6FNB5Nau+pXskfWjjQleM1P1wcYSgL9/WualaucrXk1setlEOETlbxnA/rrn3oZasL/5
 DDzRT7E3EDOPu3az4BOXFg/TyRY0cGWE0gr+xKC4CkuRC0bOug9noInbatlVwFD5izN0
 H8blUGvoOPxFJT2VSlWgwbYx4tO4RXehrWPaLmPnez20hV3NeXSIZnrhrDXI92T0SZr3
 3jGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QXxrogNPyUWaKv0YhbALpbgybFlB2iLdVPSK+TffEeI=;
 fh=7/dMrZ1kAqHqVmF07zJBXVbCQdW8JuYgca07n1eYIKw=;
 b=A8pvFIR2sZBzv598v/3fwtoJFd7eRP+IHMtyDnAS7ZD5zz1XtH98UT9dpkxT21Iuhm
 zQRd2L/IMOuiT9PTI+FJdaJa0GPoJ82DvMW/2Pj1QeIjXciMU6Xaaqr0OmUe1MZoz75W
 v7hSwKtY2k1gJ90Lmv/xE5b1rJhHPR4LY5xYahdFJcQ2ntW+nBgxM3VaPx/o4YuvAv7N
 WLlfA70/9beg33cI1MqmiwNQR9TfJ3fccJoHYpcU6igK4wXVXuDyV9pqmpSj92PRx38q
 2+G1MTl6pMA5iOCzpDnIrPeyIaFyFM9grz1sjEcTA9s30PkSSn0eadxnIFNK0ixl8VKU
 0MWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792508331; x=1793113131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QXxrogNPyUWaKv0YhbALpbgybFlB2iLdVPSK+TffEeI=;
 b=UIws4tEPLKohloXMUTTzBKAQqsQdtM+Hc8VC18oVzkyQOYn41SHmbiwjVNN0vY25Fq
 KzyZwm48+SQHkQqdBuSgXzHXt6ow9c2MpJY5DJlpMfLhY+c0BxO/WBWRvZGI81v1oE/M
 IOckxH/f3f6a8fm+6BSEJfb7dfwIkfTdhgbEAOxTjJqkOWo4fsZwU/2haelKJKAZ6fq2
 BItFizAkIvPZsbSBbZEaNfpk/6ARWc42wBjnPaxK8QpYblh86CijUmvU7ixzmccn9i6S
 Fv1+fycjsXuzrUNp9GNAr+mro7fEjfmMVe6FY/WA997nOnPnAQmMUHHrYwgRVNfAfFmA
 on6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508331; x=1793113131;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QXxrogNPyUWaKv0YhbALpbgybFlB2iLdVPSK+TffEeI=;
 b=NCZk2IBI8ByhPoNKXq0QOUQOofJheMXrdh9F0BWJ0wA98WsavDOQISDILDcrOaWmCz
 bIDbb03BNCwA+4659thc+Yq3KvBZ3PvqYJ/PLYO4yyQD1GjaEOkWmeDhCEojvV+2EiIo
 KL2RIbwynBnQJSdtrBKaV1pCPfqEK79j5iSzbCb2jwGUujnaULlKlYaDNQ1YW3G7bmIs
 h+82xMK7ifa6ZvVDnMy1ZU1S7s/h83QU6R7E3Ctyx5k9H04mRzzU1VQQ14gpc3g9O6yJ
 midjQ8Ye/+vet8zLrX15hPJh9Aii7oblAZ/gNh2nXIoEyKDzHJNfLmYi70LwhNiC/Dvf
 oetg==
X-Gm-Message-State: AFq9FYIoCKIaTH3cNm7mC/tCwS1QFTzz0GpR2cr33hKjnh9jmg0KNcMD
 y58f9I+lscT55Teh+iGMmx9GKOWvQyBWof9pKguO9ogBy9LyUynEYflgK2yYI1n66/hrhK443yR
 /PvLGkiePign7zo3dTTTXf/aPaAWLCrGd+F+geaVvOw==
X-Gm-Gg: AYBFou1up+pZRudlLDEUC3SCNeb1KjY2VbtSLsnpAh1hHlGQ2+JCX8L60pF3wxdAIQO
 vnIwZ4/hpam74mQa6N8vWarXNYhtUW0G3BFoQ1+AXWt/WucfDvCMUwgb9+vA6ejvyxdUEHoO3B/
 B35aq6humg1Hw7PBdPk94XvTiWSpiP1iiCMZsI4W0/FrDfUslb4lRtoXunmpi4dYUS28/1XOL6k
 B8yS5JGdl4rI0whkj5h8VKrSNhjPRTxgOTQXZChyiSgEb6CvcWO+nazubzTEVrNJDYgU2LNAiv/
 4kwFgxRHwthoJcCCPFkW4SEnQHf3VvRK7T50HGMXFxqocL18ZiEuVija4JqlRVwH762hY9erq6Q
 tLp4f4xLTCBDJzXJeDuRJIC3KfW2bT7lpq1StflE=
X-Received: by 2002:a17:907:960a:b0:c29:f5d8:9c82 with SMTP id
 a640c23a62f3a-c41a08da7ebmr876197166b.49.1792508330675; Tue, 20 Oct 2026
 07:58:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260904051943.799041-1-alistair.francis@wdc.com>
 <20260904051943.799041-14-alistair.francis@wdc.com>
In-Reply-To: <20260904051943.799041-14-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 15:58:37 +0100
X-Gm-Features: AclHuK9rMBCw6kkzkyu3An3Hb3gR42iNWgWg6wvCUNBM_8QMRhQockIA2JwivsE
Message-ID: <CAFEAcA8O9afywUSoju8ozvSP0q-TG2A1Y0Daij-LLhJFRy-dzg@mail.gmail.com>
Subject: Re: [PULL 13/47] tests/tcg/riscv64: Add tests for rv128 [ms]status
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 4 Sept 2026 at 06:23, <alistair23@gmail.com> wrote:
>
> From: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-grenoble-alpes=
.fr>
>
> Adding asm tests to check that mstatus and sstatus are updated as
> expected in an rv128 cpu.
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-greno=
ble-alpes.fr>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Message-ID: <20260824174246.202150-1-frederic.petrot@univ-grenoble-alpes.=
fr>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Hi; this test case provokes undefined behaviour which trips the
clang sanitizer if you run 'make check-tcg' on a build with it enabled
(i.e. configure with "--cc=3Dclang --cxx=3Dclang++ --enable-ubsan").

Running the test case on its own:

$ UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pr=
int_stacktrace=3D1
./build/riscv-san-dbg/qemu-system-riscv64 -cpu x-rv128 -M virt
-display none -serial stdio -semihosting -bios
./build/riscv-san-dbg/tests/tcg/riscv64-softmmu-test-rv128-sstatus.test
../../target/riscv/tcg/pmp.c:572:25: runtime error: shift exponent 64
is too large for 64-bit type 'target_ulong' (aka 'unsigned long')
/usr/bin/llvm-symbolizer-18: error: '/memfd:tcg-jit (deleted)': No
such file or directory
    #0 0x5ab9d5e8b569 in pmpcfg_csr_read
/home/pm215/qemu/build/riscv-san-dbg/../../target/riscv/tcg/pmp.c:572:25
    #1 0x5ab9d5f91440 in read_pmpcfg
/home/pm215/qemu/build/riscv-san-dbg/../../target/riscv/tcg/csr.c:5588:12
    #2 0x5ab9d5f79085 in riscv_csrrw_do64
/home/pm215/qemu/build/riscv-san-dbg/../../target/riscv/tcg/csr.c:5889:15
    #3 0x5ab9d5f7a274 in riscv_csrrw_i128
/home/pm215/qemu/build/riscv-san-dbg/../../target/riscv/tcg/csr.c:6046:11
    #4 0x5ab9d5fb7b11 in helper_csrw_i128
/home/pm215/qemu/build/riscv-san-dbg/../../target/riscv/tcg/op_helper.c:117=
:26
    #5 0x77568c0008ba  (/memfd:tcg-jit (deleted)+0x8ba)

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../target/riscv/tcg/pmp.c:572:25
Aborted (core dumped)

What happens is that in pmpcfg_csr_read() we do this:

    int pmpcfg_nums =3D 2 << riscv_cpu_mxl(env);

    for (i =3D 0; i < pmpcfg_nums; i++) {
        val =3D pmp_read_cfg(env, (reg_index * 4) + i);
        cfg_val |=3D (val << (i * 8));
    }

For the x-rv128 CPU pmpcfg_nums comes out as 16, and then
we try to assemble 16 bytes into an 8-bit target_ulong variable,
and for bytes 8..15 the shift amount is larger than the
type, which is UB.

I'm not sure how this is intended to work; could you have
a look at it, please?

thanks
-- PMM

