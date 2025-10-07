Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B10CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ELt-0001FC-CS; Tue, 07 Oct 2025 16:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6ELq-0001EY-Nc
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:32:02 -0400
Received: from p-east2-cluster5-host6-snip4-7.eps.apple.com ([57.103.79.100]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6ELn-00019l-LV
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:32:02 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 EC850180016F; Tue,  7 Oct 2025 20:31:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=eLOajVpF8GkgzaggtjB1nHS9up84g8T0wFK4CYLfiY4=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=K/al8F0csVazuh5M1aM4f8Y750D40BZ0DxqFIvkAdSVPkANg/vf0/KpFnIoe5TdEHH1KqQ+MTAk8mvYT02ow5z3fgy5fKw6E7SChZU7cO6c9RY0tICyss13fm9X/HGdsJSR5e+cy/fVvGOL8W+ALusX006hqZOvd2eFub5KNTP4Er8k1Tq7Vqyc+elgaCrLuTAMtd2Mnn5GU/UgWaQdJK2rdI8YC06nPvvz7sVRr19JMeVXOFrJbvPC48ko32PKCUSklD8ZqqwqYXhB4nU+zO6pDNuokbcaBum27usHwUP9XpLkK3SnThLCPW0jzTtCKNZP0Z84jwdCsUYbF2y2aEQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 6B5AB1800162; Tue,  7 Oct 2025 20:31:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC v2 0/4] vmapple: making it work on the latest macOS releaases
 and Apple M4
Date: Tue,  7 Oct 2025 22:31:49 +0200
Message-ID: <20251007203153.30136-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BTik7pc9XnxU3XlnKaHkbxOQ6KC8LKvZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE1OSBTYWx0ZWRfX/NPzWKBwkhEe
 aZjRxpY3YQbyaZA8pyMvxo8aGdNnfXwL/5tf3HL05EUHZCytUN/XL70G3RKPlYD7AVDcCDWo17T
 YH3nV0evP9+0HTzxrf8QPoCn6xdbSm38STVSTzNUGLVdXlboBoXr88N326bbQsaVQyoaT9l68fm
 lQVSMDHPEpgr3sYww8O3QcnuJvj5HxuwDASP4uSKbHImOrFrO8dRMr2h+7UT1E5zRO1MCP6R6K5
 7qMzccplseEYNWNCFooepViqxZzHGlsRTDYY7HPlX/Yc4L7u511+FkzHBlEkvAGBJbodbyOUk=
X-Proofpoint-ORIG-GUID: BTik7pc9XnxU3XlnKaHkbxOQ6KC8LKvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=451 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1030 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2510070159
Received-SPF: pass client-ip=57.103.79.100;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RFC as it's hacky code, especially for the Apple M4 support workaround part.
Support for newer guest OSes isn't part of this series.

v1->v2:
Remove some lines that shouldn't have been present...

Mohamed Mediouni (4):
  hw: vmapple: include missing headers
  hvf: arm64: add workaround for Apple M4 to run older macOS versions
  vmapple: apple-gfx: make it work on the latest macOS release
  Revert "hw/arm: Do not build VMapple machine by default"

 accel/hvf/hvf-accel-ops.c                   |  4 +-
 configs/devices/aarch64-softmmu/default.mak |  1 -
 hw/display/apple-gfx-mmio.m                 | 56 ++++++++++++-----
 hw/display/apple-gfx.h                      | 13 ++++
 hw/display/apple-gfx.m                      | 42 ++++++++++++-
 hw/vmapple/vmapple.c                        |  2 +
 include/system/hvf_int.h                    |  4 ++
 target/arm/hvf/hvf.c                        | 68 +++++++++++++++++++++
 8 files changed, 171 insertions(+), 19 deletions(-)

-- 
2.50.1 (Apple Git-155)


