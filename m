Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0183AF9B61A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFVHR-0004Fj-EI; Wed, 22 Apr 2026 06:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wFVHQ-0004FQ-CB; Wed, 22 Apr 2026 06:58:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wFVHO-0007Y8-6r; Wed, 22 Apr 2026 06:58:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MAqPgG878383; Wed, 22 Apr 2026 10:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YxAP0U
 adgVKGaypUAmf5CCqoo5vN0M5zJ7SQE+C3kRM=; b=QugbOMAUmtIY6OkFTm/7yM
 dmIPy8lhVV58CzRG1ppvJubWd8L4l2YdLDo2X+PdTj/aIaOXecqXJwDUM7hETCZl
 XAC4uXhsLdgi+JczwDBat8Q8u4z7Ps/ZfaBl3UuC5ARthi+a/tvKLzhTBSKwRi4M
 tyT9cGv9D3/Quccy39MmbhJc1kPlVxm6Is7hcBqFqy2/dehqAn5J6E2sjsvEtR6l
 igmjFF1NgmJiQyQxx0GTNzj87w+ALcyrfAMdOlyeRJl9+WyqHKVYzu+vvwu3Ghs+
 qsi7fCVBV0yvhqqvZkJjlfWPA0lJJBwSfeZRxgDTVqwE/CwzZJY3CmaptXVTaf+g
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu232ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 10:57:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MAoLqU030380;
 Wed, 22 Apr 2026 10:57:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxsw67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 10:57:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63MAvr4v26345856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2026 10:57:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F5BE2004F;
 Wed, 22 Apr 2026 10:57:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DEB02004E;
 Wed, 22 Apr 2026 10:57:49 +0000 (GMT)
Received: from [9.39.31.91] (unknown [9.39.31.91])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Apr 2026 10:57:49 +0000 (GMT)
Message-ID: <d4f5cace-7ee3-4eb1-a9ae-23551aea17b6@linux.ibm.com>
Date: Wed, 22 Apr 2026 16:27:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Replace assert with bound checks in PnvPHB3
From: Aditya Gupta <adityag@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Zexiang Zhang <chan9yan9@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Miles Glenn <milesg@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
References: <20260326190438.734239-1-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260326190438.734239-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEwMyBTYWx0ZWRfX9bykETeBAplg
 qZZcAyGn9hoK1X4L/vJ2ftjVlab78Xo6W5z5Kowxte+JizABCeKzXEM/Ju0XC6w+fPFLt0C4AXi
 +u8On+PBIPGIYq++sL+v2QDdl1Ge7gfpfbQOTiShMm5e1/mNf4INHdviWTFWNDuzDbF8A3BYBoA
 LRrIVB8vIWOURGuaoN0PfC7QYhLhcRjPI3FKUwcd4ANo3vI20hWv1GufhIWroAze2QbhH8DCMjr
 YRZAel5S0+id1VoB6x96h4NonLqtusR/gqOhT/7j30U7IYyuAeHqQ3SHF/5tTMblUg1L3o2WBF4
 6JtG9vUtQv8QEc4TYU81j+OOzRBcleRbS8GQwpi34dhR5CRvgdUShtrRzOP8okHcfCFk4jATupp
 gJw6mKHM0KzDT49Ud/k1lzE0e0jGCV96pBolxV1STET/obgPS1xSkolFUP7Ja/y4ouaSrRojHts
 feKw2r3hox3RhcNNYFA==
X-Proofpoint-ORIG-GUID: 6eu5c0m2KSEwkMagrPRUh3p_-LFA6PWY
X-Proofpoint-GUID: 5uWxjAyAsIspcb4fP0e__q6FQ5PIcMCN
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69e8a9b6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=1POnG2dpA3gO89UsiucA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ping,

Hello Zexiang, can you see if this fixes the issue you reported ?

Also adding shivang and nikhil to cc.


- Aditya G


On 27/03/26 00:34, Aditya Gupta wrote:
> Overview
> ========
>
> PHB in Power8 supports 8 byte registers, and hence the ops structure
> allows accessing of 8 bytes in 'pnv_phb3_reg_ops'
>
> Both 'pnv_phb3_reg_read' & 'pnv_phb3_reg_write' pass the arguments as is
> to 'pnv_phb3_config_{read,write}', if offset is PHB_CONFIG_DATA.
>
> This when called with size as 8, causes following assert failure in
> 'pci_host_config_read_common' & 'pci_host_config_write_common':
>
>      assert(len <= 4);
>
> This patch series splits it into two patches:
> 1. Fix PnvPHB3 code so that it never calls pci_host_config_{read,write}_common
>     with read/write size of >4, thus fixing the assert problem
> 2. Replace the assert with bounds checking
>
> Patch #2 should not have any functional change, since the issue is
> already fixed by patch #1
>
> Testing
> =======
>
> 1. Git repo with the patches: https://gitlab.com/adi-g15-ibm/qemu/tree/fix_assert_phb3
>
> 2. Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2410981612
>
>> Note: One test is failing in the pipeline, but the log shows some cargo error,
>> unrelated to the patch series
> 3. Testcase provided by Zexiang Zhang, this will fail without the patches:
>
>    cat << "EOF" | ./qemu-system-ppc64 \
>      -M powernv8 -accel tcg -cpu POWER8 \
>      -display none \
>      -serial none -monitor none \
>      -qtest stdio -S \
>      -d guest_errors -D /tmp/pci_len_pnv.log
>    writeq 0x3fc009013c000 0x140
>    writeq 0x3fc009013c010 0x8000000000000000
>    writeq 0x3fc009013c000 0x130
>    readq 0x3fc009013c010
>    EOF
>
> Aditya Gupta (2):
>    ppc/pnv_phb3: Error out on invalid config access
>    hw/pci: Replace assert with bounds check and return
>
>   hw/pci-host/pnv_phb3.c | 10 ++++++++++
>   hw/pci/pci_host.c      | 14 ++++++++++++--
>   2 files changed, 22 insertions(+), 2 deletions(-)
>

