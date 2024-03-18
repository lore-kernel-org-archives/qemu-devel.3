Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101CDC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFfa-0000uR-Ki; Mon, 18 Mar 2024 12:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfW-0000VF-JD
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfV-0004o9-3g
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8zbjoNWJje0hUAaroUJ9ZV+Rtxkcmj8KdCgGsYtrckw=;
 b=dcWFa2fpDoStgcvQminJr9Oe0qfUgis1p0xCdR0y/68y2e+tTV0LfG9S8rLuqX8Ywq7Xjz
 de+pjPjMFbwkjNzuM4N9owHej2OP+N4sFcHo9uF9a5Qp9jyMiDKgNNoMYbKFTkaCif+rx7
 PqTnJikn/4zVbAreQq1UlarzejI0SuI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-fvApRFqqP5aVhN4T2TD51g-1; Mon, 18 Mar 2024 12:16:53 -0400
X-MC-Unique: fvApRFqqP5aVhN4T2TD51g-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e70785d542so1310778b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778612; x=1711383412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zbjoNWJje0hUAaroUJ9ZV+Rtxkcmj8KdCgGsYtrckw=;
 b=K7aIkEKvLGHCblC/+9MH8+RaQvulGExavL0wzQRf5jTuv5nAy5m9eoX06fq/uY2+A+
 ILRXl8R/r+xb1bky79w6bWhJi1dbGoKVRxsd0Cf2+OIWJuW7Iqcj3SsChUX9zHWI+a6s
 MwzXUA0dv3wswSnx/750Ckh4jsArVyXy9V5znea+s9gNhYstrRiwYnzU1qvFSMhTVzGP
 OsW9DnCYNckPu4SJEOsNPgyynMQ1eH6ZkKoE4BS4Brhwz25a9a8HpuU5EonB/Ks+ALL6
 zKM9LZL1TGRDLZMVouWSVFXNNC88T5/598jiLQV2NLeF22qkuNmeTfdDBXKALwTM3RyU
 2wEA==
X-Gm-Message-State: AOJu0Yw6fsxujDb2WrNQZlukOGG+aygu/SVusEjEElz4FHSVYVTX2S0k
 HeuIHdFgX33Y134babGQK3YncmyEs8O9igpctci0rvYb1CcgebUN7mzRIw59ShVMBYwPHTUdgNz
 oaSMBepPkWXKighmVDVExqjEM/2IEPlnH7WwercZK0aErGJz7j+hQwIZdTurlRaeK7Y3ngBTU3N
 YthV4Os6WHeD3FJaflOpM1zPivMCgt/Q==
X-Received: by 2002:a05:6a21:1583:b0:1a3:67bc:252 with SMTP id
 nr3-20020a056a21158300b001a367bc0252mr73347pzb.17.1710778612396; 
 Mon, 18 Mar 2024 09:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtDccwvwswBw1izhsuxnt1TenQM4FxXdJJYLRl4upQWxORovvfbEcPqiTfFyJ4rPVPDmKXUA==
X-Received: by 2002:a05:6a21:1583:b0:1a3:67bc:252 with SMTP id
 nr3-20020a056a21158300b001a367bc0252mr73310pzb.17.1710778611721; 
 Mon, 18 Mar 2024 09:16:51 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 a3-20020a62d403000000b006e6bfff6085sm8705539pfh.143.2024.03.18.09.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:51 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 21/24] tests: acpi/smbios: whitelist expected blobs
Message-ID: <c74f0126ce5d2b3ffec929c5f9f4ce961c7e2366.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20240314152302.2324164-19-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..81148a604f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/SSDT.dimmpxm",
-- 
MST


