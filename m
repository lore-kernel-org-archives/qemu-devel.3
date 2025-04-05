Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B44DC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 10:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u10Pq-00076G-0b; Sat, 05 Apr 2025 06:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u10Po-00075f-2U
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 06:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u10Pk-0005rU-Qc
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 06:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743847570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XoeSoyyJ2F5espFfNi2p9yngvN7wZuvpwxpgTgAMVw8=;
 b=OBVpMBERKSJkmK3ebOiu0zbq2Pmria7kJ3RmSWeS7vlGe7I3b7Y7r/piP1xUV9ITHUBfMF
 1t6R35nSQiany+rTNKZsBPLXVD4deSpLTlIaJ5Rbm/HNRUwbPBcRBVaDAzew7zAA7fLF1c
 nuxWKvgevZS9hVWsaweGOrLk3qTZFWQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-U4nGLCsNN3uKMAho2jrH0w-1; Sat, 05 Apr 2025 06:06:07 -0400
X-MC-Unique: U4nGLCsNN3uKMAho2jrH0w-1
X-Mimecast-MFC-AGG-ID: U4nGLCsNN3uKMAho2jrH0w_1743847567
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d01024089so23544745e9.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 03:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743847566; x=1744452366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XoeSoyyJ2F5espFfNi2p9yngvN7wZuvpwxpgTgAMVw8=;
 b=GEvEt7FvJtnrZxphcIrClvMRDVQO1NkvAvlZwIOdKkzTx/NyRQnkO9MfFihJ9aDByH
 tKqVBcS8l9oIvsM9zx/4yH3JA1sD3HoebRezjqHqTIKv4hlxVouDTH5rBZpX/NhoP9f4
 THA0aDWhJKn7P1AR9r0pUPalOrYUZTCTeWZxUnC7/vIbb6QTuLeEAPYM6f9HnvgIxuOe
 fLCI34ikEmGns4z8qSC+dHkLrcDksqBQ6AjZdQbnWgsnxrCUZeWNsGh+pCmxUVv+Ije1
 AX7vmvbcR/R8zer63RLQpBfnFU1ScQTByY6o+wHWbt95xKTrBHQ9GNu35FQTSpb6viRq
 OYiw==
X-Gm-Message-State: AOJu0YxciIEvREa645/5JI8abPMEBc9CLHi/vMMqF6HlWbFeeXfANqWm
 TA9+z4rNYCMg64ahESfZyTZZSK1mqQSisISOqMdE5QarPGxc/MP3jA+pJ4tlb8lIgXzzntmKgqI
 wWVEBdZPrMyqEFG/aaEnHyHKwzrQZNEhWL/FqnQWeKOBuvrlhLdFVOSI9qcdGQIQD22+kp/tunO
 NEIb50fCiZeSnBvK9uUjUVH0+b5xG5TUmtloUO
X-Gm-Gg: ASbGncuc25IArNkW8u50VLsyT191AocehsRQco1556Ss6X1Wk9QUILbuXVBUPU1sxQv
 VZP59rV9RLe4xDKX9ZxkY0YJHbhns1QPF+ZFUX4hJHXVv+UrtYefzTrfLbDK5ttRNN3Lm7IN81R
 dasPyfaoDM63P0u2CjLhsUn3GVUM8kSOMPX8AmDmCr70f4gA//ZMYHYrn8NaCwB1qrBU54+seuc
 VLF/Y0d1pqADqi5fsuabycu1Hm2Afsg2mEXzwtMq3kgjc4nFWjhvGIIHtTrZ9wZb3dolwdAGoN9
 oQUC2ng4ujwmCk56Bg==
X-Received: by 2002:a05:600c:32a9:b0:43c:fd72:f039 with SMTP id
 5b1f17b1804b1-43ee0aa35bbmr14775225e9.11.1743847566046; 
 Sat, 05 Apr 2025 03:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9II0Z7ayPVeNsrJoPPMb6wgkFA4yqB/JtXUHDYD0K3rGBCCc1d/d4p47DNvpxLCQSd/XXhg==
X-Received: by 2002:a05:600c:32a9:b0:43c:fd72:f039 with SMTP id
 5b1f17b1804b1-43ee0aa35bbmr14775065e9.11.1743847565638; 
 Sat, 05 Apr 2025 03:06:05 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226959sm6321158f8f.82.2025.04.05.03.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 03:06:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH preview 0/3] rust: update build system for Meson 1.8.0
Date: Sat,  5 Apr 2025 12:06:00 +0200
Message-ID: <20250405100603.253421-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Meson 1.7.0 and 1.8.0 include improved support for Rust, namely:
* support for "objects" in Rust executables
* support for doctest targets

Use it to remove BQL-related hacks, fix --enable-modules --enable-rust
and also simplify the Meson logic for building the qemu-api crate
(which may help splitting the crate, too).

Meson also supports clippy and rustdoc but there are some bugs in the
prerelease.  I'll try to get them fixed before 1.8.0.

Paolo

Paolo Bonzini (3):
  rust: use "objects" for Rust executables as well
  rust: add qemu-api doctests to "meson test"
  rust: cell: remove support for running doctests with "cargo test --doc"

 docs/devel/rust.rst        |  2 --
 .gitlab-ci.d/buildtest.yml |  5 -----
 rust/qemu-api/meson.build  | 35 +++++++++++++++--------------------
 rust/qemu-api/src/cell.rs  | 22 +++++++++-------------
 4 files changed, 24 insertions(+), 40 deletions(-)

-- 
2.49.0


