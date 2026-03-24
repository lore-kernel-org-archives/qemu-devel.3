Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B699FEC104
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 23:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Ajt-0001OP-5e; Tue, 24 Mar 2026 19:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5Ajn-0001Nz-7P
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 19:00:39 -0400
Received: from p-west2-cluster6-host2-snip4-10.eps.apple.com ([57.103.70.83]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5Ajl-0005N7-4k
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 19:00:38 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPS id
 DDB1418004A0; Tue, 24 Mar 2026 23:00:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774393234; x=1776985234;
 bh=ELH3l7xJZP+urtZ5koKv9Tn0x+SxdT4KR09wp+C84aE=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=btv5dPS/lxCri8JVXfESDOzQFRcMhcTo60pWc3mgoaQ0La33HGwg4kA14Hz1vuSToZVm8x7fkCe4egBaKhRcP/QxKRhJp/i1+eTmvuSypRTOOV4LDQ5bjRWotmjtcKKjHvclAPW/OJfVk4+XPMIZR4kGJsjvBmdlVNSdGteztCBKXYSAOyB1iHJCZ3rRiy1jwjr11GWus1QCbMTukOxYRtJc0MtFZa0m7DdWNKYKNKaQV+NVseuP2irzVypAbYbnIQL2JTktMUQcsmAtplJVW1Tc6X9PpS7I+yKS310AoRF8lAYjur/Jepi6PgzaC/rzjDLn46P9mOzhMpwWlbgCPw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPSA id
 B7B8B18004B4; Tue, 24 Mar 2026 23:00:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 0/2] target/i386: emulate: MMU fixes
Date: Wed, 25 Mar 2026 00:00:14 +0100
Message-ID: <20260324230016.80914-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UDTpATzOa2RoqfBPve4GsrIockbSOQGc
X-Proofpoint-ORIG-GUID: UDTpATzOa2RoqfBPve4GsrIockbSOQGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3NyBTYWx0ZWRfX5aKi27Ee0XDR
 SDNof3b1D09pSALgY8/kKri1fmR2VQz/dRFoIIH3WTPdWZLXz8BuxKJ3ZxwZeeCpQLJ78IdziNY
 qGqxwNTGFH8ZjY7+OpFXlIqEWzVbKyNSR/obr9AYp5lUeyulvUJAP4ko6UPdp5LoXeoY9S/Inpg
 dMoXo4VSoJUp/dW0yA7uD9wZRxXGUl0FLGj8B5CF+1kUK94POzDc4CdNZAbXINunVAi6cN2TBKS
 ZEVBM+GNbWNcJi+4RJiSYtcZypSmVdRlrHiOdOshxNOJkiFh8adR0Cc/A5nOhXs24ozMNG6khDN
 mA916ws9zFFP+4WealSZfnAuHr88VdViKVivxBTobww6bFPU356lLkLm7Fg+MQ=
X-Authority-Info-Out: v=2.4 cv=NdbrFmD4 c=1 sm=1 tr=0 ts=69c31792
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=vtrVES03IbdsgJ2vJqEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxlogscore=641 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1030 mlxscore=0 suspectscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240177
Received-SPF: pass client-ip=57.103.70.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Two small commits I had around...

Mohamed Mediouni (2):
  target/i386: emulate: set PG_ERROR_W_MASK as expected
  target/i386: emulate: follow priv_check_exempt

 target/i386/emulate/x86_mmu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.50.1 (Apple Git-155)


