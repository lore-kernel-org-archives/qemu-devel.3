Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F0FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJLv-0001y4-7X; Mon, 13 Jul 2026 12:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLr-0001vx-Pj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLp-0008VY-RZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493b7612475so26556185e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783959468; x=1784564268; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bLcty5828NfzvVAqvyUVuUlUIpIVjjLhuUFw0yq++bk=;
 b=GzVtg4mTZb5HFkWWIFDZTgmzsMUG/dwD08cSWZLaWtBHhdZzGqoQT7VQDgMU1b8n+F
 WPT6whxghVJgJMUzK8vMSksQZ/VZjF2WCjzdZ87i4hEhhAVNsm/4sMJDRMsvkkxN5Pct
 hac+u8yAeAe9FMo0hvHmieKgd5HG2M3sbTL6waIYSKS77i213m1CgT/VdThPx/6zq8j6
 nDgxFlyxxOcpchvsS4HBy6Kr8LuWO3c9BHxfObZZZpoPdTN+xZc3R6iHwwHtHz48vEfW
 yXjDyISxn7Ft61XJ9aHh+D1XWmX3WWlH0JrXWmat9KSK9aTQj9ZAPWEFevYIT0ea2lnx
 GN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959468; x=1784564268;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bLcty5828NfzvVAqvyUVuUlUIpIVjjLhuUFw0yq++bk=;
 b=YFbO3NGuUUZeviyEFeb2n9abS+DdKZU4YPsYJ4dLjt5A487XXuyUDgYCaCvvqFgfXy
 djJomTEWOenkwX6647KQhed+jLDbdxcSgQaEfMrOnNhryZMcLUwhEmQrP+WC2brhpkUT
 HsSOJJHFNv3nB/6/m5vC2wQ7PlTO/rTH2c42yMjP+bhrOwuhYRvt3mGeLNHx/z+CijwN
 8qgCOXiNaEeT4a6sARh5xzG70ZdWkw9cWA+S2kU0qRuQ8SWHo7txWVN6/rKWKQ7KBmpP
 mYZ5CDcw/QSBzb6sM8Mrv98y/z7hbDYNTop0D8NGJerWXAqcxuowonWHhvRxrPShDfrl
 Y5eg==
X-Gm-Message-State: AOJu0YwKUGPxaRgWCT1Qccnsmt7Ake0DTZS7G5XXA11Sjylso91WshtS
 GOixZcs7Cv7U8hgjgj2fa9/aCMWLpsIadzWyLd3NYr+q5B/56+cVu0vR5x1STTGu0do=
X-Gm-Gg: AfdE7cnp0LQkPKfSbIRRDUsaXZvRm+zF3rBnhj3vG+sNYtKgp/RRcVvSMsHwqIm/pe/
 5X48aN49ZC33LAMDIAnrO9Rg+1xm6g9MYN4sM82dKyec2yjr2IwC+krOPMNLDI91ZWJ8XMI7D0P
 /gibpJc0HYeCWnLJATc0zrbdQDfy/Tt8tET/uKsRendC/r+M417QvTB+ElMgsUJsvwduQ6NjSya
 UvcwuEkAPinoBZSXCCwJGwmcsFuOWfp95oy9ZlZ/vjczkBeAZw7c0Kqy9TKfAv9RGcRnSTMnnYD
 BI2Uj6UCwvgQX+7br0PQGh1Vi+tBePf16FPjNtbmBLu3jU13Wgxl0AK+DyNQkDs8exwUD0sawIc
 MDUsjA8eWLOdslubfvxovnz6WSKfhoGtInUtWJVbR89qHoYydqfGsQrdO1sHA61Lx4c591GOQJB
 qDgIzhBQ4mmB+k
X-Received: by 2002:a05:600c:524b:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-495159060f6mr529645e9.24.1783959468167; 
 Mon, 13 Jul 2026 09:17:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2e98b0sm11232215e9.8.2026.07.13.09.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:17:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B29345F856;
 Mon, 13 Jul 2026 17:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/7] mailmap: add email mapping for Alexander Mikhalitsyn
Date: Mon, 13 Jul 2026 17:17:40 +0100
Message-ID: <20260713161745.53889-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713161745.53889-1-alex.bennee@linaro.org>
References: <20260713161745.53889-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

I use my company's email to sign-off patches, but send them from my
personal email cause it's Gmail hosted and works much better than Outlook.

It causes some misunderstanding and inconvenience for maintainers sometimes [1].
So I would like to add this email mapping to clear out all possible confusion here.

Link: https://lore.kernel.org/qemu-devel/CAAjaMXabXNmh1UZ5wnpX4wucnC+yWvMo2-jr2XBTby4zqf6CTA@mail.gmail.com/ [1]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Message-ID: <20260708134744.169452-1-alexander@mihalicyn.com>
Message-ID: <20260709080040.4157324-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.mailmap b/.mailmap
index 7665ea87562..9ad072234ff 100644
--- a/.mailmap
+++ b/.mailmap
@@ -123,6 +123,7 @@ Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@weilnetz.de>
 Song Gao <17746591750@163.com> <gaosong@loongson.cn>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
+Alexander Mikhalitsyn <alexander@mihalicyn.com> <aleksandr.mikhalitsyn@futurfusion.io>
 
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases
index e26b00a71d7..f838768792a 100644
--- a/contrib/gitdm/aliases
+++ b/contrib/gitdm/aliases
@@ -33,6 +33,7 @@ malc@c046a42c-6fe2-441c-8c8c-71466251a162 av1474@comtv.ru
 
 # canonical emails
 liq3ea@163.com liq3ea@gmail.com
+aleksandr.mikhalitsyn@futurfusion.io alexander@mihalicyn.com
 
 # some broken DCO tags
 yuval.shaia.ml.gmail.com yuval.shaia.ml@gmail.com
-- 
2.47.3


