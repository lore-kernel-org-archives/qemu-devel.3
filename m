Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B928CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOLO-00086m-Qz; Wed, 07 Oct 2026 05:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOF5-0000Cz-4U
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOF3-0000nj-BY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jjWQ151972
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oaHPbDt6oHtX0WyZwfohm2WvWyRWanIE3lUZp2Z3RHs=; b=MFIztTFs6aOdLWZs
 5S+lQ/QXIq3FLqGNPEEVIC91+m9Jqhio96uQa7ED0WdXgAcpe/XPOen/c0P0UEeN
 Q/T30l8zrYKKUBbn3P+0PgRDD07HBhj8ECIwyBZsVX7udBC0UHA400JJ1e3Y/OiD
 ANz9JpIt04nN6xV7BWHLRvcCnpcmbopSJeqeg5SkJZdRXfhktuvHI3TnbKxrSZrV
 8tkA3X9IhxE1W6NPzVtfIU7+lUzO1gqno/3k6gaYwP9mwZw2dr72GU8TcTNUQ2sc
 5oGqS6GQTDW2/mCXGKLx5J6Gzn2BQ+gS9tn5iTM28DsxCpeV5yZ9XKOcelYoDaMt
 E/AQjw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c719h8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:47:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ca9b53afaso1004017785a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366435; x=1791971235; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oaHPbDt6oHtX0WyZwfohm2WvWyRWanIE3lUZp2Z3RHs=;
 b=WHKsX5XMXgpq18xjNyWBQpN+SarmuvbiB1cHBILo89CUF42AWmQBeQASuLK5UPwMyk
 l281+2FFd+RiDA0RG+fOt3tt8vNBsPRDj+PlxpUluo/F7M7e7Zm6fPcV8qw8uixruPkd
 pjsxA/IHeJshDhRfgpi/noM9UHD8DGhEofYUoOUVxPER5C32cDaz/B2edb8ffqeCw1Sf
 j+8q2mqgXorx+u22941BprUBE2cii7XrFFr64OJ9SiecTwBrZJX7114xWCzXVp8TqUtU
 dsfNuiPcY8u4JzvqUYXEgOo1y3VQsddsYYB41OY0usMIljsSc9BSFN89vSzfySl3u0iL
 XByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366435; x=1791971235;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oaHPbDt6oHtX0WyZwfohm2WvWyRWanIE3lUZp2Z3RHs=;
 b=Gp22Yy+o+veSP02ToeoR7ZTa2QROwKeXHTVFLI1qitTLEIz4dlGHrEaGbjT50+fiLA
 1UFESUfUFqsBfSmLqkGDqwG741SsMfevHnIdQCzOB63ecKLgQyo2K+bUc5UCNlqYyeDO
 4BTgOCQg9xithow16hZrRe9kMPLuDyJwOSr8Lfy7nTchHup3JBXF1BLtHeWu+A+/sPfb
 eXdmeca/VYfyL15O27+dIKZJ0UDw5cD7ExYIslGxjvTM3lR1Oz/KDJWRHL0wRpawfR2m
 h28Far2oUqSXq3MwokYQPrF1SyzZFn8Bt4yT192KY9Tiz24r6acXCyDe29sCFAxAE/UE
 NNjQ==
X-Gm-Message-State: AFuF++lfh6+M6vBNxN2T/REJlM1ADJK5ZHB9O3dGoeA/lWjddf7L3FXi
 6ZOqIGvm/WyD2q0VRZ/cfFYWBxUFlS5JSyOYOi9GjOjYu12ZNbEfqWc5ybNt6yCll4eMT4iIX7g
 +aU24DH3BxlNVjygscKz1y1PUFccjeWURW1Qw9fTG3nsgXL5ATpe5NXMbM5XvK3zKwLCr
X-Gm-Gg: AYBFou2qpqLdEEHsy/zap383X/OYa3ah2Sew/kgsM9Id687Kn97ELeaSaW2AEu129tl
 ugoFUrKdAL7itEfK8pDQiCivwU/le6mlVBk/USaN63AY/ZxaVaPUOUbzRISmMiTGm2gQ0IRom9E
 CIC1RtvX6LlhyAQGUxYmoZKpeLtQHsa3T95RyOwoPsbOkiqD+n5pWwAihdRoLmx8HFos+VgV7sE
 wFjid0QS/MXQT9uU6PC0+OdDJBxa6luRg0sY9BPe8gsFRlJRhLNpOsslYMggArFKJDhqmqgLUol
 Xo0Zb1d+ErIQ/Pc8RsRS2QiZWjgxl2j0HWzUf0AU5kdUBoNkODfykQZz81jZpZW2DGt0++u2Noa
 7OvJW6fLojqe8YLzuzg2D+MMU6qLEN70INWwnB9yg
X-Received: by 2002:a05:620a:4805:b0:93e:9809:26d with SMTP id
 af79cd13be357-93e9b84eb25mr302278185a.69.1791366434661; 
 Wed, 07 Oct 2026 02:47:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4805:b0:93e:9809:26d with SMTP id
 af79cd13be357-93e9b84eb25mr302276785a.69.1791366434272; 
 Wed, 07 Oct 2026 02:47:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71c0b60fsm4454381f8f.8.2026.10.07.02.47.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:47:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 16/27] target/ppc: Register CPUClass::exception_name() handler
Date: Wed,  7 Oct 2026 11:45:04 +0200
Message-ID: <20261007094516.75732-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX/Jw9KGSf0wfu
 A1nBhUK/QivvNqAdsInIcCgSfv/4fNaW0wdVB/oW0LfQdjbBDEzDpe4u5PWBAvSpJM2iCHkjsBv
 Byhtz5RnwYDHvaILaBzBvZ5Qv5laIJI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX+i+5ZpCP0E7P
 gpjT++5Z8hnf/l8SKDGRxrHmIH0FQm+Gp+REOlR6ARFHr31Pf5QLxb78Os7nOOo3qwoofc5IfOd
 rYX/6MpOdXFM2AdGr/H68hWlbvgdoaQUFS1bxAO1586aLqfEthYgEB8Is+2/0cpqCESdVublzGM
 DBgL/akidyAtx4odPA3rKZK7rBS/LXb817rAvmwJQ+qfDVsxaaQDiM3McKb0QxnG6lFBVSTDoEM
 urTzqCOFzKrgXRYk45DChzf1ZRyONy1zQcwwMnQIVSvviKgOwL+7Wiu5MB7UE+ukhSjwL8STzHh
 KNmTzTFMvSDmClc17HiRPUG4vI3kEp5ZihWZFhGe/5r3CamlkhbP+vluPlUyJYD+Qfjj7G1cCHK
 jLD0JK7QZdbYvSuylwS5ZdxYsxNMaJaVkejj6dNGTI1BJ5MRP7ogFMzK/ti3pKlssNmClK17jbV
 j5bvkPeHJ6DZc3wfMow==
X-Proofpoint-GUID: whCM46T__Xq0WwnbcZ0KtUPeSUVZJKig
X-Proofpoint-ORIG-GUID: whCM46T__Xq0WwnbcZ0KtUPeSUVZJKig
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac61523 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=GQJXTKmK7mRzDcunaLEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Expose powerpc_excp_name() prototype and register it
as the CPUClass::exception_name() handler, so the common
exception logging can resolve PPC exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/ppc/cpu.h         | 2 ++
 target/ppc/cpu_init.c    | 1 +
 target/ppc/excp_helper.c | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb82..4eb7db3d727 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -153,6 +153,8 @@ enum {
     POWERPC_EXCP_SYSCALL_USER = 0x203, /* System call in user mode only      */
 };
 
+const char *powerpc_excp_name(int excp);
+
 /* Exceptions error codes                                                    */
 enum {
     /* Exception subtypes for POWERPC_EXCP_ALIGN                             */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b711f9c0a85..d5f9ac28020 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7529,6 +7529,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
+    cc->exception_name = powerpc_excp_name;
     cc->list_cpus = ppc_cpu_list;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 6d05b865058..ab7518363af 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -33,9 +33,8 @@
 
 /*****************************************************************************/
 /* Exception processing */
-#ifndef CONFIG_USER_ONLY
 
-static const char *powerpc_excp_name(int excp)
+const char *powerpc_excp_name(int excp)
 {
     switch (excp) {
     case POWERPC_EXCP_CRITICAL: return "CRITICAL";
@@ -105,6 +104,8 @@ static const char *powerpc_excp_name(int excp)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+
 static void dump_syscall(CPUPPCState *env)
 {
     qemu_log_mask(CPU_LOG_INT, "syscall r0=%016" PRIx64
-- 
2.55.0


