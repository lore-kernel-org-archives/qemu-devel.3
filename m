Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D6606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YDNOKmfF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyUs-00076V-7d; Mon, 02 Nov 2026 15:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUJ-0006yz-Es
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:39 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUH-0006id-CO
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:38 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso1857745f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650716; x=1794255516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ddMCYprMt6aDlaXCHhKy0OvuoupRq5tVuiWJqagyFAU=;
 b=YDNOKmfFGb4NIaTbE/44IctQt6f4PZP+Rg96J5T6ZTzd9y6Ihk/cS+Q3J03GvOTYYL
 jYNrz+cFLCtNL2DHcQetnVmhQ+hfKfsD2E+87OYM7ASF1vb4LwFebB318rZTLx5RNZT9
 av4Ax+Y6NNpOdXHNNFNAPQbUjIt7aTjR8SwxBRGKwyeJshx6GP3K96I/6WKQy5w4PFBw
 oYv5TEPi37/SkRzQPg7POmCuSG7QkveZ2MS79VQBKnM5NLE9VwGNc+S7U9mJUt0+WzUn
 hQg4KpsRZBT1X4nW249swX0b70n5wumStqQ6BZNyG1ixomuF0VFJxcBUSjQZg66qWV63
 qWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650716; x=1794255516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ddMCYprMt6aDlaXCHhKy0OvuoupRq5tVuiWJqagyFAU=;
 b=dAUDF3318qktCHLuQe/4tPfJ+kizFN21LppqULXxjQoACI3IWiXA4xYkfiMVpYk5uh
 ALb/WJJ5ISZd/bvWKWwZQv8sgN63z2hOq39227kYI2nhgQdbTAHn8WuH6xZJE7ew6JG+
 IY/+dG8HUHl1o5bjdHQ9zWFz3UR9GK8objmvfcTeFAxn9uJiupysaq0gq5J4JVRRgtVk
 e7+UL1LfSbIqu/PCl5533jVs6Y23U1jnVZFFrvNKghk5tfsi7KXyDXF1O/FG2NM1Soyc
 UuAO+iw6OmWTkF1GPUSopWY+Ye2W3P8H7v8lJpe7kfgoRj+Y98yzMdacvzSu5tVFemz2
 Xk8w==
X-Gm-Message-State: APuU4Z97jjKK8mwIgUrSkeAsDJLKZckDI4EHkwZ6tYl/iUCLn0jT36Hx
 GQMGIvpQLCJgMYFhifbisYKX5Ut1x51LZSlgWhJafFLyR0D2zC2yQdOljOkC89eqSCIp1tHYW9M
 6hc5BsGI=
X-Gm-Gg: AYBFou2dG21B/QWTQ2TiOIjFh9yOR9SpNsnNBAkIDuWK1hCvh3FACkVBib2QNmxmzr9
 hXAnvNrEV4LhUaNU22Jc1jw4cqo8HEi72mK8e7BanaLhYcZ38/Tj09mrmmdNYcwjZ8M1cB4QQG3
 LpBaePyi5GWKF5VBeBNEDyRetEKqjERZD26lRUWafO9T2KSsw5jll0OjzVi8A4OOtRH4svq5JvN
 i7JuPkVxFotsKRem/8+DD/4FJ4HgCcA4qwbfDHqt7pHxxi2wf6MZI6O9147Nqhtym2oAjzC34ac
 LZhUs/+ARdXcFdLZzQC8WWXtjxc9dpW0vTa4VYWnry2Ss6bwXQP20qRz0AIMr1kM1n83UYdXmdD
 PC1IDqfYfSUQHap1ldFqA6x7H6LpPNXf4sElq42+YFlkpbqjm9oxV6Rv3GjWZRlh09coWFmTcD2
 O7EP5K0rug90l5vyMsbdj0sFtwnTUzaLTLvkW09AXisJISdSVLQdCRpci/hc9i+WdBvWQBkYwAm
 xtBsrcuOY5WYM68bPmmFRogyQ4Ngq+X8Au0depd1v5YlHv8fqBB8R223dr2PvW3RfWwIYJxuzki
 2ynDjJGtrGe+3+YgERd3LXTZRONG8Ui6thsHMkoIHN1XuWj5l10q0uUfPhctn/5L+vYy9Q+RXov
 pU3rkmaUXBPfGeQL8mnU40M89amIr7MRQOA==
X-Received: by 2002:a05:6000:2997:10b0:48e:5e63:bd23 with SMTP id
 ffacd0b85a97d-48e6e2ef96fmr18510820f8f.30.1793650715797; 
 Mon, 02 Nov 2026 12:18:35 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 04/11] net/eth.c: Check for undersized IPv4 headers in
 eth_get_protocols()
Date: Mon,  2 Nov 2026 20:18:21 +0000
Message-ID: <20261102201828.1879576-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201828.1879576-1-peter.maydell@linaro.org>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

In the IPv6 path of eth_get_protocols(), eth_parse_ipv6_hdr() does
various sanity checks on the packet's IPv6 header, so we won't tell
the caller we have an IPv6 header when we have a malformed one.
However for IPv4 we only check the version and that we have at least
the minimum header size.

Harden this codepath by checking also that the header size declared
in the packet's own headers is neither smaller than the minimum nor
larger than the actual packet size.

Missing these checks shouldn't cause problems if the caller is
validating all offsets and lengths before use, but checking here
too is defence-in-depth, hence the cc to stable.

Cc: qemu-stable@nongnu.org
Fixes: 69ff5ef847457555 ("net/eth: Report if headers are actually present")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/eth.c b/net/eth.c
index 341d3bdf02b..e2c1e08ed28 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -156,6 +156,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
 
         copied = iov_to_buf(iov, iovcnt, *l3hdr_off, iphdr, sizeof(*iphdr));
         if (copied < sizeof(*iphdr) ||
+            IP_HDR_GET_LEN(iphdr) < sizeof(*iphdr) ||
+            input_size - *l3hdr_off < IP_HDR_GET_LEN(iphdr) ||
             IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4) {
             return;
         }
-- 
2.43.0


