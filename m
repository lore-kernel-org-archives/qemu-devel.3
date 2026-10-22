Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B886606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gtwe+tKS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S8KHr6QF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nY-0001sZ-N0; Thu, 22 Oct 2026 17:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nU-0001nv-CJ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nS-0000IX-Gh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHMN63741970
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VOx5ZwQQwfDpX6oIUswz4nFSPysUM34RdyM0aG3F9lw=; b=gtwe+tKS/VcPOy8k
 y33Zb4hkYGv2PnEhGDf1HNOtXqXUp+R6cSWNueOGbuJSOHwoCrrGZI3A5I8/dAXp
 mdHrcO5XSUSYKQtT4lFx7nhlXaZHgxQM7cOFXpSVFBC+G79YOJY7WRoc2AV0rwLF
 0R0VXjctZiN+mxwZfsHdKlCMTgrTxZkktSkHHe+ymTXeDjDrUinCHKrH6d2IwQwk
 xMBOzykJBvF5EQaMzAQsqO7sZTjZDjUNd5muJgVnUViU84eY/oIhf60Hp9otwxw2
 kEux5ra4xyMuduAVauBJK/QSUSN8Ad61UqSHrmNzsfZDbFuLxASvhS9dEvXwF2vy
 Vq9LSg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0qby-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3adad90c894so290067a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706280; x=1793311080; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VOx5ZwQQwfDpX6oIUswz4nFSPysUM34RdyM0aG3F9lw=;
 b=S8KHr6QF20KBJGfyx2L8FhjkyRWDgtJgZrCmKZbwOKKJ3S7w3hOdncr71dK8Q8QXsA
 L73RPA78dxLJiRddgAInxyVCIEjHK6gbIwHu/4/31b7ZBEKDkpqQdpLWULhsrQCeN0Xg
 15uGH14v3QgfjuN6GQXxbeNe0Q7DB4AiOAu5541iUIVpJHoLC+pp/I/3BG1ofZHz+Ho1
 mPugTV/SnRSXxX0Z4TSf36xdYzFZifUkoBu80EyuYzhyBlBTNM47gLIRDg1UjnhhbqXv
 A5DGjbfdnN6s16ZhRyi6JsZ75Y8BfN881VMvHsQsn9TqWbOLcWVOPoOG351UyHFC7lMR
 7epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706280; x=1793311080;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VOx5ZwQQwfDpX6oIUswz4nFSPysUM34RdyM0aG3F9lw=;
 b=zsQw9BQ7aGFMEF3aE0gEowurSkCN3AF8tF6Q6LswxeVVZ11bHfbCnHyCBolAnxQfsF
 KreSjOurwmd/q6UnHXsGDk6KDYzfvg4NBzRpVLabJDRXHnouHq3rwz7n4KlKVF6iXhy+
 z6ElrN2m+4W3OkPu3pUuww1uATORYlS9mzBKPSNiv/rBNmxxb3xEp16HOD5eYwaovprZ
 UkszMly6BNMDgXqk2aMx3/RomlU0wTyzAZ2PCVIXOUs1yGb3q83nYXolIFxb8D+ekD0m
 cdJStNkT3mrPVeCpQLpnWdcgd98STP9aPI2B5Fy8ejsoJ5M9WmmHPv39eEXg8mTcbi13
 C7BA==
X-Gm-Message-State: AFq9FYLhxsOY8UdD0oAfxt5BUHFYz4KogzpR+QGm/tOPpylZtPD1eaRp
 WZgaJQoREeYTD0ECPM1xSIqlTrOpyZDVxdH0fEWxTaOHFiFmoNt9x0DyMFOMaIkwNkRy9YruB9q
 x9CJAVpyNUp9BAxhELvTbq+uvMllbp0PuiFHAS7JfvPq38/CZoPBFUhz1WU1g+6DtFg==
X-Gm-Gg: AYBFou38LSo675QNiXLcE0176mPeC1g1TLOSJhZEpTmXJ8AkLY3AIU+bCNaDxkEGOzK
 3kIyq6dyobvbdWDv8erOXELsdGKaHNtz98pvxUfCjE07bJ6/xRPhrgup2ae7xW8CA8JKVHUWSO2
 7ckgqeXi9xhj1vBWxLvhsQBgcCWjR/ZDgpBnx/vxk590OaCZibRsM5+C7GpxP+Wobqrtj5szarw
 XzJlDbokajtR7d91NlLoQe0bYkndr8YPvdW5GijX/JCiKZtcdmvcmCxUZCzIewO86IwYrvpqdLm
 ocBnBiu9qsjMtbKae6TbOoU5z0j6RvrKvZyORsJucCLxf6N+KDVosDLCpXxbgfR9lCH9FYXMHkv
 KNevweAeT1wLNCLPqoF8afy4aXxV12qoXHN1Gn1EuARMc+bu0e1OXNCleDhFkLcc=
X-Received: by 2002:a17:90b:3dc5:b0:3ab:f2a9:cacd with SMTP id
 98e67ed59e1d1-3adce828e7bmr147151a91.49.1792706280419; 
 Thu, 22 Oct 2026 14:58:00 -0700 (PDT)
X-Received: by 2002:a17:90b:3dc5:b0:3ab:f2a9:cacd with SMTP id
 98e67ed59e1d1-3adce828e7bmr147140a91.49.1792706279973; 
 Thu, 22 Oct 2026 14:57:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 12/27] target/loongarch: implement get_dump_info sysemu op
Date: Thu, 22 Oct 2026 14:57:31 -0700
Message-ID: <20261022215747.2479440-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX2JzcSX7HZ0Lr
 puik5hZO4iAcqLgXuMTdHyy1mOdxUyyxJgQrVeaKeC9w98dAcsHyf9ilryaM7ZsrN8EmZPYiUBA
 XCybKUxB4j5gI8Ui+6w9A3VLHj7MIJDN3V4DvSyUHW32hMzG8/usb2gIowpPGzSpiyUpuR1CA+9
 bzl3cM6NgwLxNzYYlPNs8BLldxjcEXjVfuwIQz5xsEYiUh3Z2isQfoOwRiB9QlhX3eXGLtik4zq
 7NCiFyIuzcZttVwH8j9lYzvUJ0wX5Z+8psgInqfpF+FAj3Xf3lJZQIUslM55AxKMhojS4x/I224
 2v4OZtDmJgw8knwcXLGzdRRTT7QJy1cvsOviXs6wF0eEmQzKGDaZhkGiubtTZplbtzgZ/cO7Xvt
 UFnEmLcDUaRh3CkvUu4JhVDqg4AxhJG90kH5qo6Gto1agxS5ewULBnMpoal6h9fDT+21bxSQIDB
 h1avkywBXuj210/OGhw==
X-Proofpoint-GUID: AQ1TEqaJa76Rl_0uJt3PAzPm1B3THzgb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+6/7kVngtHCh
 yCT3TsyFsyQLR5P3Gj2MbJxnuIqGzjQSLU+08XOm+Q5BiSmaArfLlJzW1ZF0zDv0Kt9x+TY5fIo
 8picgA9osvLMVs0Caj42bC9/7zSeMco=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada86e9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=FnhWYSpmk11jPv6NQAkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: AQ1TEqaJa76Rl_0uJt3PAzPm1B3THzgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
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

For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-13-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/loongarch/arch_dump.c | 9 +++++++--
 target/loongarch/cpu.c       | 1 +
 target/loongarch/internals.h | 3 +++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 9d84faef969..0ab2df7fabf 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -142,13 +142,18 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
     return ret;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+void loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                             const GuestPhysBlockList *guest_phys_blocks)
 {
     info->d_machine = EM_LOONGARCH;
     info->d_endian = ELFDATA2LSB;
     info->d_class = ELFCLASS64;
+}
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    loongarch_get_dump_info(first_cpu, info, guest_phys_blocks);
     return 0;
 }
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 54c26998979..65772f30947 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -841,6 +841,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
+    .get_dump_info = loongarch_get_dump_info,
     .get_phys_addr_debug = loongarch_cpu_get_phys_addr_debug,
 };
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index ff956823fd7..041d07442fd 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -51,4 +51,7 @@ void loongarch_cpu_register_gdb_regs_for_features(CPUState *cs);
 int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                                    int cpuid, DumpState *s);
 
+void loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                             const GuestPhysBlockList *guest_phys_blocks);
+
 #endif
-- 
2.47.3


