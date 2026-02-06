Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F548EE6B69
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUAd-00063m-1u; Fri, 06 Feb 2026 17:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAb-000629-A0
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:21 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAY-000792-HI
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:20 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a9057b2ec3so13062605ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770416357; x=1771021157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7ciAN7O7/i54gZ3kSipLEjZsOBJSGqwrAABTmho6QI=;
 b=vRITGetwvsvOWyu1Sejd9qB15lXkItTD8py78Z6t20sTJXGGWTCBDnejGwzvbxbA/0
 j4mRr0sfudU12AMo3JTpolu0GaCFDPazh+i0Oe1Hcexn0YxT+rrm6CkuVL3DKVNyQFHr
 cU0IK7tEcYJEp8PZ74Dq9CK6txFC9dKz0PY/eh3cnkiDG78i/J3xhGJ2JBD64yxYJHvF
 OT6MM9Lt6EWa9gSC290m6cf31ucGKpfxJXSxmKtAkRR9THhdxk+AOAvDWmHZsxRd1gvf
 pIHhZubBRZipuW+75iH+sZqqB5hgJh6QSnNMRK7vLuFf6VoiweRlrFStzPWDV4eL80Eq
 ISNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770416357; x=1771021157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w7ciAN7O7/i54gZ3kSipLEjZsOBJSGqwrAABTmho6QI=;
 b=ZEPZmsdXculVaSOyMaLgwqw7u8qpHdFmNa9wHkk0Em33/c2SjDWEM0HjGBMHkl0fuA
 n1b7PWwbm72/3sQyNikVr80JgH1vS0WAN+743JzAwhKk0Mh2u0ukmW2k/fd9YZc7lBcc
 J/7FR37oKEEE4FW3MAvHN8lB35xgMZ5OQOci3XkOQFCxr55lPCb08VXB6eEpkWZRNUmC
 9j31kUKao0OtMXLeJVRAYEdh/e88hbsYwv/7kqhYObnSNbTt16jxBs+pSh6GCgrULTN8
 bgt+zIvKyC6fjVXB28VYSXmzAZqqdMMBThUcF9fYnEun4/iZn3udoYEL133poHSY03vX
 i/BA==
X-Gm-Message-State: AOJu0YxqRYoLNpx3q25GqppEnCKuvcA5uaDy7MjKuSKIgbqSKPd7/8af
 elh/IILTW/rT4elM+t3eD0Ex+vv0kQpiqnkA+Dzaq8NA3nMiepm6XcZrnkyV/MSMhzX5KLNFfzb
 XuQpM
X-Gm-Gg: AZuq6aJEatl/T9UmEvv/tKFtsr2bYZ7i1v+GiKkIxrQaGP7m8WntYXk+iL58Fr/eKiR
 KfmzsyJPbVjUv+G0THr/fKdrdx/dlb1nnkrw+rFnYl0/GFx8ILTo1FO9V/Kdwc/40WUiToA+pvs
 5/3VKVjNt1HUC1EG+ORSPZOF13dXiZSx/fLIdKHc48GQdBz+mAMnl6NaoH8OHw8sttOkt+ltSPY
 YUCH3jlqblO+HJLhEKLpSi1xm6Kiq1WMlCBIOxIO0kShNQjxwc7ZDag/8Lx7C/egB5RL4ThGZxl
 AQvswPG5snO2wq2kTpMOZ5Wmyyh1TYk9t3cHHub836EtskHcmXk7ds71KZdTwxn/2wU+Q/lPp4y
 9Nhc1RoVJkLOgDCX12kTc457jxYFbqlvBETCdRRAIyNrzqqO4nRCNSpm7xX3v+nRIpw8i256KHe
 MY5vfveMwI+8+ycEuLl51duEWB7r2h6mCVv7SZdBtG5diJc4k4JAVGhJxfzuK8aVInwNJEahkfE
 Ss=
X-Received: by 2002:a17:903:17c7:b0:2a9:62ce:1c15 with SMTP id
 d9443c01a7336-2a962ce20bcmr2663755ad.0.1770416356770; 
 Fri, 06 Feb 2026 14:19:16 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95bff42f7sm13316575ad.68.2026.02.06.14.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:19:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, stefanha@redhat.com,
 richard.henderson@linaro.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 1/9] hw/virtio: Constify virtio_is_big_endian() argument
Date: Fri,  6 Feb 2026 14:19:00 -0800
Message-ID: <20260206221908.1451528-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

VirtIODevice argument is accessed read-only, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27cd98d2fe1..65872f2c54c 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -468,7 +468,7 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
     return virtio_has_feature(vdev->host_features, fbit);
 }
 
-static inline bool virtio_is_big_endian(VirtIODevice *vdev)
+static inline bool virtio_is_big_endian(const VirtIODevice *vdev)
 {
     if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-- 
2.47.3


