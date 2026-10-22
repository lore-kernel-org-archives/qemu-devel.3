Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5642606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lO8j/2i4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KJVieSus
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0qG-0004Yd-DN; Thu, 22 Oct 2026 18:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0ps-0004CZ-Vl
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:00:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0pq-0000zu-9A
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:00:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MLQ7V2807480
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 22:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=a2thX2PPQcI
 DoRjwKKl55TKeLlopmGcr4cpnXWmS300=; b=lO8j/2i4sTVohzXwxje19NtaEZ4
 8H9P2jn4gYSyMGH3jeSblgrKe4PBVCzszk8fGAV89j5L1wtQBRDQP/x30pQxOi3m
 ipR2aH7z3+kjSIqUAOHfRmjEAw3Pt3ja4uoINhPvMLvM3o6b8JSfoktwRDMgwIos
 Kx6Z3G+Y1sKMWiIcebnSeq5egD8PZLP7X9wcLHWEQH6D0W8YDJx2rGx/9H2ccJbp
 EbFTQ8GYzmVRRl7XE+sqCEsPq2EiAucorMbOkG6I0hLw7TI48E4eM/9ktUiq0Our
 xTh00KtW0IOivHtePcIR2ng22F+QOWqlP9Kgh6KGXNX5cQdkkgR17rQfH7A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw18c8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 22:00:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3aca98f01c1so212257a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706399; x=1793311199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a2thX2PPQcIDoRjwKKl55TKeLlopmGcr4cpnXWmS300=;
 b=KJVieSussAmxl4Jsb6XW2QE+yS0PbECocOMX9Khn9L87Ix/z1BPPPV5KW4mEEUyhZN
 7CFFimFY8VwCM9kXyFLo9fqrlx0kFnnqOnmwsNc6nFeW63k1V11niiLY16YsfWWFrRMc
 qEZfPO1AE9MxbyQ5cGc2rSkZDQxS9JWH2gzHgckS7fIcBawlls0hCK9pr06dH3470d6l
 Ikcl0uZEcBORPsQywsYuXZjRxaoco6RAmqfHjWsr482zNTbTsCLItXqErIxCwP1ZmoGt
 AJNMPBWgzm0NuRIGeRy4VFUvhHpcbUf9XVt+XoyLQmtVtnxgVa5rKaU0kXiP6v6Thzw6
 ucxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706399; x=1793311199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a2thX2PPQcIDoRjwKKl55TKeLlopmGcr4cpnXWmS300=;
 b=RQjcIFc6N42f5aWrwgD7qBklLhFo+EBVTdLDmiNLBLMgEI1+4+tbP9onArX9dA02GE
 1NSrMlpusGAjekQXojClrj060DTYojFKFObhyC5/Qj6P9qvklxMly4+IyYt2vZcat0iw
 yCLHxCfCfD7Cf4w3DNJ4/K0+PItDUUiwE5yE2MBhN+Ubqu0t3wrZEIfpVERkzIeWaKTi
 Wxflbl4AsaTJFD68rLGRoZaExKl7wjRbC28sA9oZ3RegayGU91xVZkXYHW65K6oLtos3
 PnkA7fbrbI3fqngiiYeAp6KJKTsETyP6n0/7zUXjmsVbwLwx9vUeCuumkVxf33duZABp
 z3vQ==
X-Gm-Message-State: AFq9FYKhMr0w0cgj/gop2XtaSaM/KKTS5+MjnlyeVqMDk8KT53eFGKHp
 /Mrot6nDC+ZoCU3rvlhXAfMbHqUWn+edHrqBH2761pMfhhPS1jUd/7au/7GAsu7NigIQsnDQJIH
 IGSQ0HK3eoLNgTqe6C+8i/hWm+nQjJhxdRLZ+cuna5XlrEp8PkW49DocVcxDDYIMGKQ==
X-Gm-Gg: AYBFou0gCAguPWwRA706VN/LAqd82pMZ2KB5/zEWCIeRwzN8atIFnu/uHROo0QQS0LU
 WAUb6W6gO4vsAzvDt9susaQlbgbWPbwtjTs2ARb9o7V6AlJO+wU4DW6CqbjKYF+YLcfUQZGykEw
 ASV0uWjWcDaYKnYE96GOoA/ZrssLCrMxHYDaQSdbkuFRLRF4JlRAJM7jBUz7be5OCpnWE7D0mm/
 saD7FJ06SKo6MdW+3JB+Hbmy/ndeRJMDVjTnpX7VVmDEnePjNJn3qpFU+AWj4JoZJ8IYg/Z3AyD
 ZeBEdrXqzg8O7rEn0BGx0NajxlrV+xrKCuWbyqk5TL1OnWQkSIw/3sj5LI6xnTfD/JXaEuLPS80
 vQFGYZMqMWbVJNhinVyhzKIClHzhfZsTLjPNW14/OfXzS4YDq9n5BMdBXptFBbjY=
X-Received: by 2002:a17:90b:4e87:b0:3ac:450a:fa22 with SMTP id
 98e67ed59e1d1-3adcdc9e567mr198168a91.2.1792706399435; 
 Thu, 22 Oct 2026 14:59:59 -0700 (PDT)
X-Received: by 2002:a17:90b:4e87:b0:3ac:450a:fa22 with SMTP id
 98e67ed59e1d1-3adcdc9e567mr198156a91.2.1792706398934; 
 Thu, 22 Oct 2026 14:59:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adcb1b167fsm596875a91.9.2026.10.22.14.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:59:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/2] hw/i386: ELF endianness fixes
Date: Thu, 22 Oct 2026 14:59:53 -0700
Message-ID: <20261022215954.2482681-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215954.2482681-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215954.2482681-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nEUB2bixqdByIxD2XirwEERlGxTOP1mw
X-Proofpoint-ORIG-GUID: nEUB2bixqdByIxD2XirwEERlGxTOP1mw
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada8760 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=MllmpHxVhdK4irJ3L0sA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXwcxPCAMuySId
 zWjntvPW4dS4D5GqJiu6CjFQAqLsreqX7Jg6a42s7zNg9wK72GuIAkIgpEk19JvVon6Lc0QrkUD
 uSpH8fF+eCeal1cet4q5x2Lza/SAlJE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX9m+mx+X9NjdS
 R8gdvb5brh1IXuopB/SPt56mVybagkT/crogLlZEAuiP7hGV4wH/OO69NH4QnISBZde6e86nrju
 Q61hA5Lb52cKb6uN0lo6qr5SNOeh1gy2rvgIhRMQ1PkjTtWISpoPINkyzI8coTYkm2YsGY0Pl7I
 lSxW3cx7MfRsPyahezeSoNNTwV0vKErxpqRzwqNg1i1Kr31pOZ4192HcK4WsyW5b6r+rz73fXf2
 BcPXNt1H4mtRlfbYXKs7drGFCfevr/x9q1uUIKNJx8KYVsHs9Rj5W9w9KSeCLC5yhBQRs+ccEYJ
 TRM9oZzl3yua2x/obK0cYqAJw+YoVy++XK9B9BqVXnI7iQ9E+uCpJahP5WRoWMRiFlsOMyh2fS9
 s1ngu/8+Up1vvMLZTDyXvOTxpTQAWR1mWoVze+xr8ZseY5MhFeQc9vwzs+mDqdQkmGn46lE7/1j
 FxHYAEuz1e529ur6bqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

From: Eric Farman <farman@linux.ibm.com>

Running make check-tcg-x86_64 on a big-endian host (e.g., s390x) fails due
to problems reading/parsing the ELF data:

  qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note

There already exists logic in include/hw/elf_ops.h.inc to handle byte-swaps
where necessary, but it does not perform this logic for ELF notes itself.

Fixing that improves matters, but yields other errors: most of the tests
timeout while some generate confusing assertions. Both appear to be related
to the data addresses in those notes, which are incorrect when running on a
big-endian host.

Adding tswap wrappers, which will conditionally swap if the host and target
endianness don't match, fixes that such that check-tcg-x86_64 runs cleanly
on an s390 host.

Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261019185600.2031729-2-farman@linux.ibm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/i386/x86-common.c     |  6 ++++--
 include/hw/elf_ops.h.inc | 20 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index fa18bf1aece..dcd4fa8eb79 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -45,6 +45,8 @@
 #include "kvm/kvm_i386.h"
 #include "kvm/tdx.h"
 
+#include "exec/tswap.h"
+
 #ifdef CONFIG_XEN_EMU
 #include "hw/xen/xen.h"
 #include "hw/i386/kvm/xen_evtchn.h"
@@ -573,7 +575,7 @@ static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
             ((void *)nhdr64) + nhdr_size64 +
             QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
 
-        pvh_start_addr = *elf_note_data_addr;
+        pvh_start_addr = tswap64(*elf_note_data_addr);
     } else {
         struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
         uint32_t nhdr_size32 = sizeof(struct elf32_note);
@@ -584,7 +586,7 @@ static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
             ((void *)nhdr32) + nhdr_size32 +
             QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
 
-        pvh_start_addr = *(uint32_t *)elf_note_data_addr;
+        pvh_start_addr = tswap32(*(uint32_t *)elf_note_data_addr);
     }
 
     return pvh_start_addr;
diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
index 044e72de2a2..b4fc0b146f0 100644
--- a/include/hw/elf_ops.h.inc
+++ b/include/hw/elf_ops.h.inc
@@ -56,6 +56,13 @@ static void glue(bswap_rela, SZ)(struct elf_rela *rela)
     bswapSZs((elf_word *)&rela->r_addend);
 }
 
+static void glue(bswap_note, SZ)(struct elf_note *note)
+{
+    bswap32s(&note->n_namesz);
+    bswap32s(&note->n_descsz);
+    bswap32s(&note->n_type);
+}
+
 static struct elf_shdr *glue(find_section, SZ)(struct elf_shdr *shdr_table,
                                                int n, int type)
 {
@@ -275,7 +282,8 @@ fail:
 static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhdr,
                                                     elf_word note_size,
                                                     elf_word phdr_align,
-                                                    elf_word elf_note_type)
+                                                    elf_word elf_note_type,
+                                                    int must_swab)
 {
     elf_word nhdr_size = sizeof(struct elf_note);
     elf_word elf_note_entry_offset = 0;
@@ -287,6 +295,10 @@ static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhdr,
         return NULL;
     }
 
+    if (must_swab) {
+        glue(bswap_note, SZ)(nhdr);
+    }
+
     note_type = nhdr->n_type;
     while (note_type != elf_note_type) {
         nhdr_namesz = nhdr->n_namesz;
@@ -306,6 +318,9 @@ static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhdr,
 
         /* skip to the next ELF Note entry */
         nhdr = (void *)nhdr + elf_note_entry_offset;
+        if (must_swab) {
+            glue(bswap_note, SZ)(nhdr);
+        }
         note_type = nhdr->n_type;
     }
 
@@ -608,7 +623,8 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             nhdr = (struct elf_note *)data;
             assert(translate_opaque != NULL);
             nhdr = glue(get_elf_note_type, SZ)(nhdr, file_size, ph->p_align,
-                                               *(uint64_t *)translate_opaque);
+                                               *(uint64_t *)translate_opaque,
+                                               must_swab);
             if (nhdr != NULL) {
                 elf_note_fn((void *)nhdr, (void *)&ph->p_align, SZ == 64);
             }
-- 
2.47.3


