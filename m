Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A696FC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ6P-0002uU-4i; Mon, 27 Jan 2025 09:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcQ6L-0002g7-HN
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:28:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcQ6J-0003aN-IZ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737988109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WswtCPtrUwrXT5vATuJzuX1ZNSDYrtaRkeFZSx8J+sg=;
 b=enfkgmy/yBSOHarwcjz0zPI4A3M7iLWQI6bacmTCz7LSRyo7Wblxi++mmzu46i9eI2Ix0M
 ksT/B+2TJ/ru3BSn2m60kVWdel6K6s5bZ9UoSS5cjDdWJLohAR8WGwVd33qDwzBq/Jfzbv
 E072m4GIRKQG2dQk6mo/LZjX9KHaJAA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-T-4ofaW5NS-JfiNEhrjWaQ-1; Mon, 27 Jan 2025 09:28:27 -0500
X-MC-Unique: T-4ofaW5NS-JfiNEhrjWaQ-1
X-Mimecast-MFC-AGG-ID: T-4ofaW5NS-JfiNEhrjWaQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38c24ac3415so3686918f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737988107; x=1738592907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WswtCPtrUwrXT5vATuJzuX1ZNSDYrtaRkeFZSx8J+sg=;
 b=ft1z3trt4u3vhwcLbrqgYSZq3QbvhCSSNGS94yq7eicgW7FXR1jQrcA5Ng3rg7GyHW
 Ou2p85vcn7E+jbr/5pJA1xdXvwa6ejpyA+XS17R5YpsHhBlDuzp8x5iRUWkS4JiRFRLL
 jVmGyDTydAEQkfYykpTRjHdj/iZsZKdmKF9enwymlvpxlu2lzg8IxMGHZ2v5A6SN5LGR
 UAUrQ2cC1YciwiN6aqfllGAx7BhLF3Kfd76lVPT8RKG2tOFK70dRULFQd7LsbJXAMWnG
 CG50p6LbH/q3pGXdH+kgez8jOPMBc0uPuSVQr+RNlw2DQR1Sd8IDjJTYJE2j1dwxx4s8
 6xGQ==
X-Gm-Message-State: AOJu0YzFocHYjANteGk8PE682EAPaLWpYGuRGWnUFPE8iCpLJP0D9wKO
 Emz6DpM8PGgeSzg5olZg0/5NahGlDcLJlPo1RxQHvZTyzXaPiI/44TjIuY8w7BcEvVNBnl6KWe0
 bG39C5zl6BhYCakO/l5nj9Ly3W2Q+LgQQpHvcAK1/hZX1gCbghM/BE/XOFmLmaw4mgHYJ38CFqP
 xHaj8vgPp4lLVe6sKrjzJBoKs8MPWnHH0ENCY=
X-Gm-Gg: ASbGncsYEuqIZ82U4AFSoK7K5JwGRVb7B3jqKv3jrrFKby0gWhvHXBl1EXixK0L4TPR
 Yx6cQWG4QKr29SEOefHY//T7U6DXYJt3Tp4PabpuWXlJYPT13Mu6Vp+rxbjygyaRDpGRHVzddJU
 udp2wBTiZleKgejs1Szz3X4DMQLgiHvtdBZB5YfBp3eIk286laHIubC5of1AWbPvOtP5S+cjdML
 3511SvkMI9ou9ljAh5iqMYU0n2nfSci2UU4fjHHGL4ajxEaQf68R9iP5y8kYIIfaFYTqD3754Dg
 cOtDUza6J4OIG3BWAMPheaW3/psv/+/ys6VQQZ3NTYYNargk/fS6z1g9uUtOtpc2cQ==
X-Received: by 2002:adf:cd82:0:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-38bf565a596mr29520292f8f.20.1737988106728; 
 Mon, 27 Jan 2025 06:28:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDZxVHx0B7JTEVu24cgvPNWgP+lfDitGtoy2cuzHc2tT9rpNdChJ77AnXxx/89YeBPyVCcTw==
X-Received: by 2002:adf:cd82:0:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-38bf565a596mr29520257f8f.20.1737988106259; 
 Mon, 27 Jan 2025 06:28:26 -0800 (PST)
Received: from localhost
 (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de.
 [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38c2a1bbc8dsm11310897f8f.72.2025.01.27.06.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 06:28:25 -0800 (PST)
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
 Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v1 0/2] s390x: support virtio-mem-pci
Date: Mon, 27 Jan 2025 15:28:22 +0100
Message-ID: <20250127142824.494644-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
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

This is based-on [1], which adds MSI-X support to virtio-balloon-pci,
but can be applied independently.

Turns out it is fairly easy to get virtio-mem-pci running on s390x. We
only have to add MSI-X support to virtio-mem-pci, and wire-up the
(un)plugging in the machine.

Tried some simple stuff (hotplug/hotunplug/resize/reboot), and all seems
to be working as expected.

The kernel in the VM needs both, CONFIG_VIRTIO_PCI and CONFIG_VIRTIO_MEM
for it to work.

[1] https://lkml.kernel.org/r/20250115161425.246348-1-arbab@linux.ibm.com

Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Boris Fiuczynski <fiuczy@linux.ibm.com>
Cc: Michal Privoznik <mprivozn@redhat.com>

David Hildenbrand (2):
  virtio-mem-pci: Allow setting nvectors, so we can use MSI-X
  s390x/s390-virtio-ccw: support plugging PCI-based virtio memory
    devices

 hw/core/machine.c          |  3 +++
 hw/s390x/s390-virtio-ccw.c | 20 ++++++++++++++------
 hw/virtio/virtio-mem-pci.c | 12 ++++++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.48.1


