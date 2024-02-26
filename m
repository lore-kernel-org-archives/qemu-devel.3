Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7C4C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebhb-00039f-05; Mon, 26 Feb 2024 09:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhX-000396-5e
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:27 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhV-00024A-H5
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:26 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-565ef8af2f5so1276032a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 06:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708956684; x=1709561484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKjecqdxRCZ5NMK4buR6wBDSR91vGXc+/LHUa2wYvFI=;
 b=XFvPHYIy8rbpshtkBkvNl9VXn6hnwQj3Y2qWZRXvSHnjxIiz+O1XAzqMY+0DSBY3eP
 oQuNfHC7sSWPd9fVF3444nVIzz/tDEvdAIEMf6EPqhGiDZTfMBCbnponDGySsFL+t9Js
 3IjLUeSjPWfLefyvKhmN9JJ78AaNb4WHPY6wrvJ2DQuRieEqG32ABAXEf8U6LwcDIskX
 DgF7JVK4IhqVqW89nozt3g08o2WxKcBudaD9xEycPy6pAdr7a/JafGW4gAxH/HNwJypr
 lZw0+K+SYlx1F+yqQjXSb+JsdDGmOhmvuOELo18IsVrPFB52ixPE5BBekMp8UDM2G63/
 /mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708956684; x=1709561484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKjecqdxRCZ5NMK4buR6wBDSR91vGXc+/LHUa2wYvFI=;
 b=fArWBlVnVSim7/SjU+aqeghIqJbE2ONc62R5JrjwCebjZ8gTOkrWroawCovJiLC3kP
 J752vwgA7Wyc4nLiKNapIoaSAhI0WQbjxuPDYWukOb1sawQ0+OW3zNYLvC4mw0W8RZX2
 u0P9ACfKudDoiSDV0oHbOUJoKBLNhA+LtrotAR+gjRIwh5cXTGI1vglKnn7wSDG+x6nA
 ntnIcZLhw0m51ZANHAqgnCEFJgZZlGjnsxL3UHaazk/UDkliMsZhj9gp2tEEjUr6MGUJ
 wt1NUxtw9FBEEt7L5YJf1i3lXYcrSq4ro6RuEtcbN2ZBAsxIOQOGBnO3n1sCONDLON8Y
 nofw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE0ndVnzVJeXyq/zgTQMQ13TTy7O8Zm2zia4VMHLZmBk7rekm0hxCB4o0ET0cyUlP3CuswbM6VkvPVibj9S9v7dACOs2A=
X-Gm-Message-State: AOJu0YwdvmNx9LY9iY+AtP07ZmiB6Bb7lAoVYLI3eaZ+A6WxtolGVOks
 JxzlGCTJ0Yp7EsYVwXRHm9/Qm8FvFskaLi2BOabUo1CiwzQe4sdAmIuFFOc2/gg=
X-Google-Smtp-Source: AGHT+IFxGhT9FNZWJ+dorAita6X6FN6sgnQt3C3KAKJ8Rhq0QI8Hp9eZimdEcW0d36MaOC2hI/54RA==
X-Received: by 2002:aa7:d48f:0:b0:565:9f59:b3bf with SMTP id
 b15-20020aa7d48f000000b005659f59b3bfmr4383451edr.6.1708956683815; 
 Mon, 26 Feb 2024 06:11:23 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 eo8-20020a056402530800b00565001948dfsm2374623edb.44.2024.02.26.06.11.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 06:11:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v6 2/5] qapi: QAPI_LIST_LENGTH
Date: Mon, 26 Feb 2024 15:11:04 +0100
Message-ID: <20240226141108.73664-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226141108.73664-1-philmd@linaro.org>
References: <20240226141108.73664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

From: Steve Sistare <steven.sistare@oracle.com>

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <1708638470-114846-3-git-send-email-steven.sistare@oracle.com>
---
 include/qapi/util.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index 81a2b13a33..20dfea8a54 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -56,4 +56,17 @@ int parse_qapi_name(const char *name, bool complete);
     (tail) = &(*(tail))->next; \
 } while (0)
 
+/*
+ * For any GenericList @list, return its length.
+ */
+#define QAPI_LIST_LENGTH(list)                                      \
+    ({                                                              \
+        size_t _len = 0;                                            \
+        typeof(list) _tail;                                         \
+        for (_tail = list; _tail != NULL; _tail = _tail->next) {    \
+            _len++;                                                 \
+        }                                                           \
+        _len;                                                       \
+    })
+
 #endif
-- 
2.41.0


