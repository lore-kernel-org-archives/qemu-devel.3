Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5B7C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYidC-0002Wd-Df; Fri, 17 Jan 2025 04:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidB-0002W8-2L
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYid9-0003Ot-Kq
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sWErDgBgStcF4IIFiG2aKGTxEPfyMd9ElyExlJqlCM=;
 b=ONve/fNpDatv6lxUyE4GDQfHMxe6B9vWz2qSr1kNFK2VQfySrI59LTY9k678hvUaKvtLC8
 bFPzkhFFRWSRyEaR2ESzNKwPQTlt3ov3XLy/gDlCxSq67ek1DQcoeLjgxlJn9vPFYH0V94
 3rloVJZMbLYMqY4lh7Q9mRGRZIPFd80=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-QLcPmEuAMhO0hr0dj48pYQ-1; Fri, 17 Jan 2025 04:27:03 -0500
X-MC-Unique: QLcPmEuAMhO0hr0dj48pYQ-1
X-Mimecast-MFC-AGG-ID: QLcPmEuAMhO0hr0dj48pYQ
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa67855b3deso169525966b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106022; x=1737710822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1sWErDgBgStcF4IIFiG2aKGTxEPfyMd9ElyExlJqlCM=;
 b=lWzGGu+6H1TQULm1IXmAm0bV1Tuks6Nl0YVLFwuKuKuuGWQRf0jVRS/0R+7oXTTU9v
 CeOpJcfU+J7m2CRsoOwCeCvCxb5vSG7KMJnt6lvZKo9nFv6EngZ7zTrBsmcxycmOVMbZ
 /M+byU07RW+7xyJgq+UJfx2hmy43azyDDuhTWtzqKxUYZSvXY3YDU1rBXpbbgDU2Jui1
 apUXvZt26RLIQMQNNhRFTJBz6Ae0PN69rNlu17/o3x/F2MQZeBkYrzgJGc+LIkB1VlqR
 xsY3LOPMXLo8vfBD9biTMN2bbLshsq9YRf4yH2OdEHdMb2hlOwcjzFWWd8pxg2HYW2Wy
 tpiQ==
X-Gm-Message-State: AOJu0YwHXBxZ8pYXS7OB69PBrm3KS2d9DeTu69+2X0dYivFAdL7OhyrA
 43ArEVVj7Dv892g4gGkZsZAqzOAiF3Q943dCe3lg3vibeDyYn5+CK4gi89J1ymV3jzkPpCADP/n
 k6HVwyHafsbDvXKJgoIqLd0hqe08PeMv3IWdwFG02FrUIulU/3vEGWh+14dXRK2BybXlVZ05YYA
 AyDXh4XAGnYOETTekRrO5q/4dj2SoQdPuuc+O9Z9s=
X-Gm-Gg: ASbGncvEIZiTVbl2inxKzLtA/A2RhWCKCpUgtxX3gmNwRa2yIrfSt2sQA8dnXoEcpi1
 NDxUqtUNA7Z1cpsFtmZyBH7spdmMjpeBpDCmpMMziTEtZbKv7pc8xEdYQ4Cc8Go45ZEv0Z2rYgX
 d4AjhAu6DaQleJYl1nqT0n1gkiE4/DBfvZLgiFjRdgrtj2D+kdqLH/QGhjHudUT/LIZELSWxaxk
 2Zi7Mdb4DHDrQNUvJWK1FO99z9UoOS+AyZvbQaN981peVQBTVWKYTBe2I6z
X-Received: by 2002:a17:907:98b:b0:aa6:aa8a:9088 with SMTP id
 a640c23a62f3a-ab38b44d471mr186961466b.41.1737106021750; 
 Fri, 17 Jan 2025 01:27:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk6bG2UE+cUPVwBEJo1OkWk6DXnHkUE1Q7mZ9OfUwZKkowqMCw3iuNOMc2f8aHnNafDdTF0g==
X-Received: by 2002:a17:907:98b:b0:aa6:aa8a:9088 with SMTP id
 a640c23a62f3a-ab38b44d471mr186959466b.41.1737106021300; 
 Fri, 17 Jan 2025 01:27:01 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab398ac5879sm14112366b.162.2025.01.17.01.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:27:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 01/10] rust: pl011: remove unnecessary "extern crate"
Date: Fri, 17 Jan 2025 10:26:48 +0100
Message-ID: <20250117092657.1051233-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117092657.1051233-1-pbonzini@redhat.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/lib.rs | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index f30f9850ad4..d10f0805aac 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -25,10 +25,6 @@
 #![allow(clippy::upper_case_acronyms)]
 #![allow(clippy::result_unit_err)]
 
-extern crate bilge;
-extern crate bilge_impl;
-extern crate qemu_api;
-
 use qemu_api::c_str;
 
 pub mod device;
-- 
2.47.1


