Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D492CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOMO-0001da-MT; Wed, 07 Oct 2026 05:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOGE-0000TV-7g
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOGB-0000tC-IL
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jeHx3194063
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iTh5m2YQTWXSBC0GlLmXdtPPGcPnrBBEZumeLXJTLqA=; b=F1SLOlSFe6qT4xKG
 kR+oIvHSDXXzHnWOdlUmgHGFthqG7BK0RtP4cEaxgSD4xIN0grJ7eDcBKaMK0Foi
 nIOmi2dR5oO7Pj/yU55Bm4ccSwBcJyuWZZU/Bs0LQq/1ac2EHWocJMALRG0ZqgfK
 hJDRtEidMaQ/T2UAXsbH7i+9gmI8QCy/Q7IQXJ+Ukx0RinZYyxuTfIzGTH8MKXW/
 TVNv9eDGEQxIbjwYQ2RaRFSRT2eOzc90pKHbTv7IOsP1CjrTvbg8Mcp2l3YZ0eDt
 uRFJu+FEduQvH3YXAqTdyth7a3q3v6beE2lHL6MoZyVOyof/8dxq8LS6/38RD5SF
 U/vvCw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h541ukpt6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:48:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e46b4b700so642262885a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366506; x=1791971306; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iTh5m2YQTWXSBC0GlLmXdtPPGcPnrBBEZumeLXJTLqA=;
 b=QA1kjaP7qTbKm46Ca4YvgcvO7QHPv7M2NidTKKzr68jAg/RWi6+C2Vni+vdKXYox1r
 Rl4BmJx6uiiKluMUs4v9ubVZZS0BbTg6QVmlZJIIM5BPJsJS1C+OkUXtxXyjPI07CzhU
 2tGJ3VzLkXwll/+XzECqmmdta4sTXVj1D/KgZV19CcfeFDSz90xSJw0BliCoPHeIdcV5
 ILZh2TAyrxSfD/mVUT6COnB/bdweLjf30DVrxQkE7Th15T96uaobpCyDyORUfJfawN0I
 kozut9dQTZ5WDDLemqMNSZrwWXqO+/ecIZsNRYb0vWizy53hAaEW2POhmepWyEa1LRb7
 pCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366506; x=1791971306;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iTh5m2YQTWXSBC0GlLmXdtPPGcPnrBBEZumeLXJTLqA=;
 b=VT2/y4hyCRO8VjbiOvlPlvlKHyAjXjUPU8+eFUECHdHEbWYITbWi1i79syPAvizWeh
 ppj/UgTmd5nSsSGsqyFLc25/KH+5qQB7X95PgeROJmEImBGeqowhM2PYGX42O/T6kPs8
 R0LjANfjVuQWNOLGaFd4Wzficf4bYSWXqknYBGQ+bVnFCI18iso+/Bi6yl588TDzAuCf
 T25SkEGxRiQ6uWPim9wfu4YI0kpZk5vUDHDx6QI7tZ68VZRdkXvODL6TBzAhrLqkXN8e
 WjR7tGy7p5azh6IVAtY6PEW2aDDjAXD1kjyCJKVhEDVb/mQj5tJvCTI3aDbd6p6irfx6
 Dg4Q==
X-Gm-Message-State: AFuF++m+JHPPwzarrHqxg6H3pGd3pg4EW1fk4fWxY77Hz249h0ubx+qP
 aJBMo3xq/NVZtPURU0xne+sHzfrpAyAG8KpP0RZxNnxWaSvR8Y0m/rNvEYZOzPiz3PtGFcBqzPj
 oQ3f+PmEoze99EAzOa0mSX9yLNbhEl90LFodF0+Xq9dDNCoJ23TSV8gcdZw7q81EXDtr8
X-Gm-Gg: AYBFou0Bp6hOVvWeJ8prC7OQIRFXzQWOSOFDkJmdZ1tXXJUTx8ZKQXUDJx4F47MP77H
 2HfpsEZkPA8HThJBJepLlKQZ2mu/2bqB79UThuRvO1EE7L+UjrlooF2YxponeQb01GX2Sq7cie4
 sBBdWjY9dPJ2ZL7IjFZJK41e1DLeduR96hyPqovTDxyjLMRKAYIPzRBzWaB7+0jsGe54VUoUCZt
 suhrvSUZs7KUNfzQyDJfiNbXV3pjK11BhrJuLil2X8fGnv7o/pnxewLpBOakfjIYxUu1yQ2oMrG
 sav184ebysp71spvsC5JDbnOMX9a7rd0jayzx5AS8sFf7ZfWGOo1Ay9ILyji2s0EvZ8NlfbNstN
 Y2RQwvumovlhF3FiEu3nVO83dw+SOQ07zZ/FF9d67
X-Received: by 2002:a05:620a:26a9:b0:937:11c9:37f1 with SMTP id
 af79cd13be357-93e9b74c37emr294935185a.16.1791366505652; 
 Wed, 07 Oct 2026 02:48:25 -0700 (PDT)
X-Received: by 2002:a05:620a:26a9:b0:937:11c9:37f1 with SMTP id
 af79cd13be357-93e9b74c37emr294932885a.16.1791366505218; 
 Wed, 07 Oct 2026 02:48:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f54a650sm53925465e9.4.2026.10.07.02.48.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:48:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 26/27] target/tricore: Implement and register
 CPUClass::exception_name()
Date: Wed,  7 Oct 2026 11:45:14 +0200
Message-ID: <20261007094516.75732-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CAcKcY0jqSyRk5BxKQ6Zs5qxVQzXLA0_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXwxW6MHjmpSdG
 KUFcwtTDH9sB/hyFR0RE5RwZ90/qsbjQhQ/ZIc5YmHNIFAcfk/YQ6C0bIpXy+eG06XH/icfCKW4
 q9oMJAMmVofd4XGo1K+ouMBLbGu43ek=
X-Authority-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6ac6156a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=M3mzNYHUzacmDIfs9B8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX/morIoQ68h1y
 VraE3bmeUxtzHlO2M5uX+/AQLPktY3Asn8CN6u2QmwFTIs7aouLUkunACzSgqqwBtUXpNhePska
 RM/BVhOVG9cxS0GZCLJsQAHQw0fYFlPN2fB/l1DS7XYvgkPb21TIBfV7ew2xB2JeT491HIkDQEX
 XZxosV70rYRnS9iPgP2OH84CiVqzRY89cO4ok16WrxrZrcvTNzZsCeUAGui5Bp3hUnJZPxH+eta
 6KUt1ueWqTIKhEcAyefW47Rsfwd4PJE8qek6+3iu8EG2TuAYl6XiTcyB1t8OM2zDk1ru/OUwPzh
 rK71n6I80KiKfZ19b8Anmiw98ObMDZDOmv+QpLYNu1wuBIJbcf7/JuTgVxt3zsxs2TuxhLIZfkN
 2nbAJbbevS/zreW5kllM3suKdVZrzmw/3ULmKGCpyqK1KjCTxTx1zKQ2YviNyeNaxlO6lji/EKx
 ApY8qb3L7wtlOzQu8Xw==
X-Proofpoint-ORIG-GUID: CAcKcY0jqSyRk5BxKQ6Zs5qxVQzXLA0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement tricore_trap_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve TriCore trop numbers to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/tricore/cpu.h |  2 ++
 target/tricore/cpu.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 12e497d2a7a..fb8d2fd1011 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -178,6 +178,8 @@ enum {
     TRAPC_IRQ      = 8
 };
 
+const char *tricore_trap_name(int trap);
+
 /* Class 0 TIN */
 enum {
     TIN0_VAF = 0,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 84a05e3d363..d550b8b0b8e 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -36,6 +36,26 @@ static const gchar *tricore_gdb_arch_name(CPUState *cs)
     return "tricore";
 }
 
+const char *tricore_trap_name(int trap)
+{
+    static const char * const trap_names[] = {
+        [TRAPC_MMU]         = "mmu",
+        [TRAPC_PROT]        = "prot",
+        [TRAPC_INSN_ERR]    = "insn err",
+        [TRAPC_CTX_MNG]     = "ctx mng",
+        [TRAPC_SYSBUS]      = "sysbus",
+        [TRAPC_ASSERT]      = "assert",
+        [TRAPC_SYSCALL]     = "syscall",
+        [TRAPC_NMI]         = "NMI",
+        [TRAPC_IRQ]         = "IRQ",
+    };
+
+    if (trap < 0 || trap >= ARRAY_SIZE(trap_names) || !trap_names[trap]) {
+        return "unknown";
+    }
+    return trap_names[trap];
+}
+
 static void tricore_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
     CPUTriCoreState *env = cpu_env((CPUState *)cpu);
@@ -240,6 +260,7 @@ static void tricore_cpu_class_init(ObjectClass *c, const void *data)
     resettable_class_set_parent_phases(rc, NULL, tricore_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
     cc->class_by_name = tricore_cpu_class_by_name;
+    cc->exception_name = tricore_trap_name;
 
     cc->gdb_read_register = tricore_cpu_gdb_read_register;
     cc->gdb_write_register = tricore_cpu_gdb_write_register;
-- 
2.55.0


