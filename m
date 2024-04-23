Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3BFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG1d-0005wz-EI; Tue, 23 Apr 2024 09:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1C-0005HZ-6e
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1A-00025T-Pi
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSGRxPuU7t+PHA40W2AJKTyVoCXEdGYsJXg3MuWZZfU=;
 b=FEx1UXN1H9PqY8L/iJQoRk+exHqvTNauK/D9MAsSQQSyUDdBY4reNBlsewl+XbvZidw2j4
 1apzCoELnDYZ6sKQgQYq0dYDZFX39depTZLT53Jx7ffyENBnRi6QvTT9bkvNNma669tclt
 Sz2lG1Tgs6412iLyPZSfArivdXztPr0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-lOiovvu4OgexGcy6oGqfNg-1; Tue, 23 Apr 2024 09:17:02 -0400
X-MC-Unique: lOiovvu4OgexGcy6oGqfNg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-51b4790d422so1962925e87.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878220; x=1714483020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSGRxPuU7t+PHA40W2AJKTyVoCXEdGYsJXg3MuWZZfU=;
 b=o5x3YWH85Im999Jd8RvYzkVZJhYxX3UJhQ26nQGsW4+dUjfvfXLODdhenW8gGYexrc
 oOVk6Y2icLQdVz20itNqK2vNp0Ef3+fm5MRQnIbWc2HP+c+uqkjArVKm6Au7dtWjWZ6q
 gjddCWYZF0V8meIu4z2VMaxa6tQHex9SlX8ih/yCgoR7DElC3PgMNR0A+DRpZSqdvpUm
 +AXQgWXgBtljEy4xUjvQKwteEVoCerDoDRgAPSXtVRgpYuQSFzOmUbKL/vqApn9ZOMTW
 zD+WUib8a1gi9/fdIU3PybCddzPg1aG44m5BLuH8wv4x6rya7puHLRML8s1zT6pqEL19
 ppmg==
X-Gm-Message-State: AOJu0YwsuAxe1/v/NB4aeM8U+2UErSlLwm4XSTw59CtDt9xZQJLqhMKd
 FKW3zmRlfwLC/kmnex+NBcU8yBc248vqeFztqNVw959d/6F4LVwm+skuA/bx95U7Uqz/h59ST4e
 bue7Nxg3VK6miTOmzyY6DzZRfUGLJhTEyOe5pBZ3OzKRmEsqpeYphI2zqDPq8grDwAYthJpsAeA
 0XCuZ8AIVbyMju6DDke4+BcrJkrXQ4DhXyw2Bs
X-Received: by 2002:a05:6512:38c5:b0:516:a091:db5e with SMTP id
 p5-20020a05651238c500b00516a091db5emr6913672lft.48.1713878220700; 
 Tue, 23 Apr 2024 06:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJhC8/AzbD8jqmsqGdCx2APdbbrac7me0v57V2LDVCXZBIZyAmshxkRVC9uFck7+JloJU4tg==
X-Received: by 2002:a05:6512:38c5:b0:516:a091:db5e with SMTP id
 p5-20020a05651238c500b00516a091db5emr6913655lft.48.1713878220378; 
 Tue, 23 Apr 2024 06:17:00 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a17090632cb00b00a46a2779475sm7005937ejk.101.2024.04.23.06.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 18/22] s390x: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:08 +0200
Message-ID: <20240423131612.28362-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with s390.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/s390x-softmmu/default.mak | 5 ++---
 hw/s390x/Kconfig                          | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configs/devices/s390x-softmmu/default.mak b/configs/devices/s390x-softmmu/default.mak
index 6d87bc8b4b0..340c1092922 100644
--- a/configs/devices/s390x-softmmu/default.mak
+++ b/configs/devices/s390x-softmmu/default.mak
@@ -9,6 +9,5 @@
 #CONFIG_WDT_DIAG288=n
 #CONFIG_PCIE_DEVICES=n
 
-# Boards:
-#
-CONFIG_S390_CCW_VIRTIO=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_S390_CCW_VIRTIO=n
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 26ad1044858..3bbf4ae56e4 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -1,5 +1,7 @@
 config S390_CCW_VIRTIO
     bool
+    default y
+    depends on S390X
     imply VIRTIO_PCI
     imply TERMINAL3270
     imply VFIO_AP
-- 
2.44.0


