Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133A606A8B9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bFd8WNu8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSued-0003vB-Lz; Mon, 16 Nov 2026 06:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueM-0003qv-TN
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:28 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueI-0002AT-1g
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:23 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso2737603f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827600; x=1795432400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wvLYgJXw/izo9VYCdQNMzOW7fc8DozKo291I/rkHb6M=;
 b=bFd8WNu82iG64daQ9Q4NvjgYPxKHdAIbxqIMxsbpiZ5Ca3o9c9J7IXiQAQhYp2VGdR
 IJjhpPmORSsE7y0TWmVANbiC7yA70cBJYmPXssuZGggKw9sTljHZ6umz1L7WFejDuaK2
 25c/jkWY1S3qA/6N1Nnbn6sH0DB+Dq9XNRYI3FtO0NF+eOhqARGkzVo0imwsU06Z3c7+
 WFqR0eS+ciFZIcX7giHo0p9B6ltaaLEMecjMfk6RUEvliO573obAjcc1hPdeyqVcBshD
 6CONMqIpOFCtWlmmDPePvr5UaB2Ynsv+E4GfgdF3Op+tMDxh41leC2Knusbq6TDPkmfm
 1JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827600; x=1795432400;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wvLYgJXw/izo9VYCdQNMzOW7fc8DozKo291I/rkHb6M=;
 b=WEzsTVgxEWK7Dxav/heRt/sa4ep+2Cj4KFATUrOnoSpVI97WY1E8mPWHFT+YdgkeIP
 TH5Nsb3tVm9U1H90QOz5C16rwmideUmE+YghL+WjP+R46mjcSxOH39ixpnX1yHr1GwTz
 y5bHOb4YEzHnlhKEJi7/40h+LFAXDQtf3PFsxT8K2XqGu4Cg0Mk+af9A6pj8Ocf+bsAP
 QJT8twomVHtp3PcWErjcl0TcOnru6Q6yYnellHxfytAQYJT1K9nQqWfvKH92q9AEfFWx
 bUe3R8L0ySvoNUSrXb5EFr4vj/T3GqVXsDnz7+xMxCiDoYOUgLbbKPYxzwMN6TKJcHRd
 Wcow==
X-Gm-Message-State: APuU4Z9efBnEpQC+zQdeVCrMNaWGeKIBpry4q251ewQPmqPVsSR9oIs5
 zy2YEcNtak2A/oAL7KiT15O1GGjOgW7B+l0lMlC07QnIvu/+ocs64qpCdo8d4wLl4m2r77Lfrri
 q7yE252E=
X-Gm-Gg: AZFdTZcOu95qK+UeTSjPHTSnHpOUOuSJQUC7F2fPXOF2z+DlKan6DkbnUk+dIgmvH8J
 A3OWKtQSvLtBSPCw+wUiUm0xqFXvno213D6gNMeVVeBtGJub7p9D58VjnrNw3cIctLlST3ah+Zu
 3iAvD7pYjaYL4kwZhz/CwNYrSU/zHyFrarVroK2NgCxlF5YPgre7+34wqoMWXtTRdH2OMsklFud
 g20gj5o03IhBvGWTh2D6+KSc0o1gBuEV8ugK+liSjn9snJnU7J5h1vEltCqaPoZi9O0b45f5S28
 CMawMnMFYTCO8HFUogCnFaZEx0uigSBe1AGYdZ4DtD9oizFQzDYY5nhKURVtKLAR/W0fExF8Ojq
 EU1q9CheRkhThBQ7/dUXNrLZMEpl8T274sWbVNR05iWv53QGB92E+zkLjC0OtbUqye+EOQuba7a
 XoNQD872QbKlFHK03jVqE4bE0rOgBYH/EKWMwfGy2spU+qbA7ANpSKOTid7xlqroEtBfewbCQOX
 3mIWfHYm+DZp5VUy5AoTjNxZT+GueXj8w3/MJX7isarqM4sCUcYvj58jKLDAuRer1hc2goMtkm0
 DADMZ7HOp8MFISndBclxIm54U6Az9eF2XGsWp4+JWgEDcCKhWJ0Yhkm3HLX9UU3iEshc6ykCpZK
 CGX43AyzwpsA/OgIZY1gMLQaF1ZfkO1JWXQ==
X-Received: by 2002:a5d:5f47:0:b0:491:d224:aa78 with SMTP id
 ffacd0b85a97d-49c713ae2aemr22664891f8f.26.1794827599733; 
 Mon, 16 Nov 2026 03:13:19 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/33] net/eth.c: In eth_get_protocols(),
 don't report SCTP header off end of packet
Date: Mon, 16 Nov 2026 11:12:44 +0000
Message-ID: <20261116111303.1692832-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

eth_get_protocols() parses an ethernet packet and tells the caller
about various offsets into it and other properties of the packet.
For the L4 protocol, in both the IP_PROTO_TCP and IP_PROTO_UDP
branches we implicitly check that the packet does contain a whole TCP
or UDP header at the l4hdr_off offset, because _eth_copy_chunk() will
fail if the input packet size isn't big enough for the whole header
we are copying out of it.  But for IP_PROTO_SCTP we don't copy the
SCTP common header.  In this case we should still do the length
check, so we don't set l4hdr_info->proto to say there's an SCTP
header present when there isn't.

This shouldn't have any visible effects if the downstream consumers
of the l4hdr_info are conservative about checking before they access
into the packet, but checking here too adds defence in depth, hence
the cc to stable.

Cc: qemu-stable@nongnu.org
Fixes: 907209e3111d ("igb: Implement Rx SCTP CSO")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-5-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
[Reversed the condition and changed it to use input_size - *l4hdr_off]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/net/eth.h | 2 ++
 net/eth.c         | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 46dc9ed5acd..e10684ed923 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -394,6 +394,8 @@ typedef struct eth_l4_hdr_info_st {
     bool has_tcp_data;
 } eth_l4_hdr_info;
 
+#define SCTP_COMMON_HEADER_LEN 12
+
 void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
                        bool *hasip4, bool *hasip6,
                        size_t *l3hdr_off,
diff --git a/net/eth.c b/net/eth.c
index a444377fd0a..55d85cecd1d 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -223,7 +223,14 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
         break;
 
     case IP_PROTO_SCTP:
-        l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
+        /*
+         * We don't copy the SCTP common header into l4hdr_info, but
+         * don't report SCTP as present if the packet isn't big enough
+         * to actually have an SCTP header.
+         */
+        if (input_size - *l4hdr_off >= SCTP_COMMON_HEADER_LEN) {
+            l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
+        }
         break;
     }
 }
-- 
2.43.0


