Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884F8C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqq1-0004Mw-Qs; Fri, 01 Aug 2025 10:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhY-0005ds-Sr
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhX-0002q4-DJ
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rt7GnWAbSGWYSqFzaw9x7Xx2rUyY6tFH8mQrAe3XeS0=;
 b=gRYhPi8/BguUXFV6KuGEZEO3A8r6RmyN7DBQ+3adyHvhNDXVblsegjRIvLNA3CZRQEZpCg
 WgalzjddXbkezYuF4GISqwbb5btmGm1ExlkKTUqemD5XSJmk0AiMIf930GtU4r4XQvJDJ5
 LVYbSn5B3MY+2YFWJkurwn6yC2HnWCU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-icYRlWGiMTGYOjKPTGDYZw-1; Fri, 01 Aug 2025 10:25:36 -0400
X-MC-Unique: icYRlWGiMTGYOjKPTGDYZw-1
X-Mimecast-MFC-AGG-ID: icYRlWGiMTGYOjKPTGDYZw_1754058336
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45626532e27so11965445e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058335; x=1754663135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rt7GnWAbSGWYSqFzaw9x7Xx2rUyY6tFH8mQrAe3XeS0=;
 b=LcYg9iszza8/XAuuL2wXLyTIyNC7Kti06fkS3FQ/ogcv44r8Vnn70a/INcNzhEGKZD
 OGTBrzgv9EgNNEGgdRfavXhGpSvUUWGvfWCmoUtK0W9mZFZVxuEuxXGtsp7ujq5snyeT
 zzpnaucrvTYLtmIcee80/bMd+a1c+FscKrCd5h3zkZSCmrtCin9NA7W06SYcZcl/fntP
 QJxHgZxUlFIxZg2XJL1Jt0k1X7Fmd1ZyZTcMIA0uWJKUgdyjt+klkowPHjjm/G3uvLkl
 9xhT6FUxYUto/5ZKxd3F+7trlCYobQgLIiNT1HV+ecUKABlb3XONsPUpf8mRVu5u0swu
 hEYw==
X-Gm-Message-State: AOJu0YxINd1HeWIvcnJ0wqpLFfy5vKSZPc4gM04RGquI8AY+cqQy4Rz/
 F1D6HsqwE027BFtZcx45Z0xUO4wY6cFC8n5djzB/r1sQQN1HwDDw9VODGtFEuLXP92exRU9OAAV
 uPlbW9YrWsZnQz57VkB/Eko9HxcIkAlPnpdSbbUCVi9nfgDrHi7fAkUNlzhibFcyJCI1d/SvTG3
 WNopgZoYqp6XOmV5gP+BAACspKN2uvCYTEJw==
X-Gm-Gg: ASbGnctxPK83ipldKMrKrLQridJJoiz7oTh02Vn8Vi//ce2FG+UfxEhtDMoTKwuRcGm
 7/H+fJz5pS6zLnEILpds0TnyYQGdlW/n9F6lweyUJGdX5PaDd/FMvt8B5zdLWVrG01LsQJKfurt
 unXep4tRAuEJoMTBpVP9WCUzjfUldUreYNt2TackBGTHQlswf9U1I+Zrx6lXOqZisHD30qUHi5W
 lJPRjxbTR2R5e3b6CsJq5Fb5bi5A0My40bofn+J4Z5JN+63DnHepCZRktKKZ2mP6N9eH4dxhoJp
 X9cTgkNy4DED8gI8RGx7qzVFMT/NVyHz
X-Received: by 2002:a05:600c:3d8a:b0:458:6733:fb59 with SMTP id
 5b1f17b1804b1-45892bc5895mr101354295e9.19.1754058335326; 
 Fri, 01 Aug 2025 07:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSi8ANASNa7VNsN4h6CNiy6Tfq9yTG3B7TxBZIkH0u1iAiQ/9J3DXhfiwcBg0L9INCwvboaQ==
X-Received: by 2002:a05:600c:3d8a:b0:458:6733:fb59 with SMTP id
 5b1f17b1804b1-45892bc5895mr101353785e9.19.1754058334505; 
 Fri, 01 Aug 2025 07:25:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfcadsm112316235e9.18.2025.08.01.07.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:34 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 14/17] tests/acpi: virt: update HEST file with its current data
Message-ID: <cd16f08ad4bda8191e4de986d17184c9da5466cd.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that HEST table is checked for aarch64, add the current
firmware file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <e3527be1610b2ef6b20ca2efa025de91a1f1e0a6.1749741085.git.mchehab+huawei@kernel.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/aarch64/virt/HEST           | Bin 0 -> 132 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 39901c58d6..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/HEST",
diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4c5d8c5b5da5b3241f93cd0839e94272bf6b1486 100644
GIT binary patch
literal 132
zcmeZp4Gw8xU|?W;<mB({5v<@85#X$#prF9Wz`y`vgJ=-uVqjqS|DS;o#%Ew*U|?_n
dk++-~7#J8hWI!Yi09DHYRr~Kh1c1x}0RY>66afGL

literal 0
HcmV?d00001

-- 
MST


