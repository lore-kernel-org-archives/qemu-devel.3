Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C90C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk74J-0000Uo-M8; Tue, 12 Mar 2024 14:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk743-0000LP-6P
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk73y-0001Kf-CU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd97fd66cdso20860705ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268881; x=1710873681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKNDOo6U9WbWCegGn24r6lvAvz+nsA+Lj9vHcmb0thA=;
 b=O1UfUzrq119Jigr/rpTlHEGtLihd5bXCPpx7mEYtyjypD1LGsH8jBUVwe2coK2dSi7
 ndK1Q4QeokUew+YHnZ0nmw3UVLsZug7WjzMqzOQgMY4XHZSQ70ZPGcfC5Di9dPk+ssJJ
 5qfxFLiidSTwkmokALZz+D1/gP7e7O3QIGzxfojyCM3L8dyBcGIJ1JAP6x0kIVd52jWk
 oBQoWnWC1iAugGYYX6FVDM2Go+gJ+Xvufbd4FUa07nDYou6uNkDXhczbb1NAH9teZz6i
 FlVHElV94NTe4R8NUXDNk1CDM6icpCF6ZyjfkBZMT/oBY4nXGqI6scH1rCgshM1j3o7P
 YsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268881; x=1710873681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKNDOo6U9WbWCegGn24r6lvAvz+nsA+Lj9vHcmb0thA=;
 b=qDcyLWOFs802Em+tSJDi/Bb9tbY6ISfNp9f1eqvpTp5zq3nLtWTdigG5i/2Zzz6U3L
 Qv9P46xrvdKsbpEk6H8VCbDPpRAoCF3YUl+FfX5cvxC1JpXNS9RO7YrNoXQJS24hlvLy
 +DVpwzw2fQfG+CxxNmOrO+sd7rkU3/nIv89G7Am5B+3A5gLbNpiLLYpTVF+11Q8JSFzt
 Cmu5xow33dlpZYRcXtDkX/PToZKgqM1+lelTVAm94NWKVfRwwpsKN+iJ8u5k726CoVRu
 0hOsarE6j/ThP0L3SoX2doM08gFTxtk/8V+FWCJhRXbaVFnHFGua3Gs1LOJ/p7I/8Jyu
 XoRg==
X-Gm-Message-State: AOJu0YzHgc+3fX/lM/Dw6cAL98NdfeWL+XyN/ToBSOoG5uQyHb8s+qdi
 MoHr1vHeGTYCa8P87KTlW+O5x2/RdnbRSvNZIuCW9XwUhhlIWSCocgsnSzy7UzINXXlwSrzRssH
 8
X-Google-Smtp-Source: AGHT+IF91ZKLOJ18NdpZ/BaIPimdVv/3jx8yvdEbzx0guldfvggW7qCMIr5Z4p/nJgjvkiJvlOH50Q==
X-Received: by 2002:a17:902:7b95:b0:1db:35b5:7e37 with SMTP id
 w21-20020a1709027b9500b001db35b57e37mr10238450pll.50.1710268880865; 
 Tue, 12 Mar 2024 11:41:20 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001dca40bb727sm6951739plh.88.2024.03.12.11.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:41:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/8] linux-user: Implement PR_{GET,SET}_CHILD_SUBREAPER
Date: Tue, 12 Mar 2024 08:41:09 -1000
Message-Id: <20240312184115.365415-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312184115.365415-1-richard.henderson@linaro.org>
References: <20240312184115.365415-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The "set" prctl passes through integral values.
The "get" prctl returns the value into a pointer.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1929
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 597bdf0c2d..0801ae124d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6450,11 +6450,21 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_SET_NO_NEW_PRIVS:
     case PR_GET_IO_FLUSHER:
     case PR_SET_IO_FLUSHER:
+    case PR_SET_CHILD_SUBREAPER:
         /* Some prctl options have no pointer arguments and we can pass on. */
         return get_errno(prctl(option, arg2, arg3, arg4, arg5));
 
     case PR_GET_CHILD_SUBREAPER:
-    case PR_SET_CHILD_SUBREAPER:
+        {
+            int val;
+            ret = get_errno(prctl(PR_GET_CHILD_SUBREAPER, &val,
+                                  arg3, arg4, arg5));
+            if (!is_error(ret) && put_user_s32(val, arg2)) {
+                return -TARGET_EFAULT;
+            }
+            return ret;
+        }
+
     case PR_GET_SPECULATION_CTRL:
     case PR_SET_SPECULATION_CTRL:
     case PR_GET_TID_ADDRESS:
-- 
2.34.1


