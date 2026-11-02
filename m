Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6446606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C5zw9qc4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyUV-0006zX-EY; Mon, 02 Nov 2026 15:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUI-0006yp-0A
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:38 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUG-0006iQ-BX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:37 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e04773687so1036379f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650715; x=1794255515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vgCxVsbf3vC1/m6/qXQZLnDeOO+thIG1wJU6PgFSPWc=;
 b=C5zw9qc48BCI5kv5C+WwGaz/RMividM2kv/4PqkNaUBvhtNvB0C6jfk5RAZUUSsE1t
 PETxNoMI1P2/7Ztz6ZIIL3vGaMmMVOEVT3fGtYuegUW2IdZX7di4gLAoJRziJfKyf9y6
 HowpA3uj1qfgbALb7Jnw242vSwkTvSznPtXmgi3oY1nhmro/slYbULxCZX6AJ85uWb3o
 wAqmumFgE6MMN+D8ibwZUM6t5brcvhrhCptTNYKHEjOiOFis/RPrvarAzPLN6SjfslVJ
 FG+X/q06+VZKTlDmqn0UxRF0jVIEF08zh4e8g7esMqFyeXLhFae2eABq3ay0omdFa9KQ
 L16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650715; x=1794255515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vgCxVsbf3vC1/m6/qXQZLnDeOO+thIG1wJU6PgFSPWc=;
 b=AbgSl1yHYmjGjgbTNPVeYELOvFFpiistcqv75XxpzlpWuISfKzRLC5spidLMb6XdIJ
 id15R2kD0eeIgcjwvGfCztCwe0jXvR0/lcy6ndCaBllFEd3QyQ4YqygUEfE6KBb1eCQy
 JRvbeXVsXqesB9RMbKZdtxD5Abtp9sH/+r2cd39ReKBNYZVOww246IezbmILyDGoEUq2
 90naTkULZ4JmrGac36q817gMvA3zrN85bHagi456D2hHgtJuIpJ99DLa4NmWarD27U+0
 FS/EgdyIqnNo0kYwJzWgJeWJHxtjUligOZBmxM6zoosSV3hR7z5RDS6T+GcAkB5zr8U3
 zYLQ==
X-Gm-Message-State: APuU4Z9lqmKcSvmsvuRRy3j4JLSzo5A17UbZ3sY3GnipHDq2z147M0YZ
 TLed6WDPhWQeBjuiOo59PJZxzacNEnr1UTZQWOgJZkKKHcWaGa9+ccn94S9cSuhDEWCxdFdyVk9
 /5VUa8mw=
X-Gm-Gg: AYBFou1fqJ5lXIA42VFqi4o0yXPi/Wh5oRXp1cmqP76IKMJ1yQdNNq8g/ak4h23zZH/
 4Lc94UfwLR8ERTAlTZ6kTryVeq+9lCdNeSbjVbe6aDapVKuJTfZWX+cnc+jCbO0p9Raoq4kDZK5
 2kzaMdX4nGzIqWr7qDlgebfKZtS+7GXaSGY/BuixRmBWliOhKL5QaWf85yoi55oRn3yevowhbkw
 gvozz08KgK+Pyt7R1xwMAhBF08cm7omS8DzFxZfqUXuXPNs6AwUg1rPq0syGcGXQ8m87MlPXFu+
 TJnC4rB9zH2h3Lv7fWHFPnzHcGPU5v81AVeELl7kam8mZpSgFol5xvJKNFrFR5WY2OGRai/2a+h
 WbguBx1aX7WSHwLtRtD+GZr8mH2MjaE5CcOl11H9V2lEY9Pqdueitz354MRzEhxtuVqSoGPYVDW
 Mpc1GcHH5ktXssrgbHnG8Zm/YFOVxQT4JlFXW/K/TkLV+M8UU/4pfC5Hlp8HCBa/7xnm5uswRQI
 2V7BArQaABWbow3KtozuWPQ1kwMpvDBjD9UliFbKjQyFd1e2gbAnAHROKTcXWu6sbn4vh2YACLW
 L0oQQirEdup1b8/HvWpM63/RMwj2TsVHxCLBhY3FqOYkbETVIKBtJsQtefehSb40FfKDohnBtjR
 W5eQZ93kgRouIxFIDtmC++q2gUAognzczrQ==
X-Received: by 2002:a05:6000:1603:b0:48d:f36e:ccc0 with SMTP id
 ffacd0b85a97d-48e6e262c42mr17940850f8f.0.1793650714856; 
 Mon, 02 Nov 2026 12:18:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 03/11] net/eth.c: In eth_get_protocols(),
 don't report SCTP header off end of packet
Date: Mon,  2 Nov 2026 20:18:20 +0000
Message-ID: <20261102201828.1879576-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201828.1879576-1-peter.maydell@linaro.org>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
Fixes: 907209e311 ("igb: Implement Rx SCTP CSO")
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
index bc26d38dc21..341d3bdf02b 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -213,7 +213,14 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
         break;
 
     case IP_PROTO_SCTP:
-        l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
+        /*
+         * We don't copy the SCTP common header into l4hdr_info, but
+         * don't report SCTP as present if the packet isn't big enough
+         * to actually have an SCTP header.
+         */
+        if (*l4hdr_off > input_size - SCTP_COMMON_HEADER_LEN) {
+            l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
+        }
         break;
     }
 }
-- 
2.43.0


