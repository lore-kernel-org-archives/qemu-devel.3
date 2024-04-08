Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8155DCD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrKP-0001eY-4o; Mon, 08 Apr 2024 11:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrKL-0001cT-NR
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrKJ-0001rp-AJ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8O1sCH//2khNzwilmMHZpPjVB9bTVHLD9KmdZboVxcI=;
 b=HUJHyquIhZw9ClOUCkSS6JaH5g7fxPrfM/X70GmMrG0dJVC+CGBBLe6pAP/RgIwPwFJgEg
 2bHqNVOqqlOMJTDICW0Ek4xCphiU5eqXrEUpQXpy0sYlB1IaXDefD5sApCtbV4P4CtZ1GU
 jdhszUAdUg0eRY3S4/psTkwSRzBfgtc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-LX7vRJDoMRWIkmkA4dU4fw-1; Mon, 08 Apr 2024 11:54:28 -0400
X-MC-Unique: LX7vRJDoMRWIkmkA4dU4fw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343f8b51910so1431668f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591666; x=1713196466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8O1sCH//2khNzwilmMHZpPjVB9bTVHLD9KmdZboVxcI=;
 b=Cci6vL7SuzxCfmAANfTWGWVWsmOBXkNmpCYxa1fuJwk+FhT3XF6MGaXlgZsp1MXSv4
 hFxdi6uZjmzs4/YdgwT1afRx3+ryUpbL81MD0ofVni80WvWFqDXai/oRptBcDyC1sL/k
 xs/okrpZ/2pFepz3VYOVwOCYg7ngce8Kbhsp4rwx0aWdjpyClUr64ZJE2KkRO1EpI20n
 tzCKMAqYs5k56iZUjX38mgmdTx5oDGqbOhxAuvLx8IwGLyPv7zO1yklvx12MKegcR9BC
 DOAU0a6ODDY7HAxqeGP91jUdvKAM6lZxdmWUdYOfhb+B6Ro/cS6T6otO7Vn+wYB/nEHe
 0PDg==
X-Gm-Message-State: AOJu0YyHpLXtNMaxPhdXrApwZCp1Jzi87nhRaYGLHQl5JoPyhzxETECi
 KYN7PF3F7muGOFizF8amj5OG/YEt8Kx8qMRrIXhQiZICGPZoT2VDWLWTId7kdNt8ItywDGI3Yft
 ooW7REnqNvw0rol9WaojGUpA+Z+wYvPFer3WZajVUONWkLhh5WVYz7uZKeghXNBdhBGLZ70Veu8
 lcbmFdLnp2jmtG+3sfQh/numc1HeulXHUs/dxS
X-Received: by 2002:a5d:64cf:0:b0:33d:c657:6ae3 with SMTP id
 f15-20020a5d64cf000000b0033dc6576ae3mr9372015wri.7.1712591666758; 
 Mon, 08 Apr 2024 08:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsebQi1+SKUqEl/6WVAJcKM5Us5+PJlc7NfjUB6OgjychLQlmTG/0iAiXB6/7IdOOLNdK8mg==
X-Received: by 2002:a5d:64cf:0:b0:33d:c657:6ae3 with SMTP id
 f15-20020a5d64cf000000b0033dc6576ae3mr9372004wri.7.1712591666516; 
 Mon, 08 Apr 2024 08:54:26 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 k26-20020adfb35a000000b0034607c7d194sm302429wrd.8.2024.04.08.08.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:54:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 18/18] stubs: move monitor_fdsets_cleanup with other fdset
 stubs
Date: Mon,  8 Apr 2024 17:53:30 +0200
Message-ID: <20240408155330.522792-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Even though monitor_get_fd() has to remain separate because it is mocked by
tests/unit/test-util-sockets, monitor_fdsets_cleanup() is logically part
of the stubs for monitor/fds.c, so move it there.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/fdset.c            | 6 ++++++
 stubs/monitor-internal.c | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/stubs/fdset.c b/stubs/fdset.c
index 56b3663d588..d7c39a28acb 100644
--- a/stubs/fdset.c
+++ b/stubs/fdset.c
@@ -1,5 +1,7 @@
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "monitor/monitor.h"
+#include "../monitor/monitor-internal.h"
 
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
 {
@@ -15,3 +17,7 @@ int64_t monitor_fdset_dup_fd_find(int dup_fd)
 void monitor_fdset_dup_fd_remove(int dupfd)
 {
 }
+
+void monitor_fdsets_cleanup(void)
+{
+}
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 20786ac4ffb..4fece49d531 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
-#include "../monitor/monitor-internal.h"
 
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
@@ -12,7 +11,3 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
 }
-
-void monitor_fdsets_cleanup(void)
-{
-}
-- 
2.44.0


