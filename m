Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FCEC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcFJ-00042g-2y; Sun, 16 Aug 2026 10:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcFH-0003og-6B
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcFF-0002b3-N2
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlOdo2399229
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OPwRUFKMsLE4Q9u2udZy/naPOPsDOQ/vP4GmRlNYAAg=; b=OfYkQFiXOILm7bZ4
 P8uaVTiigT2yeBBr732xzN5LqjNJHLVE+KNhq+VT3l1ElttCrlZv8VGs5sUp4q5A
 bGUFkwpnZ0f1Kh4BbEKcWR6DZX5U1VuFFJvgkXk0mZoTqQP/2eK7kKyJLBxRm5hd
 /kztGp1J+Vl7EJkaeUyRMFTMKahV5SMlYzaf3eyD4nD8gwHec/L4lDmPbaxjzlzc
 xGIK0vatefS6k66K6FqRl+Q3ju8xJPK5hdidEvpEp9FGjnpLYg6bv5gJSvgW2QHg
 rToV0HlgjVsPLboy4BmAhEIkYuvLJkSTMI1poygBVf6FfSdcgKnQNCmjj81NBXoS
 gwlt4w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq3p0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso45140271cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786892032; x=1787496832; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OPwRUFKMsLE4Q9u2udZy/naPOPsDOQ/vP4GmRlNYAAg=;
 b=Rd59lLQruDWXEQ5eulgzU4pup+0zG6xVIVz0edaKAbmqi8XetvdvlYOXFMSKZaW4If
 MwsUlkdQua4cUq1z5EAtdx+wyX4alkKGGn1OECrJvX5sn7vIWmX8T5NJZwGy58LS3Xtv
 g6kh9/pQoBTYkjZY4jexSYE/RD9c5i+NI1oqLQjjye4NtTSMp3U/N17wTuJHwVLFl+on
 gPVjRXjO3eJE6b2IyNj2WKRaTk/iy5G5Bx/u6j0xatsUKphib8jAHeSpXy/hlRgDOzYq
 f1xmc/lg5oSlprLG0NTUrl2VfTtDCh1CS2JycDmfS58UalmGkwBpvyHM19cegSHA5oc0
 bYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786892032; x=1787496832;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OPwRUFKMsLE4Q9u2udZy/naPOPsDOQ/vP4GmRlNYAAg=;
 b=Z+qYZqbbgEFFOK6m/6PObj+fZ9qBhwpRd8mw1RncMku7Ab1yO8aUbS7CeGUQ2Yi6OX
 tFU2XJ2+nySKRyTLkgyS9qlesVE6ncnM21jMxX9eqwF3wMw0NuokBYooY+b3p8xZkajg
 Tu2VuLuJYU41BfP4N+n1wpFwYyQybVVgMQ24KcKmE3zEvwEcXUp3eSUeRigH1YOocAWr
 MCHsS8sRa32/8axTdVeZLbPdPGiC+ch8X3pI7sT/KoGT2r1OEPjciycEqC/5wm6J8Koi
 yCLmGWrWw+eBRd2MUoTBfyug6B7qvv3vYp4bdHtKuxfVVkx1wwshfWhv053KQf78yxRS
 J6Sw==
X-Gm-Message-State: AOJu0Ywyd1oH5XVYXmpW+LqppK/5Pea6QM3X+KYiRGaYRSxgBHAF93Qf
 pcDoLeKTeuhi9BJOFR2KJ+4ZcAoUmm/33bMemi3Hk1zAaRSngYbvZSbkBnpItmBSztYplYqA4jr
 HXO2zQpLHgrTVMiKNSvdbvJ6CwEdkY5xU2llNQrXkiiWtH62T0xUv/Vu1O26K/RR36Q==
X-Gm-Gg: AR+sD12VHGUd1Z6n4GHAMjFfErOtZfAGtFWU+LGMyseuGnyGEM4WyRk21y+5oBxFW6I
 l7w0F+UVuHdgEWQLhEbWtVQn2a5WkeEGTsuV9d+gV0GrUcPits8p0TfHzDAeH1JF66FKCXPwtRv
 RxZcUBmgCNbfbkHtTFU2QhNhgD2LBtvTCI8+gLprUEitTr28IvBBsWY77IM2LyANxasfKojWzac
 fEAx8/xc8D76MLPqvKERTcGl3EazJuoPv2Y5UY+gsGiPHxG5F2PC51iDUwaXqc2TXtTV1FgIMxT
 McdYYcEogRHWf+gad+G00JByKOJI2cqPzYYhR9zwztWZN5BbCTJdBuGSrOpFflF3yUonYvv97yj
 x6O70UN922+AGrH+fedMyJwNp8gVog1Hei0nClR91Pw==
X-Received: by 2002:a05:622a:588e:b0:52d:2ddd:27c with SMTP id
 d75a77b69052e-52d854b4aeemr213767141cf.31.1786892032209; 
 Sun, 16 Aug 2026 07:53:52 -0700 (PDT)
X-Received: by 2002:a05:622a:588e:b0:52d:2ddd:27c with SMTP id
 d75a77b69052e-52d854b4aeemr213766791cf.31.1786892031775; 
 Sun, 16 Aug 2026 07:53:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499960fef95sm63064565e9.1.2026.08.16.07.53.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:53:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 56/56] hw/core/machine: Move EHCI migration compat properties
 to 11.1
Date: Sun, 16 Aug 2026 16:45:55 +0200
Message-ID: <20260816144556.69009-57-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX9cDri2zsfYif
 WFiWUHS7I9mw5kT0ni86W0wSTuS6Hypzg/7p0FlRKkqM/lBvjNvfc6eNoVxMCpqwvz5zCUenU3f
 HROn2DMGGt6ki4buL8aLIKOdK6ZFrMuHrgLhIbKGYxnMG0IhSqltbh5E/74BHKEZufSpq8Ex9OU
 K2ahQtsFkscXFsbV0UHJoKa65HvOYuwpqnzB77OtwmL7zCFRGe7uYQ37FhNL5SC/dhOb1ibpUNP
 7Tw41ezcf1VERCksKNXyl19kHm/NzNlEhG9VUN2MLNZCTvcmOByXh0Hotjjp/uTlqPiS96eJwtw
 6XnEj2/YZs91VvuTaXFt0jAbRdDFcCYdTHk8RZF3Dw5amVII/oeiXMb7CkUYlj08Hw+yFFGweTt
 J7Io/dOo0oj93UEcnSP2cP7CkU7sijhSKaljzWRgkTex5ymm/2EMCAbSuyPJ1AZAs52fSLN4quJ
 mT3VfCFcG1YOag7YeVw==
X-Proofpoint-ORIG-GUID: TsEyXBY5xxyFJI2wuuXMv6A9wgj04zi7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX+MwYX6Tm18dk
 CxxebU8tYibEk9RusDKV83+cnx6CmpTNAtCSUZKq0P2BK1bOxx2XyT7fF0ZTzvIBUpJxy9X2BqH
 AFt8uHt1q6gX4wOzKJJFZb0s/MvNGkg=
X-Proofpoint-GUID: TsEyXBY5xxyFJI2wuuXMv6A9wgj04zi7
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a81cf00 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=-BVnA0jUmpH98zYowaUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The x-migrate-fetch-addr-64bit compatibility properties for
sysbus-ehci-usb and pci-ehci-usb were reviewed before the QEMU 11.1
release and were therefore initially added to hw_compat_11_0.

However, the EHCI migration change was merged after the QEMU 11.1
release. As a result, these compatibility properties belong in
hw_compat_11_1 rather than hw_compat_11_0.

Move both properties to hw_compat_11_1 so that migration compatibility
is associated with the correct machine version.

Fixes: 38ed803aebb2 ("usb/hcd-ehci: Change descriptor addresses to 64-bit")
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260814032559.3381363-1-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/machine.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4e551194465..e617f7804d4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,7 +40,10 @@
 #include "qemu/audio.h"
 #include "hw/arm/smmuv3.h"
 
-GlobalProperty hw_compat_11_1[] = {};
+GlobalProperty hw_compat_11_1[] = {
+    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
+    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
+};
 const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
 
 GlobalProperty hw_compat_11_0[] = {
@@ -54,8 +57,6 @@ GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },
     { TYPE_ARM_SMMUV3, "oas", "44" },
     { "migration", "switchover-ack-legacy", "on" },
-    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
-    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
-- 
2.53.0


