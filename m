Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52B4CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkg6-0006K7-U7; Wed, 20 May 2026 13:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfs-0005um-28
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfq-0004H2-7u
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso3525411f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297937; x=1779902737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gokMVLmqaosc2I+MTKyuLHCfZBTcMT/Kh5JpiDE4jeY=;
 b=LJmd2gBDvq9QZZ2bCH03cl8APRmluhrwNIGM2n4xOvPj5jtqvHFRBIiz8wvsQvOWQA
 PVyNwWvqzjn+4k31LyYuhpifeRZufouSPQqzp9CfZ/sdpeo8GN8UqtgshSQ/mp39u2YZ
 MwifDFsBsn6BhmGXOKUgUhUdeaFwaP8ubrxbRW8SnUHUg2oRq4NKj6jeXRY9W5W4CKfB
 Waasa69NfBDDO3ISXKaX1pKR4ZKz9Dq79qvz+4KwyC9uslBCnZa6gHPiqzzR+TuZ0vxW
 G+3Ia4fgwjgNITm63xjRLga30xXFq19be5jkBaV28x8YJBZmjEcBJV35oIXqV+UoDoyC
 BkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297937; x=1779902737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gokMVLmqaosc2I+MTKyuLHCfZBTcMT/Kh5JpiDE4jeY=;
 b=ZiUQcnqkb9TZqQOX7aUoFoC2bw6ajRbkcsDRZujkfEBjs7H3hPh0wwFVoOoo/gvkvk
 kKuNtXLzCWDAP71yEtg+mQJdSW+aT3KXlsA2ZHux7/jgsx9qP7F/RDhJWDRTb+WNOpfy
 T7/A8Cy7dJCclRux7jcl7KdbAyH4NNjTfN9ctzaoujCCA0573g6kRlOwpx2MS3ZzRN6P
 eLqo1agEaQCCHO5fj2/Z7OBQUrtCZRSGNdYi+DQqoPvk+vrD8xp+Lik9cHPN4Hmyj8NO
 voy9j+lnABagmDkm7vu+pS+3xhL4Y1t9g3QvpcIbduRWK5HC0QsGgVOYlsx7oQEOq6aw
 tmgQ==
X-Gm-Message-State: AOJu0Yz/eoqdftEunOU2SpUFkqgLUIqmV87h0xAlots36hf5QoBd62Sr
 lT2YXTMYGpI1mnt2P4A5hquz8EjCkvSvmPtnDguQEo8sZi1LT5NytdgFHd3wlAZZEa38oylrSNO
 3xPeMzKY=
X-Gm-Gg: Acq92OGKid9PK3MH0V2QCmOadstDGhtC8mvUEGiq8l09kG7VCvA2m22whfc+QAQ+dDw
 ltRZQC6hBk+n7NdALfMNVeRVxzFwWuCJG9cRvwxX6/SamugM32CUOtx/W30ZnVgsPo3bp5foi/y
 TDsCltggWeTissyhpuniab4UxWlFfQmjvnUE88lsmFct0NeYVSXIw7ii7oyJuQeLzj1nIlZAfSr
 Gmv//e2AqeJ3Li1J4vIi7ZJMy5JvUVmZd40IOlSEhqK68340z8y73PU3ekDGwaAMWTrQUVRkBPo
 OZf9ny1sujDsGjbmHqC4Pm3LqnOfiq3GK3hQuUKyG02wv2l1VE8+DTJbl91BMhQofvld/mRZIhg
 ZrzB7BV8cy9njyCN6ayqkPBcEHRDrh2x10WfigmiWN7e3OLb2KBU8XkcRD4zCBIoEVWTvlcUT54
 fukuavTh8bWexZ70qFk0rFEU9dQOQ9q8V+g+jK+I2bn7KEcQonYfT1pep7WhSbmBWZj74JAEz+X
 QofCswdCbk=
X-Received: by 2002:a5d:4906:0:b0:45e:8526:7dc8 with SMTP id
 ffacd0b85a97d-45e85267ea8mr14455141f8f.25.1779297936854; 
 Wed, 20 May 2026 10:25:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19b1dsm55060184f8f.17.2026.05.20.10.25.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:25:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 19/24] target/mips: add Octeon MTP instructions
Date: Wed, 20 May 2026 19:23:07 +0200
Message-ID: <20260520172313.23777-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Add the MTP0, MTP1, and MTP2 forms. MTP0 loads the low Octeon3
partial-product pair from rs/rt into P[0]/P[3], MTP1 loads the middle
pair into P[1]/P[4], and MTP2 loads the high pair into P[2]/P[5].
For MTP0, also set P[1] to zero for backward compatibility with
Octeon2 VMULU.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 5139543b153..bb0a9f1d99a 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,10 @@ MTM0         011100 ..... ..... 00000 00000 001000 @r2
 MTM1         011100 ..... ..... 00000 00000 001100 @r2
 MTM2         011100 ..... ..... 00000 00000 001101 @r2
 
+MTP0         011100 ..... ..... 00000 00000 001001 @r2
+MTP1         011100 ..... ..... 00000 00000 001010 @r2
+MTP2         011100 ..... ..... 00000 00000 001011 @r2
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 26b918d649a..10c7d18ad4f 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -241,3 +241,26 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTM1, trans_mtm, 1);
 TRANS(MTM2, trans_mtm, 2);
+
+static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    /*
+     * Octeon3 two-source MTP forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(oct_p[index], a->rs);
+    gen_load_gpr(oct_p[index + 3], a->rt);
+
+    /*
+     * Octeon3 clears P1 with a write to P0 so that VMULU sequences remain
+     * backward compatible with Octeon2.
+     */
+    if (index == 0) {
+        tcg_gen_movi_i64(oct_p[1], 0);
+    }
+    return true;
+}
+
+TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);
+TRANS(MTP2, trans_mtp, 2);
-- 
2.53.0


