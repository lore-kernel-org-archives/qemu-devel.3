Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5365FD262B7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 06:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viRuG-0000LF-DN; Wed, 21 Jan 2026 01:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1viRuE-0000Ey-7V
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 01:41:30 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1viRuC-00012N-Pc
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 01:41:29 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so1830946b3a.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 22:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768977687; x=1769582487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+a3OwfwQBO2otyKeHBN1LrQH4TMfKPwgsXvF1+xAS4A=;
 b=cp367XDW1QZOQbdUWNyO8sRs9Ogsqk792eT4nN6Y1wzEnLBpYFc10GFQrg5nLp4iyy
 AvhNB3lvK8PXBfjKq25bmDIxjA9dg8huNAke1TNUhpkpnE/rqrc2TLCPQzR3S+bx1Kie
 ijF8TQSk++fqHQ4QZbC7JXDzpVMMENsb2nPV3p/nedFJ0PuqRJyW5aeJWVvqqu0JWy1h
 YHZb2Pf0ihdT+kMqPOL1xCh8hePU7w9wLJcJPw1bLS8UMWhUdYVE5zyvYFVsusMudFx9
 NWuyZ+krpSEVTzXHa5czuOy4TzR/DlwH3068+Fk0GZKKDVKcLrAeo3bhGXzN5j/CEcGp
 +94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977687; x=1769582487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+a3OwfwQBO2otyKeHBN1LrQH4TMfKPwgsXvF1+xAS4A=;
 b=OukxnAXOEhVjPwELu8BzSPjUKK+dn883Lu+vvcVtHCl2vIZ/gmuBCaZjhYjNoM6aw4
 dUheToMPLJJViZFOnfggXGz7oNUJ/DUMoE5U6iqu+KRmf6mkLU8GdrY8UIQTAYgL+x/l
 EAANbx9giSnpfHrxG/IXFJicLq/p+uF4vwKaSmkM/EHoI+72KdSxz9M7EnqPWjUJoXAf
 ubR2lQZpvX1pDN+vbPijdLf8Ci0F4/E4rDVN40lbylMuH7ppFCMXOj156wVj4X0e0DPf
 Ca/Qc+Epi7YnY392c3FkIYzQ8iH/HtSfE6kCjuOMe7RDZwJA204Y5BQdp5VgPDCVEf3u
 eP1Q==
X-Gm-Message-State: AOJu0Yzq9QUrbYZ219oUjtc0tsItB7WgBN66RTYmT6J9yqiwwsKoc6tZ
 W2BEWAqaMfohtz8xiQhILUqn+ImCpoezao9FSxoZU0QwLLg4PW2h3oOc1pGPh2ss
X-Gm-Gg: AZuq6aKIiyoRiAvTPmEiDfHFpCRHLboeWK2/3V/A5UwCsLXC6tOXcdP6wIeGeTcLWIP
 1SuUvLF1xZOYOFDPr9BiZb2yj8DafrJ8JiYZIoK8y7XsAFCyUJT4AN6ExkZfd/84u2GGDNujQJ1
 6i1+vFFnnDpOcHv3T++cqYW7cftr01k2jizEkJWKcdx5pTZzbvaOpG72/k15xfksbB7oH3a7XFX
 L883rGY1CE/FkY1Bcsq2s/zzrifNFF/0DjpRNhszFof1bj61iKHhOcbbrWM8UCVDerdl53VewSh
 eOAQJ5+mwdNuClvR6atvPlIwj0hJIwuUXldzMEybJX/ZbRPZdxf3ojHhdZJTIO4j13/klUB74PB
 xcqPrwUwSPa4px90NtOUfbAiAvdYXQ9Sqwb8muvDro5oLjY+IKOoP6RXd/D1wfmHMp0pzxZsZff
 +3HcVqGPB0XnJaBpQ=
X-Received: by 2002:a05:6a00:1142:b0:7ff:ecbb:1c28 with SMTP id
 d2e1a72fcca58-81fe87e43c7mr4096080b3a.16.1768977686977; 
 Tue, 20 Jan 2026 22:41:26 -0800 (PST)
Received: from localhost.localdomain ([180.87.170.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b3165sm13876714b3a.60.2026.01.20.22.41.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 22:41:26 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V2 2/4] iothread: Introduce a new flag to show iothreads
 attached status
Date: Wed, 21 Jan 2026 14:41:08 +0800
Message-ID: <20260121064110.28760-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260121064110.28760-1-zhangckid@gmail.com>
References: <20260121064110.28760-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x435.google.com
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

QEMU Need a flag to show current iothread attached status
when hotplug multi iothreads. For example virtio-blk.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h | 1 +
 iothread.c                | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index e26d13c6c7..3d00474523 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -32,6 +32,7 @@ struct IOThread {
     QemuSemaphore init_done_sem; /* is thread init done? */
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
+    bool attached;              /* Whether or not attached to device */
     int thread_id;
 
     /* AioContext poll parameters */
diff --git a/iothread.c b/iothread.c
index caf68e0764..38e38fb44d 100644
--- a/iothread.c
+++ b/iothread.c
@@ -94,6 +94,7 @@ void iothread_stop(IOThread *iothread)
         return;
     }
     iothread->stopping = true;
+    iothread->attached = false;
     aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
     qemu_thread_join(&iothread->thread);
 }
@@ -199,6 +200,9 @@ static void iothread_init(EventLoopBase *base, Error **errp)
      */
     iothread_init_gcontext(iothread, thread_name);
 
+    /* Clear iothread attached flag for init gcontext */
+    iothread->attached = false;
+
     iothread_set_aio_context_params(base, &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
@@ -336,6 +340,7 @@ char *iothread_get_id(IOThread *iothread)
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
 {
+    iothread->attached = true;
     return iothread->ctx;
 }
 
-- 
2.49.0


