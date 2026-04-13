Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F74F34C65
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKZt-0004Iy-ER; Mon, 13 Apr 2026 12:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKZs-0004IT-FA
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:56:00 -0400
Received: from qs-2004a-snip4-11.eps.apple.com ([57.103.84.13]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKZr-0006MQ-5Z
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:56:00 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 DDC0E18001EC; Mon, 13 Apr 2026 16:55:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776099358; x=1778691358;
 bh=YOOT28fiEdtJgXJo4+sHr2gCe5d+0619yUvpG8SAUyg=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=X7z/DuNNGv6G7btjPdMK1+8eq9mX9sEBgDlew+3qNODVCzw2+V9F8dFxYRdh0s/zTe8xgW+bD1epaWSJPiv/pIHL/rwyCaTcMhuBePqX1Mi92sojlaIEdf44LYu0GsNyfYDn6f243b8J0oVrclPlM4TYjWxLWjzzE/dVUJnP/JxLcf6Rswk2vK9mEXVNJbYnXLCZfNO57+rAsRSOgrHmyJG//+AJyDRex2SDmw2qj57VE8ftG6qpgKLIrePDbtD74HjFGvCWDHMyk//rbzOJ9huC2u/mG1vSwlhDx+RCmgFee6tR4DUGkHbCYim3ryXuGVXBohGGnWvuF2rurcZi9Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 EAC43180052E; Mon, 13 Apr 2026 16:43:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 0/3] win32: Windows-specific fixes from the mailing list
Date: Mon, 13 Apr 2026 18:43:35 +0200
Message-ID: <20260413164338.42894-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Q6zfIo2a c=1 sm=1 tr=0 ts=69dd201c
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0aPdGTaxRqo4RFwBobMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PjCHBwuydqaXSVrB-wVjg-GFH7SiP7Sq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NiBTYWx0ZWRfX3WJi2gzwaerX
 V+EsvLfYk6fNcTA4V3nMuwLUkVl8pLAlHSAXw9nT+sygbBkAbCPz927TueU5x184RkCdmt51Jje
 x1q6sl73X1brjHzXc8ycy9u87lJXPhmVh/1zhl0YzDQfM+LsAoftse8X0QXf2QqWJyMQkrPLRHe
 AIee5//vK4Bz27o5kduHbBNBe5598SZoUuOcaiA0zhpx3uMTswHv4CbMHADM7d/fzigVFRvzisT
 r+442RhIbgzGRX70ojKRgKivCd6jaMy9Katr29AKtYMVs9iw4HK33YrVvlU1V8a4EWtnzcgvyFh
 95TTr9BC/p4gyo89sMOvHNV1sHADcHNCpe1MfZlK+PuGxnnhS5wa16GCfzaTBw=
X-Proofpoint-GUID: PjCHBwuydqaXSVrB-wVjg-GFH7SiP7Sq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=795 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130166
Received-SPF: pass client-ip=57.103.84.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

It looks like these ought to be merged but were not, so
posting them again.

Gal Horowitz (2):
  tap-win32: cleanup leaked handles on tap close
  tap-win32: allocate separate tap state for each instance

Werner de Carne (1):
  serial COM: windows serial COM PollingFunc don't sleep

 chardev/char-win.c | 16 +++++++++------
 net/tap-win32.c    | 51 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 50 insertions(+), 17 deletions(-)

-- 
2.50.1 (Apple Git-155)


