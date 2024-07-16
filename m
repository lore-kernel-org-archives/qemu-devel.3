Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8835EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 07:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcbx-00067S-3o; Tue, 16 Jul 2024 03:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbw-00062V-13
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbu-0006Wr-Da
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fbcf71d543so34321555ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721114907; x=1721719707;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FapB0rloacMPTGYKVxlO1Chp+0XRuBvqN0yTXZ7di5c=;
 b=rH4BE8YjUe0ma7h4Xgj0UnHIJnt5imLwvsXFVE9cV7IxwYh6J5PG5gdk5o1khu6S28
 mps2f1V11gvXi0vHBzmPrErhR0TVXL0BlkU6su5OCzSKO9lGqUAP30N09PU3y+a9TFhL
 dZp14JLISABAWlnq8UNKPphComTULxK0+HYBGoOmS/bnLlgj++J+ihscoA3aGUoUHSkN
 lj+LVGQT7e+zaCEmfdFI4e5myaKwpDGEKeeCKvCiLN4GLVJbqM9p256iFTDatCFIEsrF
 nXEMbChOYY/MBf9fRqwaQQxRugNplnQPNhl7faRvRHqWvDWvRZajyG+lRtYd3XEWKG8b
 1m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114907; x=1721719707;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FapB0rloacMPTGYKVxlO1Chp+0XRuBvqN0yTXZ7di5c=;
 b=S4GIjj5fs6gaeTphuzpxpq+lavhS+WSnZXypuYaltuL9SWoc3LBr1s2aJZSHVhRIpT
 K0Bj1Ho26XTwwVTh8QoDKMrD9+nXHwmsBbCWj6ln+HDVz7LuuHrHRrl8H1E6RLAuVcK0
 kF/vbwv1vhz/l1Gwuui3lE4nUsgSGwCJP5zh3Y8d5SjoTt8hXUZnxGxeCUvpN7iFhuwX
 kYBoYtRYTQTp36Aaj/cAP26bEMgQCUPJJNhYqnkC3CHZo7Loj6KJJV959HqKC4/k75OC
 t4Iaf4yun2acm262ZpxhCdMplUk0GWmDK1zzT+g1DOpfMKiRhVPYt/3UUH2Lo3ag9CLK
 6beA==
X-Gm-Message-State: AOJu0Yxy4kYtp6wEv0IKdE6S4clZOhVvE9zAw0alVVS/0KetNrSNbtT+
 22AiBiR4HKqsWSoNRf2NU7ZPmrMgUOG3aDCNa6FjLUg1EW5EDuBYEC5vxslpSNjmTl8UuixNRGE
 F5LQ=
X-Google-Smtp-Source: AGHT+IHECRxub+S5to2Fkay3GrLCGjY1xN63+pAZ4NE97aXCQSdcnKtZBsjIuDCNTEzaYXri0TZtNA==
X-Received: by 2002:a17:902:d48a:b0:1f9:99d8:4aac with SMTP id
 d9443c01a7336-1fc3ca07194mr12196005ad.0.1721114906996; 
 Tue, 16 Jul 2024 00:28:26 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc43febsm51820995ad.234.2024.07.16.00.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 00:28:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 16:27:36 +0900
Subject: [PATCH v4 6/7] util: Remove qemu_get_local_state_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-run-v4-6-5f7a29631168@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
In-Reply-To: <20240716-run-v4-0-5f7a29631168@daynix.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

There are no users of the function anymore.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230921075425.16738-8-akihiko.odaki@daynix.com>
---
 include/qemu/osdep.h |  8 --------
 util/oslib-posix.c   |  6 ------
 util/oslib-win32.c   | 10 ----------
 3 files changed, 24 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index fe8609fc1375..189fdf4fb6f9 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -662,14 +662,6 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
 
 void qemu_set_cloexec(int fd);
 
-/* Return a dynamically allocated directory path that is appropriate for storing
- * local state.
- *
- * The caller is responsible for releasing the value returned with g_free()
- * after use.
- */
-char *qemu_get_local_state_dir(void);
-
 /**
  * qemu_get_runtime_dir:
  *
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 9599509a9aa7..60bbd9786b79 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -272,12 +272,6 @@ int qemu_socketpair(int domain, int type, int protocol, int sv[2])
     return ret;
 }
 
-char *
-qemu_get_local_state_dir(void)
-{
-    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR);
-}
-
 char *
 qemu_get_runtime_dir(void)
 {
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 8c5a02ee881d..504a75f548ab 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -229,16 +229,6 @@ int qemu_get_thread_id(void)
     return GetCurrentThreadId();
 }
 
-char *
-qemu_get_local_state_dir(void)
-{
-    const char * const *data_dirs = g_get_system_data_dirs();
-
-    g_assert(data_dirs && data_dirs[0]);
-
-    return g_strdup(data_dirs[0]);
-}
-
 char *
 qemu_get_runtime_dir(void)
 {

-- 
2.45.2


