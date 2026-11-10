Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512B606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t7nTVUls
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqFB-0007AZ-If; Tue, 10 Nov 2026 13:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqF9-00079k-EF
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:06:51 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqF7-0000EJ-Ah
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:06:50 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso1283712f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794334007; x=1794938807; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xgCMUi9hMpttrTWa4BUBP0xD5qovh5dItgbsdQEnXSI=;
 b=t7nTVUls9strgrhEiL+3FKpzpJSfpjIQ6hLZiJ3DZMdVwF9I64t/8LKB3aV1P/v1l+
 QXCx7iY4JBha08uHvuJ1xO6LcPwGCQj9XxZgIwaVAi7E6d2cVY+hr9kxjH8xf68WVZ0+
 3TecHFdR0pXbvTw7a9Lg3L/aIaqTb9lNY01eDCBq4In4kpQVj6puDB2gNXaxcaDP3vkw
 rffNt+aAxhD2Sbm9gjiQSb54lSigmjOAeFi5142et1vPpn2qkM7vYae7FqYoz0+NVS//
 OwfUOkcdIcWHypJPGbXkTs7LjdaIHXw/gSHkkNV0zGj8vzcu6vLFYWRYIHCFAKN7j3C4
 RYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334007; x=1794938807;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xgCMUi9hMpttrTWa4BUBP0xD5qovh5dItgbsdQEnXSI=;
 b=k/92+aOjLhkDNM8FaFnA/+oIwLLBYdJhs7J2C5QSTmaHgy6jQbnOy5BAbxZNaUg3oA
 RxuAZQyDYMCu0K+aL3RViLVVu4Ej+T5mZKy88lTuNnnCgPXMKbIsSVegSExfPssZiWa1
 NrWkK3U8lK046D/B4Nj0TQwLsyYUNyQ8Rjxe3Gi7ZZyoMYRKGJUj7YwaFdhIWTFhxg+T
 J7guRBwcGpC9VuEDNMmP1n72zUedVRq6+6oqQqWv49e8pIglVIjm2e+eUs2mPLG/1XM/
 Tf9WTPO5gCeXWVTvdFo254ckuZftYnqQFtTSaMx++bnpksY2rKect32SbAf5h/vjJ/cM
 FL+Q==
X-Gm-Message-State: APuU4Z87UbCYWM5Afrg1G8kfhCX1LGHAuT4Tkhdr5KFrID52ZgEEv/QM
 Xf+rYStz3RD08dNNqSPF0TIijmGIysuGbfHDsmsKML/YfwO8+D/CSoT4FqAusKnEKpdC9K7RGs2
 GJqdS3dw=
X-Gm-Gg: AYBFou24aNZFdGxKjjdYT/ZKUpP55bKdteXxt0tY8DXKY3q05FAHry25sodr9Uqzy04
 9o5WVre8VEqvmZUBhb9Br5jmsCWMjawwKfwIMO0ToVylLjmoIg8VE2iUkty0s5NEX94/0jaF4wT
 Iw16Ys5Px/DB5TlyID3LXQFpPNisi6kJmsE7P9UYGpXzgYNaX9gr3QEq2fCAQxuew9MAPyVbAqR
 8ud6urE7OlM7+nTDp7Kq/JP4VcbuGtMBv47omJHb+82P7Hy0EYKC7H0X/i8wuPnFav+iaWqsUbl
 wUBcByJijMci/nZiY1U8olGjsjXJVbMQs2XGsIXN+sClH0y0eYLn9xV0TktrzsCJP0pHBwIBOtQ
 mGZGXeuLXvy7jnfhXg+0iC6/owwBXhG+zpWiq46UV6yszfFIdD6WGp6x27PlHpD0MsO+N1amrPX
 1mdNlLyRa5ywbBLQ8DiJoraNhbY/QWpWrBQ76p8F2lnefkurk+uC76sBPLZQNAbxqPJO1F41poq
 CwcmoUWvVrNb2kcIgtTG9/7/E2QoqZT5jAjHjzj6RNTiBLYZLGqVsEDTaxR1QJwh6w3bqduGOP/
 btWdEWct8cULAvdZuq+I4Y8l5uvYnwLYbWFcn4NCLaOqzcqqiYfnuU3/Nc0PCV+SlST5XIOE0pj
 HQVE+ERP5atecNmmGjFGlr9JL3q06ozt2/A==
X-Received: by 2002:a05:6000:25e9:b0:493:59c9:ebcf with SMTP id
 ffacd0b85a97d-49831432d19mr6093526f8f.57.1794334007333; 
 Tue, 10 Nov 2026 10:06:47 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365cbfc6sm6670903f8f.41.2026.11.10.10.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:06:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-stable@nongnu.org,
 "Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
 "Jason Wang" <jasowangio@gmail.com>,
 "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
 "Laurent Vivier" <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Zhang Chen" <zhangckid@gmail.com>, "Li Zhijian" <lizhijian@fujitsu.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 for-11.2 0/3] net: Consistently pad short packets for all
 backends
Date: Tue, 10 Nov 2026 18:06:42 +0000
Message-ID: <20261110180645.2072237-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes v1->v2:
 * squashed old patches 2 and 3 together -- this fixes the
   problem Akihiko noted where patch 2 makes us stop padding
   packets going backend -> hub -> device before patch 3
   puts the padding back again, and also means that you can't
   accidentally cherry-pick the CVE-tagged commit without the
   required changes that used to be in patch 2
 * added reviewed-by tags and CVE tag

Patches 1 and 2 are reviewed and ready to go in (they are the
actual fix); patch 3 still needs review but it's just the
tidy up of now-unnecessary code.


Cover letter text below is same as for v1:

The net core code design is that by default packets are padded out to
the ethernet frame minimum before being handed to a network device
model, unless that device explicitly opted in by setting do_not_pad.
This avoids a whole class of bugs where network device receive code
has to be very careful about handling short packets.

However, at the moment we do this check manually in the network
backend code before it calls qemu_send_packet() or
qemu_send_packet_async(), and we forgot to do it in all backends.  So
you get the padding for the slirp, tap and vmnet backends, but not
for the "minor" backends like 'passt', 'socket' and 'dgram', or if
you configure two network devices connected by an emulated hub.

This series fixes this by moving the padding code to
qemu_send_packet()/qemu_sendv_packet(), so that it always happens
regardless of the backend.

The main bug this is fixing is
https://gitlab.com/qemu-project/qemu/-/work_items/2362
but it's been re-reported multiple times for various combinations
of network devices and backends.

The whole series is cc stable because without the padding you can
provoke various bugs in different network device models.

thanks
-- PMM


Peter Maydell (3):
  tests/qtest: Make netfilter tests accept padded ethernet packets
  net: Set do_not_pad for net backends
  net: Remove padding code from net backends

 include/net/eth.h                    | 22 +++++++++++++++++++
 include/net/net.h                    |  3 ++-
 net/eth.c                            | 18 ++++++++++++++++
 net/net.c                            | 32 ++++++++++++++++++++++++----
 net/slirp.c                          |  9 --------
 net/tap-win32.c                      | 15 ++-----------
 net/tap.c                            | 11 +---------
 tests/qtest/test-filter-buffer.c     |  4 +++-
 tests/qtest/test-filter-mirror.c     |  4 +++-
 tests/qtest/test-filter-redirector.c |  4 +++-
 net/vmnet-common.m                   | 11 ----------
 11 files changed, 82 insertions(+), 51 deletions(-)

-- 
2.43.0


