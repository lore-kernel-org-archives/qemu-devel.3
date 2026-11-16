Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C04606A883
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S6ovq8++
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuee-0003vi-Au; Mon, 16 Nov 2026 06:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueU-0003s8-Ou
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:36 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueR-0002C4-8l
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-491846221ffso2996486f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827609; x=1795432409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RHrYP9A7x+UL7YQcUbon2OHooVJuSg4b3FVW4Ndxt5M=;
 b=S6ovq8++P4dxLej5STXq8SZ0VSN67USDcP5W0Lf9ryHKkXTrNc8s0gAdGgtC5cXBOv
 aYc45LVoS+mmLcGLLAGagCa8TFqSN7aj+orkhSNMTCIBgKv8WBgiCndsmamdle61sbRx
 dKrKC59g7Z71D4jAB2K9cCk+4Uz5td41MkaZTpq9yjs/1kxA67Bfr8kvFqeeKvTOVSbv
 zTS8qM0b/vYj0sQ6vK3duCDHNQzvOdvrTK6dVwV1jgMDRD5u+VbAmQj9Hmqv1wGoSOWt
 O6rqGO6v97HG87bNhPcABQkjdCq7g2+K1s3Nq2yvOq/ENr41xdCwENBZLRszj6v5sJoQ
 23PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827609; x=1795432409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RHrYP9A7x+UL7YQcUbon2OHooVJuSg4b3FVW4Ndxt5M=;
 b=UuAQk1XZXbtRORn38jp5R+ErXIYf4P+ZaimFEjjzqIVqrXEx9rVuywhH0yLGuPrMTH
 hECbiVqnZXmF5aMsrmi/4cAG7IcQj7W8wc6561FQ9cCD+/YvZ6N+m7FB8vfjEbT9NoNc
 4kXWj5BFE1y0GIE9+J5Wl1j4mMlKDxsDX2f/ljk1OQKB0G8IQAsV3Vw86/lhfopBdItr
 TkbqIcOmcdzFlvAuXZvtBQxFb35dJErx5f+yH4FEcReJDiL1OZyhZoX5wcgFIXgx59do
 DCGo/w5O3nqu39jZKlDystmeTLGB6X2dfFRVrNZQ5i4KqHi1k/EQEmUoSWIfYE3U/4Ig
 hXLQ==
X-Gm-Message-State: APuU4Z9NoRzEAqE1wBgFy4lfp0cPL+mK8JYKUhxcGcloLkNk38NFzBW3
 L3y9RIFiixsCQ4jT2BwaqwIsR79oc5Vn0cNie4B5FjQfcT+EW98gJVxrJ1TrgonTDgpP/3N/bdr
 Bao1mjSU=
X-Gm-Gg: AYBFou2ntpCfeFn7XJKcfk3y4QrP9To3iCoeth1RZk9uNeiLXbYNBCBF+KgQvGayCv9
 4SRQf7pvNfpKYl8B3Il6wIdrYxfRJaHj0lQ2HmwBbT76GlGfFPLggcP+JEkit8sZWnpYIwHpNbu
 0ZxAXyRabDeVWd+qUvZO2RdbkkPOWBV9HFdb3xx2ZgCcmM7FT8c95+ysRreU4R42ZK00iLaEKBj
 jY9jtx+E4akCM/cyXiBZ/PBZXEJMKLDKzLMUmE/co2UEjyxp1V9/TogNbfEAskCMcnH5yaK3sN2
 bftSP6sCfA7wQlmQ5AeOWxvXyxdytv/GoI7/joWp2FgCCEkBsbcadLWnfBbbo3khFLUG9sCC4w8
 EjS5gVtrIItOzoybT/3IKGcMjBfJ9wOCR6GoMiIR42VEYtytf4EpqLf7l4bxmmyAyP6CfS9IqXi
 86pNmPpcQmGm/e/uDwGz3MTVj3Ep+UX+5kDBELfElKagkXN83m1nB53YBDSDUb+TmI065pd5/Xu
 zyz4Q3fkL3bOOwFJ3TUJ5ri/DruAnVzb9tm1b766+/PXbVzQ6i2ZyOoVczS+8V6pDpSMnjXV7jQ
 WaPA7dqokRRjcheoyRJTeQgwiuDE/lBPj4kKlBe75LFpESlTzZnz7YXq5x5xMlNBC0IPX5maN5T
 EKUMvKiFlxrazNn48bFU8jhsqQpFi/kKYPA==
X-Received: by 2002:a05:600c:800e:b0:4bb:6fd3:5ac0 with SMTP id
 5b1f17b1804b1-4bb6fd35c5cmr67778235e9.28.1794827609121; 
 Mon, 16 Nov 2026 03:13:29 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/33] hw/net/net_tx_pkt: Sanity check L2+L3 header len in
 net_tx_pkt_parse_headers()
Date: Mon, 16 Nov 2026 11:12:52 +0000
Message-ID: <20261116111303.1692832-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

In net_tx_pkt_parse_headers() we examine the L2 and L3 headers one
after the other.  Add a sanity check that the two together don't
exceed the packet length or the maximum IP packet size.  This
shouldn't happen if the L3 parsing was done right, but is worth doing
for defence-in-depth.

Cc: qemu-stable@nongnu.org
Fixes: e263cd49c73c595 ("Packet abstraction for VMWARE network devices")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-13-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/net_tx_pkt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index dc2563721e8..c331628134e 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -267,6 +267,14 @@ static bool net_tx_pkt_parse_headers(struct NetTxPkt *pkt)
         break;
     }
 
+    if (l2_hdr->iov_len + l3_hdr->iov_len > ETH_MAX_IP_DGRAM_LEN ||
+        l2_hdr->iov_len + l3_hdr->iov_len >
+        iov_size(pkt->raw, pkt->raw_frags)) {
+        l2_hdr->iov_len = 0;
+        l3_hdr->iov_len = 0;
+        return false;
+    }
+
     net_tx_pkt_calculate_hdr_len(pkt);
     return true;
 }
-- 
2.43.0


