Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4298110A3D96
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5pZT-0001Mh-Ig; Thu, 26 Mar 2026 14:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5pZO-0001MP-Ee
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:36:39 -0400
Received: from ci-2005l-snip4-11.eps.apple.com ([57.103.89.251]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5pZM-0008S2-IA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:36:38 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-5 (Postfix) with ESMTPS id
 F34F51800701; Thu, 26 Mar 2026 18:36:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774550195; x=1777142195;
 bh=UP4PHAPvG4AbgTLmhBg39yt3vNpOGex89WBINyu7FaU=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=CV64KLhf74BFhXIFKRen9Pvc/WqWN4b19LbSxuEEj5L+hNzY+RiiB8ZTpGmWYbhJpTCkc7FC9QTzOJ/qWRI14TiyJIHpkoKSo1WvDbRWnpxFITlpykRXkDWJl/Q4nHhWb3OGpW+7PsjxZVgAQ6wXFYz2ZEAw+316dM5eNdfEEZrbbTSc3k+cTiDoSQ5MILrTBSF5u/lipUOuy9paPQgzAK7D475ViU4eqSjrTOAog7PKKRB4yfsk9qxz0Am0gEYZuUzmhcpXNjQ9AqdYrbeD8FsCIp+YQdE6v8BjP6RiRYl5xGqXc/gIH0ETpRg/OyeHvksHd4kMHNBN7UQl648pwA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-5 (Postfix) with ESMTPSA id
 ABCE11800171; Thu, 26 Mar 2026 18:36:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 0/3] whpx: i386: documentation and demoting some warnings
Date: Thu, 26 Mar 2026 19:36:25 +0100
Message-ID: <20260326183628.79281-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=NLDYOk6g c=1 sm=1 tr=0 ts=69c57cb1
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=hPRIUQFq285SL03yr14A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _QVtcXquJAjtgRFv5hMEDaaw5UnCyswb
X-Proofpoint-GUID: _QVtcXquJAjtgRFv5hMEDaaw5UnCyswb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzMyBTYWx0ZWRfX7VZoU0sb7Irq
 P58qG6xiyGQIfuPvaF+DjjiTOWLKsxDbAKeq+qvHIufjkGvATt//xJDD8WX7V21Ge5vHnsrQY5Q
 gccRZeDalwTK6b0Nre6HRGqSN4at36031v+DSBaGCqt6Tvyi6htUGXBIasMtYwNkRnsgA6JoYPQ
 zM92Aw3j+3B4aXEhr0xaGH/ZAPoxiDv8PC697Q9ChBrds3T4hIpWqELNFfZZzf60I3wOgKo+ZjV
 DTgU5Jj9tHsL0w2x2MjoAxGy6EVHg13yEUtRFPhFuh6wQulOPiRKee7FCUYnqhmatSjRHZOftRX
 Sa3EgEAXkpKGGDLQ7eGXaA1pEH8Q6vvJK9+js2foBEqr4bi+YKl3gCaHnLGfto=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1030 phishscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=555 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260133
Received-SPF: pass client-ip=57.103.89.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Demoting some warnings that appeared too often to traces
and adding some documentation.

Mohamed Mediouni (3):
  docs: add WHPX section with initial info
  target/i386: emulate: make unmapped GPA warnings a trace
  whpx: i386: trace unsupported MSR accesses

 MAINTAINERS                      |   1 +
 docs/system/index.rst            |   1 +
 docs/system/whpx.rst             | 144 +++++++++++++++++++++++++++++++
 meson.build                      |   2 +
 target/i386/emulate/trace-events |   2 +
 target/i386/emulate/trace.h      |   2 +
 target/i386/emulate/x86_mmu.c    |   5 +-
 target/i386/whpx/trace-events    |   1 +
 target/i386/whpx/trace.h         |   2 +
 target/i386/whpx/whpx-all.c      |   5 +-
 10 files changed, 161 insertions(+), 4 deletions(-)
 create mode 100644 docs/system/whpx.rst
 create mode 100644 target/i386/emulate/trace-events
 create mode 100644 target/i386/emulate/trace.h
 create mode 100644 target/i386/whpx/trace-events
 create mode 100644 target/i386/whpx/trace.h

-- 
2.50.1 (Apple Git-155)


