Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ACFC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmGN-0006kE-C4; Fri, 02 May 2025 05:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAmGL-0006gL-DI
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAmGI-0004xi-VH
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746176449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/IRAGOm/TB6BHj4C+HObeEmG8st+nADkj/KyPgOtSG4=;
 b=Keg7xSM2wKzvWG+a1ZspToX54cxKm0Bkck4sYc9O8oMIEfXPY2M+TGnuokP/ypI5O+5SoN
 vdZ9ZtFBAUrM+U8b8i/oPPw9ijxPHPO5ueOsxk17k8h8IW89fR3AgzN4eqKLcMbI/ERfTC
 VOtM+m5oyaAlfZ2Qt6hRR46+03txxHI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-08U9FHOYOSWgP0zc0_px0g-1; Fri, 02 May 2025 05:00:47 -0400
X-MC-Unique: 08U9FHOYOSWgP0zc0_px0g-1
X-Mimecast-MFC-AGG-ID: 08U9FHOYOSWgP0zc0_px0g_1746176447
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso11394415e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 02:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746176446; x=1746781246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/IRAGOm/TB6BHj4C+HObeEmG8st+nADkj/KyPgOtSG4=;
 b=YcIsqa9v9ucNZFoFWIjn2AlCLTAkpzP0YB0b3sdANveinPzorEPDstNs/481CsCrlw
 fuuObLmAQ0rn5C6kztCdIM0EMsmxplaEthD84045ehK6t2rPtkMwENVtiLhULHf7tlyi
 lcRpznv9o2Up9QDi5hGQH7y7AQf3S0k2iaFx9dAd/4ZmYeIMMiu4g56znDQh2t3ckRlu
 nlD8HYH4SeVQ/inPwlg4wNjpuehZNjSDe9vPRkQn86wz5/dnSoSPFU8Mm9nwjpZw85Y3
 /jDZ7dNVIoKYgoiLfp/lqJ4V0nARnKPqx7+UIvO7Zw5Ll3X/ywjc1n4yFNTjF4m2aUI3
 3Zlw==
X-Gm-Message-State: AOJu0Yy945qRiQMS0CRIbfRPqADzdA9u+FGWMaou+h2BxKk/hD1zb7yj
 4C0u6J8kHAhm4kkaS/PkIsoz70Rexb0/6LDCAhURAXRZmM0b7+eqXKBTysNIxHDfPMNCFjekjcs
 XNSG7omlVtATKXuFsiMNNnXobRYziNBSr+tw8YpzrT9yT77kMcPQY4sWO+rE+N4clOejFhr29t7
 MoHrvYluKGg3FF+q1slOlpMynBXPqRRikSg1NU
X-Gm-Gg: ASbGncvwhv4G4+RIHFBFxaLHEbLwa0MCte6WLQpMG2roxmggiSoiR2UD4mSWG9KaIHu
 FouUwB7WhBCVLzHdQB6GjimsP1l3XAWqju89Y6AGrCnU61blSWDIlLknjdqEjyd1SqSiEMgA5n2
 6oOYuv4D8x4IRGmT2XS4vLQrZ+gwRvZCsD5ZVgJ2ANJg1QEmzsM13lEmI497S0rKY9IwwCg6k34
 0/KS2Q/Ypsceyyn1KM9GcPxqH/r0E1TytwtYEHBauC6mLWfqAm0z6c803QfvuIIpedeUv2vfRR6
 o5wDdGbwBWfz7EQ=
X-Received: by 2002:a05:600c:154a:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-441bbf38455mr16298385e9.31.1746176446316; 
 Fri, 02 May 2025 02:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy+VAbyM03A/TTCR54KVh9IdcpMhkvNlc75gIY0WGIPDXj1VG5S5Yxpb2rfREeTwbRmCiwNw==
X-Received: by 2002:a05:600c:154a:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-441bbf38455mr16298005e9.31.1746176445901; 
 Fri, 02 May 2025 02:00:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b10013sm1540043f8f.65.2025.05.02.02.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 02:00:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 0/2] rust: vmstate: improvements to varray handling
Date: Fri,  2 May 2025 11:00:42 +0200
Message-ID: <20250502090044.85557-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

Small improvements to vmstate.  The second patch is a simpler replacement
for https://lists.nongnu.org/archive/html/qemu-rust/2025-04/msg00018.html,
and is needed for HPET migration support.

I will include the remaining HPET migration code in the next pull request.
I have done some more experiments on Builder, but vmstate_fields!{} requires
the const_refs_static feature (which should not be a surprise...) and hence
Rust 1.83.0.  I will maintain the patches in my tree though.

Paolo Bonzini (2):
  rust: vmstate: support varray for vmstate_clock!
  rust: assertions: Support index field wrapped in BqlCell

 rust/qemu-api/src/assertions.rs | 25 +++++++++----------------
 rust/qemu-api/src/vmstate.rs    | 13 ++++++++++---
 2 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.49.0


