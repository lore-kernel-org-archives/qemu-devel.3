Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D6F606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D4HBAUM3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H/PIb4TN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI0U-0000h0-9q; Fri, 23 Oct 2026 12:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI01-0008IX-ML
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzz-0002ju-6L
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6Pl63000350
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MQOSlIhH5HaG4TUBGOkgZqSBCSIqYLvSsT7ISyBL5d0=; b=D4HBAUM3N04AnfaR
 K8YkUheSw6N9kb8ae8MEQt+yUTLn/dKI2ZttaZWRZI6o+LOn8LTagmz5INHs/low
 sI1SzEFjwcI1fH2V3TqzQjJ+tMaIAnZCloYxRCYa+0jDfsp97uoghB9+5yekjjzp
 EQJMWQuPGWYqV58N15pqphJCCuXxcHvuk40YTMbvCZAXLqWEEd4SeY2zULNwr+rL
 VCTr1flMstrmofixJOm8zjBvRT9tF8INZwM2KtJIpQZCvZNHLLiE/cuK89DsmMMg
 vPxroddTPFMJJvbwdT35MxrkeaG/aFGvXyT9P6umB39FF6XMSwtVsalUuPTZsnjS
 aJdiXQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0w9b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f33438950so242579085a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772405; x=1793377205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MQOSlIhH5HaG4TUBGOkgZqSBCSIqYLvSsT7ISyBL5d0=;
 b=H/PIb4TNMuDQ3XVVX5eaFOgUMntbouKqjEr4gSyfxA2+isPND5LQOWLPpNt433IVNo
 Lks4f597S4Yl1iyStafg1+g3qLNS90fux94A22CXGIPltDzrN62Msi0CPYJYZzwjxEiO
 H55FlgEBSwG0S2HRcVuf50sHfn+PzIAA6f7p1jLt/xa3lqAXjl0KIf5eoi+ldTzvurQJ
 uHdpkzNsdskp85XqmlTPQIROHgKir4/Jnn11IF6E5V9x1PkYgXZdBGocsB2Cm9EOuVu9
 EqzKUs1eNFuTew7g+CC516jjqpYSakukhTRFAK/PPS3G+fDcjzHL/NNjwj6vmItuFU+o
 A2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772405; x=1793377205;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MQOSlIhH5HaG4TUBGOkgZqSBCSIqYLvSsT7ISyBL5d0=;
 b=uvU2YJjaU1ANd7r7g9yy4wYVmGtQlFArjonMy5UJTf8GzJwlxm4A+NHp1osGWW29U+
 Ci3gRfqKUmFC70f/3mun+VOS73i1MitELpbSE25tpXzXcoPcJvOcqE5jwb8tOijJgNeM
 cae0mDZyR8ZVgIMY9zo5/YYQZVFSZGx9pzc5fdP/8Cu9jrPHV+0I3AwPeXWmGvsai0xA
 MPbjpjpvnmV76Jh+NDyqJoVkp6D/RAcoipmxcSEOe6w0tgFKCUJqPWphn4yt5aQ7xMzS
 8LNV0wIQb3D9pO3YUei9holQ2LLvZNA7ZdokHLLAJfBBGSQaLkScjVeL+0wdb8en7lC0
 MQoA==
X-Gm-Message-State: AFq9FYKz+6rsGKjdAN3HSvwHug6rwsqeZhuoCjUToxlma+QLwoBQ8p7x
 zLCu80acFkTjvtBMC653ztVvD4WC9vgYmSVuGNPQCd6JHKpIUNUPS11OomzrQ+YeIphlpKqyoau
 8a0CHFwIb2yQ0kYxsP+J0pwU9pBSc0D3Jfj8/b7yQLORJ/5ChY/o5m1Z6eDIY1Vxzg5oS
X-Gm-Gg: AYBFou1n7r6LW22G+K2RGEAsbnZagEm2exxawy8iVQkOFEWR86IZuMx4NwaR5Y7uEXc
 0GFGDeBsvuD58A/ghrUk2j3eRDNccZ2TcD3sUE9x0SYTwbrBknwudxJtc2BddKbix3IVD7cEhpb
 H/pqYn6D2PBlOzaYqs6FRg2YLPy62g3khglc2HtEcDHCjg+SkvpiAw5zd7wLg+4zyx20Zf3cU3R
 l+uaz7CsWA606HYwloL3tWh5+2Er5XCdYdKaObIQtvOkKaWKp9TOwqn0M2wNWhDe14pBgn+YvTV
 7eRyUmd/MMykbuTJfQVOofm/9ZXo1/nVMm+CtIva+fIxJbiJBHu5ZFpy+rVFgb00Ps9zAuA407P
 RBLL+A8NiOMHS8Hl1LkfLZvQDhUyq3ofZJyI6dgzw
X-Received: by 2002:a05:620a:4443:b0:939:5cd5:e243 with SMTP id
 af79cd13be357-93f6f54d441mr470542585a.6.1792772405295; 
 Fri, 23 Oct 2026 09:20:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4443:b0:939:5cd5:e243 with SMTP id
 af79cd13be357-93f6f54d441mr470537585a.6.1792772404796; 
 Fri, 23 Oct 2026 09:20:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312fc9caesm4288665e9.3.2026.10.23.09.20.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:20:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 54/83] target/avr: Convert to translate_for_debug
Date: Fri, 23 Oct 2026 18:13:02 +0200
Message-ID: <20261023161332.60153-55-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfXzpSl4mxq8esE
 ZtiN1LOiBf3BA7WCem+ZyBofeN1IJThTmH4/InmFIAzvZeZa4jiQ9vC5daZgyOGDpZw8YEByjYf
 GHr/ahwU0mwwwHWzPqz0GyPFhdHswYA2TK5p4IvnzPbUS+VL3ovI4NnE1Y9QiKPRnLt60LhTgFD
 vCufm10LOPuF2Bt5znpat6AHJAHOzix+qPa25mYV8pelHs5xyOpwQ8rpgh7KwiZupL6dLjW8vOI
 F3w0kH9Rk7l44K51IAbuapv6d74g6mpCiULZJ/CgaS6fL1MoM0dnA8FIfEsFvY8Em/vNNxL7ZQ1
 csQf0lW9ewJT+CGnm2anoFJwGYrBDMIcQnhiqajk1GKb/1Wp4SDyFre0b3ImtikMycAIOZ9J8aN
 6FWlFWCY646m3z5lJaCSFmcErAKTk/kKAagTqrK6f7scm3w/JWda+s3QD3XKvA69BNWn8froDPE
 wlDX+a+XBPrCMj/qLxw==
X-Proofpoint-GUID: ikxVgmyJ8iCjl6VRoDLFFYONC9_qavWN
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb8936 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZncIJZGNqlsG_wB1ppsA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ikxVgmyJ8iCjl6VRoDLFFYONC9_qavWN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX5TsgLJbiLSPC
 QK2XtU0gy2t5PqSxHE2t7xS4TRWIufuQELpvaA2pVDN2npxp4IpevJu5tu7ZJv4H0NJPHyI5Qid
 GP9EgJMhfgSLzOTSI58FtWieGudZfpw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

Convert avr to providing the translate_for_debug method rather than
the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261020122752.3651914-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/avr/cpu.h    |  3 ++-
 target/avr/cpu.c    |  2 +-
 target/avr/helper.c | 11 +++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index b1b5b637617..a98fa6ceadc 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -179,7 +179,8 @@ extern const struct VMStateDescription vms_avr_cpu;
 
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr avr_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool avr_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                 TranslateForDebugResult *result);
 int avr_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_print_insn(bfd_vma addr, disassemble_info *info);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 244871e5e63..83710f56518 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -234,7 +234,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
 static const struct SysemuCPUOps avr_sysemu_ops = {
     .has_work = avr_cpu_has_work,
-    .get_phys_addr_debug = avr_cpu_get_phys_addr_debug,
+    .translate_for_debug = avr_cpu_translate_for_debug,
 };
 
 static const TCGCPUOps avr_tcg_ops = {
diff --git a/target/avr/helper.c b/target/avr/helper.c
index f452c9d9040..8f90b8d9a45 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -108,9 +108,16 @@ void avr_cpu_do_interrupt(CPUState *cs)
     qemu_plugin_vcpu_interrupt_cb(cs, ret);
 }
 
-hwaddr avr_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool avr_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                 TranslateForDebugResult *result)
 {
-    return addr; /* I assume 1:1 address correspondence */
+    /* I assume 1:1 address correspondence */
+    *result = (TranslateForDebugResult) {
+        .physaddr = addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-- 
2.55.0


