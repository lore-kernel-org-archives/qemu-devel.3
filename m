Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6E4C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANKx-00058Z-EP; Thu, 01 May 2025 02:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKu-00056P-Oo
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:23:56 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKs-00070p-F5
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:23:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso541984b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080633; x=1746685433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFP3MpqDIAT/Xkpc6JOppR3V5lexoIXt45Qw9vGPUlk=;
 b=v2SogIA5+84h4HD5LRtuLF8ipIJkfjfBuhI5IzdiYl15fjdQyhLwIUMUiKN49hBsxk
 IDSiUJdXAuUDoDEsk92V41TW4VAOZzUkjhRWE37Xt6CxA2NfXBK5yImSb0c+BgcAP2yo
 5mOQdlrCScGG1zCDEOmTQOQ8eheYQ1za7RbFMAFgYUyldggm4chbRSe+KIkShtTOpy/g
 yzIhpjiXvWzI8PF9aUFZN35gvewjwzz2jNktppSToZbx3uILjO9Jp46HvF0qjUKvWrlo
 MW/cNzHd8wVNx5inKjfKcoeJDb0k/Kft6M0t/UeNYCbrOKVwMj9IDs3CcMl+N9MKExF1
 W35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080633; x=1746685433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFP3MpqDIAT/Xkpc6JOppR3V5lexoIXt45Qw9vGPUlk=;
 b=FR8ruhFNyFwC5Ldf5NJlIeBDCtLBJTzT5sc95bKDzgIDo3L/OetYFH/iu75PrYPKjm
 tMf0UAOZTbBv57QXT1dVC6ssj2sjf+9MomLYROd35j35S7e//knpOWrAQNFYcNegZ9Gm
 LHDhN6u1pvatBD5y7OEwcSeRs4IOC7ShQFyvZ6ZJBd2/dYcx3RDnJXiYqglu6VyoXjXv
 11wy2HpFK+KNUmMLXTbjc8rcL6uVEd4vjJ5tnqP3K/0HkdPBFUXEMtGyX8iHyfIBz6pU
 oyLK2OPpYl71fxjAytapqoPJ6oCvOLCobJWFM7ppanDZHz6q8moBLylVhpM2LU3H7Ub9
 yk9g==
X-Gm-Message-State: AOJu0YxLK2zwjR6w5XznVhMLCHJ/sM8/62HXFTV4KZY1GBoyp59ETSsL
 hqJtUZDLKND6DdWsZmEBqNzdl9ghOjxN9dPLHItz9A7Ov5BKbKQbvroNF5QGbdyfRerCCu42l5X
 7
X-Gm-Gg: ASbGncugXFO0JACU0dQHVVo/hBW6oG9MSqYt5HrR7a8mH6XuVIwLgtSGQk6Jjagp4B+
 mFtA3eFInfHM3Oms9Gl5Idp1nRjhB2MkY5OV8h/OeypB01gONXlpq5bDS/ntnnjh1s0AnYQ6+Fm
 wnNvECdI54jrnPvBiIcvArlSCRY//yXmBg73pnNG1/HXwhVdaLo0rQ49GC8tT8XPzdu9naJoP9Y
 eD0S+CrwBrRh1xmfxbbdhQu9sZJ4B5ua+Gmqqj5UmA4AGUj84MGubRVsuaIo19KaLrmBCpR8sHj
 X77VtNRBC5UJlf6z3JhXde44HQwtlQFQ9nRyvys1EWSdhpObm0U=
X-Google-Smtp-Source: AGHT+IHLp/Trg8oMhYx6nbkeIUGb3hwNnThgpDTal4sQohjTHqVJXTQEFUpkDpackSyscwLCbu/wfA==
X-Received: by 2002:a05:6a00:39aa:b0:73d:fdd9:a55 with SMTP id
 d2e1a72fcca58-7404944e683mr2015130b3a.8.1746080633256; 
 Wed, 30 Apr 2025 23:23:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:23:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 02/33] include/system/hvf: missing vaddr include
Date: Wed, 30 Apr 2025 23:23:13 -0700
Message-ID: <20250501062344.2526061-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On MacOS x86_64:
In file included from ../target/i386/hvf/x86_task.c:13:
/Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
    vaddr pc;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
    vaddr saved_insn;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
                 ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 730f927f034..356fced63e3 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -15,6 +15,7 @@
 
 #include "qemu/accel.h"
 #include "qom/object.h"
+#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
-- 
2.47.2


