Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54663CA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjeg-0008Tr-Ux; Tue, 29 Sep 2026 22:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjeL-00085g-2E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjeJ-000387-EX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNPwnV2876889
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zaTmmtUaegU
 h9yEy5HShXGJUTBAtYGOpPxik3mZ0B9I=; b=HG0Ni8RfIxfE125gCf8JAPKrnRh
 FwGh+AT4KUlC1VuXnWucHZqQ+WnpbvxbQ58NDkyQ7aJNj548LDQDrTkgAWnxaUkD
 PSRgbiM4mpHpRdl3816o9j2Le8HIPjAPOs/YQfknmfPpRERCkd/vdu9hIL18uPDW
 gqIcd9Phst2+XQS9cBU2YxLZ+pgpkizJdhQyng2NW1zHQnlPLxaMkpPoWaYPh4UF
 BtC8G23Fg3vDBRJFAWW1GPaGwLmzOa1Q81y63GSXIwqNUpGfHu90ApEbrNIqE9rz
 j+RY4eOk3YxLUQYeazs0uz6257Qf4TcFCh1R0QfqOk+uxuI/QylvArG4YjQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0et2ar26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-349ffa249bdso4199098eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733731; x=1791338531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zaTmmtUaegUh9yEy5HShXGJUTBAtYGOpPxik3mZ0B9I=;
 b=CfjftBGLlZymn7yO+u6N/QbDuogxjwZDC7R1nTRKCqxF16j8W7SZqucKV6i4L8LXIO
 qrCYRbEvC61AfIdE7XuyNxUYpMxs17tRAU+tuJN7upwpyDrgz3ZPx+WpyhdiTmUj82bo
 2x/exUbBm0qk482wR/jT3txArAtSrNK3WtahgfCg+skqrdWroeRYIehL6QkQ7KhAtZpH
 kFWZOr5XUlEFtUPtiPlryXi/O7DLvvxG0sxMo9wiGY52jkEWclHSZiHtVSBiMPK0UrWg
 ENoLqs50J1R/RBOS/EjY+GKPJXSnVyliEaRtYk3IK9kjV0N1ccGwS7dmpetQ+drnW7pw
 hyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733731; x=1791338531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zaTmmtUaegUh9yEy5HShXGJUTBAtYGOpPxik3mZ0B9I=;
 b=xbdECMhQ2+7UnKFcWgbdcPFRWcxHl1QRmQEMKzXx9k9BHtjufMMz1bpJiQ+GkEGB8k
 fjR2HLgm58tN456O4R3OdU+nQ8Nf0E4CXn43F7nnMpaLC5cbBXQrKbsaCaShrxcqbmkq
 b+T1mqO57Cmfbdmbc676JuO87INJOiRMFbhaH3zZmVUbrfXzrCkuRN7KU0Xvl4Zg337Q
 0YWJ/uSLlY6fn61nCyqBnMSQM/3lobJJwEQGM8IAe5FKAo7RcBNJYuLrDZkgN130MImq
 0YMV+rBGZEAq1mCwTN5a0tGSHaFqtxL7Xei7Uum/UeCOlRHvKRuIOu4cadieJxuv73PQ
 cs0w==
X-Gm-Message-State: AFq9FYLotkjhbyQnb2UsOUrvqq8hZ1p58y4hQV3jQ9JM9VI+rRwhnVZB
 up25t9ROdsJCbl6+p431sHCCGMume4QLoqyhBBM5jaZ4rSqYGIdKpfKnnRTYSK5EldJbzbigumw
 wQfWLsJ/vv91ar0ChFr/0CO1HKsU2D4DKIFPoB/pYujAHJ9r8C9/6LNudZUB3EpNLZQ==
X-Gm-Gg: AYBFou1R5LlHFEMmV5ovtyk09g6ACSoAL8Mbikw4zYCg9Z3J/n65erofWrmaLWcPmZn
 QPEAE5MvQ699d0CGRYDvUXhstxjFX0rmaZ0wUsg8wyRuG0FB5yVSYV5EjqywQyDkiILkh8U+hqo
 EdJ/rB8WpVM+D3CE02V67V5pSPRV0eCviq5A1MyGbOUohZ8QI3LA3qrNC7czcCYPK/38vPnS+PS
 zkz18Glr8D321Ne0umJH/I0SK4fiUKoVIzCxrdhZIzOPAkaFEabwrm/EB+ICy0D0DUZEM5DSwgZ
 CnuBeH4YZdSrZut5uiFId6VCJ0odKfHof8qHaskqfBAMnibWIWrk/BJqffe0dNWegkWvSvnvepv
 SwYwgyn9yv4HzLBp94Z87UFn9OOTA78aylM/o3ICISdRc56Z2hhKzF+bNDjFz
X-Received: by 2002:a05:7300:f795:b0:33c:380:1fa1 with SMTP id
 5a478bee46e88-34cddb9555dmr105879eec.36.1790733731167; 
 Tue, 29 Sep 2026 19:02:11 -0700 (PDT)
X-Received: by 2002:a05:7300:f795:b0:33c:380:1fa1 with SMTP id
 5a478bee46e88-34cddb9555dmr105848eec.36.1790733730587; 
 Tue, 29 Sep 2026 19:02:10 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:02:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 21/21] meson.build: add or1k-softmmu to multi-target
Date: Wed, 30 Sep 2026 02:01:08 +0000
Message-ID: <20260930020108.217892-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7EX8GoZOOwGxVB50L1dIz19sfJ2yrIkF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX9CKz9J1+4I56
 haa9WqtrcCyU7GJlV22TPPURmRht/HwmMLVHsMSG4wgnd8cppAwZ37VUHGotOScycRrb1C1tZmU
 1PqcuzOXEZNvn6T9/m6wOdSjQDUnWr8sr2BgvOITD8PubOJ8YtUI2fPhj6pK9Pge7s/xPUdshPo
 mLaYIS6x4wWSZLex+JDcF7hBfCZm7KG0q6cBF1VRmZLR8bGXusisfVWEbKHP0a6/W9gc9QW4ZRb
 WPkTRKw40z7jK5U8hOYujH5JKM++sVy8vKh0JbCC2IS/++i1HIzufWEeWtGcKQVrkHWZOOB56pq
 I6/jcMyU+6s+jyU3pb/8CDkJF2TXpidBkkExbHObiH/4Y11WdP55ZC+2E74iEAuXxVwTmfEdQ31
 2Lcf0IhVx+6aHTgQ/XpaQDJ/4ISNISqmRMDsRI6uIG1XxJVyf9bS3m9kl5N+9AkEHRAj8YeY1TG
 JCmXjx+pq43A6N1R1Yg==
X-Authority-Analysis: v=2.4 cv=cokOAF4i c=1 sm=1 tr=0 ts=6abc6da3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=jYoFNP88ikvhVi5u0e4A:9 a=Dcm0jervGpIA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 7EX8GoZOOwGxVB50L1dIz19sfJ2yrIkF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXx/CbDw8KOMkZ
 /onbWnFYEl3UT9u+b1mW1q5eKivHvT3ayKZKcD3YmPIKAPVnj262BbZYsX5/5A8PIU3mSsevZs+
 RamU8ne3ji4OUW3yNxLVgXAMHUP/boc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 335d3dcf772..828100de816 100644
--- a/meson.build
+++ b/meson.build
@@ -4269,6 +4269,7 @@ multi_target_supported_targets = [
   'hppa-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
+  'or1k-softmmu',
   'rx-softmmu',
   'tricore-softmmu',
 ]
-- 
2.43.0


