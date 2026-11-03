Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D461606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iDpMp0/i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOIFb-00071h-ST; Tue, 03 Nov 2026 12:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOIFR-00070h-Hn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:24:37 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOIFP-00068a-S7
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:24:37 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so41582555e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 09:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793726674; x=1794331474; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GwmdcNoKtDAS2ByzEg88c4SYdY9oHlSjR6hwj08wrtA=;
 b=iDpMp0/iJ5LydRlWWw8JeZo7DjkyB6Fw6Umq2MvISBp7X/PYXKWOTOGSW+aGhw7gYr
 3zhFyHKehwFRKlbUhTnEgtwQj2uXXzJPd7GToGWpImOnBFWNut23u/2XQKwSIFQEG+2A
 tNTT9J+Ckie+/mStejwbPdPo0/9ig6PpYkXSd2QqCJCQaAUyLVHoJbAKw5+8fdBnPC9U
 z23VUW9lHuiu+bp9L1V23XNGq1VP6fAHJEHWNFOnPadn4kjGPzI9t1xhWkhAlVfAnNs3
 /UlOYdiOomQ+HlERHfEyyLsN4Lzgg0Ko67MCLFNoWQHI4hdh/uM7kW9KfNh+L1lsXqBW
 AGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726674; x=1794331474;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GwmdcNoKtDAS2ByzEg88c4SYdY9oHlSjR6hwj08wrtA=;
 b=GwXRgNwPNEROyXc6E6/iqMAT2gh7webyEPdNfALIv8avSMp58pes1Qakaa9uTX+tq7
 7clA2gMx0bpHQ6MXzcfWWwR9HqP2CCVQrZqYodBOldjjX3JjEcGTNGG/In/t0MJPzSkP
 xd0GHCnXEnR2EQuT1XvLrtk7FLLSjNdaCdBcK9Gd2MJ0fcLL1jnIcnPfTJ8NCJjGBuRS
 ORlCaiX4rp5kj4/DPPR91j3L+B6Kk3FyOOXi6u3p7BuNhYZsYMsAH2FqI54qHnyx1x4e
 ATx3C7xPcwVRJLbwh+BwWoBgCx5xu/80DW8Pgvb1Hhd8yjOJs/RZF1ce278hqR6tvgPE
 EWRw==
X-Gm-Message-State: APuU4Z/n40JxZQGSQOgPi2UWY8QbrDQNeOaebT5gHM0qjLSJObqH7Ygu
 hzc6pBIAp1D6Aal1AGNV+1gznPAY/PdlqXb/DUJsTaS/ucTRXgtXM1MZBFpKU2XAX2w=
X-Gm-Gg: AYBFou2RS4R/FSLOdTxFu+OIbaokwpMlhSokiAB+zi+F9cR5mdw31p+z8yhuWIP2G02
 k5sz6ySS6uyMEb+Gblbl/rpPzs98d2Tqn/mNwQ+2GYjuNKNIMMWU6dxZZcS9QfnLB7uLNoDEaXH
 CDglXZsJbuAUGL3LITo4lMY5nVPlrMtc7HxBL3Aonq96QlHa22jMotCtDwI+XJ3fLhkhvWWfVSE
 cRs3CeB+1SSAO2kzh5R7IRgVx/kdfFWBOOtq67FT6e3hgMLBxUBfxre9K7GCK58Hf3+/HXPMRph
 6K/q9eYSuD0V1fY0Yzf7bR6g15sjIQcYlzSfNQJIhAkP3kSOk3ksEqNeJy4xHcJbbmp8rDgZQzS
 PffUzIpQPiv7n6FHGd48GxKa2T9xI3RrM3bjn7qANzSU047SQ3WTbV1eMr3ye0E/r3/tHHc0Krm
 iOFqJgYpvf7HpuQuCyocfSe8X3cEpQVy3BWw372Xx4vKpMa8k8cJI4DyBmL+0q/E6wrWO03Twvy
 PPbnn/IrgZO2ZxGxeIFzkyXDgDquOSaBjKX7YZpo1Mxf4bBv0fW5GubDtYSlXHe+sMJQIX9hGhN
 eujsF0lt+LT7OmwCKVrNeCp5JZKf
X-Received: by 2002:a05:600c:4f0f:b0:4b3:ad9d:e21 with SMTP id
 5b1f17b1804b1-4b3ad9d0e48mr27559765e9.12.1793726674250; 
 Tue, 03 Nov 2026 09:24:34 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a555e59dsm81892455e9.0.2026.11.03.09.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:24:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4B9655F904;
 Tue, 03 Nov 2026 17:24:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 2/3] target/i386: terminate a tcg block on gen_RDMSR
Date: Tue,  3 Nov 2026 17:24:30 +0000
Message-ID: <20261103172431.1180482-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103172431.1180482-1-alex.bennee@linaro.org>
References: <20261103172431.1180482-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

End the block the same way that gen_WRMSR does so an IO access under
icount. While this fixes this particular case I suspect there are more
IO like accesses the x86 TCG front-end should take care off.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4779
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261029171737.2126803-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ed56edf8a3a..911bce5f539 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3783,6 +3783,7 @@ static void gen_RDMSR(DisasContext *s, X86DecodedInsn *decode)
     gen_update_cc_op(s);
     gen_update_eip_cur(s);
     gen_helper_rdmsr(tcg_env);
+    s->base.is_jmp = DISAS_EOB_NEXT;
 }
 #else
 #define gen_RDMSR gen_unreachable
-- 
2.47.3


