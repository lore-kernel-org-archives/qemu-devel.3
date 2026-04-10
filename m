Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C9CF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHvG-0008WF-Bv; Fri, 10 Apr 2026 15:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvE-0008VE-O1
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:53:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvC-0000VV-84
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:53:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso38602325e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850820; x=1776455620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2WKZF4iKqMlnmispjyJNMuthrudidPMtbX4QHH6Sz4=;
 b=gGYa66MFTvuuuK+1jFpvswZoWsV91IpKk0TVhL4SwiHMpcbnbT4oB3mPFjuTBhYsjG
 zwhR3MflKRvizymOE6tCK1FCm36PUvEnpbLWZAucsfKKB6VtSRPxpS378PzMSDoNkTQG
 hLuKP+L2345g5od/2d3Tab345D5e3c2V3+sejpqkLdJ8HVu1Zf4hk607qDQtIbQMqMdU
 kEkyl3fOeDRtF5qb5jSPnvi0BYUzh+je15Eghgm0DX/8otZGnkbNECPo8rBv1x1KYx1U
 i6Z9w3t/OXaqDWoKuaypzM8J7k8OVAiI7tDMCzj/g1fM5+A07rz6PXe5EfS4HLHDr1hN
 CQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850820; x=1776455620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K2WKZF4iKqMlnmispjyJNMuthrudidPMtbX4QHH6Sz4=;
 b=ftN+VKo3c6Mi5YwoeYDofLqKa3CYdheR3bON3g/nmpCzid8+Pt5niK2DZEa7wjcQVO
 KqvAIHZKdSbYVgqk2OYL03AiPFnG8RiiAZUAZt6KsEJKq2g3Cb33a08Nw/hXPbUYAW1s
 NtycZILHfE6PI8VuEkqneZ9dDxO217hy7J+X9GQDT1zwKTkeQbKn+RnWDELmzi10g+Ee
 aBWc1PCP28LfBEf6k4Q6D/xDnjzObojJj+v+7VNi+QGVUW2QHQJKaGqsYRLKPCgYU9c8
 WskIk6sexua3o+RpqUiflrcl5DLfCIUv3cloIQQfnfVvQj0JWjgAkCnXWceEG/rDCCnq
 unHg==
X-Gm-Message-State: AOJu0Yx7oqncy+PY/Iu5J1BKBfK7r97GzuNTN3jf/v5NUdDJADslAp2B
 bBuH6HKzQ7aFwr1rgtD69Pj0eMzWVmT6Mkq73mE74aGvWYgZZwaPWQt4SjE8XlEAVcYBm1LK5cp
 FPeTHVXU=
X-Gm-Gg: AeBDietrSrIPKvzpxW8TJLfSU7zrl4Jd9WPjDrOdeoypntSwUGmOi5jPRwVfYfzCF4n
 KhmJrQNjUjghd2eU1q6vT1RZc0bEJpw9BpnfoJt/elmn9seia4z2e5p/6XVPqD89xanELTsujHN
 mT0zfvX4q0sHxIwxkCvhzukbaZvyhCUYxp1Hpy17uOx9cNgmvqJg4FgXwK5RuC0gqNKFybHddqR
 pi3JEM9cOVld6NXwb2VxgAFe02blDsrQL0sj7aL8J2aRD0ElUNYSkxDTTIKYC0DfuOmU7LnLiti
 h7DCto4t4s6IuM/3BODBRmqfijRCSSbiRFqX1GSoAg4ggCRbFALab3sKIHADwzxRrsaTujC9u9b
 H8Lx1y3gSOG3c/xSQXDANJWozbhajh6iYEsADzWyczXhBMfn1XouL64kP3t7yeSu+IvuJQt/N9h
 fZCFy5GlfELYttXYGf9F31K5koJZkZZNzkpljLetEP7gIG9LTGU7OU4EWv9YOc3zatDPDNBYJR
X-Received: by 2002:a05:600c:a408:b0:488:8b99:54a1 with SMTP id
 5b1f17b1804b1-488d68865f6mr46720645e9.28.1775850819896; 
 Fri, 10 Apr 2026 12:53:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f229sm129524635e9.3.2026.04.10.12.53.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:53:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/27] monitor: Remove target_long use in get_monitor_def()
Date: Fri, 10 Apr 2026 21:52:56 +0200
Message-ID: <20260410195323.17937-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Truncate manually, removing the need of target-specific
code in get_monitor_def().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 812714ada01..b9b79e8e927 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -93,7 +93,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 
     ret = target_get_monitor_def(cs, name, &tmp);
     if (!ret) {
-        *pval = (target_long) tmp;
+        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
     }
 
     return ret;
-- 
2.53.0


