Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD56C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZ6-0002FW-6E; Sun, 01 Jun 2025 11:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZ3-0002BN-HZ
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZ1-0004dv-0Z
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQRWf5Ul3qPwNaJtVxpKZm3Q2OWK1fGLw32r1f6wfNc=;
 b=GOsB7Mg5+8m5cz0L3vtltjsQj44QuM1ybQH1T0gGysL11JvRe1kjebauHtId6qs3GyxMal
 ydZ1xRMjOKCeLPsJbgW33ym6ZUJ2rJXrOmvC4EvkfjPMzsZcjVhccBNZfu/etGhpSGfWyq
 W663ehKhWcqRyZhHb6sqmHXE86Wcw1A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-Ei3gKRa9NiOv9Ci4NBxQYw-1; Sun, 01 Jun 2025 11:25:29 -0400
X-MC-Unique: Ei3gKRa9NiOv9Ci4NBxQYw-1
X-Mimecast-MFC-AGG-ID: Ei3gKRa9NiOv9Ci4NBxQYw_1748791528
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a5058f9ef4so127840f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791527; x=1749396327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQRWf5Ul3qPwNaJtVxpKZm3Q2OWK1fGLw32r1f6wfNc=;
 b=uNV6IHk3c+3SE0QT0ruquXaXsq33Ol3G/2Ik1nbMEysCLAnHFAkJbklzSvwsieIStM
 JQlapp/YgsTP0Es4+OqV65m1xBoA40rKvx0IuqYYLnEM/UwyIGHVNpRwmn3ToMC3UWKq
 9D6TRIoUXttmRcxvx0oPxv70nQQO5BHymG58YsfogOGEh3eJWSjfLpGXsRB0ZDEp/nIZ
 Z1L8wabvYVqv/dANzmWbRqVXctxKAZIACk1/Lcivk08Om4sYRS3K7aSn1ynWvKPK2/GG
 tEnkRmJElPnjIPdKc4Uerj3yq6vjFO6eLM5GcOQwil7CTPTySEbmP+HQowsC7KYgJ+Qh
 Z/vQ==
X-Gm-Message-State: AOJu0YyF9K/PTIEI3Gol1YoXuulP5DMmeDzhafEmVwZi+B00ylQgaLuP
 DEkAuVWz6HYFSV9citE57bWKoNGuNgDFWh5RJ+IUcpfstfodjUnMVvYUeX1iDmvvPUsyvweANeC
 i5Ll+U3yRYvWhvoi1arOwiWV3ZjAn7ZSo0L5I3s8JtQZJ4jDR4TDGCbXMgkokOjI7I4iYUT/U+o
 B9+ch8jZWs/wH3ur4JKmFfsyoqOYut799I+w==
X-Gm-Gg: ASbGnctwk8EOU4D1rwzDl6BrlruQr/SIdOmEgoLmNv9hWNMT+aiCc7MWer8lMqi7JCQ
 WN4SjwCu90KQWPgqRXvfiYzShgD2I+qfRR1MeNpoyEqwqm/USou5X5DOU1sgFxq27i0jgQs/RtT
 esNq9n8/CGCvLuhMM75O5roqyQMmXv62fngx7CPLV8JRU1sv2peac9uZb5lsmSvUL23nnJullKB
 IQR7nHRvRXPVWQnzVKM7ETCG+UMK5svL9LZKja7aB11VcGKu1BjDmSGi98DUv9mwnBWsOoMyQJo
 Qa3LuQ==
X-Received: by 2002:a05:6000:1788:b0:3a4:edf5:b942 with SMTP id
 ffacd0b85a97d-3a4f7a7d77emr8203903f8f.57.1748791527113; 
 Sun, 01 Jun 2025 08:25:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElMhrqt7VRUby1hRbAFXBiLlWDV8xe+ITxpVUtDEi17M593cYxhE+R8g/SayV/14us8F1xrA==
X-Received: by 2002:a05:6000:1788:b0:3a4:edf5:b942 with SMTP id
 ffacd0b85a97d-3a4f7a7d77emr8203879f8f.57.1748791526528; 
 Sun, 01 Jun 2025 08:25:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00971d9sm11994837f8f.61.2025.06.01.08.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:24 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 16/31] tests/data/uefi-boot-images: Add ISO image for
 LoongArch system
Message-ID: <0265723eba8a612d8a94d190cef988cf8d616862.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

To test ACPI tables, edk2 needs to be booted with a disk image having
EFI partition. This image is created using UefiTestToolsPkg.

The image is generated with the following command:
  make -f tests/uefi-test-tools/Makefile

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20250520130158.767083-3-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 .../bios-tables-test.loongarch64.iso.qcow2      | Bin 0 -> 12800 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2

diff --git a/tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2 b/tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..18daee0c52fcc703a0645dbcdc598aa1f101d96b
GIT binary patch
literal 12800
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

literal 0
HcmV?d00001

-- 
MST


