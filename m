Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BE8CF07DF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 09:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sypT4-00019H-Hz; Thu, 10 Oct 2024 05:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sypT3-000198-Ht
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:28:21 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sypT1-0003vb-1i
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:28:21 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c924667851so814888a12.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 02:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728552497; x=1729157297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QaYY9X9pUCStJ66Iupj9x96nWBsnt7lR9iGUBryB4Dk=;
 b=PgUQ68IsnjaWae4xeiIm1Bvup0JLqKnz9ztxU1an0gsbZdRmKm9rRRI31WIUL9UNl7
 FEth5Z2MtDL/C9gl4eJ0jvertXDK6P3IGHeeRYP8P8x7O7f3YArSpFtlVqdQsz51w3M6
 zfEEcnrtpr+9foQLHijWSNYulGuOZc12nrihaV7L9yMLZQtiQcRmlJ85lvSGkRFoFgzn
 0sQeneatVqYB5V/211aZSfFNIYIBYQXx12ijrzQqs7nIB2+boyET4vOpUol0II+v97qx
 oBBdtwqJWLa2Mf+DANeORqoXrsut6DHF/vWt7mBwFc3cAIk9s7QwdZfPcm5IK+jfESbO
 K4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728552497; x=1729157297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QaYY9X9pUCStJ66Iupj9x96nWBsnt7lR9iGUBryB4Dk=;
 b=iOv51bbqwjkeF9FN0DXQuCLl9e/rtmLdUcZIOjUT6XtB9Z/k2VS4q1McDXX4Vu+YgE
 rjhpZn6EEWzoh0/PA+ZkmVfsW9i2g02YfPGn/pogvS8qeujzd+v/V1JeJx0my/nnGiIB
 9GDaGDYqlSOv904JKuu5eV0qjn6xhiza+9OEqNjpS+r7h5KE6l2XBtpD8t6vuT9yUb37
 H/yx+hIR6Ht6tYp+WbGpqGI80rPkqg5VYef8MtRMf6t1NIpFC4xq1D7SmQj4he4YFO71
 HMmgDHO8w/4gILUiEkXkm0j6HR6U4l9ni/FK5TpawVD5L9oYPpFrS0Tg9gSwQ07N42E7
 EzdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzMaSNrXyQiKvUd3NQQg+30WhVbFPchv3CVK+vLh73DKmOKUmjql3Udm3GAOzii6F0ebipHNdt1xJp@nongnu.org
X-Gm-Message-State: AOJu0YzATjIAQqzLi9e0VuJmy7JuI+tJ++4psOpSK501KGGYUacSTVGX
 /BbxAhXHrfaFHaE10nGfAVxeFyZDHyM7JlgePm4LdIOwMBEEykBqV8FY1A==
X-Google-Smtp-Source: AGHT+IG2jOKCngOz4u+2GABtvu0Ro+GRGFLB7fO0aJJv1V0/8b//4/AwJcuvRr9gCpAdULb0CCtWog==
X-Received: by 2002:a17:906:7309:b0:a99:4dc1:b931 with SMTP id
 a640c23a62f3a-a999e8f728cmr289576566b.64.1728552497043; 
 Thu, 10 Oct 2024 02:28:17 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80dc5easm62490866b.170.2024.10.10.02.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 02:28:16 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/1] chardev/char: fix qemu_chr_is_busy() check
Date: Thu, 10 Oct 2024 11:26:19 +0200
Message-Id: <20241010092619.323489-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

`mux_cnt` struct member never goes negative or decrements,
so mux chardev can be !busy only when there are no
frontends attached. This patch fixes the always-true
check.

Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")
Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index c0cc52824b48..f54dc3a86286 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
         MuxChardev *d = MUX_CHARDEV(s);
-        return d->mux_cnt >= 0;
+        return d->mux_cnt > 0;
     } else {
         return s->be != NULL;
     }
-- 
2.34.1


