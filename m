Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B2CD1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84K6-0000h4-42; Mon, 04 Nov 2024 16:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84K4-0000ag-JF
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84K3-0005We-1r
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OG4lyvfSQwzgYZmOFt3djPmHvHJCXcfAK3eUcAgOhtk=;
 b=AfjIFj0XR4lzL6L5EvR8uiCU6zzDl9rankvoXbVUlVUAIyC3/NYASMAfGW0jsX6Bo8aulm
 gx2AJvYO3lcFBGrWORjq3FaOtyhKg8yHIY/pjVZQ0Ivy0NhJigmaHYfQldI4SjoJ2lOWVs
 EOsCx4j2IQELynt7CTotynjFsr19vLI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-kE_jAxS1OXCt5dTlSYXQHA-1; Mon, 04 Nov 2024 16:09:13 -0500
X-MC-Unique: kE_jAxS1OXCt5dTlSYXQHA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2fb55e102b6so29367951fa.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754551; x=1731359351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OG4lyvfSQwzgYZmOFt3djPmHvHJCXcfAK3eUcAgOhtk=;
 b=PeFhjfN96GpsAcySZLbnCv4/aF2tqUYLUX9/0R9FZVt5yBe3/EMTX2bEeXwdPMzoRY
 D9jBnVkvW0E8Qf8muF2xEieWMDsaLZINM+fd1tONJVTNB4iJxL5wxKnBZN/MViojdoJg
 kbTArGPTymvuefcLv39uOcbBmaIAtG75vQcpbmLFiCD0oEtTLAldBOTPK2bl/vNV1FXt
 1Dq/wa+8n1IdBmk4lhE9KTJBMuyHCPRxLxHTHPv8HCVkVfF6IdhMnino1yGxu5i5d8U/
 K0wLN6enuMICsIkBMUsequG0CvtuLbbjVH+g3bkv9Y2tVcdVRFrQoaAU0xIHa3BmKJJB
 8A7A==
X-Gm-Message-State: AOJu0YyD2W4piJhZMeX6/5em6Undrd/VOAWQH2ZyvUlmaFa3o+xYFGNg
 p2KwI5sVoy+Lc6OdmqtBwSrbv978bRE4i4RaCLoLAPJR3UEI2dlbcxIRDl3GwipnVU9yNlcymYT
 AK4ABcg6fY7ZhYQwtNPbmJN3i2UehyFMg2KLffKqrMuc7NGSY0N3YVMInPdgBafwJ25JmZiORZQ
 yzVWaBobEaPzmLiYnB6CSabI7DD2jflA==
X-Received: by 2002:a05:651c:220c:b0:2fb:5014:c998 with SMTP id
 38308e7fff4ca-2fedb7d999cmr65342601fa.28.1730754550714; 
 Mon, 04 Nov 2024 13:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+e6pMijqXqXpcWcgXAU0eEMLqWiYhF7ynvUMIeDGJ9RdNskcsgc0NqCVkb1xHWNVAf49YPg==
X-Received: by 2002:a05:651c:220c:b0:2fb:5014:c998 with SMTP id
 38308e7fff4ca-2fedb7d999cmr65342411fa.28.1730754550224; 
 Mon, 04 Nov 2024 13:09:10 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4b82sm14153010f8f.43.2024.11.04.13.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:09 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 55/65] hw/cxl: Ensure there is enough data for the header in
 cmd_ccls_set_lsa()
Message-ID: <5300bdf5898dda5989215e183bccd555cc782b9a.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The properties of the requested set command cannot be established if
len_in is less than the size of the header.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101133917.27634-10-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 078782e8b9..f4a436e172 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1503,8 +1503,8 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
     const size_t hdr_len = offsetof(struct set_lsa_pl, data);
 
     *len_out = 0;
-    if (!len_in) {
-        return CXL_MBOX_SUCCESS;
+    if (len_in < hdr_len) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
     if (set_lsa_payload->offset + len_in > cvc->get_lsa_size(ct3d) + hdr_len) {
-- 
MST


