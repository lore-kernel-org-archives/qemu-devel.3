Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609CCC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsS5-0000On-7Q; Mon, 21 Jul 2025 11:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udsRz-0000Ir-Un
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:29:12 -0400
Received: from p-east3-cluster7-host6-snip4-10.eps.apple.com ([57.103.84.191]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udsRy-0008DE-3F
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:29:11 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 8183D1800128; Mon, 21 Jul 2025 15:29:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=JR7eof0SH5HLyb+Mv7CXqK3FI5RpRk+zvy8rYk3Qn1Y=;
 h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version:x-icloud-hme;
 b=fRrX6qcYTQZCwupaCd5UBG/BSEYzJteBCCXV/qeTDO2RDdqWMH7tu3nKfFP8bsnKrajMyN2mTSWCYtSM9phUDEyvS7dyUZSnDHIHxi0E72u7CjeU0EPFvQ1gEk2ORxjcnik87o8AJ+7p8L2zmQis1kAC4aExBUzMp4CVYtU13riJMfLUnrVVCUnIuU8D4NTvedzB9BINAheiNoV+K3vWBaK6wIOxvROrQC7frN9ySI4+NkA6x/ui63FtWRyG+7zTXfyUkyE+F8OuxpHXuJlwuHitTwoOL03Ck6TtoHdkQcqcypAn7ThJnW7wKd7O2J1AzaJWi1S9V63C/g45SPE2SA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 B8FE21800115; Mon, 21 Jul 2025 15:29:04 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 0/2] target/arm: hvf: add timer freq note and stubbing
 LORC_EL1 reads
Date: Mon, 21 Jul 2025 17:29:00 +0200
Message-Id: <20250721152902.38671-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HHVVc1YhH2-aNJFzb3Z4Y4mTOdIhOOD5
X-Proofpoint-ORIG-GUID: HHVVc1YhH2-aNJFzb3Z4Y4mTOdIhOOD5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzOCBTYWx0ZWRfX9TnhR0DVWIiP
 6hz1dp1lMtaTS5efav7ysG4wNRWqxUR5YDsZ7Mj2Sc7goKSGZXtX3IKa+e13TrUssNlvqCDw6fe
 x+In9/XHaZEvVD5aFXIbkIL42toBRFf83mjnUBoy0vx9Wm/FhEaiV15GOmYdJGm/GFGT9NVUkUE
 PQBngbh/jCbqAQz9MLygLTsMC7fYeKhRdlCDRMLJVnmvS2365l69Nn5tTD8wzALcfmkk6oLLTec
 pfQ2kAhUbfzxnHhElp7MaYcNOyuPNnSWVZadcKdABSDwm/FVDtfMwLciy6rrBFjsZl5irkNS8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=546 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507210138
Received-SPF: pass client-ip=57.103.84.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hopefully will be useful to know for somebody while
I keep testing HVF vGIC and nested virt patches.

Mohamed Mediouni (2):
  target/arm: hvf: add timer frequency note
  target/arm: hvf: stubbing reads to LORC_EL1

 target/arm/hvf/hvf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.39.5 (Apple Git-154)


