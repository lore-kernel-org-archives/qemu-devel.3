Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C3BCA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 05:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuOrU-0002iT-SY; Fri, 05 Sep 2025 01:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuOrS-0002hf-5k
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 01:19:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuOrO-0006u1-9F
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 01:19:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45cb659e858so13625085e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 22:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757049579; x=1757654379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qiesEZLirOm2kTsIFlH0zMZ4nblsrNRxWqDrcxVvyy8=;
 b=phpzEbVCoL6X9EJgQFV/J+gilmhClTjXkp/AjaUzgw9EEG2/NVTs4vT+Hqym5Zq9Xp
 ymkHAEVmatHq+e9mNwBdTwO1vT/CCxq38RhcVks99t8OI3fEVneh6MvrfTtdhB+4+ySv
 Y/emn6WNfP6OPqWgOnckIRYvg+nnnPnnhOtrAeWGcCYVQV61TA+0iOwqVrTHUZ6xv3sr
 Ky4nQO3SU5plKU32/TxJAgaVeQ6C8B7qWSQfaR0CX+ZGo5uZ5qzQb402lBD67e2KYd0s
 awmRtHGllvGQQX1R0t8n1JLTkJjGfQi8+Lpfjs7ViYlN7QrxneAoASA5V61/i9JnPjqx
 BTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757049579; x=1757654379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qiesEZLirOm2kTsIFlH0zMZ4nblsrNRxWqDrcxVvyy8=;
 b=Vm/gsWfjyA4WgAU59UVaFmqlywtSD7rEGkjtnjYYPb0qjkyJmGcQu7ph+j8raASO4r
 e0CSUre1PJcOukBBT2AVWAflzOaQFTEWk0q7PYhk15b79iNFhPG9tXcgmPilLPnL6eVR
 mrzr6Kv2cEAnTs3LfSVG8OGhc+m5ONogTQP7MsbbrPw3JTG2n8df3/m7uHtjfPEp6KD7
 uD65jP8GC8uxLJ6ScLolU6VKFi/54sDWNgLE1I/hdWXWxW4Qp+P4MLcu8fn9cWptdY+n
 j3vYXoHT/VKNkFEkiaZ4ZoKHf5b9d04zspwPO+oL6CC9OtK6XUfyX1SdUtYJrv3LLAKU
 IkGQ==
X-Gm-Message-State: AOJu0YyxbvFPQv65S/VN5S/SfvJoEAwUvS9yh8DObQ0GRIwc6dqfMv52
 Aj64HV6ucbTBVErP/fh4Y9IRlxVX4okX1rtWd8/50UP9Tre5bqQqMA3cIKBjn4Lqfb3KODZmhYb
 6hxWtovM=
X-Gm-Gg: ASbGncs7yKusPAXoWGWfuossbdPbXcPq0bfzGEt/ytnwQfwhtGbmE0gwCAAI3G9ueRS
 iQzQ/PPUkkjCyD4H+WK2Sp4zySbW+CV73peYJVxQ06YpE6XOa8tHQQuyLnRJJVPANlm39VSXk1B
 EVLtd21Vl3dnKef0WeeREn9nvSG5AxFiDbSczRDPnmHaXEfc8jyxAe1q8/W7Kmq64eP4LZPysvy
 7xssADg6obvEde4nMdkDhF8CHpaAZqSVPyITc1TRksAs4c7gnR9TRhF+1xCyVRfN2VLyymXJHSo
 X3TmaLyTWPwNESPEWjQCurs3b6hdzmOCHsc4uJyPOfzsCL48SFec1SCw1l2hUTfimR26JUiT/Ns
 8jeLVe4qivrni8So5JbZr5C9o4Fu6jX7T7aQfvgfzfmtKL5yJokpJnBvA/b5mn9AMvN4KSlAKGV
 A4CYrLM+o=
X-Google-Smtp-Source: AGHT+IHfaGvCPz3aG3pXV/5/2cTN38/vX/U+FWL9jOA0lcozpa/APkeDwDhHEjKZaWOF6m/mKstSnw==
X-Received: by 2002:a05:600c:46c8:b0:45b:7c09:bc0e with SMTP id
 5b1f17b1804b1-45b8549c7admr176386115e9.0.1757049579547; 
 Thu, 04 Sep 2025 22:19:39 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dcfcba94esm34360325e9.2.2025.09.04.22.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 22:19:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 1/2] target/sparc: Loosen decode of STBAR for v8
Date: Fri,  5 Sep 2025 07:19:35 +0200
Message-ID: <20250905051936.92815-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905051936.92815-1-richard.henderson@linaro.org>
References: <20250905051936.92815-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

Solaris 8 appears to have a bug whereby it executes v9 MEMBAR
instructions when booting a freshly installed image. According
to the SPARC v8 architecture manual, whilst bits 13 and bits 12-0
of the "Read State Register Instructions" are notionally zero,
they are marked as unused (i.e. ignored).

Fixes: af25071c1d ("target/sparc: Move RDASR, STBAR, MEMBAR to decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3097
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 12 +++++++++++-
 target/sparc/insns.decode | 13 ++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b922e53bf1..c2ffd965d8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2823,12 +2823,22 @@ static bool trans_Tcc_i_v9(DisasContext *dc, arg_Tcc_i_v9 *a)
     return do_tcc(dc, a->cond, a->cc, a->rs1, true, a->i);
 }
 
-static bool trans_STBAR(DisasContext *dc, arg_STBAR *a)
+static bool do_stbar(DisasContext *dc)
 {
     tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
     return advance_pc(dc);
 }
 
+static bool trans_STBAR_v8(DisasContext *dc, arg_STBAR_v8 *a)
+{
+    return avail_32(dc) && do_stbar(dc);
+}
+
+static bool trans_STBAR_v9(DisasContext *dc, arg_STBAR_v9 *a)
+{
+    return avail_64(dc) && do_stbar(dc);
+}
+
 static bool trans_MEMBAR(DisasContext *dc, arg_MEMBAR *a)
 {
     if (avail_32(dc)) {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9e39d23273..1b1b85e9c2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -88,7 +88,7 @@ CALL    01 i:s30
 
 {
   [
-    STBAR           10 00000 101000 01111 0 0000000000000
+    STBAR_v9        10 00000 101000 01111 0 0000000000000
     MEMBAR          10 00000 101000 01111 1 000000 cmask:3 mmask:4
 
     RDCCR           10 rd:5  101000 00010 0 0000000000000
@@ -107,6 +107,17 @@ CALL    01 i:s30
     RDSTICK_CMPR    10 rd:5  101000 11001 0 0000000000000
     RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
   ]
+
+  # The v8 manual, section B.30 STBAR instruction, says
+  # bits [12:0] are ignored, but bit 13 must be 0.
+  # However, section B.28 Read State Register Instruction has a
+  # comment that RDASR with rs1 = 15, rd = 0 is STBAR.  Here,
+  # bit 13 is also ignored and rd != 0 is merely reserved.
+  #
+  # Solaris 8 executes v9 MEMBAR instruction 0x8143e008 during boot.
+  # This confirms that bit 13 is ignored, as 0x8143c000 is STBAR.
+  STBAR_v8          10 ----- 101000 01111 - -------------
+
   # Before v8, all rs1 accepted; otherwise rs1==0.
   RDY               10 rd:5  101000 rs1:5 0 0000000000000
 }
-- 
2.43.0


