Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B389F606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Vna4Myxp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTlG-0003H0-0i; Thu, 29 Oct 2026 13:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMTlA-0003Gm-6d
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:17:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMTl6-0000PE-Gl
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:17:50 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so2032730f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793294264; x=1793899064; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Oil2VQNx1AaxML52m12NvQQ+f7a3ZA5w0IIYH+VmNhQ=;
 b=Vna4Myxppw3+nk9ORZ0ICBKeUumS0z9puAUNy31EDZNoQd1Ur4+4DUaoIIi71qYK9+
 WfR3yhhHp+VHabAWsXSBFLdlRzxjEGZBK4GZ7A1G1mu6DQYXlvpVRS4EpfczNWxktG9/
 SGD26zZX2ybIPEOJQy1rpiL2mF503swjtW/qAmR0n2QTAlYC/It9vCLI390FfCpEEdHN
 BXcVX6gpk51bCu77yI8v+7PnwOn2QWqw9o2d2f0asFvKT38yFW/FJ8kMhvMXelIfNP54
 yduL5TOs3ZtAnBebrErzExU4PBtn3uGv2gAaf5iborOIepE6Ge5/wj+UgdkCeOhPdLZK
 hHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294264; x=1793899064;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Oil2VQNx1AaxML52m12NvQQ+f7a3ZA5w0IIYH+VmNhQ=;
 b=YGzWnH7a1fVKHgnrS47PX/IlB0wxzSGGBseQZ6EyLVG0QuDvOJh6h5do7CRh8HG0t9
 exWYh1tJOWiaiSeAJ7wNAAJ306EHDQ/Z52O1TjvC7Qj/1pWVyielrnLqUez/FTza0kJb
 GHNNN0rVMyMWEnq2/tbwRB5YlnNhUbNdkmydMw3wF6RK3bN4CKU2A74uwaGlaD7f1VV6
 QM/ibWI1qVo25oq41g5yuxhrLSs/CdsI8Nd70cbVklLjObzDT+0s/ToG2M0dIqOjIXsc
 Sv64g9Y9OiQbQvs6OwfhpHVV5ttui9j7pwHExZiekYTsseyexcvsy88jUzi3AfviVfC7
 EJow==
X-Gm-Message-State: AFq9FYKg1n+xd/jfE97FZ6kuFioBBQauP0txlJooVvGeyyv5Ob3x44zB
 2DctS16k/vlj9LqcOUYE9CLfSSIvXVB8cwEwK7TvdAkbzcOUMfXfDcLGI//2sy7NDwA=
X-Gm-Gg: AYBFou17HopCIOQjYOr597QjU19hLV6+Tkqcs0lLrYuoGBNge6RGUis7LSkis4W5eHo
 om1HejCb3LTjBLuEDK+HWBZHLls2iRa1orgKRSd5v+akSaXKzdtYzmbjn/iIuVxlDjnS5y2KdTe
 Ae7BvVmddp1ico3VwbcydLEsT5p3x8vIfdaMflx/DwUBaR/snLzgsFXKQLz0B+aTZYb8iat8io8
 ebKqXMNsoj5OakewBX9zNipKyh0bXyC30Db49fy/3ArHl2PZxGnyIbuGOqj2ulL4xubsl4kUqX7
 ySj/Q1gE24Yy/SmM00Ie56KuIu/Jwj+xrdpG9ZSLY5bF/2qO82Oj8EPJIlhnKAclFCpd8KGSzEb
 DcYAimR4ya9hmOA2DiGbP+zL2W7eQzp2F3OUkd/HSdmaIY/XPPhYBpu3qA0BWwGhOYjs4PHPZCB
 W8efw+pZmLASpR0fz4eMgUrpGALBhdrYqfVX2GjFNJ4X9P6XW12EIMtkwM5+ZOOG00+fsEBgkS+
 2JukOf6v78xpdX00N3lVvgmjWmvcaaBJcLRReQvFG/xp0QpGXSqSlozpr3kACJaa+lU04CPGumK
 hWAN21fWafeuhbCGyUjKLzrvOL6P
X-Received: by 2002:a05:6000:22c2:b0:48e:2980:d396 with SMTP id
 ffacd0b85a97d-48e6e50da28mr21611f8f.37.1793294261601; 
 Thu, 29 Oct 2026 10:17:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df9e6f6sm353786f8f.29.2026.10.29.10.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:17:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 085495F898;
 Thu, 29 Oct 2026 17:17:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH] target/i386: terminate a tcg block on gen_RDMSR
Date: Thu, 29 Oct 2026 17:17:37 +0000
Message-ID: <20261029171737.2126803-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/i386/tcg/emit.c.inc | 1 +
 1 file changed, 1 insertion(+)

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


