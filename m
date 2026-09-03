Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32F2C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Aq3-0001ds-VJ; Thu, 03 Sep 2026 13:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2Apy-0001d4-Ti; Thu, 03 Sep 2026 13:02:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2Apw-0003wl-Oo; Thu, 03 Sep 2026 13:02:54 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2sGg3304756; Thu, 3 Sep 2026 17:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=1O4VoD08ZQY/fldd9xMY9W/lBFWu4i
 vqzu9C9wNklfg=; b=Q4pkaQ/ukXFXJdY1BS9+Pa6ITW8M/nOx8TyIQKfvleUZRm
 85/L8YdIWQ/WcCEkVRYuT7Dk7IdIidRVYqTxdY+KxlH2gl7jv5y+/OD95c5mAelM
 ZaqvW5iRezhN9fwQKayV/EH/r6PN0hXyPkcoMGl3WrsqdjGQBLrVulCOv3B90tiD
 DDZaY1xU7fHhLfY1qDZM8GQK6Hj5M/jDdzFZ6syg/GF/9qzAUWWz+xPLuJHBW7r5
 7SQlfl4XfnzzuJeHbyeWl5EcwbG6NF0k2e2VuMh5WWu2xEhFsW3i/hxPm65sCdE4
 QMMymk3UcY4qI25q59pIKs3Vh8ecu7qTg9I307rA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj5sfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 17:02:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GuIX8029224;
 Thu, 3 Sep 2026 17:02:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjas029-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 17:02:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683H20e646137718
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 17:02:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA2A258054;
 Thu,  3 Sep 2026 17:02:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B1DD58052;
 Thu,  3 Sep 2026 17:02:40 +0000 (GMT)
Received: from [9.10.80.39] (unknown [9.10.80.39])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 17:02:40 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------2GJXSkpPzWLK9PGXTwx56OJm"
Message-ID: <a25c7e9e-8d5a-4fae-a978-dc4bf478249d@linux.ibm.com>
Date: Thu, 3 Sep 2026 12:02:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, chalapathi.v@linux.ibm.com,
 calebs@linux.ibm.com, milesg@linux.ibm.com, jishnuvw@linux.ibm.com,
 adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: JIuepUVTECB73BON3pQLc7Q0Dz8YgrBl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0OCBTYWx0ZWRfX8X4hh0K6xqjy
 9iVGE1m1eaTJ58HU/TFDT1BgzM235en0kOABi1Cc4bCvlGHi+B/2tET1S9Wzyx3w+B37taeT0kC
 2kQouJXToPUZCtt3D3iYMtYa0g7Sr/HRqYh644Yg6UdfrXVY+X1j1dQHz0qpVuTHEASlvrIsqKP
 dLH0sj74KDjylqkBO4GIGV8nADCJ3IG8cCbz3OTrCgYsoac700oSnrofeoc9xfRYJdpQNa0djhF
 Fz6XN2tbuaewI+97VBHCMJFIV3v8/5ZKOcMTmYcbkJ5xYrnWZwjJEVke1hBIokmb2fVc8WHR1OI
 iOJZvpUZhTLoNuyQz2P7V447I9CuGD3D9+KUAY5EdvELKVKFxT4xsyC0S//p20f4YVC5ADRNDEX
 QK7Z8fbgChRrsVPq16IPmaaaGWW4mlvheyXR5OHHuF34NvPDpQ3ITtogGn9w8CgNhKU2XYEGaa0
 diXBYh0P7uoibkMfDCg==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a99a834 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=N1-tE7rikoB3GCo6Uq0A:9 a=QEXdDO2ut3YA:10
 a=4_wdIL-PfShv4t6dFjgA:9 a=giwTRlLOBNvZoAlH:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0OCBTYWx0ZWRfX2NV9e1xckv28
 4J0HSsyS0XG9VGTouJBj8OQ5xf8sQrTvYMz7jqdH36ohs+qYSTye0lzxH+DNF0hcRsXeY9+fzt1
 B0VnQkVV4KBfrodfhZGeTccX5gpHY8A=
X-Proofpoint-ORIG-GUID: pEYmEYGqeLAU2bvUD_uFNRjFOCixwYpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030148
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
--------------2GJXSkpPzWLK9PGXTwx56OJm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 8/31/2026 7:29 AM, Saif Abrar wrote:
> Hello,
> This patchset resolves the review comments for v5:
> https://lore.kernel.org/qemu-devel/20260617095058.652789-1-saif.abrar@linux.ibm.com/
>
> Major updates include the following:
> - Separate reset and register read/write methods for PHB5.
> - PHB4 and PHB5 specific reset values.
> - Read/write logic for registers added and removed in PHB5.
> - General cleanups.
>
> Tested with 'make check' and 'make check-functional-ppc64'.
>
> Regards.
>
> Saif Abrar (9):
>    qtest/phb5: Add testbench for PHB
>    pnv/phb5: Add reset logic to PHB5
>    pnv/phb5: Implement sticky reset logic in PHB5
>    pnv/phb5: Implement read-only and write-only bits of registers
>    pnv/phb5: Implement write-clear and return 1's on unimplemented reg
>      read
>    pnv/phb5: Set link-active status in HPSTAT and LMR registers
>    pnv/phb5: Set link speed and width in the DLP training control
>      register
>    pnv/phb5: Implement IODA PCT table
>    pnv/phb5: Mask off LSI Source-ID based on number of interrupts
>
>   hw/pci-host/pnv_phb.c               |  20 +-
>   hw/pci-host/pnv_phb4.c              | 552 +++++++++++++++++++++++++---
>   hw/pci-host/pnv_phb4_pec.c          |   2 +-
>   hw/pci-host/pnv_phb5.c              | 197 +++++++++-
>   hw/pci-host/pnv_phb5_pec.c          |   1 +
>   hw/ppc/pnv.c                        |   1 +
>   include/hw/pci-host/pnv_phb4.h      |  43 ++-
>   include/hw/pci-host/pnv_phb4_regs.h |  58 ++-
>   include/hw/pci-host/pnv_phb5.h      |  52 +++
>   tests/qtest/meson.build             |   1 +
>   tests/qtest/pnv-host-i2c-test.c     |  13 +-
>   tests/qtest/pnv-phb-test.c          | 235 ++++++++++++
>   tests/qtest/pnv-qtest-common.h      |  24 ++
>   tests/qtest/pnv-xive2-common.h      |   7 +-
>   14 files changed, 1102 insertions(+), 104 deletions(-)
>   create mode 100644 include/hw/pci-host/pnv_phb5.h
>   create mode 100644 tests/qtest/pnv-phb-test.c
>   create mode 100644 tests/qtest/pnv-qtest-common.h
>
--------------2GJXSkpPzWLK9PGXTwx56OJm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
    <div class="moz-cite-prefix">On 8/31/2026 7:29 AM, Saif Abrar wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260831123005.1485518-1-saif.abrar@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Hello,
This patchset resolves the review comments for v5:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20260617095058.652789-1-saif.abrar@linux.ibm.com/">https://lore.kernel.org/qemu-devel/20260617095058.652789-1-saif.abrar@linux.ibm.com/</a>

Major updates include the following:
- Separate reset and register read/write methods for PHB5.
- PHB4 and PHB5 specific reset values.
- Read/write logic for registers added and removed in PHB5.
- General cleanups.

Tested with 'make check' and 'make check-functional-ppc64'.

Regards.

Saif Abrar (9):
  qtest/phb5: Add testbench for PHB
  pnv/phb5: Add reset logic to PHB5
  pnv/phb5: Implement sticky reset logic in PHB5
  pnv/phb5: Implement read-only and write-only bits of registers
  pnv/phb5: Implement write-clear and return 1's on unimplemented reg
    read
  pnv/phb5: Set link-active status in HPSTAT and LMR registers
  pnv/phb5: Set link speed and width in the DLP training control
    register
  pnv/phb5: Implement IODA PCT table
  pnv/phb5: Mask off LSI Source-ID based on number of interrupts

 hw/pci-host/pnv_phb.c               |  20 +-
 hw/pci-host/pnv_phb4.c              | 552 +++++++++++++++++++++++++---
 hw/pci-host/pnv_phb4_pec.c          |   2 +-
 hw/pci-host/pnv_phb5.c              | 197 +++++++++-
 hw/pci-host/pnv_phb5_pec.c          |   1 +
 hw/ppc/pnv.c                        |   1 +
 include/hw/pci-host/pnv_phb4.h      |  43 ++-
 include/hw/pci-host/pnv_phb4_regs.h |  58 ++-
 include/hw/pci-host/pnv_phb5.h      |  52 +++
 tests/qtest/meson.build             |   1 +
 tests/qtest/pnv-host-i2c-test.c     |  13 +-
 tests/qtest/pnv-phb-test.c          | 235 ++++++++++++
 tests/qtest/pnv-qtest-common.h      |  24 ++
 tests/qtest/pnv-xive2-common.h      |   7 +-
 14 files changed, 1102 insertions(+), 104 deletions(-)
 create mode 100644 include/hw/pci-host/pnv_phb5.h
 create mode 100644 tests/qtest/pnv-phb-test.c
 create mode 100644 tests/qtest/pnv-qtest-common.h

</pre>
    </blockquote>
  </body>
</html>

--------------2GJXSkpPzWLK9PGXTwx56OJm--


