Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A6606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZQYbd9Wy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqFK-0007CA-FO; Tue, 10 Nov 2026 13:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqFJ-0007Bb-6F
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:07:01 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqFG-0000IL-6a
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:07:00 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso1273713f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794334016; x=1794938816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xgCMUi9hMpttrTWa4BUBP0xD5qovh5dItgbsdQEnXSI=;
 b=ZQYbd9WyvZnuME4sg3CbfvD1pDWBgYA4u/xcNcYLb6quHHWXFI2dBq/HDeJk6s1Rfd
 OYsT5auSWwDDYAX24oDbScKocF3yB7T6ulp//QcsOnLluKNHmbUT+kDRExs30om6Vysz
 M4UHepmpn58Ozom1z2wXt/hAMjaP51vLfpej3dPwHDFo/1it8qKkHdmRX7OZJWOtbara
 xApx/eqKx+B9kmfKfXhug8RIDnVAwIFzGZ5uZDY4v5R5uPWo2QN/4jHiP90x4HSA6CNW
 i8H6ql6G/1HLhCGzFwUQDKG7UBWcjRF/Zd/dkvTHZKwlAqO+/V7rzNPuiECRKF2D3ayR
 b+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334016; x=1794938816;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xgCMUi9hMpttrTWa4BUBP0xD5qovh5dItgbsdQEnXSI=;
 b=BussGnE9muy8KQ+RNr1uCYgcPiI90zdurxXt+Bc1BserHcSXuS8b6pvw4i5OhZZCtc
 r4kFWL54mFdQU1XjJeOj/dwdK6opE7rmlLD1gc2U396bvzMnVaO49VJ4mCBBTEjRAjWE
 XzzKD9BV0eoVX+qznoTn5UvDBMjul6aQr/p42ayVceVGQsVVY+Ju0Vns9N/4eknt4OgL
 D6tC/wB38mH1pcmEDaHNp32ArZNjPRap300PTIgIQeeABbkHEhj4/oSSj8psuNdgZkIJ
 Pq+aOKnbaRupBWRGnZx24BlN+oSuqYMc6pZA9PuF4YwfkWbllzYpaDjiwEg1LhTQYCK4
 XnpQ==
X-Gm-Message-State: APuU4Z+RNNJ7HZdv/sZgchF6jPmiWHjyEekdpzw+GaZkkHq490a9jsV2
 lOMrFPcVfkXWVnoBQmDlghmM12hMtuu+KZqWcWO/CKhO9ImZPujp3KgaGUazkfvW4XWulT/aJHH
 JrMn2fQY=
X-Gm-Gg: AYBFou1sHcSn246D6bH28JgfywIcWQsdHorW5Jf8rGrmTlTGB++EnXp8fciP2TYde34
 TCiP4U5WvR8XFflAKHjpTdTXrPdA7sqSLOrqfnsvAuPnZwCyVn6OP+xTcPJEtNtC8EpJeJfDtA1
 L/aDyH5nWCyo3osZEaMDceWUJanoVil2T4zuBLm4i57S+DR9KRZO5paR4RVAA0VoQAP++/YEWmI
 STL7jRzKlRAToLiM2pEgSVK++5rzdjQGb1Hw1ThlbuX7LleYn/oB0Zl/Pm4OpcstX2f4Xe9Rpof
 D629OOFkqzxcge6Byz3SLxdseGf6rbjvo88AEohoTW7U9DL18Gh0QpOW7vc6cH6kQ+xl1UO1AdU
 taB5VYR8dvI5rQMneJJQQj3phSbn/43SjW79tJ8+UI28h6tYn3P6V7vYlPQGS+FXXYN5nhqpTOr
 HkMgtqRevKpFzFT3An4F/GHjS+ht/k9AUfxvi2/+R4z/ypdaRK5gd+VaCnadimQXrpxUh2iB9cA
 Mu+LgxBdENrdOphqaYVZi3+qE128Pcj62o97/9efTX5lWP989RXveohSFz9gTHXtQlnX1pkS0GP
 H+wSavl1ib4pAdQn6UehI5q/WQVO9ec5qgTtK1K30Q7DDI8KUT7ZAYfJyBsIZILeiDQ4jFxsLPP
 qDoPj5AVdG8FlsbkO69AFNSyoj4yMy0Sfdg==
X-Received: by 2002:a05:6000:22c3:b0:48e:5db7:fd6c with SMTP id
 ffacd0b85a97d-4982c2d03f7mr7698522f8f.4.1794334016547; 
 Tue, 10 Nov 2026 10:06:56 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3f4esm6825701f8f.53.2026.11.10.10.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:06:55 -0800 (PST)
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
Date: Tue, 10 Nov 2026 18:06:52 +0000
Message-ID: <20261110180655.2072265-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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


