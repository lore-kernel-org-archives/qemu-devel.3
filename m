Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF11E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV7Wa-0000Yu-C9; Tue, 07 Jan 2025 06:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tV7WQ-0000YM-TW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:13:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tV7WO-0000Wq-6a
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736248394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i4cw780DN/LGmTQ/ybrMWyZ0EkmQUgapSHvCxCFoy5k=;
 b=ZZ7AbSVY10tWcgOFtpWWGwV//o9aZZBAGH2MUqP7+A6U+XSsey+9t45U23ZmqwMaMsQCob
 +UFMVc3KBlVhLO9j2KKMvnJQJQTHUEfcoiYy68ijxpqCS4t/adHiZGudA68cubS3UjyIkO
 baW2Dsd5pSWxy66glDUOFFRJVCQ+A+c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-p-teSpYSMu-xjTQRfKXfMg-1; Tue, 07 Jan 2025 06:13:12 -0500
X-MC-Unique: p-teSpYSMu-xjTQRfKXfMg-1
X-Mimecast-MFC-AGG-ID: p-teSpYSMu-xjTQRfKXfMg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so6817249f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 03:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736248391; x=1736853191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i4cw780DN/LGmTQ/ybrMWyZ0EkmQUgapSHvCxCFoy5k=;
 b=iajPtKgbWKverjx3pwQEmhNEF3/rcfEWj6JZbglkESjdcOKKPHqKDHZE3sN9lNHoSm
 BMavaqQA4bz8Jlvfet5krgfLn8zqetQdRLWYV1kd6430+0LGy7vLtZT4kRqeYkZZiDtT
 pvgB93d6lgRvTNvuzWsmTkFOMGwUwN+ddA8Xw7UbLSy+NE2h+Eevcgo6JBb/wcUB5s/n
 9E58BFnkyUi8j63cH7jYoE5Czkmfm1UccqObdOM2s6OfYe6xty6JXk2z2l/QMkPDk/U9
 1QdbjkKSDD342VuUwVxcE2VDcuxMX7Xo6Y5XwAuxoECfFs3sS1EKsAeboPPRNYYGuiPF
 3Vqw==
X-Gm-Message-State: AOJu0YzD3flbdgxME25A0lIR8lPPELsqwbZiKJ4HHc+aV3r84Et3zMYV
 XDpkHd/Wxb7mUwoOjAstMHxdBNRr8HmIpaAxdl6xl6eP7IQ0sMBeKX8bZqHTLyRuShDWZYU2IpG
 RNuq50Mqnq/mUdlflLDCKzItmgWjRUnJbWocfbnOWh+Llvqw3rfQSQAWqXez5Kwa/jiazg5P3zT
 bn5iUBOc05N6dLDOIyZ0Dtr+sOwK44jdL1pMB9fTw=
X-Gm-Gg: ASbGncvpSv6ljrRpx3JQbg7TX5mZm48B8ZV3EB0nNr5VhamXAhFeW6ACLS8LYLooTsf
 6af3EdFalaVfxabz6E2g6s76+yZlKcjPWtTKL/uNcUOQ4PZoafxblAVaQgwqnTSduzvFmV75Yje
 yK0fWMPWaxN/GfLHBqXkvWRtLAKY6fV8+q9p3+DxZ56gu327mAr7kHNJ2u0QvspCM2viBhZ9+DR
 S1m7TwGFhNqkqGFvlRGGQNHP4ZnDPmmVnLf7vPZJEnW9+QY+7QpKtWJ6vPt
X-Received: by 2002:a05:6000:471e:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-38a222007dcmr57916471f8f.35.1736248390932; 
 Tue, 07 Jan 2025 03:13:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsKGtzMwet/3vDxB6OPZw6g/JXYZ4ek+I8YHCnTJ883ddE31kt7UZf50c6150NnPPetdLyJg==
X-Received: by 2002:a05:6000:471e:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-38a222007dcmr57916416f8f.35.1736248390231; 
 Tue, 07 Jan 2025 03:13:10 -0800 (PST)
Received: from [192.168.10.47] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a8d3dsm49686927f8f.94.2025.01.07.03.13.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 03:13:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qom: remove unused field
Date: Tue,  7 Jan 2025 12:13:08 +0100
Message-ID: <20250107111308.21886-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The "concrete_class" field of InterfaceClass is only ever written, and as far
as I can tell is not particularly useful when debugging either; remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 5 ++++-
 qom/object.c         | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 95d6e064d9b..f28ffea9a64 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -573,12 +573,15 @@ struct InterfaceInfo {
  *
  * The class for all interfaces.  Subclasses of this class should only add
  * virtual methods.
+ *
+ * Note that most of the fields of ObjectClass are unused (all except
+ * "type", in fact).  They are only present in InterfaceClass to allow
+ * @object_class_dynamic_cast to work with both regular classes and interfaces.
  */
 struct InterfaceClass
 {
     ObjectClass parent_class;
     /* private: */
-    ObjectClass *concrete_class;
     Type interface_type;
 };
 
diff --git a/qom/object.c b/qom/object.c
index b4c52d055d9..e9dfad854bd 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -314,7 +314,6 @@ static void type_initialize_interface(TypeImpl *ti, TypeImpl *interface_type,
     g_free((char *)info.name);
 
     new_iface = (InterfaceClass *)iface_impl->class;
-    new_iface->concrete_class = ti->class;
     new_iface->interface_type = interface_type;
 
     ti->class->interfaces = g_slist_append(ti->class->interfaces, new_iface);
-- 
2.47.1


