Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BF606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sfqKJTlD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyUK-0006yx-9H; Mon, 02 Nov 2026 15:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUF-0006yG-Ef
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:35 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUD-0006i7-LW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:35 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so26500185e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650710; x=1794255510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ISEK2AhAsN7I5/oNDqiaM8jvK+KgFvSVBm4YiMvcrzE=;
 b=sfqKJTlDpKsMb01h/ZFS3VGQvUa+F1GHipAUo8hzFlrdzjLxsIPbnsGvcRSKP1Am5C
 t4zkEbfKntaxRDyRz1NlwHPWb1upVUZCn5jeVA4ELSX/W3X4+6TtvpHPj4BM1wZ8d+A2
 sgECkji5sNf9WjpL7BxksUbUanF0RB1UFTHpLkC3C6rKI02yNxIK3roho/KhjFBriLT3
 nxOWBHFjpd+TOo6zKuqEhZWVy3CaFCI9hONSJnHAKNrEEMSr2R5D7cQ7rAR7uxa++qqi
 POhl6EPoi94NhkT3hNKK2gyqkmcQXqXVFNBruf0kehw6nqgdc599T1Ot6sDG0EEixUtQ
 nwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650710; x=1794255510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ISEK2AhAsN7I5/oNDqiaM8jvK+KgFvSVBm4YiMvcrzE=;
 b=N5IAOr6eq0uP4ddmW6wTDPYrvISOE5ZnAN9ICozjpzOVjbJ0eijpzCKY6u2Dqy3V3X
 L+nNKSsVL/TN4CTHHKff+QpyovvrTLCXbAQorJTX59vMipSIz6bRMj2Ldx0L3xYLkgB8
 Ko2mRdZmUF45/qwdG5nhxF4gQkTjsQo86JLZyZNPmIX584dx8iKkK1HEDlIpAiGIs0Kj
 nH9rhwOsYkNTM/SzcnrseUhSR5rnfvKuqXNdp3D4FfbbTABo6ay/XInv4cVJsQF9kBNx
 9HzF4Bd37vwj6A3GYFSmr/ulf3vIY5xOOaNIf6D4gHmfTvNNBmycZBbSA8XAy7jpzLv7
 L2gA==
X-Gm-Message-State: AFq9FYKpU+sdnQR0+ByIrtVlXsyrdtgXYri+zTv1aa/gFF1LnjhMpAZH
 XHbyRQACb/Y3ViVycuncKEuTAgJHQJs0v795xGakgLhj1rUDYlQXE3mXO+Gzl+lKF6HBbzvSjwy
 IOBzJATw=
X-Gm-Gg: AYBFou3zOLPnB8HYhP3c53AQp0svUQtbavjol09pGP7BL3eRKetcYwb3i9zNMtKEp/n
 98WDhKvH6o+9Ovo1Qa8Zym23D4XqzYHjfiQ9dEni/xgoIxm9glJcPmzlO+8uzc6l2KG77zo8d+n
 EeDK8+EPnCAaFnME67o9MonyUxnZ5Wnm84oBPn3uw//l6yYC5BcZu7bIPTMpjJni2PQsJG9gfYl
 ybD6M932PSrqVxRPhXFUR4hh1z1TzigmxdKBBMVVMcb4VZ1UJDsVaDjnqu1Fv1eUyg6vHehxVEd
 0NnufRAAiMqpzU5nRs91bmQytPAEhGNtpEautJJospzVnGvnTc8ATxLtT7ppuCrXQ3/TB5mjjs3
 5sZ22ojec6HpwrKw6Uc46NFMqIkf92PvTVu10HYH+wLmmftGxn3YjdugOeC/Qm1kUO1reNlndRF
 oXqQt3Os7i1G/t1/0x0jK7c8RbpGHakSO2qLZejsI3PK+rWVO07TrpQbqpcZy0u7V5XDse6yjDH
 boXus5muBa4qB1vZ+lANB5SaAKSsnd4bstnYBpf29dvqK60kYSiEYW9lscd7jM5Ta6JykF7NpXl
 8JB4g54MYzCMO2UoQFapme5Cax097IzHY9gC27Tz3THJn/NIYld+85Imv891LykmfacGIl3uB2a
 7/SlWBCMAlUEWN9tcE8b5S/QREmk59clCxZQvEEHs7fcBLVhnOBGAtys=
X-Received: by 2002:a05:600c:3b29:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4ac17d19aeamr232718785e9.21.1793650710455; 
 Mon, 02 Nov 2026 12:18:30 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 00/11] net, hw/net: Harden common code against bogus offsets
Date: Mon,  2 Nov 2026 20:18:17 +0000
Message-ID: <20261102201828.1879576-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

This patchset is a set of patches which try to make the common code
in net/eth.c and hw/net/net_{tx,rx}_pkt.c a bit more robust against
malicious packets with bogus offsets and similar problems. In theory
if other parts of the code are correctly checking offsets and sizes
to ensure they're within the packet before relying on them, this
should make no difference. But a defence-in-depth approach seems
like a good idea.

Two things in this are fixing demonstrable bugs:
 * the "igb" network device's use of the SCTP checksum validation
   function allowed a malicious packet to trigger a read off the end
   of an iovec, likely triggering a segfault (patch 1, issue #4138)
 * net_tx_pkt_build_vheader() could overflow a 16-bit field when
   calculating the virt header length, and net_tx_tcp_fragment_init()
   would trust that and attempt an extremely large allocation as a
   result, triggering an abort() (patches 8 and 9, issue #3648)

Neither of those are security issues from QEMU's point of view,
because "igb" isn't covered under the virtualization use case and
"guest root can trigger self-denial-of-service" is also excluded.

The rest are just sanity-checking, mostly based on suggestions
from issue #4156.

The disclaimer here is that this hasn't had much testing beyond
"make check" and "make check-functional" plus "make sure virtio-net
isn't obviously completely broken", which I am pretty sure
do not exercise much of this code at all, especially not the
stuff about L3 and L4 and segment-offload. So I'm trusting the
net maintainers to have a more extensive testsuite.

thanks
-- PMM

Peter Maydell (11):
  hw/net/net_rx_pkt: Handle bogus l4hdr_off when validating SCTP
    checksum
  net/eth.c: In eth_parse_ipv6_hdr(), fix check of input size
  net/eth.c: In eth_get_protocols(), don't report SCTP header off end of
    packet
  net/eth.c: Check for undersized IPv4 headers in eth_get_protocols()
  net/eth.c: Harden _eth_tcp_has_data() against short lengths
  net/eth.c: Tighten size checks in eth_get_l3_proto()
  include/net/eth.h: Make eth_get_l2_hdr_length_iov() check protocol
  hw/net/net_tx_pkt: Sanity check GSO headers in
    net_tx_pkt_build_vheader()
  hw/net/net_tx_pkt: Sanity check virt hdr len in
    net_tx_tcp_fragment_init
  hw/net/net_tx_pkt: Sanity check L2+L3 header len in
    net_tx_pkt_parse_headers()
  hw/net/net_rx_pkt: Check for overflow in _net_rx_pkt_calc_l4_csum()

 include/net/eth.h   |  4 +++-
 hw/net/net_rx_pkt.c | 22 ++++++++++++++--------
 hw/net/net_tx_pkt.c | 20 ++++++++++++++++++--
 net/eth.c           | 39 ++++++++++++++++++++++++++++++---------
 4 files changed, 65 insertions(+), 20 deletions(-)

-- 
2.43.0


