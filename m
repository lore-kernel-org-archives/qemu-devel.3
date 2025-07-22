Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF031C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 17:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueHFc-00044s-OW; Tue, 22 Jul 2025 13:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueGw0-0000Lq-4t
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 13:37:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueGvy-0000AW-P4
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 13:37:47 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MGhdg2012558
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 17:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=obCClsJcQMc
 052y7t2akKepUi0DGGNqD8BY6lnSGTo4=; b=cmH3rjw/HL32ef0orVUn42DkGAW
 RGvvmqQ++ZJ4FnoCYNbu39SIoZcXsDDfHwIRaGBv+iYyHMKq0qs+OT83hgwmqV+t
 g+YcDInE9/TwL2G1os53YFswWEatzSejza/2/e+goLl8fPvbAs2zb4Y5uV2OqANi
 xlRjeUfFtPlo8LfWGuvuYlccrI8DNGaBHOfzgsxEFodZ0WQUrAQyezSl0yvFv7/Z
 tbbNsm7N/fDcKA/M3yBjISo7RGG/zXg58FOENtVo6PLjhrWcBSkLTa3C+mVZYbJi
 riKNGUHOe7Z96861yF8vZ6LpoxsaCQca0RK3qt9N/AcuiD4wRaGd7WLxdRQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6mnab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 17:37:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3132c8437ffso9883250a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 10:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205860; x=1753810660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=obCClsJcQMc052y7t2akKepUi0DGGNqD8BY6lnSGTo4=;
 b=dFdTbqGhxAc/mjBRaX6y/nbG6A1T2MenKq7dEwzxp72DqOQAIoLgnP6qNhMjpy7fz2
 6nki2JhqsML7o5P8n9AjBL4pjlU07XBug/IagWhznIpDzbNZj5nX9GfE02jh+Ma/HJif
 kYloqBeqdHTKbfBuxezbVmOSFVwhszrQdrHplYZ+ZMCoyzVQsrXqG4hTYQEewXt/opWk
 VsgIHzHzUZt0IRELpU9biMfpHxMozXtm9vNClTJXb4Ylk61pZBWuCY844+WLvQ7Anbe+
 G7LLCGVrvg388nPABk/vcEe7AL/ITRwnaLjROHn4TqhAxlFlDiXWkS5ZxLQjk87OhfRm
 JSPg==
X-Gm-Message-State: AOJu0Yz5PNzY163JfbzYTiR7o55DXLB7/y8Tgpykn7ffm8vWYkSWp+9N
 GSg6sI1b2n/luIN0Y9ugAAcIo4VtEj8LOlPq6c18Q9cCYznH5E0cO6N7Pnfd+rYFof+cKkheQuz
 OVb2UkP78BRDPhTZ5c6iU/nh3sfZEbeFqo+fjs+5unKqiAkUvyTCZ6DbN9cG9C3aN4WyE
X-Gm-Gg: ASbGncsMm3BGuRaaqVdJd1zi4TtiL1gGyoTsnttRU7CJEBlZnxnMBvU5nC1G+BLtFkk
 oh6Cwxhpb+IS8Cm0j5RCiJ3RqCLLq1A+XB0rsSQTM+oaTQ7/JzY+NKtn0yvJyXAo268F1y2ghvV
 r80AIYgBrRMPAViGRSDjznXab/fbmPsY11Te3TufK0nslbyIv4S0A7KIBIiVrY8NsBio8f2tKXk
 utqVvVxtJ//SCoZ/vjBlJ41CvUUbXLknUxHkVIIAs9q0xw8lq7trdItfOjW/B6scovD4vPlWkCj
 hvMo5j+sOA//eZ/+cMg5azg3GlGpbGxuNOHVSLvhoiCpMEviPRN15jq4rpZZI2pBLXsy8qZGsTr
 AUG+YcK1inwVU39M=
X-Received: by 2002:a17:90b:2885:b0:311:f99e:7f4b with SMTP id
 98e67ed59e1d1-31e507ce490mr148985a91.28.1753205860297; 
 Tue, 22 Jul 2025 10:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYlm3VuL+wL06ZHfokI+fHHJVWcmjTlW2ak3xoOyfjkiYsf5LiO6T2WZWxFTbVtcu2uGFcBA==
X-Received: by 2002:a17:90b:2885:b0:311:f99e:7f4b with SMTP id
 98e67ed59e1d1-31e507ce490mr148957a91.28.1753205859836; 
 Tue, 22 Jul 2025 10:37:39 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31cb5c5da0csm10081180a91.25.2025.07.22.10.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:37:39 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org, vacha.bhavsar@oss.qualcomm.com
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 2/2] target/arm: Fix big-endian handling of SVE gdb remote
 debugging
Date: Tue, 22 Jul 2025 17:37:36 +0000
Message-Id: <20250722173736.2332529-3-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722173736.2332529-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250722173736.2332529-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=687fcc69 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=zyzssM-dKFwhFTZ1wpsA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: s9fErqjdfywSAnFdWIkuRZNlJqQUNbZB
X-Proofpoint-GUID: s9fErqjdfywSAnFdWIkuRZNlJqQUNbZB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE0OSBTYWx0ZWRfX1hH1O32a93JS
 W49TVCA85lp6jj90+ji0BkFmo+7oz8XkLUJ6HrFFpekrqPXgmC93iXoIHWOz8s7YxTR6HzvVuIo
 oaGlUvCCquLmwHUJxW+e/TtuWrQoS8AO4ZLU8/o0mll5yRT2Mz6S0DdrfYCWJvJj7p5BfbFkYrX
 r4a9GPGLbdD8ygYWsXuo0ipU4V1XnxVD44zmHGPHrMhUn+AvXyxjyj1rjRvAQLVM6a+CiXp0gLP
 1L6qfA0s8uQCE4b7G6NbrWV2N4Ta0IYejneueyoJutvbNpkunFpq1JwP4QtPHmMZS5A0Mz/AByk
 aG8XMtVYsTTPCcd2Q1hQ6LmxQolGw61CJ5ce/bVrhichGkq5y93rBtAgzzIIsbBVjFmvwwn2dYU
 lnjAvWXocMXlRJR33Zyh8PU4fwINNkiR0g97t2iFV2hOT9IWJ/HbkLNWb/ILnZB5zlFLv7FQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=718 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds big endian support for SVE GDB
remote debugging. It replaces the use of pointer dereferencing with the use
of ldq_p(). Additionally, it checks the target endianness to ensure the most
significant bits are always in second element.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
---
Changes since v1:
- corrected styling error in if-else block
- correct commit message to no longer refer to patch "series" notion

 target/arm/gdbstub64.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index c9d8012907..f276522af7 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -199,10 +199,17 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
     case 0 ... 31:
     {
         int vq, len = 0;
-        uint64_t *p = (uint64_t *) buf;
         for (vq = 0; vq < cpu->sve_max_vq; vq++) {
-            env->vfp.zregs[reg].d[vq * 2 + 1] = *p++;
-            env->vfp.zregs[reg].d[vq * 2] = *p++;
+            if (target_big_endian()){
+                env->vfp.zregs[reg].d[vq * 2 + 1] = ldq_p(buf);
+                buf += 8;
+                env->vfp.zregs[reg].d[vq * 2] = ldq_p(buf);
+            } else{
+                env->vfp.zregs[reg].d[vq * 2] = ldq_p(buf);
+                buf += 8;
+                env->vfp.zregs[reg].d[vq * 2 + 1] = ldq_p(buf);
+            }
+            buf += 8;
             len += 16;
         }
         return len;
@@ -217,9 +224,9 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
     {
         int preg = reg - 34;
         int vq, len = 0;
-        uint64_t *p = (uint64_t *) buf;
         for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
-            env->vfp.pregs[preg].p[vq / 4] = *p++;
+            env->vfp.pregs[preg].p[vq/4] = ldq_p(buf);
+            buf += 8;
             len += 8;
         }
         return len;
-- 
2.34.1


