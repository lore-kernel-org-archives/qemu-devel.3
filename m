Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EB5C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrKD-0001ZZ-0e; Mon, 08 Apr 2024 11:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrKB-0001Yd-Qv
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrKA-0001rQ-96
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kAFeFR3TFnC6ZvXg8Xbg86O1uug64SjMekWiPxE76o=;
 b=cwV81roU+h3vrc0p5P4F2VAXiMHhyfUI+IJ079p8b2/gio4P6Il54P0W4y/w7MzcJKFLJx
 ntxRCzbfALRxUMZJ0eyBWU2qCqnzs+gmcxZl3ibruckAJu+szCucRL487iHNCvZGFWV1rG
 LXzAWL1Hz0pof8gGb8yxi//hWPUGyRQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-PE7CnRVSMwGPg3FO6Tz9Hg-1; Mon, 08 Apr 2024 11:54:20 -0400
X-MC-Unique: PE7CnRVSMwGPg3FO6Tz9Hg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-416664de900so9021365e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591658; x=1713196458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kAFeFR3TFnC6ZvXg8Xbg86O1uug64SjMekWiPxE76o=;
 b=RGvBnMhGwyjMKHXaD1lR3HM0Pz1h1q0e8XXb5/YNhjqvEuAgfjjYDeqz/e51iKXxwb
 xG1uN87YrKfUWBev/6714QZGEqCN/kUym9HBtCIXPg1VhE+KmaYH+sBw26xHuNoz3Va1
 KePiVKIqE8Wmw5qydtR88bR67tcsjFHYS9eyXR9kEGUU5Wx07TCiBEvAgcXQhH5CFApQ
 vsk4L8q2VtroUfJZ/KZBJGbGF2vebDUyqiqlo+9VQmcqZkywGziR5mnk9meqM0QD2VDi
 +KDBBLK7DxMi0WUCZhGt1kQ+2HimfdeCef+IuFNDUwZGOTclx3wyfrODKU+GFTQi2wyY
 kurw==
X-Gm-Message-State: AOJu0YyrbcpCUl+nqPsvLoAC0xJyb62USERs7KRIVNuj1eobUox9OIXZ
 4pgL89mW7DOZb5qcDHUDYMqCFiXcGuxHpMSzdEPs6TAkrF2HTvf0mRyPdD74upwnjuAMX4c6DVU
 2zNrx8j5mmenMEZMvwIN2L9qAUHoYNqomLE5k4Sc9nmqtqucR4kY/dslMAtkF7HBTWzOysQXd6T
 g/rsQn+boxbgTneWY2GOgU+AQuwD9kctBL3Db7
X-Received: by 2002:a05:600c:1906:b0:416:3217:15be with SMTP id
 j6-20020a05600c190600b00416321715bemr9490133wmq.35.1712591658269; 
 Mon, 08 Apr 2024 08:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+C98nJTrHFPPnw9odefebrxdXIWiWcUNnyJuVsAcd5QoanIT+a34seTwiStU9JJY1CwZmxw==
X-Received: by 2002:a05:600c:1906:b0:416:3217:15be with SMTP id
 j6-20020a05600c190600b00416321715bemr9490118wmq.35.1712591658024; 
 Mon, 08 Apr 2024 08:54:18 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 i11-20020adff30b000000b0034334af2957sm9276431wro.37.2024.04.08.08.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:54:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 15/18] colo: move stubs out of stubs/
Date: Mon,  8 Apr 2024 17:53:27 +0200
Message-ID: <20240408155330.522792-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since the colo stubs are needed exactly when the build options are not
enabled, move them together with the code they stub.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/colo.c => migration/colo-stubs.c   | 0
 stubs/colo-compare.c => net/colo-stubs.c | 0
 migration/meson.build                    | 2 ++
 net/meson.build                          | 2 ++
 stubs/meson.build                        | 2 --
 5 files changed, 4 insertions(+), 2 deletions(-)
 rename stubs/colo.c => migration/colo-stubs.c (100%)
 rename stubs/colo-compare.c => net/colo-stubs.c (100%)

diff --git a/stubs/colo.c b/migration/colo-stubs.c
similarity index 100%
rename from stubs/colo.c
rename to migration/colo-stubs.c
diff --git a/stubs/colo-compare.c b/net/colo-stubs.c
similarity index 100%
rename from stubs/colo-compare.c
rename to net/colo-stubs.c
diff --git a/migration/meson.build b/migration/meson.build
index 1eeb915ff63..f76b1ba3289 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -34,6 +34,8 @@ system_ss.add(files(
 
 if get_option('replication').allowed()
   system_ss.add(files('colo-failover.c', 'colo.c'))
+else
+  system_ss.add(files('colo-stubs.c'))
 endif
 
 system_ss.add(when: rdma, if_true: files('rdma.c'))
diff --git a/net/meson.build b/net/meson.build
index 9432a588e4e..e0cd71470e0 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -20,6 +20,8 @@ if get_option('replication').allowed() or \
     get_option('colo_proxy').allowed()
   system_ss.add(files('colo-compare.c'))
   system_ss.add(files('colo.c'))
+else
+  system_ss.add(files('colo-stubs.c'))
 endif
 
 if get_option('colo_proxy').allowed()
diff --git a/stubs/meson.build b/stubs/meson.build
index a4404e765ab..a252bffad00 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -42,8 +42,6 @@ stub_ss.add(files('target-get-monitor-def.c'))
 stub_ss.add(files('target-monitor-defs.c'))
 stub_ss.add(files('trace-control.c'))
 stub_ss.add(files('uuid.c'))
-stub_ss.add(files('colo.c'))
-stub_ss.add(files('colo-compare.c'))
 stub_ss.add(files('vmstate.c'))
 stub_ss.add(files('vm-stop.c'))
 stub_ss.add(files('win32-kbd-hook.c'))
-- 
2.44.0


