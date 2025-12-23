Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31055E6FE23
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 17:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY69N-0007h4-0k; Tue, 23 Dec 2025 12:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vY69K-0007gH-MS
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 12:26:18 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vY69J-0002Mt-3p
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 12:26:18 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so983538866b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 09:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766510775; x=1767115575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Rde5OrYxFRDd6W+VT1CBE62Mao2oxteoXB4bZ+nSYo=;
 b=gQWaU5wt5la06lze3FXytbEDemn/dAtYbULFwjNbqEQOKyE7BR0dZwX2NlY4ij/a8r
 lAqSfyZxm8uXSYPUow9CDJZDykHTtldj7pQ72lsnd7b3cdKmO3hJcERTOSk5nhQj2ZpW
 PFnZGZCC3EAO5foDUTDMOqiIg0HMt1v0iW4lsH1rJuEjdO2p4Bq/rBuVxJt/DCfni0wC
 d9FoAE8yKJuy/GiMPDNMHl3tfdHPNWTNuYb/iS9w3nIIX9FrhwFhOhdaIt/0iL3JN2sb
 ruyz7urY9lJaFNsxabA4egn6iCwfNmbc3HhJziNrk/kE51VOaR4dG0E47D9L/r3b65xS
 b0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766510775; x=1767115575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Rde5OrYxFRDd6W+VT1CBE62Mao2oxteoXB4bZ+nSYo=;
 b=j2lviMced60tj2XPEhGCRv0J/N7uSPwcWqwbBAOmX3PajnOSrhKsNCGLUYNikA3DPs
 rv8n9yXTZGRyKXjLs6+kIYpScIwFydV0bfkd82SteYGMXUY6v5iu9Dnuxt+TSd9EozXe
 +w5caiCiOhKHmshF0lMinX7CqckjiKsBaYWn9RaFGwL5KBlAChVFcme3vXL74Ugm1aUw
 ao79f9TnE1tbQFTlFL5jx+KqTXHGH4k10sjrhQLapfGJrChZ/BswDhjZmtyLWoDVez/r
 XnTydRONMw+mGJYYcXUiKuUMXVTQfs0xziPx9trIGPJA3yIvoPMHI5NDZiEiby1n+p8m
 toxw==
X-Gm-Message-State: AOJu0YzC6UdwKiJUwWwpnnnUVbtSc8vjTBwOWPEhFCsaKbXH+LHxhD9o
 oh4nCo0P3e0P+qNWLLhzN9PtV63vQhJ6uVSOzjDSQM+r8u6ZjPlwDxpZ9xWBbc6f
X-Gm-Gg: AY/fxX7K8QAaqa865lDy2zjKFnEiTNIB2wT0mxEgTvjgnHtWBneext6iUPNXHQKPxfw
 h5itmnU262lhmScY/DvKH1yOwuHwhU/n8YrIxGE45oF844/goL7eyCW8VeQN71PUiQoIFgiOQrp
 8BGvH4OlSbyHuMq0r+iDdRVsffYcdoHOBpig6iVovHiHuoaHGQi5y/FknSwfC1+ZBG0+FB4yo+R
 HzOYdQzJPE8YSErEewzIHPkcYCBkseg3FdRno7TwUYFx/QR8LZ4lKkprTp4S1jpL+NAzHQoae4x
 lFUh5FBxo5PxNlmoLeuhGQWYxMyBM+cXiXu4eE2EKgTtafPKyMdyrFkTFvdBuvyWT8ufGmqffT/
 fL4y0zDAKQDzMXECEmEBWdSpjJMVzxz8FIt/ZQaJp5NgbJLOC9BkUEimPipYQb012k8FCGrUjwM
 oBB/GAl8ZVSHrkD5qMxZvZgz8NRA==
X-Google-Smtp-Source: AGHT+IEc+4C28275WdpB5ngzcklTO8pv7V1QS34W4HVm55M2gqr/SZryga/RYh8vIrbj8U0vm8muZQ==
X-Received: by 2002:a17:907:7708:b0:b72:671:b2a5 with SMTP id
 a640c23a62f3a-b8020400974mr1494134666b.3.1766510775508; 
 Tue, 23 Dec 2025 09:26:15 -0800 (PST)
Received: from tuf-gaming ([82.78.167.169]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a5c4dfsm1465822666b.14.2025.12.23.09.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 09:26:14 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Subject: [PATCH 1/1] linux-user: allow null `pathname` for statx()/fstatat()
Date: Tue, 23 Dec 2025 19:25:48 +0200
Message-ID: <20251223172548.1847032-2-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223172548.1847032-1-jean.christian.cirstea@gmail.com>
References: <20251223172548.1847032-1-jean.christian.cirstea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Since Linux 6.11, the path argument may be NULL.

Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..e1b61f6dc5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12142,7 +12142,8 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             int flags = arg3;
 
             p = lock_user_string(arg2);
-            if (p == NULL) {
+            /* Since Linux 6.11, the path argument may be NULL */
+            if (arg2 != 0 && p == NULL) {
                 return -TARGET_EFAULT;
             }
 #if defined(__NR_statx)
-- 
2.51.0


