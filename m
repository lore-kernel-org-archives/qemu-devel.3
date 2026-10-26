Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4021E606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GKJFprp2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PERJ+T1e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOsK-0002F9-Pt; Mon, 26 Oct 2026 13:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLOrz-00024o-Mg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:52:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLOry-0002vQ-64
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:52:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEw6743584367
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 17:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2Px0aPx8t7UM+uij9z7bW4
 Tuh8rXa2BAdWWDddT8704=; b=GKJFprp2PZ5uaDX1s1jXyHgcNbLeqmg7Y3rnrZ
 SBMJ/r3LDJeru51HdRexYjope1t0LFDus3eLGFjku8D4apKOGKZYMBsf6f5h12mp
 b+hRWjjUp8/AIqSOYIDqNOaCQbSkcErjpGXLH8WJWmhmTonwwVAn1lHos03x761e
 sUKxfZQU15SnovcKDR7ORjbvczxfrSh4n2Ei1QAPf9IEVtXyhjhYw7aWucjvTGzS
 zop26Uf6ucFUq6cHWs5uTjUkHWEo2jT1B6J/f2vKaRLwI2tm8TAytNvr8cgpQseO
 UZNlYZGb/e+DlMOfz1wHbOu2S/ktuYyrOTEER5WF8Ok7+YLQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvddbef2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 17:52:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c66913ad0so18461826d6.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793037143; x=1793641943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2Px0aPx8t7UM+uij9z7bW4Tuh8rXa2BAdWWDddT8704=;
 b=PERJ+T1eVPUC0y0QRSV0IP1KdFJHfWFVKKynmzer935syqMxKvARUsQBE8IszPmk8x
 4zobWKycT/Gg4x4X/oYSKrZ1uTyNw+G8Y0ABscCnUQBRj87TXI6pcw+U3k+IF/ZjKKvL
 riQrfaKzCd9L5EfPqpNTZURbusv8WGey0lO03hegT49xfA24W/N9rRxHzOVzA39tK68i
 JymO9RTgVWAytac7mIUxqx0my/dK5IH0m6hxzRBGucIiPqYgqRcVWVDvP5Wdwh5mSzCw
 p517I9/pHmjTch9Xx4uhP2vN2/JlPgm4fHgxxa1wylNwP4y+cBPNM6G9dRzXY7hF6ScA
 P5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793037143; x=1793641943;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2Px0aPx8t7UM+uij9z7bW4Tuh8rXa2BAdWWDddT8704=;
 b=YEtWz+kiD4pBJk61OJEBwIETHqm6FJr5C7axMvJ4NvaV06rCD8b1RlfcAUmEATkv6z
 Cl4AN5Tf6VAzrhBQSXtBF41yDqwUs/Cv3CdW4Xdf8FI9qoGfl12/+6KicObq6etFICAI
 QWJC83X7Vsk69Y+iamqqMLZRrTnr+Ge20is+muuaWI6LkSl4iJlnTJ+dCMDDfa2MzTxy
 JEfiw2CEG801jVIYRK7DbCXMR9Y0CD0ESI4iHwJG5dERCPad/2U938eaX047pe5/MTPf
 9dHQEJzRqlDzYIIgofEhL/4xp9T2ciwuy/L6UF2yhYirxm/2Q8cEAHsBpRicKz+RPVph
 gRyg==
X-Gm-Message-State: AFq9FYIKy7C0hcxKUsxM6NgHsVM674QzjWRP3xSAW6ooHs7q5xQJOLJb
 ftoar5C+LDIn7ABYHZkIULFzjDJYnV423RgiiVwOe16qiAHo8eHRUP0SF+XSOeQASHKWsQRUv/k
 UVrT4Zi0C/KYghJ/aaNfDirHZSDWfvVJJyX9/WLl4ZF61ikOwMN/PWa3yzCQcuhi1QA==
X-Gm-Gg: AYBFou3Qmx0jMkk/t17al8xojJnwMxKDt5wd3LXaz6cMp+xqKAMJttrQTAKVy1QqLRd
 MfyZZHir1Ce5pTLLaqML1ZI39QSsNGOuN1KAqkm6cOxwL/gZfaroI94nIDi2ulbxPqHEbCXErmN
 9ueOiO3ccLS7nDZYhp9yBkOGjO0OV4tj6vM9kIKFTrzBIeO0qex5y7BeZwYuzZUIVc7tENe4D3f
 bcFvmCyUtQBnn/JlQ15W9mVnoRhMCYmnFGADBZsE1AxnMrtT5JCphpQnG15AWQZpGvXJbjq4qGg
 EFVVLrfM+m7poo7L+V/EiAtrhBdEV2rqIPjaSkkuhNh7icIOqudvC9w0jDLlMnwxoZQWGe5juj7
 P9AlOB6rBwPV0iby/r5S+fELJJsPPA9NS/qqX2lpq
X-Received: by 2002:a05:620a:1b98:b0:93f:18ba:bf78 with SMTP id
 af79cd13be357-940ef94aa26mr1123183385a.69.1793037143390; 
 Mon, 26 Oct 2026 10:52:23 -0700 (PDT)
X-Received: by 2002:a05:620a:1b98:b0:93f:18ba:bf78 with SMTP id
 af79cd13be357-940ef94aa26mr1123178485a.69.1793037142866; 
 Mon, 26 Oct 2026 10:52:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd354asm16866466f8f.43.2026.10.26.10.52.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 10:52:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Samyuktha K <samyu@qti.qualcomm.com>,
 Sritam Paltasingh <spaltasi@qti.qualcomm.com>
Subject: [PATCH] target/arm: Initialize SMCR_EL1.EZT0 for linux-user
Date: Mon, 26 Oct 2026 18:52:20 +0100
Message-ID: <20261026175220.85545-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kcr3XnIEvm-fwenBrewBwuCDqOJSbprj
X-Proofpoint-GUID: kcr3XnIEvm-fwenBrewBwuCDqOJSbprj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA3MSBTYWx0ZWRfX8pwGP+qxHuUl
 yOdpMfxKER/WcJxr1kZi+rq4iZz+EXZJX14RkgpH73dNbkAVhxujGJz0IiUg/nucvVzJLaBpe6j
 Q4FFbPtTeNRwOelUhormwVwkTC49bOBw5zv9YX7qwb3lhE+QPStiETwjjIS4+8pCYFhO+34N/fj
 ARUXJRyaOMd+OISTlyZ8GkA+gvNyRUkNzC/ft3ivErFrMSyfkvVcYltIIS9Wvr5qiXnpZUhdH26
 bqby8qZ/zjNdPLQLls9oqycGvVRV5WegL41OiGE5LlMPh78KjKQKW2/RfDHG1YhPPRUwDDTue13
 sVb202nN60ndT0PU30I9u3cnTFndC0Z3ZpN8OJneI1Nx1KCqnnJ5b+tBJEzQElSOe91b0/3vH1+
 EGWMepW00BflZ25OCk/iqGeEzAcVbApzlT31UHoiB61EVsneZMAiSeDHRV5f0YZtxlirfG6fFuc
 xilbO1rFCWtvazVP9Ow==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf9358 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XLJSLKbTjuxEe3lMcToA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA3MSBTYWx0ZWRfX+aPdbSVk5OaF
 HLuvPoARuG4wmAMv4RxPa5MfR181QvQwv5NXtRzLyKSbIr1X5a8QPNo0QIxOxCvXG+EptgbVhAD
 TakpgXj5sJlwInqwiJO2ojgQc5+Jzsk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On SME2 systems, Linux sets SMCR_EL1.EZT0 in cpu_enable_sme2()
to allow user space to access ZT0.

linux-user already initializes SMCR_EL1.LEN and FA64 to match the
kernel's setup, but leaves EZT0 clear (see commit 3aad4bc8beb9
"target/arm: Add zt0_excp_el to DisasContext"). Set EZT0 when SME2
is present to keep the emulated EL1 state consistent with Linux.

This has no functional effect because CONFIG_USER_ONLY omits the
ZT0 trap checks.

Reported-by: Samyuktha K <samyu@qti.qualcomm.com>
Suggested-by: Sritam Paltasingh <spaltasi@qti.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 62262d742a27..851c9a81f3cb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -387,6 +387,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
                 env->vfp.smcr_el[1] = FIELD_DP64(env->vfp.smcr_el[1],
                                                  SMCR, FA64, 1);
             }
+            if (cpu_isar_feature(aa64_sme2, cpu)) {
+                env->vfp.smcr_el[1] = FIELD_DP64(env->vfp.smcr_el[1],
+                                                 SMCR, EZT0, 1);
+            }
         }
         /*
          * Enable 48-bit address space (TODO: take reserved_va into account).
-- 
2.55.0


