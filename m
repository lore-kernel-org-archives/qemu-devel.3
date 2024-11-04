Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1919CD1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84L5-0003lI-U2; Mon, 04 Nov 2024 16:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ke-0003Lj-6C
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ka-0005ZU-Tk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEdkjWiHP5L8rCz25+/APfjLDFkHVovlyOsZHlqQfEA=;
 b=LpW2rt4LjHcNsPTylSRWjDMTCoIflwbzyEfjcJJWOTb+o7aOwSnTT4hmsVgqlFuaqgPFmG
 JBIaN4Np30ZcN2Zmkv3JHv3NRzoi0MEtCWERo5rpcpaVic/KPtbnEoKqytP9obEgtHJ45U
 AO7wjydfn5ydE/YYuT8eTOtinAu424k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-skrIC0ZoOcqn3eCL1WwXEA-1; Mon, 04 Nov 2024 16:09:47 -0500
X-MC-Unique: skrIC0ZoOcqn3eCL1WwXEA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315f48bd70so32910175e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754585; x=1731359385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEdkjWiHP5L8rCz25+/APfjLDFkHVovlyOsZHlqQfEA=;
 b=d6IpyC21tyC473I4g4KuSQyTovTx3y9TQUAPY0n5FHac6Utg3tydZzEs5ZecLw5qE4
 K42hRpRd1J04bMoBEA1oFpYtyaKaq2Q5Dct4+GSv4rQ0xMRk+x4weL9gRwPUxYxNPwTs
 Mu8hyLwyVmuEvC8iyo5L1g8KZFb6MVlvKAPy2EIvpnmNEORxgAbm0OCvnFH9VbkSRKtg
 s5kLIyRqCw3aK0Q9Sn2kSvy6ViV4pAR3zz+2XCCOaaNgMfezQFHz07u5pXIujNOvAxci
 gFC+CA7NPFlOWSrlNg0J3yVPBNKPq4ATlodPKEIUU1P/x8zA9iR+uot5Nipxba72qQ2y
 Q5Sg==
X-Gm-Message-State: AOJu0YzMA+t2BqhoLxvJ/J6MIKe7YBas09JzaxUKIc90+Rt44hXNl0Bz
 HJSaxS+6Fb8uXi6JrdQrNOX3XiDa3FQofvAG5M77AixdjbKKR+2JcExXBoEicKHC4rc0LoyHzsU
 fpxuh96Eq9Kf06KbtQ0sIlUesw8hoftKvE7F1x4S1tDrYgU2kUB55aHiKSWyxj8N5InhyGhQkMN
 tBv2dUzRV0P8wYcLIovoNQYmDkIAw0mw==
X-Received: by 2002:a05:600c:1c28:b0:431:55af:a22f with SMTP id
 5b1f17b1804b1-4327b6f950fmr151215135e9.13.1730754585498; 
 Mon, 04 Nov 2024 13:09:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYUvvajy/IyjMXtvvwGY4IBBvJM8VI3THCroLWnMaQ4x2mCxJfcno+4sD27Iws7y331399Eg==
X-Received: by 2002:a05:600c:1c28:b0:431:55af:a22f with SMTP id
 5b1f17b1804b1-4327b6f950fmr151214885e9.13.1730754585030; 
 Mon, 04 Nov 2024 13:09:45 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a27456a0sm512215e9.1.2024.11.04.13.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:44 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 63/65] intel_iommu: Send IQE event when setting reserved bit
 in IQT_TAIL
Message-ID: <e70e83f561c45864eeb0945ae0298caa595262d2.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

According to VTD spec, Figure 11-22, Invalidation Queue Tail Register,
"When Descriptor Width (DW) field in Invalidation Queue Address Register
(IQA_REG) is Set (256-bit descriptors), hardware treats bit-4 as reserved
and a value of 1 in the bit will result in invalidation queue error."

Current code missed to send IQE event to guest, fix it.

Fixes: c0c1d351849b ("intel_iommu: add 256 bits qi_desc support")
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-Id: <20241104125536.1236118-2-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8612d0917b..1ecfe47963 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2847,6 +2847,7 @@ static void vtd_handle_iqt_write(IntelIOMMUState *s)
     if (s->iq_dw && (val & VTD_IQT_QT_256_RSV_BIT)) {
         error_report_once("%s: RSV bit is set: val=0x%"PRIx64,
                           __func__, val);
+        vtd_handle_inv_queue_error(s);
         return;
     }
     s->iq_tail = VTD_IQT_QT(s->iq_dw, val);
-- 
MST


