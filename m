Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281A4CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 19:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL4N2-0007P1-CJ; Thu, 07 May 2026 15:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wL4N0-0007O2-Df
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:26:50 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wL4My-0001CG-1a
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:26:50 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso986034fac.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778182006; x=1778786806;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wootNPoK+NYg6wggwgIPazhoDF9fQkDS4IXYC9i/yLM=;
 b=n105PIBgXnF3NcY5KzsEkjRnNCeB8ittxhnR9v8AS8iz4dcclHSWjoEdB9h+8gzsf7
 1cZ3yM4dB7IkbLkP96xJOVUFeAGfZJeBQSPRBAMZw1ohdVGwgcmQnafaawKnpWUc7YTF
 LOsEt53hSXOznLBYhqZWa/0JkGWxsWhch4NorKc2X3JRXsTkUS7i2NyRRZW/g3tcStSo
 nUtR2LdvCoJGhGO177aF8s+h984/0kMc/ORhAJzH/tVWkDH3/sBEhtCIDh41xxXx3kUu
 wDjJEv3uwLzxX0htylMi4bpvBrGYFTX6VeoI/MlV252O/MgjM8FMiI1gCDiyOQ/RB4jk
 P+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778182006; x=1778786806;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wootNPoK+NYg6wggwgIPazhoDF9fQkDS4IXYC9i/yLM=;
 b=nLEevWTttOTY3wzC5cBhirkzRRbXICEPzblL9NXds/V+2QaUVsM9cohqAUMGiygKgJ
 e80XxFAVcsV0yE92xE3vzCpgJIm+OV415kR3A/nnMJ+aRTqkFJydc+AB8pmdk84G6Eyk
 9VYKROQcueQoF7FxA+kuj+4Z5b/0I1kfEyer8KbNehrRfdA/eyrmLlCQdGGjtLhSq0fx
 xwtEpyptH92SfWaWRbZ1nJHZNqHqvII372JTaiitZcL6P0M9TnRk1gpYrQfUeOO3f0yZ
 uS/qOEUKxYEiuuJNLlvBCxwr4GSDL+J5YKJ2GRvF78V3ScS1tIgRNZdVTpAfhmmyg4g1
 4x+A==
X-Gm-Message-State: AOJu0YxEqcYG5eoImtGTjfdyVonBNcL5jFOa4vFTPgh5DX5oDeOKiZQT
 hSiIso07rJWdCGeId2GdpjcxoBHsdIsboEF9/z6KEQX+l6d3XGetA8jYE2zweqTmdu3i6KK/gDK
 O+r4kAo0=
X-Gm-Gg: AeBDietJ0DuJA2U7wMehve+bAmv8n3lr7M7nZT4SLDzkdSdoh7yVwK1v10oS+ls6ayh
 SAEZSRCTb+zidhXxu914XYZ3xMcRiJBcD4qUMQpNlMG6fpzQw7Ly3GWP5o/PzIn+dC9pv8TiTSr
 GL/lonvw66iEEbIA0+FLMudusGAYsaeyU/nWm4stnxtVLbocQmwb7jDyzokz9qN/WPaQX85TayL
 Iiwv8zV84MZxmtlPW1f8Cmk8V8R/xCjPFRMc7/h6QBxRQVWdmdsGpH+vU2HmVz9UsgFTAdYMylZ
 fIk5rM19yOTdWRSJ9dnAzfQHcP3FKlEMx/DAlmUhL+WQhZLKfn+N9brJqiZrq79GIUhxLW3mDjd
 2aSUJTIC3+Rs7MPAoQEk3GmCABOEKLMmUAchDyqQRgXk0uCcOaKeuspths70KgeL5uRhz4nvwXj
 ii/MICS85nMwhpplOIGOAK
X-Received: by 2002:a05:6870:272:b0:409:5560:72f8 with SMTP id
 586e51a60fabf-434f51cce99mr5629107fac.0.1778182005943; 
 Thu, 07 May 2026 12:26:45 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4354bc90c24sm446308fac.17.2026.05.07.12.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:26:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 07 May 2026 13:24:40 -0600
Subject: [PATCH v2] linux-user: Fix a memory leak when pthread_create fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-linux-user-bug-v2-1-26ec5da22f6c@bsdimp.com>
X-B4-Tracking: v=1; b=H4sIAPfm/GkC/3WMyw6CMBAAf4Xs2TV0pfg4+R+GA21X2EQoaS3BE
 P7dyt3jTDKzQuQgHOFWrBB4lih+zECHAmzfjh2juMxAJdWlLs/4kjEtmHKGJnVYt5orTZUjZyB
 HU+CnLPvw0WTuJb59+Oz/Wf3s39WsUCHpy0nx1VgivpvoZJiO1g/QbNv2BV6oZ9etAAAA
X-Change-ID: 20260507-linux-user-bug-6a5e4524d2db
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=tANhKr2olwZwmSR4R8PK5bVZuIBZQwqBpBO6v4uc9YE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp/OcA1IvW3MofG6YoqUAWezgEM1CGKLXyhDiUN
 TJnNlpF6O+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafznAAAKCRBsHNEofbAR
 AEmLEADIfO1M7YXdlkH5pNLG9rH/6mcvRUlmPBtTLE0RtXO+RKVrqYzKhftMdv3fJpRsLja//9J
 MbHz6krc9ecnVCpHzMLICk5SuQtXd0lqclTHsxfCNYgDmq6SUbAhRi/J5l1sO4pCQ/0CFLwxVFZ
 2Ww1iTVsYX1c8+9K3PVElu0dPje2m29vKaH5vLAqeGreTNyeNtgH1HCCFdBBwRLpJpoBga5Bw3f
 P6MV4oBotbxW05++yRyJrkqiWwJcRC32EudegmDcO4NeIHgv0KeIJOztPcYGwYCg0SGZ6vvr0+Z
 qB/jIfoGMo5VILOUaJTNc6zUnRZnI2QrScrtmVf6OJq2BcvNJpT8USmKgqlpawGUXTZVls0OROD
 rbd4mHXpfFITmdi+Swj/RGS/uLAjrdQzn9BlJHvMC34uq76UZnZGXtqG6OLBM5evAaWWiDwzTdB
 Zljrff1MOGtVNRDKm+iNqzRQgUj0KnoCmZb59j+kjem7/TXK248dDZlKp/QbI05kPeBL5FlgGUD
 FAa4ihE17pka9bunHCjHTJG/pbUB6oEpQnlp9RINYGpZAe+kMw6q+8I8VrYDXJttyMggDCxbbur
 +tFRmtIiwTUAO39ONX7ah4+mQVM0isZi3gC1SzusqlHoMuat0B+GQgBwgmA+Txd9v7X7XaU+B5M
 2m4FyNs2/4wLukQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2b.google.com
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

Fix one of the TODO items when creating a new thread: release the copied
cpu and free the task state.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Free the new task state and drop references to copied cpu structure when
pthread_create failes.
---
Changes in v2:
- Add ifdef for aarch64 so we don't leak stacks
- set errno = ret to fix error propagation.
- Link to v1: https://lore.kernel.org/qemu-devel/20260507-linux-user-bug-v1-1-25831e9bc22e@bsdimp.com
---
 linux-user/syscall.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d3d9fffb54..c7357bf208 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7005,7 +7005,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
         ret = pthread_create(&info.thread, &attr, clone_func, &info);
-        /* TODO: Free new CPU state if thread creation failed.  */
 
         sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
         pthread_attr_destroy(&attr);
@@ -7014,7 +7013,16 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
             pthread_cond_wait(&info.cond, &info.mutex);
             ret = info.tid;
         } else {
+            errno = ret;
             ret = -1;
+            object_unparent(OBJECT(new_cpu));
+            object_unref(OBJECT(new_cpu));
+#ifdef TARGET_AARCH64
+            if (ts->gcs_base) {
+                target_munmap(ts->gcs_base, ts->gcs_size);
+            }
+#endif
+            g_free(ts);
         }
         pthread_mutex_unlock(&info.mutex);
         pthread_cond_destroy(&info.cond);

---
base-commit: ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1
change-id: 20260507-linux-user-bug-6a5e4524d2db

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


