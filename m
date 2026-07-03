Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1658FC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiHo-0001dX-17; Fri, 03 Jul 2026 14:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHX-0001Xe-Dp
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHV-0002I2-Ga
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiQjq530592
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cmKlme/+Fb//M0XR1dvpwM9sgKlADSguwUHq1PI3P7M=; b=bo7PCY0nLjLrIfeA
 gdLStHZEhJvBrkM+NySyM+iRwrPW54MRuqLCrpYmHyysZZcW+syiLmgvXImnGlMw
 tNnc6C8lRUKnLEd9MUIhilbIWn7zZt/mQ4ySW1EKHkTJtR6/78J82p8SP69hrDV9
 Xq6/1QP7X8FxA2cuXmGb/OrvPT8u+vngOi3AdsE9O+LFRc/Epvm06i2h2UUstFiZ
 aTEC1qwvXTtdE5z98rDKhpG6g9J2YrizezbtGi4g4LIX/Ob/yVU+V+UAi3aXtaAm
 y4KBLrcTDBTYx2Bap79x70LbpFdS3oZlM7KD1NuzRhYVA6H36afzjzX1Oo3MD/E3
 6UB0gA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n3gtm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso17039221cf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101987; x=1783706787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmKlme/+Fb//M0XR1dvpwM9sgKlADSguwUHq1PI3P7M=;
 b=COdqWBA0rowQGTfG4URAr8ROWEd51rp8BPqVyrtemlebqLcGDN2iP+VDeUdO+eCHKD
 Qaqn7MPP8oRMX3h+bknFgqw0eCmw4c5xwGDmawbA5gQb/mbOFFt+6NTqomAq3LdZc/9g
 SpiISJZykhpkJ5cO6SQaeoknirzKdRI9Ov/IGvskNBkk1Zqw5+q/s7yW3zsVGCkqD2cT
 oYjo/1QQpamar1B/0fXAm91B4NcqmAgCHzoXk6FHD1uMDahID0u+MAdg1u2Suj22tJVB
 BNRIbqdFh2kcuswMF31AE9Xc1Ph536DiyfAvkmaExfJb9yj7GkeW7lOASbeARZTRch2c
 Iubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101987; x=1783706787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cmKlme/+Fb//M0XR1dvpwM9sgKlADSguwUHq1PI3P7M=;
 b=UaTUpujk4aoIgvQ5ZBjrzVxjbnUCWBLJ89V/WDy+evoY/027K7D5AW2Q3zdGegBYs6
 zz30Zo3tdegnq5tdYXnPFZvV3ZP5RQBOIY8u4Qpz+BIlGBkLQeEWyaDadTMmkmB5T6jM
 zUZRzyEAp4m3wL9fq6lgERufvWZO0PBCcM3YjJhoCI4rEzoKGDsGq7w5ufjjjrIRzsh1
 KfA+cAPbrnU+bCY8ddx2vzdavqtpK6P53kbqn1SYHj2yzJIu9GVPzuha92cOC2GARflN
 Hh/nlaQhmeJbDs8CYIAsUPPDbGTbg7SB80b0n5QKGwkKIXlbhtpBT5jETHgNtmKHl2nW
 ZmHQ==
X-Gm-Message-State: AOJu0Yx7QN6bV972ZKIMdLf3lO1nTsYLIxnzGblJlXeUEvvP190pblAL
 ECs/PFOQNseFKysmXr1cOXGDTvRzQl0XPyT9iCr6CMCBxtusDhT/XDvLL14ZModf1JanfgxHzpE
 9QyX3Z96reTNtu8kqiMwcdV4TiGctzdQP/wsa9XMmfLbY2z8/FANc+4IEVR1ZwpVaxw==
X-Gm-Gg: AfdE7clByLdwkQgts2WBFNL6V5Y1APkZObZveBcEp8UEggH8fhaXjEb29UErMr6oJ4m
 zl5BQwlwMGdlJHesRcU/6rwmm+djv41WUwDIXABe80xSbURegKiY7i11ZeChEqAXl2MBnXz+Irz
 VvGKfIsdGAX57hYGd3HyKSLi4PicbxevjHPL95O2itz3aLQLJbdTU4Vu/sqqSA0j7eYCNZI26UK
 R51DVDSHidarzCzebL624AW6S3gtGzkY63b7M+tY9KJwUMNTpsUGD/XXnKaKI03N+oaBgW9u9t/
 QLbreAoQTD0l/hzMIfAjavIAalsiNCHOJj/LVLcPoCJdItiXd21Fo1wJQwvO3JXhdH3C3qQR6Ro
 z/Tp6VbaAMWFhXU22oT6xxApsVDJbi48QzCaWWSwXBG+wkg==
X-Received: by 2002:a05:622a:408a:b0:51b:3e56:6407 with SMTP id
 d75a77b69052e-51c4c32a935mr10549331cf.54.1783101987114; 
 Fri, 03 Jul 2026 11:06:27 -0700 (PDT)
X-Received: by 2002:a05:622a:408a:b0:51b:3e56:6407 with SMTP id
 d75a77b69052e-51c4c32a935mr10548451cf.54.1783101986475; 
 Fri, 03 Jul 2026 11:06:26 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:25 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 15/24] target/riscv/cpu.c: handle TCG bits of
 riscv_cpu_dump_state
Date: Fri,  3 Jul 2026 15:05:27 -0300
Message-ID: <20260703180538.3346781-16-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXy9X6GOBhHvBk
 Y9Zm1uUBo+50sj/F61nxllF0xHqhSV8VtreopSzIHtbpLl19pW0JY7bMxbzBw2SLFRFqzB6Qi+6
 6HNhZFP79LrY7Pz7hek243YcBv+Fuc8=
X-Proofpoint-ORIG-GUID: K0j2Q0MLyLSaLpkm8GOw99tleF3vEBzl
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47fa23 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=n_Gjmr79VRyvsDPUZ2MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: K0j2Q0MLyLSaLpkm8GOw99tleF3vEBzl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX7DwkcIDU/nq3
 rryOjZbkCGwuCTpF4t3B2uDHPfIEty5SwnxhZQ3mCH2M3Db6C2xThE8PPUYEktYqu/vN5SmjeZY
 8nJOlXlLROTOOgIo1c/E3Gj2Bf8A3Yl0f3BOfm0KrO2N9sQucwf3ngmZaPtoQul8n0T3Sc99VnW
 kwM8iwQUvAgNOfd6z9nL7x+Iz3JJBxb3Zs2XNxfh28IPV2F1/AS/JloU0vhKGQd6Dy+i8pOZ7cG
 flnSYs5GhFhIBhwh0KelqwPCru5iPJLwRXKWwWjdWtD9D57M5eWSUgPWMXkijjqUmkc+DNog8Zj
 cO96xil5cPRtNuN37mfDhuGvPhviERQVPnWbvS4+LLmY8cROE7RyzhZyglXM/KakApS6Tiu05+0
 J0vCN/I7cgrN+iVh0qAntENubBVDB8M3DMO8zeFUJE6ZIjhnGyMfl/KOEz/vPdTa+buV2wLV3hZ
 syZ2mzVWVMLWaQCMkUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

riscv_dump_csr() is a TCG only function but we'll have to implement it
at some capacity for KVM eventually, therefore put it under a CONFIG_TCG
ifdef while making a note that this function is unimplemented in KVM.

The csr_ops array is also TCG specific, thus the for loop inside
dump_state that iterates it is also TCG only business.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2741047769..db18c52656 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -612,8 +612,10 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
     return cpu_model_from_type(typename);
 }
 
+/* Note: this function needs a KVM implementation.  */
 static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
 {
+#ifdef CONFIG_TCG
     target_ulong val = 0;
     RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
 
@@ -625,6 +627,7 @@ static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
         qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
                      csr_ops[csrno].name, val);
     }
+#endif
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -662,7 +665,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 #endif
     qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
 
-- 
2.43.0


