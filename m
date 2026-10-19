Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB165606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R37rxlD+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqCm-0002ao-D5; Mon, 19 Oct 2026 12:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqCM-0002Fb-Hm; Mon, 19 Oct 2026 12:26:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqCC-0001UN-8a; Mon, 19 Oct 2026 12:26:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFiCwM006330; Mon, 19 Oct 2026 16:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xADp2Ssvv2t4fnFKS
 1R2JvkoCpkDDw0qXSxMDua+T9s=; b=R37rxlD+SFpZQz58Bjh7JiJrKolpR2KI6
 Vr3MHnNhOdPJ712UVdoogg3vco97K2lr5rKok8FVuwT/lOnOTTW95Z7YQ4HHyzkg
 aSlJ/mNsTVwOvFq8r1iGUZOzoLTsm1qlZcIoqehmqqLIcxyPRlHESQpnK254Fb76
 iLsuwSRdHo/nv52zMxJ9Owc6sl6NiUyt1UK/gJjUxeXLAI9zhwNAqy2kkiokxfER
 G86V791uaB5EvIB0hksNX+FP6vHvc5qMCH/rUbLX+4I0AY9B+QU24u0Nm8m5Gt0q
 rpeUrM09nqPEvHmd8wBBUnpROVWyA/QUXBvxcTW0fYJvM/dyrE9dg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7mbf0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFo6hB122115; Mon, 19 Oct 2026 16:26:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqvekq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JGQLFI32047442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 16:26:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68B6E20040;
 Mon, 19 Oct 2026 16:26:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9678B2004D;
 Mon, 19 Oct 2026 16:26:17 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 16:26:17 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Sourabh Bhat <sbhat@linux.ibm.com>, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, Sourabh Jain <sourabhjain@linux.ibm.com>,
 adityag@linux.ibm.com, nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com
Subject: [PATCH v6 4/6] ppc/spapr: Advertise RTAS error injection call support
 via FDT property
Date: Mon, 19 Oct 2026 21:55:38 +0530
Message-ID: <20261019162541.68440-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
References: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfX5/aYpRYuZlnq
 +Tp87RExIyFBvRuweNngR5Y+Jb4iw93gD0YWH8QiZrXyTkH77GGhSjgwX/EdU73cv9cJdEEJqxr
 og4RBqlkCHSUWoac9ren1dSVM1wVryA=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad644b4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=llslmTbBPWc8O3lW6jAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfX6Ka8+NpKmi4B
 TsHW3rxgex59siw4TvZMCUrebVJOFs4S0OFDOckl/zOknZl/U6RyP1Gwf5oYKreUdiRuuEaMBGd
 mfOnLgJatd08SS3WpkEmw7aygqg5LcoZI8M7NePPDHAfbuVuHoPVJeoGt8BksjQHpL37LyiK/yD
 1Nz5JyEQ1be0chS3qv3V4yXlNZBVXP5am1e/u7L6OSI6NNb32b1noBjcZng7o4WfNmpwP5E8zRb
 mKx97lvI4xdHiAQL+3yOkO1ckBt78z+034vVeMv+KOsJ8WzAr5rngY1QhllTwG/VzvmJgwWkmAo
 lbuqoXb0vbGWadbTGmahglHnUoK6qeGNMuYFbqKZ6FSNtrGuGzbO2wCK/qxL8CVwXgrOH+TSXhv
 Vq9XdSZTAIc7H4VaAyFw73zcgx56rMKO8IR5OeEJ0ahj2SWxJlzQI/LsaAKK5UZYdDsoNu8lSpn
 uSbknKhV3mdzH41MLEQ==
X-Proofpoint-GUID: thkxDJhto16AmHjOqLqyUoQ7GwyW5aeQ
X-Proofpoint-ORIG-GUID: 6-4-rKNzS3vkUaneI0I7P3K1_UgdaMTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Advertise the supported ibm,errinjct token types to the guest through
the "ibm,errinjct-tokens" property under the RTAS node in the device
tree.

The property blob is built directly from a QEMU-side static table.
No host /proc/device-tree/rtas/ibm,errinjct-tokens probing is done
QEMU presents the same token set regardless of the host platform,
which avoids host-specific dependencies.

Each entry in the blob is a NUL-terminated token name string followed
by a big-endian uint32 type value, matching the PAPR specification for
ibm,errinjct-tokens.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
---
 hw/ppc/spapr.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6d99464486..22724d6afd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -116,6 +116,8 @@
 
 #define PHANDLE_INTC            0x00001111
 
+#define ERRINJCT_BLOB_MAX       512
+
 /* These two functions implement the VCPU id numbering: one to compute them
  * all and one to identify thread 0 of a VCORE. Any change to the first one
  * is likely to have an impact on the second one, so let's keep them close.
@@ -1081,6 +1083,61 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
      */
     _FDT(fdt_setprop(fdt, rtas, "ibm,extended-os-term", NULL, 0));
 
+    /*
+     * Advertise supported ibm,errinjct token types to the guest via the
+     * "ibm,errinjct-tokens" RTAS FDT property.  The blob is built locally
+     * from the QEMU-side token table; no /proc/device-tree probing is done.
+     * Each entry is: NUL-terminated name string || big-endian uint32 type.
+     */
+    {
+        static const struct {
+            const char *name;
+            uint32_t type;
+        } tok_table[] = {
+            { "recovered-special-event",
+              RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT },
+            { "corrupted-page",     RTAS_ERR_TYPE_CORRUPTED_PAGE          },
+            { "ioa-bus-error",      RTAS_ERR_TYPE_IOA_BUS_ERROR           },
+            { "corrupted-dcache-start",
+              RTAS_ERR_TYPE_CORRUPTED_DCACHE_START  },
+            { "corrupted-dcache-end",
+              RTAS_ERR_TYPE_CORRUPTED_DCACHE_END    },
+            { "corrupted-icache-start",
+              RTAS_ERR_TYPE_CORRUPTED_ICACHE_START  },
+            { "corrupted-icache-end",
+              RTAS_ERR_TYPE_CORRUPTED_ICACHE_END    },
+            { "corrupted-tlb-start",
+              RTAS_ERR_TYPE_CORRUPTED_TLB_START     },
+            { "corrupted-tlb-end",  RTAS_ERR_TYPE_CORRUPTED_TLB_END       },
+            { "ioa-bus-error-64",   RTAS_ERR_TYPE_IOA_BUS_ERROR_64        },
+        };
+        g_autofree char *errinject_tokens = NULL;
+        uint8_t blob[ERRINJCT_BLOB_MAX];
+        size_t blen = 0;
+        bool ok = true;
+
+        for (int i = 0; i < G_N_ELEMENTS(tok_table) && ok; i++) {
+            size_t slen = strlen(tok_table[i].name) + 1;
+            uint32_t be_type;
+
+            if (blen + slen + sizeof(be_type) > ERRINJCT_BLOB_MAX) {
+                ok = false;
+                break;
+            }
+            memcpy(blob + blen, tok_table[i].name, slen);
+            blen += slen;
+            be_type = cpu_to_be32(tok_table[i].type);
+            memcpy(blob + blen, &be_type, sizeof(be_type));
+            blen += sizeof(be_type);
+        }
+
+        if (ok) {
+            errinject_tokens = g_memdup2(blob, blen);
+            _FDT(fdt_setprop(fdt, rtas, "ibm,errinjct-tokens",
+                             errinject_tokens, blen));
+        }
+    }
+
     _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
                      lrdr_capacity, sizeof(lrdr_capacity)));
 
-- 
2.51.1


