Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF1AC9830E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAGnC-0000LO-Qh; Fri, 25 Sep 2026 21:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAGms-0000Ik-Kk
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 21:01:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAGmo-00067X-7J
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 21:01:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PNcQHS1760888
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o2pBM77M4j9n9oME7lfXwXk45T4g7GUtuGv1O/dDIBk=; b=WrJnkKn6x6Lo0y91
 xb/R8VoFIy49r64wc1rByQcRXgUgqb3OWIRhli8KGpEPiq8Uo7R0LveyUAps6qQq
 ztpyZQ5V8u+Ii3Jyr1dWFPYqEaZzTMevb+LUpkMDci9evXsygGGg8mNQcQX4ywoW
 oKV/QIh3u/8woL5z6qHAgjzEPgtQP8YY41uhMVM4LwKbM47AV2qD08PY7ft4qkgc
 veXB2XB98qbDVO9LcfBW3Vueby3wsbtYMNSnQt3cFaBrwmE0NJRURUjB/PxMUw9h
 kFyvt8WUa5+SgbIoiJ+FthRg69gYjU+aG/LQG1P3d88ocs4TvwLkv7S+kby7QBI5
 AqshCA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq3brdt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:01:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a0ad137e87so2061814a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790384464; x=1790989264; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o2pBM77M4j9n9oME7lfXwXk45T4g7GUtuGv1O/dDIBk=;
 b=AS0Q1gRmLvf/7y0y8j6kUsuENmrJohVjYiNEUIEAqq0wWHc4gsRPK+VQOZw5vYu2yn
 GY3P34Zn10mnhHI8FwTuiKnu9DhwOuFVfwO/cmaI2ECIlL+L0qczTEPzp2FYQG9dyXET
 UsGb5+qBtzKAsGcdEd1CQiaJQBCeqq6bO/c3I8Cx1hv5Y0d9Z16bVbFS3wisznySf0Wr
 +RT50wV5PF8mbL1fvybz/U7/S6h2DeMeb6hjJf9Jltko7e87wYCv1DDXzc3u6tN0jQeQ
 3MtNxesjo5nK4cPHzcYiM2KsmA6dGldBoI6083aUtaJGUHr1Kg/LKZNhbIYnfqGZJnFm
 0/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790384464; x=1790989264;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o2pBM77M4j9n9oME7lfXwXk45T4g7GUtuGv1O/dDIBk=;
 b=IkLX1IzcsvnFXFNgNA0kmgCWbD7GgsBzV+CNMNBStnIuVW2PcR2UjyDR02XonUBBKW
 UQP7FZ+rjSSjQwmUJSrY51Ucj1d/Q3tLl9ISY10LogPk780SIjcZGuxh+MUHZgUsKcJS
 B/CSWcbroR/fA6Y+e6rie9P/vfGohp4gvT8OD5OBJSYEnPhjIaBJ5l3dlBm0qOA1Xt5P
 6baMW7soYXm0X6aRr/VgCZXBLigyWYT8gEyKu9QoiMyry2fivYqA4QK7+eLO+mNT+sdD
 p4nyBIqZ1B7XqmFII/4pn9qzArN1lK12avGKR5kP5Wdhy+61DGxB8O6PuTo33AFB15dn
 epwA==
X-Gm-Message-State: AFuF++kH0Ijem5pw7l6Y24qqZSL5Y8xeKZG1Up5YWl4Za3chTChohBir
 nyZJf6MqziHQ3DJAbGZoiAHbkSKhmzoMvy02i6oLiJVoXPcF3lJuaeacqMDKLKlWVNg7uOoKuKv
 +oWmKBLckbbVD7MTwlJUK0gXZlx+1bHktVtTSSCzkaz66yS8OlaCnQilYYHV3uQbVEA==
X-Gm-Gg: AYBFou2g0DIt5tBiJTvX/P7MMv9kALnZaf5maREBUgUzvvw8Pt1ywSXpKCgbmftJkSm
 bFz2waktJFg4xbzJSD2odc005zYdn9lt/auSzvAjZ5kw6MfzKeA6UC/9Suk/+MEuwFEyfziVkrf
 yapAo9kvh/MuxG2113LSzmmK/0/p8Odkj6tIu/Kl6uz7lOo8rwURUhlVT9eruanZpN2Z4Sl7pSO
 /AOotF2C7pP3R+JXTI2J2cH3+R+qhurJBdhyx6BglVoQoX7tLnxXmsxI739eBO3sbc+L+wdsNfS
 83cVcobrDFD+OL0mXkCgPWUKh3QtLgF/7YIqECyVoaeeR9UCae9LHF89NjHhRuGa5iWnVWaFRBe
 WCTigf2kiNPN30NKDRrZ99HQIkSAxcCabAQUjRXWG5F94ebJJ3sbdINu0NpW7
X-Received: by 2002:a17:90a:c48:b0:3a0:a055:1739 with SMTP id
 98e67ed59e1d1-3a0a0552132mr3924476a91.25.1790384463896; 
 Fri, 25 Sep 2026 18:01:03 -0700 (PDT)
X-Received: by 2002:a17:90a:c48:b0:3a0:a055:1739 with SMTP id
 98e67ed59e1d1-3a0a0552132mr3924447a91.25.1790384463145; 
 Fri, 25 Sep 2026 18:01:03 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b898cabesm7138253a91.0.2026.09.25.18.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 18:01:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/5] tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix
 compilation warning
Date: Sat, 26 Sep 2026 01:00:50 +0000
Message-ID: <20260926010053.2840-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAwMyBTYWx0ZWRfX6TBMt9NJHJaN
 gPAQkffiENpxVPV7YrMj/aDX41o+VIBYz4Ze7Mo/+K4Y+aVR26R9DMbBOd/7dDNsjzw8PKdQSdk
 j3/QpW4x2RyjzCYX26ncZTv2Y6t7wxU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAwMyBTYWx0ZWRfX4VUOjimE5oBg
 oF8uqhEfs9tCutuRAVQUf1++cXHYErKfFBnI7yo0nscn12kp5e+maBNUGs7NLbZxu4vJ02D1VQQ
 EiZ/M1Ww9iQFiOGpa7z2f/Ho8eqX2uZkMdTYUxMfe5G4Mq0+4PlIvwkuTAr2umLOeH7pxAXnmIq
 YmEsqoAOFYI+mksmrDfthjh84ePfXZdLdUcVGlvSJP1pmaNLdmn7GCgF/Bbg+I5jjQhEIAmCq91
 JzJAsdklsjAEak6cGRYb5e6mb2CRxdZ4cStinFk0zj6E86YJ/VZogFktf9p7Nbuw+1yVIkQ5Xm+
 scCC1VQ6UR8BPp+olVGbyf73I2NzbHGblcPYUpvh6LtZS9D7IvyfUbp2KjE/tZUc2Pk6afVdhGT
 w6BlxhlgElfNOOynIoOXk3C54B5RuNiacXfxAjD2qdnvA4+Y8wOmlxU9bEE4wpWpltibpwq+45d
 EW9IKNJNAOm2D6OjJUA==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab71951 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=GOtNrUbr6fPSDctt2LQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: MxhQXi4AILV0vGgShFxr1OjhJKb9Q1Iw
X-Proofpoint-ORIG-GUID: MxhQXi4AILV0vGgShFxr1OjhJKb9Q1Iw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609260003
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

../tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c:13:5: error: ‘dsp’ is used uninitialized [-Werror=uninitialized]
   13 |     __asm
      |

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
index ccceeb9f4ce..10c182a54b2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
@@ -3,7 +3,7 @@
 
 int main()
 {
-    int rt, rs, ach, acl, dsp;
+    int rt, rs, ach, acl, dsp = 0;
     int result;
 
     rs = 0x03;
-- 
2.43.0


