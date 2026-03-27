Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC1010AB83A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 01:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5vkD-0005Hy-4P; Thu, 26 Mar 2026 21:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5vkA-0005Ge-4e
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 21:12:10 -0400
Received: from ci-2006d-snip4-11.eps.apple.com ([57.103.90.171]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5vk6-0006KS-AN
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 21:12:09 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPS id
 2F033180015E; Fri, 27 Mar 2026 01:11:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774573918; x=1777165918;
 bh=Ydz/hZxljWbu/ai9XltlyzziT/25kc5TG/SYqIJxPgc=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=JP+8fXhsgvVPPX52JdICd5p+W8osbSeLVHddXdDZ+bro5MWFnBbo7JypX8+JM15Xeq+vm9Nzb4Sy9eC7g3AkGoFuZO34VuRGAQW64REoHA//3QeccuQjaTGV5t1H5qoxwp82XGk52ZKAT+4gyQoZJO/U00XQq+xFoT6jPzDo4FagX/L+SJewrLDx6Gc/JL/jPMwlygXHpehDn49aZD7aRi/ZB5QtpmVJ58pnrYdOco+7AMxBFzZqRNEZ5aE0YjnXmPgME63hC4+bfBaD6HR5SvMvPyMbedr5S96VX2EUE9Xp0Kf8gFAlNLiqJcJifOQ8bmuvd5wsWplSG0sK8iM7qg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPSA id
 24E7918004B0; Fri, 27 Mar 2026 01:11:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 0/4] whpx: i386: even more updates
Date: Fri, 27 Mar 2026 02:11:48 +0100
Message-ID: <20260327011152.4126-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=cqWWUl4i c=1 sm=1 tr=0 ts=69c5d95d
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=waBImidRqKZr_2MpZXoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mU7CZMaCq3bjD8G2OilOhGNsNNz6ZGSO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwOCBTYWx0ZWRfX5liD4DLSCYt6
 jutFTmycxsv6IoYaoY1f/X6cz0jXZKGKo3GHGIEYG2pxK6OL3tnlBF/gOIe//0hqQyoLnisZTyX
 9NPU1ihSg7ArY8tAZ9McA5g4Q7afNwF/yZsKdQLFPOcTxuXtS1yi6DAvgg1PDHBf7xC3CLi5iiC
 A91wljmdt0zNEpn4Wl2tl42Y8r+RdlXPos3/EV7k/1kYDV4eRhzbuytz4WcKLgTifmkSrCN6Iv9
 kuUeXQovc9aEyxXrt7vzINU4yt8XSeJaV8Y9zom0WEFEtmN514v9RiHo4d6BjZ86WSJO7NA6tV8
 pW4w08hAYwb0k2riueAKcT+HPQH4sC/eSIr7FWqRzQq/YfCg189GW8IGeFla8A=
X-Proofpoint-ORIG-GUID: mU7CZMaCq3bjD8G2OilOhGNsNNz6ZGSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=728 malwarescore=0 adultscore=0 clxscore=1030
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603270008
Received-SPF: pass client-ip=57.103.90.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Demoting some warnings that appeared too often
and adding some documentation.

v5 to v6:

Remove emulation of SLDT and STR from this revision.
Will continue seeing what to emulate or not for QEMU 11.1.

The issues there turned out that target/i386/emulate causes
state corruption across the board when using the i386-softmmu
target. So disable WHPX support for that target as a workaround.

Mohamed Mediouni (4):
  meson.build: remove i386-softmmu WHPX support
  docs: add WHPX section with initial info
  whpx: i386: trace unsupported MSR accesses
  target/i386: emulate: remove redundant logging for unmapped MMIO
    access

 MAINTAINERS                   |   1 +
 docs/system/index.rst         |   1 +
 docs/system/whpx.rst          | 144 ++++++++++++++++++++++++++++++++++
 meson.build                   |   3 +-
 target/i386/emulate/x86_mmu.c |   3 -
 target/i386/whpx/trace-events |   1 +
 target/i386/whpx/trace.h      |   2 +
 target/i386/whpx/whpx-all.c   |   5 +-
 8 files changed, 154 insertions(+), 6 deletions(-)
 create mode 100644 docs/system/whpx.rst
 create mode 100644 target/i386/whpx/trace-events
 create mode 100644 target/i386/whpx/trace.h

-- 
2.50.1 (Apple Git-155)


