Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F5ED2B944
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LzJ-0006hD-Of; Tue, 05 Nov 2024 11:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzG-0006eb-Id
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:00:58 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzE-0007O4-3h
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:00:58 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cec7cde922so5362947a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730822453; x=1731427253;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Scb2EKQT3PN3UVGeb/ptW1xx9GSETchLiUtounmX4sM=;
 b=iM1JZG+D13GZ2InRU1D7dJ02EpMmRhjNyxIYf0gLC5VYLDxGyqRETm2Bl0YLPt+hVl
 zuzY/gsWbDP8ZTeeHclmBXeUO+MRZ0W/sMJIhnX83oh555N4J2TfzfulYAzcYPLTq4y+
 RdKCbRPRbeRKr/ytOlj3iUGBsliddt/rb21v83yJfDEyfuiAbaloHpWiNwavHnjpcjNZ
 IxR1yAdkp0tsnn2A2ViiG53e1mHk4HYnCqArCfQbPL0AvnGq0j3sRguDmIOhwTrJA3S3
 EKjRIuSbyPJ6Ga42jnxVXL1rkDNDtoLFLrSGYrC2towxXovmTXix0SdaqtmhOH0zouwy
 TaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822453; x=1731427253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Scb2EKQT3PN3UVGeb/ptW1xx9GSETchLiUtounmX4sM=;
 b=FJX120HpmcZpyFCFvN/aSt2wWmx9UtXNbQObkDh801Qm9WIuZcKX++uv/ch6j5118Y
 N7gqjYuPYW9v/dOp4mxcPVgVKudKBaN6RLuNwEBCoQDKqxkl15KsWqP4wZYaNBke+X9O
 qYLLE3Y2mElwwebjPa6+HvoX8tWKiTR4Mjvm1Kn5rVPBgIj/2K1+eaI/6oV9N/WyMPxu
 5ilHFsUsQ71UZuh+lhSuhGSPYusDd5qzy1BCHtbv/3EMcNmmmMNVM2CQOpYe4rVjPzlz
 ET4IOfqLLcLB3PuI4MOacInqZp79fzBk4CuMGQYbEFvpc4osuQ9pzeBJzxg5s7UHc0rS
 NaWw==
X-Gm-Message-State: AOJu0Yw8tpepE72auV/ZOpZ1Yy6skBFFe7pUaxB+KNKVKK3Ji7Fp6Xwb
 b4DhMujFSb0ucok38i2vGKgAK/mo32biK7OXdoyuoC+rQr1le65WSBW+AZYcP65f5LBInEul7K7
 1hQ==
X-Google-Smtp-Source: AGHT+IHFwFJXrrJEFtJzNJXDIAMnh6oqx02gkIAG+R9PNyGcg92n71Nn56J3tU82TAPVXPbLLgurJQ==
X-Received: by 2002:a05:6402:27d3:b0:5ce:df56:4e39 with SMTP id
 4fb4d7f45d1cf-5cedf564f15mr3588937a12.23.1730822453455; 
 Tue, 05 Nov 2024 08:00:53 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6a9a41bsm1467773a12.14.2024.11.05.08.00.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 08:00:52 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, pbonzini@redhat.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 0/5] i386/hvf: x2apic support and some small fixes
Date: Tue,  5 Nov 2024 16:57:55 +0100
Message-Id: <20241105155800.5461-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52f;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This is a loose collection of patches against the x86 hvf accel. They
can be applied/pulled independently from one another.

Patch 1 is a repost of a patch I've submitted a bunch of times already.
It wires up and enables x2APIC mode in conjunction with HVF - the
software APIC implementation in QEMU gained the feature earlier this
year but hvf wasn't included.
The change typically improves performance with modern SMP guest OSes by
a 2-digit percentage. (Exact values depend on workload.)

Patch 2 fixes cases of undefined behaviour recently introduced by commit
7cac7aa which made changes to HVF CPUID XSAVE functionality.

Patch 3 fixes a minor one-off memory leak during hvf startup.

Patch 4 ever so slightly improves APIC correctness under hvf: when
setting the APICBASE MSR, if the APIC deems the new value invalid,
we raise an exception (as per spec) rather than silently doing
nothing. This fixes a failing kvm-unit-tests test case.

Patch 5 removes some unnecessary duplication and type-rechecking in
HVF's inner loop. (No need to cast the cpu state pointer to X86CPU
within, the hvf_vcp_exec function already does that once at the top.)

Some of this work has been sponsored by Sauce Labs Inc.

Phil Dennis-Jordan (5):
  i386/hvf: Integrates x2APIC support with hvf accel
  i386/hvf: Fix for UB in handling CPUID function 0xD
  i386/hvf: Fixes startup memory leak (vmcs caps)
  i386/hvf: Raise exception on error setting APICBASE
  i386/hvf: Removes duplicate/shadowed variables in hvf_vcpu_exec

 target/i386/hvf/hvf.c       |  7 +++----
 target/i386/hvf/x86_cpuid.c |  6 +++---
 target/i386/hvf/x86_emu.c   | 42 +++++++++++++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 9 deletions(-)

-- 
2.39.3 (Apple Git-145)


