Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3BFC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3vM6-0004kp-Iv; Mon, 06 May 2024 06:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3vM4-0004jy-Fo
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3vM2-0000dv-S7
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714990434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bH0a8jMSBbDkZ5OVO8PpEw82Cy/TaMi/XdjNGpajG2I=;
 b=BEsjpPS3i1reU/A/tmSA6FIuOOd8siJWT+d+Xd4ZQDQZ5Bv2H8kvE38EzBlLRKRS7k9KYk
 afWNhDNiwAhX9dvqpNz2O8B7n2Wy4qC3SPW16VaC+eOiCEL7Ol3mLjakJOD61+m5xJGJZm
 Pf5kaAB/i9OgwvQunpsqHkz9GdSfVOI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-sg1pY0QVOiatwsVQ9v03RA-1; Mon, 06 May 2024 06:13:53 -0400
X-MC-Unique: sg1pY0QVOiatwsVQ9v03RA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59c2583f0bso59743566b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714990431; x=1715595231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bH0a8jMSBbDkZ5OVO8PpEw82Cy/TaMi/XdjNGpajG2I=;
 b=Cd3b15hct+6s1uaPhb9xwJVWGcH94Ocv+O9WGU0zJ5xFtauINVH0wsFcoZSC55l20n
 0Uk8vbWwxV59/1UrQq5o6bOWmWvU0OJfMFo60cPJ0LKGAhn0nIb1p8H3O+1TsJrqH/UO
 KPZI2J4NBbmvzTCcEoBmlH4G0BLIuPdLpbJz/qgbSpIU1eHFico9pwhp2eN+FbkCU98B
 J4eOjmjLXOTpTlL9x3DSoQ9ehNDyg0KcAdvbPIxQ85O1M9yY/A+oCOD8bWbU12x7FDi8
 rsbmDAk3NbJ0m/ENWOkret6LwlFxveBACsfvJqdb0aGFB6ezd+Vk5EEkGrjdSiY77dn0
 xcLw==
X-Gm-Message-State: AOJu0Yz31caACiROP2Vs7Ht5eOkDxumP3XyJu24zgAJSeIPq9meNWnRt
 mvfHeCF9sp9suW0VSSNMFxE6JvVBXvARE7/PU6+HOmmzZ2AzPRxJ5LP3Vdz2EYka07FGOXL8QAv
 +EM+s6w/I0hIqIIm97+AvoxSoSVwwIP9d/6uQ4dSknpf1gINe+0/5IXU6PvOFyxSZEqP9Q237+w
 TXyFsO4X1xukrOzA3uV+GqQvhPOrFrEqUCIloP
X-Received: by 2002:a17:906:b7d7:b0:a59:a727:1e8c with SMTP id
 fy23-20020a170906b7d700b00a59a7271e8cmr3711912ejb.1.1714990431315; 
 Mon, 06 May 2024 03:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiTME7TkauRNFmbpqaCN2iVNC2pJZzM1LN0ij29Sx0H+f72kAmK95AuKDLEypFjoAul5h59Q==
X-Received: by 2002:a17:906:b7d7:b0:a59:a727:1e8c with SMTP id
 fy23-20020a170906b7d700b00a59a7271e8cmr3711889ejb.1.1714990430813; 
 Mon, 06 May 2024 03:13:50 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a170906474100b00a55892e840bsm4973887ejs.205.2024.05.06.03.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 03:13:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [qemu-web PATCH] blog: KVM Forum 2024 CFP
Date: Mon,  6 May 2024 12:13:48 +0200
Message-ID: <20240506101348.30469-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Add a new post linking to the KVM Forum 2024 Call for Presentations.
Thanks to Stefan Hajnoczi for providing a draft of this post!

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 _posts/2024-05-06-kvm-forum-cfp.md | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 _posts/2024-05-06-kvm-forum-cfp.md

diff --git a/_posts/2024-05-06-kvm-forum-cfp.md b/_posts/2024-05-06-kvm-forum-cfp.md
new file mode 100644
index 0000000..23398fe
--- /dev/null
+++ b/_posts/2024-05-06-kvm-forum-cfp.md
@@ -0,0 +1,36 @@
+---
+layout: post
+title:  "KVM Forum 2024: Call for presentations"
+date:   2024-05-06 07:00:00 +0100
+categories: [presentations, conferences]
+---
+
+The [KVM Forum 2024](https://kvm-forum.qemu.org/2024/) conference will take
+place in Brno, Czech Republic on September 22-23, 2024. KVM Forum brings
+together the Linux virtualization community, especially around the KVM stack,
+including QEMU and other virtual machine monitors.
+
+The Call for Presentations is open until June 1, 2024. You are invited to
+submit presentation proposals via the [KVM Forum CfP
+page](https://kvm-forum.org/2024/cfp). All presentation slots will be
+25 minutes + 5 minutes for questions.
+
+Suggested topics include:
+
+* Scalability and Optimization
+* Hardening and security
+* Confidential computing
+* Testing
+* KVM and the Linux Kernel
+  * New Features and Architecture Ports
+  * Device Passthrough: VFIO, mdev, vDPA
+  * Network Virtualization
+  * Virtio and vhost
+* Virtual Machine Monitors and Management
+  * VMM Implementation: APIs, Live Migration, Performance Tuning, etc.
+  * Multi-process VMMs: vhost-user, vfio-user, QEMU Storage Daemon, SPDK
+  * QEMU without KVM: Hypervisor.framework, Windows Hypervisor Platform, etc.
+  * Managing KVM: Libvirt, KubeVirt, Kata Containers
+* Emulation
+  * New Devices, Boards and Architectures
+  * CPU Emulation and Binary Translation
-- 
2.45.0


