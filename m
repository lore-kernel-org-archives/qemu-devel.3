Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC0D112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LEH-00077V-JS; Wed, 11 Mar 2026 11:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCq-0003RM-48
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:40 -0400
Received: from p-west2-cluster6-host7-snip4-5.eps.apple.com ([57.103.70.48]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCl-00067U-Dy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:38 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 675E21804E61; Wed, 11 Mar 2026 15:10:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773241833; x=1775833833;
 bh=F7MB9xDK8Y/KCWxyNNFo79pG87u3BYQyDUlbbG4/TL0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=B9dKMwxRZtzAQEdJHcuG7iiO58LkGfMI3nHIAvVR7aVG+cUrIGWzbGuTDcKbjnis/UCbARH0sryCtZVa7CdJi3Q6cNpHZUxGPzobm2h+cN4+QM5/UA+g6dWBb/3kQNe/pObohd0lk+Aa6UOQ/oFfNEabbKMUeKh7T07CnJ1Z1H9z5ObMv8Pn6hv7vs0obUNqVOvcV7idZnRWT4c2M6PcPNmUMHFFOh/bjUAJEH5z7CRv9knFbHm8CiimsxTMwBxYsm+MaVJNY9F5VHxM5ncSvTTcxIQK2OFZr+WTcMhSDsAkGOPD9wINI8awrn8zp2sX0Pu/jTGz5cldoMscuntOxg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 9796F18015EE; Wed, 11 Mar 2026 15:10:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 0/5] whpx: arm: set of small fixes
Date: Wed, 11 Mar 2026 16:10:09 +0100
Message-ID: <20260311151014.55915-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Nu9Xp1TAAe6OdSlsLCZHggDCPVPy8XK1
X-Authority-Info-Out: v=2.4 cv=OZWVzxTY c=1 sm=1 tr=0 ts=69b185e7
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ITCvsc7dFgX-EMZVpccA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyOCBTYWx0ZWRfX1Fb976SPwszo
 79iC4LWkZAUH7seTBn2VRsc8/V/AjrhKpHV1yruwVgIaMjVIIXc9m622VwRGVbstPF1tiQlxe+2
 IS4eLO4ynRWTuTBXfzGd7zknBM32yfgwtqxgxS4UreqgWgUmoGUHH+TpL70x/PYlfKP6xrahFVv
 9H+09bscFwYr2AIt85dtU6QhPrIccSkoEwSdLSOJftnv53mpj3pFzBDA0X/+WyJo2V0UI5T8KOs
 PTiqHFNzmCASBqjkPpi0WE5WtkRtlVfK/VVFfM9wgVjRPDRXSfs7/RoLilXh0Iziwraccku4xVO
 tuxv8sxvCcGYZbRZ3CuAvI/t8OOBLT6G3jqgBJ2aM/2As4QrFlpmXDOuAr9Le4=
X-Proofpoint-ORIG-GUID: Nu9Xp1TAAe6OdSlsLCZHggDCPVPy8XK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=618 mlxscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110128
X-JNJ: AAAAAAABywpwkN7GlaDy3Ee6zOaCDGU8iGuWXeyqNHSNySyE5ceSBZ3QdlzoyhWmFffJ3BF8USgPZC/JwV8J4jUQf4/jUZRszQLZeP+sBQm9WhEWAbU/CvWnMqW6EuofmwBLG90/t7/ET0DvtVBvMPV3y5h32xl+hwUPX+JGYxQcs37Wi0vvwbcPOsuvPlF2qnu/afOejHu2MW+Xtlx4g0KbkDd05zbySeSrd7b8bMxxYOj2dmDUkVTmwdFuiqm4378OI+21pegKRM2L/yrJ+fZNjy2zuYxE7W5gUf2YE8nwESKpCib4QkJ3KhfTjwE3PLApy6cGPOwybIZ0OFSv5/dcreFXWL9jWbbLE+Bfsa9lKEol5jcwmo5ZNp64d7cXkOo52Gu+2jPQ/uuUeUMJNhYHH8tPMgeb50Y6i+07TvQa6LI6QeUIzs+IsaASSwje/hmsGF/GftFiGBphO2f8G4tvUDeu722Dt+Mv0TcaPlTMFH/n3H+G8t+OmJz+CPfcXlxXkMz4JNgvZ81nU4xlXq+1QD+70S4xgPM38aBJweb4Kjr1HLFXVNp5iLJ9PRRVQFyimJi++5WWkpZmvpdRp/NhRUx4i/LZLPhzFwW3di2hRVU1HMlMwGK3YWw05HU=
Received-SPF: pass client-ip=57.103.70.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Highlight is probably getting -cpu host working on WHPX again, but otherwise pretty small
set of fixes.

Mohamed Mediouni (5):
  whpx: arm: fix -cpu host
  whpx: arm: add EC_DATAABORT assert for
    WHvRunVpExitReasonGpaIntercept/UnmappedGpa
  whpx: arm: enable more enlightements
  whpx: arm: remove comment bit that is no longer accurate
  target/arm: cpu: alter error message for host CPU type

 hw/arm/virt.c              | 2 +-
 target/arm/cpu.c           | 4 ++--
 target/arm/whpx/whpx-all.c | 9 ++++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.50.1 (Apple Git-155)


