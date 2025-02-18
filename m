Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC62CC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 02:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkDlU-0004HQ-DP; Mon, 17 Feb 2025 21:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tkDlF-000462-9L
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 21:55:01 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tkDl8-0000VB-UO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 21:54:59 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22100006bc8so47095905ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 18:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739847293; x=1740452093;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ansaoQj2VIkNZSxiwgYKiw4k0MHlhOwmkCCrsFy9sk=;
 b=hkFr5jsSKhCFa5HkzXquPxsboxAOqItVgnnpV+qtl28XttV/+RC46iCB5vvUjlJad6
 p1JW6dNQ/oWe3zk4HLE6M7mX9S/nqvTltgpbRACQ77q29EYSoNq47I4zf4VP+uMUd9fg
 IFce5aHS95xWFb3DGXkyR7Wu6w1pde2fVmgXSSkzkjb5n7AQoxyhMhcZRfjHX+X5+ysr
 LCMkXanOwTUbnLIbfkTYpDt5kPvpjOrkeCcfMq5rw5WYSy0UXrXRzMwulsVqQwUQPx6T
 0KP1lh5tM5SgE5kx82CyvYHLrPnHGwYP89OcKRcWOkE4qgmrYS5lhlI0TK04X1SFhTZ7
 Q+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739847293; x=1740452093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ansaoQj2VIkNZSxiwgYKiw4k0MHlhOwmkCCrsFy9sk=;
 b=mLXlhSENlmMAtChR3v1fIi1kzyPFD8HgbD2+u66FjukC8cSx6UEj1FE6rbs2SWifi3
 D+ZF7h9lDWoeYD1ZXUJqFsrZYkAjriw5v8V0NuEMAj988N2FA2I4t+9eXrIcQOzP6nlB
 teLHjLPaVWt3Ot6ZftxG79+7jFstaEpBgw88qmYdj1V8rNQqHJSRhdAoCseD5v7vwii1
 nE9QZtLVvGs2h7X6Lj+TT2RSGMW3nI+Uxu+mohuOErEhdZJRVT3fTudWQgqG9cSemjuj
 8oARS2jWKIdJ9QrMuqE+CElYKcQ0cPaSbD0E7GBFemsdrLnrBDjySu6Y9vziD/Q19DD6
 ODnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXKth9o/0y9WvBZPs433DYYv7pYj7e1Dl9DUipxJzt5Vsuygcudh+IyPyolAKJazQIiFaBbj7OgYfb@nongnu.org
X-Gm-Message-State: AOJu0Yy/nARF8blUrWevC7VZJrpfjXSzvbFzaDft2v4QM9u9iNZBEaO/
 f7FK+Weee4qfgREXB/JpckAwhWJ3GFIolS1CyLjRDce5qy5/Lx24ittGZo8GcIc=
X-Gm-Gg: ASbGncuZtgdWy/NgWJqDLIjv58chFRZl0bhP0u5oOYkP8vlcaTf0rTk0EWikUy/avqc
 Pgy8lNCYP29rDJiaSLanO10CpchQI647tHjqVvkG+D/G5tEyKeKwxWEAc6At/ilt6ODEuDnRH3A
 SAFM9jyN1lhjvO0X/wTAvWCz12QU7UUqyWmfSyTBp6CKKsGzkqrQldZqqDaonfNoL4kzR9lPFLD
 8JnqQjP2P29JlLutVvMPVAeP990/k6kDOEr+zyBRzZqIgtKT9TOf/fP4ocrIcK/RBRsg9BuBM0T
 1DTOBP7vQgfgP95Cz5uAp1DXfw==
X-Google-Smtp-Source: AGHT+IHx5PshsvLEAlI4zKHqHquOxs/xHzGaDPJb6I+3G83+tZ08pz6of8sx0EYU4p2zNg+4LzfUwA==
X-Received: by 2002:a17:903:41c3:b0:21f:7821:55b6 with SMTP id
 d9443c01a7336-22104030832mr188581915ad.13.1739847293079; 
 Mon, 17 Feb 2025 18:54:53 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d473sm78293595ad.166.2025.02.17.18.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 18:54:52 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>
Subject: [PATCH 2/2] target/riscv: fixes a bug against `ssamoswap` behavior in
 M-mode
Date: Mon, 17 Feb 2025 18:54:46 -0800
Message-Id: <20250218025446.2452254-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218025446.2452254-1-debug@rivosinc.com>
References: <20250218025446.2452254-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Commit f06bfe3dc38c ("target/riscv: implement zicfiss instructions") adds
`ssamoswap` instruction. `ssamoswap` takes the code-point from existing
reserved encoding (and not a zimop like other shadow stack instructions).
If shadow stack is not enabled (via xenvcfg.SSE), then `ssamoswap` must
result in an illegal instruction exception. However there is a slightly
modified behavior for M-mode.

Shadow stack are not available in M-mode and all shadow stack instructions
in M-mode exhibit zimop behavior. However, `ssamoswap` can still succeed
if MPRV=1 and MPP is non-zero (see section 2.7 of zicfiss specification).
This patch corrects that behavior for `ssamoswap`.

Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")

Reported-by: Ved Shanbhogue <ved@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index e3ebc4977c..ec016cd70f 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -15,6 +15,13 @@
  * You should have received a copy of the GNU General Public License along with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
+ #define REQUIRE_ZICFISS(ctx) do {       \
+    if (!ctx->cfg_ptr->ext_zicfiss) {    \
+        return false;                    \
+    }                                    \
+} while (0)
+
 static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
 {
     if (!ctx->bcfi_enabled) {
@@ -77,7 +84,8 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
 static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    if (!ctx->bcfi_enabled) {
+    REQUIRE_ZICFISS(ctx);
+    if ((ctx->priv != PRV_M) && !ctx->bcfi_enabled) {
         return false;
     }
 
@@ -97,7 +105,8 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    if (!ctx->bcfi_enabled) {
+    REQUIRE_ZICFISS(ctx);
+    if ((ctx->priv != PRV_M) && !ctx->bcfi_enabled) {
         return false;
     }
 
-- 
2.34.1


