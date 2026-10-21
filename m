Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD46A606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VV5cTj0I;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iU3Qywpp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRdJ-0008A2-4x; Wed, 21 Oct 2026 04:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xJRdG-00088m-Uh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xJRdE-0008K3-W9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792571106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uZUZl8DdF/8KZZmJur0SaWLyu56jXGYuJwm0X8FaoCs=;
 b=VV5cTj0IfmqW2LTHkkguQI7N1OOXgCaJD3eWOuGnJoUcEIjD5Gj1zLaJQQFrqRlppygAQe
 MKSwbzy8dpBy7qM19YVymslqROij9YAEYlZ05AWhY4Gx47i6G7q2adE+EWty2Uk4gR6lo5
 8ImCuryGWmG0W/7fu8E/WaN68W/hdcA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-woLv-cpsNiC0KY8ytQuE3g-1; Wed, 21 Oct 2026 04:25:04 -0400
X-MC-Unique: woLv-cpsNiC0KY8ytQuE3g-1
X-Mimecast-MFC-AGG-ID: woLv-cpsNiC0KY8ytQuE3g_1792571103
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1fa972b4fso2479705e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792571103; x=1793175903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uZUZl8DdF/8KZZmJur0SaWLyu56jXGYuJwm0X8FaoCs=;
 b=iU3QywppBWhEYXQMR+6iMJU8ZOzgflZcJrQ/jzB5zGR1FdqSSi8fCsz352x0qbgsTV
 m2Br7fRlBuSju0G2IiqGTmNIcEWGtjp496wNFm/MlyCH7wUMj6nkSoUBclpohi2zQYg7
 xMsF6ecQrpNsWmNQG0mieO03+briI2IQCM5Ox6NvVpWVvgeK5HIy+bkafs37nYoGqICz
 plJu04Egbk5pkuQt++N5AATFwGZHkf3PDxPFWF5cQ+ZDjB01k8LRMRl76sBLrYBz3bjg
 CFGjANYFVG7Y39JefD+e8X37FVYq04j9SrQ6w1Zu/Nn4gqDU88HTqFPM1I21ctiTxyHr
 pENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792571103; x=1793175903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uZUZl8DdF/8KZZmJur0SaWLyu56jXGYuJwm0X8FaoCs=;
 b=sF7uRTt762P2uGtarhXOjvy9iroBrFAtTcNWfmihDXIRZ/qdYaCqQALpB0AC2QQuhD
 h9JXCyEaadRYviAK0hziId+LTH9P7TcRJGz5FsiqxFdPEkY+UmM3LeB6nX/6W+MxSWTW
 Auuebi1jE1KoYfIgMmBs9fN0wX+DuaLKrvqYZ0NqvBkWO2rBozS8I7aOsmXyQ5UmnGpo
 kUIrUfhdsj//1+G5Gj9A+Xz+NXzC/RGqNElEUoLgFYUx1Twt/SS2wnTKr9e3fWSezJuh
 FzhBRujAH5u63buM6/BP5xELNw31xkTj0NAt1jB5KtGdV9Ed7voJReHgdSfWAowWeun6
 3m/w==
X-Gm-Message-State: AFq9FYIj5+O4eQ/CHXLInQizVXGXyp9MPG7cgtCsZ2W8fV9AZilNjRmw
 u05TLCP31ogZszhwUGziBBByUErnD59mOBgjexLSPQI/ipJNT7+Qba1Txa3sGEPdvnWZoGAmzxn
 pKMKlpxcoDhocLSn4uLlZf9LzLQrsJSenSTnjZ4fSAbjFzNrlLwN5AqHxScr4Yar/rUrKXRb+M5
 XZjwSLq7igUtSDM4G9EztyVwgJ91s169WTk5cJPsSf
X-Gm-Gg: AYBFou0W0Gq1/uhZED2UKQDxUNkOmI0iC94wrrbAV8Ph39iKp3awxfTgE5/KeckCSP9
 E7kfYddSk+xGg7Wu44+K3KwvlHqkdHRBzVpQdlHmnCEbnUsx5nYpmN6TTvPYuWFrZRHyoMr91gl
 bmrIqXXqjkDa68KAOlL/FVOR9MlP8YL9B50aPJGv5PZw2MGRWKdJgV+0sTMxZ7jY4Ntwqk0MND9
 zF+hBR1ivBfuTklktZO2ENG3/gs0SLHIeg1TuMVpPe6orxbjvtqv5tSjJTm4LoixFaK0mJPjCSc
 nVEnuziyL77CwvE6mZTXccUBWO+0/bDZ9jZ5TmtFeD5y3QypwB7DxxBYUOaZncSoNw==
X-Received: by 2002:a05:600d:82c1:b0:49f:ff73:9971 with SMTP id
 5b1f17b1804b1-4a1fdd393c4mr27013905e9.18.1792571103389; 
 Wed, 21 Oct 2026 01:25:03 -0700 (PDT)
X-Received: by 2002:a05:600d:82c1:b0:49f:ff73:9971 with SMTP id
 5b1f17b1804b1-4a1fdd393c4mr27013405e9.18.1792571102775; 
 Wed, 21 Oct 2026 01:25:02 -0700 (PDT)
Received: from stex1 ([80.116.165.64]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd25edasm34144445e9.3.2026.10.21.01.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 01:25:01 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] backends/igvm: fix parameter area entries leak
Date: Wed, 21 Oct 2026 10:24:59 +0200
Message-ID: <20261021082459.72038-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefano Garzarella <sgarzare@redhat.com>

qigvm_directive_parameter_area() allocates a QIgvmParameterData entry
for each parameter area, allocates the data buffer, and queues it in
the list.

At the end of qigvm_process_file() we iterate the list to only free
the data buffer of each entry, but never the entry itself, so all of
them are leaked.

Let's also free the entry itself and remove it from the list. We could
avoid the removal since the list lives on the stack, but it's better to
leave the list consistent.

Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/igvm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 58f3097e85..605a3f3a36 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -1044,7 +1044,7 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
                        bool onlyVpContext, Error **errp)
 {
     int32_t header_count;
-    QIgvmParameterData *parameter;
+    QIgvmParameterData *parameter, *tmp;
     int retval = -1;
     QIgvm ctx;
 
@@ -1142,10 +1142,11 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
     }
 
 cleanup_parameters:
-    QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
+    QTAILQ_FOREACH_SAFE(parameter, &ctx.parameter_data, next, tmp)
     {
+        QTAILQ_REMOVE(&ctx.parameter_data, parameter, next);
         g_free(parameter->data);
-        parameter->data = NULL;
+        g_free(parameter);
     }
     g_free(ctx.id_block);
     g_free(ctx.id_auth);
-- 
2.56.0


