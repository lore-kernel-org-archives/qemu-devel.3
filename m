Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0E4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf7aL-00010Q-GW; Wed, 01 Jul 2026 22:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf7a3-0000uz-8H; Wed, 01 Jul 2026 22:55:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf7Zz-0002jM-Id; Wed, 01 Jul 2026 22:55:10 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621Kunj2510123; Thu, 2 Jul 2026 02:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4feySX
 +XQB0uhsYMjwQa7+XhaSKbTxkQ1VoZ87CFBL4=; b=A1oVh/IWz3h1spX3rBAsla
 9wWgVobCzYbLwsJ9rOixa0xM4iYfZ1Yqkn33i/9hRL8PYmo9CXvjN/hRGoN/D5RJ
 AltlLfAWBMxbFtuF4Q/Oo5ohxw1krIYotbj2fFS/nLa/2IZqpv3VqBoqukMYBflb
 PIAx72PwIt8d9LIU+yRHbuC9myUvZEvC4DaIHfvQ1r/5ldz4hmkl+MWGSKTtevVF
 GpBVwV+oHNAgJnCPFNBhxwKrti77MWeJozh9PlCLtwYF8VoGL51nq9lba7DD6iEi
 otlpZ7cTEgNPkm4myo/nlFROmukr1OQ3MVTJ/gbXKZYdjAH7WeAHlAaj5ZjwMaaw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe7ty4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:54:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6622nbVu006968;
 Thu, 2 Jul 2026 02:54:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wa788-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:54:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6622stL035717586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 02:54:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E015258043;
 Thu,  2 Jul 2026 02:54:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F29665805D;
 Thu,  2 Jul 2026 02:54:52 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 02:54:52 +0000 (GMT)
Message-ID: <cbea338c-0698-4432-ae1f-0e54ba5678c7@linux.ibm.com>
Date: Wed, 1 Jul 2026 22:54:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 34/35] docs/specs: Add secure IPL documentation
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-35-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260701204922.1320349-35-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sQYgfmxX0KOhpSzoCKi4TgH4_m5-A5S5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX/iJstjJO+daV
 qZl+5vxbV9L959CaZvJ/gEXo5YPPiBG8IfM9ShXcdZ+Ft93cZVv9yKEw9Fp9gW+26M+OCkakPC9
 9gV3F4CG+nFz0Mkx4x38/jlnlzjMGQ8=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a45d301 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=MCl5k4fuD9Xhj4u6LNgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX4P2A8s/4bD4M
 VG65F1yqxi4m7HJBCGYhssYJTPrivpZfSaimf35r2zTiTxEk84QFxJZiy+cJbFPe6xx2JAta5Ed
 HmRSY27VwFQxecvvALEibdbPUSNBWMf0OdK+MnZgyuq80WFaKgGU74ays+pRVEE0STS5FPkqBoc
 cCHlMdonQTwU/yXNxy+g0z9qCIWnjHNxW091L6YBBCpsXpkbeCS1Oz7hAU3/U9UA9ip/qNLzpIi
 d9xNcR6oi7ana4XELuiPzKt6ty55zJNy5hzitnQdo0GJVYIkhOE1YRVWPTCtI6eyE1vhkDio/2k
 jIBvCr8ZSHNFP2uYvuMMsG0jFzLr/U8aif9QgBmxQVpe8iRxi6vz2rQnJlBiVgrT/8F27iFRn1c
 EfSq93Dj2Ef+ivwh6AH7Dt1IMISLmHzZaEXJhexbF6PixlFT9HGB6MIUwj587f+uKbGpAesrHzD
 iRLbu03GcrHCiMca+Iw==
X-Proofpoint-ORIG-GUID: sQYgfmxX0KOhpSzoCKi4TgH4_m5-A5S5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020026
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> Add documentation for secure IPL
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst | 55 +++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 0f92ff96b9..65a4b2f624 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -1,5 +1,60 @@
>  .. SPDX-License-Identifier: GPL-2.0-or-later
>  
> +s390 Secure IPL
> +===============
> +
> +Secure IPL (a.k.a. secure boot) enables s390-ccw virtual machines to
> +leverage qcrypto libraries and z/Architecture emulations to verify the

s/emulations/emulation/ ?

> +integrity of signed kernels. The qcrypto libraries are used to perform
> +certificate validation and signature-verification, whereas the
> +z/Architecture emulations are used to ensure secure IPL data has not

emulation is used ?

> +been tampered with, convey data between QEMU and guest code, and set up
> +the relevant secure IPL data structures with verification results.
> +
> +To find out more about using this feature, see
> +:doc:`documentation </system/s390x/secure-ipl>`.
> +
> +Note that "guest code" will refer to the s390-ccw BIOS unless stated
> +otherwise.
> +
> +Both QEMU and guest code work in cooperation to perform secure IPL. The Secure
> +Loading Attributes Facility (SCLAF) is used to check the Secure Code

Secure 'Code' Loading Attributes Facility ?

> +Loading Attribute Block (SCLAB) and ensure that secure IPL data has not
> +been tampered with. DIAGNOSE 'X'320' is invoked by guest code to query
> +the certificate store info and retrieve specific certificates from QEMU.
> +DIAGNOSE 'X'508' is used by guest code to leverage qcrypto libraries to
> +perform signature-verification in QEMU. Lastly, guest code generates and
> +appends an IPL Information Report Block (IIRB) at the end of the IPL
> +Parameter Block, which is used by the kernel to store signed and

IPL Parameter Block (IPLB) ?

> +verified entries.
> +
> +The logical steps are as follows:
> +
> +- guest code reads data payload from disk (e.g. stage3 boot loader, kernel)
> +- guest code checks the validity of the SCLAB
> +- guest code invokes DIAG 508 subcode 1 and provides it the payload

drop the word 'it'

> +- QEMU handles DIAG 508 request by reading the payload and retrieving the
> +  certificate store
> +- QEMU DIAG 508 utilizes qcrypto libraries to perform signature-verification on

'QEMU DIAG 508 handler'

> +  the payload, attempting with each cert in the store (until success or
> +  exhausted)
> +- QEMU DIAG 508 returns:
> +
> +  - success: index of cert used to verify payload
> +  - failure: error code
> +
> +- guest code responds to this operation:

QEMU can't control what the guest will do.  Maybe better to say
something like...

'guest code is expected to respond to this operation by:'

With those changes (please remember to stay within 80 columns):

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


> +
> +  - success: retrieves cert from store via DIAG 320 using returned index
> +  - failure: reports with warning (audit mode), aborts with error (secure mode)
> +
> +- guest code appends IIRB at the end of the IPLB
> +- guest code kicks off IPL
> +
> +More information regarding the respective DIAGNOSE commands and IPL data
> +structures are outlined within this document.
> +
> +
>  s390 Certificate Store and Functions
>  ------------------------------------
>  


