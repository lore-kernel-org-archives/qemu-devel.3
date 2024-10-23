Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9598ED2E011
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9T-0007Oq-Mz; Tue, 22 Oct 2024 23:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S9C-00071u-2V
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S97-0008OB-5h
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso4141072b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654492; x=1730259292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OngEdDcxXClzCGFGbODXTalLFHBoaUhdi3GauHxJbA=;
 b=YAYiyTjBzQLRfqYoHhvh63fzEYc4/sOSBS/U9Rg6JdDoPLQzl0VzYbtJWLYsXfT+Dg
 0M/X1JD7Ar2hS6BTZ0D061M8VGlRCuhEVR3uFKMWZj2w7IWbbHs3CuIytpoYq5z78uE7
 Ll3dykqAxLdJlapMDhn2IbnQixQJ2XXwHK0BVolOrc/neHM6qQ+MkdKBQM1GTuU40v8c
 fX/rbWU0C+9Y5dMUwCOin5uphlmDrL5qqq5rXgw0H3Z1FtHQzAQVOtMxrWJsgvD1wWVp
 2QDw//q6qMZgFz1elu6ddn9YphYKt/7gnFWqGnETl2PJDEjPChnb4L9nPjj6u2KkUpAR
 nmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654492; x=1730259292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OngEdDcxXClzCGFGbODXTalLFHBoaUhdi3GauHxJbA=;
 b=f2tQqQ3qQrMk3VTM6k1zHxdostoy+hf7zd45Z+D1Gri1uXzyRrpUJqfcASL6Ag69q9
 e5FXGGnGKQQs+L33Dcc/PoZNYEKfSVtxxKUjvaZyvp4Rhk4d1h2HPEyJc8mNj44VIIcI
 mwMrMmcw0R7qVUwHHWbgeTLJcN3qSl7axHjSQB2JejAVFVBMi0xXXtSTm4GBK2tg9O5H
 Gc5AyBcEid8iYAb8X5ole+ioKTo65/eWkaVAe85US6+GiTYFzGsQc5vZfz4aOOFOpP3D
 woYNbuOGcGDl3Obqjma9DwCFxPTQh7hUqoU+4dm/dMiVAfV1/TrAkRq1M8ClEcTjMVMF
 SL/w==
X-Gm-Message-State: AOJu0YwGIisElb3i7+uEHGpef/BZNxEUVzCwAZMzAhO4JkZP6uGZS9GD
 lcSlzeKl5QAFLoN53vwleGFQ56jNHhUxA1UXQoDLykVEyCLBHaSSzxzZdmrDxIBNLNxf52/Ckcn
 4
X-Google-Smtp-Source: AGHT+IFF1y93URtQcNRgQYIzb4tLqZJv+PZylfOsMB8ykPfHQL8ymNodzlDtSQ6uP/33xaF0FerWag==
X-Received: by 2002:a05:6a00:4b56:b0:71d:f15e:d023 with SMTP id
 d2e1a72fcca58-72030bcbb6fmr1981515b3a.11.1729654491648; 
 Tue, 22 Oct 2024 20:34:51 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Yao Zi <ziyao@disroot.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 23/24] linux-user: Fix build failure caused by missing __u64 on
 musl
Date: Tue, 22 Oct 2024 20:34:31 -0700
Message-ID: <20241023033432.1353830-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

From: Yao Zi <ziyao@disroot.org>

Commit 9651cead2f ("linux-user: add openat2 support in linux-user")
ships a definition of struct open_how_ver0 while assuming type __u64 is
available in code, which is not the case when building QEMU on musl.
Let's replaces __u64 with uint64_t.

Fixes: 9651cead2f ("linux-user: add openat2 support in linux-user")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20241022122929.17465-2-ziyao@disroot.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0ade83745e..0e08dfae3e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2750,9 +2750,9 @@ struct target_sched_param {
 
 /* from kernel's include/uapi/linux/openat2.h */
 struct open_how_ver0 {
-    __u64 flags;
-    __u64 mode;
-    __u64 resolve;
+    uint64_t flags;
+    uint64_t mode;
+    uint64_t resolve;
 };
 struct target_open_how_ver0 {
     abi_ullong flags;
-- 
2.43.0


