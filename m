Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80ABCD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdp3-0005jf-2d; Mon, 11 May 2026 23:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdou-0005b1-Fe
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoq-0000Kf-7U
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6mFF2519102
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0GmmpYoJW3y
 jIGaIP6YmtrLvEha1Na4rKBarcDCv2mM=; b=QiDjZXKZjGUZJL2FVjTYe8G1gIp
 NNDPrJqKa0fn1H9uYgdNZQeWIqoogFByfnqyNbfwLXlxR/efEdtdMkNhp6adnftV
 8Aea4iLXalYZk78ZFNFt8G1KL778o/INX0jvnZOo8vmb+90UxnMvUmIw1cRPG2NV
 Mtwgt8xd2Iig3CdWG6Et1iKgCGgsIOk6LqdZYLV7aWXDcbl9/HeSca9GauzatQGk
 Qfrsnn7uEyU3tGYyiA4bl0Qb7OczrL+p/JMnOx25EPzcAEqqlH7p4W04V23vHepB
 9qZwc2nG/EBPgXIZSNxvIDXtsZ8C8Erz1uiSJ/Qw5lRwZgy/5Mi+YXI3yyw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1h8wx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2f525565b33so6246142eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556599; x=1779161399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GmmpYoJW3yjIGaIP6YmtrLvEha1Na4rKBarcDCv2mM=;
 b=AXeoDlvBFhQKV2qqndc1ouoJDcflIMXD1c7BQP5Y6Knd4Y1X7v6JMsOVojaJ15WyY+
 5S6Hm+IlEJmrLAOQ6Hjy1uvHmlLx3+aG224qHqVZ8c/iuPB9BwGncJKAqUHlPFmD4qH7
 O/4kXG9En60YEvqBLx+wEiZpOxqbUA8kWNfqtZHjXWYE1N3/PV+UVoDgAJou/ifPHklz
 /5u8D4fwN8jcLgfbSKKsyvm8V53Rhp7GQh6T0crp6eWhGvbP4jQagVcv4F9S1MPO5xc6
 Wy15K3BoacOeAkTygYll1Qi6AGy5EvuvuKmIZFVE9Ywe0PPzjjfoeQnL+a/aJEpIK5J1
 HsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556599; x=1779161399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0GmmpYoJW3yjIGaIP6YmtrLvEha1Na4rKBarcDCv2mM=;
 b=aZRPTaeXdqtXjciwgo3ZpXdq8k+7lbPtQoGiE/+s3QPKcpBw+auxjzaf60TQHHPoyr
 TN8h3NHGnMPU5ktHjpwLthyS9XsPgkg0lQpdOqrGPgBVjVyLsXiNnFogrGY+jljHBrnL
 oXZTtHTQmjT9+oCrMGwPaMEuicZUV/8+yV/mLFZsg8NnJ7/Ki6Q7+NxcI32drn1xL7V7
 KIW2co4fKRy2XXZ2G2eDBbyDH4JUuCT8lyuFtyrvLRu5yPLyOiP+OJ5LJ9s0K8YT/cDf
 r7W57FcC+09TqvRUvY8WDGWP5upq0QHv9MoCkAuMZznTF0ZS5DihcueCBZYkDwRqckhh
 rkrA==
X-Gm-Message-State: AOJu0Yxwhekw2MMCO606CKTkzVKRtch3UjdT/KZWXKHMG7z8VVCDBKWI
 A6s8a9vmrxBgjwl1hPKvG8OJAd/u2qKqIqbQk/PV/gUl7K4YnWo4Em2IfMHB48Woftiqhlq8EEf
 3m6MfT34n/5hltKBv3qy1FoC32kMNCdc/TG+FDKLR6SzxEraqdiUEK/B23H59N5sDBg==
X-Gm-Gg: Acq92OGBzS7ZxfErs5sGlD/8deI5sw4ZHEXQhfQocgo5tNqa0HP1c0bg0fNVj6mXY44
 StpsqxqU9j4X3xSYZY5KIIQlWpPJje49JDlmGYtGkDLN3JUHAGaZpTWd80AXNP2B8qaTStxQAYi
 2u2W/XnVX7YydAcpWlktRjCRXANn+pbSCBOx00KH0C++yZIt6nHLn0it985AhRpkYJ9azZ3E24Q
 +LPttKgXuACQoLigpegXmJsP5gQE9ZIUC04BrtWP89yxPQ+rNCO/c7XCpyxAujSEopMONqr9V0Q
 q7av1kqn6Tzoq3Fpl5vL1wpnLZTNjxS+Gg6LO6nghFsf9e98zQPBE/KvzzRZGrOmUOMjS4vEmrz
 9gKzG5CPjz5USpEcso+Fmge7iprc8Z4ay6jsf3FfK+3md2+wooqxWQ5WhmRBr
X-Received: by 2002:a05:693c:2c01:b0:2f5:3fb3:4a76 with SMTP id
 5a478bee46e88-2f54dc8e745mr13373483eec.10.1778556598646; 
 Mon, 11 May 2026 20:29:58 -0700 (PDT)
X-Received: by 2002:a05:693c:2c01:b0:2f5:3fb3:4a76 with SMTP id
 5a478bee46e88-2f54dc8e745mr13373473eec.10.1778556598167; 
 Mon, 11 May 2026 20:29:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:57 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 11/14] target/riscv/tcg: use cfg_offset as
 cpu_set_multi_ext cb opaque
Date: Tue, 12 May 2026 00:29:23 -0300
Message-ID: <20260512032926.1978818-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uNO5GZ-ZUxYKXg5qFi_SCkhn8VYXOu3G
X-Proofpoint-ORIG-GUID: uNO5GZ-ZUxYKXg5qFi_SCkhn8VYXOu3G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfXwDRC080jD32W
 iEhJH+den0VwjJlFTCBNIcyTS8KhvRpUPXWTCiP5CBzR+PANkEjxeyjS5/T9wRSHNlUQTnTYso1
 3bAm6W4Fw/RQmTYUxtS3MQuuGXIB+WquuMSWwFKsYzQ5YJFFi5sepaJZnAn0ZYaypugPxRF0+nQ
 rJJO1pbSUb1bytPcq/KguIhs2KlkrHUgmUe7jXACov3I3QpT+a4536Xs4d9RNZP8zi0TtLFZeey
 FUACI/ugzI705DQ81ZIlh+1AUqltZw9wAehxJBuIwvHlP6YcOJR3p0zaPbCJvR6GE/RzpSFjIHr
 0yKV6wWt6ZmoCjMVDfd7TIHgdopxG+rU6C0n0PCJVqt29xLyW5PQ5SZcOv0PM4ros5VAGEbJxfD
 5fiO5d2ayOKrd64bOB9Qcwr9WAY5kRYagVEnLTPJKp6g0a+AQ/nMCb/5ONZdZ3WgjstnWxe+v9T
 yVBamXwCRcyb1aUpkSQ==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a029eb7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=eGyGyxdOu922ChY7XH4A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120028
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

The cpu_get_multi_ext_cfg/cpu_set_multi_ext_cfg callbacks are using a
RISCVCPUMultiExtConfig pointer as opaque, but internally we're just
using multi_ext_cfg->offset.

Use multi_ext_cfg->offset as opaque instead.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index eb48a76a6d..50d9218a75 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1510,8 +1510,8 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
 static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
-    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
     RISCVCPU *cpu = RISCV_CPU(obj);
+    uint32_t cfg_offset = *(uint32_t *)opaque;
     bool vendor_cpu = riscv_cpu_is_vendor(obj);
     bool prev_val, value;
 
@@ -1519,9 +1519,9 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
+    cpu_cfg_ext_add_user_opt(cfg_offset, value);
 
-    prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
+    prev_val = isa_ext_is_enabled(cpu, cfg_offset);
 
     if (value == prev_val) {
         return;
@@ -1535,17 +1535,17 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
     }
 
     if (value) {
-        cpu_bump_multi_ext_priv_ver(&cpu->env, multi_ext_cfg->offset);
+        cpu_bump_multi_ext_priv_ver(&cpu->env, cfg_offset);
     }
 
-    isa_ext_update_enabled(cpu, multi_ext_cfg->offset, value);
+    isa_ext_update_enabled(cpu, cfg_offset, value);
 }
 
 static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
-    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
-    bool value = isa_ext_is_enabled(RISCV_CPU(obj), multi_ext_cfg->offset);
+    uint32_t cfg_offset = *(uint32_t *)opaque;
+    bool value = isa_ext_is_enabled(RISCV_CPU(obj), cfg_offset);
 
     visit_type_bool(v, name, &value, errp);
 }
@@ -1558,7 +1558,7 @@ static void cpu_add_multi_ext_prop(Object *cpu_obj,
     object_property_add(cpu_obj, multi_cfg->name, "bool",
                         cpu_get_multi_ext_cfg,
                         cpu_set_multi_ext_cfg,
-                        NULL, (void *)multi_cfg);
+                        NULL, (void *)&multi_cfg->offset);
 
     if (!generic_cpu) {
         return;
-- 
2.43.0


