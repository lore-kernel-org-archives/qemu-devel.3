Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C613DC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjJ-0005No-7n; Fri, 01 Mar 2024 23:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgDpo-0008In-Am
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 20:06:41 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgDpj-0001qH-4Y
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 20:06:38 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e5e4b1d1f1so241738b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 17:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709341594; x=1709946394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heWwhhZRXEytDL0SmdxoBBOuqoxj4iBtZd/7OGPBfBQ=;
 b=DEYHr8YNykP4Tvn+YkyIDqsvjVWYkIr6Sm+r34N7YUvFYCCd2cFWdX2FPc1Z3PouKs
 HILLcreypPr3Ayfo6giUotyU+foj8mp49lPedanOngYNbYWmO8OtjpH1ylKSTwTyMjQ0
 KZrqvIZ37c0cpcnIWQht4U6e7fmQWDMm9owEP1H2Pn6J7DRXwMBbSV3d3UihODpQzdg5
 egFEgy9Trpb3JrcFsgAvsidQV00HjXxBsxFtWtvgKv4xnXXH6f/FdSKTDNzswwfhngiq
 J7+5elGpMdIlsDoc1ySQwKf8TnWooaAQzHvwqw9acvBxjkiIHGNCcIwTeztpxed7Vhi3
 sSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709341594; x=1709946394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heWwhhZRXEytDL0SmdxoBBOuqoxj4iBtZd/7OGPBfBQ=;
 b=qJ0ooZy77CBfJ3ZRwsB0SGLuOwdzKoftpYgupx9uxMyQq2J4BbKKoeNn1/Lpcr8NBY
 GPlwSWbYBcoKY+0UH6Q7VvdAVdUSwopMaH3Ftq9cE6mMaUcCseRKblPxsDxKJcM7Htfp
 MwrrD40aZhwVUA9Jvsg6ObXC4Z54ZrnI4TtIIj2OK+ksHcgC+iJPBXpPS7q2919sqw3R
 fzNrlPP7Q3qFjeLLuRd6CqPkFde19j7lTXu6F185M1e3cltU2wqB3uCAZ6fIk5aOfSNc
 TTQkKnml6vdtgVFV3O6ekTbM5SXI6cOb47t1zsCY+3LODX58wA7xil5OexwSzS3qbVsp
 XTRw==
X-Gm-Message-State: AOJu0Yy/gQUQJ9Haso7UtjTdGUnuKJwHgTIMuhYtedvLIjhoXMQ8yglK
 uUNrunxJsO/mTq8TxCZnzrb4PiASyEHhfiDgn/AaNW1Uhv2CFo/esvTxu5T/MnOPzJCy09+9i1L
 j
X-Google-Smtp-Source: AGHT+IFI82ZPjHgKGiOB++Pgxaysu7U7cPqxA80sGKZQrtrMxgCuowohJxM6NNImHf4d14jxzuC6ew==
X-Received: by 2002:a05:6a20:c706:b0:19e:a5ae:229b with SMTP id
 hi6-20020a056a20c70600b0019ea5ae229bmr7573638pzb.31.1709341593953; 
 Fri, 01 Mar 2024 17:06:33 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lo21-20020a056a003d1500b006e5acdb5c94sm2399881pfb.176.2024.03.01.17.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 17:06:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 3/3] linux-user: Implement PR_GET_TID_ADDRESS
Date: Fri,  1 Mar 2024 15:06:27 -1000
Message-Id: <20240302010627.12998-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302010627.12998-1-richard.henderson@linaro.org>
References: <20240302010627.12998-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index efa200878f..a50a18b008 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6468,8 +6468,10 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
         }
 
     case PR_GET_TID_ADDRESS:
-        /* TODO */
-        return -TARGET_EINVAL;
+        {
+            TaskState *ts = env_cpu(env)->opaque;
+            return put_user_ual(ts->child_tidptr, arg2);
+        }
 
     case PR_GET_FPEXC:
     case PR_SET_FPEXC:
-- 
2.34.1


