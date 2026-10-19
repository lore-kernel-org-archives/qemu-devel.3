Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D2609B66A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zs4377or
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIp2x-0006pV-BM; Mon, 19 Oct 2026 11:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIp2d-0006ht-Ru; Mon, 19 Oct 2026 11:12:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIp2a-0002W2-AV; Mon, 19 Oct 2026 11:12:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JEEKZp2316702; Mon, 19 Oct 2026 15:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VS0DLcY/4N97K+zZm
 iS08wE3tvxfgAgaCzjKdjWi3LQ=; b=Zs4377ory6WzPwIZ57wKh5gLqC3CK2nl8
 HZApfNFPLjuIl2B2ibjvrK52EF0s0kg84a5qAxuufYd9iKEn0Ah0jhl39s/RX5N4
 NYFWka+c/zer3mcYiee3/KmbbFPeycy3g0uvRxHxjNHjCJt+7ySKsiU2Ke3W6VK2
 frTvD8FYkNtM7GwcjdsZsXcNyZHwE866KNQ5pm9tAPfaOo2ljv2Q+2s0Mn8QTtmB
 TTFFQp61dZo1W76jCYPqrAkm6rk7dwaepJtlkPk8lDsvJW62NSCZBshP5f5g7r+y
 +0/d/2YXAO9Z7A3KL0RHFQzeNmmFd+MkpIjZZICEo+0rbPAjRIHNg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0ptky6w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:12:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JE55k74174428; Mon, 19 Oct 2026 15:12:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjx7d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:12:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JFCZkT17629556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 15:12:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 429B22004E;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1748E2004B;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id F28A9160AD8; Mon, 19 Oct 2026 17:12:34 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 1/4] hw/i386: ELF endianness fixes
Date: Mon, 19 Oct 2026 17:12:28 +0200
Message-ID: <20261019151233.230172-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019151233.230172-1-farman@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX+vLbAUhQ/zE3
 wwIzIROoI66gD2zvnXoqRJTmhZLdcwqAaa8h8RwxtiFIESl9IXcgE2PZUPlDbaU+GVd2XDbeoA5
 SrGR8GfUiLsmo+fiJeyL3gu/03lpvs+hPoXSxJOV1w/TbgfW43p6sTdHaGFn0GnGAo9EnzXPIxB
 jNLqsz42VdxGYDrCxVYyvBFJB975G7ymILmkUDXHuIQoKj67xbgind41hXH/a3qR4h3pQNYaGQE
 wwXq1VLGvydsu+w3RaKYD7T6XqQoHt5jNCS6rEtq49iFfWhGl7uZtdWWceljcApfixtkLnRM8Ev
 6fb4GY3vNuHZq4p1S10eApUDWkOc6Z9dvhcu9j76SaKm1Pyv3NXshw+OPNtNN9Nwa4zTiK8r8GN
 4l86n0uDkG8K+1YsjFYCvsKaXRA1tO1Yg9nrFQ2haCC5U8KqMN9MFZpRqjvcEi7dPv66AcURZ7N
 KLK07MU+aIdrqUDMlCQ==
X-Authority-Analysis: v=2.4 cv=WNvqzXsR c=1 sm=1 tr=0 ts=6ad63369 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=MllmpHxVhdK4irJ3L0sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX/xYltkNBkn5A
 SUc71DsSVZ4jEImXBfYCEfHbYwuu5e5WzJdGrYZRvnliGKwfiEHAOB+t3mV+0D7uI5hYULTETTN
 uau8xPAZ/1tbpxFe+2LGyL18fnDg5Oc=
X-Proofpoint-GUID: xvzm2eZbAz5t3iIsVv-g9mKsDyxnaqfv
X-Proofpoint-ORIG-GUID: ZsSsmfOook0Wda2G3quyP87lFZ7iKDA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190058
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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


