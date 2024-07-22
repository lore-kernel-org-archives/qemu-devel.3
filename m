Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB102C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgk6-00043E-6y; Sun, 21 Jul 2024 20:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgk4-0003vx-Bn
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgk2-0005lT-WB
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b1DVK7w17GPjd2vAQhHKtU0B8nNst/5eqxCLxdYr+cI=;
 b=gf2Mlax2Aq2RDQ8p/rv6Y3/H9Wz1vZYBlrpRQIaesLCX1jS5bReXAOYbYb3U0eDa4Qn8L2
 DXttJ0TZoIgby0+pgqZXtI/n4sCLu6f+tvu3sBNnOeTBHUdVo6X1m+yoet/jNlV03N7nCw
 iYFld16NFiGtn3Dry4koNfiLMBCIhhI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-sWw6uVoTO4ivVzH9403SXw-1; Sun, 21 Jul 2024 20:17:24 -0400
X-MC-Unique: sWw6uVoTO4ivVzH9403SXw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42666ed2d5fso25930045e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607443; x=1722212243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1DVK7w17GPjd2vAQhHKtU0B8nNst/5eqxCLxdYr+cI=;
 b=EpEhzD9008AJpXNf04z7HvRWZnvhxT16XqEjcPWyGjgLfKcLLm3wP09wJHUQMaI8Ix
 Gok2CQTRCFDrRyhXjqkf0qkMMyV1vsR0iooWiEDj//M5aA0cqppwiY9KYVJMo0ARBnsv
 VO24iB5QqbB6MmoSlSI0FQSBd+iaeveaoRhnDEbWsOhU62OleYSrdYZqJGb5+d87C6B/
 wZwaXK2gK0c675Gh9D6wEapKC1urHTYGML7SVIOMMRYWbwzIuVhoX7ZIpKMREb9nGk5s
 bVdJwCu5Elu7idZCPkXVUX+FT22OyrWazxH+i1s8wGZ3p4AnoWQHKYiEUrSoDeOOs1oY
 Fp2g==
X-Gm-Message-State: AOJu0YyPMBXXq5Ckf0LxRGysUufPNZFNfVYcEoe09Fq2Yra6YADJI3TS
 YmqPko9mkoAkzxesUH7E17DvEovHMszv9I33UBv6NGjmjjMzSrkQLoI6SVrICe06kWnSqphyI6O
 j/qazkoI4+W8fkA7Mqk2a9kVKtaoxV8jleepjjHBz4AttbvY/IV4RdJPGA+fJq0F+KuAn9viAnS
 1HAY35sK1x+m2XSKPkwubSRLF6hnbxyw==
X-Received: by 2002:a05:600c:314d:b0:426:5dca:50a with SMTP id
 5b1f17b1804b1-427dc531d47mr32801935e9.21.1721607443168; 
 Sun, 21 Jul 2024 17:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE5ezX0uRHXNslnNmqbBgg7RqX0cIh811EpZ5bWGJHemxROVr893VGvhfDGBfkANjzJjW24w==
X-Received: by 2002:a05:600c:314d:b0:426:5dca:50a with SMTP id
 5b1f17b1804b1-427dc531d47mr32801755e9.21.1721607442241; 
 Sun, 21 Jul 2024 17:17:22 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa171sm107667915e9.1.2024.07.21.17.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:21 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yi Liu <yi.l.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 15/63] MAINTAINERS: Add myself as a VT-d reviewer
Message-ID: <e3f15732c479e6c4baa56af65f52d99fbfb5c417.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Yi Liu <yi.l.liu@intel.com>

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20240708032112.796339-1-yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b7e9ced3e8..8ad64ff76b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3659,6 +3659,7 @@ F: tests/uefi-test-tools/
 VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
 R: Jason Wang <jasowang@redhat.com>
+R: Yi Liu <yi.l.liu@intel.com>
 S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
-- 
MST


