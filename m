Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA352CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOH7-0006Zh-K4; Tue, 02 Sep 2025 06:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utOH2-0006UR-F6
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:02 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utOGz-0000oX-BJ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:29:59 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-72290cfcf5eso14519017b3.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808992; x=1757413792; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G/imFK+wxlwINE4m6wr1YjkZKrZAqg+FuJFMNF4Nks0=;
 b=xqtNrEIIdN7/4aH7HXRGNG5091e0snXYAOqbUpMuE8s1v3Z/qhHPzeCOS28hvoKeCH
 wSMFxLZfga70jUbeMVg9or/wWR4xik3HlGO0yvVLhkm9tQteaMr7omemrCyhTmu3yQ4U
 6PSKhHQF9LwjCe40EglI6mhB2IreC1GttUHI8O3QV41oBZcjP1yKoMDG8YTYug5JcHhy
 R9YT6XHIlTeAnbz/3tZt1T5+gZC5Bt8EzotJalSvc6TX+2RPgy1BSMYTKxem0vVqYWC6
 Ov+fgCywO7qnUM47lWTXS5q+X48rwY7MWbYijD9tfvY9heVhipNp/8QTLPcfAxFH52cv
 Al1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808992; x=1757413792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/imFK+wxlwINE4m6wr1YjkZKrZAqg+FuJFMNF4Nks0=;
 b=Zh6NGVOtQRCbu2o9XlGGTmkIJAvXVIuXxZ46cdQCEmL5Xkb3lnJXU7KJdukDbyu0BR
 GRY7pW5fI3zK5OdCcAZgCMW5VPfNe3dcla1NsJVwte0otBPnSm51fECrT3mhQcMafzku
 3ynkp6RncqnVGciVaSZiWQAvyIythv+YBeHRs9YlBG3QazltpwqCIf/XVpR0o8Ki3G8+
 aTewH+VJWeZkMFBDue6A9wU+ETlMOiciugGrzpkOgq/Ew+7/MtZIVOoKnH0wGCnR6Uz5
 B+D2jyAkfA+KCk/zt0p7oFTIhvhk9ZZczDy7Lenlizk1uvdf8q8ai22bZS0XVqkCx13j
 p/2Q==
X-Gm-Message-State: AOJu0YzIroaDq68E8hsc18u3pyUXJrbikpJJtyHYqk9A0lNMnLKPJsnO
 X+jRQSJ4LNIySO/RiBaJOCI/2jGWNa7dv9f5SbkZUKijIe1zF9e6O4wMorIt9zCnk6++iekdohU
 6llTSs7DYOOnARAG2+eDnwG0l/nrHP2Nrfez/4rSs5A==
X-Gm-Gg: ASbGncsTTKbwBf21FUji96X72G4xBxsnrH+OfwwwrNtS2koew+dX2D16l2JeEC/6Y2i
 mXdWB7ItFdCkUosSgrXkLZUpEVOEhi6wHE3oYErpKtSD8y1Q0nlpMV3GjE3r1MHfzClhzWQi2lN
 1kl1hujuHRSproki2pelyzH8GuIxDlSdB2hgeWiglb112jqapTPErLsheKsSdFWp/iW6Ftz09BV
 ZFNzkMw
X-Google-Smtp-Source: AGHT+IEEW49jn6XqUr8B+82MbnlTNfAwcDGgmifQbvoTTYeHDYV/xn4cdTUgl7LwGgfZtrOx3IkT6jyWtUTy4Jgx79s=
X-Received: by 2002:a05:690c:7682:b0:722:7cfd:4f94 with SMTP id
 00721157ae682-7227cfd52f2mr112947137b3.14.1756808991961; Tue, 02 Sep 2025
 03:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250826184504.510279-1-vacha.bhavsar@oss.qualcomm.com>
 <20250826184504.510279-4-vacha.bhavsar@oss.qualcomm.com>
In-Reply-To: <20250826184504.510279-4-vacha.bhavsar@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Sep 2025 11:29:40 +0100
X-Gm-Features: Ac12FXxHN_ydRYoxfH2kugr7zpqez8cHcqyMCf-oUQaqSEdI3zVSYEsP_m67ccU
Message-ID: <CAFEAcA9_wXKT6zfpCSty2bRjVpCSyzLcdfWuJofJEZcZuqRgYQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] target/arm: Added test case for SME register
 exposure to GDB
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 26 Aug 2025 at 19:45, Vacha Bhavsar
<vacha.bhavsar@oss.qualcomm.com> wrote:
>
> This patch adds a test case to test SME register exposure to
> a remote gdb debugging session. This test simply sets and
> reads SME registers.
>
> Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> ---
> Changes since v5:
> - added copyright and SPDX line
> - added functionality to avoid casting a gdb.Value object
> to int when testing the za quadwords to address bug found
> during review, this change is declared to users via a
> warning message included in the test results file
> run-gdbstub-sysregs-sme.out
> ---
>  configure                             |  11 ++
>  tests/tcg/aarch64/Makefile.target     |  33 +++++-
>  tests/tcg/aarch64/gdbstub/test-sme.py | 165 ++++++++++++++++++++++++++
>  3 files changed, 208 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py
>
> diff --git a/configure b/configure
> index 274a778764..9e2ae174dc 100755
> --- a/configure
> +++ b/configure
> @@ -1839,6 +1839,17 @@ for target in $target_list; do
>            echo "GDB=$gdb_bin" >> $config_target_mak
>        fi
>
> +      if test "${gdb_arches#*$arch}" != "$gdb_arches" && version_ge $gdb_version 14.1; then
> +          echo "GDB_HAS_SME_TILES=y" >> $config_target_mak
> +          if test "$gdb_version" = "15.0.50.20240403-git"; then
> +            echo "GDB_HAS_INT_CAST_SUPPORT=n" >> $config_target_mak
> +          else
> +            echo "GDB_HAS_INT_CAST_SUPPORT=y" >> $config_target_mak
> +          fi
> +       else
> +          echo "GDB_HAS_SME_TILES=n" >> $config_target_mak
> +      fi
> +
>        if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
>            echo "GDB_HAS_MTE=y" >> $config_target_mak
>        fi
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> index 16ddcf4f88..f9304d29cf 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -132,7 +132,38 @@ run-gdbstub-sve-ioctls: sve-ioctls
>                 --bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
>         basic gdbstub SVE ZLEN support)
>
> -EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
> +ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
> +# SME gdbstub test
> +ifeq ($(GDB_HAS_SME_TILES),y)
> +ifeq ($(GDB_HAS_INT_CAST_SUPPORT),y)
> +run-gdbstub-sysregs-sme: sysregs
> +       $(call run-test, $@, $(GDB_SCRIPT) \
> +               --gdb $(GDB) \
> +               --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> +               --bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
> +               -- test_sme --gdb_sme_tile_support --gdb_int_cast_support, \
> +       basic gdbstub SME support)
> +else
> +run-gdbstub-sysregs-sme: sysregs
> +       $(call run-test, $@, $(GDB_SCRIPT) \
> +               --gdb $(GDB) \
> +               --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> +               --bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
> +               -- test_sme --gdb_sme_tile_support, \
> +       basic gdbstub SME support)
> +endif
> +else
> +run-gdbstub-sysregs-sme: sysregs
> +       $(call run-test, $@, $(GDB_SCRIPT) \
> +               --gdb $(GDB) \
> +               --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> +               --bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py, \
> +       basic gdbstub SME support)
> +
> +endif
> +endif
> +
> +EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls run-gdbstub-sysregs-sme
>
>  ifeq ($(GDB_HAS_MTE),y)
>  run-gdbstub-mte: mte-8
> diff --git a/tests/tcg/aarch64/gdbstub/test-sme.py b/tests/tcg/aarch64/gdbstub/test-sme.py
> new file mode 100644
> index 0000000000..e27a37631b
> --- /dev/null
> +++ b/tests/tcg/aarch64/gdbstub/test-sme.py
> @@ -0,0 +1,165 @@
> +#
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from __future__ import print_function
> +#
> +# Test the SME registers are visible and changeable via gdbstub
> +#
> +# This is launched via tests/guest-debug/run-test.py
> +#
> +
> +import argparse
> +import gdb
> +from test_gdbstub import main, report
> +
> +MAGIC = 0x01020304
> +INT_CAST_SUPPORT = 0
> +
> +def run_test():
> +    "Run through the tests one by one"

This is a very unhelpful name and comment for this function.

> +
> +    frame = gdb.selected_frame()
> +    rname = "za"
> +    za = frame.read_register(rname)
> +    report(True, "Reading %s" % rname)
> +
> +    for i in range(0, 16):
> +        for j in range(0, 16):
> +            cmd = "set $za[%d][%d] = 0x01" % (i, j)
> +            gdb.execute(cmd)
> +            report(True, "%s" % cmd)
> +    for i in range(0, 16):
> +        for j in range(0, 16):
> +            reg = "$za[%d][%d]" % (i, j)
> +            v = gdb.parse_and_eval(reg)
> +            report(str(v.type) == "uint8_t",
> +                    "size of %s" % (reg))
> +            report(int(v) == 0x1, "%s is 0x%x" % (reg, 0x1))
> +
> +def run_test_slices():
> +    "Run through the tests one by one"
> +
> +    frame = gdb.selected_frame()
> +    rname = "za"
> +    za = frame.read_register(rname)
> +    report(True, "Reading %s" % rname)
> +
> +    for i in range(0, 16):
> +        for j in range(0, 16):
> +            cmd = "set $za[%d][%d] = 0x01" % (i, j)
> +            gdb.execute(cmd)
> +            report(True, "%s" % cmd)
> +    for i in range(0, 16):
> +        for j in range(0, 16):
> +            reg = "$za[%d][%d]" % (i, j)
> +            v = gdb.parse_and_eval(reg)
> +            report(str(v.type) == "uint8_t",
> +                    "size of %s" % (reg))
> +            report(int(v) == 0x1, "%s is 0x%x" % (reg, 0x1))

This first part is exactly the same as the run_test()
function is testing, isn't it?

> +
> +    if INT_CAST_SUPPORT:
> +        for i in range(0, 4):
> +            for j in range(0, 4):
> +                for k in range(0, 4):
> +                    cmd = "set $za%dhq%d[%d] = 0x%x" % (i, j, k, MAGIC)
> +                    gdb.execute(cmd)
> +                    report(True, "%s" % cmd)
> +            for j in range(0, 4):
> +                for k in range(0, 4):
> +                    reg = "$za%dhq%d[%d]" % (i, j, k)
> +                    v = gdb.parse_and_eval(reg)
> +                    report(str(v.type) == "uint128_t",
> +                        "size of %s" % (reg))
> +                    report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
> +
> +            for j in range(0, 4):
> +                for k in range(0, 4):
> +                    cmd = "set $za%dvq%d[%d] = 0x%x" % (i, j, k, MAGIC)
> +                    gdb.execute(cmd)
> +                    report(True, "%s" % cmd)
> +            for j in range(0, 4):
> +                for k in range(0, 4):
> +                    reg = "$za%dvq%d[%d]" % (i, j, k)
> +                    v = gdb.parse_and_eval(reg)
> +                    report(str(v.type) == "uint128_t",
> +                        "size of %s" % (reg))
> +                    report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
> +
> +    else:
> +        for i in range(0, 4):
> +            for j in range(0, 4):
> +                for k in range(0, 4):
> +                    cmd = "set $za%dhq%d[%d] = 0x%x" % (i, j, k, MAGIC)
> +                    gdb.execute(cmd)
> +                    report(True, "%s" % cmd)
> +            for j in range(0, 4):
> +                for k in range(0, 4):
> +                    reg = "$za%dhq%d[%d]" % (i, j, k)
> +                    v = gdb.parse_and_eval(reg)
> +                    report(str(v.type) == "uint128_t",
> +                        "size of %s" % (reg))
> +                    report(v == MAGIC, "%s is 0x%x" % (reg, MAGIC))

So the only difference between these two branches is that we are
checking "int(v) == MAGIC" rather than "v == MAGIC" ?

Is this a "one GDB only works one way, and the other GDB only
works the other way" case? Or is there a real interesting thing
we'd like to test involving the cast ?

Either way, this code is way too repetitive. Don't copy-and-paste
like this, it's very hard to review.

> +
> +            for j in range(0, 4):
> +                for k in range(0, 4):
> +                    cmd = "set $za%dvq%d[%d] = 0x%x" % (i, j, k, MAGIC)
> +                    gdb.execute(cmd)
> +                    report(True, "%s" % cmd)
> +            for j in range(0, 4):
> +                for k in range(0, 4):
> +                    reg = "$za%dvq%d[%d]" % (i, j, k)
> +                    v = gdb.parse_and_eval(reg)
> +                    report(str(v.type) == "uint128_t",
> +                        "size of %s" % (reg))
> +                    report(v == MAGIC, "%s is 0x%x" % (reg, MAGIC))
> +
> +    for i in range(0, 4):
> +        for j in range(0, 4):
> +            for k in range(0, 4):
> +                cmd = "set $za%dhd%d[%d] = 0x%x" % (i, j, k, MAGIC)
> +                gdb.execute(cmd)
> +                report(True, "%s" % cmd)
> +        for j in range(0, 4):
> +            for k in range(0, 4):
> +                reg = "$za%dhd%d[%d]" % (i, j, k)
> +                v = gdb.parse_and_eval(reg)
> +                report(str(v.type) == "uint64_t",
> +                    "size of %s" % (reg))
> +                report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
> +
> +        for j in range(0, 4):
> +            for k in range(0, 4):
> +                cmd = "set $za%dvd%d[%d] = 0x%x" % (i, j, k, MAGIC)
> +                gdb.execute(cmd)
> +                report(True, "%s" % cmd)
> +        for j in range(0, 4):
> +            for k in range(0, 4):
> +                reg = "$za%dvd%d[%d]" % (i, j, k)
> +                v = gdb.parse_and_eval(reg)
> +                report(str(v.type) == "uint64_t",
> +                    "size of %s" % (reg))
> +                report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
> +
> +
> +parser = argparse.ArgumentParser(description="A gdbstub test for SME support")
> +parser.add_argument("--gdb_sme_tile_support", help="GDB support for SME tiles", \
> +                    action="store_true")
> +parser.add_argument("--gdb_int_cast_support",
> +                    help="GDB support for 128bit int cast", \
> +                    action="store_true")
> +args = parser.parse_args()
> +
> +if args.gdb_sme_tile_support:
> +    if args.gdb_int_cast_support:
> +        INT_CAST_SUPPORT = 1
> +    else:
> +        print("WARNING: The version of gdb used (15.0.50.20240403-git)\n"

This is super misleading: it looks like it's printing out what
gdb version we ran the tests with, but actually this version
string is just hardcoded !

> +        "does not support casting a gdb.Value object to 128 bit python\n"
> +        "integer. Thus, the testing for the ZA quadwords will be done\n"
> +        "without int casting. Refer to tests/tcg/aarch64/gdbstub/test-sme.py\n"
> +        "for details.")

This is a big warning that doesn't convey anything useful
to the reader (why do I care whether your test case
is using int casting or not?).

If there is part of the gdb view of the register that we
can't test on some gdb versions, that's fine. To handle
that, split the test case into two, so that for the
test that needs a newer gdb we report the test as SKIPPED
because gdb is too old.

Please also write some comments that tell me what your
test is testing. I should not have to reverse-engineer
your intentions by reading the code...

thanks
-- PMM

