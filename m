Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB59D262AD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 02:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viOAy-00059L-K4; Tue, 20 Jan 2026 21:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1viOAx-000594-RR
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 21:42:31 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1viOAw-00032S-90
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 21:42:31 -0500
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-352f60d6c2fso338441a91.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 18:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768963348; x=1769568148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Odr1n1qm+Qr2BCwhfBFs50K5fHu9QLRM5Rl0Pq0/hpI=;
 b=mht2KuAUZE+SMZsWE4a5VWZ6V3VC6rbGfiK2kMOLjS4Uv0kR9lCkNbpuMj/niecXrx
 XN3oz7oNMWJ+kZnkVAjsOcAwecFD9qWEbj7hXIRlQU7X9LE5R6HndxAobHaWB4fo3kVY
 +nHpmPEUKwdrC8bp+9eHG0Gmz5P0p+W4OLWLajjYbvAq7mu5SVNj52V/4Pw0OxUvBTqz
 Q60acPVxf3RboK2bUaRfrmqYbr0YNZzOA9vg6G3T0diHftr0fPbr6T+nAuEzRX7IrmgY
 N70jSCEJ7tqQtzOjd4scKTgg8HrhbQNk31DoHQXKVYT+ofT2dfCybtkFXK9iqRacIJne
 Mo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768963348; x=1769568148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Odr1n1qm+Qr2BCwhfBFs50K5fHu9QLRM5Rl0Pq0/hpI=;
 b=Agodqd20m2R2gDUfrRk5KEEiU3rTytKBZ/fO7xVqGk34c7VuifNxsHKesBsI/KYjrD
 7kjFpgyPqyB04cgjZLBkScduPfMWgRrAXOeNP4Xha4a0drhLOqVYAyq0EW6AtgBOTQAp
 Pf/g3EkfUhrh20UqwyvtWI0mpduUoG8JdCF3YtAe84dVP36/vslqOh9e4J3h9MDJ4eT8
 AFrcduIgTTIO3LCumyGWYVlmo4UjXHgBbhwvNXGfYEGZCL5+LSVez3Rc5YapxYcXmbMv
 9i03Z9Ex2wsi2EV2chkw36mNSNtUZ7JjbLsA0bMsA2vK8ngSJp3jviWT34et4YXKjm0r
 Dd5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWQ1UAQrq7yonvbK5GyevZC/URmy7PeD/skquc4byTigaqx3c5yrp08F+2y+ZNEmQ/a7rGhZqUD/y+@nongnu.org
X-Gm-Message-State: AOJu0Yyk5rWAFV7SPu0kqI7S8BKx7GRRcw3QOdZetPE48Xxc2M7XKKv9
 WvUXfMbOa6nIhwpghivK1YhFhm9OZ4l2EJRXw22LtXesfP4XyK5pzjFh
X-Gm-Gg: AZuq6aKdsCImzKfQAHWm/F/8yPmso9e7KET8cORpM+2JCDsnDRQ68YLsW4pgWslPYop
 9Pup7KtFLC5eUwH38g5E3D4Cy6yos5GbT4SU5A6DHNfplpnujs2O2aCdmQRVq0LEWAuF91jtTqn
 02XftJz6UnA0HFvRlRqabJ1s7m4aRJ99aWLM27xFqqyTzKlZJzA5izi8Uq04xnYOAALFYBayfOX
 A+kmcCoSiMKyUEEyjMrBdEvFuf7M/5LhcD5WPcvIiL3mhSlT8TtzYtXmOCrrxpKT+5rinddsHFh
 qRGjncv9DT/MseF+qH+UePiBGydkmdrZBWOhV403Iw+xf35DU02u7u793OYpRKzG8GQi6MdSzbS
 h75PQjlWF1kldyaCIvfXAEr2D1QAqsARh93m2GK3VX8dXadIAhX7C1ghRZ79eaQFUuMvspJRR7C
 FLP/fMcACbpfqq2MEtjk4yRT39cFREVnDUwEJq0eATfFXK9/a0xUyXITZHkb0=
X-Received: by 2002:a17:90a:dfcc:b0:340:ca7d:936a with SMTP id
 98e67ed59e1d1-352732547e9mr13129487a91.18.1768963348402; 
 Tue, 20 Jan 2026 18:42:28 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352678ef77fsm15563990a91.17.2026.01.20.18.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 18:42:28 -0800 (PST)
Message-ID: <3c1ed2bb-d089-4f85-8696-4027257de5f4@gmail.com>
Date: Wed, 21 Jan 2026 10:42:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/riscv64: Silence warnings from Pylint in
 the boston test
To: Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
References: <20260116095615.269199-1-thuth@redhat.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <20260116095615.269199-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj1-x1041.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Hi Thomas,

On 1/16/2026 5:56 PM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains:
> 
>  tests/functional/riscv64/test_boston.py:1:0: C0114:
>   Missing module docstring (missing-module-docstring)
>  tests/functional/riscv64/test_boston.py:95:8: C0415:
>   Import outside toplevel (subprocess.run, subprocess.PIPE) (import-outside-toplevel)
>  tests/functional/riscv64/test_boston.py:112:17: W1510:
>   'subprocess.run' used without explicitly defining the value for 'check'. (subprocess-run-check)
>  tests/functional/riscv64/test_boston.py:95:8: W0611:
>   Unused PIPE imported from subprocess (unused-import)
> 
> Rework the code a little bit to make the linter happy.
> 
I tested this patch, and it works well :)

Tested-by: Chao Liu <chao.liu.zevorn@gmail.com>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/riscv64/test_boston.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/riscv64/test_boston.py b/tests/functional/riscv64/test_boston.py
> index 385de6a61df..2582df96f21 100755
> --- a/tests/functional/riscv64/test_boston.py
> +++ b/tests/functional/riscv64/test_boston.py
> @@ -1,11 +1,14 @@
>  #!/usr/bin/env python3
>  #
> -# Boston board test for RISC-V P8700 processor by MIPS
> -#
>  # Copyright (c) 2025 MIPS
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> +"""
> +Boston board test for RISC-V P8700 processor by MIPS
> +"""
> +
> +from subprocess import run
>  
>  from qemu_test import QemuSystemTest, Asset
>  from qemu_test import wait_for_console_pattern
> @@ -92,7 +95,6 @@ def test_boston_invalid_cpu_count(self):
>          """
>          Test that 65 CPUs is rejected as invalid (negative test case)
>          """
> -        from subprocess import run, PIPE
>  
>          fw_payload_path = self.ASSET_FW_PAYLOAD.fetch()
>          rootfs_path = self.ASSET_ROOTFS.fetch()
> @@ -109,7 +111,8 @@ def test_boston_invalid_cpu_count(self):
>          ]
>  
>          # Run QEMU and expect it to fail immediately.
> -        result = run(cmd, capture_output=True, text=True, timeout=5)
> +        result = run(cmd, capture_output=True, text=True, timeout=5,
> +                     check=False)
>  
>          # Check that QEMU exited with error code 1
>          self.assertEqual(result.returncode, 1,


