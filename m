Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C983FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnD-0007Dm-Df; Tue, 20 May 2025 07:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnA-00076y-Jb
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKn8-00031x-NA
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNAkHHLNPF5LdPic5qNP2qinaPDR6IQbUe7+qMe8esk=;
 b=CrWDsPOY6hz1bOAvrHI3uU79IcTjhEEz86/HpRkDjKp5Rh3+Wbw6p4UhXrz0DK0RdaYShG
 b+bS5GiUhxHhGX6SOuxs9oJLTr9PDs+u1UcrrbItU578SgZ3MTRNpKyva51m21RS/Wg0kH
 yVwIaZwm3UIhsZdSUKWbZrdXdDiTRsc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-oubZ6BtkPCqWS3_bbT1LHA-1; Tue, 20 May 2025 07:05:48 -0400
X-MC-Unique: oubZ6BtkPCqWS3_bbT1LHA-1
X-Mimecast-MFC-AGG-ID: oubZ6BtkPCqWS3_bbT1LHA_1747739147
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-601898cca80so3610898a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739145; x=1748343945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNAkHHLNPF5LdPic5qNP2qinaPDR6IQbUe7+qMe8esk=;
 b=w0co/sxmcqFBP8Fj1UXTj4Be3lcNkkRc1Wr+CGRqgYeeVOvLb3rudvCld/FuPidAq4
 9OMrhx0fQN7xtx0t+zpvtOQCckrZK2XSrk0nBfECncvEiN/sG0NkK+6GLyR9HnHanzn+
 WPD1WnmLZTBo3PhY0Wugm864C1URskOSAKcOtwmpeHFeJbYP7k4W9VbaWzZ7+wobdJ0b
 Ox9ZOo0eKuZbdzP4MV0OtGpusLeVKDKsmsoZO1WLhyK6qTH1akWvHVlCfo7Ae3u/AVd2
 P1LBkasrZNzjm93HuX/nJ+C/f/Vcl/QzuIbVLNYGPTIunhm7RRljd4Urlmwm4BrBC802
 ZxAg==
X-Gm-Message-State: AOJu0Yxb3+XGAYcpEfPDEqRMbx+Wl4UM2K+h1sUQTazCU6ptOU6tGta9
 ufE5dtPjORA/SwjmKQkStcc9PBQcuwMzZsjtlu/0xk7+E4wwriR0t4IRMx05scMVtIJ/QpkUcOU
 jQ6bkKDnTVJPaQitVOT8Obhnizb4atiDMowu9XheW/6geS2aV3A5O7V3cXg9OSc3pm1XMUfmSW2
 UZFvjehLhbtbfqD2ejEWSeGemUL/vfhxSqjjwh7IP8
X-Gm-Gg: ASbGnctA3gN9dusIim2uTFiXNaCDi4DD1Y7DqX12ksRfV5faQEGpZNyaa51cGrfUN44
 tpvXBsS+RyWjT1tXc7XalwE3zH1Iw1KP+uZ6d6e2wrZQsjmhOsTrUIR2gRyhSoqAPVQhbleNla+
 IcW3sjWJKMVMtJS1LD1dPU+nPQRmZOKu2cyv5os6S0ISXCEExCAMf5jf8mUMnIS4DPKZpPvLGPd
 UrbJ1pOb8fuU9W57K124zY1JrongVPq6wpj9kATO+LXo3Us8E0aRX/xQMyzEHWYxmI5O27yxDhp
 9myuvK4BK8GU4A==
X-Received: by 2002:a05:6402:1ed0:b0:602:53:cb06 with SMTP id
 4fb4d7f45d1cf-6020053ccacmr3736876a12.17.1747739145584; 
 Tue, 20 May 2025 04:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmVJw+ts25lQp/akB78FEBM/Ealhq/hrdgdSuCfLezF80kSeLSuXvV3XJPrSmpGC7kT4s5rw==
X-Received: by 2002:a05:6402:1ed0:b0:602:53:cb06 with SMTP id
 4fb4d7f45d1cf-6020053ccacmr3736826a12.17.1747739145004; 
 Tue, 20 May 2025 04:05:45 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ae39175sm7042840a12.69.2025.05.20.04.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 07/35] qapi/misc-target: Fix the doc related SGXEPCSection
Date: Tue, 20 May 2025 13:05:02 +0200
Message-ID: <20250520110530.366202-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

From: Zhao Liu <zhao1.liu@intel.com>

The "sections" field of SGXInfo is used to gather EPC section
information for both the guest and the host. Therefore, delete the "for
guest" limitation.

Additionally, avoid the abbreviation "info" and use "information"
instead. And for SGXEPCSection, delete the redundant word "info".

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20250513143131.2008078-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/misc-target.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 6b3c9d8bd58..6814708972d 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -321,7 +321,7 @@
 ##
 # @SgxEpcSection:
 #
-# Information about intel SGX EPC section info
+# Information about intel SGX EPC section
 #
 # @node: the numa node
 #
@@ -346,7 +346,7 @@
 #
 # @flc: true if FLC is supported
 #
-# @sections: The EPC sections info for guest (Since: 7.0)
+# @sections: The EPC sections information (Since: 7.0)
 #
 # Since: 6.2
 ##
-- 
2.49.0


