Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13540606A324
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n3ZVH+I+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIsWu-0007qe-A3; Mon, 19 Oct 2026 14:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIsWr-0007po-Cb
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:56:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIsWp-0000JO-8f
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:56:12 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFiRSQ018806; Mon, 19 Oct 2026 18:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q9V09zFHk1PvlLKWs
 M5WFGopCmm4gYe3kBwRMJq7X14=; b=n3ZVH+I+8J9RHDvawooa/gXXE/KeY2+f7
 6XZnfJz6nb0TAoxRwfTr/LPj0VMqZCFT3vB8VX5OGfEAmUoKiIgn8aF1c7V66/ql
 fWWjNUtWtm50uq4olfg0VvbXoVrSelwhMo4w3gJdYub7hQB4xWUUnHqzNOpmgMhz
 3In0Ra3uYjyM0QdElobV1mw+UzUkGp4EPi2iyZ7eYCROHVp+C1hl/bc26fII2XPL
 whnYd/8ELnBnUBN6WNdE+DShWiO5h13LTVXel6OerozzbBfxs5XIJcMdUU2e84oE
 UELGE/DoQag2kAvDspTPOpWqkBDRIFvaG2YiDDai3hBwXKj8SCf5A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvv5s1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 18:56:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFZ5XE3125152; Mon, 19 Oct 2026 18:56:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgxvrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 18:56:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JIu24N48169320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 18:56:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30EA720043;
 Mon, 19 Oct 2026 18:56:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01C9D2004E;
 Mon, 19 Oct 2026 18:56:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 19 Oct 2026 18:56:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id DAED61612ED; Mon, 19 Oct 2026 20:56:01 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 1/2] hw/i386: ELF endianness fixes
Date: Mon, 19 Oct 2026 20:55:59 +0200
Message-ID: <20261019185600.2031729-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019185600.2031729-1-farman@linux.ibm.com>
References: <20261019185600.2031729-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NCBTYWx0ZWRfXxE2gLhKYP5No
 5UhnwZiu0rP8C09W/8WNfCdaNz9qpJkrUD8mCHlxl7JNcKZjQJx3EbvNLMRkDEwYIU8NJGuAUl+
 JutHNaH5g4UCDF/LmL4V8zm+AokHfG0=
X-Proofpoint-ORIG-GUID: D88vyqtWG2Ms8Rh71gyVsWPv5QwPf041
X-Proofpoint-GUID: s46m0dQHkupqf5I-0B-Xa8hAP_3y3R37
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NCBTYWx0ZWRfX8eP2PYiPSfCW
 Umeiv4IKObVgu1YVYCyvPDGNBq8sw0cHHy0mrkMWhM5jAZs3mi/G2H/+CS7CZs+Ry5Z5aWqNyKb
 mjnNmaQkLwgf9bx8tpDlyyLMdwEuOm80/kmZsgwBwUhe4VsTSTIop0hADFlCAjb0Zh6JfuB24j/
 QMY6d74qxcVwFeDBmP1uoSJjPcHdb8aBH+Cw/5WHJtDGXTFznYP1DRmzAy1If0vAtWi1vqqA9T3
 sMd5f1FBIScBz7ySqwe6aAwkIqtsnXmFnp1EqA4X0ZmXIcDYPRRo1hOZzsQKCKDW3ZEzG4ElwFC
 KAfrcOQ5CyOICNBnTGPlBIgydxlnTUmm7L8Fo4vs2eVwS8QLLH1R2wiF1NRAdbHSpTTfggfeHeW
 hVDf16RjMnlt3msxcwe5DPT6pNQtKuh8Nk1WTDpenkkznfQgUL9qfHYSJk//bdSNRLzTcAgWaO5
 t/vhib+03htOoeJvdLA==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad667c9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8
 a=MllmpHxVhdK4irJ3L0sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Running make check-tcg-x86_64 on a big-endian host (e.g., s390x) fails du=
e
to problems reading/parsing the ELF data:

  qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF N=
ote

There already exists logic in include/hw/elf_ops.h.inc to handle byte-swa=
ps
where necessary, but it does not perform this logic for ELF notes itself.

Fixing that improves matters, but yields other errors: most of the tests
timeout while some generate confusing assertions. Both appear to be relat=
ed
to the data addresses in those notes, which are incorrect when running on=
 a
big-endian host.

Adding tswap wrappers, which will conditionally swap if the host and targ=
et
endianness don't match, fixes that such that check-tcg-x86_64 runs cleanl=
y
on an s390 host.

Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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
=20
+#include "exec/tswap.h"
+
 #ifdef CONFIG_XEN_EMU
 #include "hw/xen/xen.h"
 #include "hw/i386/kvm/xen_evtchn.h"
@@ -573,7 +575,7 @@ static uint64_t read_pvh_start_addr(void *arg1, void =
*arg2, bool is64)
             ((void *)nhdr64) + nhdr_size64 +
             QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
=20
-        pvh_start_addr =3D *elf_note_data_addr;
+        pvh_start_addr =3D tswap64(*elf_note_data_addr);
     } else {
         struct elf32_note *nhdr32 =3D (struct elf32_note *)arg1;
         uint32_t nhdr_size32 =3D sizeof(struct elf32_note);
@@ -584,7 +586,7 @@ static uint64_t read_pvh_start_addr(void *arg1, void =
*arg2, bool is64)
             ((void *)nhdr32) + nhdr_size32 +
             QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
=20
-        pvh_start_addr =3D *(uint32_t *)elf_note_data_addr;
+        pvh_start_addr =3D tswap32(*(uint32_t *)elf_note_data_addr);
     }
=20
     return pvh_start_addr;
diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
index 044e72de2a2..b4fc0b146f0 100644
--- a/include/hw/elf_ops.h.inc
+++ b/include/hw/elf_ops.h.inc
@@ -56,6 +56,13 @@ static void glue(bswap_rela, SZ)(struct elf_rela *rela=
)
     bswapSZs((elf_word *)&rela->r_addend);
 }
=20
+static void glue(bswap_note, SZ)(struct elf_note *note)
+{
+    bswap32s(&note->n_namesz);
+    bswap32s(&note->n_descsz);
+    bswap32s(&note->n_type);
+}
+
 static struct elf_shdr *glue(find_section, SZ)(struct elf_shdr *shdr_tab=
le,
                                                int n, int type)
 {
@@ -275,7 +282,8 @@ fail:
 static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhd=
r,
                                                     elf_word note_size,
                                                     elf_word phdr_align,
-                                                    elf_word elf_note_ty=
pe)
+                                                    elf_word elf_note_ty=
pe,
+                                                    int must_swab)
 {
     elf_word nhdr_size =3D sizeof(struct elf_note);
     elf_word elf_note_entry_offset =3D 0;
@@ -287,6 +295,10 @@ static struct elf_note *glue(get_elf_note_type, SZ)(=
struct elf_note *nhdr,
         return NULL;
     }
=20
+    if (must_swab) {
+        glue(bswap_note, SZ)(nhdr);
+    }
+
     note_type =3D nhdr->n_type;
     while (note_type !=3D elf_note_type) {
         nhdr_namesz =3D nhdr->n_namesz;
@@ -306,6 +318,9 @@ static struct elf_note *glue(get_elf_note_type, SZ)(s=
truct elf_note *nhdr,
=20
         /* skip to the next ELF Note entry */
         nhdr =3D (void *)nhdr + elf_note_entry_offset;
+        if (must_swab) {
+            glue(bswap_note, SZ)(nhdr);
+        }
         note_type =3D nhdr->n_type;
     }
=20
@@ -608,7 +623,8 @@ static ssize_t glue(load_elf, SZ)(const char *name, i=
nt fd,
             nhdr =3D (struct elf_note *)data;
             assert(translate_opaque !=3D NULL);
             nhdr =3D glue(get_elf_note_type, SZ)(nhdr, file_size, ph->p_=
align,
-                                               *(uint64_t *)translate_op=
aque);
+                                               *(uint64_t *)translate_op=
aque,
+                                               must_swab);
             if (nhdr !=3D NULL) {
                 elf_note_fn((void *)nhdr, (void *)&ph->p_align, SZ =3D=3D=
 64);
             }
--=20
2.53.0


