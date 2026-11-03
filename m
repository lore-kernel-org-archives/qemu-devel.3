Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F82606A32E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sjxnIDdF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOCNC-0003Qo-Q1; Tue, 03 Nov 2026 06:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOCN9-0003QL-Pl
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:08:11 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOCN8-0004Qg-4v
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:08:11 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso28528545e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793704087; x=1794308887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7iG2SYwtBBIhLgtuCXNogbrC0BTIs8m+FaLSVxI4qpo=;
 b=sjxnIDdFUgMBfZMc16pUPZMsGKUh48+hVIrS1H1IZkkGq2tbMZ6sKeEznAs1cPqXGO
 m/SWaH1B1Yf2reC8T393KWL8DkxUG32rZTHkBTTNUeTqQCyg70PSErNPTCdZp75wjGoX
 o5gLvrzL2pKQoEgevae9PX/PeSCUOMmrxDwFHRhYq9NWC5AnnlshG24YEwl6ouaUD3GR
 udcZGWqYDbhbnwizO+oGV6+iAIgUvtChpYqNCLmLUBL05qn8S4QA84W5xf6S8Bw64HgI
 Kb7FnU0PVh6tO8uax0O4ybFVlYPpP9m4aRTOTO54anXcdvGHYdCb38QWgQFBu1O+0beK
 rZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793704087; x=1794308887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7iG2SYwtBBIhLgtuCXNogbrC0BTIs8m+FaLSVxI4qpo=;
 b=BUcFfOoNtgCvL7q4UKn3ArJhNZALzb3+w8CrwD1HDMJP/7eP17iSAIPu5VnAJDOmqo
 x6OJG56RmWU/hImEBjrQrdh3O4oL/7CDVyZNi+jEIkzYVGDDNqctTf5FeMRI0LYAY69U
 ew2e1l6ERgBEXydT6OYTSgmsS0mKqkapqx0jPEo7n1xcwgDvAsXu3PYnXJJCeF266M4F
 CioLhQaUc04CWbM+QjjdwPXt9EIt28YC6EYTcMKH4M9Wr3OOSClnK6uHVthxzHe/YbJk
 Vtaxlj9138mgLFCXXGyL0CYD5qoXx1yxqblCgroDWHl6xy6vZ0f3/OeZVd8MDHcRy7rl
 sb7w==
X-Gm-Message-State: APuU4Z82gqCp33aA8+aCBnJA0ryy8B4j85ZBUcRIUecngZsEN7JpowT6
 2YLOyOUNcSGtQtBJ45i9C4MQPVNWalHSnYGcL/5rXi6yYxb7ZdMs6G2OgZFmXpVfpNh8CZ0LVjn
 CBp0mRK8=
X-Gm-Gg: AYBFou0yNjUor1YGt8zXVR+SglGKTdkso3vhhBmhbiHmf5/SpnpTZyU8kJj/tiVab1W
 j8DDjkGH5Fhk93PU5GGb/QmeOHRKHa04B3xxowzRxuPeKMyZhE5dz5MQiFCQzEt2yVixAbprfl2
 Yxwboy5vV+RL5T7YWvSdCwwriAY3fv29+XEH2bnmB06OSon3c8RfMOPc7+DgJA2P9ZQLkppnmtn
 kAASNnJUc/FdmzkfFTtsfRVC8RpTKhj68eCzOAl+m5PRgxlekNP8XqUlYJpCpdDycMTcgyC3CY4
 WqXpaCp8SPowdi/zpSRkMwV/V6RFNPV9vwlBUG4Fhgkw10wMUJ+BF8t/aDGpKpKB0/dQsJ3uY25
 xt/S4oP+Vjxu5/GV0Ami9YbMEz8hNo1XGTXx/nK057BhNud7ARL2dO/0Ig8I+pv1boUbwj41ObF
 W9uSQ2q88jyecqw0mgKh5fiAXYjtrwDqpd9hC9FTC+st9BdY/hOf9B4CB3YyMRD91gVPrfO8yJg
 GglDO+cX7oW/6eu7yv0SFyXIo3wpolV7T6IKeb+yQq8QcztYKOGrkhFHkkTHQ1BR021TCV28Pod
 JW6bU/dxb/eeyNORnHQNlIdd1GzNSXjmz3fGiOyLya8KhEUYz28bMwUsjPEiGUhMmEd2AvVrtXb
 jUo3RVvsLAJl6aStfBZyvQAnpL64lxcSGCQ==
X-Received: by 2002:a05:600c:638f:b0:4a3:59c2:b41e with SMTP id
 5b1f17b1804b1-4ac150b304cmr286411745e9.4.1793704087605; 
 Tue, 03 Nov 2026 03:08:07 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm442897585e9.1.2026.11.03.03.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:08:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] docs/devel/testing: iotests check script should be run via
 'run'
Date: Tue,  3 Nov 2026 11:08:05 +0000
Message-ID: <20261103110805.2010679-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The iotests section of the testing documentation suggests directly
running the "./check" script.  However if you do this then the
script complains:

WARNING: iotests is being run from outside of the configure-time python virtual environment
[...]
Please use the meson run script:
        /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check

Update the documentation to match this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/testing/main.rst | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index b0ca37fe2ba..e26b8af0c79 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -272,8 +272,12 @@ scripts.  The testing success criteria is golden output comparison, and the
 test files are named with numbers.
 
 To run iotests, make sure QEMU is built successfully, then switch to the
-``tests/qemu-iotests`` directory under the build directory, and run ``./check``
-with desired arguments from there.
+``tests/qemu-iotests`` directory under the build directory, and run
+the ``check`` script via the ``run`` wrapper which sets up the environment:
+
+.. code::
+
+   ../../run ./check [args]
 
 By default, "raw" format and "file" protocol is used; all tests will be
 executed, except the unsupported ones. You can override the format and protocol
@@ -282,16 +286,16 @@ with arguments:
 .. code::
 
   # test with qcow2 format
-  ./check -qcow2
+  ../../run ./check -qcow2
   # or test a different protocol
-  ./check -nbd
+  ../../run ./check -nbd
 
 It's also possible to list test numbers explicitly:
 
 .. code::
 
   # run selected cases with qcow2 format
-  ./check -qcow2 001 030 153
+  ../../run ./check -qcow2 001 030 153
 
 Cache mode can be selected with the "-c" option, which may help reveal bugs
 that are specific to certain cache mode.
-- 
2.43.0


