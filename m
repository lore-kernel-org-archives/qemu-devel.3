Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA68AD6E2CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDf7q-000215-6j; Wed, 20 Nov 2024 02:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7n-0001zt-Ty
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7m-00086V-7v
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732087661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rLHa2lhaD4JkWUbp9sIMcNrBEmDkALIbWpGkF72WqY=;
 b=Yrh/eaL+hqMOYLlRd6sH5d0OuNsQztgsVL3YYx1A+py1oB/5OYO5rMzSCoXcDvdw4pmL9C
 PnTfdHyozVLOBWFbeTFVEWyE56w5rMQhXcAyfJLZwvdSG85p/kT+SE09vXBhNlHoAdFHxf
 rZuez9ypkXKV+HfHvSOXdNUhzZHJS80=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-g2th1MNmO3ueSzxoG51GWg-1; Wed, 20 Nov 2024 02:27:40 -0500
X-MC-Unique: g2th1MNmO3ueSzxoG51GWg-1
X-Mimecast-MFC-AGG-ID: g2th1MNmO3ueSzxoG51GWg
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539e294566dso3838879e87.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732087658; x=1732692458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rLHa2lhaD4JkWUbp9sIMcNrBEmDkALIbWpGkF72WqY=;
 b=v3z/NaQCYpem0qTUYB2exOg4PpV6xvvUGgshfHN9FnNfu0WxR0U8803Z1vEaUNSE7q
 mWHMJyUzzSW6LzSUF4Hg3qh377ElEoK8Fe47yhh4xA2/nVTQr1ztSYWlD8IBEOAYinb4
 L64B9epdV3Zx1um+pj6AUSYzAH7KT+gRuwDaxIFeXUZjpbaUSVKUuL9FPLrJHEuoeBoU
 Aez7BUNXcnwj5UOFKN5WOlRjhBQENa+GU4hTonzIZ44Ln/gl3/HivIQ00mQLkRcd+6ES
 uwUyl2RaXNEf31lioCZ/8Bct4hwaNT3HlS6mQrjmQvNBnaxqoE9c7NYKxdFmO51aN/WJ
 Oiuw==
X-Gm-Message-State: AOJu0YzIvYJkDtxN9SFWwuRSTnl8Ba29LOH+a3ncBhB1eaftwhD8Yz5a
 2D134hiotaGY+RzmVWifElEWKkdOzvJYOww8rZbapYehQfxoaUGzEC9Ie6hUCShQ0JRDrwKdQBL
 NrNVpT94ZiBDt2chxPfLkprdrhRAeHBvEWxtph+wFY6kkH7tNbZO5UhApAvO+BDPpt5PPlpRGGm
 jdxjYHWGlKxFfKjQcBa5dLTWmKKdij//9Yyiav
X-Received: by 2002:ac2:5b01:0:b0:539:f26f:d285 with SMTP id
 2adb3069b0e04-53dc1323503mr633172e87.3.1732087658047; 
 Tue, 19 Nov 2024 23:27:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhRVz9VYZsZd/AYl+/XTvilrzQiVez0TUuzzSwRNqUHj6o+oMnUPEX6uqNrjfjUJasZ4LH9w==
X-Received: by 2002:ac2:5b01:0:b0:539:f26f:d285 with SMTP id
 2adb3069b0e04-53dc1323503mr633154e87.3.1732087657623; 
 Tue, 19 Nov 2024 23:27:37 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d4ce6sm9161925e9.25.2024.11.19.23.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:27:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com,
	thuth@redhat.com
Subject: [PULL 5/5] scsi: fix allocation for s390x loadparm
Date: Wed, 20 Nov 2024 08:27:23 +0100
Message-ID: <20241120072723.103477-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120072723.103477-1-pbonzini@redhat.com>
References: <20241120072723.103477-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Coverity reports a possible buffer overrun due to a non-NUL-terminated
string in scsi_property_set_loadparm().  While things are not so easy,
because qdev_prop_sanitize_s390x_loadparm is designed to operate on a
buffer that is not NUL-terminated, in this case the string *does* have
to be NUL-terminated because it is read by scsi_property_get_loadparm
and s390_build_iplb.

Reviewed-by: jrossi@linux.ibm.com
Cc: thuth@redhat.com
Fixes: 429442e52d9 ("hw: Add "loadparm" property to scsi disk devices for booting on s390x", 2024-11-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 8e553487d50..7f13b0588f2 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3152,7 +3152,7 @@ static void scsi_property_set_loadparm(Object *obj, const char *value,
         return;
     }
 
-    lp_str = g_malloc0(strlen(value));
+    lp_str = g_malloc0(strlen(value) + 1);
     if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
         g_free(lp_str);
         return;
-- 
2.47.0


