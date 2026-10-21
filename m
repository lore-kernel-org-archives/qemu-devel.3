Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167EC606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mDm8dg2d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wgj+CuLv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJao9-0004ME-LT; Wed, 21 Oct 2026 14:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao3-0004L7-6A
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao0-00081v-W8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:54 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpA8W1359163
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0vTdM3GG376mGwDjYDYJAgZ6IyqF2rbJbS91j3mgOcE=; b=mDm8dg2dDPlOee/U
 1GS9UUe4fhP6KbRsHK1BlAOO8/BEDVc1UKctnwK6eXYQYoUeoO6fDijxEHYqRHgw
 0h/ehYg9HtgoWdPH9nyE+bj75BZ6CcXIao5ygAK1+MhlkF8rJ9Ts2p11jZe742LV
 Cw5PxboxB2FFaGNkprWMYT1kJIC/o5mdOWN2qkMt1h1HvQh6MkrayvKutXSUkpRM
 q8of3oJSPmvmLU9LpTdvfrWZy3eul025dRZhFTO7jtpv7/HlNEGOUt5dUawGqF4f
 WseM6F5lsCauPYHLDUnUNslbjsPoUGFpZXIsJTQ1asz1PQ0JXdV2ZPM5WTH29IKm
 a/aOvA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj4a7cq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab868fe362so1487801a91.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606370; x=1793211170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0vTdM3GG376mGwDjYDYJAgZ6IyqF2rbJbS91j3mgOcE=;
 b=Wgj+CuLvboSXSwrMjmoVaMH1VRgCCVligykOOVfFK1YZ9TAKIyHwbMjsZXKQwc8QKA
 4GdMvmapVOkduBV7i1sEOPwsF3M2++L1T+/qLKazIv+aj+J/Q1g/Vnoo6SgAKbdqPj8W
 OQIEpajOQIqL7byNga/Tyo2lVsMVBx4vCibls7W0RoKE81uhHGF1L5WUHYtwbHKOIRzU
 /mC9MSm9lpUZbVl/IN8plSjSr113dE53hw7uzC8clUuen2Fx88Zmg4GvidJ5QEajCNGw
 YHoBxuWfuqOqTpnMRynQ+Wr95oG14LTA3wFnfceXZWXsYRCi8Hw01qPFztIpLEodOmS6
 HpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606370; x=1793211170;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0vTdM3GG376mGwDjYDYJAgZ6IyqF2rbJbS91j3mgOcE=;
 b=gtL+Jpumx0AHVi0kiaviYGOcrIoxCgiyOBnRtYqtCM8Y8E2No0YWkbJejlssf7KG/B
 uZRBt7NCbpkl/aEVGMT03KbTK11vCafYSb12nC687PQyoo2m2icnunaxH0lb1g8nFS3z
 P4TK11dBi0MABce8nA82ByDwpY5WXhVDB96yKw2RWwt6W78tAhsQIK+hdAepn5cea+cl
 vuP97t459uGk8z2VAYulUw+7yQsjTlKefkAzMlEEv3BHX8QGpy6QY0IvgEEY3S3Rzib2
 ly/wnMoJAtuxN7AQRo4empmVE09ZWiKO1d7ls3NmfZn7bTefSBPWbiDVg/YQuWh00/Dm
 Ft6A==
X-Gm-Message-State: AFq9FYIls8OyApmqYEoS7uo+FJ5VVIi1QPM6Cv75A0lQc9/kp5e0p+CV
 pKAM/p3L9p85+1fMQ4P8GXqDIc/f4GEr3xSI4Cgu1R+J396RyaZAPq/CpFHpv9ZPjlBuw/Dj8Wf
 HaurxJ+zPZv2DF2QSlKamyLcBXNc2XF1qDSHVJsFfTxBt9lXo3iW5/zHO/iKTz0ytZQ==
X-Gm-Gg: AYBFou3Inv1IqZPtcO2Z/BHFxMR2kMIGQWN3Cvv+ypnSpqzmKC1yI5W9tODXqlpOTN2
 h1toHfG9AGsMJsWNXidAoM+b1WGfVJ7yoE67MPrMXm8XiWJRDWDlm5eOWY3yhm9Tw2VMNBCYpKx
 CN37KF8kXmC0DBMXSJ7Cl96W+q7pv0tuP89KZzzcC0teL+qhSJaLaMNo9P2iiKDuG+DudoHsyu6
 k6GdGJcJOevzSfzkmnBEN9Z7oQKa7ePkhL1x2pHPeMJQQZfQr/ZjYnXmVVeTb2S0ZJNhCWiMdPq
 jh5MrhjQDKe4ODj9SZaiXJFqLwMJvRDr3jVuy2Jh/zUz09MTVTPUzXd0ONXBYNu095HF1jZEwT3
 hsjnxpZIOur6REqZ6riT4nyKGbdUzEmbfzOjPM+vRWyDmIhVi2Oi6h9UPooG1+Qs=
X-Received: by 2002:a17:90b:254c:b0:3ac:9176:e83d with SMTP id
 98e67ed59e1d1-3ad86e96d6cmr2024329a91.21.1792606370340; 
 Wed, 21 Oct 2026 11:12:50 -0700 (PDT)
X-Received: by 2002:a17:90b:254c:b0:3ac:9176:e83d with SMTP id
 98e67ed59e1d1-3ad86e96d6cmr2024311a91.21.1792606369854; 
 Wed, 21 Oct 2026 11:12:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 01/21] target-info: add target_heterogeneous
Date: Wed, 21 Oct 2026 11:12:24 -0700
Message-ID: <20261021181244.867840-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DD60nxwmM4sFij5bPx4tuIY43Njs787M
X-Proofpoint-GUID: DD60nxwmM4sFij5bPx4tuIY43Njs787M
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad900a2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=3q1FPIo8JGfx5WVhvewA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX+EZ58AvwTlvN
 wVRRK+pynroPBXRG/BwriLva7zxodQwz+/G02SJ++c2GJnbL0TUKPLvtiSmeZHhuvHrwqkLUgYF
 V8JQJnmCoASoIIgwtqiPvDNvta/qzHcnqVSr5C6Xw6Lgb6WoAv1p8aweJDyEJclIMSEtZGcD9bN
 OMtpfBJPZaWtIYX7kuKsdjFQwi939jk2TYIOGYnT6EXThiqEiG6RmmGBMZ4PmGeK60kV81lSOOS
 YBbipbMFvtLlzJ1uDUFezWZB51X1ekA7PJEEhjPdmoY4+8/EOLiJGF3c4ZOUncy2YBVvVbKZY4F
 5kEn/+1wKc14Z+A/b2SLfrLbHKsdpWxoG4JN10YEMqMfuVZXJXOkESGFHo5JI2qhacLmSZcxecE
 Blm2zpmswX86IajJfBDkjSe6OOJ4sC2U3hh8jNqpDdcuU5li/LgfNE+MyIvPoWN43rGfWqaZ5CA
 FzM7YnsoXMfXJrmbZbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX58EZbZL2XSuC
 TXB153M6+nwoxv2NEWwCRG+02lhmfREs8Ub+tHzyezPmyaMwfelstX9WUSU4NT9cbIu1Y0KcM/z
 c5lvUDbMGM0hGrw7Aru1rPLii5wOCb4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For now, this function strictly returns false. We'll turn it to true
once heterogeneous emulation in supported. Meanwhile, we can use this to
add various checks and asserts over the codebase as reminders about what
we'll need to modify.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 8 ++++++++
 target-info.c              | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 862097c6c63..923c00c917c 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -42,6 +42,14 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_heterogeneous:
+ *
+ * Returns true if current binary has support for running several target
+ * architectures at once (heterogeneous emulation).
+ */
+bool target_heterogeneous(void);
+
 /**
  * target_base_arm:
  *
diff --git a/target-info.c b/target-info.c
index 254530d8ea5..b8a4a7ebf7a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -42,6 +42,12 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_heterogeneous(void)
+{
+    /* For now, we only run a single target at a time */
+    return false;
+}
+
 bool target_base_arm(void)
 {
     switch (target_arch()) {
-- 
2.47.3


