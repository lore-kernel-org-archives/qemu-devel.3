Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81921C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvb6i-0002xs-QJ; Fri, 21 Mar 2025 08:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvb6e-0002w0-OP
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:04:09 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvb6d-0002th-1R
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:04:08 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so1497726276.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742558645; x=1743163445; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CJwk1+kTte8ITmBZhftdGAPv0C+slT3ULQeayG6Ytkk=;
 b=RuTgMGkB1SSmS6ktJHtXnO2G92XryWo2wQ0U/sgz8k2JQMEzSpbNFiUh1UG8Ftk/ct
 nHFLW3SRmadrtaHtf+/x6jniYz+JDb3EewygV7fp4LNZbN2bwysvFHer5ZrXLiGhm9Zj
 8nuMW43lEM0URBdi/MycqAJ/ga/Ocp+XFcgU259H3TZwOFJqlF6x+VEZK0HlZjvmHtFu
 Y7WORXUYiYAlMxgEnsPiZQLAlUxfPgzSyy5eyb8fOKmHpDB25GbHvj3Tk9ASSJ/fNsIS
 uNgZ+MWm/6wlioIl/jHj4GCbeuPHF5m4W2mkbZWGa13hkX179txf8kci+sI+dlSq4PWH
 gs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742558645; x=1743163445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJwk1+kTte8ITmBZhftdGAPv0C+slT3ULQeayG6Ytkk=;
 b=MHKmBl0fv4IDSYK5cDCM5LMLu+Ak9D20Q2qpKUhHbhBAwFn8ldIZkaDG73Av9DiB/+
 eFYjmEuEztlvfdYorDgpmIDDhoR+Ar1WqfFlhWzC04cgMSOtTGNrvy8qFxHkoT7g1RA6
 FSrftpaaoowVqLvE7qZXRZuCRdvVw89lUeePpMJ6vKeuZzv3HLm/NoF2+C9zRZSyM1Zb
 ipy1llffed9Hu1YMB8SRwgMiiBJu5I5yNCJ7t3Xqu3eKFy+xqMbS0BkZchfvJoJZlxzi
 5GXpkcFlEyOwX4uz+wlSP3/Dja4AqfnTnGtw85zaKqxiMlLn/aHuiNA5xEBKHZTdiLLH
 Vzkg==
X-Gm-Message-State: AOJu0YwrFaycaCUqAhb6z1XT4SnKk1fwQu0V/NRYonMxWDVG2YMjZPe2
 lfnc/ZAuUMQ+XlKxHDxSM2T8HhOgvsVe0io1FDY8Hb8OTiXiJRkw4cLHgSuhNC9eWE5yNlWc/1+
 ZrnOBdKe9i+q+13Z0eF1R1/MtP8rrh5giAeuIUw==
X-Gm-Gg: ASbGncvIHjG4NflMWXNGPfDJt+uOUtNxI+SEZbnLQy3PL16CtzZmMJQzW1c7uT2RXWC
 Ffo14pDuulZQmz4oPegNLhuSPeC9gq3BCTQzRr7hGk7Rjpezo6XPhTkGIhxfYEjfd5qOnQeWW92
 MOocMPXh48YngTqQ7k2zKBHBB9jSQMD8j8PIi+Gg==
X-Google-Smtp-Source: AGHT+IEtAHm/R80OnqykCioR1z7zhIqKV+/IPz15QKmwYiTtdD+7UayTPcT6x/BbBEnJfO/08YsKvtsEgOydpeW80cI=
X-Received: by 2002:a05:6902:260d:b0:e63:5a1a:7ff7 with SMTP id
 3f1490d57ef6-e66a4fa9420mr3544344276.31.1742558645438; Fri, 21 Mar 2025
 05:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250309103120.1116448-1-pbonzini@redhat.com>
 <20250309103120.1116448-22-pbonzini@redhat.com>
In-Reply-To: <20250309103120.1116448-22-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Mar 2025 12:03:54 +0000
X-Gm-Features: AQ5f1JpM3GMKSH3fVkq4WmYaxMi0k9G8AmvHwpcJ_CUn7GKN917mt4BX7wsUPeA
Message-ID: <CAFEAcA_h=dHcWyZfc7FibzbQiUtz+jHs+psKz-_ifrzVKU5CYQ@mail.gmail.com>
Subject: Re: [PULL 21/25] rust: hpet: decode HPET registers into enums
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Sun, 9 Mar 2025 at 10:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Generalize timer_and_addr() to decode all registers into a single enum
> HPETRegister, and use the TryInto derive to separate valid and
> invalid values.
>
> The main advantage lies in checking that all registers are enumerated
> in the "match" statements.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; this commit seems to break 'make check-functional'. Several
x86 tests fail; the one I looked at was x86_64_tuxrun:

$ (cd build/rust; PYTHONPATH=../../python:../../tests/functional
QEMU_TEST_QEMU_BINARY=./qemu-system-x86_64 ./pyvenv/bin/python3
../../tests/functional/test_x86_64_tuxrun.py; )

TAP version 13
/home/petmay01/.cache/qemu/download/4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751:
1073741824 bytes
Traceback (most recent call last):
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_x86_64_tuxrun.py",
line 31, in test_x86_64
    self.common_tuxrun(kernel_asset=self.ASSET_X86_64_KERNEL,
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/qemu_test/tuxruntest.py",
line 147, in common_tuxrun
    self.run_tuxtest_tests(haltmsg)
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/qemu_test/tuxruntest.py",
line 117, in run_tuxtest_tests
    self.wait_for_console_pattern('tuxtest login:')
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/qemu_test/tuxruntest.py",
line 67, in wait_for_console_pattern
    wait_for_console_pattern(self, success_message,
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/qemu_test/cmd.py",
line 160, in wait_for_console_pattern
    _console_interaction(test, success_message, failure_message, None, vm=vm)
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/qemu_test/cmd.py",
line 116, in _console_interaction
    if _console_read_line_until_match(test, vm,
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/qemu_test/cmd.py",
line 67, in _console_read_line_until_match
    test.fail(
AssertionError: 'b'Kernel panic - not syncing'' found in console,
expected 'b'tuxtest login:''

not ok 1 test_x86_64_tuxrun.TuxRunX86Test.test_x86_64
1..1

The console output from the guest shows that it fails trying to set
up the timer:

2025-03-21 12:01:10,676: printk: console [ttyS0] enabled
2025-03-21 12:01:10,678: ACPI: Core revision 20230331
2025-03-21 12:01:10,695: clocksource: hpet: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
2025-03-21 12:01:10,714: APIC: Switch to symmetric I/O mode setup
2025-03-21 12:01:10,728: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
2025-03-21 12:01:10,774: ..MP-BIOS bug: 8254 timer not connected to IO-APIC
2025-03-21 12:01:10,774: ...trying to set up timer (IRQ0) through the 8259A ...
2025-03-21 12:01:10,775: ..... (found apic 0 pin 2) ...
2025-03-21 12:01:10,818: ....... failed.
2025-03-21 12:01:10,818: ...trying to set up timer as Virtual Wire IRQ...
2025-03-21 12:01:10,862: ..... failed.
2025-03-21 12:01:10,862: ...trying to set up timer as ExtINT IRQ...
2025-03-21 12:01:10,910: ..... failed :(.

Incidentally, this is the second case of a 'make check-functional'
failure I've found in this pullreq, which suggests we should improve
our CI coverage so that it's doing a check-functional test on
a config with Rust enabled for at least the arm and x86 targets.

thanks
-- PMM

