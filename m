Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7BBFDEE50
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1ih-00020k-Vv; Thu, 23 Apr 2026 17:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wG1if-00020b-C4
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:36:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wG1iY-0000JI-TH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:36:18 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NFNbLa1204771
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4MDLlAiATNxWdDaOyE1E2F86YfNkBeRBkoK
 OExLyYBc=; b=aMwiyDsJiUxk3Uzic8l/gweAE7QFqO3+75UfLQyi3A7B7hLlQe9
 21nttstStpnqhHl9Em+Drs2zJoCJwELrUCmfkX9AYXr74EwIeuvxbvtWshEEzOUJ
 4wqV7ZAohbNMI96ke650KDFHhbkiEHfr5JUUQfnye6nEuxANDRMZyDLWJz+peOcU
 JfFNLr89VmTTGnStNgZ3kdoRm1/juFk82uQJgjQHriGm4/4EsiSGlVyC+7RS5HKL
 VgqG8RspEY2w7fnKQRYDPKRdb659yRHB8PyxmicF4gnQKVLTmybEDeIJbRxOGc5B
 jmX7VA4tDQYn3oXP5BAtEoPQE2eJmz2xniA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqggnb42a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:36:09 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c8d7d4a79so5170204c88.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776980169; x=1777584969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4MDLlAiATNxWdDaOyE1E2F86YfNkBeRBkoKOExLyYBc=;
 b=jlpvnJPQUqzLlOnwghN7cXhux5kJH7DkDheukVC/gP5Bs83pEsVz8bfb+tk1QOwAPv
 MD7qOhcZMko5anSSp4FKgzOZG/ukCx41wQklXxaWZmEIiPnQQ+6J+erobG3nGTc73L0i
 V7ee69KM1JRtX4KzTbR7u1d90EsqVglxyvTRE5pm7szurqLkse6D+oMJZf4zhwoxYSzk
 oSORthcK26k7ulP+EI/I4sl4iUtRCNkoKvVg80WrFOnVGKzzbzn6Kw2Xq6IhC76Axbm7
 bT5tB2gMhjdNxQKLZ16Oo6sGiPP44B5SiK/FJA0JbvACDv/Kmr+Ey2rRQeXK6T6/5LTV
 L1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776980169; x=1777584969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MDLlAiATNxWdDaOyE1E2F86YfNkBeRBkoKOExLyYBc=;
 b=hwVyQ/Pr92Hg31+33N6dfrqbrT/YsIESSoE+UmpTgbvwALv4PGf4d7KKw/OahDtBhv
 +MwfdvkjGCdZhfhVIEiiGGY88YyDwdqIS/pjaSdZLvTQSUMJ5uD90S60aBn1Nb6f+T6t
 Dv7LagfFmmjnjYBXM+/epC2Dthk7uJDgMR0bnrHuZJLs4muUnNXbS2Dx9iYwCNPJbZlB
 SGNDjdNeQyZLPqJRCn/1XMskhmTtP4Og4/5dDeR0C70nIs1i8YCDVfQzNnOGgZI97ypS
 +4jg9e83SXx6NdJmAzoJ8OGisnc5O17Gf3AOWJ9aNgv44PS8CMxYE6PdG8A0pECkuvuH
 j44Q==
X-Gm-Message-State: AOJu0Yz/bCwhMr5MHqYvpIvQ0bX1isaXdloYRZXr0+D+q8SKfoNfAPy4
 fbsp3zhYxA1D4AD3HExUcZ5/nU1WbKQhlK94ZGKjGMCMx4HqMRNg3t5M1r15upHnI7ShZ7b3oRu
 Aya9XEbTAApTJDxvPfVw1gTCDLGh8/15jlQAfuDthiiEAGWG8aI/N5JNQfRaA31czsw==
X-Gm-Gg: AeBDiet4hf2jci7YbdTMYzbgIBPuCLWmgzNbzYiGdNXKdLWIPowILgtnRUWJO5lrLaZ
 x9zW/FDAB6yAvgx1DwEZ/2wGB5AeeWZzQ2jYyLH7weoFrBlcgHUEe//Elfp/rjSqhNJUzbB+LQz
 CiwaU3fDrGLsg7wtF2DpTh4lLhlaAvUyKTrZWqGnRzlhg4QNm/d9IiECRqrLg8q33sYyOqKU+y8
 S6Xy4fKdeFmOO4JrpXqnwRzxp+1EF1e3dca+lqfcSq1oj2UTkKVRJxXtEqsOIyjmyvav+21zyUB
 jzharQ8Jvc/Ml6C8l1+mDKsWYxQBriFEYeVfyd4xigrCoUREWkbmveF21KNRpF6tFjp/zpactcu
 zhd+u5+zhR/EztZIkbzWL3K1zlSvQGpz1OBXVoJHofrOOn/2m38oaUOGFwR7YK7Vl7hFkkCYQTY
 B3iTAqSDM/H7iKZF8tAwG006wVceE=
X-Received: by 2002:a05:7022:6882:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-12c73f996c9mr15846485c88.17.1776980168729; 
 Thu, 23 Apr 2026 14:36:08 -0700 (PDT)
X-Received: by 2002:a05:7022:6882:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-12c73f996c9mr15846468c88.17.1776980168192; 
 Thu, 23 Apr 2026 14:36:08 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dbaab165bsm10873238c88.6.2026.04.23.14.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 14:36:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] docs/devel/codebase: add link to rev.ng video series
Date: Thu, 23 Apr 2026 14:35:57 -0700
Message-ID: <20260423213557.780112-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Nbia4ZduvssqXD49JvBO5BFHVN2A9u1_
X-Authority-Analysis: v=2.4 cv=YZeNIQRf c=1 sm=1 tr=0 ts=69ea90c9 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=vnREMb7VAAAA:8
 a=EUspDBNiAAAA:8 a=INscn7OYckWatDDT1KsA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDIxMCBTYWx0ZWRfX96vI0umKlue8
 ivWaLpt3lZkr1QA4vLsG04xWhwM8r/EE/ISLoX9JUbkpXOvEg03i19mvRqiIe1NCCk2oJH8V1QX
 WAf2497kUx5oePsf1cPS7pqZztXypDgxmn5FMZLAP9LqMKyKU4bwxNsDsrwkb2mwkjR/Ml7ftSN
 inUt5YWQrY3qSfMHBBmJjz50H0qrh+KVQ7XS2zmTmh8ax8/D8kw18oBnigNuhpDBGyn8ApsfFlH
 5iJEl1co+yLP7OZC5sG/6GEtxo2zLhLOfFynBlSf+PxCJFc4Zx8dsYo2VK8D4RymqQ4ihX0bCrE
 aARetCzlTRjA2oUpYzryuy8d3BsYjb8mp7Jg5JE2Nkx80S3fyZZweH8g8UME6Act/H0uTibcSBK
 DRpZSVHWG6FgbV9IWo9/mBYHOWfC3MhluBGh8U7m5GOknjxJYqEM6StLOXlA0qMrP74RWOSXJN/
 7Z6uafjXdYVuQu+lzGQ==
X-Proofpoint-GUID: Nbia4ZduvssqXD49JvBO5BFHVN2A9u1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230210
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

Those two videos provide an excellent introduction for a new QEMU
developer, and such resources are rare.

Kudos to Anton Johansson <anjo@rev.ng> for creating this.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/codebase.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index f09307b8971..f065d7eee0b 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -8,6 +8,11 @@ organized.
 Beyond giving succinct descriptions, the goal is to offer links to various
 parts of the documentation/codebase.
 
+Those two videos are an excellent introduction to QEMU codebase:
+
+- `QEMU Dev Starter guide - General overview <https://www.youtube.com/watch?v=OCBLTMKLGAk>`_
+- `QEMU Dev Starter guide - System mode <https://www.youtube.com/watch?v=jrZ56K3Sl_k>`_
+
 Subsystems
 ----------
 
-- 
2.47.3


