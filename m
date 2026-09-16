Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7E0C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNj-0007Wl-AR; Wed, 16 Sep 2026 09:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNF-0006k3-K0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:37 -0400
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNB-0001QM-K7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:26 -0400
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6b1ae7089c1so497760eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564103; x=1790168903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=epXRE3Bhlave264mRqO7H5W/yKgUDy0RT7IQiUe3bHM=;
 b=EG1YSofb4Y2PiWqFHXxKZrlsMhbmpfqZRg2t055aFkNnsDTA2eVyXrXGQsL/mciuNw
 eN/QPJnxq6MoSxqcDTpAN2HFJ6MiKkeckUJyePUkMeEPJVEDV+dv40iVUmP4T/xnbXI+
 BeqXGFYgcoIWKkDFKLt2jEZyjbgt9B7lF6CBYgX5x/eUHuENBLrZF/rWqGNVhdghH6g8
 QxJkFSCL929Ac7KmCA1jYZ/W6pMChYpCHysi1RObdrnH3GWZ2nvFKAY6dPz29+lsQC7Z
 gtJvi4PPBA+J0UjwNFL6yOKxXe9fQdCy+IIfI+DlH+KUoMWxHiJnM1jIKDuDvpLwtO/s
 yqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564103; x=1790168903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=epXRE3Bhlave264mRqO7H5W/yKgUDy0RT7IQiUe3bHM=;
 b=gEz8UhrqMC6E/5s92V7MwHT2qk6D7UzskVpj2XnqI/8kZ7Wohu1wGw4PVnMJ43hiDg
 2sKrbcj0MOn5KTwszA1onhZ95et+2L/If9LL6lULNwo9vh14ktEc6qwABF0AuGIyvhOT
 C7kjfJLTz5Ni9nSc0QJgX0PGt8kYihyPNymh+/N7dSCE3PEvGGQL3IK3quVn3PrXODGH
 PKbqMFNOlpYMsg6zf+gEYJCMWwvM+CR+JfQEuuehPQTa7TwB5r9XrQfJImafBgWqIPdb
 VVeD4ryQa5vYE4q4RKuIm99foadBBIuVPv5VzEhPSrc/KESf0jhlPmTG7Fu6cUqSkCf+
 aOAA==
X-Gm-Message-State: AFuF++kE7cCM3lmd46qwK8gzkxIjVnzt6txfFX2dRuX64FPfOmvikK9Y
 7Wam+K4k3NwjxFkILOZi9QsyHnhQYumjkrmHHV23iUbmEh/Ua2HYCuDVLj7koQ5DIDTlLI/bjwD
 kuKM3eLY=
X-Gm-Gg: AYBFou3qzvRsKTGLKO0tISh7NWm5JrGOUc89Wg6B4FTGyd/a08FBYPayUdx+sUik3yt
 oBKcqseN8DCbq70/9pulqEzoSgVwPqqxyp3IevahMZCVOA/44vfMsJuHaonYRO85oh/2kxNg6t/
 Nu4Cr8BGGNrLm7lzaE8NrPT39yJ6iflIQWeLWoLhi5QL/zDwCxj5i2DY1qXxM2OzOzgbrRjt3/P
 IrbS8VQdYbUoLJBcATx+YAFp3WfJozcdyNqobebHjYyEkllMVfANWRGL7YnlimZOGxQz7vj1WKJ
 W8sgq1+41XNHCnd0trI0ifxBKJbEwSR1KxNSRzaFiTFfDG7UtSbS84bBV529E3bdKB6DRwp7qBQ
 vVEWnj0ZvQLXQ7CQ3HyXWscT2eH9ejhjlbyZdSZ/OPfEg+ZcMlczsBAQHE80jqWGPhPZWlvV+jM
 ky8VOMA24j2AdIIIjAIzm9TI/lYFgYWuPLSu9/ChOaJVqNh/9e1qN4AQx1dy8QV0EGSs12xBECL
 mdfVBU=
X-Received: by 2002:a05:6820:180f:b0:6b7:8396:f3d4 with SMTP id
 006d021491bc7-6c7d41d7f0fmr2697575eaf.54.1789564102992; 
 Wed, 16 Sep 2026 06:08:22 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 49/92] tcg: Split out gen_extrh_i64_i32
Date: Wed, 16 Sep 2026 03:03:24 -1000
Message-ID: <20260916130409.3382710-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0f.google.com
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

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 017bfcdd3e7..710483f6778 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -411,6 +411,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF4
 #undef DEF6
 
+static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
@@ -540,6 +541,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_extrh_i64_i32, TCG_TYPE_I32, dst, src);
+}
+
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
@@ -2291,8 +2297,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    gen_extrh_i64_i32(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
-- 
2.53.0


