Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A4EC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Adu-0003JU-4K; Thu, 03 Sep 2026 12:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2Ads-0003Ip-IF; Thu, 03 Sep 2026 12:50:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2Adq-0006kB-8a; Thu, 03 Sep 2026 12:50:24 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2QaL3425618; Thu, 3 Sep 2026 16:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=JB29K/kIFaXz9XpFpYD+6df8lbdPcO
 9pcu50JVzlBPc=; b=O6g2xJTD9KCrWQvxtJ4sU4EPY/i73W1yf10i/R10S1+FR+
 6q1TSbtfz85s5Y5g4WgmMQl9XH7dSDdHd7IzQFgWDLYD+dpJRee0pL0h60KH+eks
 Jzc7Po6y9phhFE9rb6YWS7C4N+uC9hOiRPOwH6Ukkuq6pKdgRTVIbPirMeSVasC8
 +sO/IB6jGllQvVclJZTG590M1hgYMespDTc7uzRCaWIvM3wxe8/CIv7g88bAWAUr
 sSZbLRv7FZe2C9DflELINAvMkHNJH8DmUw9r4WTz5WafHfn5iSAyybxK3RiWJVYd
 bkuLXy/45zel3111BzgSfVxrZbm+WQ3c2u0wY8zQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq5561rb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:50:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GfGjn003012;
 Thu, 3 Sep 2026 16:50:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hrfv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:50:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683Go9xT8651458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:50:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3DF558045;
 Thu,  3 Sep 2026 16:50:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B4D658052;
 Thu,  3 Sep 2026 16:50:07 +0000 (GMT)
Received: from [9.10.80.39] (unknown [9.10.80.39])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:50:07 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------W4xTBoqsCBjW2G5fCUnKupfB"
Message-ID: <7e4f5e0f-462a-4dae-aa58-cdb81545f934@linux.ibm.com>
Date: Thu, 3 Sep 2026 11:50:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] pnv/phb5: Implement IODA PCT table
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, chalapathi.v@linux.ibm.com,
 calebs@linux.ibm.com, milesg@linux.ibm.com, jishnuvw@linux.ibm.com,
 adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-9-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-9-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfXyrZC72suPe0V
 jP1HoblcEyq/kgenjJz1rpMk2zylPv7HDN0fn6zT1KTEV3Fr/lUgoKwLBuyujLcyyXcgvJYC87s
 +uflqmKHlvodhJu4mvimRJsez6gq2W/AEIMKhul7pK7ZdyvQOJltXGM6UDlx9N/dzJhTUtxZ3NC
 s21chRZjqloNVUbcAzRmC7sHlCkNCULX8SRKflYuIgDFJLLhihz16OZ6Lq1DfyRhafDakBf36CL
 idRZevAefYsbg+oyfhcF9PbVngUqxRSJPVFdfqjzkqzEXgdTdPyAVRsXv6Qt0Hyrh09HHVE1K9f
 t6pLfvaCuGhN/hOT3jFWBM2Bxz/z7JnIWQ7mAFSxZh2xGJsIuCiCTpRwOwIoKIZbuNGMyHmv9vA
 fmx+sd0WiX0qZohRyQsvf94nbeEc/XwGfLLhrWBQs6b+ZqJEcqjxaygYJ9BPmvi2HOcksVqQFsH
 IbFWPu7GmbHyeUwx+Zw==
X-Proofpoint-ORIG-GUID: w2qTG4szFumfXCBE6GXN021_vb4Ja_ZM
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a99a543 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=CQXPn_koWp7IErjzBrgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgsLwUnGCMBw8fX4dgEA:9 a=u6yHql4XC96yPjzb:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: hsqGhTbKGecK_mhANzuNyCNxBiEuvi-s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfXyTctyTwWGzk7
 8bTLGRL52dHfLDGXvkWi2n+HZL/JSGOV9oECzAfDb69rvJCwVIDitKRtsyAfuhW9nLmb/pRTQSf
 A2VojdGumReI/epYmk98G0DI1IvhZ+0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------W4xTBoqsCBjW2G5fCUnKupfB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 8/31/2026 7:30 AM, Saif Abrar wrote:
> From: Saif Abrar<saif.abrar@linux.vnet.ibm.com>
>
> IODA PCT table is implemented
> without any functionality, being a debug table.
>
> Signed-off-by: Saif Abrar<saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater<clg@kaod.org>
> Reviewed-by: Caleb Schlossin<calebs@linux.ibm.com>
> Reviewed-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   hw/pci-host/pnv_phb4.c              | 7 +++++++
>   include/hw/pci-host/pnv_phb4.h      | 2 ++
>   include/hw/pci-host/pnv_phb4_regs.h | 1 +
>   3 files changed, 10 insertions(+)
>
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 56952a6200..5f84550a7c 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -264,6 +264,11 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
>           mask = phb->big_phb ? PNV_PHB4_MAX_MIST : (PNV_PHB4_MAX_MIST >> 1);
>           mask -= 1;
>           break;
> +    case IODA3_TBL_PCT:
> +        tptr = phb->ioda_PCT;
> +        mask = phb->big_phb ? PNV_PHB4_MAX_PCT : (PNV_PHB4_MAX_PCT >> 1);
> +        mask -= 1;
> +        break;
>       case IODA3_TBL_RCAM:
>           mask = phb->big_phb ? 127 : 63;
>           break;
> @@ -362,6 +367,8 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
>       /* Handle side effects */
>       switch (table) {
>       case IODA3_TBL_LIST:
> +    case IODA3_TBL_PCT:
> +        /* No action for debug tables */
>           break;
>       case IODA3_TBL_MIST: {
>           /* Special mask for MIST partial write */
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index 33e11a3fe8..8d5822f339 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -65,6 +65,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4RootBus, PNV_PHB4_ROOT_BUS)
>   #define PNV_PHB4_MAX_LSIs          8
>   #define PNV_PHB4_MAX_INTs          4096
>   #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
> +#define PNV_PHB4_MAX_PCT           (128 * 2)
>   #define PNV_PHB4_MAX_MMIO_WINDOWS  32
>   #define PNV_PHB4_MIN_MMIO_WINDOWS  16
>   #define PNV_PHB4_NUM_REGS          (0x3000 >> 3)
> @@ -138,6 +139,7 @@ struct PnvPHB4 {
>       /* On-chip IODA tables */
>       uint64_t ioda_LIST[PNV_PHB4_MAX_LSIs];
>       uint64_t ioda_MIST[PNV_PHB4_MAX_MIST];
> +    uint64_t ioda_PCT[PNV_PHB4_MAX_PCT];
>       uint64_t ioda_TVT[PNV_PHB4_MAX_TVEs];
>       uint64_t ioda_MBT[PNV_PHB4_MAX_MBEs];
>       uint64_t ioda_MDT[PNV_PHB4_MAX_PEs];
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index 9ad6713d37..897c869d20 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -478,6 +478,7 @@
>   
>   #define IODA3_TBL_LIST          1
>   #define IODA3_TBL_MIST          2
> +#define IODA3_TBL_PCT           3
>   #define IODA3_TBL_RCAM          5
>   #define IODA3_TBL_MRT           6
>   #define IODA3_TBL_PESTA         7
--------------W4xTBoqsCBjW2G5fCUnKupfB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>
    </p>
    <div
style="font-family: &quot;Consolas&quot;; font-size: 11.0pt; color: #000000;background-color: #FFFFFF; font-style: normal; font-weight: normal; text-decoration: none;">
      <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>

Thanks, MAK
</pre>
    </div>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/31/2026 7:30 AM, Saif Abrar wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260831123005.1485518-9-saif.abrar@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">From: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.vnet.ibm.com">&lt;saif.abrar@linux.vnet.ibm.com&gt;</a>

IODA PCT table is implemented
without any functionality, being a debug table.

Signed-off-by: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.ibm.com">&lt;saif.abrar@linux.ibm.com&gt;</a>
Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@kaod.org">&lt;clg@kaod.org&gt;</a>
Reviewed-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
Reviewed-by: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
---
 hw/pci-host/pnv_phb4.c              | 7 +++++++
 include/hw/pci-host/pnv_phb4.h      | 2 ++
 include/hw/pci-host/pnv_phb4_regs.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 56952a6200..5f84550a7c 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -264,6 +264,11 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
         mask = phb-&gt;big_phb ? PNV_PHB4_MAX_MIST : (PNV_PHB4_MAX_MIST &gt;&gt; 1);
         mask -= 1;
         break;
+    case IODA3_TBL_PCT:
+        tptr = phb-&gt;ioda_PCT;
+        mask = phb-&gt;big_phb ? PNV_PHB4_MAX_PCT : (PNV_PHB4_MAX_PCT &gt;&gt; 1);
+        mask -= 1;
+        break;
     case IODA3_TBL_RCAM:
         mask = phb-&gt;big_phb ? 127 : 63;
         break;
@@ -362,6 +367,8 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
     /* Handle side effects */
     switch (table) {
     case IODA3_TBL_LIST:
+    case IODA3_TBL_PCT:
+        /* No action for debug tables */
         break;
     case IODA3_TBL_MIST: {
         /* Special mask for MIST partial write */
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 33e11a3fe8..8d5822f339 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -65,6 +65,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4RootBus, PNV_PHB4_ROOT_BUS)
 #define PNV_PHB4_MAX_LSIs          8
 #define PNV_PHB4_MAX_INTs          4096
 #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs &gt;&gt; 2)
+#define PNV_PHB4_MAX_PCT           (128 * 2)
 #define PNV_PHB4_MAX_MMIO_WINDOWS  32
 #define PNV_PHB4_MIN_MMIO_WINDOWS  16
 #define PNV_PHB4_NUM_REGS          (0x3000 &gt;&gt; 3)
@@ -138,6 +139,7 @@ struct PnvPHB4 {
     /* On-chip IODA tables */
     uint64_t ioda_LIST[PNV_PHB4_MAX_LSIs];
     uint64_t ioda_MIST[PNV_PHB4_MAX_MIST];
+    uint64_t ioda_PCT[PNV_PHB4_MAX_PCT];
     uint64_t ioda_TVT[PNV_PHB4_MAX_TVEs];
     uint64_t ioda_MBT[PNV_PHB4_MAX_MBEs];
     uint64_t ioda_MDT[PNV_PHB4_MAX_PEs];
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index 9ad6713d37..897c869d20 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -478,6 +478,7 @@
 
 #define IODA3_TBL_LIST          1
 #define IODA3_TBL_MIST          2
+#define IODA3_TBL_PCT           3
 #define IODA3_TBL_RCAM          5
 #define IODA3_TBL_MRT           6
 #define IODA3_TBL_PESTA         7
</pre>
    </blockquote>
  </body>
</html>

--------------W4xTBoqsCBjW2G5fCUnKupfB--


