Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159EDC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 21:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkV2G-00033W-5h; Tue, 18 Feb 2025 16:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkV2D-00032J-C2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:21:41 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkV2A-000336-Sh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739913695; bh=7MkVBQfa/QDS9tzkbgaSyr0CpRT/Zux2KixYtMSdhvI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=My8Az+iugNF1JKtBfgZFx5DZJI+elk2NKdjVHj56cDau7nB9EiEB0RXZrqmUmtinC
 oR6eTq0uW0Ih6/Tty9ugxV0dzwo0FjP22R57pa4RU9azPQ80ORmvLWfK1gZstkRD1R
 pjtcK+PTsi9U7i1EeykI2T5wcT102qvTq4HqPmFDEqhgEgzlCJ/SYBn7jrSd79T+QR
 +bHYlk5DQr9bHvNOP20QXIQqk5rrnaJaTcKK4CaYQViu3OoytFMlC4gXd50iQcflvJ
 FcDortA8UehkFBNDA1vo5iPeztP6PPti8TpAd8XSiRd89bAEsrC8/wCnLXyOdMRi3e
 P64wSV6pDEqBg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id C9ADC3F22AED
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 13:21:35 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id 9xxpqjs8ffs8; Tue, 18 Feb 2025 13:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739913694; bh=7MkVBQfa/QDS9tzkbgaSyr0CpRT/Zux2KixYtMSdhvI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Un8m6yvv1pgaQ90FBOzC7rMQkAzItWumTTRc666/2KrWPSKlbzC3GfescWoqG5DaV
 Fe1InjWMbjtUGduTnhtyQwzJQAQBLARmN1S/7caX/VZE0qz48I1ZtUGc8SzL5j0WCZ
 vO7ohU1Q9IFukFpQufkp3wNCTCA0xA3rG9GIaI290aYzz5gghEg5JT2ylh+WeGnHIO
 TKi1tGWrA5AudrV/gjBvi5c1UYI2Fr+kQQhmtc6SWbXE8sPp7C3LoTSSL29bQcLvh+
 pL9SJKYALRDQJg+0VgbRroRiP0/arWYt7SDyhsUNU1gRcPsDEkHAM3nCQgfAyl4RT9
 /+iGQp+87GVNA==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id D01873F204E1;
 Tue, 18 Feb 2025 13:21:34 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id B5EA01E60096; Tue, 18 Feb 2025 13:21:34 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 0/4] Renesas RX target fixes (v2)
Date: Tue, 18 Feb 2025 13:20:59 -0800
Message-ID: <20250218212103.2024039-1-keithp@keithp.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215021654.1786679-1-keithp@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With feedback from Peter Maydell and Richard Henderson, I've updated
this series to address two concerns:

 1. The hardware model is now responsible for guiding the CPU reset
    process.

 2. Loading the reset vector from memory is now delayed until cpu_reset
    is finished to ensure memory_dispatch is initialized.

First, there are two critical flaws in the emulation. These are
needed for this model to work correctly:

 1. The exception vector base is 0xffffff80 not 0xffffffc0. This
    prevents exceptions from working at all.

 2. Many tcg helpers inappropriately used TCG_CALL_NO_WG even though
    they modified virtual registers stored in global memory. This
    causes these operations to fail unless one-insn-per-tb was enabled.

The third patch changes how the cpu is reset so that it is driven by
the hw code instead of the target code. Now the cpu is reset each time
qemu is reset and the initial PC value is either set from the loaded
kernel or from the reset vector. This should look a lot more like how
other models manage this process.

The final patch adds the ability to load an ELF file rather than
a binary memory image. It's purely a new feature and not required for
this model to be usable; without this, it's fairly easy to use
the loader device; that just requires the loaded image to include the
exception vectors with the correct reset vector value.

Keith Packard (4):
  target/rx: Set exception vector base to 0xffffff80
  target/rx: Remove TCG_CALL_NO_WG from helpers which write env
  hw/rx: Reset the CPU at qemu reset time
  rx: Support loading of ELF files too

 hw/rx/rx-gdbsim.c  | 72 +++++++++++++++++++++++++++++++++++++++++++++-
 target/rx/cpu.c    |  9 ++----
 target/rx/cpu.h    |  3 ++
 target/rx/helper.c |  2 +-
 target/rx/helper.h | 34 +++++++++++-----------
 5 files changed, 94 insertions(+), 26 deletions(-)

-- 
2.47.2


