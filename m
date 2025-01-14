Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A4AE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfOJ-0004Oi-2x; Tue, 14 Jan 2025 06:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNp-0004KX-38
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:58 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNm-0006e3-FW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:56 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e06af753so2715894f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855212; x=1737460012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsJrQyXEWZvrTPX4VUVE9uBd8vvjXQHOnXreMlY89ek=;
 b=dqLrN7x9vIaMFIPTiGPzszoh9Vle0SZIdveecXAADpT7vwlVVrgH/KThwFSWuPzD6j
 J6cVsywdx5Kkrsd2Kl/7mEt87Dr/oZlky98TMV47sEN+LpxOZ3Rhr1c/SCMLfpIxxCUb
 FJyAl63bmyiJXJwT8jxvqQkJVaxBbBPUpk3QKhVrAy7P0GDPeKQBm96J3B1mG3hmsL4r
 IhsAxY9AhRituYjjDvFelimCtOUYoTg2bCRFEhdgfgJ9GzRjQzi0AYPsPWsFi/hw9BPg
 myc2QDRdfHP5L2j4OEHxicz2gAJSxrF4AgRUI1DtjnmEXteuJoFGrSyW4UhxcRfa9dQf
 dJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855212; x=1737460012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsJrQyXEWZvrTPX4VUVE9uBd8vvjXQHOnXreMlY89ek=;
 b=JhERNER6QV75OBV4Xe3kU93FlJuhOIh878G7lJXBdutbDf4afMapFBissEzGvyN7Oz
 a6gEh65CPdCLHF1dKf6h5lGP/tEzFf+LhYcb2MulUhkSa6hp4BVEpqLJPONSsSBxmyXv
 9H3csKW5+IlTm3DfSFXADNTfyq15BNP0hYOVnyob1+H+mh4Tm9Y1/UhF6Vf+Izpk7iHH
 ogh12GywdbUH6SpKaxYrE1iZ8Da8DQKTbN7J8PjGUcBiJqC/buBTaLbhZFrGJSifsLvw
 MgBtetHsDy2P4W/x8RkZjsEl4aaGaqrJQHGVOg+sjhEEKyq2WSJaxaR6f8LQn9Uq5Jtk
 oOyg==
X-Gm-Message-State: AOJu0YyG8+2JjmMVxO1RQekSo2/0YTEvvc1zoiovXdiPGltPM8d7dAbg
 1d9+fDv4E8JEj61fZj9zzl6/jecR+vHAmPt5fnHlvmmEmvJbp+N0UAWjxoOi0wnqdh456eZdXh+
 vGyU=
X-Gm-Gg: ASbGncvkOF1hiGSzWuRktKwUhlzYszcdZA6KvOUPhqh50Ts+4gAqP+OCKc4Iu00LUNB
 JlgckUqwBXdyMgAHuuwruRSwbuprLfVlFDtNT1F/1EP1Lytk0db6JHRuRycfFtjn2M3QH1zuMhv
 kyKxEwAZ8k3q68w4IETOvUeWmf0fKPqjbknf2/sc4xQ/lDmrlB2F29exdpjG/lSya4h4eFYcaJ6
 eUewM6oaoRXTpznkR6AiqW7R6Kyt7OyvFthzy0lOUZwnuh6ZjTIDEw=
X-Google-Smtp-Source: AGHT+IE1DFN+OWPDp14+H/YgQki97VWAV3NLnStbT0X6sb+ofZLZxMSsL1CtkbJ3Y8sVU3fScSyTbQ==
X-Received: by 2002:a5d:47c4:0:b0:38a:41f8:8abf with SMTP id
 ffacd0b85a97d-38a87312917mr23365848f8f.31.1736855212602; 
 Tue, 14 Jan 2025 03:46:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b80c9sm14473802f8f.84.2025.01.14.03.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 735D15FB53;
 Tue, 14 Jan 2025 11:38:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 28/37] tests/qtest: fix some copy and paste errors in kdoc
Date: Tue, 14 Jan 2025 11:38:12 +0000
Message-Id: <20250114113821.768750-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

A number of copy and paste kdoc comments are referring to the wrong
definition. Fix those cases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/libqos/qgraph.h | 2 +-
 tests/qtest/libqtest.h      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
index 1b5de02e7b..81fbfdd0e2 100644
--- a/tests/qtest/libqos/qgraph.h
+++ b/tests/qtest/libqos/qgraph.h
@@ -355,7 +355,7 @@ void qos_object_start_hw(QOSGraphObject *obj);
 QOSGraphObject *qos_machine_new(QOSGraphNode *node, QTestState *qts);
 
 /**
- * qos_machine_new(): instantiate a new driver node
+ * qos_driver_new(): instantiate a new driver node
  * @node: A driver node to be instantiated
  * @parent: A #QOSGraphObject to be consumed by the new driver node
  * @alloc: An allocator to be used by the new driver node.
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index f23d80e9e5..fa08c7eca5 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -365,7 +365,7 @@ QDict *qtest_qmp_event_ref(QTestState *s, const char *event);
 char *qtest_hmp(QTestState *s, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 
 /**
- * qtest_hmpv:
+ * qtest_vhmp:
  * @s: #QTestState instance to operate on.
  * @fmt: HMP command to send to QEMU, formats arguments like vsprintf().
  * @ap: HMP command arguments
@@ -904,7 +904,7 @@ void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
 
 #ifndef _WIN32
 /**
- * qtest_qmp_fd_assert_success_ref:
+ * qtest_qmp_fds_assert_success_ref:
  * @qts: QTestState instance to operate on
  * @fds: the file descriptors to send
  * @nfds: number of @fds to send
@@ -921,7 +921,7 @@ QDict *qtest_qmp_fds_assert_success_ref(QTestState *qts, int *fds, size_t nfds,
     G_GNUC_PRINTF(4, 5);
 
 /**
- * qtest_qmp_fd_assert_success:
+ * qtest_qmp_fds_assert_success:
  * @qts: QTestState instance to operate on
  * @fds: the file descriptors to send
  * @nfds: number of @fds to send
-- 
2.39.5


