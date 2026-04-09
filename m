Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39874F364A8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAt9D-0008RN-85; Thu, 09 Apr 2026 13:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <easonwei1998@gmail.com>)
 id 1wAsf3-0007sG-2z
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 12:55:21 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <easonwei1998@gmail.com>)
 id 1wAsf1-0007dI-GX
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 12:55:20 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so744396f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775753716; x=1776358516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8cLNNdF+q/x6S9UkU3OcxSQ8zWRQMmUrvueeQ1bJbRw=;
 b=Ufthzdlf3PaNYHSSEuiCajmi4RZQRkqdHCLwPweCUgY4LwHpshnndoi6j0cOJlgwy9
 EkO9Lupdp131J2cC3eW//KBq6NG6I0rk81ts0b4mpGDrLbnpovQCb5WllyRNqiGjSpru
 Ie3stA/jwFBTG1+yA3GlNm89vwYSvzqkWamlF3hNvJsvjuL5A1pcMgYL7AJsBwB7lUr/
 CHwjdsC83L1d8g+6JKBsNZvxO26zaM5qG8aaCzX8J6ENx2ewsoaC3I59D/d12IB4bV4q
 Zl/Y2z1/yNND9POAE+Yr0ve20S30ta0lmKD+0sgkaoye1aS6Km18/9H4fUQb5qYxpZge
 RbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775753716; x=1776358516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8cLNNdF+q/x6S9UkU3OcxSQ8zWRQMmUrvueeQ1bJbRw=;
 b=ZRdKqE9UvGrtxC/Rk8UXnnQu1l3XaqbMKcfPaxHRWxjbOeFmIc1L4vW+wOyH42wL7W
 aUnxDo4RUlm/qKSscRpbooFFhoPcYIcyLjteYiVrQ2DINQRoAeEuSU3Jdj/HlTKbcrD8
 eIFIDAnAMV/UWHu/M47UmHzzmplEBNDlWkZLo2vbZbXRxyfErvutxeh5ZIED44VBqkA1
 gPEjSP1IFomWDS99VuJ3tUzgTJ9NJwqHKroJIRWmQB7+04ivzxc6gWxKkxFhuBCyPexq
 mMZG/XQhm01WG79QcI63GveMgLU5Cpgb5Sp9o1FX7LOIKhx/Od71iVzLGqgTHqcItU9/
 8W4Q==
X-Gm-Message-State: AOJu0YweoCNkEBOqX0cbghQx5Vwwi1MzIV8FYLlKuiWyHWP9t00saGHx
 9TIunaaK5ljFIpvLGUHVd3vpM4U+KU+KY72jhZ+i/Ytx5gRqBh/IeM4UDjQiADPuEBU=
X-Gm-Gg: AeBDievLJVP57fxBdDFgmFbju5Hm+XmJLn1OiKreqqyiu1SLyFSI50GGoeTuYRo3b8z
 QjBjbDqX8WvZBEAI1g7uW/qYEtTJbrGRFEqy2pIpz3Yq85F+UEhJE4t9nVVf3hAMhpRCLnRCFQ/
 12IMU1eL4yOOHlNtvSu3P8y/DYDkAhbJZ6AxvGsq5iVypFVgC8loUmPy6u0WRLu04lkGJroAquG
 G6/q/AgS/p/jBcT34Zt3gdPKaIBzRspZ7wbSF9efo2EjHCHpOiDUfAx+SEMf3wGet2jRmOD/M2k
 fsNbkackHqcl+4xxY3Xjq+PTTlXMcRlJzvkaWWMrVNxxgTN2hg2OWwd5Erhzk9cX8wGhbUc1f7D
 QjFqVu9mjWF99XJUI9Y9FGVG1cTDPbWVdG7bDIxVilJIwu55jBJdlhTBf3RGZVXt77jabrK7EQ3
 lZH2mv5ofMXVAuRLgYfPjrIElQLfB0Sw7zPbKS2B5Uhg+t9qpNkQ==
X-Received: by 2002:a05:6000:310a:b0:43b:4212:2ee8 with SMTP id
 ffacd0b85a97d-43d292cbcd8mr36865503f8f.24.1775753716246; 
 Thu, 09 Apr 2026 09:55:16 -0700 (PDT)
Received: from yixinwei-mac.thefacebook.com ([2620:10d:c092:500::4:9bf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46a90sm73292f8f.19.2026.04.09.09.55.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 09:55:15 -0700 (PDT)
From: Yixin Wei <easonwei1998@gmail.com>
X-Google-Original-From: Yixin Wei <yixinwei@meta.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org, easonwei1998@gmail.com,
 Yixin Wei <yixinwei@meta.com>
Subject: [PATCH] linux-user: fix off-by-one in host_to_target_for_each_rtattr()
Date: Thu,  9 Apr 2026 17:49:38 +0100
Message-ID: <20260409164938.6735-1-yixinwei@meta.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=easonwei1998@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 13:26:29 -0400
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

host_to_target_for_each_rtattr() uses "len > sizeof(struct rtattr)"
as its loop condition. When the last rtattr in a netlink message has
exactly sizeof(struct rtattr) (4) bytes remaining, the loop exits
without byte-swapping its rta_len and rta_type. A big-endian guest
then reads rta_len in the wrong byte order and fails validation.

The companion function target_to_host_for_each_rtattr() correctly
uses ">=" (added in commit fa2229dbf8). The kernel's RTA_OK macro
also uses ">=". Fix the host_to_target direction to match.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2485
Signed-off-by: Yixin Wei <yixinwei@meta.com>
---
 linux-user/fd-trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 64dd0745d2..7f55a0690b 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -480,7 +480,7 @@ static abi_long host_to_target_for_each_rtattr(struct rtattr *rtattr,
     unsigned short aligned_rta_len;
     abi_long ret;
 
-    while (len > sizeof(struct rtattr)) {
+    while (len >= sizeof(struct rtattr)) {
         rta_len = rtattr->rta_len;
         if (rta_len < sizeof(struct rtattr) ||
             rta_len > len) {
-- 
2.52.0


