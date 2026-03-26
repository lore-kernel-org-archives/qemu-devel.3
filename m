Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FF910AB80C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5qTI-0006dw-28; Thu, 26 Mar 2026 15:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5qT4-0006cE-7U
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:34:11 -0400
Received: from ci-2007b-snip4-11.eps.apple.com ([57.103.88.23]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5qT0-0001bk-Pi
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:34:08 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 EB67A1800169; Thu, 26 Mar 2026 19:34:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774553645; x=1777145645;
 bh=Klv9SWAvktCxp2uN+5o8CzhCb3C4Tp1vO6np/kezQjo=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=ajcA8seJmedgTwbDsOIz1franXIalumex5fOnYFih5mbWAJcFaqr3IEvClCBzY1mg/8VipxLSN8scK4wuggDv4M6nXWJPY5v/rIGvbco4W2nrtKcKF4LfNJ8aIwRowwNFobcXvmrxS4LUKMEOPj4Cyy67OCbE/7rpf2BkbR4jzRE487aEiss21gtCI+wBjlo8QLcUCitWv+WDf0Tl0+zjgVwYYwwOufmXt/d72syhKJ7y1+hZL+OOi0cCYCZtAA6DTxKiUE+Z1Tvb0UmZx08PLkJURx6K105hvawt0jkBnvCA7I8f4n83+hSn7ew/8IAudnO2iyDJdWo4fc5+YxAFw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 B1A511800174; Thu, 26 Mar 2026 19:34:00 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 0/3] whpx: i386: documentation and demoting some warnings
Date: Thu, 26 Mar 2026 20:33:55 +0100
Message-ID: <20260326193358.97858-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nHhe3QohndP2d9ZTHpEUfH18OiQC6tOu
X-Authority-Info-Out: v=2.4 cv=MtVfKmae c=1 sm=1 tr=0 ts=69c58a2b
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EmbHMQYUkXzR4eB19IEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nHhe3QohndP2d9ZTHpEUfH18OiQC6tOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE0MCBTYWx0ZWRfX5k88814vWZCw
 NeIjj+WwsQHnOQ6JKlQswpesMKWPzKsFWAmKz82xWL1OJX1Y3+HVPGpxhZ11gl7b+2EF9/MkiYz
 mYNL7SMT5bDikN4mxnRyD45ejFaWzJML5kr4uit8XBh3u+GHUkW0HywjAgpOfKu8/h1QNrJSG5v
 Bdy9msMbM/09lN64NjUxTq+XRnW0BeZw8/qTCuestpKwrxLLLAyYBpWTcO/h+VUrbRkr+A0em4y
 dldY7owcx/+8i6pAPW/5/TbuKIotKhZM/cRJ0HynT1QeEm++R+aiIFnQ68RPkn8MOTCz26fwaEw
 Vg2OpjbUH/0T6GFy10KQtf1EVK37X40Uc8/u7sy58/IeYc06pkGKi42Ms38QfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=605 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260140
Received-SPF: pass client-ip=57.103.88.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mohamed Mediouni (3):
  docs: add WHPX section with initial info
  whpx: i386: trace unsupported MSR accesses
  target/i386: emulate: LOG_GUEST_ERROR for read/write from unmapped
    MMIO

 MAINTAINERS                   |   1 +
 docs/system/index.rst         |   1 +
 docs/system/whpx.rst          | 144 ++++++++++++++++++++++++++++++++++
 meson.build                   |   1 +
 target/i386/emulate/x86_mmu.c |   6 +-
 target/i386/whpx/trace-events |   1 +
 target/i386/whpx/trace.h      |   2 +
 target/i386/whpx/whpx-all.c   |   5 +-
 8 files changed, 156 insertions(+), 5 deletions(-)
 create mode 100644 docs/system/whpx.rst
 create mode 100644 target/i386/whpx/trace-events
 create mode 100644 target/i386/whpx/trace.h

-- 
2.50.1 (Apple Git-155)


