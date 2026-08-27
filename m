Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DC3C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziG5-0007WY-10; Thu, 27 Aug 2026 18:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG3-0007Vm-MI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG2-0003WC-5l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:39 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMcAB850290
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oLma5rA2yLbR0swPh7bAIAXRqc6qV0VXcf4yAANWjSs=; b=kZUuBDnVuLQRBeFl
 I9EYQdiFgv2+kjMnTyRQAQH+qsca+reE1IDoF2KNGCCgRGu7ycc4YwRaXe1pALuF
 Fz8cf2bbDr2rxvU8tUdYcbpeop6Muxc8D5o0jCN/i8GAefG38+vaogA9apuR6sEP
 bTmzTIlhb71fl4sh/WAmkeAlAfp87Z+uTUJAmU2Y5ptudB6p3E3OuBux/tJtNQcF
 qyKEAT5Z6V+tW2+P5POtfjA/QAsYWniws9mF1ryxDMJGllPYEx5g1j/c30d7ODQk
 5BCVh96TrOVtjHmrOpvM5GBtvxej9dyjwk5aH9LRXt3mVeelRqkTIEEhj6JZ77lT
 5B995Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a64n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:27 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so508304a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868446; x=1788473246; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oLma5rA2yLbR0swPh7bAIAXRqc6qV0VXcf4yAANWjSs=;
 b=iiRLIf+SBcIkLU1l5TLlHts4e4lT2FyI8RhKVbHgLfzEknK1O4wuk//QVyOgKdKEKL
 shr1jD2nevx+nGmU3+U31shbJUmKA7n4wvFhONLKcAdKBLPepnFLBpr/31kBE0ygRn/t
 UH90Smyz50I8aeKfl576xR4RNySSotsKQ4BlZ5A3zeilxcA+m61uvhJ9YcOFckBWsLEW
 8GoRI6lted8NBxoN6aKEOdInZWqGmCAfA4C6zkXgnBrlGsPAp1SNmpHF5ohbUTAR+Idm
 jKjkE0l59BV/7crVHgnr1Krz/NxEt/dZbmMctqJ/YskfX2ak5FRVBDVY/W5b99Hpb9x8
 nf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868446; x=1788473246;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oLma5rA2yLbR0swPh7bAIAXRqc6qV0VXcf4yAANWjSs=;
 b=F/+pk9FP1Tz1eXivxTb0hi5ehpS+QM93vJCppkaLFVB9AdXSNRc89Y4/Ee5TmDNsJ3
 ZYwQ6eLoEvK6rwwX3zuFNlT1KGAz48H4/hOfcK70uK4u490a3ho00bIMIZS1u34zhncK
 cRkCpjMO16Lnvc1OIr8vTMWX3oCOY0Hyeea3RkArxesD6vHQQvkwvUw43wKy9ZPDdgZb
 VxZ0+DPEiA916a64Gr1193dlZ2w6GCEquNNASQ9LBwjpWHzvT/FIkEuaE5FHcdG2YnVH
 IiaYz4jXKxNhZup48jUU5YfSjsRbEfpGFoDSeQvS/hP1haSCJPzmvdIe2TEJzuSu0rV3
 3ffQ==
X-Gm-Message-State: AFuF++kKQLUwsR++OD9z1EmR0ScsNQir0iI4degfZz1klGap9jhfNJjy
 KEfpDEBCEH273E5Om1pWzhADDH5gZmWQ9i9ky761Iuw+xMW6a2EPIeElmDc2eePm8hpFYquLwA+
 g/fzRvyGH72GqJdtxS/XSf3jPy6kKBI6tRYmhswvNvy6d7fEPRSJXmhXKzxS4DGHygA==
X-Gm-Gg: AR+sD11fMvBR3mRb/Uz1DFJ86vCRCBxxf+wFGMeX1SyONCepO1ivntP5LSE0XOjqfH1
 FDr3WJ751rdqXwSeAFPOksTrUd8ke2Vgh7n8fRztQNzLi+hND8RDzeSjYe87WtKQqO+MyPNG+/c
 bujkeocZKm6oy29tpoTd2lriJAe8Djb3gQru9o4R2bt0novZ0OjL1w2VgUkh/5h+0WO7tl1ol5w
 yWN/J/6PhELPffa82Wr8nUD+WWDUuioPYbfMsdKPist4TyltF9zv6F6BLo5DeEkCITg5vLDa+Yk
 J+b5LhFoIXZTL993j2w19OT4uGdG4D/oUzrg3vjimvxagnlVa/Vw1gJ7dOm+n0r6RSJPNFYYcTv
 h3i3OytuFC+0YmYsLxbMMZYROK1S9atxHrtmdOlN5uivzO3BK0QtC3l2SeO8=
X-Received: by 2002:a05:6a00:2e90:b0:851:ba04:ca02 with SMTP id
 d2e1a72fcca58-8562b782769mr3668305b3a.16.1787868446218; 
 Thu, 27 Aug 2026 15:07:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e90:b0:851:ba04:ca02 with SMTP id
 d2e1a72fcca58-8562b782769mr3668226b3a.16.1787868445807; 
 Thu, 27 Aug 2026 15:07:25 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 027/105] tests/docker/docker.py: remove "Image is up to
 date" info
Date: Thu, 27 Aug 2026 22:05:21 +0000
Message-ID: <20260827220641.84885-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX40FMkaRL8GlP
 IG1XdcBRfOIMQF3WcPDOTkfNb0xsE8w92M5JnW6iN3SVe9YEWg2FllemUrHtpKYg3rYQcI+TN0d
 Vw7/Us7SPZbTSMOncCMeBpeQSmrl/Z2iql1kkPpoz+GqE05YHvxqi/KoWMh8cD8PMRTuDdsWD9u
 8ijOfAlgIXiu/Ky9eLQf4yYhzpk9N/pXJqarf8xY26IO8zG6bq9GqdTQuF+kFK7NbvjH5tO0PUn
 4ZgycsJkTxS2eA83gM96VSHMviFo9rh5Z0jhhwKn5rT4uxrXyfDx545fCxt611xsRsEO3JwIJDb
 dNdnkdO4ffNxCwuCfl1iPRzOt3QWlAmTyRzdgChcpGDc3FNoLjSlDwQb2jp8BnTFIvFBY0jYXPJ
 FTdoXZ4krKZBKYFCaPJe9RK+RHvJQ/P7SYTrCs/bpOJNIylC8nN2+agBPQUgFPniV6WrFhU84sl
 RPMpzuZFRe7NcFA/HIw==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b51f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=3L1wqYL7HJlRHUT7mJMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Ku_8pmAP4vfeNX-tZYQcU-jDhCETo_6n
X-Proofpoint-ORIG-GUID: Ku_8pmAP4vfeNX-tZYQcU-jDhCETo_6n
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX3IExjTvIYnmE
 nSoZagCY1YNX9cyvT/zIBHMBZWVe/WJM4Ms7/hUmYpbu7CE0dKFU7MFaQb6blZpx7ScpbpRlqJ9
 mLrM2N8Dexn1pXANbu+EcGQ9pUcg23Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

It's useful to print build output by default, but not useful to mention
it succeeded. Reduce verbosity of tcg tests build.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index fea6d0f85af..315fa2ff848 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -429,8 +429,7 @@ def run(self, args, argv):
         dkr = Docker(args.command)
         if "--no-cache" not in argv and \
            dkr.image_matches_dockerfile(tag, dockerfile):
-            if not args.quiet:
-                print("Image is up to date.")
+            pass
         else:
             # Create a docker context directory for the build
             docker_dir = tempfile.mkdtemp(prefix="docker_build")
-- 
2.43.0


