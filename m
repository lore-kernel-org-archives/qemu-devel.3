Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0696606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OV8a/sOS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlFq-0006ma-Fj; Tue, 27 Oct 2026 13:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLlFn-0006ly-UE
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:46:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLlFl-0000iY-C9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:46:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so907075e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793123187; x=1793727987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8t7N56HA8ls37YiQ9Zd0Y1zbjHwCFI5k6cIHVyMmAFE=;
 b=OV8a/sOSTX7RdwJxeAVLUvkt+rYMvNX6dOiBPIJmDfGutIoxf41+rKDoqzHx/rMa3Q
 rXISK3uzU5k+Oy6NNvFYuFHwXDTl/kypeHDOxW05GKH9Aucz1MrRqWd6IwVKUsrSnKJD
 ekQnEIlpEtQ6quAMKMYBEP4lJr6ybuaolutPQMNeYVYIWXSMbbvVCKn4idK9W6Ayl47Y
 cjSesMPND1YdLFiLJMeiG/kGZZxMSZKFHa5LyHClsHNKsEZKTmf5p+mJs6kqorF4SgRs
 Cb3fnUczJMiELlWOfw9DKMS7vGQFCZZW7h3CpbvU4i8rMpCCDCAlEjX+mwhYtN8A490b
 mG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123187; x=1793727987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8t7N56HA8ls37YiQ9Zd0Y1zbjHwCFI5k6cIHVyMmAFE=;
 b=hJTyIVfJF266M8y6W8yaVbmElbZ8WUMAyW+4Mumdg0jxRWz4h+yndBYFbPqjrgosAS
 WGyZUltQR5PLTPVo+nMFXUFgbgV0e7FlqlFWFWckz750WHcHhr92onHk0Z4hQcWQTpqR
 klwVSnoSGG3P1baoB5p8bhefXTWeaoCSxWrdmupSxoFqt/2xn5gZphYBORU0S29YjmTq
 kMIt4dZ8UPvGZQwesQ/8RGbY4OUNlhoChdbqG0byh/MklGQbPlEbHrZfTDvFJH8Ccvjt
 2QimKhI0KK6f4Qu2dSjVj6Ncc7mzDMSfAZmN/SrBA5iDjiqEDkt8QP1WvP5xudOueOPN
 Naig==
X-Gm-Message-State: AFq9FYKme/T9P23NQacexAr5HipyIX5g12jlGEPF+ugxhi410liOBL4y
 0O9WHYWVgclS/f8zEaT0OTB5PjBZeWrcrxYJScjmbALL+SgGA/txQqlI801m/eFVneab4z8iLi/
 4zsgofNw=
X-Gm-Gg: AYBFou3id8ASiYDmrhieFzJsNWi6UiLdD3tR+pTZdzZnk6DO/LFlixjlPb2IbzvHkaq
 6jZwxNo6adC4Z2IeyoSTjDCVsVDXr4sXE9qkzdmcY0J3mnC7CeOYEguodf4/YgADFxfDOts669B
 JJK4apKVEgeSyRvNKMp7DtiGEkRLT7H4g8nNI7UK3od9tgJ8MQP8NBAg2jEXpAp/o6Esr52DAm9
 N0OOwgXl66mGrXX14GIq3AkSokbdj9ZjrRzs/0cGPeUIqMquTCmopIZ0w2wjoani0Sj8dVXZUo7
 DGXzfTDyz5GZOezXTZKXBsHPJvJb6CZmYr9T2MTYmHnxUc/96Pe+BHQhbE2MzoF46toSOSF7sBy
 ldbxpqghxHdc8+mbtrZtX3kTJePccIH8h1s4P/4I5wgLSpZkD872Ax5QMsUUMa9fJhQdQe9W+nk
 IT5hg9WRdPe4KxnWt0MvTHn/uNrDpTm5KorFTHdQJy9jxavAaF3oAbpR1n84BmGhYN327kT/+PR
 dtwT+SzDhmYB1pnwIR/MSyD6fWqcxo3hCnIB2vLrylN4F/F6+tW+j6JTIdn/DJtYGB+68Q/SG3C
 Z8regXW5hf6vhjFt09vY1hHp8V8SNx98eMV2b6YG2llc+nz0scPxCdw7+OF6
X-Received: by 2002:a05:600c:3487:b0:4a1:fba8:b13d with SMTP id
 5b1f17b1804b1-4a35ac8c231mr219422655e9.9.1793123187561; 
 Tue, 27 Oct 2026 10:46:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92b8812c5sm5518875e9.10.2026.10.27.10.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:46:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 0/4] net: Consistently pad short packets for all backends
Date: Tue, 27 Oct 2026 17:46:21 +0000
Message-ID: <20261027174625.4025878-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Peter Maydell (4):
  tests/qtest: Make netfilter tests accept padded ethernet packets
  net: Set do_not_pad for net backends
  net: Pad short packets in qemu_send_packet and qemu_sendv_packet
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


