Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D2DF327A9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF4FB-0008E9-U8; Tue, 21 Apr 2026 02:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF4F9-00088i-G6
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:05:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF4F6-0007GF-57
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:05:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so60286375e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 23:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776751550; x=1777356350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OtKY0PIm2HMVW6Fw0IHLRhBr7oEOdI6Y19waM5q9yes=;
 b=vXhFJ/JHPWIK9OtSJWljglTOmAiCUMaWRBahV8gVyZQPEkGdj63Hv0aOLbkyqdMpHE
 Mk/oM7ASUQx+FeQhxPsGtgv3tgZrvAohFu6UuTIuuhWAyIDalxZ2CHC9ZgKbMAQoxBez
 l63v8PwNhrRpfvhXYoXckKy2SkTpgF3aY2HYnkWGFRarr4epzWEqJHMrKw2GQHpc0eQm
 HS/d3uodZGtgbNaR92ODQo9iHPXHpMXBvycijz1+J/GoAuXJaSpTUat01AR+RZ+/hd9e
 5yqRGuaFgFAwEWgx7gxBi3zNUa3tf1njr/p0/LoBllzAQGIqF/HUH/ILcOIJliXWeh3g
 5IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776751550; x=1777356350;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OtKY0PIm2HMVW6Fw0IHLRhBr7oEOdI6Y19waM5q9yes=;
 b=b6AlQY83klLCoIEvL8RKkCl081jJYQ4OEdEEIumEjNqwIQUXrYaMxWNEKkzjP/ef3n
 Vi2jST+9tF7OjEbnfWhr3oxlGhupIgT2Jnekmo8faJM+oFX2ZtgHg1ZdzxfUAHI5xgsi
 Xf5Rxz1kikBr30TkrFGGIRMx4vNrb2Mqo+JlVfv8oMK+6ee0akUJSQ9iICLq8yb13rDp
 3KkLRew7gk4r4Nkb6hkK3DsoS0CGpyR/HEP+9WkB+vnDXMG+RPoTS1tlpJ1Zhi/YMfve
 vdSnsbzhyJFgI/5t69h27PNHTdXRDqZ+rWFPmwNuHvL+j6k/kLHbXxxQEiXVqNANm1IF
 R26w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VFZ6Cmr8pXpOHagvqD1FXzbSP5IcK0mIldAX6wV3fB+UqzGveiZOWS9VQab3dNZc8DQ9vwvzC3mz/@nongnu.org
X-Gm-Message-State: AOJu0YyhSXskes/HjeYDwII1LXvgNVv7zqtZCQR0+yBhezFKd5uNPt6+
 EtM99DowZ4xGmTKf5k31vd7sPOKmBFEFD+qtS4xHveJyArxD7SYrS61qc9FAS1HDSD0=
X-Gm-Gg: AeBDieutdGRbTCQcjnkEwuKINmhhlUSXP6hhi770qlMNlPeX2miSmB/aINxRVIfXWrS
 TVigUBYM5blMzUGHisjn6yMoFJf5RmxDesanc0UU/Kyz34p8CdlI8flEhL42+XXMP9DYi8KLq92
 TpkU5JnZbNKw/Hc6V7OMZSU5lUHaFOa+EXc+sQ/nBJCmBhY6TVVLZWF1cmYNF1pMbptFb/jK3zu
 +nQOL+YjH8DSKlpovweDy/lBFjIl+W43sCbzOnHLCTV1qzZLqiPQkd/8qFbimGjSYYFiaO/jhxI
 1iZbzTpBBxe1sJEe8mcLoHNhCXAjGrpEMbDTVNr+Cvx7C7VMZ4AuLIri5iu/e9mdumhVG66ImDA
 cTpuwA18cl3tNpfYApydE0bdPjeuh6rHiVNnboD8gCQkHmfEey0c55QCJi7FKDWGCqN2TP7bPeT
 htXVtB0H2FPjlr+5ooKz3/g/r95qGQg8EGkyfMtPKteeG/m0REj6LAcIHhHFOE+kIRHeupTGq/Q
 EhQ
X-Received: by 2002:a05:600c:2e42:b0:489:1fa4:50c6 with SMTP id
 5b1f17b1804b1-4891fa451bamr41848125e9.20.1776751550085; 
 Mon, 20 Apr 2026 23:05:50 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc17f642sm314040795e9.5.2026.04.20.23.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 23:05:49 -0700 (PDT)
Message-ID: <87ba28f4-aeab-4015-8f9c-9d3a53c0cb7a@linaro.org>
Date: Tue, 21 Apr 2026 08:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] tests/functional/riscv64: Add tt-atlantis tests
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-12-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260421053140.752059-12-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/4/26 07:31, Joel Stanley wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Add OpenSBI and Linux boot tests for the tt-atlantis machine. Based on
> tests/functional/riscv64/test_sifive_u.py.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3:
>   - Fix path to test files
>   - Dedupe command line root argument
>   - Remove unused import
> ---
>   MAINTAINERS                                  |  1 +
>   tests/functional/riscv64/meson.build         |  1 +
>   tests/functional/riscv64/test_opensbi.py     |  4 ++
>   tests/functional/riscv64/test_tt_atlantis.py | 63 ++++++++++++++++++++
>   4 files changed, 69 insertions(+)
>   create mode 100755 tests/functional/riscv64/test_tt_atlantis.py


> diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
> new file mode 100755
> index 000000000000..f6f4b7ceec34
> --- /dev/null
> +++ b/tests/functional/riscv64/test_tt_atlantis.py
> @@ -0,0 +1,63 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a Linux kernel on a Tenstorrent Atlantis machine
> +# and checks the console
> +#
> +# Copyright (c) Linaro Ltd.
> +# Copyright 2026 Tenstorrent
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +
> +from qemu_test import Asset, LinuxKernelTest
> +
> +
> +class TTAtlantis(LinuxKernelTest):
> +
> +    ASSET_KERNEL = Asset(
> +        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
> +        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
> +    ASSET_ROOTFS = Asset(
> +        ('https://github.com/groeck/linux-build-test/raw/'
> +         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
> +         'rootfs.ext2.gz'),
> +        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
> +
> +    def do_test_riscv64_tt_atlantis(self, connect_disk):
> +        self.set_machine('tt-atlantis')
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
> +
> +        self.vm.set_console()
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon=sbi '
> +
> +        if connect_disk:
> +            kernel_command_line += 'root=/dev/vda panic=-1 noreboot rootwait '
> +            self.vm.add_args('-device',
> +                             'virtio-blk,drive=drive0,serial=0x1234,bus=pcie.0')
> +            self.vm.add_args('-drive',
> +                             f'file={rootfs_path},if=none,id=drive0,format=raw')
> +            pattern = 'Boot successful.'

Should we run a full shutdown to test up to the halting payload
(patch #4)?

> +        else:
> +            kernel_command_line += 'panic=0 noreboot '
> +            pattern = 'Cannot open root device'
> +
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +
> +        self.vm.launch()
> +        self.wait_for_console_pattern(pattern)
> +
> +        os.remove(rootfs_path)

Since you call uncompress() with implicit @target=None argument,
scratch_file() is used:

         Construct a path for accessing/creating a scratch file
         located relative to a temporary directory dedicated to
         this test case. The directory and its contents will be
         purged upon completion of the test.

So IIUC no need to remove manually. Do you have an issue with it
to remove it manually?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
> +    def test_riscv64_tt_atlantis(self):
> +        self.do_test_riscv64_tt_atlantis(False)
> +
> +    def test_riscv64_tt_atlantis_disk(self):
> +        self.do_test_riscv64_tt_atlantis(True)
> +
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()


