Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64507CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU5M3-0007sx-AY; Mon, 01 Jun 2026 12:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU5M1-0007mU-38
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:19:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU5Ly-0002RF-Je
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:19:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490aebf33e9so4178685e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780330741; x=1780935541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woRFDgkeltSJSljZfKDRQkqjb3r06yY7f7258KpFoKU=;
 b=gV9MJyg6iwnxnShm5vv5LesxzsM061uigyDGjaiT4YtBaWyQhVvSgjOS1GbW7jPaBr
 G/uXCC5rqN/D+F2Oa7vlHHdq+lYllA/U5M+J/ypjFOrHpkjT4OgstXjc1n4eyrvf5u8B
 UyHpKPkRmFqzM3ArZCozYFw+yyOL6a4RX6JXiHW5My3ddisnI0RXYHr2n7D738oq9j0V
 iReq3zQ5t7hu23bV9yCAtkrX8HNW6iAjF72aDKLMhMcbv0wrO3b0a0zg7wRqNd9GE06F
 ag9bktMp/RaQHuxJvmPjXmoFtJzlhP9sEkx1wd1E5rDkra+0bR0NyEII9yw7BgLLGDRt
 SUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780330741; x=1780935541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=woRFDgkeltSJSljZfKDRQkqjb3r06yY7f7258KpFoKU=;
 b=RweV+6MxcEnwQBQjqsFrB4oWXJMoJVXfNho/xxbyNAFNBdT2qHr004E+Ch5BrjY03e
 QyhhvkQVwWGZZSjWDOuY7VvxPprd6BqDtPPw/huOMm7y8qZ67sLowO18kh9g43wtPeZ9
 y9fu27QpHX+BNu0bZnXhTNB+lvnHxOxNGQUpgYTHp9a7xAjcaYZher/UVxPdtDsCTI59
 FB1EcjqMAJ6hqo0qwhhPyUnSa92NqjZyqs7oGs8wNDoWVby4e3H1gUHceLNY1THv5uWD
 oCcl9jkhUegl8FIbTRl+WHqyUouwE7AXeU/Yfc8MxPPpFFpRffdWt4JwnWTwfB44lCGx
 akBw==
X-Gm-Message-State: AOJu0YzfcN/ip6UcmpjjlG74EsClZKt7Z/+mWPfbIptGXg09yu4JTsoR
 PZlVelqG/EqCnWpywCSB/s8v+bKO3xElM0CN39BXoBZA0b41qYlaWDnq9mp2+g0A8Mw=
X-Gm-Gg: Acq92OHAGvQEiwc4ojWmfkqupwUhMIj7m6zxk8aI5j/8QjzzngSf0/wvYGkLcnkYcqq
 +PVh88FZQL8mS2SpvU+OrNKr3ut5k/dLPs2sLabAn3mGvyl1X+YJcfzk2+aJFXD/16SQKYgsp1a
 EHcDj0b4fW5GQooVnosGxJ1YwzgvWftceKrLBSjghn23CXPkEE1A0Soj6lpZw93c1adp4WJ14a4
 WCAC12cweR9MFpcedKVBn99PRpzUtCzAFl0BQUXqavzfReWuhbWH6kuy/OZ8VANsuxVS8PHezuN
 kLY4jfoVyIe3fR+jd6sKGwweip0z4G9AUYiqmbcULiOxIam1T+UQbjXSXPXb+UqZXXpE4R114mF
 PcVH1UwbvO7CAXsvjVkU3g3elZiBT62OUSjxxmdvkclQ+5WO4q2QPuNZ30jOFh9q0wizR59/F5o
 3NFHFSL41bSWycVTtzAlJOc3oIwsLZ3MSytg==
X-Received: by 2002:a05:600d:6445:20b0:490:4f91:5519 with SMTP id
 5b1f17b1804b1-490a2958db9mr159368015e9.18.1780330740935; 
 Mon, 01 Jun 2026 09:19:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e823f7sm2381655e9.13.2026.06.01.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:18:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7EE9C5F8BB;
 Mon, 01 Jun 2026 17:18:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 1/3] Revert "Makefile: include tests/Makefile.include before
 ninja calculation"
Date: Mon,  1 Jun 2026 17:18:56 +0100
Message-ID: <20260601161858.182286-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601161858.182286-1-alex.bennee@linaro.org>
References: <20260601161858.182286-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

This reverts commit fd63125b9089610d63a53c11ff2fda6b53a2265d which
broke the ability to run the check-functional-FOO series of tests.

We will need to try something else for the MacOS builds.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> # running tests on an s390x
Message-ID: <20260601143129.144786-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/Makefile b/Makefile
index 829c51e364c..54547a37b1a 100644
--- a/Makefile
+++ b/Makefile
@@ -45,8 +45,6 @@ include config-host.mak
 include Makefile.prereqs
 Makefile.prereqs: config-host.mak
 
-include $(SRC_PATH)/tests/Makefile.include
-
 # 0. ensure the build tree is okay
 
 # Check that we're not trying to do an out-of-tree build from
@@ -182,6 +180,8 @@ endif # config-host.mak does not exist
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
 
+include $(SRC_PATH)/tests/Makefile.include
+
 all: recurse-all
 
 SUBDIR_RULES=$(foreach t, all clean distclean, $(addsuffix /$(t), $(SUBDIRS)))
-- 
2.47.3


