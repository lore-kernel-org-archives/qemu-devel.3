Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155C6C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB78b-0007pd-To; Mon, 28 Sep 2026 04:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoxiaoqiang007@gmail.com>)
 id 1xB78Z-0007oH-9t
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:55:03 -0400
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhaoxiaoqiang007@gmail.com>)
 id 1xB78X-0002dJ-OT
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:55:03 -0400
Received: by mail-pz2-x2a.google.com with SMTP id
 d2e1a72fcca58-882c2bcef77so617970b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790585700; x=1791190500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U63lHaeicpFEWBUa6vI1IpOgqgcW5RuE4jfl53b+aYA=;
 b=FfIXCEZKq4g2kK12VwOEVP3H01yMlL72OqF6mqpU9cZRRzAVITIYJbkej5vuJJ8a+L
 IbrJ5j+2pGRNnYLW/vaSsayeebbGXucyIFAy1fh5SaYiBV0dSJKkeKXjzUkHADl68qk0
 UtQS63ggCrxWRiyyoV/l6ZZtew68b9qUZ84mgHs8nfY7B2UslrYokr+uqImTj5HmSyOE
 Mt06TaRALSEr71gikrnC2jP6kHNBmeV2mZnGVeSe9mVzzu3F/FiWbgVdkQG3SkrSHrPQ
 cUVJXSZW1JwWKwyk7DS2kCi828A4QrevKwUhOZpLp3Rh2Csr+U6V8hzchY4KvGp5VYmn
 dn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790585700; x=1791190500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U63lHaeicpFEWBUa6vI1IpOgqgcW5RuE4jfl53b+aYA=;
 b=JX7onEmW7k04DQt3dwwBwjtYX2Z6fjW4zs8ynih1LivlPtvr4oqW9br3/YEavEdWHd
 1373+NEZdMN91z+ASLQiPgjlM+Up26RNtSQu85lI2P/0T6EAGMClPZlJfRO1ap9Yff43
 bp51rNW9Qrzr4zWCy6tmuVoN4AzwovUKjUNewwozqOjg9FuKMG2/SWYfsS+O8OjLtMil
 aQhrx0yDe/gxRqXUQM1/Bd/dcta8exuwa68UTxKHRwAX6uyAr4eydl0eunAJmg3vLXrE
 xmQ14f1yJh2+vyg6yRjLJ5cdOdi6fLsWz9EjEumFAy4A/vKFPESkDoOchgCmXl309PpV
 m6bA==
X-Gm-Message-State: AFuF++lV+7k4ERGT/E8et+GDEi230rq3i1BxBKZyPV5S76VQJEcixHQU
 g4ekrUCl2UjV1x6+4NHPc/yrjgS2ucUPyUYIJGsiywyxS+feRGnOGYcEaRnrQtqU
X-Gm-Gg: AYBFou1NHJmzVpGUZm+/2oPxhgbuS3fgXfBQ/pGoXSzEuhiYmkrFAHsqcn10fCmh4pM
 L3ZcAaYC7UF43T+byXldDLxn3nS4Tc+aYhUuQGXl0d8HWK4q1HeGti9yEMFlnIr8BQXtccV/Vou
 qyuMkLJUaS2nFoPnrrqCoMCDjelcOvcIVoOAVyw/bsqTEdC7xKpY7F3hmDsAi2UA3KOUjzbZChU
 9f19Tqm6Ncs+FvL/a5EXnnLF27OAmKTqUQO5jQVDx8YoZXWNw5dS+JxS/HPtci1TDohtc9HYWkB
 tWtMckZYG1TUBu9SEJgnUhGdRzH8lLo1rX7GJZJIlWLK0WfL9UgGJsQ5ORIy6Rx7mlVObHYfDVa
 +qu+I4p2tHv/NEwuyC0EsvH6YUR86lZBhW3WL4N/3ZgATVXXlCLDdXNBccnhCTovNUb2xHL92oL
 pLewaR9GfsS5axEBg8de9OSSn5rjRiyYg4gG9gd14h2HfPB9OGzh6FKDae9Yvq
X-Received: by 2002:a05:6a00:2991:b0:882:d8c4:17c9 with SMTP id
 d2e1a72fcca58-882d8c423bbmr2236261b3a.23.1790585700297; 
 Mon, 28 Sep 2026 01:55:00 -0700 (PDT)
Received: from debian ([1.203.174.67]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea18ff77sm3849500b3a.14.2026.09.28.01.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 01:54:59 -0700 (PDT)
From: xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>
X-Google-Original-From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, jiaxun.yang@flygoat.com,
 xiaoqiang zhao <zxq_yx_007@163.com>
Subject: [PATCH v2 1/3] bios-tables-test-allowed-diff.h: allow loongarch SPCR
Date: Mon, 28 Sep 2026 16:54:17 +0800
Message-ID: <20260928085419.188886-2-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928085419.188886-1-zxq_yx_007@163.com>
References: <20260928085419.188886-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2a;
 envelope-from=zhaoxiaoqiang007@gmail.com; helo=mail-pz2-x2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..53702282e5 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+tests/data/acpi/loongarch64/virt/SPCR
-- 
2.55.0


