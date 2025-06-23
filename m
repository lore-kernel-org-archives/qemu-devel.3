Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634BDC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 21:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uToLY-0008JK-14; Mon, 23 Jun 2025 17:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uToLV-0008Ik-Mo; Mon, 23 Jun 2025 17:04:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uToLT-0001GV-OA; Mon, 23 Jun 2025 17:04:53 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NF4HIA009252;
 Mon, 23 Jun 2025 21:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sUZ5AR
 8TDskfdgfdwROHTbtFTR4PjI2nYL5YC41QM8M=; b=LyGAiNTTzcaFAhJNuVg06o
 sPtQMSu8Xv3GD3JEYbiUSI7oSvTokJkG79NtPGd3We5Vbzgp9ch4BbZRUFHvkyli
 3tQIVFk61w9KEZYG0MsgCww0Jqxnu4OnpGVpXYScKHbeRevHmfaK9D3+eRj5GwQm
 ICg+uTWbO5WPtp8ZZs38Rw14/aNBlcqGbY1nLE3H0fMMfVmRgDtTJSTeG9XOfg6C
 4s8nqbGjKK/0rh/k0d5o2Pp48aUwoeBH90ZO+AyYlOuq4XtFwUxj0oL4VDQ2ELji
 dAx6zheztK4lToXhwjr9BhNahdfloMT4dBz7oviH174bZerQp6CN841g8Z6V0RVA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2vdn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 21:04:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NIvaT7014748;
 Mon, 23 Jun 2025 21:04:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s28dvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 21:04:48 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NL4lZn22938206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 21:04:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8113658052;
 Mon, 23 Jun 2025 21:04:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0A0F58045;
 Mon, 23 Jun 2025 21:04:46 +0000 (GMT)
Received: from [9.61.145.51] (unknown [9.61.145.51])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 23 Jun 2025 21:04:46 +0000 (GMT)
Message-ID: <f31a48c6-f7e1-4462-b785-b0af6d4736b9@linux.ibm.com>
Date: Mon, 23 Jun 2025 17:04:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/s390x: Use preferred API call for IPLB chain write
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, philmd@linaro.org
References: <20250623201216.721130-1-jrossi@linux.ibm.com>
 <20250623201216.721130-2-jrossi@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20250623201216.721130-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=6859c171 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=o164naMlAKljxEPHmDsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEzOCBTYWx0ZWRfXxVF3q8nIU/OB
 VmpmBxMbbvZQ/3D6aO+WfVSOjZ8mJJi2QbsMYez7tLJsrvgjCK1fhx6RhJA3BEI1I1WqB6qj4hK
 km3Xe/h7HCnnWdl0HgSpfOvcU/IKwHV8JyWjKxnOHaDTYcvHC4T+q5Kf0oC75jQALi7idXPlKAx
 9fZ3hEM/LguMapoJm8SpRYJMZKs7fZmZgu0Zv0GC6fc5uujRA8l72D3PFXnU39gaMNDNlwOqshK
 JAK9rywQhoZY0eKNo2yY5zY23CkQGOZj/CJiNia9y+Gu4flxqEFKVh6lICeqHjWtZjEvJrq9wfj
 ZVml0v12G6dGYe3SvxUJpDBvW/CIToCxwGs300J8oINFlYC1GU6uiwnJk2VG4HDmo+5FI8u7/BH
 BdrVZQWwKETwjON9KaoB0OABMAJZo7cGl3/X/kEwNns0c7o2/QJU4GK1O6vuqAuOrgDO/P6P
X-Proofpoint-GUID: WFFtWahGmYln1XD8ykk95Y6sE9-W_K6S
X-Proofpoint-ORIG-GUID: WFFtWahGmYln1XD8ykk95Y6sE9-W_K6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_07,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 mlxlogscore=765 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/23/25 4:12 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Replace a recently introduced legacy API call with the preferred API call.
> 
> fixes: 0927875 (hw/s390x: Build an IPLB for each boot device)
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  hw/s390x/ipl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 2f082396c7..f2606303e6 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -399,8 +399,16 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>      uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
>      uint64_t len = sizeof(IplParameterBlock) * count;
>      uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
> +    MemTxResult ret;
> +
> +    ret = address_space_write(&address_space_memory, chain_addr,
> +            MEMTXATTRS_UNSPECIFIED, iplb_chain, len);

Just a small nit: the indentation seems a bit off.

> +
> +    if (ret != MEMTX_OK) {
> +        error_report("Failed to map IPLB chain.");
> +        exit(1);
> +    }
>  
> -    cpu_physical_memory_write(chain_addr, iplb_chain, len);
>      return chain_addr;
>  }
>  

Regards,
Joy

