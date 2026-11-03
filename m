Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9BA606A33C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BJZ2ZfjK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qu4fleSj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2H-0003bg-C3; Tue, 03 Nov 2026 06:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2D-0003aw-7q
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2B-0000Jw-B6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tZcQd4j24SOkPd+c0T3lL/TJVy1cifbr427VoGmUk7A=;
 b=BJZ2ZfjK0OEgO9cSMSj3l0O+MsNVBjZXLkyTi4ovS1Ep4uD6IsMvkPNO51ZZYo1JijCHxP
 ZhHoVMCAl6aa4YNqiJ+zOSVRsdUvUAm0XHQ9f93xQdjeUvFnziPuC0hxcyUIgu5W4Lnd48
 AbD09g5H5JrSx1siSj/MKINNnK/vE2A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-3UHSQGR_PYe4WkmEPTzgqA-1; Tue, 03 Nov 2026 06:50:32 -0500
X-MC-Unique: 3UHSQGR_PYe4WkmEPTzgqA-1
X-Mimecast-MFC-AGG-ID: 3UHSQGR_PYe4WkmEPTzgqA_1793706631
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1fa972b4fso21196165e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706631; x=1794311431; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tZcQd4j24SOkPd+c0T3lL/TJVy1cifbr427VoGmUk7A=;
 b=qu4fleSjVsyG0qbf7yNox2Q/Fy70PHEknnXeWKno5AKhsXFUStjuMuIP3xHmJgev1h
 KfWV7nF8G9IfXwoupdFJ8Mdy/5vzigJ6ZgrgPtVAV6p0UGFI5p3pOVz8Kb0AbAEtb1yg
 sL4NZ0QLZGSNyBElkgsIfmx3UvKhTMu3ObNqU9yikA5FcsXmA0PLtRzP0F5+gHp34rPn
 3Xap1eMRLU5Aw8SKH4oneQtzVzAFwZnWLbx7nNp0DCKs+1PCZz5CWd2AAwrj5CIly1EP
 dbk0YfNVd/dRfUViE8F375hbdre3hcOtCnqOQRPQyc49i/NOYzUmjvYIoS76LLDqR/rB
 XbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706631; x=1794311431;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tZcQd4j24SOkPd+c0T3lL/TJVy1cifbr427VoGmUk7A=;
 b=f03b5BGLWWb7ssIsU3VlbwNSiH2nH8xEKqZw76lfe95MpFETMs4/cnZi/Y3GdfcwCQ
 vnhG/EIaoQHWza+d1HKzfT7slF27BRYxMkk1lECvSiWntDjEQvOUF4uirevNrm+zeP28
 uV818vzc20JZODpLzqvT3OjyCXp+LBp8Wg73pTzZEbPzuJi80Iek00YU/6WKG29QSwu0
 D+y1/bUwrumfQkoQtfVoNZ8g1KTBn2uipVVU9VDyfECPNqNcfGG4nUjiV6rkGHGpa2bM
 0GlHWeNSJ2m/qANfoixxNpMRrO7ZLqkeNeCe82HnngAkGlOH3SiqwV6OEvG9rqIs8emG
 Py8w==
X-Gm-Message-State: APuU4Z9Q5u22z0OZF9VwaOFL/UKRn8Db0dUthsuTzaptfso2dLI246H3
 TMz8INMfRxwLZ0wFHqZa/ek37VWIR8SxMH5ySIEXtlZO7qq3qZfjx7M1RmwH6qg/BNNBzrvq4Dx
 pwdD829EsUWl0pArTHnQOKqy7gA6oLqusTz3f4GS7qgwmfaUKP4ZREOMA7onYXPTJouffKfkRZw
 bFhWU2SamHviY/G/zeK9iJRyN2Qk5Fsik45A==
X-Gm-Gg: AYBFou3pdDpnnz9sSfE3Gqt3hxjrfm/vxNKFNzk6eCSgYtHZC1DDHVch5nMCenp4QGL
 hH3vNjiH8Z85qGnwvwFhAsAAfL4tFKXyoL/13Bk3LmPds57yeqG4H9Ucc24Y7yFzFvChlGCCa4o
 EtZKethhxrsgsiRZ7Tx4kKO1ZUlA5bVd1si2wwPoUwxriimeuPcOJnVl4TQr0TbxmoIpHifWhTW
 QqbG9eeoWf8n5SGupqQYYu9cL8ilCCDabwJe6g697PdAumgN/POogSLIWTNP2mSomL7RNN4VWW9
 GjarhoXuSMlzVZqy9JjIntoISfrbRykTgC+q1DjUHKSodRqAKe9hSFpAt1wD2emHdn9okuJjPw+
 pOR/9X+rNkA9kDFuMTPkMzHBFCScI2Pa/RYyCzEwGhw==
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id
 5b1f17b1804b1-4ac1719112emr282931205e9.9.1793706631462; 
 Tue, 03 Nov 2026 03:50:31 -0800 (PST)
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id
 5b1f17b1804b1-4ac1719112emr282930595e9.9.1793706630961; 
 Tue, 03 Nov 2026 03:50:30 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a879f401sm49067545e9.5.2026.11.03.03.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:30 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 03/17] pci id: clarify pci subsystem id usage
Message-ID: <16085c7f27f95d6c178d77894d35de46d6b83e86.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gerd Hoffmann <kraxel@redhat.com>

Qemu uses the pci subsystem id not only for emulated devices, but also
for virtio devices and generic pci class devices such as pci bridges,
xhci + nvme controllers etc.  Update the documentation accordingly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261030115455.1121808-2-kraxel@redhat.com>
---
 docs/specs/pci-ids.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 60cb0f7db6..53dd571de2 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -46,8 +46,9 @@ maintained as part of the virtio specification.
   upstream merge or shipping a distro/product) to avoid conflicts.
 
 1af4:1100
-  Used as PCI Subsystem ID for existing hardware devices emulated
-  by QEMU.
+  Used as PCI Subsystem ID for existing hardware devices emulated by
+  QEMU, such as the intel chipset devices.  Also used for virtio
+  devices and generic pci class devices (1b36:00xx, see below).
 
 1af4:1110
   ivshmem device (:doc:`ivshmem-spec`)
-- 
MST


