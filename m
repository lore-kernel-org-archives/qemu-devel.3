Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD45CC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L63-0005Uh-EX; Sat, 12 Sep 2026 06:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5F-0001gr-5Z
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:45 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5D-0008Uu-5g
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-86a25369f16so1395790b3a.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209341; x=1789814141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FcKD0bQYlAhK2PtfL2mvjA3hed1eL7X/1Mksn4LYhpo=;
 b=BbmZjkPbmsZZ22zJwocfOiowwh+lebo2Flp8R8Wb4F/Bb7LH0Nd0S8SFl5MsBMjPJI
 a2r05F75XrAKg6j2NUUIq4H580aL34m/AGqp1JdMSwuZgwmZZ6UubQzeDtrc1NR89UvS
 JXj0U9zLDVuaz/sf4S91+TycFsWsZ+wpzW89pkgpLrm9dhQzGjFIEB/BAkL2fPDlR6Fd
 JVdVh2q5D1zZU9qYaLNfJqa/TYv7IPnFiAz6Qvnx4846eF+uLi9yaZwRUFpJwhkWVgYv
 IT4HX/m2x/T1DMeEDHDO1XSrrOt9O9S+qJmIT50534h/fJ3bcUCpVJI0O1DBbSIw5e+z
 Ajyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209341; x=1789814141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FcKD0bQYlAhK2PtfL2mvjA3hed1eL7X/1Mksn4LYhpo=;
 b=CGMvsPBEiGsP2RGGY3pwS2b7fgr+fm+g/RZoSvPHddIehrM4Z7DEj3qBKzK0yMv+xp
 ILqE9tjwfnZD5rb/K57F8RBVfKKetuVriWNp0bMrZ4oTdb1MnY6Wy+wKtVtwjvRGib2+
 g3jrcWFZMn1wWmh4zg9uucD3DveOBPXcpwVpCDAV00N1iGZWJfPQZY/1E2KLiocS49Uq
 YwKW11awbCZG2BuVgiNDKbgRygwMGmpLkJJaV9UDOnm5PShFdusGQtIsGup9GDetW77y
 GH6sjt+RGi/ORGEyNSSfqyag3V3ew5PQf+X3ThGpwIM4gvsg6yrZyDHLs+WJ51wqosMP
 eerA==
X-Gm-Message-State: AFuF++n1KplWf+8V4/kOSa2vW4EkOno7q0eYQhJSmEg9JLqMHudJA2X9
 lgJ/Xwkg7XA00qQC6GWW3k7FheLmKvwu2Up+j1ST0PYUHiOYC53cttu4Ktr9Zmenpivw59o4AFP
 /7uU5sqg=
X-Gm-Gg: AYBFou29NAVT7pNstWmJYa8lMH1biPSigS8pJd87Ru1OMqtYvk3zNHio/yBxEd176n8
 W1p7G/9v4nLKRlggSYxTgzTJemMZo4HsQ3Vfm6xIvDBPg27/tdeST0onJQa6t3ujgLLQ9L/BcNi
 gElEAhfYtqDocDhdQrBjwz0XOBP2iKdpwaQaY913l3G1OO9cIqjN/xMpemNYl3vKCTCWYjzl6sf
 cj8VfbZ3SypbKuKbVGHzZY9I0NSZ/CBGkPLyOaDPo7PDfqcsNBG8ZArU+JV0tVjtjmht5zQh8VL
 bNpqY3a+2GshS3RlhZ+kDXgHCgjjoJBgWudp47YRWnDrK+a5VaVBL5CnW89N2PJHHUdGfN8L9nz
 yFjX6w/2tQm9z7tmkE68fHxKGwYygUVONdFJylOmeYwY59zUyCBqrgUWtv/i4h+KRglxcQS4my+
 yDMUzugSZqbuj5XsJoNOkS/Lt0YikDLQz0f/xn0nDlhtY85X1bq+NlpUbSmwZf83s8JVkXjCQof
 gh7oHc=
X-Received: by 2002:a05:6a20:9f95:b0:3da:80a1:f2f with SMTP id
 adf61e73a8af0-3daed5d1801mr15553184637.14.1789209341365; 
 Sat, 12 Sep 2026 03:35:41 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 75/82] tcg: Use umax in ussub if available
Date: Sat, 12 Sep 2026 00:31:19 -1000
Message-ID: <20260912103126.598030-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6c76cecc501..49c187c3784 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1147,10 +1147,15 @@ static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 static void gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
-    TCGTemp *zero = tcg_constant_internal(type, 0);
 
-    gen_sub(type, tmp, src1, src2);
-    gen_movcond(type, TCG_COND_LTU, dst, src1, src2, zero, tmp);
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        gen_umax(type, tmp, src1, src2);
+        gen_sub(type, dst, tmp, src2);
+    } else {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        gen_sub(type, tmp, src1, src2);
+        gen_movcond(type, TCG_COND_LTU, dst, src1, src2, zero, tmp);
+    }
     tcg_temp_free_internal(tmp);
 }
 
-- 
2.53.0


