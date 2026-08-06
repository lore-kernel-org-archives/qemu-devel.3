Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7657FC5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4gx-0004sZ-Fz; Thu, 06 Aug 2026 16:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gV-0004Pj-0p
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gQ-00053g-Vn
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:21 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso38614645ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048037; x=1786652837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TE6CIxrgczOwgOd5q0qHaw4i0YRa6nQhecXzWOxzpJY=;
 b=rslwLphEuDIJIJXtU30FxswDDqb3TswsXm4AMOmJhGvAnXAPP09r9sf2/+0W3Up98b
 xqRg28MiqtioT/bqGFJxPC5AMm4hkm8lHr05x2r+Cf7FOlQ1EtCx+edKjySFlMfEFn9T
 6sY2MwfubYicPQR0vvpZwIhdrHJ3bzjidHLqjNM/MLBJU+H++zZwlapzMVWkMoyb/zAE
 NUJmuVtILmzjLZ2bb88uKYiudQtnigB9MRJkj8ydZ5FxeDrrOvqiZklBlRoiYzGjDxT8
 lZiNWT5/FaaOy1IwRJgpMYSpWA2l+iJBCzgLEKXv7fMCpGdikP+Z5EMwrSNaqvSq763o
 BH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048037; x=1786652837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TE6CIxrgczOwgOd5q0qHaw4i0YRa6nQhecXzWOxzpJY=;
 b=N4MIIDYlV9cKAJzxRHLBnX/zOvblTIOCA4GDtgq+X5L95e1BSEyFFdN3C3wDxE+Tu4
 NDfbFFnfg7q935eqUIvtT8TNrvhIzuvZPO5twjxzk7JNIsHIbRLaw9fN5bjeGP3BhTHe
 tEkwoSex600kZ52p6+n6IMPFieJPojozDrq55tcIXtdpj5IVI++nqtrU6uke3yRB1+qT
 ntOwBpgpg8npdSvhri03xJyev2csgTJ0ju8PD+p+rgNQdPzQXzyZqd11AHtgaW/l/Egk
 Qg8/6Jf9eLWUYqm5aMRAsLkMgGmckG+tRTDtteHZfwI1b6gNpbR1CdnHWK2ju8VtZ7vo
 2h+Q==
X-Gm-Message-State: AOJu0YzkmesBbe0314QJJ/6s/tFsAoqfiAdGb2nu804VTr2KJKEXwQoo
 4bZ2k0vjATiClVNIn+LhvHiLYzvLlFzu9L2hCvYCjdPZ+7zZoOgkCVRj6NT9OR2y7dXZhndJ
X-Gm-Gg: AR+sD13hA77n1ERD8WhqjA3FgXGjQ9Zz/7anbeXUo3Yd3r9f69pLL7Z5DkYRM4MEOE6
 qohTJNam1PIgfGmaKMbJw1NLIoAor60Ow2Y/dHImd1aOn7JatxuYKUr/JUHfRK2IOWzhz3TcWTI
 ZBJqfE+wrks/FkH66s5gjtn056UG5CcLNo/keRzZXsqfvk/oGUE5qewhA6g8QkfraExjsLGtan3
 eiEkT7M5wkDrW/k4lUE5Cs+NLz+HK20pNe3mvrh2a83hvPijiZEOnGteD/ngH0oeh6EiodV6iWB
 aR8uOoKONnnvDsY9kIGA3pR3OKqG5oFpTq9dzMTRdsQ6ovAf6V/aZNLQRGGhcZp2lGdEWnudQ/p
 tLzifp9nalKm77e/Ia3DJX7SjZv+HXiNzEBlcCKTJIWIohKsns9WsMn2zBUsLE23t/e4uv3LWKR
 iIcwlhOZaEIGOHTIHPhAB2p/Mc0gamDJdZ8zkcUJYA5rEjEP54QlH2n00sGCq8GCjU6YeKx3bVB
 g7tGawm54UHIvGax7aDP3pYx18=
X-Received: by 2002:a17:903:ac4:b0:2cf:a1c0:d4ca with SMTP id
 d9443c01a7336-2d0ca961ad6mr227793105ad.22.1786048037501; 
 Thu, 06 Aug 2026 13:27:17 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:27:16 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 14/15] iothread: remove legacy iothread_get_aio_context()
Date: Fri,  7 Aug 2026 04:25:23 +0800
Message-ID: <20260806202531.243806-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

All production callers have migrated to either the holder-tracking
iothread_ref_and_get_aio_context() API or the explicitly unsafe legacy
accessor. Remove the now-unused ambiguous getter.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h | 1 -
 iothread.c                | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index cf1b6e0cdc..2e28fd3ad0 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -66,7 +66,6 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-AioContext *iothread_get_aio_context(IOThread *iothread);
 
 /*
  * Return @iothread's AioContext without registering a holder or taking a
diff --git a/iothread.c b/iothread.c
index 43f42c65c8..06c5926b6e 100644
--- a/iothread.c
+++ b/iothread.c
@@ -422,11 +422,6 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
-{
-    return iothread->ctx;
-}
-
 AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
                                              const IOThreadHolder *holder)
 {
-- 
2.53.0


