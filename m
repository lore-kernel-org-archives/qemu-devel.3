Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84693606A893
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KMbYwbB2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSDjh-0007iP-Jq; Sat, 14 Nov 2026 08:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSDjZ-0007hB-QQ
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 08:23:57 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSDjW-0007vK-QB
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 08:23:57 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so26674875e9.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 05:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794662633; x=1795267433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5zCi1WDEGs6MDZxvhzndLNFAh+xWfyUYVRkRi25Lfiw=;
 b=KMbYwbB2xFgun7wBRzIL3VHqdwSPJvWCtOkXoln7ih49z03WgDmKfdhDElRbEmsNvQ
 DAF7719dua7umVZWq1UvdZzoKjNzaustvyIQ1hG7T5+zwsblk6V98QqyseZ8c/8uDMSr
 0hpROsGFrot4Gi/18RdUyQHlkoZ1mgnqr/sZiDP9sL5N6sUjEpUYR/e1/e/4/kW3BJpV
 xOV2xRbIbbqinRfahKfr3AjA0ezJPQke6H91gJgLKGReFHBCyIhGK1m07zIPHWgnyvF7
 Di6rv6Kvlfz7odvekQWnuLLTVmUdhjhnO3VfbgvXZGcciOyNQcf/aUySkb0pVxMRzJBe
 mXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794662633; x=1795267433;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5zCi1WDEGs6MDZxvhzndLNFAh+xWfyUYVRkRi25Lfiw=;
 b=eLyE6q0VJtwJuTmtgAhM7FeZHN+VPBIhYZl0Fz1P5n/Ammb0wbvRJPkoPYVI3DyMet
 3pbJkz7fMLs3dmr/OXkCQoEgOiXNZ2ZLfJR4CqsBuC9C+gobbno/idVkS0HpitkTwTDF
 KT4Q2RBtWAgnoUbWRmHiIFTMauwY7KRHCKR4e+EZCjVbMrRMN6MTTV6KA8uD9Yc35gp/
 eQVlhXpDf28mRb/kdyTo1cH2xv6uqCC3j9wq40Iqb+fUMOt2xtPLAyxj79j1+G92nDJq
 MTA80IVG68ChbktsC9weP9Gz5ce0BC9jt2t9leOf1Kxw7rjdQFdbNSV5pT9zKDpwQZCO
 TtMg==
X-Gm-Message-State: APuU4Z9+DHBWulx+UyoM5CCMOGaSfwTQI2qzBeHvJ3PJE6jZfhN7vacV
 5yGJG9kF4y5RtuGcKm/JbbJ7ky/LTZ9fVF8ls/GcPXjIBosFZirhF4a8nmbiGmemdF1wAqWWZvB
 ctZtznMc=
X-Gm-Gg: AYBFou10wwwVTq+/dWkk6YnTP/rJPrCmNqIMl7q8GAIYNw6UC8V6iA2bUAP95eoPpbn
 n8Wxj0PgKe1V2sBph6Y7ioFBhQK0aOu8Wl6oqL0LwbqmberkD2o553UnPkwOHJo1DtyMzztBTbX
 Ks83Y8dYFO9jL5BtYB8DpAFuZzl7pYHgAWgnIfkUgfi+HqvbiiUFw4v7ga3TZIWKM/Qruhm90ek
 tV18c64/+ECVxKU9ARcwiaY01ol+yIonYBvChkVyqbwQUQxzff3T+aLtddWQl0HR4f604xHyQfg
 h3PP9xdZGeK3YXewILNonP2a7Uv0/S0ttFw/hHr4cEwSHVSy2AfqpGvMG2zyVfl9QBTFr9Eyh90
 vD09Ig2vgRpWozGa9A4oaPqnEhDfvLC/lBarCzvkSrmfkWYcZ0Os1ed9Ty43ZJb23WJhWYVdmW1
 fpPPkmYjI2DLVAIK5nBBysVRWTLsXW+mKqZ0xV317eIy5QG+i2mmwZ2OJwu/aNBb0X4HUnvCZxx
 58YZVArRBTrysI4WfP8rpn8xBc7yC4aKF5UrLDMElIA8In/CtJsKeZrgcgvlM1SdQjSrh21pKeZ
 FrkUIVrqSKteRltXUAyMcp4317RGFJrflpHvkUroN0oseB/BsP3/ppA/YiAAjnPvWM8OluN9AX/
 8ZYMHkqG976eIKkm+3i4qUkOJLSIvPK0P0g==
X-Received: by 2002:a05:600c:a012:b0:4a3:5aee:2c25 with SMTP id
 5b1f17b1804b1-4bb55a907cfmr110739265e9.31.1794662633019; 
 Sat, 14 Nov 2026 05:23:53 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55a0ffcdsm130357045e9.0.2026.11.14.05.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 05:23:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 for-11.2 0/2] net/checksum.c: Fix errors in dealing with IP
 header length
Date: Sat, 14 Nov 2026 13:23:48 +0000
Message-ID: <20261114132350.1456994-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The main point of this patchset is patch 1, which fixes a bug where a
crafted packet whose header fields claimed a header length smaller
than its total length could cause us to set ip_len to a negative
value, which then (because of a signed vs unsigned comparison where
ip_len gets promoted to unsigned) makes it through range checks so
that we checksum 64K of data off the end of the packet buffer and then
write the two byte checksum also potentially off the end of the packet
buffer.

This is CVE-2026-127233. The code is used by at least xen-nic,
virtio-net and the COLO filter rewriter, as well as various
out-of-security-scope devices, though it's not clear whether the bug
is exploitable in all those scenarios.

Patch 2 fixes something noted by one of the reporters in passing,
which is that we don't account for IP options in figuring out the
offset of the TCP or UDP header in the packet, which means that we
will write the checksum to the wrong place. This is just incorrect
behaviour, not a security issue.

v1->v2 changes:
 * use 'size_t' for length argument, and drop assert(length >= 0)
 * use 'unsigned int' for mac_hdr_len, ip_len, ip_hdr_len
 * use 'void *' for ip_payload, and drop casts

thanks
-- PMM

Peter Maydell (2):
  net/checksum.c: Correct handling of IP header length
  net/checksum: Correct handling of checksums when IP options present

 include/net/checksum.h |  2 +-
 net/checksum.c         | 46 ++++++++++++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 14 deletions(-)

-- 
2.43.0


