Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E80AD49222
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD21x-0000HP-0w; Mon, 18 Nov 2024 08:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD21u-0000H6-M3
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:43:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD21s-0005R3-H8
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731937379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JnPuj/Ao84HNRM35VmPWv8XIuBS/8IHZBk2XRpc9GSo=;
 b=MHecODiOPs3aROGByMnMeYkSjvT9ovI3LkSBiY/+e5ig4huU9fkILTgmr5WuMMR7mJ+z/v
 gZmCdfz6dtljisYz0gTXTU2kqGjoSej9EsjF1gkeCnJviabFgVlk8VQTWfezSx8vVRcABa
 UnwEpAgT5E/TdUb90lvj92Bkzj7I8lk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-TtJ7sbDFO1S1InPYCwgs0g-1; Mon, 18 Nov 2024 08:42:58 -0500
X-MC-Unique: TtJ7sbDFO1S1InPYCwgs0g-1
X-Mimecast-MFC-AGG-ID: TtJ7sbDFO1S1InPYCwgs0g
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315544642eso22767045e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731937376; x=1732542176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JnPuj/Ao84HNRM35VmPWv8XIuBS/8IHZBk2XRpc9GSo=;
 b=gSA4+f8FOmZMhlZGB4oa2UAocJIv+vAHDuqEuxKznoMIc5TMVU78FBVdnNRAdeAgmI
 nxOD9Ghg0dv+QTOSgU//eFj6vkiCcF71W6nFPfqYM1P+MmJhAMOSVXMwfYESy/yUDgqm
 3Ntxp126+YA4tE3qH0iEBQYnjuAb5x7Pl9KmAqYDi+71VrMkdywLf0AaVRKNxalgoiqI
 83OW072ChbquHmEkWeXUn/Wl6SsoL+Rz5PvRojqxIZXeGT2eaoCeJ5UxCcFfl8gWMvJF
 tO3z7Sx/v2DeLaLjX8tyEQvBEBdtedihiFw6flWWfHjFrIQqWZPCtuR/EuXgbjuoVDwF
 yuOA==
X-Gm-Message-State: AOJu0Ywnswm7wADxhu9jLgPnOFiNcVTJWGrFKBqQKdiRcBHrNQ73pFzE
 aQBbr8lXtYwbRWPOzgEBd59PIBoA1BmNAlcnne2+MNIuUqXhYMpXZzIgGSD2DSHfIPx2IIZjzYA
 NBoL2urmmO3x8r0EG49QiKgqHTBaStqVq820UZl+llrMlaSmeRnmBQRw2BksjbVGZxGCAA+TaH2
 dMlb3DKXm7q7zTv26wGa8S3giHo4QdJij2zhyF
X-Received: by 2002:a05:600c:4e46:b0:431:5aea:969 with SMTP id
 5b1f17b1804b1-432df725235mr107106225e9.8.1731937376160; 
 Mon, 18 Nov 2024 05:42:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgvty+6S9nopq84kvh0YlOKWoUH6MVpIPOgiXZZluqPjTN4w9BGhy8jx91JkzfqbcUDC+yGA==
X-Received: by 2002:a05:600c:4e46:b0:431:5aea:969 with SMTP id
 5b1f17b1804b1-432df725235mr107106065e9.8.1731937375861; 
 Mon, 18 Nov 2024 05:42:55 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0ae04sm154933265e9.33.2024.11.18.05.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 05:42:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/2] target/i386: hyperv: add stub for
 hyperv_syndbg_query_options
Date: Mon, 18 Nov 2024 14:42:52 +0100
Message-ID: <20241118134253.2071319-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118134253.2071319-1-pbonzini@redhat.com>
References: <20241118134253.2071319-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Building without CONFIG_HYPERV is currently broken due to a missing
symbol 'hyperv_syndbg_query_options'.  Add it to the stubs
that exist for that very reasons.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/hyperv-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv-stub.c
index 3263dcf05d3..5836f53c23b 100644
--- a/target/i386/kvm/hyperv-stub.c
+++ b/target/i386/kvm/hyperv-stub.c
@@ -56,3 +56,8 @@ void hyperv_x86_synic_update(X86CPU *cpu)
 void hyperv_x86_set_vmbus_recommended_features_enabled(void)
 {
 }
+
+uint64_t hyperv_syndbg_query_options(void)
+{
+    return 0;
+}
-- 
2.47.0


