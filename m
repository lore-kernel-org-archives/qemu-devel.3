Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B8CCCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrGh-0002rt-T9; Fri, 16 Oct 2026 19:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGe-0002r9-FP
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGc-0001RH-B6
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:16 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNFewQ2616479
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=T9M2C/1meVb
 asPyXXTiSZM/+vjdIFKnlwYc9cAFmSw4=; b=lkWUkc8WjZBO5wK43fBGVp4gdLJ
 KYvdYO+6xqLtBrQEBrVwgTkI1XMRz+4X1rVloJ0ZI5zWcYdc8LoSHYUuMnxEvRbn
 Q3ce+QrvF6WSftn5+je7dlA0Z31kD9Mb9bh2QZf6QCiMC3WTFcaATZZ0F12tOyFF
 m/fzriRwMP2aVlxOfy1jaxdEcUX3CPgM6hKuF2UHbpL4dC4KVLAMZxQqV7+ZemCC
 F8G8Fdls91AkecYqvMmb7P71+v3j3QjPi0hqCTWfGwmteRAC2D6Qbyvw7f3U6iDU
 7SKyGBa49VJ0LM/aXOhDZ9UAOZ1uJO8KIjIDw4oqjfmt6R+5lZRRH2+YeAA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur2qnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3aaf955db5fso571199a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792192992; x=1792797792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T9M2C/1meVbasPyXXTiSZM/+vjdIFKnlwYc9cAFmSw4=;
 b=jxRJ7rQfE1n9tIsZTXu2o1bK8iHAmahLxaw6aLqmqLtjcM8LsnzIxzB7HsmUaZ5yux
 7CEV74ubD8PfL9dFuJbObuXxhX0cvtlpw4mTi9h+LwsAv00FuzotzfZqJ+WyUVW5rq5C
 7jrDBKRVqKt1Mn4xgMx3a1JPsu0ZNpr0n9sCbfJvOX9/Pve+GYUH9JQPt5quP3/DrZo7
 c8vlf4cIhJ4F4zzOp5in72pKbEjZBQc57KVZZ50WrfXTOoYnYpth5S8AN0msXW0bFR0i
 nM43jiKa/PMX1VH+ggv3z0vPtrhd70ozYMxCxANFC+r59uiLGnO4ltLhv9USe7Sot9/A
 X71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792192992; x=1792797792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T9M2C/1meVbasPyXXTiSZM/+vjdIFKnlwYc9cAFmSw4=;
 b=xX2v4v3wlJ6SoFYyY64Tj1QInBAZBLhO/g+44pIVlhiaJVa+3KGq/O3EKocejPN71Y
 71euzdW6x5KDDUvaggDmnaVyB1AI1CV45YF4PjOkApBsFO++EnOghqiHuS2X3KbBIpqU
 z3lDk3/cNCWuXg2zPl17ybpBukGP45KtbN3z2uwnt14cae0KM9LjZ00rok8tZ98c9ck/
 qCsrUey5KkxynrxfPhNs8yr/kNX1j7g4wtan8vf7fGXfLGg2LvuvoLPd0bfSv32x3xoj
 TIGQLuBZ3u0ZiSvhtLggOK/mGSjHFPCxez82/mDgFwHLMGNY/vOx2z9yqlie5GxaWTtI
 Lnjg==
X-Gm-Message-State: AFq9FYKPK29QVf5Sff4eim8Nb+joCcrWOVCYSL47ZiH7hX0WSbsTcJX4
 58PNYUWPEDeNM/fkFVybp1GC5rk0mFNAjeOVfYRXio9xZfhj5hzdlXPpl9LGU4hSbu+xwt7Dsou
 J1VJiijeH8vtJCBTO0oDaf5da1GNp7H0rdOQgICtOFkXOfj4C1y/PIwi+k3BSG8o0iA==
X-Gm-Gg: AYBFou1Ud/pNcCE3YrDOtFuJX2pCSx8P9lHrKfhgGdBtuNTjUN1j6akrR7aG6TQzXuj
 mRvC0ZSZfAQXwoTLMaqn5BzJHMXZwFrPhIP3UNV17Ufq18cu9Ev0b4eugqu1pyOSq1Xfx8Q+AQm
 vgOMbKEVY9P+N/o8cNHGLCW/HRo9HXTF09+eC1ihmNKtj9yUwjvAr0DNLrwydYUT588+g8YNhCk
 aGEhW1wjE2hECV3hRrHZzmtbfhtvHJPckkHK+rkubvOjO1DOWj3Odg0GJ6JfpPxwnukNGSa1//6
 49SZM4QT6KsaeaFWcSAbNHpOjCrcBeOxc/N8yuCFxR7B20/oj7sYdiTJf6cPWKQ6YnkG6wxX6G4
 198p00kk2ZLFt4NM/zj76wKDAPcDh26N7Owpq4ieTtdGLvin2k/Akux7HpwSlK0c=
X-Received: by 2002:a17:90b:1b0f:b0:3ac:8446:c1b5 with SMTP id
 98e67ed59e1d1-3aceebfacb7mr1181181a91.31.1792192991714; 
 Fri, 16 Oct 2026 16:23:11 -0700 (PDT)
X-Received: by 2002:a17:90b:1b0f:b0:3ac:8446:c1b5 with SMTP id
 98e67ed59e1d1-3aceebfacb7mr1181159a91.31.1792192991199; 
 Fri, 16 Oct 2026 16:23:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm2829304a91.4.2026.10.16.16.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:23:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 1/9] target-info: add target_base_riscv
Date: Fri, 16 Oct 2026 16:22:56 -0700
Message-ID: <20261016232304.1215119-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX/nAusS9yZMJp
 uuDId5ZtXKHM+4YBqJcbIKs+zyjTKNsXuVjoyw70467WeSibLSdMdbciY++SvnWbMYf2n5toHI7
 lyye4YMcA8SFOmniC5JWSugseD2hz71/GX+BvzO1uNtHUoCx8b1Z+XEeGmSsVpWdDZo2Q72hcq4
 b4IK+Tn/Zppb94g1+Y2jB4z5GOMLkLYNG4DK8IPJ+SI58G1OHnW76RRXwSibpp9cY0wxRQ/evKy
 u0mwm/HHEfI0AeXW6sD17ZsyML8oqm18kdUqd17L0EGl+q4LdxvDrzcM2HWro8PYnZvLaWZWKgX
 1EIF2qpiSt9+43rbgyu5xn6AAl7QiWTBxHmzrQTR7H6SBox1GuN9LQ7zCsnsUlOjVfsWFfrgZe5
 BmoI4HcQa1NOg2iA9HSVJwqZ3nRcIRFVg7N0Z8csOiiFd6NXn40cGNjfa83ixBx5G6G5fCX3sAj
 EtV1481eCtT1x9cvyyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX31L0tFo9EAjh
 c3FnbZYrUvG5tu8W0zMnc0zqqaiRgZOt8SZt+gRF3GYI+qSIB6upj+H2Jtr6gvbe3aSJwucwJ8c
 UvIbhvVLoSwOHswu2cpV6ZeppnNfC9k=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad2b1e0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=erv6mG0yiTVJuKtm71YA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: j5iEnbIJJ-c4vxGj2hfC7Z4vADzlr3Kh
X-Proofpoint-GUID: j5iEnbIJJ-c4vxGj2hfC7Z4vADzlr3Kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160093
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h |  7 +++++++
 target-info.c              | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 862097c6c63..b0f3b4cfb8b 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -112,6 +112,13 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_base_riscv:
+ *
+ * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
+ */
+bool target_base_riscv(void);
+
 /**
  * target_riscv64:
  *
diff --git a/target-info.c b/target-info.c
index 254530d8ea5..e827026bd23 100644
--- a/target-info.c
+++ b/target-info.c
@@ -104,6 +104,17 @@ bool target_s390x(void)
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
 
+bool target_base_riscv(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool target_riscv64(void)
 {
     return target_arch() == SYS_EMU_TARGET_RISCV64;
-- 
2.47.3


