Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA098FEFB7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw3AZ-0003Ej-Vi; Fri, 27 Feb 2026 14:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vw3AW-0003E4-Gt
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:06:32 -0500
Received: from p-west2-cluster3-host3-snip4-10.eps.apple.com ([57.103.69.13]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vw3AU-0006Qx-95
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:06:31 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 29051180009F; Fri, 27 Feb 2026 19:06:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772219184; x=1774811184;
 bh=YHlOC6QpODQJByhnKi0m984SSAsx8vfXpRlZpaeNqUg=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=c/34p7q8W/UXeb6x9Etj/eItPOQAFgsa6qQ8lMmdmad9T4kiE/WWGy8EIO5K4TrNJGhrS7L5unAcZ7LHuYe0yBgrh/yLH3YYj1P8av1bJ7NR3W2JRXD8yy/62E3mlorJZWOxY0wHz7tpKHte02QxMA3mQ1skQWEvQddQI9Fym9On011DRoCEvoFzEvEmPxElnfO9eUUeuFXXMI6Mb+zGnpIPKzBX8A/2XY2dtVJLIkJr6SUqk3ywYQFcKiX1c4RgYKbrQKYaAS7mKj6Dga53/jOOF9KjV8TBaFos42405cboLa8Hh9odtOxpitnJXYIemKJODZRq1xNZyAYQYAgCNw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 9E40D1800090; Fri, 27 Feb 2026 19:06:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 0/4] whpx: i386: even more changes
Date: Fri, 27 Feb 2026 20:06:15 +0100
Message-ID: <20260227190619.8867-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2OCBTYWx0ZWRfX+sE/H91ehu7K
 s58ohdMgnf8T82BLkNzM4+ULQx+4wk8r4e/j4SBm6bRIgdWy10lEMT1TZQ+0WJw5lH3qDZ9ecLf
 6PDwJ9+uckFHC9gJxhHNSUKuQYUOTkWwtAXhN+VBDwkH8cI7eZTWK+IbpIdYlFmsgBVFRv1ecGh
 ey36W5GKAstXSZkQeigCm4c7ln1G45LagwRdAvandmhvVM2QJqTrVyZArDitL3tpWM9jvG9JB+i
 Spw9f74q0atH687jpFPBdIM/qisib04SerVGFhjWqcWhQJbn2Ra3ilu+XSrcSKDE18KBigBU0go
 rgLDOffDyjPTmAlXewUzFAZdw0fLPbeES0WF0mbkZmpBhIB0RF+cRVTqb7rywk=
X-Proofpoint-GUID: 1qyKTspuXoBmubxETvYGslF687BoO2Gy
X-Proofpoint-ORIG-GUID: 1qyKTspuXoBmubxETvYGslF687BoO2Gy
X-Authority-Info-Out: v=2.4 cv=Ra2dyltv c=1 sm=1 tr=0 ts=69a1eb30
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=ZnAijjnxezb5ScpUtTsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=429 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602270168
X-JNJ: AAAAAAABM+BC6qrtsMrNdr6hOMHO8wO6Le69n8H0jkzH0TRK1iFD/moxfPj85i2/RMmjXLiEdGVxytj04A8CSv1Zv/yfKaxhzvoXm29dNHDHBU6vEeKjFG+cnxoq2vDIvR6aW+D/nO9oHtf/sXHDxo4Xq+ekguGP5GQ++Y3D5gY6JB2LgKGi5mlomi/w+xeLtzWFueb7Z0KiNpzC6n4Ba689PY0Nf3Yhie4A7xdLWT1JjZfdxzStsPLEWoI2AKAHhUpZP1Q135iKzqo0033WvYK0mPVrgnVpR6SKHfzFle6oJbJHjKyHstXu5QHT/fuaIp2QudIXmi1l5o0OqH/QwbdzIcbaWAYNsq9+pMrWApNk/QRMo4lvIHnCOG2fBlVAFB2aKzh0mw3Gn9IgIobKnIHTdm54WRzjZJWNk0pPrhfBrGivOkvMQ5rkUQ2+8VRT9/UdPH0jWFFzy9zxwz4uBKcuAXBn3L86ojsj2Yxdrp0ht3sYXfPEzkmtSJVzUlRjEIkf5gdZ7FluSiouQzsdJXHUrxF7kv8ycD8tNBEsATS2aUjVOmWwOGItvkugJ8pbyl9edlZH1sFk54QUcTu4Hn/HcR0OwGc=
Received-SPF: pass client-ip=57.103.69.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This one is pretty small:

- the first patch is a fixup for "whpx: x86: kick out of HLT manually when using the kernel-irqchip"

It can be squashed with it and fixes the "sti; hlt" KVM unit test case.

- enable all supported host features

This enables the nested virt capability too when marked as supported (although without nested virt enlightenments).

- enable synthetic processor features

QEMU assumes that those are a property of the CPU, but Hyper-V needs that info at partition init time, so just
enable them unconditionally for now.

- warn on unsupported MSR accesses

This applies on top of the "whpx: x86 updates (2026-02)" and "whpx: i386: interrupt-related updates" series.

Mohamed Mediouni (4):
  whpx: i386: move whpx_vcpu_kick_out_of_hlt() invocation to interrupt
    raise time
  whpx: i386: enable all supported host features
  whpx: i386: enable synthetic processor features
  whpx: i386: warn on unsupported MSR access instead of failing silently

 target/i386/whpx/whpx-all.c | 126 ++++++++++++++++++++++++++++--------
 1 file changed, 98 insertions(+), 28 deletions(-)

-- 
2.50.1 (Apple Git-155)


