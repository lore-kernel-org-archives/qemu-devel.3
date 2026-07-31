Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9385C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpake-0001o6-Ea; Thu, 30 Jul 2026 20:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakU-0001eO-JH
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:14 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakR-0001LI-94
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:14 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso303019a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785456309; x=1786061109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=96KWcuhE8+BvPKd60ur8XtdREvBb8Mo8Rk3bAfuVXDQ=;
 b=S3C2BzmKDnunXaglZA3m4JU7C44AYOYj2RtDYRMycnEgZ2Z26Cg0zs5u2wJ0PwJ6hp
 B+t7vNwlmnayF0qOFfG0LECow4rgkHnjzD67juCLpppf8OZjmKD/xdTNS3ozy71hY9Uu
 0dEuVJYHboTJlgvfPqtjJScWo51MPTC4EV7n5aFcDCgk9VZAP5Iaf0/i9ACojW2nH1/f
 SP/NsmEe0nkZjVpri2e2NHl/zyBWLQzUKYQhyq7APOV3BEv6UBaoZMb0DJq8Qn4nmWTE
 UtYactQFx3qgcPZbrI0hwa0p5j9ozx+Cuhju6u9WXkhJeFB7/APnG6mQEoPS7n2xHOKf
 sXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456309; x=1786061109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=96KWcuhE8+BvPKd60ur8XtdREvBb8Mo8Rk3bAfuVXDQ=;
 b=Na8R1raF6o94aCL6nGaWpe6kG+c+Q/5e5ra5n5tLob/0VWCBxopzD3YZA5TIFXRKLq
 j5rASVCTXmZa+KOxO262iEXB/1B0KUjM6TYUOg0vN/0J2JmUnLq9QlgsemYhctngcU5v
 vOXgPNR7s6fyraR25VMPfKBc1mCsuXd/JhNsEul8ifefiR868qFBeT65oTTP219xH+Xb
 mVTXR4H5V30XdJ7a9i0LiCmyVQycuCMJ0OWSmQIY1LBSop8SJDLq5Jg+f5bBHWqWhgLa
 Q2ng6FkwR5uoB60TWEwg6eh4K0ia3I2ppm7rycJ+MghvQNH6UxlhKJdPjFdQMkE9YIsR
 0KUg==
X-Gm-Message-State: AOJu0Yy/VG5BSmUkz9QoYxNfiYP7tPx90wQ/7YTU1DLW7fn9sOTTWjgH
 G8s5+PsD94nELyXYSUyZ+jPCycBjW2MEGDtEK0rnn43r+rX93B5A//UpkmSUPbvm/eEbeEZE94h
 6rGwF
X-Gm-Gg: AR+sD10+hf+6Sa6Yt5eEu8UFFLWYS9t8rhasW0derq2qhN4inXkYv++glz3YhIYzct8
 OmSXWtq7h+jbh18+KUmeSaoqQtq58zli/tEzoo7PJqtI5GmIZaQA99pSB27Sufia/orS4gysEpk
 ynWB5cyT071qAI1wBQN7HHyadzjWo9Gmshz6LIfGBOFvjUBezBJh87U5ftjK/qnfGZOeRD7sXXV
 T24gzGOGX9+Tlb4XCgT9hbVxxe7BtM276cOmIZ//oZ6pIlZM1kDnRJg3rL6+g83GNtnCk4UcU6f
 sWxSKmgiLd6+xQHZWe0QDlNeATLNUMryOwFKwaEpWz5CLJwpMI6f+1bQvPEojaHiQwdSmhkhUT2
 K1AQwdKlS9uE6n0JltwcXhKyAWuaWjFyLd3v0WzhycxTxmdYxHNW4REIMX3MHgdokYV1zjzCA3l
 AmA7li8/a55cPcZWRE+tOeQHTVRTKsT8/7go/vCCYBY6lS56xQ/tDaud1mfdhPFUI3LLN3oeMn6
 +OudSRFBvz3Rxk5CVhB
X-Received: by 2002:a05:6a20:a108:b0:3c3:9a7f:7307 with SMTP id
 adf61e73a8af0-3c90075a083mr4323934637.24.1785456309243; 
 Thu, 30 Jul 2026 17:05:09 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a999ddsm2656460a12.4.2026.07.30.17.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:05:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
Subject: [PATCH 05/11] target/loongarch: Expand bitswap inline
Date: Thu, 30 Jul 2026 17:04:57 -0700
Message-ID: <20260731000503.170446-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731000503.170446-1-richard.henderson@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The bitrev_[48]b instructions reverse bits within each byte.
This may be accomplished by reversing bits within the entire
word followed by reversing the bytes with the entire word.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/helper.h                 |  2 --
 target/loongarch/tcg/op_helper.c              | 11 ----------
 .../loongarch/tcg/insn_trans/trans_bit.c.inc  | 20 +++++++++++++++++--
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 4b0fc81db6..e76c73c775 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -5,8 +5,6 @@
 
 DEF_HELPER_2(raise_exception, noreturn, env, i32)
 
-DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
-
 DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
 
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index 37afa8e92d..f41f0cb1e6 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -22,17 +22,6 @@ void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
     do_raise_exception(env, exception, GETPC());
 }
 
-target_ulong helper_bitswap(target_ulong v)
-{
-    v = ((v >> 1) & (target_ulong)0x5555555555555555ULL) |
-        ((v & (target_ulong)0x5555555555555555ULL) << 1);
-    v = ((v >> 2) & (target_ulong)0x3333333333333333ULL) |
-        ((v & (target_ulong)0x3333333333333333ULL) << 2);
-    v = ((v >> 4) & (target_ulong)0x0F0F0F0F0F0F0F0FULL) |
-        ((v & (target_ulong)0x0F0F0F0F0F0F0F0FULL) << 4);
-    return v;
-}
-
 /* loongarch assert op */
 void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
diff --git a/target/loongarch/tcg/insn_trans/trans_bit.c.inc b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
index 3d24e320ce..1200f931fa 100644
--- a/target/loongarch/tcg/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
@@ -178,6 +178,22 @@ static void gen_masknez(TCGv dest, TCGv src1, TCGv src2)
     tcg_gen_movcond_tl(TCG_COND_NE, dest, src2, zero, zero, src1);
 }
 
+static void gen_bitrev_4b(TCGv dest, TCGv src)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_trunc_tl_i32(t, src);
+    tcg_gen_revbit32_i32(t, t);
+    tcg_gen_bswap32_i32(t, t);
+    tcg_gen_ext_i32_tl(dest, t);
+}
+
+static void gen_bitrev_8b(TCGv dest, TCGv src)
+{
+    tcg_gen_revbit_tl(dest, src);
+    tcg_gen_bswap_tl(dest, dest);
+}
+
 static void gen_bitrev_w(TCGv dest, TCGv src)
 {
     tcg_gen_revbit32_tl(dest, src, TCG_BSWAP_OS);
@@ -199,8 +215,8 @@ TRANS(revb_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
 TRANS(revb_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
 TRANS(revh_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
 TRANS(revh_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
-TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
-TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
+TRANS(bitrev_4b, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_bitrev_4b)
+TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_bitrev_8b)
 TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_bitrev_w)
 TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_revbit64_i64)
 TRANS(maskeqz, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
-- 
2.43.0


