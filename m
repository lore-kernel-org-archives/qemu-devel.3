Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADF8F4BB8C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 21:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuzsN-0002sf-AD; Tue, 24 Feb 2026 16:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vuxeQ-00073u-Td
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:00:54 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vuxeP-0003KF-HU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:00:54 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-506bad34f51so50314561cf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771959652; x=1772564452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHVwHrUI/Y9B2elM5BR9o0qWvDqrPxdtG8wtGZdfRks=;
 b=L3GcAmfzrLHsrzCztDmnmiAc6dbIk/ev69lpK2V8F1LsOEjCSKKhMs/swM5vT0wyqw
 ZqwYBKEbqmovvvBEVJaNdHbErkEMHhw6ZLHiekzqTQ9UarWT23ojxPV7gMmmSgI2OIA/
 PhRi/tzBP9wztMTlHLpcBfnF+KfAYn48tQjuZPL7X64MVhzHMlYYLJtXjFbpmxNP1TH/
 HCxbCi0Imj6jY3AuBtiFSFc1AGfG+mDGKthyI4LTHPJLhHDpGSv8oPQaeJXDvR5WsKFO
 QB7UuYrzNQzql84RiDS3iA9JTfj3tTv/Nswwx+0UsY7dKl45WV/UhvUyN6za4FQbj0NP
 H+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771959652; x=1772564452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zHVwHrUI/Y9B2elM5BR9o0qWvDqrPxdtG8wtGZdfRks=;
 b=meweH+9Di6W5/bH0qAhcRFWB58WJNiTpNvcbUEDdkFhqY5WIjfgQzgDuLpCfFAM5xN
 bs3LYMe67ewxPH0vjTiQ9X/VThUp5DVsl1dB+XjAWCMvqejfvBongb6sww4IdN6TGQdJ
 cbpTsrMtiPyjn3VQ7k2n20PyJAAotFyPN5C9fFVGQhKZidxlronXYANsFSD8rJL0ZDZ6
 2M1aS2Ite8HfWoJoTpBSK6jFzNNEzyKYGQkI1JmpPthXy1uXCoCXPA9X91KQdUZOXgzC
 BLnW82TfQ2PA9xTN24jdsy13inDdEQDWcrCsjPgg+tbvbmX8Hxy43kK8m+3Ka4Pd/bTs
 zfRw==
X-Gm-Message-State: AOJu0YwGcV2PhquziSm0KnuPjKsmJE0rqNrHfqqNTbGcdSHuhE4FiJGF
 Z8cqY/s8Y3gcuBTsFEglXK6Rz7SEL4bWjExi4lmw8nY2X8YMV24QvRED6oQYAQ==
X-Gm-Gg: AZuq6aLb44Zvt9LdN3OmvOa9fzyk8gIQFhVBsF3Jb5eNyFF1kTbl3rRrqog7vpyZRsk
 p9FkrUaRINfvqnVstp90qZKS7UGLUe6DrwUUbloJUX7TiruhYoiTg3xaEDe9kLEwiOu6qYvHCKZ
 aaxo2OdB8SpNphaq6ebU2l997O4hrKqOvZpApZYljnUGLkBDrJW1XA4bb7cicdr+IyPKpdLZLa/
 O1/ogZIPUwnM9BSIb4wT/STVQ0YDEcrrFThkQlAOMXhfrdVAbD+OQTBS1B34wpb79FBCFSb9UMa
 DWQSXPihsWiKMjJg7Kfy4WjNunJG36TOjdKixDLshLoNMHFzZENIAE4tFtVp2Mfg7qjs/kL4u8U
 BN8bSUe6M8RsSBKNCDhxzWh4aJR6bhEK6wr1I8SmNOr4xLQlkRgiJeHNwLN6hFW/g6I/sGIEqCf
 iw4/XbpZMt0b2I66niRyUvEzBX54nWBZ1BCsUcieWOZaUK/SQzWCmcE8abHMa3PQ==
X-Received: by 2002:a05:622a:48:b0:4ee:2459:3d6c with SMTP id
 d75a77b69052e-5070bcb29e2mr169570411cf.58.1771959651727; 
 Tue, 24 Feb 2026 11:00:51 -0800 (PST)
Received: from localhost.localdomain ([207.98.184.46])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5070d3a2dc8sm102616291cf.0.2026.02.24.11.00.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 11:00:50 -0800 (PST)
From: David Hamilton <dahamilt0@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hamilton <dahamilt0@gmail.com>
Subject: [PATCH 2/2] hw/misc/ivshmem-pci: Check error after setup_interrupt()
 in process_msg_connect()
Date: Tue, 24 Feb 2026 14:00:04 -0500
Message-ID: <20260224190004.84187-3-dahamilt0@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260224190004.84187-1-dahamilt0@gmail.com>
References: <20260224190004.84187-1-dahamilt0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=dahamilt0@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:23:21 -0500
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

setup_interrupt() can fail and report via errp, but
process_msg_connect() was ignoring the error and continuing
to ivshmem_add_eventfd(). Add ERRP_GUARD() and check *errp
to avoid operating on a vector whose interrupt setup failed.

Resolves the TODO comment at the call site.

Signed-off-by: David Hamilton <dahamilt0@gmail.com>
---
 hw/misc/ivshmem-pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 45b0e20363..85614feca0 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -528,6 +528,7 @@ static void process_msg_disconnect(IVShmemState *s, uint16_t posn,
 static void process_msg_connect(IVShmemState *s, uint16_t posn, int fd,
                                 Error **errp)
 {
+    ERRP_GUARD();
     Peer *peer = &s->peers[posn];
     int vector;
 
@@ -554,7 +555,9 @@ static void process_msg_connect(IVShmemState *s, uint16_t posn, int fd,
 
     if (posn == s->vm_id) {
         setup_interrupt(s, vector, errp);
-        /* TODO do we need to handle the error? */
+        if (*errp) {
+            return;
+        }
     }
 
     if (ivshmem_has_feature(s, IVSHMEM_IOEVENTFD)) {
-- 
2.50.1 (Apple Git-155)


