Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA73C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLNd-0001ex-Ai; Wed, 26 Aug 2026 17:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bp@kernel.org>) id 1wzKdk-0008TE-D1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 16:54:32 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bp@kernel.org>) id 1wzKdi-0005ds-PZ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 16:54:32 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 247A4412E1;
 Wed, 26 Aug 2026 20:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD01A1F000E9;
 Wed, 26 Aug 2026 20:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787777659;
 bh=VkKsmCZy/rnxubZH0/c+mkwbTtoGfB3dzDANhC1a1BE=;
 h=From:To:Cc:Subject:Date;
 b=D/hepNWOViViQeQTysoJuATuDfCzW7+2EYIkZojpagoK3SKnfgtWNf0wa7Ok0goA8
 tcOcuslE8ePM94LITXUgYlcB3WiumbMsV4weDwM2KM8rsDQ41eOuw5+yCd6zuf+v8Q
 hQL7fblp5D6ZE11qW3b7FwJZaX37NU+/JAX314je6XkV8lGMuy3H5BFDdoG/MuDk6e
 wdqSHbqYomqTLYdUAnlgOCjIKnhGDLkzJ7sMaSMMwokXZmyzybPYrRfx9iYVOZGwTM
 9dtAAIxL+2XPLjDimFAtKytyQU8EqKX8NDOOLdTmc33epEF21vd/BWpoJr1fyAtIGy
 syJcaKN2mJoGg==
From: Borislav Petkov <bp@kernel.org>
To: qemu-devel@nongnu.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] docs/cpu-models-x86: Remove a Texinfo leftover
Date: Wed, 26 Aug 2026 13:54:17 -0700
Message-ID: <20260826205417.2062172-1-bp@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=bp@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Aug 2026 17:41:54 -0400
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

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit

  1bf84a1e2e8f ("docs/system: Convert qemu-cpu-models.texi to rST")

converted docs to rST but left an "@end table" which shows in normal
text.

Zap it.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 docs/system/cpu-models-x86.rst.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
index 126c5a1972b8..9d8f1400d59f 100644
--- a/docs/system/cpu-models-x86.rst.inc
+++ b/docs/system/cpu-models-x86.rst.inc
@@ -25,7 +25,7 @@ Two ways to configure CPU models with QEMU / KVM
     typically refer to specific generations of hardware released by
     Intel and AMD.  These allow the guest VMs to have a degree of
     isolation from the host CPU, allowing greater flexibility in live
-    migrating between hosts with differing hardware.  @end table
+    migrating between hosts with differing hardware.
 
 In both cases, it is possible to optionally add or remove individual CPU
 features, to alter what is presented to the guest by default.
-- 
2.53.0


