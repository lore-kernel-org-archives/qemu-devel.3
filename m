Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5DB1125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LDp-0004OB-1w; Wed, 11 Mar 2026 11:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LBL-00080B-S4; Wed, 11 Mar 2026 11:09:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LBJ-0005gJ-TQ; Wed, 11 Mar 2026 11:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241482; bh=1HjWwuWMbJ/lQLP8MJ0zy8gCLPzqeUaEQHlIXn44DXw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bdpZk7nedMhY7yGQyqTJufDTwNmWE5Q3v6B4P92aKPqSE9WL3GOIGZ8R8yjnr4x/T
 OWN78TSQPnIM7Vci0M77KewqnAaULf7J6S6n/ZMv93F3H4sxmJXrthd8TALJ0yDAbb
 Fzz9sTJrlVrI+foHeyWs0WL8ZrLzSFcQ0VtTHpBgmJrCsaFNumJTTa7Q7uobZwr4k+
 PKm8sNWc++31HdNRrmyF+JAmHfCWLG9jK3Lrxwvr3umI9giDI7SsTKzSP/15Zii1S8
 cI2X6npdwCy3cxi93wDZbLenDLSFDsOyx0qP4CRfGGom20KdSHri28H/x3lOYJCWGX
 x23iMIqzd3f7A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D738E191E9D;
 Wed, 11 Mar 2026 18:04:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C327E37C2DE;
 Wed, 11 Mar 2026 18:05:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Wei Liu (Microsoft)" <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 26/46] target/i386/emulate/x86_decode: Fix compiler
 warning
Date: Wed, 11 Mar 2026 18:03:02 +0300
Message-ID: <20260311150327.1084669-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

When compiling for i386-softmmu under MSYS2, GCC emits the following warning:

  In function 'get_reg_val',
      inlined from 'calc_modrm_operand64' at ../src/target/i386/emulate/x86_decode.c:1796:15:
  ../src/target/i386/emulate/x86_decode.c:1703:5: error: 'memcpy' forming offset [4, 7] is out of the bounds [0, 4] of object 'val' with type 'target_ulong' {aka 'unsigned int'} [-Werror=array-bounds=]
   1703 |     memcpy(&val,
        |     ^~~~~~~~~~~~
   1704 |            get_reg_ref(env, reg, rex_present, is_extended, size),
        |            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1705 |            size);
        |            ~~~~~
  ../src/target/i386/emulate/x86_decode.c: In function 'calc_modrm_operand64':
  ../src/target/i386/emulate/x86_decode.c:1702:18: note: 'val' declared here
   1702 |     target_ulong val = 0;
        |                  ^~~

In the calc_modrm_operand64() case the compiler sees size == 8 to be mem-copied
to a target_ulong variable which is only 4 bytes wide in case of i386-softmmu.
Note that when size != 1, get_reg_ref() always returns a pointer to an 8 byte
register, regardless of the target_ulong size. Fix the compiler warning by
always providing 8 bytes of storage by means of uint64_t.

Fixes: 77a2dba45cc9 ("target/i386/emulate: stop overloading decode->op[N].ptr")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Wei Liu (Microsoft) <wei.liu@kernel.org>
Link: https://lore.kernel.org/r/20260223233950.96076-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit c86bca1671e9e4161e2a93d73514384de510bbf3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 2eca39802e..aa14d42c8f 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -1689,7 +1689,7 @@ void *get_reg_ref(CPUX86State *env, int reg, int rex_present,
 target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
                          int is_extended, int size)
 {
-    target_ulong val = 0;
+    uint64_t val = 0;
     memcpy(&val,
            get_reg_ref(env, reg, rex_present, is_extended, size),
            size);
-- 
2.47.3


