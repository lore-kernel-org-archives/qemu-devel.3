Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46484C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk74B-0000Op-MJ; Tue, 12 Mar 2024 14:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk740-0000LC-TL
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk73z-0001Kq-8n
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd97fd66cdso20860865ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268882; x=1710873682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+qvEdc3P8IChx8s2V+ShSCYxYz1aPKBexowlIxfWPc=;
 b=eA/OMNgXMZX2zZbNjbRx7ZUI3vhGpFSDlYJIbKoW8jrBjJxPUXk736w7UyEgZqqEdM
 XPx8h317IvCl6y0InwHI+6FDLUoAda9yjNJUayQ0jMb6OwAqIfxFLM4OMe+gU+ZBMTqO
 sdFiet1v1DCQQbF/B/OFHo30R4DyWlmHmCKdD4MF0h9gSWOIKT1OQCjv9rriKt3Bz/jz
 6PsTJp0LOh0PFco0C+FYgJFrmjYlV2clrFmQyqbqielchQq6I/M64GRbSwAw6JcVGvHR
 JS8QtzXP5ollxBCw5ksbAeB87vSG1J1sJpTEYI4HV8tZOurs5TFSKDMqBIfHhJLciimP
 G1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268882; x=1710873682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+qvEdc3P8IChx8s2V+ShSCYxYz1aPKBexowlIxfWPc=;
 b=QJiOW0Odghi+5V2rvGDZHl5wlDX26ZTsvdDoKruVUy/H7uwO7VFg0Ol/QBUGiH0qKe
 UHeSU174STjyO1JD+LRuXQ2zRjHgldAjfdvI0lqJ/XhdLkPObuWYF3ZeWiq0Qvc+d+tZ
 zgxVLG7ueRXZmNN5omAiBX/rGW1ZK7P3LC33FijRJOEEmcINziFucDr6oPGWUIYaTDz2
 w/lm/QI/4lYc0Ugrg5u42oM9e6cC6WVhd2t1dlaespPS7hzsE90fYnBWFYYUSxx/tzVV
 OOgVTWwwlJvOp/m7VyhzNCkPqwJBnbU4ZrCu2ijI4WJRk5oKpIIjdJ3e/iO1NNA3geL2
 qtow==
X-Gm-Message-State: AOJu0Yx3dgfDYgsj8EdOEIGkCt0/wybHFC+531SgJsca5+RVYAWLpNUS
 2n7M1DsWeIOWh2ovpwKZUo0oE3oFAwLsOS0Q2dDOoPPADxA/Jq+7b6noD7ua/+VVMbLappHPwG1
 7
X-Google-Smtp-Source: AGHT+IFjXBL08lJja2Fg4HnM5FnwTyILIXB05uepUcMdNuA/4hH5CdlbeY96DbBkG6BpislTdO9cmA==
X-Received: by 2002:a17:902:ea01:b0:1dc:b531:839 with SMTP id
 s1-20020a170902ea0100b001dcb5310839mr15427797plg.25.1710268882003; 
 Tue, 12 Mar 2024 11:41:22 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001dca40bb727sm6951739plh.88.2024.03.12.11.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:41:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/8] linux-user: Implement PR_{GET,SET}_SPECULATION_CTRL
Date: Tue, 12 Mar 2024 08:41:10 -1000
Message-Id: <20240312184115.365415-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312184115.365415-1-richard.henderson@linaro.org>
References: <20240312184115.365415-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Both of these only pass and return integral values.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0801ae124d..4871c4b648 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6451,6 +6451,8 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_GET_IO_FLUSHER:
     case PR_SET_IO_FLUSHER:
     case PR_SET_CHILD_SUBREAPER:
+    case PR_GET_SPECULATION_CTRL:
+    case PR_SET_SPECULATION_CTRL:
         /* Some prctl options have no pointer arguments and we can pass on. */
         return get_errno(prctl(option, arg2, arg3, arg4, arg5));
 
@@ -6465,8 +6467,6 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
             return ret;
         }
 
-    case PR_GET_SPECULATION_CTRL:
-    case PR_SET_SPECULATION_CTRL:
     case PR_GET_TID_ADDRESS:
         /* TODO */
         return -TARGET_EINVAL;
-- 
2.34.1


