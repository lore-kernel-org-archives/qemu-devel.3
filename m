Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD0FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79N1-0006d2-4k; Wed, 15 May 2024 03:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79My-0006Yj-Uc
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:48:13 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79Mw-0000Bw-Ou
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:48:12 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f4178aec15so5579062b3a.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715759286; x=1716364086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ud73vz92nOsf2EEwTWRfZlN26yWfMncbzbCqjllYE+Q=;
 b=gb3vubuQ67TXuEGB0E3zPiPrFM7hFIQARfW0LxY6UkA2YUcNvr6JjRiZ8wLn5qUbRw
 JWWnNuERgHPVSd4ctbAeU9SyKKJGHtCipHl6Thu5nTw4VVZtP/tKL8dBP3YQ2Vin92xq
 qv/feSwYbfwhESRTr+N1Cs7R9BWn/BaVZlCzyiprynl58q3FEMxX/6Og+Up+mKiHPO9V
 GlwBycFP7fx5WMKbmv1nxzNB4o2QJoP+2/HZgzqvaza9HTrjc2s4zcu8yOjmRXRa2Ehq
 7mmlfl39mfQNJg9wtSpviCWD39WTrKE4u3W2T7DpvNNFs4r0UgjcDRt2bbEqxj+AD+/+
 TCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759286; x=1716364086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ud73vz92nOsf2EEwTWRfZlN26yWfMncbzbCqjllYE+Q=;
 b=kl9f2LcP5KHxXRYegbntNSl/OQ200kHcv0liLNld8kmvGtb8WpqiiMNMtEVrg+Tvix
 +WRNhz+aLzrthChMcuFMNNV/RNKhL0GobPPMHxVFw8LGi2xJ5SbiWW9gK2D3fpn773sA
 UB9J0P8i+Uk5R1g8VZxDj4cgA+U1BNgGsrbV3JEvmvIwwrg77ssj9Rf1Ne9m/70fRb8m
 BHga/gdEYhsQdnry3texDyTZ4CJHqvJD21DF/M/BZ3eSNvAno1JGFugSvAdAaTUxIsm8
 Vfx/P5nyxT5ygK0+cRRRHul2Bcotq6X5FShvfRm8qNYu3DkbS/e87nCOJLuyFO8e3Qvy
 yo4g==
X-Gm-Message-State: AOJu0YywrW83cthz1RO8EUrdrGNgNcksOfYrfULCD8XQRr5Hz/e2ePuh
 QL/G0mSjVF5A9nfFY/G0rrqz268kcXOoT7aQrgXpAc2m+mc00GYdLm8LCiGtEx6UPu0hDloxAC5
 fZKW41mVFgYyk9a+YJI+mVydQRrhYP5dQyFV21bb7EU/bzSOnH04r1qif1dYqKxALUBOeeKPgkL
 T/e5Z29EKrjnsnIxQ2d1KmisCgBr3rmmxMk0s=
X-Google-Smtp-Source: AGHT+IFzXvh+bJ+HptFSKTibqFddAo04I/2H1d9HYbARcJRKgbKNb2WAu+uoIjxYim+tBTGH9DXd4w==
X-Received: by 2002:a05:6a00:9285:b0:6e6:98bf:7b62 with SMTP id
 d2e1a72fcca58-6f4e02ac4cdmr18180011b3a.8.1715759286091; 
 Wed, 15 May 2024 00:48:06 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm10389060b3a.162.2024.05.15.00.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:48:05 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH v2 0/5] target/riscv: Support RISC-V privilege 1.13 spec
Date: Wed, 15 May 2024 15:53:31 +0800
Message-Id: <20240515075340.2675136-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42c.google.com
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

Based on the change log for the RISC-V privilege 1.13 spec, add the
support for ss1p13.

Ref:https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface.adoc?plain=1#L40-L72

Lists what to do without clarification or document format.
* Redefined misa.MXL to be read-only, making MXLEN a constant.(Skip, implementation ignored)
* Added the constraint that SXLEN≥UXLEN.(Skip, implementation ignored)
* Defined the misa.V field to reflect that the V extension has been implemented.(Skip, existed) 
* Defined the RV32-only medelegh and hedelegh CSRs.(Done in these patches)
* Defined the misaligned atomicity granule PMA, superseding the proposed Zam extension..(Skip, implementation ignored)
* Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip, existed) 
* Defined hardware error and software check exception codes.(Done in these patches)
* Specified synchronization requirements when changing the PBMTE fields in menvcfg and henvcfg.(Skip, implementation ignored)
* Incorporated Svade and Svadu extension specifications.(Skip, existed) 


Fea.Wang (4):
  target/riscv: Support the version for ss1p13
  target/riscv: Add 'P1P13' bit in SMSTATEEN0
  target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
  target/riscv: Reserve exception codes for sw-check and hw-err

Jim Shu (1):
  target/riscv: Reuse the conversion function of priv_spec

 target/riscv/cpu.c         |  8 ++++++--
 target/riscv/cpu.h         |  5 ++++-
 target/riscv/cpu_bits.h    |  5 +++++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/csr.c         | 39 ++++++++++++++++++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 17 ++++++++---------
 6 files changed, 63 insertions(+), 12 deletions(-)

-- 
2.34.1


