Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE345C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxw7-00025v-Lj; Mon, 21 Jul 2025 17:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1udxvV-0001YY-Kp
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:20:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1udxvT-0002m0-HR
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:20:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIg4Ew008298
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+fQw6GvlrZy
 4nyXBmMwVnrWr+x1hCVBNBgVHmbNeyzc=; b=ES3xH7RCX588vil8hmJknmeIgNo
 uuGxW0qMbveO5si0TsCL30bK3Qg11bxAuKf+Brq6B4iR3c5gnymqkTn7Nl56dDy8
 s4/055VfwfGwMRy178rF4LUsDbWYfTbGt+M0Fx5Dor5W6Yfq5LIZe1d5tLGL1DMF
 flbiPa6H5kXKouIzD+IToH57NOAXsWIT08Q3AvN6Q5c5ooULNBd0dOfneYSgyqsa
 +nub5mTlZ9MgLILOh6Ye1Zj4WV0xAP3mMrWF1PetTGd322PNWe812Ez1kErYYxPy
 2iORJzqM43txNPUlujJ/DJ98moKnZAMeDoBq64eaWjsAZO8AMvA9aM1s3Gw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vwhwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:19:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b3f321dc6abso2298852a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 14:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753132797; x=1753737597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fQw6GvlrZy4nyXBmMwVnrWr+x1hCVBNBgVHmbNeyzc=;
 b=s/HxzaRK97GVkhDDimz/HIZQw+vQOry5r/N9DGox1FhVVRxIfTxkFzftGIkOZOm3M8
 jDcbl58Ae2TzfdhNpuljMEO0npcox0ikHG+2ly6GpUeCJ/arj1HNDRQ1g+FwzXk1iwP6
 nQnbwhT4sj6pcG6/vwfxnF3H91ZD8a8vF5Z4TOuWAxsyV2F9BZMiCQ55btTpOA3yeKgG
 Eq1sVzCx4cFS2jEyNbpxyXSHgwv6rr27Z510ZrYXyJjzW2drB/8xHSISV3YhuANmMZfX
 xaDxKp/VCXoYDvZskFAOdQVcr6xF9aJAkpgiWSlxH/ecJrvcieOTKmBnytKxqbvkGgfM
 BwXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ieoszM2T1Qn3IItK5ighY13piBuXU33Rmr5IpqDuYH26NORQh0s7yzApoGdRaquwflo7ey6wJ30v@nongnu.org
X-Gm-Message-State: AOJu0Ywuss6Q99UH3PfHEOnM8jYozv7s99+lYr2hFWCIZuPZjlR9sgOS
 aixxYEhCe8ypom1EbH4laHip0T2u1oZdWoNMQEH5pQC1ac2qftxD9vW8l0dLUvgxqIvwVRVgxeK
 0u0A9tA2iv/aqAXNcLY6iEq7T77ji81u9hfW/2kRlbR1DhZOEP3UwnbnQjy8yXFFfqJL2
X-Gm-Gg: ASbGnctSL4KMNmtIt8KccUoE+BZyh7XOGsg4p7QX0v9Vi8W7JtLhir0A3ZB81wzRNwd
 u9MBAasiW5xWN3R3x0oyOoGwng3/kx67yLRSkXsCFlyoKo89Pbl2o9muDkKYelrxucjRZD5VWF2
 Uipe04WFCHdseBfjSycvhKcW5+htcOtZxNt0rIEa5lKgJJraa9wu2oZ/k8KgZH/hlxNiRN/Ft7t
 ytiNNxvTfWywdoQ+/QtQFF/mC6ulwF28VjuqfPCG6T3LvhIghqk+cwUNScPd/lc3lxzLL0se+s6
 iOv4rK2GcD2dK1pIJKm/8QSFBYnbsMpaZ1SlyvIBABzIvxi2fXTdoL4Ui2PKsrI33EsF0DP4G1l
 MXB2fStqHYz59tKs=
X-Received: by 2002:a05:6a21:e92:b0:232:813b:8331 with SMTP id
 adf61e73a8af0-23811d5b784mr34505162637.2.1753132796941; 
 Mon, 21 Jul 2025 14:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzy+rG4z+MCFgRHdWfF1gmyGS6BGNFnENxteF83+4NQHOg38jvkmlKAngkw9fAVCN2IEbEyw==
X-Received: by 2002:a05:6a21:e92:b0:232:813b:8331 with SMTP id
 adf61e73a8af0-23811d5b784mr34505132637.2.1753132796541; 
 Mon, 21 Jul 2025 14:19:56 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cbc680absm6338808b3a.144.2025.07.21.14.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 14:19:56 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: vacha.bhavsar@oss.qualcomm.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 2/2] target/arm: Fix big-endian handling of SVE gdb remote
 debugging
Date: Mon, 21 Jul 2025 21:19:52 +0000
Message-Id: <20250721211952.2239714-3-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721211952.2239714-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250721211952.2239714-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687eaefe cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=u4diUC1y2Yxsy3ku_HcA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: S85P7k4FNP5BV2tqwcXyHeXVlY5ISqh1
X-Proofpoint-ORIG-GUID: S85P7k4FNP5BV2tqwcXyHeXVlY5ISqh1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MCBTYWx0ZWRfXwPIU9F3LcncP
 zlupvRvRRM8g7YbzdafkeINWXx/3OZssgayPgz7yCAuQJqVBsaJMe6k0XigA+z61iZwjLdNoZiZ
 uMA6CoPcTycTgkwLrFjXH6ZKUEL/4e2fKV3UvFXZrFjrwIBQ1TG6Ke/d+jTFdisd+Rm8cOS7eQc
 v7f/nu/qxdbmanmIBv4AgNfwHnop0sKjZfxMDZsaNlqBvaDP3Z0as0uMDEZaMAxSu5qcUIXRKPi
 BpPwWVkuMDcoTTZaX8cIEapt8gEWc1X4quApBZ9/dRgYPsay+PzEDERkREfquXVOkEJzwkyMubC
 dZWK01gRi7A8sLqpRTOe1FprOoLbp9WsIgL7qF6gyss+Ia6nKnp8pyBxXM9BRUmppg4yA6WCa7f
 WjTV+KL0grcBCi8Ad/po9sjMSgOswS+qFIsJIs++YWnUhLwFzib941y3DaYDAAHF5QUFxcDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=553 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210190
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds big endian support for SVE GDB remote
debugging. It replaces the use of pointer dereferencing with the use of
ldq_p() as explained in the first part of this patch series. Additionally,
the order in which the buffer content is loaded into the CPU struct is
switched depending on target endianness to ensure the most significant bits
are always in second element.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
---
 target/arm/gdbstub64.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 8b7f15b920..cd61d946bb 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -200,10 +200,18 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
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
+            }
+            else{
+                env->vfp.zregs[reg].d[vq * 2] = ldq_p(buf);
+                buf += 8;
+                env->vfp.zregs[reg].d[vq * 2 + 1] = ldq_p(buf);
+            }
+            buf += 8;
             len += 16;
         }
         return len;
@@ -218,9 +226,9 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
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


