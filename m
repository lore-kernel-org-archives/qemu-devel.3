Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3063ACD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgf-0001AS-Tc; Wed, 20 May 2026 00:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgd-00019G-S2
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:39 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgb-0003oX-4h
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:39 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso2244610a34.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251855; x=1779856655; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pdT1KFqbmJPaSXtIjTt6ff2nwOW3lgDDNcKqorOiIKY=;
 b=n3oKgP9wepw2j55S3tt/25iPYGwCPf1+571ksDP73mvjPt/wsz+LG7qnWcTHHhb7QF
 P9fZM+thdXm71vWaiYAmkWhtLRcjlGbercSx+K3PB/zubsYLwLMs87EhaGKpW/eB2yUt
 XWiU9VWNaKH1XFQUWr3jzJJ/IAaAe9IWGIN08nAlgD+EjIzlv9wFdbz/wj308FlbOmOc
 WoaqMnTR2rBAlg2IKdvW2GI09A/jYY3aNJ0Q5YuaZJBvmk082y6Ne0Lx3TB0XoDOIMor
 PDe69ziCRMoX1IvBgV0vJUWW5xl4AjVXcyNGl6rxuWMZ6KovBbQJPiJ3+f3uoL8m/6tu
 H+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251855; x=1779856655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pdT1KFqbmJPaSXtIjTt6ff2nwOW3lgDDNcKqorOiIKY=;
 b=WKZQmLjAOsU9tNbCJZnXjZHDcWRVl9pY3vM/2zenvCIVXX//X5ykQPN9IbxsPzOeYx
 kREbCUEXMe5vI1HHVoXdukb1J3G7KhWQjMjqWaiOCi9aW8O2t8/N1zsEC2Hoa51I34Rp
 PW2zYat65u1u/Wt74ONnP9C3yQzlEfuwidaAAbz6mZq/cBBXDvJx4b0Cd3/az7zhy+o6
 WiGe/ifFQE56X7AMLxT701nLVmdj8Tw8q0Mw1i+I3d0VtJoU6pFQ1r+QN+yj+GM5pqIt
 IJDTnM5ztXBT7KSDTC2/mCiXooFDT386ZMMNqVBG9XmbQDkk3zqnn75HHgfOUoD+3kL1
 lJNQ==
X-Gm-Message-State: AOJu0YzEAgo3Xap4HaLjofqF5YyJyGY9u/Xolfpi+ndcCL8bK97GqTc3
 NMX4/MO8Qjc0tCRwX9aSaiehNsByjzoLErox3bg02c3VUC0hHEtJkJuQ
X-Gm-Gg: Acq92OGGaA/o+/I0FbRDGvjmxMW/FiiAByEr6A4WhqtZoOTH6ChoMof7uBbcYHLb499
 8TDhe5OjGbyfm5MMIuw823+ylVvOpZEADrs1U1S2k8XfYyUd198yRS4fWxVD0934d9txEdyHvao
 C1ymjCcw6fCdEuaJ8UQ5df3PRDs36xco4c5TFP8XHIGO1KOI45BU3PbKwt906ue3Dz48QD+AWpr
 a1UKWzLbLr70g+ezTziH99MHEDXWuAkc5wHc6Lqp7yhTk6mTYCX0WCADVd/z0RXLYKrYL1wUTjt
 YEPlcb682lOw6un6lzgEX3q3YbmW5qguqA5gsNH7TCf3D8YGs7H0MPSKyHIkeHCSwqzWyGpy6Uo
 bwmNHd6ixaAbBCBQSXh2Hbcnm38aDS9sc0hPE7q023lv7UBHB5hl5n2zo/Ut1jc6YgilYTbQH0u
 mesoPOiScfcN3i8hQ0//8XlnSLAJMl40sJ3hzBQUKcLMRcOVut8FIHbYMfuXm/swoQRjiffw8/F
 YJJI4q5At7uf73XGkJMN/oh47SI23+oh/A59MWqwu8lVQw3URyhNTtPF7qBuWw4xdJo
X-Received: by 2002:a05:6830:6408:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7e4de65c157mr14478787a34.0.1779251854784; 
 Tue, 19 May 2026 21:37:34 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:11 -0600
Subject: [PATCH v10 17/45] target/mips: add Octeon MTP instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-17-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

---
Changes v2 -> v3:
  - Split MTP0/MTP1/MTP2 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 two-source rt high-lane operand and document that
    legacy one-source MTP encodings use rt == $zero.

Changes v5 -> v6:
  - Zero P1 after checking the CN71XX register-state table and
    description.

Changes v7 -> v8:
  - Combine MTP0/MTP1/MTP2 in the v7.5 inline TCG translator form from
    Richard Henderson.
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 5139543b15..bb0a9f1d99 100644
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
index aae6e9811c..36d268e09c 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -242,3 +242,26 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
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
+     * Octeon3 clears P1 with P0 so that VMULU sequences remain
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
2.54.0


