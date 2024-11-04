Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF47D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84JG-0004AO-BT; Mon, 04 Nov 2024 16:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JC-0003jb-6W
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JA-0005Sw-Pa
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sfl9wFyrkXhR/mQ1NQ7urae0AqeUeu0VLGkrRpWPy4w=;
 b=KL8M37+KcLsoZJ3VXk4/R4/VOlm8XHJpW3EDUeAIHToXeL2tS8M4YX+exYaXpr0jLa6rQn
 Tv4TbhFdGPGNzC8WhIpjDNafiJmMlKm79XZQoLyhFWTwn+xOPWiKK3TwkIkG4FPXg4vNH5
 3kcSi0yOkZqUbuCLQ9x9HCfzRRPCxHE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-pUabv_JqOrW1Ao_Q48EHjA-1; Mon, 04 Nov 2024 16:08:18 -0500
X-MC-Unique: pUabv_JqOrW1Ao_Q48EHjA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso39454175e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754497; x=1731359297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sfl9wFyrkXhR/mQ1NQ7urae0AqeUeu0VLGkrRpWPy4w=;
 b=j0Gl8D4trGJ2NIFDa2LfwBPcfKnMDL3BM+z0Aj3U4JL44y2S1xH59sLGHcOFAF59kG
 F4Aiid2q9Kap/nTNfqz4Q+sGnsUHCsD0B4CqQydCU8PjzM5teYjqIzQ0K/VQycvV8FsU
 2TfaK0LpHWNts45cqb5KclR97LoiQN989LomCPDVbc5aLUoG2/VfadTQxpPodapMQlLe
 orAqyni9Ecd+V/uC84NaoZN2LKxQjYI1b2x4LP9LPMi9GRtdb3vxNnTSxz2cWhDFHK/Y
 AWqKM7QlhqzYfryNVro3dU868RLQ93ue7p2l4Hnh3Wft1MUxb948628HNCH8TCkTnDNo
 NvRA==
X-Gm-Message-State: AOJu0YxYFrzxQgoW4nmymNT5fpZm9UHucA0bhXt8auKmIyaVAq8Vlgxe
 BJdWW9FCwAehpYGlmZ6qbl/yDFGpe2zSYFVcyhVEBuJV6FKHND1GZsG6nRlfpbSTSHALdZYOItn
 UyKczGP9UDuJZ79MNuwuIeCJFq/Q8Prof1ahBHG4gUigG2ExVYFOgAeiH4TuRIRALgq50AnGPqz
 ks1e95VNdKBmul9P+wgsrxgzVZ5Yp/pQ==
X-Received: by 2002:a05:600c:5486:b0:431:52cc:877a with SMTP id
 5b1f17b1804b1-43283296066mr146670695e9.34.1730754497187; 
 Mon, 04 Nov 2024 13:08:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8JUTVrQ0zQfu3t+4t97vpqnT9wnXm+/ReoeLAiI7H3SYXYwubqUC/J8qHDCVzLlwZtPzX8Q==
X-Received: by 2002:a05:600c:5486:b0:431:52cc:877a with SMTP id
 5b1f17b1804b1-43283296066mr146670535e9.34.1730754496823; 
 Mon, 04 Nov 2024 13:08:16 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d698055sm165490415e9.40.2024.11.04.13.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:16 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 40/65] hw/cxl: Fix indent of structure member
Message-ID: <d1978226c81b0e9b3d6a7779cf92cbfe9f4a10e8.1730754238.git.mst@redhat.com>
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add missing 4 spaces of indent to structure element.

Reported-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241014121902.2146424-7-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 67041f45d3..5f63099724 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -374,7 +374,7 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
         uint16_t pcie_subsys_vid;
         uint16_t pcie_subsys_id;
         uint64_t sn;
-    uint8_t max_message_size;
+        uint8_t max_message_size;
         uint8_t component_type;
     } QEMU_PACKED *is_identify;
     QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
-- 
MST


