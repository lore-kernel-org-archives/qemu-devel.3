Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7670CC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wom6R-0004QG-L0; Tue, 28 Jul 2026 14:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1wom6O-0004Pb-Tb
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 14:00:29 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1wom6N-0001Vh-1w
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 14:00:28 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id EE737EC03EB;
 Tue, 28 Jul 2026 14:00:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 14:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1785261625; x=
 1785348025; bh=4KVBolDTcVreHTFkDRgdLiRHcN1OPMBH1qRNKYHGYRQ=; b=I
 0iwQYJsKs32AiS3ohhcna+TTTdOWDdXj5rBd0yz29ZATqkkjt1qQx/L3BqplpLuP
 z25KD0ZD14+2oEwhI0UM31esS5AXME4jKuIkuHmA6KFHEwfG9ArHAkXcfzmk3kDV
 OijNR4t5+m/S/BupCzoulKeixfiJbYjYW1BLtcgHycgqwFHTlM33HJwpCubwuJpm
 mouJQuVx1lWxnx5sP6BOPlxrEVEEP01TrMB5iLrw6L9DRlrc+eyuStay8V6ylY/b
 PJxfJBhBShFT8cUMnXPtCAMiYow0ItxfgfrpZ4BXDism8JV/RSgllz/uXifRxqyK
 OGorKxzRCDvL+xD+hxt9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1785261625; x=1785348025; bh=4KVBolDTcVreHTFkDRgdLiRHcN1O
 PMBH1qRNKYHGYRQ=; b=IMGLKLEpbQJ18rvbxaG4Z/cp3N/+SIEuDVRAmZo2QAtV
 mrikdRS29Wk407IVStHEV3IU1FmGv941920lRohQWYc/MwdxMAiH2+FAvlaRVAsa
 q+qUzEoWiDQjv7TDW1jC+rnkatkepFg0F6Pax88BtahFUl0evCeUit6H17yotcld
 lVLioNO5gyo4nXgqhzDI5F3e3XDM/calXALzic7AsQs/4b71tuhqN9xWp0rq0vsT
 xOfpAP36XvpK1e5wr6oHV+fbpJMhkw3Q/08rYXDivXIHZvdDuyMIK9xSGOc+GCZN
 +l61j1rqBJgBd4sSuSYms4EfgcSICxLwrR0FjjIsPw==
X-ME-Sender: <xms:Oe5oariF1vsTNT3FKJhe-wONL-zMp5P7LvZfPkxp49lIbr9gFNqldw>
 <xme:Oe5oasUqsmlKQbKpITVI0BeiyH5hOEWEnun3pbXBDQUSJHbY1-8up26kw-9Vcqw8u
 ufzTdjGTBuqwi20SyxZAqIRlylJEdhnGZxPw9gcSp9qBDvv6ziBQ4U>
X-ME-Received: <xmr:Oe5oaqPmeTIEY_-wu0xOVLYQA1TnVk98VTA-3IiP7acH69FmqexzTc2T0LfVTBqbA9qfWSU9CYNaHbsuVmjsVIqAQv92pPoHbbk0IXxBmm3YaygOo4lvVmbUQw>
X-ME-Proxy-Cause: dmFkZTF08tH0abgo4h86GppyqKneRZNZXbdrEpQ/daSHdGPM+KCG6eKqb/juIy/0hXmW2j
 GOM+2P0evUg7GfnKUn9nBfCPdA0WsDDKFj52Q1AW+5rgaKY6H6fJYrXiNl024I0PfaxdyZ
 3LZhvNEKd1be8sBeLtmZ6jVJIzGqq5nW0pj8h2kzkPuDzUQVGTkUIZM45YbWnqcN0Q2swq
 VgNdYNQ4NebuwfKYd7Ij39ZZxS6m5n1tB3V3op8reaUSFdZz498l9rUjZgZdEQ3WK6uB1g
 B6v4R9J6ofQjFK2R1MSR3H2TtQHznAR6gd0Chm/SFoV5cGuNmVg9DBONsJKp6hnSma0qfL
 4XgkMxoTo8paZOACDtPxYk/vOFREg6zQ39+7eSsnEcB5hHIbvPNueXW384J+BcFhxUBqkU
 Pl64pkudeRUmYsUXyB77V27ICL2r9mPT5N+tvpknncfoaH5Cp0Ui6WrPIvOI3G1uGyRosf
 sfOzQa8YtBPxO3jQfiTEmixJZZ8J6Kr1yUBYaRxjtdfV2aVciETDMNC5hUJxVyAAql54NL
 6vyO2T5MUX7BYFZAnUW91Sv1A/uj1Sv6Ezo5IGbyV2JmHku0ik4ERWX5suwFopDgR5cYz7
 +S/bhAoHwVNCrvwGUPH+ZNPY4p94zaZqBWti/GSGz5b0MdpzzhsyJYXA9Sig
X-ME-Proxy: <xmx:Oe5oagadM621wvyYPi3RGMCNxAFvtBOr7ofub2_EwPt3jLwqliRrmw>
 <xmx:Oe5oaupHE0hmA9vgQ_ieIdbTEcq7M2YGS9DDZtxfd52Fy_sxmTQBTg>
 <xmx:Oe5oakZeVCP0PJLH4gMR3ZO-kRqzI1UUdqvkZbsSx5VAVo2A9KitGQ>
 <xmx:Oe5oamSDiN7OWbjeScbDdf_upegIFGGufhO889woiPeJ7o3qMoH07w>
 <xmx:Oe5oankzSi3HqCLbQCEPy4JhcZO3rFRsv7GRADDSliwgP84_FZlJ7JKi>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 14:00:24 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/4] hw/nvme fixes
Date: Tue, 28 Jul 2026 20:00:14 +0200
Message-ID: <20260728180018.3574-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.146; envelope-from=its@irrelevant.dk;
 helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

The following changes since commit de5eb7c4dd3ef5688b14007134eb11ff4973580c:

  Merge tag 'hw-misc-20260728' of https://github.com/philmd/qemu into staging (2026-07-28 10:04:08 -0400)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20260728

for you to fetch changes up to c39e05af439a3a2bd58a847fc30d7eb590fcf61e:

  hw/nvme: fix unintentional integer overflow in shift (2026-07-28 19:59:01 +0200)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Alexander Mikhalitsyn (1):
      hw/nvme: use GPtrArray for blocker_features

Daniel Paziyski (1):
      hw/nvme: fix assertion failure on subregion removal

Klaus Jensen (2):
      hw/nvme: fix cross-namespace copy dif buffer overflow
      hw/nvme: fix unintentional integer overflow in shift

 hw/nvme/ctrl.c | 57 +++++++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

