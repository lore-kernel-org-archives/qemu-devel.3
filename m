Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000FDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 10:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwJxC-0005Ze-VS; Mon, 15 Apr 2024 06:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwJxC-0005Xw-8s
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwJxA-0003D1-O4
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713178368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=l+juIvxJLR81n7mcxw8RIhek+hBjbS5jCMqN29aOWCM=;
 b=XOqhBqmdmGTonnLpXKZq/fixtjjyQaH1/RGHDAg0BpAQ4yeKAmvSarWyY56Rd+HAa6iS3N
 PdJhCL6LM4IRzzj9te4RIELy600vXEZz+eh5ylngElGIuuEILVDlSF/DTcQNqc594F2/SI
 XTWKdd9JJY8hIOSgxEA+8lQxRQw1a8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-MBOTz9sENmmGD57IYRPaEw-1; Mon, 15 Apr 2024 06:52:46 -0400
X-MC-Unique: MBOTz9sENmmGD57IYRPaEw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4183b895ef1so3226645e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 03:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713178365; x=1713783165;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l+juIvxJLR81n7mcxw8RIhek+hBjbS5jCMqN29aOWCM=;
 b=WoCq9txOKLY8nSW5e0DFDzVAjNgkQUBPPRfVEz5kCxMBCRU5IY2De6Wk538Ty5XCGQ
 IX22e0NjH3IZTQGKIK4lSly8ehWVXebQ924V9IXq9lPXT7SdUWCbBDF/l6zDObx2Dyhu
 WbfUOx3PvkZynHjokWDmDNdbjUkqKxuaVM5fiiGQfrnTLu14KANH7mEIqRRk0Jsrw/XJ
 O/45LaqrU0Ubz9ZOkXGhiK4PE3skXo4kzT4le7+JriQ3cookbvt1J6OUgqTt285ii/vZ
 W3oQvwiQhQBj53aeUG9K3JJyfMSTKin5lmNoBJUmbbnzoDwDNdzkUFocmMLMEe++khce
 Go9Q==
X-Gm-Message-State: AOJu0Yw/L06yXEdCWZImJ1o7MF9zr91z5Jma1415ytIX3peERUEPnibu
 cQVXBmDaqUfIqTuq6HXzcvUwdSrdpjlwdDZWq1wYcp5OPonaXf6aCD2G2Op4au8ZKYpKoHU/DiY
 oeBAA+2oO1+BxBuTjgA88OOrR3qc8khDi3aCrrxD2IuIGfJkdW3znrS0nrHvXO7ELvbGAmCgcKl
 WenjCGyJxLyoZYB9OOm9n9yElQD5pm2g==
X-Received: by 2002:a05:600c:45cc:b0:416:902e:51ac with SMTP id
 s12-20020a05600c45cc00b00416902e51acmr7861973wmo.39.1713178365140; 
 Mon, 15 Apr 2024 03:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqXeZipBNRM54/gdXapXLyzXsgOjgOMRnS4K5VIf3gI7/OBolYnVSbdh+zddgp792+yjbIdw==
X-Received: by 2002:a05:600c:45cc:b0:416:902e:51ac with SMTP id
 s12-20020a05600c45cc00b00416902e51acmr7861949wmo.39.1713178364440; 
 Mon, 15 Apr 2024 03:52:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:a95b:a91:79d:72cd:ca48])
 by smtp.gmail.com with ESMTPSA id
 e20-20020a05600c4e5400b004186f1ed3a2sm2006194wmq.36.2024.04.15.03.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 03:52:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 06:52:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/1] virtio: bugfix
Message-ID: <cover.1713178348.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
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

The following changes since commit e1999904a960c33b68fedf26dfb7b8e00abab8f2:

  qdev-monitor: fix error message in find_device_state() (2024-04-09 02:31:33 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 2ce6cff94df2650c460f809e5ad263f1d22507c0:

  virtio-pci: fix use of a released vector (2024-04-15 06:50:44 -0400)

----------------------------------------------------------------
virtio: bugfix

A last minute fix for a use of a vector after it's released.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cindy Lu (1):
      virtio-pci: fix use of a released vector

 hw/virtio/virtio-pci.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)


