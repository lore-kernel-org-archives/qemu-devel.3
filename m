Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB6606A331
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=ENaF0yAV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLvKw-0007mO-3p; Wed, 28 Oct 2026 00:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvKr-0007ib-Sn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:32:25 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvKo-0001gW-Aq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:32:25 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3ad9c5b4dfbso42664a91.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 21:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793161940; x=1793766740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UjTYxjwBStG+zG+XaE/upOrdCBHCoeR1wLAXIfObVG8=;
 b=ENaF0yAVz1cQqZINqlAzP3a4UzbaX7sRQtsyLMGRARpIxn8J6Z7EzbDRtUr8mFxa/O
 /FDC1vXMiUCuw3trr9OBA/LDF8rpFF1sJSf8cbBRGIlgBMCCQuXSQ1IgCYTMR9pKbZhz
 0UCgN5zmLME1pTRAw4zbUGcQaExnAYJ0TcTCoTfoeQE+x/PusJQVukL7o7J9Z7HZOEMM
 zzA+QVMpvkABJnDXECAeoNihfA0A6QCL6Zvr12WPspvE5eyuQi+OZv3cNtEuQ2jDT+v2
 IqEpv/4LS74QZXms/xz+Kq3ec1PRjEkmR7TnByJJk+zhjWaFtEqPvaNYwS6VwI1/1o2s
 qJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793161940; x=1793766740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UjTYxjwBStG+zG+XaE/upOrdCBHCoeR1wLAXIfObVG8=;
 b=k07a9oxxujCL+LqX2yMy9hJoamDvugGnsAjvvRg+mElvMVQWpnbbL0UXMBWNTEgqZn
 64shDUIdS6JkJ6XfgOtzVQP3/FX5eBxfpQFePtWNZO5PLfnyH8oPcZInpuI/Zgx8kekm
 duNOvIFumHOBg7Wc0iFzRQganwnq0jNG5CafeFL5iP8yEyoQac+zSrwjQ7vJ34bTee+F
 5wx8immaqSZSMWKAPKsBzPAIJP6GPSn+1MDHwAgxJ0td9PyLye1A00yl7hT2X/9d0hCr
 WFY/qkNW7dgqC5yZrf9oagYHuiuwrbx72slBgVzNMEhcrnKyV2m0GyKqoWVbWq6AWfKw
 DGmQ==
X-Gm-Message-State: AFq9FYIYLRD0QUlHxeBgjhDQpqeLOQ8CLCaNdcaBP9P4GuPSW3ut/+oH
 86TU86uR2+uEqjwm7eXJI+5aUKj++e8sr9kx9Mj2iPXCzeJP79iWJhpJ0ospG6E2EW04UZylE0R
 6JgD2IAY=
X-Gm-Gg: AYBFou2tGR2vq+Z0bUs4fRcD+QpSZQ0ldRnoo4SD8tcoh3UBIOoP+l0W/CtgpUzxJz1
 e9sx0sEiEnQXsCV6Dd45cXNP/j2szPAuOzm2H2UcQRSw5oDols3BRaEYpIywqZcPUxhwoSq55RW
 F7FNSLxv0LvY9jqbzu/qkUIs/Tw5kJVPZHO8w6IsHBmEyH7f9K4FRgpJ90CqTQ//ei2J2gjE/Nw
 lMSNaIThY0CBxDiBUHimlxr+x3loxLoY3fCbLPKnzmw2ol1W/HLK83dsb6YAgRwG0NVTAz023hS
 t5ebcaXUrv8cQCamiLK14xF/07e7Nl60tkEuRSIBBG+PDlqToVvsDIS47+AhOJs9iLBRwzw7dWt
 kpMa1VZhElYlXRpwsu90+ZYR7tu0jbfdOjH+a9RPQRaOPg+9CHEKHucAWZqlzNwmQzdO3wThov4
 eJVxnSR8c8F5jgZ55Hv7jswTSCwvvhe2DYwTzxBlQnBzilYlslgpdAAwe+YktImFdSdv5gKc0gX
 N9PgGeHRE22pTCjMGYDGKOczMv6/N+kNGF9w1WYbbvSizQINqsKPbDXgLUS5cNmsfFNaH8Atc8x
 fXlIEbuMyeZyCTBTsOj251OsXL2hoCNe3di4f9aMRi1rW7Zo0zWXel3nY5KVcE959qvFwW/2V7W
 wVjg=
X-Received: by 2002:a17:90b:3c0c:b0:3a8:1759:2217 with SMTP id
 98e67ed59e1d1-3ae57e5769amr1399241a91.2.1793161940109; 
 Tue, 27 Oct 2026 21:32:20 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5d45a8sm1024470a91.17.2026.10.27.21.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 21:32:19 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 10/10] docs/atlantis: Update Atlantis documentation to
 include the RCPU
Date: Wed, 28 Oct 2026 14:30:59 +1000
Message-ID: <20261028043059.600498-11-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028043059.600498-1-portias@oss.tenstorrent.com>
References: <20261028043059.600498-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This updates the Atlantis documentation to include new machine
properties for running the RCPU.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 docs/system/gdb.rst               |  2 ++
 docs/system/riscv/tt_atlantis.rst | 40 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index b6d8f8e77d..3777630337 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -79,6 +79,8 @@ debug some interaction between kernel and user-space you are better
 off running your guest program with gdb either in the guest or using
 a gdbserver exposed via a port to the outside world.
 
+.. _GDB multicore:
+
 Debugging multicore machines
 ============================
 
diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
index d94d064f4f..77dfacff3c 100644
--- a/docs/system/riscv/tt_atlantis.rst
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -12,10 +12,37 @@ tt-atlantis QEMU model features
 -------------------------------
 
 * 8-core Ascalon-X CPU Cluster
+* RV32 Real-time CPU (RCPU)
 * RISC-V compliant Advanced Interrupt Architecture
 * DW8250 compatible UART x5
 * 4 PRCMs (Clock and Reset Controllers)
 
+Boot options
+------------
+
+ * ``rcpu`` enables the RCPU model to run alongside the Ascalon cluster and is
+   enabled by default. When the RCPU is enabled, ``UART0``, the RCPU's console,
+   will be mapped to the second -serial on the command line.
+ * ``bootrom`` binary to be loaded into mask ROM and run by the RCPU (no effect if the
+   rcpu is not enabled)
+
+To enable the RCPU model with a custom binary and the RCPU console on stdio:
+
+.. code-block:: bash
+
+  -M tt-atlantis,rcpu=on,bootrom=../path/to/binary.bin -serial null -serial stdio
+
+ * ``smp -cpus`` The smp cpu field includes the RCPU count. When rcpu=on, the
+   number of Ascalon harts created is smp.cpus - 1.  When rcpu=off, the number
+   of Ascalon harts created is smp.cpus. To run with only one Ascalon hart and
+   no RCPU.
+
+.. code-block:: bash
+
+  -M tt-atlantis,rcpu=off -smp cpus=1
+
+
+
 Known limitations
 -----------------
 
@@ -39,3 +66,16 @@ and Linux with default configurations.
 The development board hardware will require some implementation
 specific setup in firmware which is being developed and may
 become a requirement or option for the tt-atlantis machine.
+
+Debugging
+----------
+
+Ascalon and RCPU are on separate CPUClusters which allows gdb to put Ascalon
+and RCPU on separate inferiors. This prevents issues with switching between
+RV32 (RCPU) and RV64 (Ascalon) targets.
+
+By default, gdb will connect to inferior 1, the Ascalon cluster and the RCPU
+will be on inferior 2.
+
+gbd does not handle multiple inferiors by default, see :ref:`gdb multicore`
+for how to connect to inferior 2.
-- 
2.43.0


