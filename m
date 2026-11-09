Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B16606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iQovPoAN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQS1F-00023f-Ft; Mon, 09 Nov 2026 11:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQS1D-00023W-NA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:14:51 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQS1B-0006DQ-Uv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:14:51 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso739838f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 08:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794240886; x=1794845686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oXExxKfjLRsWOerbk10pq7nfRVplRR2QsDyoDpY1MY0=;
 b=iQovPoANO+q5lwyDblv4ho00yMDhpOKD0iJVITggxMfomMw36litYl4C6qFr6WWx5E
 VBcaFQmgWzlnNRd1g6I8Upc87gN+YkH4nuAnehTjkaZC7yKNmznOT+4u91zgIpKBqC4n
 npCvqeKrt4OqdrQLUIkG56pcYUeQhaetE2R9+qdfhZ/joyA1ON+Dpr77K4EFumLleWvs
 ZLspa1yz4c/vasZOGwUCjHh+aQLKAoWnQgskQ/SdoCSMydPjyFCCasZ8hzIhc8rT59Rj
 SXNlaaUJ+eSP0yKVB6hcmnhut700SOnRFcuEDEJP++TpcpzuH+JB9pW4/cKCjCN+6sJu
 NcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794240886; x=1794845686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oXExxKfjLRsWOerbk10pq7nfRVplRR2QsDyoDpY1MY0=;
 b=uP5+24qfIY/Rx3QdvL2mLHRgSmXrl94DnkYCIPEpiX2UnKKvZ9wxJHRtmM/j5DBmWq
 /DQVa/l6fegQLWQ40NpFVccLiZ57SRqeMWdE2kH7pIJtOIYnQlgdGk9w8vNS4hXpZUpx
 oIgmNqotEXupr4m8BmCHHDB02kO9w4FXEPC+lihngmN7npfFa5tY5R1oMYeMvJXFS3u1
 DcJQKlWGTtNmlLg/7huaPVBLiRmpgQRYCiCrbR2n5qHwJrVzHdxePWYhZT+GNeoV4W4P
 K7QCGosLhFOElsSopbleIdsqXULuQF8HI6J/4/9ea4OsN15DPuL4IBNsXtasP/GUd3Ts
 mXhg==
X-Gm-Message-State: APuU4Z/K2prhQBAtJXeJElcAWrL/kLFubRDg7myOSjp0W46QWmqsKtU1
 t7BlPcgNYZgFD00yXQGEcN/hunw5bD85CYzCkM0gytgv5ei5FIBfACgWxpZWV2udANJiibLzKXw
 n5dIi6ss=
X-Gm-Gg: AYBFou3RMBWwIuD3FRK8Z5lPxyEh6INoG9AvtbK/yYiUShHnJRpEjmm4IeT51K1hDRT
 LKJ2y2Q9BL5Cz3Iofk2GwhJn4A7pXLDVfl0SC/FPaHjcyHZZDb/I6eBXgORTcJZd6Apb+YJjoVE
 O11rIi954LoSe5CJ801JjVgPQ4TfxHzmxCEgMNNk2Oi7fg8CGDLtSgKCLy4pOnump5AO+ONB9+2
 gQVEDBh5TQr99z3GHnlImv1++rSuIUBdE6/NfgHEcHyVbYztvrIbSTnMDpKCZxhz4fKk8qEPliF
 d+pPa2TmLQB0VedNbEVdtiD/mIY+0udP6O85kA2nrUQ/oZXzRKme71un0trcxwOgYxhnZT5NDvW
 Mv99goG0g0aaeisBaYy/eJiYJ83KjxaARJxuojeXRX4LCBF3NDB+mZfDOSAiWApM0IkSVTKqj8d
 3fp/a/GtfkQTmdOBXREgXNgnLvG6CzBFG297m23e2pxFp2vW5ko4zeuxKFqiXI++Vwg5iUghePm
 jKBeIULgh9eFSruJG/NUF8lg3fY7V1bMjz4OTwCYUZuVB3Ec/dbRW90aHP8VO67FFnWOPKHV8+A
 47rPptn3YVWMWjYZxANodITxFpabSUi8TbiYMprN1E6hBhK9SU9n63WZp/issP6Ea5Flpm1ZJTq
 YcO2/E7kCSwbBr+hKhXyqnSbdHK7pg3YPgA==
X-Received: by 2002:a5d:5f87:0:b0:48e:2108:4d28 with SMTP id
 ffacd0b85a97d-4958a4e09f0mr8040287f8f.13.1794240885965; 
 Mon, 09 Nov 2026 08:14:45 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959783fc31sm10838679f8f.48.2026.11.09.08.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:14:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/functional: Allow Asset() to work with non-HTTP URLs
Date: Mon,  9 Nov 2026 16:14:43 +0000
Message-ID: <20261109161443.724122-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

The Asset() implementation only works with HTTP URLs because it
assumes that the object it gets back from urllib.request.urlopen()
has a getheader() method.  This is only true for the HTTPResponse
object that HTTP URLs produce, not for the urllib.request.addinfourl
object that file, data and FTP URLs produce.

File URLs are obviously not useful for public QEMU tests, but they
can be helpful for iterating locally on the asset to be used by a
test before putting the final asset image up somewhere public.

Get the Content-Length header with resp.headers.get(), which works on
both object types, and matches how the urllib documentation suggests
getting headers.

Fixes: 7524e1b33679dc13 ("tests/functional/asset: Verify downloaded size")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/qemu_test/asset.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 0abd89e0a38..780b995b703 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -139,7 +139,7 @@ def _try_to_fetch(self, tmp_cache_file):
                 with tmp_cache_file.open("xb") as dst:
                     with urllib.request.urlopen(self.url) as resp:
                         copyfileobj(resp, dst)
-                        length_hdr = resp.getheader("Content-Length")
+                        length_hdr = resp.headers.get("Content-Length")
 
                 # Verify downloaded file size against length metadata, if
                 # available.
-- 
2.43.0


