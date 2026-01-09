Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51D7D232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56e-0004H6-0w; Fri, 09 Jan 2026 00:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56b-0004Ec-MQ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:13 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56a-0003h2-7b
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:13 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34c30f0f12eso2312602a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936731; x=1768541531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PC98MoSZr1UE7TNVEPSglIh76HrqcaKgifra9RoSItk=;
 b=w0h8p33kdhdXGdn6OvZWUYWR6K0vKfrBHUfgKvFFCyGtzd1E4Mm+bId5z0bHE/SF0l
 3wEYUo72IYd99q8Z/rK7jYYCh9epCSYdu4bXEDy8mMY/J9O6zdH9kA21mYmC3W6ViP/L
 l0wF+CAYK4oGZEDOfRYfGR1EM9anGp/ADXDyBNskZsvdpK+9XIfaATJ+WPec/0w/Cjol
 2mUC+QougEm9q1JMrNEZlgd1FtSJubI8lo6DNIxulCBL5jxTO9Q7h3bwyoneFmsu6426
 hj+j7zIJVWEJXtHdj/DLKr9je+GX9ZKkdt7ZcD28/bNoiTUS4D2xcbxEri0oIR1Fk9xT
 gNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936731; x=1768541531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PC98MoSZr1UE7TNVEPSglIh76HrqcaKgifra9RoSItk=;
 b=bk9ugtVXgDxzOwROAqaKzY/t3oHqWSQjUNJM6A6rgytaT8lBm7G6gHzKQ/MzMcrP2I
 CD0SrIBDJKEk6zJZmIFmUtw9zUUV/ZFMmdCfSKq7Z8f1UCFwrRvaXWNAhJQizz5OQb4L
 xZ2+oIDVJpxyw79wJJk24fdASFbW2a414CfBZnMFFhlAXLR46Llk/h0tKBNpXg5shd0c
 8CY8NHj3lqGFORTkAPjEz2OL+O8c12IgpfhjB74fD4weW2F7Xf2lqUCtJfGpTK+l63fk
 MZ/y6WTR6OyozCSaTTGlyPueUGXPcncANVrAHmsh4H2BZaMTQi2VhbirsDtvTtQ86zku
 US2A==
X-Gm-Message-State: AOJu0YxCRlvUE4fTBepaXwiwyBHXM+IuiSUOJDvIeqGae6ihCoaVKn+s
 EjSSI+VjzZbjTiuy9cGGu0i659vlRU8OwKpNGXBrlRT2aldYXJvNKui9hhvq+3H1DycoTughlEX
 Qofl+
X-Gm-Gg: AY/fxX5YTGEFzgMt3qM1gEl1THqhB0+RNOvLkHMWUXUGHFC270LMGVJaxn0QSJmVrGK
 sNYe1IA4SZrmeZW+/pu9Raak6TnTCfFkib9w17XzdSWm1GAjH6A/TFKT/TNgFU1q/PZ7FiNe4sX
 xTtbMTRmW4bWdj7FLljMFXmtpyqjF712LmOU98TMNSQB07b6MFkGZdsftGOjWmR2/kG19LWpVGm
 AYnFVDFaxxkrOFyJe/UaLb1BLivPBnqCFjBscSz1Ms4xAxwPolwXiVMGQUGQmr51cC0FRa39NBO
 i2/87KFITx43+P75r3suHNLPX4VqGUUr6/YPCjDJFblBx2TSEp/zNmlmfOloeR6WzUhlIly+3PC
 0Vql2eHehGjXur6GIS388dOpBCOr1oOVNqh+wNgobA5GezHm9ca8V+QQXZw0+UkJVXXb7P/aT2H
 a2HXKrxBAUSRkw5y21hW5KqVeNU8kwZtHrK1GjeEbwNNmEweAgcnSsByld8qMPYv4y
X-Google-Smtp-Source: AGHT+IHxOrDXd9Tl3CnHVlkw7cxCRaB5QzRHQdGsBjRNAKeNqqXwYBtNZsxSAj2fjUB0Y2lVOdiNFA==
X-Received: by 2002:a17:90b:524d:b0:349:3fe6:ab8b with SMTP id
 98e67ed59e1d1-34f68c48301mr7210764a91.36.1767936730745; 
 Thu, 08 Jan 2026 21:32:10 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 05/29] include/exec/helper-{gen,
 proto}.h: add conditional HAS_HELPER64 define
Date: Thu,  8 Jan 2026 21:31:34 -0800
Message-ID: <20260109053158.2800705-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

It allows to include helper for 64 bits variants selectively, by
including helper-{gen, proto}.h and defining HAS_HELPER64.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/helper-gen.h   | 6 ++++++
 include/exec/helper-proto.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index f7ec1556997..c96e13b835a 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -13,4 +13,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#ifdef HAS_HELPER64
+#define HELPER_H "helper64.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+#endif
+
 #endif /* HELPER_GEN_H */
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 6935cb4f16f..002460722e3 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -13,4 +13,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#ifdef HAS_HELPER64
+#define HELPER_H "helper64.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+#endif
+
 #endif /* HELPER_PROTO_H */
-- 
2.47.3


