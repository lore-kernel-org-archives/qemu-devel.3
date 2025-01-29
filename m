Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3022C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3ZV-0002vs-Jg; Wed, 29 Jan 2025 03:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td3ZT-0002uy-8W
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td3ZR-0006Vi-Mu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738139831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z39SMo5fMi5Iw581fDH9qIPvAtJD2ehQKZCfZcwRJGY=;
 b=UYKzWG6I7wr3Z8przUNuprD2djTUHcqgS1doJbSerDx3Jek4qhaKV7A/VKfgIi0R8FLz4R
 Ux2HbbtJDqcW8fK1is26JQcIQpiOztaXrx1c8XH01OwnIflNqKc+cIX6vJJ34fVpN4/YRg
 3D8KP7MN9v4AGl3duceUCi0BgyVm5X8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-FZ_xXo44ODe1f-n1zfJvYw-1; Wed, 29 Jan 2025 03:37:09 -0500
X-MC-Unique: FZ_xXo44ODe1f-n1zfJvYw-1
X-Mimecast-MFC-AGG-ID: FZ_xXo44ODe1f-n1zfJvYw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso45334325e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 00:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738139828; x=1738744628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z39SMo5fMi5Iw581fDH9qIPvAtJD2ehQKZCfZcwRJGY=;
 b=pRHqJS7lzb89C6Efj8ZGJhVeMH5V0hJzNcv5RNgSLPqWdH5OV65Bdu9rLTfA9LkJ21
 snNO3Ha82ds3qmCi3ei9OZjVOrGOMlSLgATYMRRW5ZRPzPRt7NWfeAkLs0VMqQ/oj2rH
 D9JJzcXzCWhn9p1RUEonVDzjJqxuTOUprKF9Z3Kyfl9732/gmQhKDxLFn4gAsgVmA5JG
 Tv5LEM1uHvIv6URAVRHPsA2O9cYapNX9aAg509z7aHrTqa7RPpuv6f89V1gVN0OhkaH5
 4DxfxyepA/Ydu2LTPQz4fWBs2LBbqm7UUdu17Vsoqw2RIgkeEdtGIXAR8DV3y7KxZgFp
 hQcQ==
X-Gm-Message-State: AOJu0YxbNUfqjcSmg75kOV391AwILk+Z2msfPj2YWYWnYLJWQwX/jAEQ
 le6rpkUMrzgnVFAa+vstoxoq0yAUGNACEcamnqN3F1ukRBZODgwk07IJ9dbMYob+qZkRrpWyJf7
 F3ShW304O0FzWzV9vncsFYVMIremIe8BvUipTJkcM3P1WlCWEwa871CPH6bT2gbA7F7ynhIMnQy
 xp8r8WP/EOxsR4TBkmgtUTmrguCa7ezWRwADr9mqA=
X-Gm-Gg: ASbGncsA9mxGNdbgpgDDMu34yfPyaOd9+YThLnnDOVqxakjXvCI2Phg9p5I3nzbqCVT
 cWH4CqDr8GTZsElpDIkmlZMogWhEq9vWVZDFPsgCgsK0W2eoypfL7lPuAYkln4t7/MBWelZHspc
 04GBPtCdvzrE4h7TOyD/UXDoXt9A4m8w9ndZWNXcL7k36JF2hcyL4XM3DO7UJ0YKeA5MybASmw1
 UHmIlnx6fJX81dhtc4xqm+bIMItcUuVmL0sYXoZFBVYk4yYlE7IDnxLieQvt69bsR1dIcFBjY2N
 hjhkBA==
X-Received: by 2002:a05:600c:1d83:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-438dc43540bmr17232275e9.30.1738139827699; 
 Wed, 29 Jan 2025 00:37:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRVnVACXbe2o5UFdWmFh32QWJzcSMoeuoo/SloXi5oWk7LyjTRgab9mbySxerp+6u4mScZCQ==
X-Received: by 2002:a05:600c:1d83:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-438dc43540bmr17231985e9.30.1738139827318; 
 Wed, 29 Jan 2025 00:37:07 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2ef08sm14586025e9.22.2025.01.29.00.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 00:37:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/2] rust: small cleanups to Cargo.toml files
Date: Wed, 29 Jan 2025 09:37:02 +0100
Message-ID: <20250129083705.1321407-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Remove duplicate or stale information, and add the rustc version to
help clippy produce good warnings.

Paolo

Paolo Bonzini (2):
  rust: remove unnecessary Cargo.toml metadata
  rust: include rust_version in Cargo.toml

 rust/hw/char/pl011/Cargo.toml          |  4 +---
 rust/hw/char/pl011/README.md           | 31 --------------------------
 rust/hw/char/pl011/src/device_class.rs |  1 -
 rust/hw/char/pl011/src/lib.rs          | 14 +++++-------
 rust/qemu-api-macros/Cargo.toml        |  4 +---
 rust/qemu-api-macros/README.md         |  1 -
 rust/qemu-api/Cargo.toml               |  1 +
 7 files changed, 9 insertions(+), 47 deletions(-)
 delete mode 100644 rust/hw/char/pl011/README.md
 delete mode 100644 rust/qemu-api-macros/README.md

-- 
2.48.1


