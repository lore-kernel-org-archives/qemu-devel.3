Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D565C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7MC-0006fN-93; Wed, 31 Jul 2024 07:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7MA-0006dl-Rn
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7M9-0006pr-GF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVez8TyHo7hNenUkEAcWhE2tawtL+vOCnY0ZoqSQIew=;
 b=d6k+dRs44Yfz4ThblBHX604BeXMa4X6z8yuTuK4l1dFYGBS92sAlzxSn1D6yIZ1BF1TFFL
 yreNLkbo6TvCnRyhnTbj2RGZqPmWhGO4SQeo0nwFCXHTle4QGiBACU6OOktyocEMlwmmv0
 sgIm2rCrpibisPeBfhZS1o1uYUSbL1E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-p-ww0tNsMAyJTxLCtZZq1g-1; Wed, 31 Jul 2024 07:18:53 -0400
X-MC-Unique: p-ww0tNsMAyJTxLCtZZq1g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a2ceb035f9so1157871a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424732; x=1723029532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVez8TyHo7hNenUkEAcWhE2tawtL+vOCnY0ZoqSQIew=;
 b=HwG9HH/JJcDzC76SxeHNqIguO7C3OygGQYXBkUcHLP+WnNP2dhVlPVWeChS+uUlgO2
 ioqaHXRugfl/ZO5eKBuIkUxi7nJIYtimdBCE368vyIPmcuY1B50BaYnRu9FmTbC0H01i
 BmO6Zu98XEvhwRERGAAdzW+Jhh1OSu6wAS4oYOV+zI153Ni8AwiXv9N3BjfJz0Cjuquu
 fDh1SxhaUjhdNjP1f3x9WaflJreXOF2krwSKTX7NU9SNOGEeUFeIYdx7tX276MICyocu
 RXR5NKFQGYhXEws7ljU5lZLdBuk2QiamXqGseBJzVnsMEL5W+ZAEmnq0rwnG1o/fJGJv
 cHQQ==
X-Gm-Message-State: AOJu0YyLx7Pxjo47wEtxeRYTyRwOJIdrkpMzYyQmPQmx718mDmP5LJOK
 vn8J/4ZxxSGuk5Xw50jkqo9dI/uoPO2nRShdw9I4k1oI/LWkV0YXxi5E0HFPwO2iyK9kaqo0Jqc
 MUcV8HF7qavLuS2ISUj0e+YzkgQCINYXb/zJTev3apZVizY0+GfTEsXOqvhJwsXQ5Uk7eXdxSUn
 ZsteOJ8+fg0wEb+NKwqh2idlNsv8y1OO4zWhCR
X-Received: by 2002:a50:c08a:0:b0:59c:50c3:af65 with SMTP id
 4fb4d7f45d1cf-5b46ca289c3mr4398819a12.14.1722424732041; 
 Wed, 31 Jul 2024 04:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0/9R4hN4m/6w66/xqgyBcFI3rVGskcB8eVM72vvXb/NGiYh5ZQvZUY+xl7gLxdI/zlM7epA==
X-Received: by 2002:a50:c08a:0:b0:59c:50c3:af65 with SMTP id
 4fb4d7f45d1cf-5b46ca289c3mr4398182a12.14.1722424713579; 
 Wed, 31 Jul 2024 04:18:33 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b52ab8f09dsm1517584a12.26.2024.07.31.04.18.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] qemu-vmsr-helper: fix socket loop breakage
Date: Wed, 31 Jul 2024 13:18:05 +0200
Message-ID: <20240731111806.167225-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731111806.167225-1-pbonzini@redhat.com>
References: <20240731111806.167225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Between v5 and v6 of the series, the socket loop of qemu-vmsr-helper was changed to
allow sending multiple requests on the same socket.  Unfortunately, the condition
of the while loop is botched and the loop will never be entered.  Clean it up, and
also unify the handling of error reporting.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/i386/qemu-vmsr-helper.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index ebf562c3ff8..585eaf88b37 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -227,19 +227,17 @@ static void coroutine_fn vh_co_entry(void *opaque)
                                 &peer_pid,
                                 &local_err);
     if (r < 0) {
-        error_report_err(local_err);
         goto out;
     }
 
-    while (r < 0) {
+    for (;;) {
         /*
          * Read the requested MSR
          * Only RAPL MSR in rapl-msr-index.h is allowed
          */
-        r = qio_channel_read_all(QIO_CHANNEL(client->ioc),
-                                (char *) &request, sizeof(request), &local_err);
-        if (r < 0) {
-            error_report_err(local_err);
+        r = qio_channel_read_all_eof(QIO_CHANNEL(client->ioc),
+                                     (char *) &request, sizeof(request), &local_err);
+        if (r <= 0) {
             break;
         }
 
@@ -261,11 +259,15 @@ static void coroutine_fn vh_co_entry(void *opaque)
                                   sizeof(vmsr),
                                   &local_err);
         if (r < 0) {
-            error_report_err(local_err);
             break;
         }
     }
+
 out:
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
     object_unref(OBJECT(client->ioc));
     g_free(client);
 }
-- 
2.45.2


