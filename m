Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950E5E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XT-0000Wa-Mt; Tue, 07 Jan 2025 03:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X3-0000JP-A7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:46 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X0-0002xy-Qq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:45 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21670dce0a7so43339345ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236900; x=1736841700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iotMcZN6ga2pspsEdiSkbfFRa51DDrjDS+qAe0YcYk=;
 b=BLdu6r0M5syehJT427J3ULmIDZsrU24isHqnxrCn0o7m46ZccbLD1MAnYYUrfryFeU
 qInwJVPaDZEFGiRqCzuaUT0aYtJuQQ9+XdwjwBIry6uv3V7EeDm/jBGmbDyOXlvgFMcx
 FMKI9SLnAY0pgJHITv/0iSeIgvSjE09E4P9tGXqpskHpnisrH6F1X1kt+C3JHNcB0XqW
 k8UO33VQzClKKBHYnnWlOc4ByPVt0uHmcjYIxYPdSiqD8ezSn78W7wcRIGLEeDpdPvO0
 O08kMQBNM4XsM3Q4in5M8hR2uHr7vI5tS+SeCfS3wPU69DqLDo3GnugPQ+fm8dxaSybs
 uAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236900; x=1736841700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iotMcZN6ga2pspsEdiSkbfFRa51DDrjDS+qAe0YcYk=;
 b=ZuCMyFEIKhY+HmPm11SIPno08LXcrpzrMEOMqQHjn/zVRx9QIcejXQE61fqiDhuKiy
 P0kKcoOKHYsLivc2znbVHK96g81rVz9sWurjJb6ps6Ok14EJL9h/Xw0FUYaMg4LnbJBt
 Gr56Ih7ROR/ANDULYpJfx+C7UZXQ+rriYBHeMK6aGE/PQiEjhrzqYxQDdsbnN8VGA+Ks
 SmvngsN+fgieWpBbs+MYtfZ1pDLIj0b1Y9SpFjcTWaVPJfC/LjGo5Q8qPb8GMfXaM/qL
 MBjgM+YiotqBRhQbyrTbtVFUUM0g7Wc/tCU2Mz4SSqFrj580xur5E8BaiqPrf2OnDS2n
 6MuQ==
X-Gm-Message-State: AOJu0Yw+w1LbqAXa05/Vf2jQpfiw91cJqBA8Tau4GCmg7/6V76n++BDO
 ESjvkkbu9LBfofpDmQOyxGhbW1PuaAxsm4p+ukksBgAHLhkQJgOaM4wLTU5OVLGYwa4qfeNKQcw
 s
X-Gm-Gg: ASbGncskbXlfLB6Py/q7445aY+sb8GFDthBHVn5N4yNhtDq8RqaQpU45v9hxNQv/aGl
 7hUc5Tmj6YKyGFlupGsWoqHleeRvXockizgEr8Dc+UO9J9XhuhnBytSd3LCdOXiqN6E+3Xb0m65
 C7ixlWwcFiQ1JlecHxiVpBqYxJUSE6jlss3a0CL9R2rA9P0ZQYDyzJLvvPTjvt5wiQAA97oMXgV
 5MZBFGj3YKSTSkZ6N5VuI4z41BcTzgcnXc70pGWlsNzaH1y+graD2dPOGHOg6EPe0pPLScqsXN0
 +Wfhk696hxEtdzKmPw==
X-Google-Smtp-Source: AGHT+IGaJTz5+ULkmK5KBTQ/VO5vW7uvluAMf5MsFCcDJ1GU1ZPaufmKs+17iEUeZVk9a3S8SYwceA==
X-Received: by 2002:a17:903:944:b0:215:6e01:ad19 with SMTP id
 d9443c01a7336-219e6ebc9f5mr980389605ad.29.1736236900498; 
 Tue, 07 Jan 2025 00:01:40 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 25/81] tcg: Validate op supported in opcode_args_ct
Date: Tue,  7 Jan 2025 00:00:16 -0800
Message-ID: <20250107080112.1175095-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

We should have checked that the op is supported before
emitting it.  The backend cannot be expected to have a
constraint set for unsupported ops.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index f72a8e5a47..80744b86bb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3367,6 +3367,10 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGConstraintSetIndex con_set;
 
+#ifdef CONFIG_DEBUG_TCG
+    assert(tcg_op_supported(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op)));
+#endif
+
     if (def->nb_iargs + def->nb_oargs == 0) {
         return NULL;
     }
-- 
2.43.0


