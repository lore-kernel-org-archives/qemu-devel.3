Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1F1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSJB-00058I-CM; Mon, 14 Jul 2025 19:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIE-0002VL-LY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIC-0005o5-H7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vkrlbrhsKn6eS+sA2oOtiYsJKDGFt+PZH3pEh9q5Hf8=;
 b=LT9A219rIG2GfmGycgFxgyUVnbWxsK60+nlztlnh6lVYfeh28k6jVTmDrbthoI3lCaLrtU
 UCHTXHeiJNnwxMd5aiUhnJsZA70Xbox858Yxc524kZAALc7zQWrSPgC7ipuR18lK0rHw6I
 4Orm6O4DlsSbT5/EqAvvGD5RlNCOwWI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-gR4Os1bSM3-xIfO74Dhiig-1; Mon, 14 Jul 2025 19:09:02 -0400
X-MC-Unique: gR4Os1bSM3-xIfO74Dhiig-1
X-Mimecast-MFC-AGG-ID: gR4Os1bSM3-xIfO74Dhiig_1752534541
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4560a30a793so10161665e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534541; x=1753139341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkrlbrhsKn6eS+sA2oOtiYsJKDGFt+PZH3pEh9q5Hf8=;
 b=wNcMYcYS5YfKbUI8AyDU5qZFwO3SdjLvfSqI5wdJjscuGHfmTWiDdXPPM3dB1ltUuV
 ZfyKxtK0MLGR7PLhfdoNk3SYijMHyQAZNH64Pvnk8XPKXX73+Rf7xMviArgbIICu1iRu
 r1NX3FzpaATpJldzF3Z5TNqreZSAY6LjQBskV6uKPceREdMHPLQwzUyWZR4O1JDbAgAx
 7FXd+3MlzfxzbSfUe1wd5C5CH/bn1aYYK1nF9jQ+aS/lMmMwyzicmqxLzrbi14VKzd+C
 VlAHfS7BRiVpzcQRlm8VU9c7VNkKUdR/PLCKt4owF0vG6k1gnpbk9vQx+NhU4/U4jHvI
 VOWg==
X-Gm-Message-State: AOJu0Yx80CFEI+djb61HYiZIdy2wUHmn9Y2r4tqFrItkg5q6HH/GRVvR
 FjCl5lLQXE8KlHN6PNOX5u7CvdKWJu0tn7mEGbwk1ovCm5VUDr2Nfj30F6/f2KOq74R466ivAI2
 hzP+4rBGco8DN9/J/90dF4x6urbAIVkbjW/DnJp3rwVEt5OMjbadwWsfbR2b9Aqv4uP+U8OBowb
 r3SMhJU3xw9tg1x6bD62FXvyy8vXKhzBRMJQ==
X-Gm-Gg: ASbGncsEm00nGrO7kimt7kkM0xyachfuMXO7Dgr0djE5kEH4XUH2z4gqix9c106KrTd
 5S/HYCISNW7moceRD17m/mf8D7CG7qOg7YLnm4elCz9Wk9NGny6yVox6i7eL+N04fQ9eXRtSG6E
 vE9x9VuWJkWyBTh62iFNJ13p7TFTf9+plYXmbmmA9R+0cy5Qk18zNDsIijvj8pebwNfVVxUyLx5
 8+Q/SQegGp0eLI7rhec8XYrDmBMXvLyIdDkOuX7KslOS7JiPETq9S8jPg97wClbLNnxp7M/Opmx
 wHmotGRpxeRR1MjOFKpKMNUET/6HPetm
X-Received: by 2002:a05:600c:1e04:b0:456:c48:491f with SMTP id
 5b1f17b1804b1-4560c484fbbmr105500325e9.10.1752534540675; 
 Mon, 14 Jul 2025 16:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMfqosGnNpE2JNodrS12kF8YYsT+u8JEf2idso1z5nPAIDS1pJIPJ3iZCom/rbOlNQXjssVw==
X-Received: by 2002:a05:600c:1e04:b0:456:c48:491f with SMTP id
 5b1f17b1804b1-4560c484fbbmr105500075e9.10.1752534540177; 
 Mon, 14 Jul 2025 16:09:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456009ec9c8sm91680415e9.39.2025.07.14.16.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:59 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 63/97] qtest/bios-tables-test: Prepare for fixing the aarch64
 viot test
Message-ID: <b04afde07abcd2cb49482ecb7caad88104ee6235.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

The test misses a variant and this puts the mess on subsequent
rebuild-expected-aml.sh where a first DSDT reference blob is
overriden by another one.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-18-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 tests/data/acpi/aarch64/virt/DSDT.viot      | 0
 2 files changed, 1 insertion(+)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.viot

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..7a74beab3d 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT.viot",
diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


