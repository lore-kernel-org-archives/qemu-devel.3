Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A68C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebhh-0003Bz-6F; Mon, 26 Feb 2024 09:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhd-0003BR-Ev
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:33 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhb-00024l-Pt
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:33 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d204e102a9so36270061fa.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 06:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708956690; x=1709561490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECJWBAuFizFY5M+8BFfcvUn+iW291fgpghDCdO55uQY=;
 b=yPR99tnn/j98GrzA5rhv2EpShQjrtUSgsqSBFpdxnFXCHdC+WMPfwDyUGvv8WZuWlk
 tANTbiqOLqgtsVt1/btZpmsrmWscyrPZrH0dQe90JArkLaQZTO9wyZE1utETGXCGcOMb
 z0DUEme3tGQ3V8NhSuaf8EHHR7gchRex4pB5/nRtJ2xqtStSPEDDcraV3MuYPqpZrdz0
 a8lkmZMFXqJSHB28yhjjQm9ZK7pbZUAr3SYziv2tQXZhRmiIDQnjhA+9NSq3g/yzLf/P
 9/Y7STi0mlzh7FBx3pu5rvea+NGXJadVp/0PDkPf54x8vVCt2tewG745ehBJqWs9M7wW
 tFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708956690; x=1709561490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ECJWBAuFizFY5M+8BFfcvUn+iW291fgpghDCdO55uQY=;
 b=m/Ex5bk+BrnGf35MFj2uYsXolod4LTGXLCQxDctneuKAGG4hglojQabBqhq6Gqsg80
 a56t2kVTM4sJhcHsWI3cRZ9juDmSl133iYuyF2I7QkIwimFKxqvWWmsXJ9408xfN+PwD
 nPHmdCht71Z6OZDa9WCL0Ne8ECXGdt/r6vuMLQrds4/ekbYBtiDECkXm//8tzVUOOO3t
 xUk/T76QkNokctTzESQrY6qy7Hf4keRcxUfd+nrw//wSQgUfqexLjcbIQCt2QTL6mH/j
 oXMmasjm+xRqGsNkxlnTczOGLErveMpZrZKrAdwZ5VqQKyDEIIyv8Ma4IwPfBsjD4cJj
 xGow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXlMDIjoblbZn1iOE/MvSGG92DPRGrytep2tIRy31QyMebEqfaZ0B+AogujSEN+es+hyvV0LwcgLZgjS45wp5/LksMRK0=
X-Gm-Message-State: AOJu0YyAe+O3XSk9aNtw4X6FsNuic8RxiMZJc4weNKk0buEcNtt0e+5a
 SnRyeM3YNyISK8V3oNqiYklAewhhhUcel1ylzTAOORXb3Aijgpj5bL7DcKFkXDA=
X-Google-Smtp-Source: AGHT+IEPkgQkCpspdhaP96yTf1JqLnTZw0O7hCCeEzaCub6DsRYfYXaUBI+4AeKoCQT1NglpriGtZg==
X-Received: by 2002:a05:6512:3b2c:b0:512:f719:aec5 with SMTP id
 f44-20020a0565123b2c00b00512f719aec5mr4068070lfv.9.1708956689785; 
 Mon, 26 Feb 2024 06:11:29 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 gq9-20020a170906e24900b00a3fa275de38sm2438554ejb.162.2024.02.26.06.11.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 06:11:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v6 3/5] util: strv_from_strList
Date: Mon, 26 Feb 2024 15:11:05 +0100
Message-ID: <20240226141108.73664-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226141108.73664-1-philmd@linaro.org>
References: <20240226141108.73664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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
Message-ID: <1708638470-114846-4-git-send-email-steven.sistare@oracle.com>
Message-ID: <d126c937-c705-476f-baa5-d5e258780cc0@oracle.com>
---
 include/qemu/strList.h |  8 ++++++++
 util/strList.c         | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qemu/strList.h b/include/qemu/strList.h
index 4e2e78624e..b13bd539c3 100644
--- a/include/qemu/strList.h
+++ b/include/qemu/strList.h
@@ -22,4 +22,12 @@
  */
 strList *str_split(const char *str, const char *delim);
 
+/*
+ * Produce and return a NULL-terminated array of strings from @list.
+ * The result is g_malloc'd and all strings are g_strdup'd.  The result
+ * can be freed using g_strfreev, or by declaring a local variable with
+ * g_auto(GStrv).
+ */
+char **strv_from_strList(const strList *list);
+
 #endif
diff --git a/util/strList.c b/util/strList.c
index 7588c7c797..6da6762c08 100644
--- a/util/strList.c
+++ b/util/strList.c
@@ -22,3 +22,17 @@ strList *str_split(const char *str, const char *delim)
 
     return res;
 }
+
+char **strv_from_strList(const strList *list)
+{
+    const strList *tail;
+    int i = 0;
+    char **argv = g_new(char *, QAPI_LIST_LENGTH(list) + 1);
+
+    for (tail = list; tail != NULL; tail = tail->next) {
+        argv[i++] = g_strdup(tail->value);
+    }
+    argv[i] = NULL;
+
+    return argv;
+}
-- 
2.41.0


