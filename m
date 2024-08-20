Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44314C531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 11:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMc7-0005UF-FP; Tue, 20 Aug 2024 07:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sgMc2-0005Pe-EI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sgMc0-0000Oc-Gn
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724151673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JQ1d53v+93cxlbyGr/E9PZMQ1XfE3Z82Mwm/UxppW9k=;
 b=N1OCFCxW7+ZrRLTvOaptE8CdVXMY8we22oZaRBEGoXhXxiB6auL0NrBiidegwRf5JLxBwU
 EHUvw4quA6kFOP7oJlPRhIaMemPZ959bdD3MseU7rRpkops4PGOKRQyacrsRuUExeme4C+
 adT+SIPPj4kTJzyC6JCYxyy05gDxJPg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-lMFrRI-RM1GiPcOgkfUHIg-1; Tue, 20 Aug 2024 07:01:08 -0400
X-MC-Unique: lMFrRI-RM1GiPcOgkfUHIg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4280d8e685eso45742855e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 04:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724151667; x=1724756467;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQ1d53v+93cxlbyGr/E9PZMQ1XfE3Z82Mwm/UxppW9k=;
 b=jozpMOYjO5Oc4+NBSzxZaBuc/oSxdY1Qm9ME7TfrCUin2VCDBcuSpWv6PXkvSfk68A
 tbO7MR+KTrozXQi03MsudIRW4x9ls7kPD87FPNg5taV4kuJpZGVicpzOae4Xr/ftjPCE
 +5SR1RtCSyHB7INjaBz8mDPD2fCtf3g3dqG5fjH2f/uAeWilxOL2HpFbtYhqqtETMQTN
 INvVnD+iBIaeJ0kcmHYu3AsPr5msaIiQ4fSMWOm8+6KXxmq4eOyVuSUk7hLF/Y6xpOWB
 2DhjHxXA6ZvO8GKmABuANmeWbzcDqoQxI92dsJwH+wKdFKItC1ub1tyHqlrzN3HEvX7x
 b+sA==
X-Gm-Message-State: AOJu0YynGLSvw4pXTcDOlSm5OEkG0qKRctJveomUJ0vwAMXKJAA82kQa
 zT6vFMEZt2dWNfj9LYkz7pBGpSIFwKzSFqvqlpvYbLhK+1yNI8Z9IbftUiBs4u/Rwml5LQdFrsC
 ebnVo+63ILnYi215NUOzAg065/CWoipxRg8SYhQRNzQ/bF2jhxgi2ko8XOYHNznE75ZE3r0l3aB
 TMk15qdeIV8YMdmOFKZhU4pNEC/XohSQ==
X-Received: by 2002:a05:600c:5029:b0:426:59fc:cdec with SMTP id
 5b1f17b1804b1-429ed7af8f1mr108859255e9.21.1724151667144; 
 Tue, 20 Aug 2024 04:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzD560mfHyQWadZdFHzzUu5+22Wlnk/ccVVO/oTMpuY3sGiXuGHrPP6GcEJ1Xd6VyT9mPY8Q==
X-Received: by 2002:a05:600c:5029:b0:426:59fc:cdec with SMTP id
 5b1f17b1804b1-429ed7af8f1mr108858915e9.21.1724151666359; 
 Tue, 20 Aug 2024 04:01:06 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:a812:cb6d:d20c:bd3b:58cf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed79da99sm137847255e9.46.2024.08.20.04.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 04:01:05 -0700 (PDT)
Date: Tue, 20 Aug 2024 07:01:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/3] virtio: regression fixes
Message-ID: <cover.1724151593.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 76277cf82f0e1123bd69ec59d22014b8f78485ec:

  Merge tag 'hw-misc-20240820' of https://github.com/philmd/qemu into staging (2024-08-20 09:17:41 +1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to a8e63ff289d137197ad7a701a587cc432872d798:

  virtio-pci: Fix the use of an uninitialized irqfd (2024-08-20 06:57:47 -0400)

----------------------------------------------------------------
virtio: regression fixes

3 small patches to make sure we don't ship regressions.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      vhost: Add VIRTIO_NET_F_RSC_EXT to vhost feature bits

Cindy Lu (1):
      virtio-pci: Fix the use of an uninitialized irqfd

Volker Rümelin (1):
      hw/audio/virtio-snd: fix invalid param check

 hw/audio/virtio-snd.c  | 4 ++--
 hw/net/vhost_net.c     | 2 ++
 hw/virtio/virtio-pci.c | 3 +++
 net/vhost-vdpa.c       | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)


