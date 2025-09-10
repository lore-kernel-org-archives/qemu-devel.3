Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B11CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwNHB-0003Oy-UZ; Wed, 10 Sep 2025 12:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwNGq-00039w-3V
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwNGn-0004VY-W3
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757520122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F33TBYki1BDgx+VyY0rl+C5E5kkXuHdxe6UHxgWX2Qo=;
 b=XEmH7DKCko5u/BHM7HPVIBXezKNdxKQoG+1tTNxk4WwUs5n6yElrkHhPNs7/H5DSYZt+ol
 OTZ3N4Xos8m9DsC0DEnnrt9bjQQeov0bJpEgcWrjxBjiVhxyt2bMfyTpLfPHD9VyqVCKrR
 o0leVYj/neBEI6FD8gjPeXPByfz8opU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-5IXxPuCDN7W99NkfOU6fYQ-1; Wed, 10 Sep 2025 12:02:01 -0400
X-MC-Unique: 5IXxPuCDN7W99NkfOU6fYQ-1
X-Mimecast-MFC-AGG-ID: 5IXxPuCDN7W99NkfOU6fYQ_1757520120
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b5f9673e56so133860451cf.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 09:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757520120; x=1758124920;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F33TBYki1BDgx+VyY0rl+C5E5kkXuHdxe6UHxgWX2Qo=;
 b=G8Ygc5AdQu94CqAXxPgVlvHZNs0ntKBMqHSYYUO9b2obNbyWV+Grs6Wjhed40vKniE
 08mfDFFGVlG9I6xFPtCGZYL9FBuMxqlbCEoJVRf/kpCeW/e3AxKo9DQceFBjHtcwPekK
 4mfx2NoMoHJCirEng8byWNIUJNwsFtuaBZO/6+AP4QFsPRIiZBzFsSxfN5UejYa/bIV1
 sM+QyfngjGxhGf3sO8AHHV8ODbdZektoSvBPaMAEcbpHQzvtByDIpFSFxVYH/dPDufwA
 c5owb2iKNMzxxgs8+htKXHbFsYxCLMhrHAF0jUdnNIP0FV9GUuStyBZb5eQCwVP0pERg
 HrKA==
X-Gm-Message-State: AOJu0YwYupkYqvV97fvAOVpraYp1senvAgNNYYjajzURUh0p1bn0jrgC
 ELXXrNTH2/Q/m9J/j8bicGizthw3THS5l+Pv/Gb8Rcdt7wFYUxNfPb5/q5GXBkXyX9jAcnTnVhN
 BcSYQSnqd3vVscDbydCn2WLCDyVGEYpVxazNjBRBq7KhOEzLbjG/4Um6g0uhnWLGVLu6hB/yrlz
 IF4vQqhs79BMi0dZZZVKx4FcEEcjrnm6DAo9CFCQ==
X-Gm-Gg: ASbGnctrOJFD0chRDu4cu1OEHBglbjkR32sqd/3SKnKtB6Ovabe1xKJaLCW5fxmFFgx
 pBbknS4O8yMc9IC0Ic75T8gKYaQOew7r5P/A2V39HEIenWft4qAl8+ZZlUksPo0pLM04KhiWmsq
 aNvwBjzFcHWaTiZASQzn9LDQOQTevnKTI5VogiROIQ6CMaaM47sFI7skT2EfizFGs/c1hvGQIJ6
 7iJjQ2+mKpdSYWmQBxTPW2aXcDBCV5sh05d2l4ugc+7hDwUSVb8+SUoZD/8ssTM/ejvjGJMPpWh
 Aa96h3KCChlQPSpe/ysi7/O+Byj9GQ==
X-Received: by 2002:a05:622a:1788:b0:4b5:f514:7e17 with SMTP id
 d75a77b69052e-4b5f83a509cmr196120591cf.22.1757520118452; 
 Wed, 10 Sep 2025 09:01:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOKu0bMDourAMbQ+lj7s8GLZLzGItc3Tj5EgM3cK7m3JgbHNbJqBjyr1IuDcltTGpUoKAOmQ==
X-Received: by 2002:a05:622a:1788:b0:4b5:f514:7e17 with SMTP id
 d75a77b69052e-4b5f83a509cmr196119271cf.22.1757520117312; 
 Wed, 10 Sep 2025 09:01:57 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61bbe0a85sm26655281cf.42.2025.09.10.09.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:01:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 0/3] migration/tls: Graceful shutdowns for main and postcopy
 channels
Date: Wed, 10 Sep 2025 12:01:41 -0400
Message-ID: <20250910160144.1762894-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano fixed graceful shutdowns for multifd channels previously:

https://lore.kernel.org/qemu-devel/20250206175824.22664-1-farosas@suse.de/

However we likely forgot the rest channels.  Do it the same for the main
and postcopy channels.  This fixes a warning message when running unit test
/ARCH/migration/postcopy/preempt/tls/psk.

Thanks,

Peter Xu (3):
  migration/tls: Gracefully shutdown main and preempt channels
  migration: Make migration_has_failed() work even for CANCELLING
  migration/multifd: Use the new graceful termination helper

 migration/channel.h   |  3 +++
 migration/migration.h |  2 ++
 migration/tls.h       |  1 -
 migration/channel.c   | 20 ++++++++++++++++++++
 migration/migration.c | 27 +++++++++++++++++++++++++--
 migration/multifd.c   | 40 +++++++---------------------------------
 migration/tls.c       |  5 -----
 7 files changed, 57 insertions(+), 41 deletions(-)

-- 
2.50.1


