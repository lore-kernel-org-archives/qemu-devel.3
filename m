Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0644C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYidB-0002WG-BO; Fri, 17 Jan 2025 04:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYid9-0002VG-5d
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYid7-0003O7-03
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b486P7QDYUT1skG7NsQHZqf9CNEnvk1cpaVCEyko9DU=;
 b=KGfGtmlATX4wxq8n+ARC863kGJbLGIn47+le1WuBbeogJtfOSpDndBvJ75y94cLVbDS92y
 PgC1NAIMAl3tCilyo23Hbvcf7trFXTpg5qP7tJVPoKUzf+FX/+VwNwFzF5Urxzpzy9h5RQ
 AWt1xCcMdGgIz3dpS/d4gHKoCFOI5IE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-5DRFyNMuOxKv_k6C7CXHZQ-1; Fri, 17 Jan 2025 04:27:01 -0500
X-MC-Unique: 5DRFyNMuOxKv_k6C7CXHZQ-1
X-Mimecast-MFC-AGG-ID: 5DRFyNMuOxKv_k6C7CXHZQ
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa6a87f324cso210624066b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106019; x=1737710819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b486P7QDYUT1skG7NsQHZqf9CNEnvk1cpaVCEyko9DU=;
 b=csAf1p8FlHLDcUvlAu8KqXVIF0+QYEGPT7hFBirZJpFnqgMIWNcaaxLjTS2ViR1DHz
 T3YmrmeYxBRyB6N6jCLfxfYHbTF+dV8fpm08GbmCNW+oh6WEx72vUKvVxvj7q09SbIVR
 lRM3+a7S5RgyN2Pr/ZcN8LXFqwo0C0Jq+4iQdmoj/GLAUqSPwf/bWmA0P9alh+ZEoFvs
 5dr1N/xGI9QBYJsdiy4grgwgS6oXVMmKB/lgQk+7GyQMVBsnQn6am1PRV2YHtnvMDi9x
 J9B5CEqS+oo1PpVXRz5MXJNGBi8JvqNNAjo5N9buiAW8zpfvHnMk32Dtn1sx8PeFPu6N
 djHw==
X-Gm-Message-State: AOJu0YxZW6zjCQO0jIU3dIGPtG7G81HTQYeug8HwXGQKo8GIMe7bilOc
 blB/Gkct/5+SasdjB/O5yXISleaFen3U6qaN7DmLDNfX0+4ocvrwHqKOI7UkXMhkfg/wUCb/lMG
 B72MwlYai0IrydEOIyXvd1Dh8OV3m1vgec0JTmPuCB6yzUebhgFNR02gQiG0n1DU90luSzmfVBU
 28MyGUZ87uMVjYpXiv0HP03p7tU4vtz5LhZJbZNDs=
X-Gm-Gg: ASbGnctBY9WXvPFX3ggzn6QtL1w+kWLnZOwAylhDLLTMjD0fUlrVeM5oE4+8VHlXlnK
 akCR0CkzxCvffwAQdDC8UBUTMXGEV3cZrysYFOEN2OaEIDfIqp6BewTSlR1RjkO8iIwDQQDD34R
 kUqlxd38Ae9I8+7c/h0xRvn6AMe7qviEEI5+4w4VgGYePqulc3cD6LNVGf2S7hNCdacNoBRuV5B
 YLXZu2M14FiYa47/YxHoxEoz9N8bOYwWRmG7544UHUBIauD/GPb0ZosOZls
X-Received: by 2002:a17:907:9803:b0:ab3:47ce:7931 with SMTP id
 a640c23a62f3a-ab38b42ad35mr158066466b.44.1737106019564; 
 Fri, 17 Jan 2025 01:26:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEymVy78kMxXiofVYv+pkVdNjWFf53m+NmdS3yabEnhJIOFVdAosEYy9sJMWX42n/UbGs7NOg==
X-Received: by 2002:a17:907:9803:b0:ab3:47ce:7931 with SMTP id
 a640c23a62f3a-ab38b42ad35mr158065066b.44.1737106019032; 
 Fri, 17 Jan 2025 01:26:59 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce109asm141088566b.51.2025.01.17.01.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:26:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 00/10] rust: pl011: correctly use interior mutability
Date: Fri, 17 Jan 2025 10:26:47 +0100
Message-ID: <20250117092657.1051233-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

QOM devices are aliased from the moment that they are added to the
QOM tree, and therefore must not use &mut.  This has been a known
issue since the beginning of the Rust in QEMU project, and since
then a solution was developed in the form of BqlCell and BqlRefCell.

This series moves the MMIO code and registers from PL011State to
a new struct PL011Registers, which is wrapped with BqlRefCell.
This also allows to remove device-specific code from the device's
MemoryRegionOps callbacks, paving the way for MemoryRegionOps
bindings.

I am making this series a prerequisite to the usage of Resettable,
because it allows reset to reset take a shared reference to the
device.  Thus the Resettable implementation will not have to
temporarily take a mut reference.

Paolo


Paolo Bonzini (10):
  rust: pl011: remove unnecessary "extern crate"
  rust: pl011: hide unnecessarily "pub" items from outside pl011::device
  rust: pl011: extract conversion to RegisterOffset
  rust: pl011: extract CharBackend receive logic into a separate function
  rust: pl011: pull interrupt updates out of read/write ops
  rust: pl011: extract PL011Registers
  rust: pl011: wrap registers with BqlRefCell
  rust: pl011: remove duplicate definitions
  rust: pl011: pull device-specific code out of MemoryRegionOps callbacks
  rust: qdev: make reset take a shared reference

 rust/hw/char/pl011/src/device.rs       | 458 ++++++++++++++-----------
 rust/hw/char/pl011/src/device_class.rs |  52 +--
 rust/hw/char/pl011/src/lib.rs          |  61 ++--
 rust/hw/char/pl011/src/memory_ops.rs   |  23 +-
 rust/qemu-api/src/qdev.rs              |   2 +-
 5 files changed, 314 insertions(+), 282 deletions(-)

-- 
2.47.1


