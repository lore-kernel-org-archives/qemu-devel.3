Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2DFC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFJ-00044P-Du; Tue, 06 May 2025 11:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKF4-0003ou-Kh
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKF0-0001yP-NM
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKOv1v024B92HottiDhCQaai+VOGIVTfrRTpHkpYUUo=;
 b=Uhae7reCUCAR+v/8//JdtKJbIT6q/28giFaSSNra1Gyvw5nt1REfpj+ScV+wcp1EpPv0p2
 GBByX2hAV+xRPXDSU7ZXqcD0bNaRfX3tFrHty+lqvqZHJXWMfb5ks+0ZIenaAVJFoHeNYM
 etEp0JXQhMGhxO9fWVelNB3MyLT30/w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-PQ84Urc-MdWaRFpFWq4zsw-1; Tue, 06 May 2025 11:29:52 -0400
X-MC-Unique: PQ84Urc-MdWaRFpFWq4zsw-1
X-Mimecast-MFC-AGG-ID: PQ84Urc-MdWaRFpFWq4zsw_1746545392
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cec217977so34610605e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545391; x=1747150191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKOv1v024B92HottiDhCQaai+VOGIVTfrRTpHkpYUUo=;
 b=kA4RtzBwmbpBVGgM1pgb/iXdOZiB3LbD+BfFTruW1pHoC6by6e/OU/t7dmNkTbpoew
 WFlJKHxdHpUsEwt2rEKgVMEcmUpE24SjalAVygRGvLyTAXE2R8hXX84uTrFv4qIZf2sE
 Qea+L2dmjlgYQTF2jfV+KttRYlNLZ/IznofrIYJxQ7JGN3Ui8Q8T3t/DfuS+W2P6tEZr
 FVj4Mb2U2ryWe/vNZFsUlHrrCRE6ykrQwSVdG0aZf82wJOE1IhFroaQDMx+00UCnuKhM
 BdZkhHLFGI4l1d109rweioo5IChn6x26nerOswp9fHWP1278TMj+uQGt4iecQY4fvdJF
 5eBw==
X-Gm-Message-State: AOJu0YxCFTKSlthJmfU4apdkZbPWTHQ72qOv7O7vGDN409IeqHGeKtH0
 I/9WTJNf8+Pe1sVTCrHO5SDY/3WjcjlBpcfQvi99bnPmXE8OgSc1FHcmIRnabGofDWpqvH7wDxh
 B2p6hCuiF2TSxEzAN+C1PhPdnAsP3gnHcmfK0YoZ7MlnUMbYaHvhQ29UwBPmx9BzCV5NVKPOgqx
 UEp6REXAJ3/4jsYN/eWu98I2TbUCQiIsSY6Bul
X-Gm-Gg: ASbGnct6LclDZpmoTOsd7eg+yqL5YOok/T5L+ejcxo5La/a7VjFus+7F52OATOLy1j4
 C8PjRmbghZJTrnkeSNcpy+UNKppoV8waCtaWe8Rf+AXfLqUuDCvwf9ThiYrV69GIkdGe68ATPRC
 fewRZmsjCe8HEvP8Di6/tvmU7hJ6hEcL5Y0xxqid4j1/4C4OhbkKDBT0XBO/tFLdSL7/tbI2Nyf
 kgLr+j1vrJX28s7s4glTM5uDKsbq1wwgslK5YsU4OjpMJd8z0welUR/VNVF6ROzPfwuGHjjuvhM
 HwU2X1Eaj/kH8gA=
X-Received: by 2002:a05:600c:528e:b0:43d:10c:2f60 with SMTP id
 5b1f17b1804b1-441c491fcabmr99445755e9.24.1746545390711; 
 Tue, 06 May 2025 08:29:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ5XGnR5VaaEyG02j8fUQYIjoPpUslJG/+FPfKuPzmkyKxhN8nCDrwnj2/rM9DtrUrFgmJng==
X-Received: by 2002:a05:600c:528e:b0:43d:10c:2f60 with SMTP id
 5b1f17b1804b1-441c491fcabmr99445575e9.24.1746545390359; 
 Tue, 06 May 2025 08:29:50 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af2922sm216834035e9.17.2025.05.06.08.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 11/30] docs: rust: update for newer minimum supported version
Date: Tue,  6 May 2025 17:29:06 +0200
Message-ID: <20250506152927.222671-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Remove leftover notes for Rust changes between 1.63.0 and 1.77.0.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 557cee72f39..4de86375021 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -71,16 +71,9 @@ Building Rust code with ``--enable-modules`` is not supported yet.
 Supported tools
 '''''''''''''''
 
-QEMU supports rustc version 1.63.0 and newer.  Notably, the following features
+QEMU supports rustc version 1.77.0 and newer.  Notably, the following features
 are missing:
 
-* Generic Associated Types (1.65.0)
-
-* ``CStr::from_bytes_with_nul()`` as a ``const`` function (1.72.0).
-
-* "Return position ``impl Trait`` in Traits" (1.75.0, blocker for including
-  the pinned-init create).
-
 * inline const expression (stable in 1.79.0), currently worked around with
   associated constants in the ``FnCall`` trait.
 
@@ -105,12 +98,6 @@ are missing:
 
 __ https://github.com/rust-lang/rust/pull/125258
 
-It is expected that QEMU will advance its minimum supported version of
-rustc to 1.77.0 as soon as possible; as of January 2025, blockers
-for that right now are Debian bookworm and 32-bit MIPS processors.
-This unfortunately means that references to statics in constants will
-remain an issue.
-
 QEMU also supports version 0.60.x of bindgen, which is missing option
 ``--generate-cstr``.  This option requires version 0.66.x and will
 be adopted as soon as supporting these older versions is not necessary
-- 
2.49.0


