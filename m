Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1727AC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWJ0-0003CR-6n; Fri, 06 Jun 2025 08:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIx-00039N-AV
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIu-0005z2-Kn
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6T2UdLZ98T4mEFrrnkCvZZaWql+Pj2cZBNd8iq7JhE=;
 b=daA+JJy5XgclajL0xHN/Vpd4HjoeSEVKAimuiAI1F66lNR76kfnlgNU2DR3NTXrCtFF+Hs
 y1e1VShyH9uOBUehEyMNRH19V+3YcdtAlPesLG7/MBCkkfT+MGUSTRzEcatq/eCdTJOEuw
 LF0u/QX+1BDxVRuAerr0Frqn+jQliJw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-ZK5QGKgXOAGEeWXVamvdmg-1; Fri, 06 Jun 2025 08:36:09 -0400
X-MC-Unique: ZK5QGKgXOAGEeWXVamvdmg-1
X-Mimecast-MFC-AGG-ID: ZK5QGKgXOAGEeWXVamvdmg_1749213368
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d6768d4dso13428505e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213367; x=1749818167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6T2UdLZ98T4mEFrrnkCvZZaWql+Pj2cZBNd8iq7JhE=;
 b=uYFQEqyYRTm3RckWillkZXdo54/00COOdCNS+HE8PuOgvA8bSWX8B9WfSXa1IfTqMe
 bSqFAxJ45rVKEBHjkX6h2akpQ3yjTCIseuGVCHl0QRkPsqWMny0qBGemSCbTw2QYlXqP
 3k2KRAz3LYNhENL2YuuP+a81yJjqdKeISFj8UtUqrLlLPDl+Y1FvPptwWgb7BWoKDlJO
 S79nnUBxG0UzCCiPIE6k6GRykny+X0wCK/Fe0vPdYGfwR2JfFpbagS6pPpio8dRq670E
 OijZdgmdA5/jx2QoR715+Y1aDVmikkrBN000vWCrpp3wSey+gd/FT+e8Dl8N0uE46t42
 HU2Q==
X-Gm-Message-State: AOJu0YzfBsWoZs0SOH2+eLC9iDpNfWHVaR7wYUhrDBE4jTYg+1ifdTnH
 29PmiEhMTDVPZlvazDCzm85Dvr+glol6qe9n3hrqrHkF4dWT08L7GQ7UYGWN+tEQr7MnY5tuFbV
 5OJdbNoAuDBo0nxur8O1Lp3RKgOja2kS00V4qjju/QhtiyLUgrbA2Pl2//y3AQHBfY/9+3NzAsf
 r+mgzYJB17aD3w3AmpYIUuJSOyU7WEHgs38FFf232S
X-Gm-Gg: ASbGncvQWlDbzZ2HzotUk0DJEZq8H3YnZyQAMKfZ/XIWy8GD5gpXrPTtbbCr/Epjmlc
 XD0YUQB6b8uCx0+GONv2kzT+0BcsvgsW02euiVieR9NVwnCi1DoVi1NWbT+RW20JJ4MaZIbcV0l
 7L7vFEBATgdtRd+cJao0bfSzEUI+jTkRh+AMsZGa3+1w9IRdYClIHLFm2MfIFtCiNjsCKTeyTZn
 3IAaCaUw01Lrd3gC+pTY3eEXrjCl3CVpL7+31GJOpbZb53TA21ZZhBOApsPzd2f+vGpGuLET7Dq
 77zol/Sugck0Nw==
X-Received: by 2002:a05:600c:310a:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-452014235d1mr32936825e9.29.1749213367447; 
 Fri, 06 Jun 2025 05:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE424q/EwXJFAssQxY2eCPg3Fsp78gspcYwg612N1I05o9/1GG7qSkOkP+1NgweuT2WF32sew==
X-Received: by 2002:a05:600c:310a:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-452014235d1mr32936535e9.29.1749213366894; 
 Fri, 06 Jun 2025 05:36:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53243664fsm1786344f8f.65.2025.06.06.05.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:36:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 23/31] qemu-thread: Document QemuEvent
Date: Fri,  6 Jun 2025 14:34:37 +0200
Message-ID: <20250606123447.538131-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Document QemuEvent to help choose an appropriate synchronization
primitive.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/r/20250529-event-v5-12-53b285203794@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/thread.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 573f8c9ede2..f0302ed01fd 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -10,6 +10,16 @@ typedef struct QemuSemaphore QemuSemaphore;
 typedef struct QemuLockCnt QemuLockCnt;
 typedef struct QemuThread QemuThread;
 
+/*
+ * QemuEvent
+ * =========
+ *
+ * QemuEvent is an implementation of Win32 manual-reset event object.
+ * For details, refer to:
+ * https://learn.microsoft.com/en-us/windows/win32/sync/using-event-objects
+ *
+ * QemuEvent is more lightweight than QemuSemaphore when HAVE_FUTEX is defined.
+ */
 typedef struct QemuEvent {
 #ifndef HAVE_FUTEX
     pthread_mutex_t lock;
-- 
2.49.0


