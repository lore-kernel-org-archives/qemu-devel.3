Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A25C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 07:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5eFS-0000Pg-6i; Sun, 13 Sep 2026 03:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1x5eFP-0000PM-S0
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 03:03:31 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1x5eFO-0006wU-7b
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 03:03:31 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso10035935e9.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789283009; x=1789887809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G8Yi8RLvK+tUbuDO9IzdFTX3o4OGXx9ityAEIiXj6y0=;
 b=C16NXkZ/pZqGsboxVnE7vK4HyiEbtM5tpP4xkN+fdTwhYD4jwbE7IU4vwEGgbP/WR1
 OVINe8wEITQJ8D9XRpn6Ixldh6+JXxNkVUZLpCM/c1Ssvc3svB5W8EVmiUCS1goWCLIy
 YF9ZIlN5q5dq61rO0rPDWRnt/LNIbqpCZQh6f9zpOExb6S6Kipc8wwM3f7wuH1x8g3A7
 rVDqN38HWKZfYpksSp24w/4fwsnm6kQrBwCdv7n6eX7osjzle/k2jNmV5qsRPbb+c8J3
 GFBqgnSNd9pDqaFghEgcTtTn0N/mFCg7Boc+LXrHL/G/MtKHz4TOdcBACZsjPvE6cXJx
 ZxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789283009; x=1789887809;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G8Yi8RLvK+tUbuDO9IzdFTX3o4OGXx9ityAEIiXj6y0=;
 b=aglLk5UhcRiBRmT5DtBTdUe1UbuVIECaM8Uk68aZvPLM1iy145tyH+8auHiXsYmoLg
 a22BdW5jo7jUFawiJ31QD3erN9JxsY3s8MlHaJ/iuxHxsMEVfR6lQtEtFicN8ueq5BWH
 lQxwnQ3x69OxjpUcfg4lN8tmbBphy6d3AIFGZWgxcRa7DVXWWDRuAyy0ZUB51g0mpE24
 0Rcv/bFK534s/mE8X3/rHzlGZF7roaLGIasODjKpAyYJXnyfa1QucaVDMudt8ifhZIsK
 xnw1qotuOAizgl252t7JE2hfgpZZ09+PHARkNLRAoeA5t9h/KPmzwfwGdDSwuKXjmbzs
 YHRw==
X-Gm-Message-State: AFuF++my7hXomGW/oRNCYDikeafkMF+sA/F+VQhbvsicVlc83MlOIplW
 shycZN+CEb8z8zf4MeNvTbLXLF6Ng46zuzjtOi/gZ99wj6+v3OpAa1RSFRPwIQ==
X-Gm-Gg: AYBFou3oemdxg/MNUZ5PiIpG0NIK+PTCvQY7a1liF99jDvLl0dBbEdSL2Ojj7clg1u/
 c+AiavjVV+8CczN3Eai85jJuVgHUp4J4gWg3h7DpyCqU9yYg+njnvHJQ9Tet9uek5vw6Rfb+1In
 P2fg9Md3SKOUcvgEyKea+Qo2HsbPbcqJMPYbYFMnQCGTKrDx8GxTHzW2HHe31QKrYW76MIQ1TPp
 FD0fIeBuwGlW3TZm4AyacZACdEU/ljnz7DoajH+mBIByfz8eIUes+4CxD4ChdsbDQHNZt36AmM+
 cy1Iut44DROTUVsKJhHJbw0x/hFfBdN9IspmrLUJhxTX/X97AWtZOIpc1BfRV0PKBaPEhh83mMZ
 I9RuW5sC6Ry3duxnKh3W9ZlbtueW6N4lVbUIH+y8b8ylAxenCb/hzd1Jwf9t5DX5aoOW2tlMDyn
 +ibGJLLsuJ/9GBadqxCOxZ5c9AS5J8ZzUjYJzodfMEAwBUkrvHhlxuTKarN+iA12Iy0fAAPMdxH
 oVjEuPI5N74yi4RGwxRl8XibB2MU/yg8d4U9HVBJ0o/uMf7y0zBEg==
X-Received: by 2002:a05:600c:b96:b0:49d:1916:59c7 with SMTP id
 5b1f17b1804b1-49e619831a9mr124044645e9.7.1789283008310; 
 Sun, 13 Sep 2026 00:03:28 -0700 (PDT)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26d4e3f3sm328384495e9.15.2026.09.13.00.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 00:03:26 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <ali@iusegentoo.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PULL 1/1] target/or1k: Implement l.extws and l.extwz
Date: Sun, 13 Sep 2026 08:03:03 +0100
Message-ID: <20260913070303.1010504-2-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913070303.1010504-1-shorne@gmail.com>
References: <20260913070303.1010504-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shorne@gmail.com; helo=mail-wm2-x10.google.com
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

From: Ali Ahmet Memiş <ali@iusegentoo.com>

l.extws and l.extwz belong to the ORBIS32 instruction set, but the
decoder has no entries for them, so they raise an illegal instruction
exception on every CPU model.

On a 32-bit implementation both are register moves: there is nothing
above bit 31 to extend into. Implement them as such.

Found while writing an OpenRISC port of Valgrind.

Signed-off-by: Ali Ahmet Memiş <ali@iusegentoo.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/or1k/disas.c      |  2 ++
 target/or1k/insns.decode |  2 ++
 target/or1k/translate.c  | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/target/or1k/disas.c b/target/or1k/disas.c
index dc025bd64d..0a46d68d30 100644
--- a/target/or1k/disas.c
+++ b/target/or1k/disas.c
@@ -71,6 +71,8 @@ INSN(exths,  "r%d, r%d", a->d, a->a)
 INSN(extbs,  "r%d, r%d", a->d, a->a)
 INSN(exthz,  "r%d, r%d", a->d, a->a)
 INSN(extbz,  "r%d, r%d", a->d, a->a)
+INSN(extws,  "r%d, r%d", a->d, a->a)
+INSN(extwz,  "r%d, r%d", a->d, a->a)
 INSN(cmov,   "r%d, r%d, r%d", a->d, a->a, a->b)
 INSN(ff1,    "r%d, r%d", a->d, a->a)
 INSN(fl1,    "r%d, r%d", a->d, a->a)
diff --git a/target/or1k/insns.decode b/target/or1k/insns.decode
index 0d6f7c29f8..cbf8af7f8b 100644
--- a/target/or1k/insns.decode
+++ b/target/or1k/insns.decode
@@ -112,6 +112,8 @@ l_exths         111000 d:5 a:5 ----- - 0000 -- 1100
 l_extbs         111000 d:5 a:5 ----- - 0001 -- 1100
 l_exthz         111000 d:5 a:5 ----- - 0010 -- 1100
 l_extbz         111000 d:5 a:5 ----- - 0011 -- 1100
+l_extws         111000 d:5 a:5 ----- - 0000 -- 1101
+l_extwz         111000 d:5 a:5 ----- - 0001 -- 1101
 
 l_add           111000 d:5 a:5 b:5   - 00 ---- 0000
 l_addc          111000 d:5 a:5 b:5   - 00 ---- 0001
diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index eb4485312f..e00ef45b9b 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -502,6 +502,20 @@ static bool trans_l_extbz(DisasContext *dc, arg_da *a)
     return true;
 }
 
+static bool trans_l_extws(DisasContext *dc, arg_da *a)
+{
+    check_r0_write(dc, a->d);
+    tcg_gen_mov_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    return true;
+}
+
+static bool trans_l_extwz(DisasContext *dc, arg_da *a)
+{
+    check_r0_write(dc, a->d);
+    tcg_gen_mov_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    return true;
+}
+
 static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-- 
2.53.0


