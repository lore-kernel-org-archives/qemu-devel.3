Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182E3606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=onAEi++a;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dGtvfN59
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNl1-0001l7-UZ; Fri, 20 Nov 2026 07:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkg-0001Gv-2v
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:07 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkc-0007ks-Lb
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:00 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id ABBFA7A0363
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:29:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 07:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1795177795; x=1795264195; bh=5WNLtDu4Dx
 zxZHiobINTfwZc8r59nSfFcOVofMz7YR0=; b=onAEi++aFUkOW8WprnbXQFZKRK
 jQrQmBMjeWAICAgYCfPrgr2Z0ECo8pxBVW9BguyDTqdXdJMblkpYIy0RB7csTv4j
 6gh2nci0yzNVHsPk95tR3wXwTkis4jCGRGzaSGhrGl4MyJK3LXb64hVL4CjvjlCO
 s4JGBHs0Ey0Xqb0gbG02NzNcKUg/ahfdqfweO40qoLc4O+z5ZOPpczX4fue+lInT
 Vb0aCA8IDOMV1ub6nmZ88YAFutim2sfz7Kn19gfKIytvZLiPq+1MglkNr4ra70ZY
 l098P1rOf589UimYKPQ3VoX7c/MEmXfuN4ZKWL75GRzclQhNt4iBX4q4Uk6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795177795; x=1795264195; bh=5WNLtDu4DxzxZHiobINTfwZc8r59nSfFcOV
 ofMz7YR0=; b=dGtvfN59gcYesUsak8Q74rtC6JTeglKSLGU8kgIb6WGG7Fd7Js9
 qbCkH2ndz7wt0U2wx+L6Hg5Xu7y4FwJecY5Xz34hVtDGPCjXL62mGiREIRb3JmWH
 qi/Ks5gCffLD2XgReSNhbOP/BMd9KCt8W03t+YUvG+bahB9l4OtGoffKUXTvV4fk
 FFqtPp9CgHPkYg4FYXeMlizfkELKIPnmPQPEfOa7ATM/WvJ1Ql5vW+z9bWrQOjkf
 LjCTTn+dz47ukoBXe0w/QsfeuYYu2/Rzr6boGBwO22EdH0WdWRRJCwj919l/pzqs
 yxUm7OUmVcPykrAl0Bfbl737DsTPGqJL8RA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177795; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:VfuUhMq9jZS51rk+/GjJEI/8i4bhnyjw1Emnm+4XDNJinGa
 DB5j3EPQuccw9w6heH59qfCMb6UDr9VKEQeWjMPnj4bW/noWxj3G+sbIINA6/nFH
 L9XKl+DeBM6X5AbTfkDOUM/mXSpHzKONneZSbPpdAujnyz9d/brMzyWJV3Rs73G0
 AyE1TteU4REpxYgaDNV/4NhVBa2wdX8PDO82NW+xvsPDt2ticNZZBlkwX0q24pQr
 /Ru1kwH/MmNS3I4X+DGA7oQQe9h5+V4O4e0qGWn0lYKdeJU1qb7QYVY0MDEBvv/6
 p3ZnCCxZeSsSq4iCmThjhOQFXfLCZKmZL4Z81Vg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:Cn50KVeQ7rhwHysOZHrzPzoF4qaViYHwimyySi9qxSg=:0xWjFG0F2qnirOoaSVFD/dXmbUOF6v6GGELhvPvI3Kw=;
X-ME-Sender: <xms:Qj0Aa9ovVaTuA6oOP-c1IKqGzJ6TGVBz_FCxtumdlnilX0D8GzITQw>
 <xme:Qj0Aaz8n00c1Bt_IlP2jT7dPsl03uARh5jhshXybvDtbGpmA5FiJfdEsIFj8An3Ju
 dFK7Ww7ZTOxCQraj2eHgSlTvfw5C3y1aXozCgikS575ZBuaouEGu8THlw>
X-ME-Received: <xmr:Qj0Aa5UC0_Wuj70B4YAzJspiX84a_V3-JUIgVPnPI1MyhEZ5w1eqipMwDoscQg2yKX0QnhjkgHEnc9XdPeLhFAHB81Sr_BOSGHz2dYxskHM4paN8dcwG72xCog>
X-ME-Proxy-Cause: dmFkZTGkgz+MHBpcIOd9ImX2wDtfhP+/Q4NpBhtSTTafSS1g7Cn65+77gl9YgeQQg0SFXr
 NETgrFdmS4k7DtPhUgbc6OeVY4yzgtgreKxKxAoawo6MBE1KrlppZO0Llwvsj1SXA9lAEc
 tI8HeaAmjksSIekPCEw2JWciHIOXJ5JddJNMl+9VI+zfPEUR2jn4PUKXrEQMs5rpXXFGSp
 t7+TnuIAkD09rf4hJ/p/HKyyuGXjqT0VachPa1KKEqpqh66alKDILHjo1dlYNCIcpemjVq
 AV9L7uuvdM1o0VMGP2LEbR41yCrflxt1aI/OET1Jsf8RJHqi5R12HAkjXfEINpvLqKLmOy
 X5DIkPMoiTAQ8b3tZJ+uU8sndLz8cUvZWQTD7bgaCAf6HplWpRIrlqt37h091XfFL0zhyo
 Ch3uxJf7VrER0H1sEUDmo1e/HzyZUoOpF7PTgaCv8kYKaqo47XXALbGTxsWBx3XUSX+MMv
 lPF2RJGBpdf4/Us4lXbX5rUaxtRc2w857/zVYyDH16FdoQNNJwrUxDYljXy0C+/YplqBF5
 9CG6qJljaFVCcC7rDILsmw5y6b73Q69zM68fIbSviw7DMpOi2xwOcbIixNouJhW/HMiUjS
 nRnyK6PL7FwnwWFxp4gAzWVOPUnEKMYfjwWmJ8I+ucWa1S+GGJhMnLGwVUpg
X-ME-Proxy: <xmx:Qj0AaxDvV4jWPHow1U5S6EOENfOIP6K81ln-jOscXxpZ66nbsYowlw>
 <xmx:Qj0Aaywyd4VLdxfBmZS9B-vwU_0g6l-RGhSxGPcTaYodxZ1AzuOrkA>
 <xmx:Qj0Aa2BoLjzV6eUn9_mYadwcFXblqDBhtNBmc2w0JCTBaUsgI5XFAQ>
 <xmx:Qj0Aa3YsajSl1R2RRgmZ98mtrOy39ATC4DnkOu1rRMhPJkK_-hnreA>
 <xmx:Qz0Aa9OQCfKHEIzd5v_g77tGWFKOWOgfMqEEkz4Z5pOAgdNoEHlTtgUo>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:29:53 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/5] hw/nvme fixes
Date: Fri, 20 Nov 2026 13:29:44 +0100
Message-ID: <20261120122949.1044-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.154; envelope-from=its@irrelevant.dk;
 helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

The following changes since commit 08ed97c33c3818ef51a7c852347a28e9f66807b5:

  tests/tcg/i386: compile test-i386-blendv.c with -msse4.1 (2026-11-19 13:54:13 -0800)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20261120

for you to fetch changes up to 7e203726411b7a28b2d020339d6267c7c7d4134e:

  hw/nvme: advance zone write pointer only once the write is committed (2026-11-20 11:32:57 +0100)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Klaus Jensen (5):
      hw/nvme: report data transfer error on failed dma
      hw/nvme: fix zone descriptor extension allocation overflow
      hw/nvme: fix open zone zrwa allocation
      hw/nvme: bound zrwa flush by the write area and zone write boundary
      hw/nvme: advance zone write pointer only once the write is committed

 hw/nvme/ctrl.c       | 48 +++++++++++++++++++++++++++++++++++-------------
 hw/nvme/ns.c         |  4 ++--
 hw/nvme/nvme.h       |  3 ++-
 hw/nvme/trace-events |  1 +
 4 files changed, 40 insertions(+), 16 deletions(-)

