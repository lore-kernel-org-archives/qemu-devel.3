Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58488CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHpY-0006yM-8y; Tue, 19 May 2026 06:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHpP-0006y0-2p; Tue, 19 May 2026 06:37:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHpL-00067r-S2; Tue, 19 May 2026 06:37:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J4fQxw1144060; Tue, 19 May 2026 10:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nPzDV2
 EVhTC+3h4KyiiLMQbDnQe62vbv0IZiw9wJPN4=; b=BaKO29gfrybECXwMdAyccR
 mtDsSljAdIsGaV0YUL/GmS9Zoi2o1My9pT4mxVFJo4vvVopn2sNg/Z2+VJaDn0a0
 sJdeRGT7aHreShSTSxCXFtbDUwFbKCVA9HJXBN8cgC6HahdG5UDcriTQHRMSoVWU
 HrkElOXfnhoXE4AJEo8ac9hwRIMrmfOXslI5QZXyh7BYrUElBIBskieaW3sfJrb4
 ZmfEvHjWct9cZErvCx+M0Gl4qMg0lbNdRXPhPjvjPtG43SN6P9J9quiZ3uNvF8lS
 Milr6zZ4HGQvhlXjl0fyOZPa4aMUjGCbM1L2kjB1edjQO+Z+7CsqiaoWXBplAHFQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw3s4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:37:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAO7WE004865;
 Tue, 19 May 2026 10:37:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk24hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:37:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64JAbPlK52691308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 May 2026 10:37:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22A0420043;
 Tue, 19 May 2026 10:37:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF9A520040;
 Tue, 19 May 2026 10:37:22 +0000 (GMT)
Received: from [9.123.10.31] (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 May 2026 10:37:22 +0000 (GMT)
Message-ID: <b13e3ee2-8a9a-4c78-be26-54081137783c@linux.ibm.com>
Date: Tue, 19 May 2026 16:07:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/ppc: Rename spapr_pci_vfio.c to
 spapr_pci_vfio_eeh.c
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
 <20260512071112.9675-6-nnmlinux@linux.ibm.com>
 <ebc9e323-6acb-4224-84a7-1fdcc0841205@redhat.com>
 <368f7343-f0a8-40c8-bbab-663831962660@oss.qualcomm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <368f7343-f0a8-40c8-bbab-663831962660@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwNCBTYWx0ZWRfX7DBlQcWbQGan
 VqUCvta8pH+KqNuPZkhXX3NPrzuNBJsKKzXaj4IZyFkFt2CjE96AJRHlYnvCTSaYP8vl8EdaoiY
 pA7MqfLjmGR1D6rDL7u9fcFrwLjZMAfgXp0zEqN9GsGH/LUo3bXjp/A8ARuC84k6QkRyB5tBmbP
 X0bm1wtfR6vcREW6cb62BXfQcdSBTOAZXOSCR4ixRSjC3E8reHDGRQ+dDAI2hPEb7h7NrTeH4OF
 fI84HzSvXpZMMa8KiQVTlVvyKfBcna9WcCnd64avHnrBVl8D9j56lU5NAmDCZorT7g1J4nA8zRk
 B4dorQZ/q81Kuwqnns0UJKJ1PO7YYOClf5HSrhHiM288xsKZpSDrxbNY7eIpIhm3me+S2hDztmi
 06usE43JcFAac0Xn/o+ASydUGa05puas0FRZA6jYq4vZ8rA9kS/kTR9KODg2poWQcgzOQOryzd8
 xpJ1q8b5kjM3+9PN8+g==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0c3d6a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VZNyi5kqvfz-fu05OJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dE676b3iLswNPgOpC9QKjN-VZgwbKmKO
X-Proofpoint-GUID: THxbvpjYrjTwe1x2sukSglk6d3vDZUVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190104
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi Pierrick, Cedric,

On 13/05/26 9:46 PM, Pierrick Bouvier wrote:
> On 5/12/2026 12:54 AM, Cédric Le Goater wrote:
>> + Pierrick, Philippe
>>
>> On 5/12/26 09:11, Narayana Murty N wrote:
>>> The file spapr_pci_vfio.c contains exclusively EEH (Enhanced Error
>>> Handling) related functions for VFIO devices on sPAPR platforms.
>>> To better reflect its specific purpose and improve code organization,
>>> this commit:
>>>
>>> 1. Renames spapr_pci_vfio.c to spapr_pci_vfio_eeh.c
>>> 2. Moves spapr_phb_vfio_eeh_reenable() from spapr_pci_vfio_eeh.c to
>>>      spapr_pci.c, as it's a general PHB operation not specific to
>>>      VFIO EEH error injection/recovery
>>>
>>> After this change, spapr_pci_vfio_eeh.c contains only the core VFIO
>>> EEH error handling functions, making the file's purpose more focused
>>> and clear.
>>>
>>> This is a refactoring change with no functional impact.
>>>
>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>> ---
>>>    hw/ppc/Kconfig                                    |  2 +-
>>>    hw/ppc/meson.build                                |  2 +-
>>>    hw/ppc/spapr_pci.c                                | 14 ++++++++++++++
>>>    hw/ppc/{spapr_pci_vfio.c => spapr_pci_vfio_eeh.c} | 12 +-----------
>>
>> There is a CONFIG_VFIO_PCI in this file that could be replaced
>> with stub definitions.
>>
> Indeed, we didn't touch this yet because it hw/ppc, and it's not in the
> list of target where we are focused.
>
> Indeed, the #include CONFIG_DEVICES and #ifdef CONFIG_VFIO_PCI can be
> removed, and stubs for spapr_phb_* functions be added in a new
> spapr_pci_vfio-stubs.c file, and added to stub_ss.

Thanks for your suggestions. I have incorporated above suggestions in v2 
here:
https://lore.kernel.org/all/20260519103325.8056-1-nnmlinux@linux.ibm.com/

Please take a look and let me know if any further review comments.

Thanks
Narayana Murty

>
> Regards,
> Pierrick


