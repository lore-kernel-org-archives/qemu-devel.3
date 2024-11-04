Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030E6D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sO-0005UC-GM; Mon, 04 Nov 2024 12:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sL-0005S9-9o
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sH-0000Mq-Ao
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJilloWL9v8Cwa9SjhS4DIAn5GcNqvslur8KE0ijG6o=;
 b=X4xrpexINvbFFDL0da4aJr9LvX22u3f+YRIfoDPfMDs7LA8A9x/Z3hyr+ko3DigPh2Yebk
 /NNRI2U+sYtWaiVWQcNcEMyaRyhydFC93fhLd3+v6arpJRjo7Ejz1Wycnf7OjF7rLwQ3te
 2uQeFPdp9BfgBCCswIZvhoHInaXK508=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-0j2yRt_-OgCveL_uA15gkQ-1; Mon, 04 Nov 2024 12:28:19 -0500
X-MC-Unique: 0j2yRt_-OgCveL_uA15gkQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539eb3416cdso4699051e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741296; x=1731346096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJilloWL9v8Cwa9SjhS4DIAn5GcNqvslur8KE0ijG6o=;
 b=EkGAH5XITy13LYgqf0nNcwYG+/i2SS0volPvcNG8bxZhbbxIDDPbcrbZDnHUQzfFVw
 tAJQR0a6awqHAtt1C9t56yGh85QkkXH40WLRddsWQrDLhSXIb2/4FmIRnW9tOlktf9ya
 SqDuY+EIRT/nQ0+A8ffMu0mXaafjiWYAkhmlIKd1/sN/QVhtjNAcfRAZ6SfLgWwmzSZo
 FBqmRbibNPcK5WVosr9myyvFT4dLau2WXLgv3m8jffXD/4bDa+d70q+HWs+btOlv5/jB
 ng/KSQ98V3xMekC7r4eJBFLyGyBT+IH2pEtdzHPr8fdTrKW/u6EIU0kzbkNLZLJx0y4F
 uwcA==
X-Gm-Message-State: AOJu0YyvKIljqv2HH4WBzQJv2b1S52W+iODbcWaEVBp9loX/X25J+kn6
 6Ir49rmKF/31I8lGA1UfVFjYQzW6y+aFJWFOfowUL+hAoxx+4Oy2Gpc9/BCZsgXXRf4xgNc9PFj
 C50ubNBm183/uQBCXumA1B9fBsH1KUZPYRd1n/tR5+LLoA7yEKDhsHhiuhiycWU7NaJlTdWztJi
 ldzFFas0EIiGnLJFw1yY7fvhj311EmrUOWVTrG9dk=
X-Received: by 2002:a05:6512:6ca:b0:539:e88f:2398 with SMTP id
 2adb3069b0e04-53b34a19082mr15881384e87.39.1730741296178; 
 Mon, 04 Nov 2024 09:28:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5/G5lHJETWS/M2/T7irkPpf7iLkrl4EKM+E9y/4r8NpxspclCOoSsZkRoSxKxTKO27xMHtg==
X-Received: by 2002:a05:6512:6ca:b0:539:e88f:2398 with SMTP id
 2adb3069b0e04-53b34a19082mr15881347e87.39.1730741295631; 
 Mon, 04 Nov 2024 09:28:15 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d698055sm160636155e9.40.2024.11.04.09.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 24/40] rust/pl011: Use correct masks for IBRD and FBRD
Date: Mon,  4 Nov 2024 18:27:03 +0100
Message-ID: <20241104172721.180255-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Port fix from commit cd247eae16ab1b9ce97fd34c000c1b883feeda45
"hw/char/pl011: Use correct masks for IBRD and FBRD"

Related issue: <https://gitlab.com/qemu-project/qemu/-/issues/2610>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-9-051e7a25b978@linaro.org
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 98357db04e8..788b47203b1 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -19,10 +19,10 @@
 };
 
 /// Integer Baud Rate Divider, `UARTIBRD`
-const IBRD_MASK: u32 = 0x3f;
+const IBRD_MASK: u32 = 0xffff;
 
 /// Fractional Baud Rate Divider, `UARTFBRD`
-const FBRD_MASK: u32 = 0xffff;
+const FBRD_MASK: u32 = 0x3f;
 
 const DATA_BREAK: u32 = 1 << 10;
 
-- 
2.47.0


