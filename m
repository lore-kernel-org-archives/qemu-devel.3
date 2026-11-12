Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECC606A338
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=twqRzRUY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZ8P-0004fI-W9; Thu, 12 Nov 2026 13:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRZ8N-0004ep-4j
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:02:51 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRZ8F-0004zB-VX
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:02:46 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso28035f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794506561; x=1795111361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZB8/h5pcpC8xOsxNTHjZ42VX9Bmh9MxX/wywZ+VeEuE=;
 b=twqRzRUYv4ThTT4029ShHodbFc3BNZOqnvwF9Q42iza6BmeHd0fcJQxhWBMvCPLO9A
 bZbKAqLbOu4qhGKQWmXeBcnh31XzuO2kgWxdnsxL80Dqbf9HHuxG4bFjSvWd7Bqq8x/T
 Xfq+LOPUuohsgayeTodsZpgaj6h2QRAdXJs9ksVVaR9+Jt6zCw65Wdf0+d8WL5uPjslX
 +uHRXzSBWnjHl5coQkS7mGcxrAbuDp/VSttTZg7KGx0HHvfK5O+4dO94T6m5HNw2px40
 2YaR2EyMf60+Lh6C8Ihm2/g+XFBCildkNFBOx6Esn4hw/L6sCHH+zSJxVk93GjgvFP8r
 5SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506561; x=1795111361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZB8/h5pcpC8xOsxNTHjZ42VX9Bmh9MxX/wywZ+VeEuE=;
 b=WHzuE8b5aNPtwRR+9yvZUHgyEcS5XIYZ+GjxnW5K7h18GaSZHl7a/nff8ShrIqsAPE
 THfB29I1uB2N5vtsZNd//XSEtuiRaLKgcU4OZlacUruvsjMpO1w/U9UdUi/JU28X/1yE
 429JLmBQt2y80OrM8uVeH85b/cuWkKIMJ8sPRw7Sreej8qkho/rBX1ldNQBZMVs8Rlxe
 sXlX9gStAAz2dmu2eHUdYcj1UCRjlro4KHUe2MtiQSJFwNyLiMSEOlEVPS5Hz0D09Eh+
 i/Gbb46pS+pwnKcPjhiIjHbQQIJ1pj8UgaT1Vy0c53MVJ9QmaBpfLLGDfSC91jN2F/xa
 bqoQ==
X-Gm-Message-State: APuU4Z8EteXRHUCKGTJl/wKA91VSrgJA1MJJj1eOurIMTcsGhA7vqH0s
 pcZL8/uVrhi6VdRyYRcoZ3P1GlQM44Kg3Y/TH41W8CQzD9JuDGZHUAX8UP4/Rliuh9CwDYSzl77
 KVKu4nRg=
X-Gm-Gg: AYBFou0UXBTQSHPzHpGdjaOukZYWXbyaWuvg4omdAcb1C4dn595fNaA8Adggw20Q8+7
 UlpE4yAfldZBieJ7p1ww8nySkKTpesPHFLq4qYj2hBaX4l5bLKr51w2XKcsn/vtFqQBYSrgfqC8
 YJa87cu5VHPbuIjkphm67W3qEGvNOMsicikmuryQJQdSMLLJjbF4VT7OF3h5V6PtUGzx4+Gnyzf
 LNZuifhgIkZ20LzTtb+f/DY5y4X+IAalX5JYcosQq/7Z5hzmWoZE3DtUqQ1gOOfA4Pi0sqv6JRk
 4XEvGNO45O7/HEHB372Y7droK3PLlnfXrl4UTnvRUbnZpK8xWjdoYJZioNLLzKgrRfELs0lxfAe
 HGY7uAlodCtskZ2MenNRSSa/N9u69Kkz9CRmo43jKvzVu60Vj7JkFOrM/knNf+YhQctPiXCIvGf
 NOonncsq0FWIcp4cgSoFdA+18k0I42R5mNdCzsIT5HrM+mI/91VnaOQ0cuMl4LEmO3yBqFrsa5x
 5LJ3LQOniAd7I8yHFt1SgHZo15zDzmW4nIW3Cf0XimX26H3E1lDZHgLkyeJm0XfWnEQ+95yk5WR
 K8zOc4NNxn6qQ3rExu70BGfHnAC7zzJEpgo5WnsLYTkVViqtKVbzSFq9uxj2jeluMbNS51Pa6uW
 FWp6AL9XfN0aLnjxHudYCbFKeoeZ9GAo+ykiUSMwxrXoSP66B+V3L75A=
X-Received: by 2002:a5d:64cf:0:b0:48d:f3ee:7cc with SMTP id
 ffacd0b85a97d-49c71a66085mr257163f8f.30.1794506561509; 
 Thu, 12 Nov 2026 10:02:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60d9fff8sm521325f8f.52.2026.11.12.10.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:02:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/2] net/checksum.c: Fix errors in dealing with IP header
 length
Date: Thu, 12 Nov 2026 18:02:37 +0000
Message-ID: <20261112180239.489819-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

thanks
-- PMM

Peter Maydell (2):
  net/checksum.c: Correct handling of IP header length
  net/checksum: Correct handling of checksums when IP options present

 net/checksum.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

-- 
2.43.0


