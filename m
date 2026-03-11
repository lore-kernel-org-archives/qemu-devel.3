Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576C6112583B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0KuV-0005v4-Kk; Wed, 11 Mar 2026 10:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1774596582@qq.com>)
 id 1w0KUz-0007CP-5A; Wed, 11 Mar 2026 10:25:21 -0400
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1774596582@qq.com>)
 id 1w0KUv-0000Km-D7; Wed, 11 Mar 2026 10:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1773239107; bh=VvHpoEpak5oD4BWW2VNZzlgx/0J0ttLib2JoncQTjDQ=;
 h=From:To:Cc:Subject:Date;
 b=KQZZRweuMEVFmBLeueJD/XIdNgMww2nxFImadnHRAtMdA4iiH4o0sczLRQ38N4Q57
 zyIBlXl19opH0+FVRBNPsw6CpTri2yVsYOd7NbQreT+lrSvnlRduxtILY8h73Qxgp2
 3hrMRh/VZnlQ9Hugpg6YRnqcOtull1pRiuyVjmxY=
Received: from dt-VM.localdomain ([175.152.130.74])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 6460A831; Wed, 11 Mar 2026 22:25:06 +0800
X-QQ-mid: xmsmtpt1773239106tcpzbhgk8
Message-ID: <tencent_1BF621A658E043C088A2681178D57ED14A09@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+WrIA1BOiSRIdpssHXSykV3Q5QTFmdRXJ77DEKJ9otZ5mTg4qRK
 dYyBEGAkaM79zem/hK6VEUISAVLLBvsL34DDqaQO62yixOy15T904SuOmxSHA0lSva9L38mGjSRa
 yLYWLWfKloiYk4HallyBM6yQmnsNGXTY0nMUb35Rp0jm2VyalDvhiO5kIZQoE8ap83zcQGqfujCM
 pi1PFbAS6J72UnEaxmJgJXezrMkdNrshqooHnWkkV3VutoeEidl98yQxfRJ6igLxESf3a/LlrI3D
 oJmSFV7doo9po5csqLAnJ+ExlscpPglIBpNDeJIdWC15G02qw4LNx+UEdv/PAuhsrQnpEwK+V8u/
 rRxzkrZAMosbDsco6L575eUROeq7ZNMOtEcVDGHcCBYEGnCVH4ZydzqNZZ3oWwxyYf69k/y7q0Oz
 LELVlnEeuI2Mu+Hqj5NazsSWMImQqJyZlnST7sJ/DPj/NV3eFUh8St8RVZIuF55bBCn/aoB8l4x4
 51sit70CxpDPkCtkWLhh9UdPaPWgMbo79DC0dEPLseeCy5aR3OilZ8jBOhYBY7uB/T2wJcL3iWr9
 /9S/870ZmqBkYwJ1SHoVMQSCQxEOFxaRHaB0gfMXOMto4Ueg73OsKaO2pOP2CHTTyrWAdv7KRGW4
 3xuizRvS6p4XAw5VX6ySinLHl/LvzES/zcK7ptZHpBIjafajm/mNojN55q8r4xTpp29ijVk++rq4
 pAQLjBPgsnkFBm+gzzCtQj9NQr6sm/2O9SeDX90/40lKiIu70shDXUHFE23t87BUxZwIZn6rfPEY
 3I3/z+A1ZxruKewsPOO9KRFRSjVdH3UDxrsRkrRMKv9BWfpCYvAXElNO8JOIbd4zrpsjyxo8fC62
 COJUw1EuVojlfngUgqri//lKBXbRnEIbQC2K1nLx7xHGXpYywrtsC1FWqy0d7LYBcFTGWd9mZWcy
 l5T8AKozuQxtnxGlKH0hZwn0sJxlxC7WOw9p/7UOoevUocqQ0aZzmPMM6mbmVExWskJXi87eM05T
 9k/O8x1dkFJUWvkl6kNVrSpWw8NuRi+BfCfkiIgvHpuI4Z8dQzEPzixAwCoUY=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: 1774596582@qq.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	TaoDing <1774596582@qq.com>
Subject: [PATCH v1 0/3] Fixed bugs in pl080
Date: Wed, 11 Mar 2026 22:24:55 +0800
X-OQ-MSGID: <cover.1773236195.git.1774596582@qq.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.64; envelope-from=1774596582@qq.com;
 helo=out162-62-57-64.mail.qq.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Mar 2026 10:51:41 -0400
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

From: TaoDing <1774596582@qq.com>

Hi all,
When I tested pl080 using the existing dmatest tool in Linux, 
I found that pl080 could not output the results correctly.
The main issues involved are inconsistent source and destination bit widths, 
misalignment of LLI, which can lead to incorrect data and even cause qemu crashes.

TaoDing (3):
  An interrupt is generated after the DMA transfer complete.
  The swidth and dwidth of pl080 are not equal.
  The LLI of pl080 should be aligned with 4 bytes.

 hw/dma/pl080.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

-- 
2.43.0


