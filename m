Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FF606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tZNfhZ1C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU72v-0002kO-Iu; Thu, 19 Nov 2026 13:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU72u-0002kF-RX
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:39:44 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU72s-0007ER-Va
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:39:44 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so99945e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795113581; x=1795718381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x5MT30AeIP88DtOBkXkVzKqlEFlDUDDAsMGVfJvjl6w=;
 b=tZNfhZ1CJ4KQMOez334AzabfBH8xFQI3sKZmmtUlm979EU2a2o1WKPsTceINjerhYc
 Ymz7HB8qEWB3vyErtqiYFzm3nlpznKqe/vKeXVq8kvkUWRUcGLkRwK9BuVMY/FmIkc2K
 0JbEtAK2hV0r4UvYEYj9VcH/KwPUv7BIcKhWhDMB9gyB4TOyicdgavpVrAFUGIclGCOY
 5Ei6O2/RIaDp4em4/GXKnTs3j2XIo/gaK6xOpnYOVEIupnpvH+Gd7ybKfeFwuY6+JzYh
 5xmvHRNOoseOOXqTLD5VU9amxnk6NFkKTrD2iyZ5sxXzl76xdHleVZhH+1F2/dzLfz96
 nGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795113581; x=1795718381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x5MT30AeIP88DtOBkXkVzKqlEFlDUDDAsMGVfJvjl6w=;
 b=BSa6sjBlUD3snaHnp0O8bgLn75VhPNV7SQ+eayr7LYHQCq2uSZ5YRUucm9iuh40aXK
 mciqTFt5ddYJi5P31/gRfmqca3n+143c9x980Ju/wdHnCLBf+qdMtnSNndDwU13Gr6f5
 uev7MxamJDszDvz9oesviVPuDYVx6b7UjYl5RAtopEs6LX9PuLmK9B7dPF/qHXEWVazX
 8Lpe3j8ioLNM6zwmgP8df2H2RD9pLM3ikP4L5OqyIW1DkT+9UOpaDutOAoNFqg5IJAbc
 AAKNTwR7m60sjxrSLdW3LxIoAyUOCoZw+sbW8mXEqcF7KIL7DZCwvUJxdREDlXKt6M9W
 IrPA==
X-Gm-Message-State: APuU4Z8stkkA2RTW5UR60/O1/5qFZoEguoAfwSdXi1tM6/FgSABHnQ+J
 aMIiMhcaVE4zdU05JX8ugXy64tDQTtSmo0kmjzdmY3EKuMRNDBAKCA1i6vqdhdbsb/AxiTEAR1G
 edlHHkvY=
X-Gm-Gg: AYBFou2Sy6zZbS/gFWHvUoznHsdo28Tfe1P5IWBZvdDU+zFjbD/IL/ea15+ZjxSHAXX
 GR8dYg7/QBySr4tMjISavijwp4u+luo+Qa4fXkcUUNfleFao8QuMJDGoFlmi6Kej6AEGiN/JNYW
 gyY0Apg25EF0bPFRx+LtKALGCW1chpSz4GY1PWjtMeswdJx05gRP2BGLkQeqGgitsN/LMB6FWzY
 70QCKn0mhKzGNQCwNjJVlK6B2X40o8/33rmOq9kwn6mc5xVoBrjf0lDzfdfg9eug55CC51a/66t
 O0HdOqgJtxBqnzChOQi981sBc9NqHMRFM2Ik/jtMLirTGv8Xszj2DAjLe7PGC+b7UCnHykPBbge
 Cq04pY+tFteZCh3dCtPEngWPHamKQI7byruprJz9hKStiOHrrgo88byuvgIaQXRgzU8cqjoqD8D
 EXFgjgf7WwmwT01B5cw/biK+Eah44wM89F86PUqxSdywvL8wwTB/BCC5IOVHsz6lsEfUKn9UUFs
 TkThIYzWtE4g2K6A8K6tEAwUUj5bh6Dv3n/d5uOzxluG4UpX9L6R7faq5aj0rsePfDSu/l4i+wx
 Bpz7+/qLkd4f2fSKDGCk3js0/ynNQc1dwxhhDbgp/1riGPz5IAMo62Qqo6D0h3CkfBOFGyCZKuN
 NK30f90awamaDsJ73x/BvpdxEjpiKvyCjhQ==
X-Received: by 2002:a05:600c:46c4:b0:4bb:6a5a:7834 with SMTP id
 5b1f17b1804b1-4bb888106damr9176825e9.20.1795113581345; 
 Thu, 19 Nov 2026 10:39:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a680483sm1027213f8f.28.2026.11.19.10.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 10:39:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH for-11.2] net: Don't assert when net_socket_send() hits
 EWOULDBLOCK
Date: Thu, 19 Nov 2026 18:39:39 +0000
Message-ID: <20261119183939.3421111-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In net_socket_send(), if the recv() call returns with an EWOULDBLOCK
error, we continue in the function to call net_fill_rstate() with a
negative size.  Before commit e9e0a5854b6dc, this was harmless, as
the loop in net_fill_rstate() would not execute, so it did nothing
and returned.  However, in that commit we added an assertion that
when the loop has finished it has completed handling of all the data
and the size is now zero.  That assert will fire if we get
EWOULDBLOCK and pass a negative size into net_fill_rstate().

The code as it stands today has this flow of execution because
originally net_fill_rstate() was inline inside net_socket_send(), and
so it was perhaps a bit more obvious that it would do nothing for a
negative size value.  However, now it's out-of-line it's definitely
confusing to call it in the error case.  Return early instead.

This fixes a bug where using -netdev socket for real world workloads
tends to cause QEMU to hit this assertion. This bug has been present
in the code for a decade, but recent changes to io_uring code in QEMU
in the 10.2 timeframe seem to have made it more likely to occur.

The same problem also exists in net_stream_data_send(), though this
one hasn't been observed to cause problems in the wild.

Thanks to Alistair Bayley for tracking down the cause of this bug and
suggesting the fix, and to Travis Frisinger for providing a
standalone test that triggers the assertion.

Cc: qemu-stable@nongnu.org
Fixes: e9e0a5854b6dc ("net/net: properly handle multiple packets in net_fill_rstate()")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3285
Suggested-by: Alistair Bayley <https://gitlab.com/abayley>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
These functions could usefully be simplified to remove the gotos,
but for this bugfix for stable and for 11.2 let's just do the
simple direct change.
---
 net/socket.c      | 4 +++-
 net/stream_data.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 1ad03fc9d45..eb0fc4e404b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -162,8 +162,10 @@ static void net_socket_send(void *opaque)
 
     size = recv(s->fd, buf1, sizeof(buf1), 0);
     if (size < 0) {
-        if (errno != EWOULDBLOCK)
+        if (errno != EWOULDBLOCK) {
             goto eoc;
+        }
+        return;
     } else if (size == 0) {
         /* end of connection */
     eoc:
diff --git a/net/stream_data.c b/net/stream_data.c
index 73b45da9fe3..5dd766cb8cb 100644
--- a/net/stream_data.c
+++ b/net/stream_data.c
@@ -101,6 +101,7 @@ gboolean net_stream_data_send(QIOChannel *ioc, GIOCondition condition,
         if (errno != EWOULDBLOCK) {
             goto eoc;
         }
+        return G_SOURCE_CONTINUE;
     } else if (size == 0) {
         /* end of connection */
     eoc:
-- 
2.43.0


