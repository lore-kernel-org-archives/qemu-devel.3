Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F4606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CoQA11TJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QkHbCPxu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoC-0004Ni-Of; Wed, 21 Oct 2026 14:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao5-0004Lo-Sj
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao3-00082D-I8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpSTq996557
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BHCQXaYrP4rutLahhJMCE3dN2TG6l/19YLFPj96v7Mw=; b=CoQA11TJKkQSVXmG
 KsSizqQBzcS286kxd2SbewWgvh+FAQZ9fjv6vbol5Bcs6wziNu6BJl3PL5WvbOH9
 8i6iM6aeqhtmvvz3MGhE7LfOp2xnxPf696sqfLsM29k8y1xmq002cKQWZ7udgZda
 cYUtoYjdzNDFl+kkqAjkCmK1sqQRhzeEDYT4nlkXrMIOUIre+Z1fMtBXswXAwgsl
 XQegzN/esvoCAff7Kx2t4xxtX2QJS5tZKeohy7hDOqjv0K8ZE9hniK4Xzl4CqVPD
 ea4KwKKnSRKwriMD+68+riYa7aOiQlEq6R/SYppbOvexP4qkV34SV59vuQqz3TqU
 M1hYjg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vs9th-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc4216aee8fso948064a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606373; x=1793211173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BHCQXaYrP4rutLahhJMCE3dN2TG6l/19YLFPj96v7Mw=;
 b=QkHbCPxuGCUT3mT3LT6j7KKeMw8cdMsueqyiBK7y2VG+KNnDnFqh2NHetkCKe+sugl
 XEsxXTZZC1cHGBvVBHuetFoNpX4p/wgtFUAt5Od34WfQ6cNtK7MBBLbDB1cqr1gJ6d9t
 7r6U8aKP8YrLUr1nD0yqTyy6RXOLrOIlR8kL7M2WD/ExUrT2qh4jzAkPp+UhQbGqcsBM
 5LpSJBRoo1H0SOnJXeOLmkJnMDKqC31qzXgNfEIKTUVFBaMl3HBGcjzDdnjHS6ztRvZF
 6gaxRAun6uXmOmXHUoMWCTBbJGvaHQYxtvV4eseEfGfRu6d2sSk4CgRTZQPzTE/FFVsY
 filg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606373; x=1793211173;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BHCQXaYrP4rutLahhJMCE3dN2TG6l/19YLFPj96v7Mw=;
 b=Op1R9XrCM0pXr9g5edRPB1o5lR9WgkRkypTAsIkXUlzkfHnVsxFeIeZQBhqymECATg
 LvBsfkVyet8gzp4caZpiePG0N8cwHnsLNOK6PnsdMQR5L1xHKNSsJxFI9z3TO72Z/9pa
 3vZsUyz1u30xiety8GxrCcoFmSi+/wlQDd77m7Uq/Zq4mwzLg3p6C4MmTh+SziMrlM6U
 S42PzAdvx4Ey/fgc6cNMCZjJD8QJXVhmUxu6LXqgSV/YgHublNhZ15vhh1lA374M6xhu
 cs5sf7PF20yBSlJvmG+Rr1uGeNpxOXfGFt/c/l1dvAPidIRT9EfHUSyYwALU21G6Hk1n
 Tnuw==
X-Gm-Message-State: AFq9FYI2AHfMNocApuPWNy6ngC/JCFTmmajhynyGVL1ZEB7nAycRWOhp
 oyldi6/iURKrUbD2BG1zg9qwf6LvyrDA39c8XXcw8p1pieQkDNsPj5vdfG/GTrN7BUjpXqXdGLg
 /ycIw5y8GoIRQtODcSQX4srUfGEwKzs/uLXRIv15iwXVXWHqA2GLSrziUkBTo9BwwRw==
X-Gm-Gg: AYBFou0sTB28byoaGkeB9lRz2NHnI3EC9g348PmisWPScrhzFkbWmhudZIb0n4KPoVx
 WZzYh9R28H+kJa9Mm5cM1kRDzjNGp5P+GOPekKYbgzzJxyhT4nl3/g+Pr4LCbuHDqBUAdYUXaig
 JYXRYH+Vxg2QFK/G1dqNtl1nraYcmj/z563ub8p2ESlQUspB4/n+5Akh2NZV1nSbAPQ0TKDCvaq
 692I3PwOwacpfrNBmvKLizORdqDSAWpftPpsC2fj+dRxPh+Bhp4qqs8G2YzhHWPthwIizIduEeq
 kamNqEWzsMTArFa5OYFpzXYD1G8w61UrTAwNt2JpnuUakhYVtpeSh2tkBhvCMvQoJiQSrolDMWc
 Ofc60e2K+C5K8/mwr2NDKSlFRdvCVfVvLzlYAsIf+oCXY/7AEfzv8EC+71cYQq1U=
X-Received: by 2002:a17:90b:258e:b0:3ac:9a03:20bf with SMTP id
 98e67ed59e1d1-3ad86f711b1mr2404821a91.55.1792606372734; 
 Wed, 21 Oct 2026 11:12:52 -0700 (PDT)
X-Received: by 2002:a17:90b:258e:b0:3ac:9a03:20bf with SMTP id
 98e67ed59e1d1-3ad86f711b1mr2404802a91.55.1792606372241; 
 Wed, 21 Oct 2026 11:12:52 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 04/21] include/qemu/typedefs: add GuestPhysBlockList
Date: Wed, 21 Oct 2026 11:12:27 -0700
Message-ID: <20261021181244.867840-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MeRfKehZNOh4gqlp0xRnQxMjAaI0n1ED
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfXwFGkIZRciXNo
 XGFlZzwS1v004hYVw2BsunrHdicLH8NlUf6sWPTN39tBRbC+emXyO/ZurseIclWAXpobM3Sm7zd
 eB+5uL7gEmV+0JtKURKiryG/zb7VNWw=
X-Proofpoint-GUID: MeRfKehZNOh4gqlp0xRnQxMjAaI0n1ED
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad900a5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=De2SjmbKK7625g2b_egA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX4OOBp4pcUgLm
 q2mBw5/WHutm13439j6kyXZj6pboCBGPX1Gmd9hBj2Fz522CE1VecjHxo5JlqKXmIPrkw4efRSd
 zjDetOZo09fcXhbJw2zWBbShae0Uus74mm2Hm2iUrTFupRK/kZ51jgENX5kjrJ8jvh81uljkfle
 SPgTl2vGpQFzBi/c8HJiedx5i7D9u/cr2iFTSCZ46Nmbnsg+6Hle3dSsvfCAHHl/J9afrcH/V+e
 iJWWzW52+kpeI3pLCYLaSO8yYQisY9Hb9hTpuQNvVadghhxjmfFXwUjJ/7VziBfy50QHw+NgU30
 8FW1cfd2B1sIPEzvohEP8szty07xmDPEBX+UTPleNrefbvteSdP5GMUKYvNjfdJOGPG98Dy/NSK
 uAyAE0gvQcxhAu+c8+AF6/UqKYEk8fii7IVhRhNcnlAYkFw2BSqPSz6w0o77NMYaLru+JLkNDd8
 La11Kio2eSRMPC7T9pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
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

This allows to use a forward declaration instead of including
system/memory_mapping.h.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/typedefs.h         | 1 +
 include/system/memory_mapping.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 8fa7f752dac..488d2556670 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -53,6 +53,7 @@ typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
 typedef struct FlatView FlatView;
 typedef struct FWCfgState FWCfgState;
+typedef struct GuestPhysBlockList GuestPhysBlockList;
 typedef struct HostMemoryBackend HostMemoryBackend;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
diff --git a/include/system/memory_mapping.h b/include/system/memory_mapping.h
index 4c770bf0b83..3bdf9badb5c 100644
--- a/include/system/memory_mapping.h
+++ b/include/system/memory_mapping.h
@@ -36,10 +36,10 @@ typedef struct GuestPhysBlock {
 } GuestPhysBlock;
 
 /* point-in-time snapshot of guest-visible physical mappings */
-typedef struct GuestPhysBlockList {
+struct GuestPhysBlockList {
     unsigned num;
     QTAILQ_HEAD(, GuestPhysBlock) head;
-} GuestPhysBlockList;
+};
 
 /* The physical and virtual address in the memory mapping are contiguous. */
 typedef struct MemoryMapping {
-- 
2.47.3


