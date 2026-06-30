Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB675C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weTi2-00056a-VM; Tue, 30 Jun 2026 04:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weThu-00055k-Kt
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weTht-0003RO-3I
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c9e8a1d256so19774405ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782807634; x=1783412434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPjsToBeS5cS1bHYcqZKAm2lG/5VriJ9o57EzBTqELg=;
 b=Z0fD/tNySGnt8TnNU7/OZCKdCKtDeXzabC5W+wiJ3OJJYvZwHxVOsGUuykxf/PL70R
 Mrj4C08yYDAysjl7O6UbUeL03O/zbLClwCDabGEBoP97ps2F/0NlK6drbIKj+P8KkX+t
 tatjJNxmu6NaauHYvBPQBbH3a6x0S3mJWfDNdgqJT0wYBDf0CMGzN0MTgMJot9srzECH
 IPQ5X0FbKQBzS1+5bPV7CcSlA+d+/w2Gp1/VteXV8i90QBUjcoeivcEr7Kl/APMANho8
 VifYq2PwR7vHRTxfUqtEvVjtRx3JhhEAuPynaKbRC8MzkKk7WjO+WDk/IaCPghvpIJiT
 5EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807634; x=1783412434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VPjsToBeS5cS1bHYcqZKAm2lG/5VriJ9o57EzBTqELg=;
 b=iS9pc8PsbjeaXt5rdDLyv1ccI7YPTkJ7gnMG4cPQ8+Zaw0oewf03Y7UvCuKC47NA55
 AheEK2ytpt8mbSvvT25BKCG4GPsKW3jlJ7fiqLV/bkdsjC7pyT7oWJVCKJAoekWFYS3u
 rUuEwjzi4XACpkMu/ISg9T8uWSuZmRkC+sRAStfElFTQHC1b/kd09r+/LC5eNg+0ghfW
 lT14zQyKV18WDxSjZt6d/3wAKWtkiYN+R/fcTet8Tp2vX6Jhc7Hq0z/EcQs5c+ypnVU5
 CzYiiDkzEstk5a1BnIVmvBkXIVi2t9k9lq4HhSJ/ATeyCYYj0NbcciwMAYmW8+tn4w7c
 hosg==
X-Gm-Message-State: AOJu0YwfRnfsoDFyLKOmoUEOuHfnEsmyDdjefS3HTJKMiMMs/ehMo1yu
 P46ncE5YM4Y1Z7l9bAffWLaGRoVMpuR/+qnKWdOkz/AKZXqlqPm8xsoDf+FZoEnG
X-Gm-Gg: AfdE7clFBsLUH4iiuDQKFya6vChrTSmHeF+Db/UDEW9WmN6pLQZUuSSZ8aHeISTd7DQ
 ee8c6+Lm6T3pBrHYGb1N6Tvp5gn62fhYAS5HzUIedv71/epeF68OP2sF/i2lBisieV6byIe1OTL
 Y1bsrKym1mNIxRB1Y4tzCtEavf6L8guJ3KwJ/t5iaoxHZEhvgFnviYGR5+rHMlk5dI32BmRCGXo
 VueMHmGQpNGX1nd2HrFYwHhPvlGFZARTZxv68XKYwWul0undZu6DcvCQusHsPPc9GIXINGtrz52
 fu0+cjh8UhMhBqoGc8FUVBrhtsV+LT4gAL5mMY4RWKIj2KPecU/zAqlFCy8Co2bJeim6sJjRC3k
 aFrjeAu6EzX4c+9PhaC/e+AAXstGFvd/yJnVV/+OqS+p+UHLSs9p0ONyCU91pKiioqUCc1bh/Lm
 E0pJdWC/WBrfgnnIDkayDYefOyIHyVMJ1U1mM75yU97D8=
X-Received: by 2002:a17:902:e747:b0:2c1:98b7:ecf3 with SMTP id
 d9443c01a7336-2ca2e71be03mr20866555ad.23.1782807634020; 
 Tue, 30 Jun 2026 01:20:34 -0700 (PDT)
Received: from setun ([2401:4900:a344:dc6e:573c:3e9:c03e:731a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca4f2a71dbsm1284615ad.50.2026.06.30.01.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:20:33 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH v2 4/7] migration: Make qemu_get_buffer_at() thread-safe
Date: Tue, 30 Jun 2026 13:49:37 +0530
Message-ID: <20260630081940.611092-5-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630081940.611092-1-aadeshveer07@gmail.com>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Remove the internal QEMUFile error state modification from
qemu_get_buffer_at(). This function is called by two functions, both of
which already check for unexpected return values and handle their own
error reporting.

Removing this shared state modification makes qemu_get_buffer_at()
strictly thread-safe for concurrent disk reads, serving as a
preparatory change for the upcoming fast snapshot load feature.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/qemu-file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index d5a48115bd..c73f8178d7 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -553,14 +553,11 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
 size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
                           off_t pos)
 {
-    Error *err = NULL;
-
     if (f->last_error) {
         return 0;
     }
 
-    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, &err) < 0) {
-        qemu_file_set_error_obj(f, -EIO, err);
+    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, NULL) < 0) {
         return 0;
     }
 
-- 
2.54.0


