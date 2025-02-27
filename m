Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C86C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnh1a-0008T4-2w; Thu, 27 Feb 2025 11:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnh19-0008Ie-Vh
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnh17-0007n6-EZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740674743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wVAr7MFEIkeCBVn/8Zyjx311WrTsE+8/auwtseqk9Kg=;
 b=g0Ju41cDjPIlt64wakq1Ml02QzN9cZwmL/n5BanN5W4gSB/XzGEZsCzT8RrYBaRVVTbtEC
 MYjQk3lTeW76V7Gn/RtZDsVr1Qp4VAXuDnOJt5cR8dmtvY9YSj5cA+ML4+YTUDarVmn/KI
 FpauMVVSIjXV8ORjafNAw0Emft6BwM0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-eR0JhCi-OTCcLza678Mo5Q-1; Thu, 27 Feb 2025 11:45:41 -0500
X-MC-Unique: eR0JhCi-OTCcLza678Mo5Q-1
X-Mimecast-MFC-AGG-ID: eR0JhCi-OTCcLza678Mo5Q_1740674740
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abba6d94ae4so145155766b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674740; x=1741279540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wVAr7MFEIkeCBVn/8Zyjx311WrTsE+8/auwtseqk9Kg=;
 b=J3eqbjONUD00PVkLPxw6jEx4g2qpitAGMnKHHbzFgaO5cZvLNj+umz9TsCHg0G/86Q
 WVkroJEpWCgR8BKYaL8smWG7FFq+s4w8MukbUtQabr/QhGvp1U5jnaY8zeXJAmXlNw6R
 8bfhTiggnMuAidYDnmC/TXWblzcS2HLb0fSEFmga8+7QWN8ryjZPJswFVQxjZftBnhny
 oFlJC5EFD2SLr/hkQylRVq8MkYoN0EICv+pqyZGiOS5lU3Tf+Vx4olp+ex7asCsa5U8p
 hJxvCIQ+fFiywGwVWtbNpSXLwwj/9YjbYOhG1HlYSvLNhp3+kq1+4f06WURTpD2h7Dtk
 nbTg==
X-Gm-Message-State: AOJu0Ywfb2zKwrIfTGYf2PD3bGo2h3VFYksNhZjyBa+1vYQGikX2w73J
 QR0Re9LLtBjMyO27ysYfEVM9IRYYc0ABevX1olEO7bh9B89nW9Qi0/S6Rk+gZ+vpB40uDt0/NF6
 DsaZS/3QM9bOhwBRLWDOZ4zm+ziRW8TSnU0fVrUCYLbh3auGp98u0nx2UDNmeRZdfTaZ7iMZFyd
 +KYQLZf0M2l1I1E8pIyLUH9ZgClJkmn+LK8+t7cRw=
X-Gm-Gg: ASbGnctaJl3mEZUOZOGUPmUALebMNAwOZXHqvL+02aAlg47DEZOKWRVfTAdfpQ40p3R
 NY7DgDm9LIuy7h+vGCoush9puoe41FIX/pUG8HtFy6bAGX4FUhTYWG+bZHqzp+zGMBJ92rRnljc
 Td0TcZITGMLcwzQKo01UMYcLbq6g8rM6RZddFJQdB3h6paF+LHlGdH1ppNLFotTvVYS3zHr0Rbn
 22HAA0oeYhm+5QEDScYmRUSH1S49xWlV27GGAYhNHeCpzz6TkRLvaBAQpYFN6I3msWD5u2E4Sx5
 w4bHHnlKZlztbyxtbw==
X-Received: by 2002:a17:906:c14c:b0:ab6:dbd2:df78 with SMTP id
 a640c23a62f3a-abf265d5f40mr10043066b.35.1740674740080; 
 Thu, 27 Feb 2025 08:45:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVICs7YosIKdvQcANivRuQITr8x9SCFmOjcIuOagDNwYB2/tynqNs9teU8KdaRali8adqQEg==
X-Received: by 2002:a17:906:c14c:b0:ab6:dbd2:df78 with SMTP id
 a640c23a62f3a-abf265d5f40mr10040766b.35.1740674739704; 
 Thu, 27 Feb 2025 08:45:39 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c755d22sm146958166b.129.2025.02.27.08.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:45:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/5] rust: pl011 cleanups + chardev bindings
Date: Thu, 27 Feb 2025 17:45:29 +0100
Message-ID: <20250227164538.814576-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

With this series, the only remaining use of unsafe is for vmstate's post
load callback, which is small and self contained.  All functionality
used by pl011 and HPET devices are wrapped in Rust APIs, so they look
like what a "real" from-scratch Rust device would be.

Patch 2 is best reviewed with "git diff -b --color-moved" or similar.

Paolo


Paolo Bonzini (5):
  rust: chardev: provide basic bindings to character devices
  rust: pl011: move register definitions out of lib.rs
  rust: pl011: clean up visibilities
  rust: pl011: switch to safe chardev operation
  rust: pl011: pass around registers::Data

 rust/hw/char/pl011/src/device.rs    | 146 +++-----
 rust/hw/char/pl011/src/lib.rs       | 509 +---------------------------
 rust/hw/char/pl011/src/registers.rs | 507 +++++++++++++++++++++++++++
 rust/qemu-api/meson.build           |  17 +-
 rust/qemu-api/src/chardev.rs        | 237 ++++++++++++-
 rust/qemu-api/src/zeroable.rs       |   1 +
 6 files changed, 800 insertions(+), 617 deletions(-)
 create mode 100644 rust/hw/char/pl011/src/registers.rs

-- 
2.48.1


