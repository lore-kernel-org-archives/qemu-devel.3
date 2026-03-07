Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8365FFC9ECA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 04:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyjYv-0006lG-Ic; Fri, 06 Mar 2026 23:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyjYd-0006gg-5Y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:46:33 -0500
Received: from p-west3-cluster5-host1-snip4-4.eps.apple.com ([57.103.72.67]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyjYb-0004jf-CK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:46:30 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPS id
 5DFDB180011B; Sat,  7 Mar 2026 04:46:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772858788; x=1775450788;
 bh=uL7SH/8eLEnNDGttJV810T7r+i9fS8o6dskAKag2GG4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=K+1iIoi69BHzNTxbavyXZEbpwh13NHzXQGO0xcFSkbI5jgyMAvEBNfToH5edIcTnshUFQqsbQs9AA6a+AiIHsBB6z7wQqsYOrlcGGKU9pyOvsf7xu79ZEFrV4XMl/SuRn4l1uSSa6NC/5AbDpYqVMRwuZcXB86xcu+GAH5KUo4hVtsvkNT5lAl/U3GBVCe3DSzxzwmB0EKB+HjUdNjjnbnHqxIaUPGo2BEO8vNOMg8hO2U8s0ZXQENBmFf4HSyOwMTeB88x6risGX7RXL5VsEL1bAu4mrVXMmojZlVicWN79PERZ9yugc124IzjyvJhkcIGie/dmA4rRY0k6DgEaZQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPSA id
 424E31800103; Sat,  7 Mar 2026 04:46:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 4/4] Revert "hw/arm: Do not build VMapple machine by
 default"
Date: Sat,  7 Mar 2026 05:46:08 +0100
Message-ID: <20260307044608.25486-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307044608.25486-1-mohamed@unpredictable.fr>
References: <20260307044608.25486-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=ddGNHHXe c=1 sm=1 tr=0 ts=69abada2
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=XkhoILwbEVSdr8iLt8MA:9
X-Proofpoint-GUID: pkiJM5pu4mSrk6OSmaYBbDqswC6rNTvL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA0MCBTYWx0ZWRfXxWjiH/mJNK8C
 tNOYrZNoAW9HD+XsvfyGhclVJbW8TwBq+jl4R4/LpLCL+Sj19WbdLv0b12okJLVuLZF12H4Q7X9
 sk3pJLkU2X2Se7Lyq61k3+TSUrgAjRHEFvvrqALq7mdB2MzLeEWohBieZKOXkQSnJzJxokLEWj/
 i0M2o2jW1CKLmJmVlLbRjeNNs5cxxXZl0X9hGTVg60BxGicSa2d4MJ525BYAGsamI7RCJfjwtop
 gDYk43AVpK74sYAmKhh9Gx8BCgdfIGKKF0BNA5ZmNnRtgZshA3su9/NPfLICxeRGarqXz4EQbv0
 VYwHQLs0vMHmseULFXHZDMi69FLUNxDI0yV41eb4nUzxi98G9tP15Y3UBcE4Rw=
X-Proofpoint-ORIG-GUID: pkiJM5pu4mSrk6OSmaYBbDqswC6rNTvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=878 clxscore=1030
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070040
X-JNJ: AAAAAAAB92ozb+pR3tOEhI9OJtDcEIXhjOBc47OE68EB/FqrsIKnpJw6tVSmvrwIrN+r0sp5s4s5SfC5xQqppGfMKQzGJ7wIPa41MQtPyiDmLnUiKZhko/FjaCbsKdsVkpEwoHbdJBrENSr9gskYDvTZKvDezFcm39hRSZ3OK54AX65d+RoDf/jHijhzv0Ezg2JxL08qV7OsQCcdvQk/df65mqXG4omqMFp5qSIL31+v67QI2GIjjgXJpaPhWbaiOJDJBvXuVFvkzZhaBVVUYV2iW+auYWC+8PClJPQsgZFdmR6mzGoN9tER3Wb0dUFW3syF01QCM6SZEcx9bvdcsBthtcPCBw6FuN+fHQlrAiO0e6EkdhAQpUAocb0s9K4PITxoRPbfoek2iDQCuBfLPa5irC0b+PJ+3x+e8pe++OzNlnIFTANmTRdUt+ombsSYZwmv83W6M9WLiA+JWvuKWHa+xMyUidVdVyZY+OU/SZMCACLmK+0vSL349svT6pJFbT+5QhwWqXPacjjOyqHnzljett4tmAOh6NdSWlXBKxG0l6CPg8AV5L51fQipd+C5KbOZIQd4Rz6ugYkL49TrS7deOdNHLxbfRhbB2B5vJFfQx82RwE8TQbb/TpmfISqPQODUH3UFzoJdeKFEFhIqJ3qYzwZyEPNBUFivMArS5ICfRT+2LapFtlT+K9Gy3+RU8HtVjzpLok60DTBbF+sqysEJJ5VqDQHstcEf1RR68kDETHkWIfhWjOxWUG472T9RExtOJ6LExEx5nAFASYPddsTSI4rKWlclUyCWIi5BDR/uSRLG
Received-SPF: pass client-ip=57.103.72.67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

The vmapple virtual machine is now functional on newer macOS host releases.
Revert commit 49551752e860f5e403cdacac11ee1d218141fd3d.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 configs/devices/aarch64-softmmu/default.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/devices/aarch64-softmmu/default.mak b/configs/devices/aarch64-softmmu/default.mak
index ad8028cfd4..93f4022ad6 100644
--- a/configs/devices/aarch64-softmmu/default.mak
+++ b/configs/devices/aarch64-softmmu/default.mak
@@ -9,4 +9,3 @@ include ../arm-softmmu/default.mak
 # CONFIG_XLNX_VERSAL=n
 # CONFIG_SBSA_REF=n
 # CONFIG_NPCM8XX=n
-CONFIG_VMAPPLE=n
-- 
2.50.1 (Apple Git-155)


