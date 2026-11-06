Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CF606A32F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=mqCNkEsv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQ9g-0003BE-Am; Fri, 06 Nov 2026 15:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xPQ9d-0003Aa-D5
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:03:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xPQ9b-0004mW-Qy
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:03:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so9141105e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 12:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793995393; x=1794600193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y8lB8Rw56JelFMjh6Mt5SXKKPBHVE/JUAhN1fFX12Sg=;
 b=mqCNkEsvtoO9PjFeLKZlBrwwTh9btqDJfZMq+D3UP690BU0O/rsktYdDpxu+3x5hEa
 EYqtJRGEx7TXsgmjEpvzVwWa4dX+TASZxosEeVGz522KRXoHY8jQSBuga9bXln6xNZC8
 9UPOjblstjAFQ6EvdEeM3PMOM5zrlarcPr5nuHMlN4YaLxlzSVxfG1C7hVH4UQc7ULFv
 UlWF4vsXGMbg7fqjLSrPKmejcP8gMHYH+4Ih6ZHMX/sCn8QffuR72sn5H3lF91aXxw9T
 RL6ZBRnJ3jO2sL8Jlv/TURsEsCfVNm1X8RR98wRLLnMD4yNWbPlHRANsCj03vbSWF8wr
 LlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793995393; x=1794600193;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y8lB8Rw56JelFMjh6Mt5SXKKPBHVE/JUAhN1fFX12Sg=;
 b=RexXrjMkxTloqc5V11BctSVpxw9b1A54G4ILNlVnOTmt/9ydtmsNSSQvgHcSgXB2rL
 VYnKbsmZQjHZx0glwNpCD5tL2JA+GhAQsvZqG+kxQhZpTdhjJ0sxtCdbEpFdlZen7RXR
 1F8G0g+ukItLB8LKn6Kg8CQvadngsmaT6Mk4QLPZf3iLJ1ym8PCJmXQrj+JobN33y0p6
 wME5pu0P+CUwEBExscoIRYLmGdhBSAkUXRTZTPqcaUzn8LvbJORnqBC0HapaVClLykZV
 EW+QyuQsGMlpMMgn8RVHNnzl98KlWyfPsiZyWVs96ByA7kvQMbKyW/kZue5SNYEPndRO
 UrRA==
X-Gm-Message-State: APuU4Z8p+CpfIW4xxvMcyGNNJ6Q7YcwQZ+ybihGwDRNnRdRdJkwxCWa1
 nd8PG9g/jnSDaPTHyZunsbBSe+ofa6XO8VhmMozCsRx20u7uIc+EHdAYtR/T2kO5qP9WBUbaDQY
 5xwLW
X-Gm-Gg: AYBFou1jGdWotBa2R9JleETS9dq3mjbJjJmEzzuFOC5Yz9gw9KPs/t1ZzAd5m4SYMyS
 X5zYC/YpF3G+e8mo1JUIbsJEbTyVtsqvgjJD8iTjqrIkIjD8gO4u7hGsLM3cmlUYxJIy8hew31O
 PZqUXZD6D4Sfc1oWRP8sdavbFWbw21I6Nx3yWc85NmfgCyysqTmHJm6d6iOrulAL8EdtIYOlC84
 juRpXh6Kh66bOyO2tNETYgxVk6VeDFL3tZ9f5OHkB4weNkB+fy8ixoU3Y2kxlJDK51ngdFdWU6f
 btnzpPlBN2qF0tu3eXg6MOnA8tP6Udxom7H3AYe13YPO3loLmrTQ4tfPOKIwNqHWtQU5WSW+NjE
 brN+PBdV8HqSoRohndiaNveQ8I2t/sMOEBuflrS9WnXkhJjdz4aL9JpA7isyeePvY/lxszaDjac
 acLLKjWpQTdKkrKf3akRfei3p9mVCSbj9t1q1+5Q7LZJzYnSvhfMz+3uBo1zfQgE/H3ANkSiuK0
 2TXyle9Ukzj9sAKfy+L+Nmh8bfA6y87Dvm5v6Hbo8dv0WUq6ToDxCa0JnKBGKgdUTDRRZBmZTz8
 u88uITpvMDpYWrB+XDCzTgbFlg==
X-Received: by 2002:a05:600c:310f:b0:4a4:7a8d:c736 with SMTP id
 5b1f17b1804b1-4b6de78917cmr58554665e9.9.1793995393213; 
 Fri, 06 Nov 2026 12:03:13 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1983:68c3:80e8:4ae2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e3271867sm4660995e9.6.2026.11.06.12.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 12:03:11 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/2] net: fix abort and busy loop when the tap device is
 deleted
Date: Fri,  6 Nov 2026 21:03:07 +0100
Message-ID: <20261106200309.122830-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=den@openvz.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Management can delete the host tap device of a running VM while QEMU
still holds its fds, e.g. OpenStack unplugs the VIF of an instance it is
deleting before the domain is gone. QEMU should carry on with a dead
link. Instead:

- a multiqueue virtio-net NIC aborts on an assert as soon as the guest
  changes the number of queue pairs or resets the device (patch 1);
- every tap netdev makes the main loop spin at full CPU in tap_send()
  (patch 2).

The two patches are independent. Each adds a case to
tests/qtest/virtio-net-test.c that fails without its fix. Creating the
tap needs CAP_NET_ADMIN, so both cases are skipped when not run as root.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Denis V. Lunev (2):
  virtio-net: fix abort in virtio_net_set_queue_pairs() on a deleted tap
  net/tap: fix busy loop in tap_send() after the tap device is deleted

 hw/net/virtio-net.c           |  25 +++--
 net/tap.c                     |   8 ++
 tests/qtest/virtio-net-test.c | 174 ++++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+), 7 deletions(-)


base-commit: 76fdb3373c9a27b3f50ecc9e012cbdeb90af7151
-- 
2.53.0


