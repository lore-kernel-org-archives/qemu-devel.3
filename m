Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE30DC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39Ng-0001s8-H4; Fri, 11 Apr 2025 04:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Ne-0001rP-LM
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Nd-0004i5-1S
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227c7e57da2so15885055ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358692; x=1744963492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWO2MpNR+Wq7+HXx3Lk8VZg+9OETBCuvoauKUfERGVY=;
 b=Ueh10OKSG5Zp4i0EnaF8IRB1WffvIZNkzxZ2iVRd8YQ/JlRG27XP9OfNCdHKAEKyY7
 y21iVIRwo04vpLOGVDQXyS1FXHtW500Iayvc3wnkVv96sVd6QZRA9XyLq9N7yyGcPdom
 trXdrKSsyEWUi785ioy78a01pHc/efNwBIVEc6ZrXs//gidpYnPLtqoE/gPQDoUfmBOy
 P8HMpt6Vy1NV2AKVzg8CH0Yw9f+Q/28+9oGprfj4GZysY4k2Cc4jUCmK00PKuUXTRS1z
 VbL4O8igHd/bM2xTg8hIz9kMFA4yxrRaWaTsL2LKwk7CoLy0G//CUd+ky0f84pMWxsjt
 hFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358692; x=1744963492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWO2MpNR+Wq7+HXx3Lk8VZg+9OETBCuvoauKUfERGVY=;
 b=GOwiYM/Xz8KPgOzP+gYHaiJi5uFuNloAoi25XVjvfUjESaRweXsAF8v9guxJJhPskH
 Gs95uneVyih6T/3F3xiRMCPg157nWoLRITwXcDaV/JPQYJ3ZHuZ5EgYhG4TcqQaSnBHh
 hICD+oUyBmLWbllj09Agb79PVlh4Y4HsnVJ+2aK1sj+lCIIMSz4EoR+jkkO/A4i6nMi4
 +l+4TBSXxbjvt2PRLS9AQ+bh4ZH4SfNI75FgWyRgV8TXPRmeJsAJdJreH8uDhZreMRby
 hqLQC5FjltEPcIG+Wo5W6WdedL9IkQWVm1FjPpSyE9TyqGNKatFQ/RBh580dGPQUcogi
 87mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjtTHjSCgK4eOlEjC1ZTjEz3g4UN+Ff6kiHg+bRnprwR7cMUnmP8Wx4rmvPHcZmqQFCR0BdPsQCdLn@nongnu.org
X-Gm-Message-State: AOJu0YweGL17LIwTIqGqpEAmK8fTXHm/WlzgNkQKe6p+wY63t/Oy+KfD
 gTpeGGv8PabLmUaqQuhJuXklOoTdv0RXqIWgHR3Az4ufd1sG6utP
X-Gm-Gg: ASbGnct9Zi59VeYmUptn2bsyLZtAuCDTnZX/QJeS+0YWcPaOOP71DVWxmDdmAYSnef+
 jrOAa2AH41hyzyVwvYqImkaMOyZiJFb/jLxTQLDggnGK5Afj8HBKSEQp1zxXNWaR+m28cXxHqXQ
 u+Jma3JD6kk1rLHYjsd0gQ6xqCI3jFaNRYbo68xHh9CudCXrEDL5KhWIiXZxUtWfKXXuRjYLQqV
 Wxqj3Nw8H7LoTcxMqn45H0Lu9QDgc9QQV2tk1LaxmufjloCVFxbAO/1txoqkXdX/mDeJKQkD0Of
 ESW8XuXpwKXNzZJ5Qfzee/bjkk0X9blNAsbzeQCui4gt
X-Google-Smtp-Source: AGHT+IEWLLB5jaPOfmOZqay5OMus7igJMgH2AceMaH8QP15MjI+Ue7E/Orl7N7qOICElf4nTZYoULg==
X-Received: by 2002:a17:903:3c6d:b0:224:a74:28c2 with SMTP id
 d9443c01a7336-22bea4c3e94mr32558085ad.29.1744358691712; 
 Fri, 11 Apr 2025 01:04:51 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:04:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 05/10] usb/msd: Allow CBW packet size greater than 31
Date: Fri, 11 Apr 2025 18:04:26 +1000
Message-ID: <20250411080431.207579-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411080431.207579-1-npiggin@gmail.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

The CBW structure is 31 bytes, so CBW DATAOUT packets must be at least
31 bytes. QEMU enforces exactly 31 bytes, but this is inconsistent with
how it handles CSW packets (where it allows greater than or equal to 13
bytes) despite wording in the spec[*] being similar for both packet
types: "shall end as a short packet with exactly 31 bytes transferred".

  [*] USB MSD Bulk-Only Transport 1.0

For consistency, and on the principle of being tolerant in accepting
input, relax the CBW size check.

Alternatively, both checks could be tightened to exact. Or a message
could be printed warning of possible guest error if size is not exact,
but still accept the packets.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 6668114ea74..27093de5c84 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -400,7 +400,7 @@ static bool try_get_valid_cbw(USBPacket *p, struct usb_msd_cbw *cbw)
 {
     uint32_t sig;
 
-    if (p->iov.size != 31) {
+    if (p->iov.size < 31) {
         qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CBW size %zu\n",
                                        p->iov.size);
         return false;
-- 
2.47.1


