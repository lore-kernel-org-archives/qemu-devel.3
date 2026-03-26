Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E6D10AB82E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5uB0-00086F-Kn; Thu, 26 Mar 2026 19:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5uAx-00085Z-Dh
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:31:43 -0400
Received: from ci-2002d-snip4-11.eps.apple.com ([57.103.88.171]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5uAv-0003lg-Ik
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:31:43 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPS id
 9F6801800209; Thu, 26 Mar 2026 23:31:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774567897; x=1777159897;
 bh=AgGFaFGJOz7Y9Fj6pPNpBMoHa1YUKbCUmRuYh71HsL4=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=TmATCasjhXp4lkfAvyz7h/HIILCH1NKjVQH+bQw32hXedSZV5lMeHSTKgZtfj5CW4CTOT5pV62JU44B+Lfed1xORv91rQOLSRnsSgFrt7uiHGdBQTYhV6mLUePAUpGN6ds11/hmIyFwvIB4U6bI9V0m2Y+6/8QKDkVh/srDl0oF4d2/yFVWqhDYVfh5EKGurAuuFbinKRvQWVxIo1ifol8b2uCmed6Eo4y8n2k1gNbt0hEgNMTD6SowFxXskV+nc7wgcE1IzcCr//Sk4VNti3U9VtL5t2ViFk3F3H19tLvd8FvhWbOzY4H82VFIt6SNqb/py6ES2lx/NzwDb9BNaoQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPSA id
 3D37B180012C; Thu, 26 Mar 2026 23:31:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v5 0/6] whpx: i386: even more updates
Date: Fri, 27 Mar 2026 00:31:24 +0100
Message-ID: <20260326233130.59392-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2NyBTYWx0ZWRfXwZaGk1q3BdGb
 O82i+s3vXyYbL6dWL+b6u7gHHsWwJ7CkqEPHc+QS5EPAWLhbMu7kTx4nyXHhA48YB9SiO423TXH
 9JVtBCdmcm5EtxMKkoTar6Wn5nUdmIU2BAIaoifvwPx0ayyiQdBKMy0R85hyM0sdCirRjXPCiJV
 DHCYcJ8HqFvKAcdlEE5Cgz3d7HJX89pf38lflO0N4RyngdKDutxqnyzpWeFIFKnNNAxKSnnDQQ6
 cFy8+43ay8r9wHG0EUhHkGtnBIlqAxVtBCzfmKKjWHkvzRbe730YZX+6/ULjo93+uMEsoHoTiUa
 lUyEigtvSCDqRMKp2PYKxk5V9t7Ra5i+sMF8HLVwwse7KrrpoV43W1ihe5+5YM=
X-Proofpoint-ORIG-GUID: KMKkVE1e6FJVxDBpuD6Ll8JH0BSS8URQ
X-Authority-Info-Out: v=2.4 cv=A+Vh/qWG c=1 sm=1 tr=0 ts=69c5c1d8
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=r00tg9IzZes3XP5rG5AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KMKkVE1e6FJVxDBpuD6Ll8JH0BSS8URQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1030
 mlxscore=0 mlxlogscore=677 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603260167
Received-SPF: pass client-ip=57.103.88.171;
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

Also add emulation of SLDT (and STR done in the same vein)
because of a bug report.

Mohamed Mediouni (6):
  docs: add WHPX section with initial info
  whpx: i386: trace unsupported MSR accesses
  target/i386: emulate: remove redundant logging for unmapped MMIO
    access
  target/i386/emulate, whpx, hvf, mshv: add read_segment_selector
  target/i386: emulate: include name of unhandled instruction
  target/i386: emulate: emulate SLDT and STR

 MAINTAINERS                   |   1 +
 docs/system/index.rst         |   1 +
 docs/system/whpx.rst          | 144 ++++++++++++++++++++++++++++++++++
 meson.build                   |   1 +
 target/i386/emulate/x86_emu.c |  22 +++++-
 target/i386/emulate/x86_emu.h |   1 +
 target/i386/emulate/x86_mmu.c |   3 -
 target/i386/hvf/hvf.c         |   1 +
 target/i386/mshv/mshv-cpu.c   |  11 +++
 target/i386/whpx/trace-events |   1 +
 target/i386/whpx/trace.h      |   2 +
 target/i386/whpx/whpx-all.c   |  15 +++-
 12 files changed, 196 insertions(+), 7 deletions(-)
 create mode 100644 docs/system/whpx.rst
 create mode 100644 target/i386/whpx/trace-events
 create mode 100644 target/i386/whpx/trace.h

-- 
2.50.1 (Apple Git-155)


