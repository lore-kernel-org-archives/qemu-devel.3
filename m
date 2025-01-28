Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14696C02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqmF-0006rq-Kf; Tue, 28 Jan 2025 13:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcqlz-0006p6-En
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:57:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcqlx-0000kT-UJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738090637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5r4VjtxsT+ISp+Ezj4VWQLthp0p3MA/bNODm6gM6dI8=;
 b=Y+rLag5dZVEOplcHaUkIeC24hVjcpWx6Eqoag4fQUbNEFlXTT2jIK7/NahV8QNk1TSZilk
 ibidxotY3CmmOB8WiCK24l1ZLDg958v4CTmqOxmqpZ3IZXZ66PN4ODZqCpMBvWh5GRMr/r
 tcmboDf0vy1DiFs9z7aKTYZ93tP0v2I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-lO_DOY08McmZbOBI0hUyxA-1; Tue, 28 Jan 2025 13:57:15 -0500
X-MC-Unique: lO_DOY08McmZbOBI0hUyxA-1
X-Mimecast-MFC-AGG-ID: lO_DOY08McmZbOBI0hUyxA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so3635678f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738090634; x=1738695434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5r4VjtxsT+ISp+Ezj4VWQLthp0p3MA/bNODm6gM6dI8=;
 b=Qj1avUxlcr6ILcsGkGEyMZE68dy6JoWNyqHctcUw/hQ6rvWK3Hlq7Phvm4ZgerFtR7
 bvPvCMcpuJposTT0pS6pOkM+w/XWvTI6nck+LF+BH3GcOyrHguYL5tQRob+JLx0WNyRg
 iimqnq+kCNMfF3ipd4Ywa1Y0/Jze8ifCVEd/VNLekK7wUkoa95d/ChKDrdt755IBojw7
 DVa/2vArAU7Jica/w3uU07weS6Ux94eVhDtv2i78qMg1IAiPDZscSpw0+53B4ahn8W1M
 6xRUhmVHq585+17KJlnVlnWK+M34yGYiNsHRe/z0A02kTW0it1OoFJbWoe3u+GPvJZtU
 rgqw==
X-Gm-Message-State: AOJu0YyH5W21UmjYlfIqUoqNRXNQYQSbozsVa/WskxmQQkiDQc3cyBrT
 ClSMpvyAmIdEKCnnMBCLrKXEWqTE7uiJs3tp6Pv8deUrfrvY7j78VezcQNGuCF+cvd9VunEPJVh
 CtYfwgY1Qqf97SiWKGjvi7JOcrGTmK2IUZrcHQBnlXewWTqqZ/3iGTkcrvujl+yjNiGDupl2+wc
 U+bKZlP3G3q44G0kqyp97y7JrNjZO2gaKooME=
X-Gm-Gg: ASbGncujW596N9ZMvE+NqZvF83CBXMsWaJylHeTiaygj4BWPWImxRDeafZk++9s4Jrq
 MbiDnxq7hmYP4yHXLnU/d8uDwv9QEqrnMeAdLVO61O0eMxvxnmpx00d9hoElQzCMkPKBeERRMwX
 D6nel7V3A0c4vsEJbtEpgwmTmm+k9/zMJ8t4g9ZdBBeFJSPPtUHXNQ5sebkyKgvx0TV3yhdqxkm
 gO6FY5Oeas49xFjz7ZNbkAZ39wPSptRPxX2Gf3w4PTHrquF5Fs30FxaP7fVUuA8rDgahV22UmQy
 0qShyuinoffCFk9VoIzNYI7T3AdiGbtkV9yDhUfc9Mt5UN4xlNRfXP8JQ8Sc4rOMWg==
X-Received: by 2002:a05:6000:1f88:b0:385:e176:4420 with SMTP id
 ffacd0b85a97d-38c5194da70mr139236f8f.10.1738090634737; 
 Tue, 28 Jan 2025 10:57:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9pQX8CoKHCCCA6Sd7jiAnyizjLVsWHWsEmtV0ur2kZWocXGbBR78Wb5PpMEKIg/B+Gr6wyg==
X-Received: by 2002:a05:6000:1f88:b0:385:e176:4420 with SMTP id
 ffacd0b85a97d-38c5194da70mr139203f8f.10.1738090634320; 
 Tue, 28 Jan 2025 10:57:14 -0800 (PST)
Received: from localhost
 (p200300cbc73fce001be76d7f3cc3563d.dip0.t-ipconnect.de.
 [2003:cb:c73f:ce00:1be7:6d7f:3cc3:563d])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38c2a1c4e49sm15089889f8f.98.2025.01.28.10.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:57:13 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v2 2/2] s390x/s390-virtio-ccw: Support plugging PCI-based
 virtio memory devices
Date: Tue, 28 Jan 2025 19:57:05 +0100
Message-ID: <20250128185705.1609038-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250128185705.1609038-1-david@redhat.com>
References: <20250128185705.1609038-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Let's just wire it up, unlocking virtio-mem-pci support on s390x.

While at it, drop the "return;" in s390_machine_device_unplug_request(),
to make it look like the other handlers.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3af613d4e9..71f3443a53 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -554,8 +554,7 @@ static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
         virtio_ccw_md_pre_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
-        error_setg(errp,
-                   "PCI-attached virtio based memory devices not supported");
+        virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
@@ -566,7 +565,8 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         s390_cpu_plug(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         /*
          * At this point, the device is realized and set all memdevs mapped, so
          * qemu_maxrampagesize() will pick up the page sizes of these memdevs
@@ -580,7 +580,11 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
                        " initial memory");
             return;
         }
-        virtio_ccw_md_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
+        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+            virtio_ccw_md_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
+        } else {
+            virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+        }
     }
 }
 
@@ -589,10 +593,12 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         error_setg(errp, "CPU hot unplug not supported on this machine");
-        return;
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
         virtio_ccw_md_unplug_request(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev),
                                      errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
+                                     errp);
     }
 }
 
@@ -601,7 +607,9 @@ static void s390_machine_device_unplug(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
         virtio_ccw_md_unplug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
-     }
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+    }
  }
 
 static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
-- 
2.48.1


