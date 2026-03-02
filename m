Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C4FD58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwttq-00048j-EG; Sun, 01 Mar 2026 22:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwttm-00048K-Tf
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:24:46 -0500
Received: from p-west2-cluster6-host2-snip4-2.eps.apple.com ([57.103.70.75]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwttj-0008Il-Tp
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:24:46 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPS id
 6D06C18000AC; Mon,  2 Mar 2026 03:24:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772421881; x=1775013881;
 bh=Z+ZXlHxZqL5m9IjGrYI18dyP4pUx+lq+7Izz0cnnHoI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=R7vdb/F7dREz6uF7k+qefg5MBE5uSHcvoFJ19ciLB41mpuhE9N8/kRea9d1RPhCybdYICXG0GOMGw5saGrUeendreiXE7RLxlisiLq3q6BA9mWmWv1a5bRkCM4KGNGQIR0Q+L6v6OOqNJy50LgEK5A/yfo7gN8aQ0vl2hGZxBXwRBKR1VPPJafc4JgFaH50oDKw1ZGnVnEP+LATF1aBr3hcItT1Iw44WuGF1Yla4wktbe5emEpRyKRINBvXUywT0QMLejhCXjYa98hXVYQ1JC7P9NcQt4a8Rry0zWxV4hoYDy1Dm9fNVkpvRdSwfWmroN8yEjTFPkV/SVcmcKK81gg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPSA id
 074F8180019A; Mon,  2 Mar 2026 03:24:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 0/3] whpx: i386: small random fixes
Date: Mon,  2 Mar 2026 04:24:32 +0100
Message-ID: <20260302032435.42698-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAyOCBTYWx0ZWRfX5B+QTzuomcDu
 eztm+k3w60EW5QIJmS90FsiAuoYCCe88X/NC3JYt18SnnewBMdES8SCyxfTogIFoUSbFm3fAjH1
 cm7yR/JMY0ext8JVhP/Cdd4OLglZfcnGD0DjXIlzGXqvPtQc09Blu964aLE4O/iP5eMOGYzpJET
 QCQRm2/BC8r+lk4Y1UNB6gEKlDstJHieIJm/WulhKz5yNRhUqNS2e6Z5mMBmcADZc1gfUo7cedh
 T3W8xCT9BDlTwGrT6xOOMgvS3L0SpMi62Vlezx6IYLjNoCdFIRMX/HJ3PX0+enTZVK3l31eCfTf
 I2tdiKEVPE9z7kKKVj+H4RTaIdMhdLWtkBBqINiAU256WpnONQp1NA3+WaAqyQ=
X-Authority-Info-Out: v=2.4 cv=J66nLQnS c=1 sm=1 tr=0 ts=69a502f9
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=9--OXFxxhngiDR9OTd8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: s7DRdxNlAba96M5DQ9XzwLy066bimZsh
X-Proofpoint-ORIG-GUID: s7DRdxNlAba96M5DQ9XzwLy066bimZsh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 clxscore=1030 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=699 lowpriorityscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603020028
X-JNJ: AAAAAAAB5F7U99jJJmsgLG/ac+GkDrXKTqx+jbRRMHozl2nA897al5XIWRdqxiWoVFttaV8UmyycpfFIBjNNsF3D6NkYd2HpObzt7tcqyLg/1ZKCNstXab3kHyu2zZAKlGRV/icizWw5tO17weaavDjB3DNNVPEjYzTuvwrNedMrGht+cTFsexZLjl1OlQh4bJFilYBGLW7Yte9cf5IjpSh2C5WLDPGxAX4KiqmxdkywJF46oAQdXK5iUy7YwnkKi0gsTryIC/Poc5irlRfLjLdRTCeJXxAc8zUBRGmPaT/2tD1g3vCjm5hp93jxEIz1cK338WZNnobBGmeCtZ5O8IoksqwjDO3yVLn5yB6JAITX6CPwu7RqceJcKXifRpeBGlj2pQMttyDhh/pU+0Y0AAejRkoLZ6Akfu9giaWIpT6LlKi87RbxciA5XcWp04Ww9zbjpV+GeNO9nZee1aHerXyFKNSA/eVxxArtJgMhQsFgRi/XGyJDUtER8hpZjoT/12OpOxk0rf8Rjs4Os4xWyKWoMwfD5QaQQyF0oqlYY79WabKdzfH8gleL/UypiKIuXqmUK0nnHYD10ZU2Q1Vkq+R5v19EzuAIorpcWR4kYwIYCzYHjCoMbR4SOdH+dx2+uIW7fLmqPdDUB8rMflbuJBzcDNcbTPrGWab2oeqWaaYZwmpxfpav+YsI
Received-SPF: pass client-ip=57.103.70.75;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

And this continues...

From doing testing on a Sapphire Rapids box, saw that there was a stack overflow in
the page table walker code when the guest is using 57-bit VAs.

And saw that nested virt is incompatible with kernel-irqchip=off so made them exclusive
to each other.

Also enabled some more enlightenments because why not...

Mohamed Mediouni (3):
  whpx: i386: do not enable nested virt when kernel-irqchip=off
  target/i386: emulate: LA57 fix
  whpx: i386: enable some more enlightenments

 target/i386/emulate/x86_mmu.c | 2 +-
 target/i386/whpx/whpx-all.c   | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.50.1 (Apple Git-155)


