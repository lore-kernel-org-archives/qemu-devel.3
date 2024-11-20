Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E36D743E6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshU-0008Ky-K7; Wed, 20 Nov 2024 16:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshS-0008HF-C4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshP-0006SY-Ba
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GdlWuAzVgLMPTb7jLHDxfnOi9pO2fiIoW8m2eDrLfQg=;
 b=hOBbyi/+9xX5JCyTn8qRxrQUeUaobdWFZsyeulq2fyckHSWqipjAyZ2M6Keyb64klxiw1Y
 N4B0YcI13dnklzbJD/ei6iNSPSLs3RfhyXa8G8vxq2KG/+Yu0Yxh4iEikUyKQgLW670xah
 PnT96lBel1fFyiGoSD5c71dQZ0ws3RE=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-MDcAJMaCMv2hjaOIBLbijg-1; Wed, 20 Nov 2024 16:57:19 -0500
X-MC-Unique: MDcAJMaCMv2hjaOIBLbijg-1
X-Mimecast-MFC-AGG-ID: MDcAJMaCMv2hjaOIBLbijg
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5eb742a18ebso204873eaf.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139837; x=1732744637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdlWuAzVgLMPTb7jLHDxfnOi9pO2fiIoW8m2eDrLfQg=;
 b=nzqSkL9kugiYmUnExfnqedt9ylyiyQqCqt5tZ5d9KRIgW9tND4aS2feQ4SEKJ9bdbP
 IoGiLABGiPonsw02nphay1rteHKQL0Y0Ts2XOIB12FxDfuG8RmDuZM8IoddY+qrvXXE+
 nwS526Kk6woyl5bu41sKTPnoXS4OML9Y4x8Vx8+pvgj/g8seMaZ+NTdnqehiWlgd+jA8
 vW5C7hemTmp51vKbP6dUfsdUUCoR4FiGUohjmp4cDgMqkdQiwsTiFiRQvakAZyg6tw5w
 Nif6mpGYI5t3St0pZAtAfg9cWyiNIPpFP1WE6p+ZlOhKaYsYj1/rpXlFjsauGiAkkycx
 Oy+Q==
X-Gm-Message-State: AOJu0YyOPzd7o2CIdTeuPPWRx9rZimWEuxRUJeuWfBqAOSRjKHXj10KX
 LC9Y4sxMcxR1lYlkCzTnvVAlzZGJjg1eeF9/Qh4dBCrLu44rUePw2GkwQeXabjwmSZnjumeMEtb
 PbSUY4lLFdHqRNlEEPMTcThDd5CRmaz5lqF5eSsU27l4Ta6R7qB0qxTFghpUKEpqer6FwIrBI9a
 5+cOa8KsakwFPpgsAJ4fbS5+8uAfK9X+CvYQ==
X-Received: by 2002:a05:6359:2703:b0:1c3:8c84:e08c with SMTP id
 e5c5f4694b2df-1ca66495017mr344568655d.10.1732139837232; 
 Wed, 20 Nov 2024 13:57:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZhlNlx3+iZq4ezAiFAE2b0r5JuUK83mBtbEHJy81HSXfFzaGsKsSK1jQ1j2lDNXCbJYSopw==
X-Received: by 2002:a05:6359:2703:b0:1c3:8c84:e08c with SMTP id
 e5c5f4694b2df-1ca66495017mr344565555d.10.1732139836885; 
 Wed, 20 Nov 2024 13:57:16 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 05/12] ui/console: Explicitly create "/backend" container
Date: Wed, 20 Nov 2024 16:56:56 -0500
Message-ID: <20241120215703.3918445-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Follow the trend to explicitly create containers, do that for console.c on
"/backend" container.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 ui/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 5165f17125..36f8c6debb 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1154,14 +1154,14 @@ DisplayState *init_displaystate(void)
 {
     gchar *name;
     QemuConsole *con;
+    Object *backend = container_create(object_get_root(), "backend");
 
     QTAILQ_FOREACH(con, &consoles, next) {
         /* Hook up into the qom tree here (not in object_new()), once
          * all QemuConsoles are created and the order / numbering
          * doesn't change any more */
         name = g_strdup_printf("console[%d]", con->index);
-        object_property_add_child(container_get(object_get_root(), "/backend"),
-                                  name, OBJECT(con));
+        object_property_add_child(backend, name, OBJECT(con));
         g_free(name);
     }
 
-- 
2.45.0


