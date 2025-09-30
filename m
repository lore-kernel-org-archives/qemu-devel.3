Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB77FCCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Z2N-0002bc-Oh; Tue, 30 Sep 2025 08:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3Z1s-0002YT-34
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3Z1n-0002sd-6I
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759233614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9cRZKuLYf1PeX3kptJkawumw9y9xmtGwH/7o1mOtoO4=;
 b=OXMpv3GnWJYA1og3x5+EPCc3j1Hs7hvuf7zpNeP078ruNhIuOJ+3YUJe2wccapDFOP9ulX
 iZXNQgJ10ZkPH9UOwIeuZ3foPHm6lXiHJOAM9mZLmJFViqbF/PPYGBGV2cIHtg9QzWhGSa
 +dE2uzn8tVB2XVbNHzLUmcFy/DBevLk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Z0IY5lHlNvaMTsm1NGs9Ow-1; Tue, 30 Sep 2025 08:00:13 -0400
X-MC-Unique: Z0IY5lHlNvaMTsm1NGs9Ow-1
X-Mimecast-MFC-AGG-ID: Z0IY5lHlNvaMTsm1NGs9Ow_1759233612
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-633009e440aso5634031a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 05:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759233611; x=1759838411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9cRZKuLYf1PeX3kptJkawumw9y9xmtGwH/7o1mOtoO4=;
 b=big/IRDS1al4VyWi0nB14zeLZP6rB4VWzB86IQ2uB87Zvs6tMJ3DOL/K7Vcl/zUs1u
 7rUaUW1Ag/NBFNS1qbb4EETU8HwSAbnkWSdDsdH5Suf+r21lvkkjesNkCFOPi4eb3hwt
 R/fsDU1R55idqdTdkYMs/zAH+oVoe728AXQPIne9VTG+8xgw7nHHpCPUT4x+/5NefMXe
 17W0OblVzLEb5l1D6WulblRQ4o4m372K4QwBDgbS/U4U97FuoGW64bVgJqdUDVYcqej0
 V4mrG0dOVYm+oINpnNr89D+E07tI30T5HKB6a1kZ86+7yvDUy3TikIy4fhvaemO+lnqg
 Euzw==
X-Gm-Message-State: AOJu0Yypr6NCgJ7wW39/BJumQKj/unTeAUYrpZ83r28aXiiDG+WuMYA5
 3L859PRHTRkA5GfBd4vflmlfMOF9pQpFzA9/SV6xweQmAxhy2HTrZtJtOXCPlcyfBOc6OcSnBIG
 SdJHnz9+SgkTcSe4K6NoMJn/Kmxq96jJweLFPZjjKCUHcLObpjazbja8v1UQdwX+wgAxACDaosr
 75E5eBCYRSDzBh28PqrW2bmNAI5HALixlte4Km4ceh
X-Gm-Gg: ASbGnculf4jlhYzko0sE2tQ8KVlosS0EKQw1F2WhBENXYvxil0hv9Ce7fWiZTG4XFU1
 FoKPLtYpmM9qOABimQPEATVp1QOHdOU6uywYnamFZEtDX2exMddl/XYmd5WoZGzQvVlWzxJyZrH
 C0eIG6+14GJg8ayKK7qeIWhrFlFURE6YIULGAN1M+TJ80fTiNxzEItShDAYVo1nLX3HO768YYqL
 iKWp3khZtOJF/zydXyR+e0RoF6x8xXRVNXgOlPavdm0gii1jTffjkE/tuYru32EWzr3KqEN51Y6
 p0y4nNyL2U5fzP4bKuUMxgrmZmkvH5fQufX1E/chUotG6QiavjHoaRBHqfTxdioJYGz0ckAMyNC
 RY1ZOPanbfYW9MStwwWerERMn2iZS3x6vGyzkOVjTptQIBSFy5aw=
X-Received: by 2002:a05:6402:278d:b0:633:feba:4756 with SMTP id
 4fb4d7f45d1cf-6365af1a3ddmr4402907a12.12.1759233610840; 
 Tue, 30 Sep 2025 05:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjOaenNlHHDq9jIg/F4D+8KKBtXNwbIfWtSXj7ZXcenUTEz66o6MRefduo4uK2bGBT3SsgTA==
X-Received: by 2002:a05:6402:278d:b0:633:feba:4756 with SMTP id
 4fb4d7f45d1cf-6365af1a3ddmr4402860a12.12.1759233610421; 
 Tue, 30 Sep 2025 05:00:10 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3ae2cb3sm9714991a12.27.2025.09.30.05.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 05:00:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] subprojects: Remove version number from .gitignore
Date: Tue, 30 Sep 2025 14:00:08 +0200
Message-ID: <20250930120008.700432-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Get rid of all the version numbers, and use wildcard matches instead,
because peopl will repeatedly forgot to change these versions.

Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/.gitignore | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 58a29f01204..0b5d9634094 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -6,21 +6,21 @@
 /keycodemapdb
 /libvfio-user
 /slirp
-/anyhow-1.0.98
-/arbitrary-int-1.2.7
-/attrs-0.2.9
-/bilge-0.2.0
-/bilge-impl-0.2.0
-/either-1.12.0
-/foreign-0.3.1
-/itertools-0.11.0
-/libc-0.2.162
-/proc-macro-error-1.0.4
-/proc-macro-error-attr-1.0.4
-/proc-macro2-1.0.95
-/quote-1.0.36
-/syn-2.0.66
-/unicode-ident-1.0.12
+/anyhow-*
+/arbitrary-int-*
+/attrs-*
+/bilge-*
+/bilge-impl-*
+/either-*
+/foreign-*
+/itertools-*
+/libc-*
+/proc-macro-error-*
+/proc-macro-error-attr-*
+/proc-macro*
+/quote-*
+/syn-*
+/unicode-ident-*
 
 # Workaround for Meson v1.9.0 https://github.com/mesonbuild/meson/issues/14948
 /.wraplock
-- 
2.51.0


