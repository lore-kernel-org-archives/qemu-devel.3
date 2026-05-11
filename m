Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0193CCD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQhR-00012k-8h; Mon, 11 May 2026 09:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhJ-000109-KC
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhF-0007WL-TN
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:24 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B9C6mi017425
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+nLbY8JMJdA
 iDui26QXsdA9zNJ+aiOby0h3EfFX61gE=; b=b0p/x/6OLgEDJXwSOP8l0J/1LsJ
 OYJIo/dLO2HgyBQ9M4csh3L/s2hiECzVSMe9XSLGp5nffi4G/25Hcm3S12aa/JZE
 wD6ft/C1lGCevtOWjK+NyEj6gvo929PhNlToGqUMClhlNHVsb/BJajO8jWa6CzX7
 wXOzcaXlBVTxuZNdtqW39DhGs315RFSvnXKyJLDcslGbBCL5GhrmjHntIol6U8hz
 NKN7BFkvfjGcmakLpDg45T/D8TLhCnTbmtrEXR1GtgDLY9XDs6VTGVXuiDvD+TOU
 P0zGbjb23900fEHmjqECqkcG3ZvB8yEgbvrpfIazuUyjz6B6oMhvkbkW0pQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfsve5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b3fe2f190bso111132316d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506160; x=1779110960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nLbY8JMJdAiDui26QXsdA9zNJ+aiOby0h3EfFX61gE=;
 b=bNo4JtJQ312G1ikG/A5ki5dfyRwBzGyXRx0xp5v58EfcHxhwrBQTYwoHVTXNhAaMtR
 8pf1mSc3yTa/iki1Or3IMdWrp9avkgI6QegTw6Vgm4GOABKMO+y2mXVuGnw4S0/FybYO
 cBKbZSwEhRjTh8ysvz4OWVTv+cRD9YbvB4cS2KVVRhtLQrjjjn9mfFloWtpJUkF0reoS
 p86O7qQvIJhJD2BijoFTwYrzFa3f3YvXrlgrw7BRGtKFete1aArQc8uQ1CEgw9fhTxLS
 jg6FRdlbi0p1JgEItUymk0DlkWzhqeo+YolIQyCimQtrOeckoSrMhzthSeVdi3sn2lH5
 UAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506160; x=1779110960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+nLbY8JMJdAiDui26QXsdA9zNJ+aiOby0h3EfFX61gE=;
 b=HzGT2zViGbBum70WDbBy95AvgyneujaGcBkN0JsnWzq1zKJN1gwyCNarWiaS2EciKG
 I6sxwtCzqWgubNzRNxa9xx8Zi0i64YMMlMDTHAPHjXj+owOWU4g+KwvhIvKXYM4IeOy7
 HsUF06J0/RfzbV6RyzxGXa+njIuB4seHlpmwMScS3FUw3KdGlf6aDxNgJjnBS+6ioSym
 lYoUIqAtuRb4TNQ1YAzwWl/zdWCeYEys4fQk63OsCz93vQ72FOn67q0YvRFEtaN39BC6
 0udHbFjZh/Bc0Qkz+FJy4WQzLUxypB7JGGig//S/3SlFNZoeIzD311Z/juA46tQPxly+
 2lQA==
X-Gm-Message-State: AOJu0Yyw7moVmZEEqx2qglvXdscfk6NFcJv+dVWZFwgw3fGC2EqEtBPD
 xtoq1Q1Kxpn4+pnF+Rg0rHes6LnFAP3PkUI23mpjTMsrm4Fn18fGu1QhWMfQCH6N56LE6c0LcfK
 U31Bb8KyLUrTIgkfHg1NVEM4RGKl+tzmz2zN2ruCotU71YJYvwP4W1T3ql9vqnF1vZw==
X-Gm-Gg: Acq92OFkeM4U7mfftUI3PAOVYN3nlATV0GgGLYr8xZJf83rbPy+NWB1aW4HKRVrTw8r
 ORwXPCdes9I/y0FfEofB16MhYu0hBotoVqviXwvECr8XvVFzWmdoWte+3ZNVPVZVpnKObzA/Hd1
 BxWTt/9nG7aTxJD7mxIbqgIET6AbvBJ974x7nRrEnqyTI5i+kU3BPd+EhkFA3ek/f5JixZgh9Qp
 Ro814PcB+wEZZvfC4BqohKmOOPOGNtoK4NpfNcu1OOlu9y2Mll8CpReTgJvSTq8beBZVtPBB0Vk
 /pthAIZq6XVCjYkp+RXtbThlLo+ZUqBxLdNfLF2bsI4xBA2bbUK7RTBh2aXQGKpPecR8lCdBcXh
 iZK3DOanPw+FsHtHuD/KP3R/tFFn/A+Jm4JXrvoMAqMqRFxNqe8NcBtsktusP
X-Received: by 2002:a05:6214:451a:b0:8bd:59a6:4165 with SMTP id
 6a1803df08f44-8bd59a646b4mr311159156d6.4.1778506159880; 
 Mon, 11 May 2026 06:29:19 -0700 (PDT)
X-Received: by 2002:a05:6214:451a:b0:8bd:59a6:4165 with SMTP id
 6a1803df08f44-8bd59a646b4mr311158496d6.4.1778506159397; 
 Mon, 11 May 2026 06:29:19 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:18 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 02/13] target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[]
 order
Date: Mon, 11 May 2026 10:28:59 -0300
Message-ID: <20260511132910.1738069-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a01d9b0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=kMeT2rDkcwzC_QZMVmMA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: kCzh4n9ezItiVXeWuYHAHiZYClzhhICO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX4QXPK/9APOq1
 KZbFV1B/Ey8tv83BJTqwhafdSZ11V5KAtlRNCy3uTMvATU9usLPBWqdpJJ+hkUF+ZyidmRtBW3r
 k/pbdjMLLW9SqsWroMYbxOY+/MLYDax6iNZuubmV1lpNdcBAREOSYfKFXWXw13imeDs10qXfwaA
 GNH9fpmQDk5hcJoJ+viFDwynHJ6JZl5CR0/zYWAhnvv62YsX7U9XKhn69cxlTYDFmG182B02h2R
 i9hTZPBNTbacAHvUhtjwIr7Yu/rH2t2B84KOCFO7Vt+mWJlwJ99/A5YlRLvASzgeYZFcPOiDu2I
 iYvO0OF9AFumdUiPcEUM+CGrBHY8snbRoUYoRmBQX/MHXkqLQ7/gPUKANYBerIM6Iyoff7Tz81N
 6JRfwrbV+PgoswlWglRz7Ieqy8pWzUIY4/PA7hgqr+c3VGMWfGHcNDBs0ZAB2bIHzFfeMPJHG7x
 A6+RxWOMr6ycohRB+iQ==
X-Proofpoint-ORIG-GUID: kCzh4n9ezItiVXeWuYHAHiZYClzhhICO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Noticed when realizing that 'svadu' was too far apart from 'svade'.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a9d9d16c1f..ee8f6e5296 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -222,6 +222,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
+    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
     ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
@@ -235,6 +236,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
+    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
@@ -246,8 +248,6 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
-    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
-    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
-- 
2.43.0


