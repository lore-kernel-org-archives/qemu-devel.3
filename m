Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F16F531DC
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQ9x-0002Da-6c; Mon, 13 Apr 2026 18:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wCQ9v-0002D5-F2; Mon, 13 Apr 2026 18:53:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wCQ9t-00020P-U5; Mon, 13 Apr 2026 18:53:35 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DLIXOL1859930; Mon, 13 Apr 2026 22:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DDyL0r
 SzVoHgxxzByOuDifhHQA49xy/pg1HLV58Udp4=; b=AHwaXRJzi3Wa+/cnTTdusX
 msNwcwnZ48NHLDWx6kR7SxbjfSZXIV0wzWngFntg7JzsOOzgCLx3IVRfw3u6+cHF
 hrJ02bO+rTULudG2FglDk/HtXwPL4fEH1jnxBDrAlrB1iSqY+DluoG2Cin0U77Vp
 3YOchEDg9RzB4LN52hhcTlL7PXUEhQv+X6ij/GK1EH9zY/cuJWsbTx2VJyF8wERs
 JDM7H6VVjgWh2/gXD6bJFAOgeQ03z3ywdyiLyal44FnJwROf7t0j39pSW1hlVs3A
 CYZKkqwdK3URlSGWGvxsiUOfdo9pXQ4PMtER9d5XCzjvySNyFQxgmiVMI1HbI3XQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89p871h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 22:53:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DI5w3N004198;
 Mon, 13 Apr 2026 22:53:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k722q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 22:53:28 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63DMr2RF18219670
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Apr 2026 22:53:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5086858055;
 Mon, 13 Apr 2026 22:53:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6FCF58043;
 Mon, 13 Apr 2026 22:53:25 +0000 (GMT)
Received: from [9.61.251.241] (unknown [9.61.251.241])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Apr 2026 22:53:25 +0000 (GMT)
Message-ID: <dfc34199-9d96-4f17-8b4b-79b181534668@linux.ibm.com>
Date: Mon, 13 Apr 2026 18:53:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 29/30] docs/specs: Add secure IPL documentation
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-30-zycai@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-30-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3cEx1h9hvFukSsgMUeaEFduqOJjXUgMc
X-Proofpoint-ORIG-GUID: 3cEx1h9hvFukSsgMUeaEFduqOJjXUgMc
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69dd73e9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Blc7dCXeqDJRHnnFPaIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIyNCBTYWx0ZWRfXzRSGuN9dYTZo
 Gy/8uJNC7QJuxaqKP7VbN6HVpkgSD0eAqwbaj+xL2fGKLyw4dtXErTPCzeSAJ/tQaormQwifH+Z
 Rk/h/KNoPinYMkvkua46dQVmWio3r5l+mm9P2vcZX+zU8SEGS3FEnVwwjf7uMubSF8ZN8i/HmEF
 a2hjBFyH0VFI7KYy8k33EmJxej2sP3aZh9aKAtqF8YBtQ7RK0js5Rh6XAHeepnlYXzSFCISe20j
 PKEmN7Uh8Lo7aefIStleEzUOWHYBlsl/GXs71/6okSd3nOSI34WN+X0HsCPwJKbfegKOMiHv2fj
 kLKrWk/6hM6B8p5wFwOy0lhlviA0XF0YdyIRvOfH1xi9AXqx+BFKLxsINK3dyWgq0q0rmbRYSPI
 GEyO8vTErKZtNotBBTX03YrUYIiCejjoPQdlY4txCvgwFIGt7xRnj2QNWsTl/OAPO1fe/phcf7G
 6zXklMioi0WCl8QIHIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604130224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/2/2026 6:14 PM, Zhuoying Cai wrote:
> Add documentation for secure IPL
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 55 +++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 756246c45a..2ba54ecc1d 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -1,5 +1,60 @@
>   .. SPDX-License-Identifier: GPL-2.0-or-later
>   
> +s390 Secure IPL
> +===============
> +
> +Secure IPL (a.k.a. secure boot) enables s390-ccw virtual machines to
> +leverage qcrypto libraries and z/Architecture emulations to verify the
> +integrity of signed kernels. The qcrypto libraries are used to perform
> +certificate validation and signature-verification, whereas the
> +z/Architecture emulations are used to ensure secure IPL data has not
> +been tampered with, convey data between QEMU and guest code, and set up
> +the relevant secure IPL data structures with verification results.
> +
> +To find out more about using this feature, see
> +``docs/system/s390x/secure-ipl.rst``.

This path is useful for developers reading this page in the repo, but
it may be confusing for readers of the built documentation.

You can create a link instead/in addition. Consider something like:

  To find out more about using this feature, see the
  :doc:`documentation </system/s390x/secure-ipl>`.

---

Regarding this document overall:

In the sphinx build, the left-side navigation menu and the bullets in specs/index
do not render sensibly. Use:

Level 1 (title only)
====================

Level 2 subtitle
----------------

Level 3 subtitle
^^^^^^^^^^^^^^^^

e.g.

Current:

= s390 Secure IPL
= s390 Certificate Store and Functions
  - s390 Certificate Store
  - ...
= Secure IPL Data Structures, Facilities, and Functions
  - ...

New:

= s390 Secure IPL
  - s390 Certificate Store and Functions
   ^ s390 Certificate Store
   ^ ...
  - Secure IPL Data Structures, Facilities, and Functions
   ^ ...

