Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F8606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p7HSdXhi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kf0PAuVq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoT-0004Ta-Gb; Wed, 21 Oct 2026 14:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoR-0004T9-HT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoQ-00084j-0E
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpMTd791150
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M8UuXxhSXXjnNdpJ0Gfsf68nKuzHyB0D4qkHeAp5mb4=; b=p7HSdXhidtrUli6R
 nrMXp6MQvV7gaz9VDx1X8Gds4VJ7yTbydual7l5Ol2p7vv/WYnfw5Z1lWvmYwN7p
 c+NGv+nR/W/jI1/P1KD97SnfwuaTDinmbHzKzCx9HgUjVceikRODtYY4m7cOZxE9
 V2dMTDhvBemtv79zub61DMvgi1Tcit+RgiLucUBycSVmiqhlR11ET/lwsgVcXiDG
 6mHFiLjzlUc5P9n5TBbchIfV5iV7d6efaW0Rye5xLxwZl51Pq3pIDUNfafPLo+ON
 YOUgoQ4+Vh2IhleXwN0LhwolF5mOywFZ/iFJqf+/NxkiflhoXY1+lolfAO1ZaU9q
 TCnwug==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv0n0j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac76132001so836660a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606386; x=1793211186; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M8UuXxhSXXjnNdpJ0Gfsf68nKuzHyB0D4qkHeAp5mb4=;
 b=kf0PAuVqTu4joIxw/OIA/QHGdHIqbPeNwhkEkQzG7C0Gk2rmlSIsAjmzFjkumW/qnA
 +VnDAZ4P+ZAYjSQjk0ePlUwGBCcqiNsYkzgjZUDwgzq88pdD1G07d/8dWPvrU8B20czw
 ig48que/vWpKYQBKyCTgZZVN0kCdrCVV/uLIpNX9oSNp/PvP7XJ5e/UzlI7PDkCXXqG+
 m2mwDC0blIB1leuMvP06tiKKBAHfYK4xl4LVcex6TeGNYSVG0dThwB0u3anR1MCfIBNI
 b8QraQeTm8mCpaUCX/NqFFpfAvFnhEZ3jCpPvYqBKmsFLM4HE6hL3S3Xmc0nkBx3sxzW
 bZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606386; x=1793211186;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M8UuXxhSXXjnNdpJ0Gfsf68nKuzHyB0D4qkHeAp5mb4=;
 b=jfFNAcYx9MrjIjqLdPB7MSGR0Xa3waxVIgGnyv6aIt+jnwkqFs6W3GuQDrdjnwcNDy
 WiHfx13GQ+6tUeFxLSuc3vz8sFaSxjjOgpq7qT5+trdrxbblEWvImcChJcl/rTzjjh9a
 LokqjmczIwdYmXCC7IUUiiAA83GKhgXCKPLdlLED7C80gEkWbaU7yS39qJXfXCWOyf5Z
 Imqfkei2bFetv+soJKHtvLV7jBFhAoXyrsG99ytsP/zcR6RTnI0mTW+fPoev2dU8F4RK
 0/bo9dXpoHBD74Dmnceqfn6gX3wH7YML03HT+Qq+9flNTFUxRvHA+/8NzzS4uih5NJP2
 tR5A==
X-Gm-Message-State: AFq9FYKi4yFWh0YoGCmXllLU7OHJSB/9mo8W1sCO2o2UZwToC4e+N9BJ
 FHSmB6bWqu7BK8y9PvBDf9fzWPDPkJjMs++lIKap4ncu1+I6CsU8TclpcYbe9bzhQQ99aZNLlMP
 uS6hj0JJXG1PWsjqYGZOEqe5w0gVtmgJimie/GynCIsvEVvu7vhspP61H7tPdAk1c6Q==
X-Gm-Gg: AYBFou0fcmIhYv8poz5f3gpnSa8qj3VX2mnOKTrMc6cLno8ZqoKCz0Pxz62RPx+2ZZq
 iVAJ95DwgP9vkVs/rpilrxUe8/fPuDOCjlDt/BhH4+CwfKuWOjWjDcByvH9BWq8vjOfhPkYp13d
 HGogNeQr3NS7Wc7OpgjzwD2FglBcdK82csjrtF8KN6gKJ8AFZGYxesC2IjZ6sfFtWE9EMo2+RGg
 YjUymd5XbPjiB6IFca4faUk8EYOxu7Tr7m5yXF4wKSdmoDdFeQ6JUlpANhMQxnUnQpm/ATfTw7n
 lF/um0f+vBx6zXnt2AvWbl2Amo14lHTFwfD+uelSh1dpSiJkTqrwkFpBghyLxsngkyiYLh01EGJ
 EVMetSlEAzoXmkW2lgO102g+AlTQaS2T69iL/pYahAMjL5FvGrf56D//o0FS1i0M=
X-Received: by 2002:a17:90b:4d06:b0:3ac:9e76:aa93 with SMTP id
 98e67ed59e1d1-3ad86dbc0c6mr2025129a91.7.1792606385932; 
 Wed, 21 Oct 2026 11:13:05 -0700 (PDT)
X-Received: by 2002:a17:90b:4d06:b0:3ac:9e76:aa93 with SMTP id
 98e67ed59e1d1-3ad86dbc0c6mr2025115a91.7.1792606385424; 
 Wed, 21 Oct 2026 11:13:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:13:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 18/21] target/riscv: implement get_note_size sysemu op
Date: Wed, 21 Oct 2026 11:12:41 -0700
Message-ID: <20261021181244.867840-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad900b2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=WHTxxU84TY79vzyxHH8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: PT6QiJv_a-Pnt2yjtse0JMRMvYyc2oeK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX3N4Xhx5b45bB
 ujNb8XlzV3iQDni5VXSegNioJEWHK1aUY4r9rDTWLtysjRBu5U+Vap2Nd8KlbbhdhkeZb3rbJM8
 /7l54rt/dlqn3t0I02zTRl87O9wujJ4=
X-Proofpoint-GUID: PT6QiJv_a-Pnt2yjtse0JMRMvYyc2oeK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX9uklg/+nZUgJ
 fp4mxiCbCC6CG7yvrurCTSHLgNSc1Ig1+MlYUE5p4JLLAOMrQ/X1NMwEl4u/8B+cRkWpI84pxiu
 xls9ZeBlFO5S1EPwTqhfAjBH766tY2wGAyo6Fsq9RNS0eG9HPI/LUxSBsVbtiI7gjVxF6lVQS1o
 NLqOyuiVZpG9m4Z/MI6eHMKp0xdQyp1SUQH/298xQYgr9KDvHtAhfgESl1kxCK9eGF6RxEJtT2y
 umwP7GuGQscBSUzeZhnREOqmeivhoazEAEbn2tafLb1Ew12U6z2BU8+fY9Rfy2pYb6oX55mGe0w
 BQ+KXOcCTs3k8997SJMytR/6tSYMQorZxPmwvuikUaY9z9aAePP4TAOXNpgPOmq6G/jMI81e+S0
 biPGgVLCyzpYvBjYoPJRISEeMEkXDWjLNpAH37f+U6PkraleofAaCtvv3e8OXGEckDu9FktlmIi
 8ycPM50YgqJgEwTvpQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
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

For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/arch_dump.c | 8 +++++++-
 target/riscv/cpu.c       | 1 +
 target/riscv/internals.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 578435941de..06b66a56855 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -180,7 +180,8 @@ void riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                      ELFDATA2MSB : ELFDATA2LSB;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+size_t riscv_get_note_size(const CPUState *cs, int class, int machine,
+                           int nr_cpus)
 {
     size_t note_size;
 
@@ -192,3 +193,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return riscv_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059aee855df..b202a4eb6ea 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3105,6 +3105,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
     .get_dump_info = riscv_get_dump_info,
+    .get_note_size = riscv_get_note_size,
     .legacy_vmsd = &vmstate_riscv_cpu,
 #ifdef CONFIG_TCG
     .translate_for_debug = riscv_cpu_translate_for_debug,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index d2993842a32..9f1dec6748f 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -209,6 +209,8 @@ bool riscv_cpu_has_work(CPUState *cs);
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
 void riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                          const GuestPhysBlockList *guest_phys_blocks);
+size_t riscv_get_note_size(const CPUState *cs, int class, int machine,
+                           int nr_cpus);
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.47.3


