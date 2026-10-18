Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5D0CCF2D4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 23:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIZyp-0001xa-E7; Sun, 18 Oct 2026 19:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xIZyo-0001xK-IJ
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 19:07:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xIZym-0008FK-NU
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 19:07:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ILjKNn1956835
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Vw7XXvh93hkTueCsFYlkxV
 0beTx7+p2NZ+HttDarvO4=; b=V4+J2JXrTS8KElf0e5znH8akC7C7MwnCPKZGPf
 3aRMzvkgpS9cRlnhGQo3UkhoVym4y21Ew+LcJjmDUrB6prgj7Gu4TfgXDPrX4oZm
 5qd8hPGD0A/maooWTB4AFby1YT58cy66TtIGlUyC6g+AXFqRBSSj1AhDUhP6d8YP
 W00DrLUSf0EQqa7WZNmc8IPIG0gPvoWC2a291VKlZ9X49c4Gu9bqHrr0vKVC7r+1
 kGxavO7mo6v/gllF14fmlb9YBM+jt/8M2fekRIpe3+YESctjV8AKN3jqPSdyqzTd
 R/CGdMuex8qATpvRbcMx+rTsQMZRh3ZoTQonIvzOOFUpcFaA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxqfvc1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:07:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb93c874bso489074485a.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 16:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792364865; x=1792969665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vw7XXvh93hkTueCsFYlkxV0beTx7+p2NZ+HttDarvO4=;
 b=Dl5aEq7xtUpIdVPnx5g7iBC4PL05QuytQSNiKDhVIOlLWuF3kmCH4I0kmegZsnEdGT
 JBpWPnNI+Wes1I6iqwcpJd75dBKtgQC1IWcrQZgVOg2NNgSKFCtlKj/HrPzow8BDMFS/
 T5nHVO7A/H4+1Wvc00k00hRrYNaqUAdlvk9BBovM87VU00JgdZNNma1PXF0HTKeR5VUY
 z/Q8nYM//4ATOAY+6Tu+zIIpztuyMDGSFBn2D2i0qGz7NVjJ00kYqvCKF54yTJGziX5g
 ZMmoXn0+JzlSob8AF+eTAdnm44WTwHfWIWZOiWENzgRZICyF8mpHOM/he+l4uAoWxL2h
 uGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792364865; x=1792969665;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vw7XXvh93hkTueCsFYlkxV0beTx7+p2NZ+HttDarvO4=;
 b=mcRLvVorqJ1T6kWdF/A3qAvUTC1kCiyRzHN4bi4BCC/jWiFRRdDggGTg4LWMhvHJGZ
 MhvE/jKYPiyskmR6Q9NrPaOU3vB2exge17KPRsdpL5N6t2WA1LHVJyHSHBI+1LfRBhQi
 AF9zpDOcEiLZGHdNar4yOO9rTEuUFePLwh8J0dIO8rrILrWSg5+A+iYcPuVCnJ6bkuM/
 92bBsFnJE+j6p50g/w+m9KlntAi53aZwLW7N3I9yku3PMBDDQ8RhAFFhqdJLYpxpek9A
 c5sy8/v74FRRJjCb1IevbnpBsAd5QJHZHK63X34ukVyUFrxjOJODqju14E18/lwPTF66
 /EaA==
X-Gm-Message-State: AFq9FYLivy58q6JXPTbLJhgb2mOtss3gDk2BIhSrevONfuitHOZXjo/V
 04D4vbj6PxKGihC1KJ+aFGgUEO+vEkCTlHDEYvOvuz59ATBQWoJoWtKWM08luKl8ikfoNA2Vf7+
 +/ujfLJkp/bdvWeKBSMhXREIs2uNBrwdyxDPtAeP5c0Xwt1EFSavlk56t9v5EcwWg2w==
X-Gm-Gg: AYBFou30fo4AQcwAIaISy6Fb9XM+gRXS4fC/y1nBccmQCoTLvgoiNRWgq7rHRQ33tiY
 4txTllUvRycF7ZXslBL+q5IlPGg5bXxQIrOt6qXJj2UFVfzg6WnpwqYGLtq8i+UerHfjtobG9Ez
 SJo1EORK71y9/ckLMICD0Gxg6XzvkFQ9pWnzclAJXurIkXxHJ+DZh8xDsY3tQyf9OVWIj2Cyt+l
 oOpVAKiKisx4QLSoK67vDkKfXmmlZuXrZu9ryfmLUtFPReod+2mx6OUScLPH7HAUWZ+Jjq0DNE0
 cH0b68EPuaFwIY67ckpviWDjjT1xz8jFjAXFoOIy1aZZBQWc4oWeQeIyrr/bBQa+gOMgQj8IVcY
 iVqN/cVNyGJnpL1BssHdNiWY+Z3/A52+wZqnuQn2m
X-Received: by 2002:a05:620a:4608:b0:93e:fcac:a91f with SMTP id
 af79cd13be357-93f17f9f371mr1515256585a.37.1792364865415; 
 Sun, 18 Oct 2026 16:07:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4608:b0:93e:fcac:a91f with SMTP id
 af79cd13be357-93f17f9f371mr1515252785a.37.1792364864888; 
 Sun, 18 Oct 2026 16:07:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm19230164f8f.29.2026.10.18.16.07.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 16:07:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] docs: Remove stale chapter on RISC-V 'Z' CPU properties
Date: Mon, 19 Oct 2026 01:07:41 +0200
Message-ID: <20261018230741.6560-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA5MiBTYWx0ZWRfX5Ehr/BkObXSy
 xxeXnjPYCfaeoTeHPesGJ1LtEkPo/fkxX/UAuqHkCmxBRAFsr4/45UYI5/AqRTB5DUL9md2kdEt
 z5VThPV7Dp9YeufD7zdw3szmIkXWaJs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA5MiBTYWx0ZWRfXzr9kSZeOyz5S
 3VTGyOBBh6ELXC6cbSUGawPhj2PQA6bjKX6EviUSI2ytZJqpaVrLShZvWdkeGk706kCkLKmqG/7
 2/bfSv9Rs+8FSurf+5/HoLbKz5MhWXVvWyugO2QiYu/4jwqsYuLNgdC3lhYgWnb2ImBAMzRU8x+
 zWr8oPYJnto7G5Q8be4FoTCaPR9Q0k8SpcRn/HEMaCi8er3qilURxX9Q449WVF901kwyTb/ApN2
 DkPvnKDZUEZJd3xNCnZPCPnr0BqDQkebp6aWfjgBxm/AfZouNRSDylxrWGonKvt33mh2PLE6sTS
 OECJ5gz1misy3UEBO2hi7shnTMK4LsN3zNApevnGZeGEpQ0MAyPIwgsCaRtPeFjNX1MJOC1C8ao
 NZf5jRRBOewRnC/Zm3EGoMNyBzdiBVaIPP3QKd9muN7zFO5CS2O1PQAEDURo8dR3lquuva81ewQ
 61Ktu9JXzxdirAvXqaQ==
X-Proofpoint-ORIG-GUID: wpP3ejC4T2m_W8IPPmZ9WdXNiV8OVDON
X-Proofpoint-GUID: wpP3ejC4T2m_W8IPPmZ9WdXNiV8OVDON
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ad55142 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=-qirTN_0YUXb2Kf5Y8sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610180092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RISC-V 'Z' CPU properties were removed in commit 455c0fa9eef,
for the release v10.1.0. Remove the stale comment.

Fixes: 455c0fa9eef ("target/riscv: remove capital 'Z' CPU properties")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/about/deprecated.rst | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ccbc4219497..368fa1b4ed3 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -349,30 +349,6 @@ the addition of volatile memory support, it is now necessary to distinguish
 between persistent and volatile memory backends.  As such, memdev is deprecated
 in favor of persistent-memdev.
 
-
-RISC-V CPU properties which start with capital 'Z' (since 8.2)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-All RISC-V CPU properties which start with capital 'Z' are being deprecated
-starting in 8.2. The reason is that they were wrongly added with capital 'Z'
-in the past. CPU properties were later added with lower-case names, which
-is the format we want to use from now on.
-
-Users which try to use these deprecated properties will receive a warning
-recommending to switch to their stable counterparts:
-
-- "Zifencei" should be replaced with "zifencei"
-- "Zicsr" should be replaced with "zicsr"
-- "Zihintntl" should be replaced with "zihintntl"
-- "Zihintpause" should be replaced with "zihintpause"
-- "Zawrs" should be replaced with "zawrs"
-- "Zfa" should be replaced with "zfa"
-- "Zfh" should be replaced with "zfh"
-- "Zfhmin" should be replaced with "zfhmin"
-- "Zve32f" should be replaced with "zve32f"
-- "Zve64f" should be replaced with "zve64f"
-- "Zve64d" should be replaced with "zve64d"
-
 Block device options
 ''''''''''''''''''''
 
-- 
2.55.0


