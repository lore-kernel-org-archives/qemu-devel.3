Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3AACD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 14:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLiwf-0002vb-ON; Sat, 09 May 2026 10:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLiwa-0002ux-Ob; Sat, 09 May 2026 10:46:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLiwZ-0002NH-9p; Sat, 09 May 2026 10:46:16 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 649Ddts4523084; Sat, 9 May 2026 14:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JuA8Yc
 QTCahviaIFtQJ/TFFExaiICZSdqnblvdGxS+0=; b=djmEA7yN0COEOJb9zYL2UO
 hYA0ZJZUgpx2ufbrdkxywpc0sIhklaYJDe7XX/hwLIGFw1+29/o20zdPuFA7fYg+
 OCR9JEXCRDuyS3aXKJbvg/PNCNvL2W7ugvvrdtgmbzqNb6bNkgWP1J7irkOJrV5R
 gtsxhC9ZTkv9aY8gyQL4BEULD1/2eedv5/N25DA5+u6e9e/6aWi8NAgrBKkOYYlZ
 U1GJShueRQrkuMPMzFSF0Jy1ETuG5CDcrD4isMycHLf9FXigDSHNXqjlLU8luqP7
 EnCfsQoH2vyvmqqWNwVEBoyOEW37quVu8xf9iXD5/48KdLVHfIPn8nh0MlrjeiVA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve6sx1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:46:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649EdWeg024766;
 Sat, 9 May 2026 14:46:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yvmw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:46:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 649Ek0HI47120696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 May 2026 14:46:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01D0420043;
 Sat,  9 May 2026 14:46:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F48320040;
 Sat,  9 May 2026 14:45:52 +0000 (GMT)
Received: from [9.39.25.188] (unknown [9.39.25.188])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  9 May 2026 14:45:52 +0000 (GMT)
Message-ID: <b055cb2f-6610-4714-9ecd-c79a57274b11@linux.ibm.com>
Date: Sat, 9 May 2026 20:15:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] qtest/phb4: Add testbench for PHB4
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-2-saif.abrar@linux.vnet.ibm.com>
 <af9FJIWPOH5Bej7y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
In-Reply-To: <af9FJIWPOH5Bej7y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE1OSBTYWx0ZWRfX5KfkiaQIhX+X
 ANDDsStH9BfbluqNv/kuZ0NvOW9TDc83l0peq4RrpZvH5hod3ACgJG5FqF0uM02GfzPt0s3Mf2w
 yzohDF8JcFzjPSbU3ASMk1AucnIOvuB2A70fqamXTWuZJkYsHXPUv+4gDS+KO9MwcEYXjnGKFhp
 hFi2DS9NcgTCfgFQbY40N7ZOKRplcUHvbJRNGjXEwpofEKKVW9ZA4CYa5w7/uNWoE/jngUw6fka
 kcsb+8izIbPANy/bZu6hOHrS+RvRGWhb60M+/ix3FG0cpl1MeD31ivDfdcB0DlD+rVspNJZYaN1
 gh9xWqGuezYpG7MLukoE3LzsBIwpOqhLCrGnjQSo1A4aiM5nnJajLoH6BZNbpPAxYOyr31aDz1S
 LvQWG3BMi8fibfPpNAC1ALbThmXueoClfiN6JSww1Vy+/a0B7e81h/wbnyiB1iFcnCeRO6qYpAv
 qGotXNPne7ceYJqTT/g==
X-Proofpoint-GUID: _rTItnQgcvg9dJ1PnZh3cQVxmJR3e4qQ
X-Proofpoint-ORIG-GUID: _56L4OMPlqBgknfinh4forrXRH3iJsej
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=69ff48ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=zjctwEK5lmB8oGVZkGgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090159
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

On 09/05/26 20:03, Aditya Gupta wrote:
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> <...snip...>
>>
>> +#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
>> +#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
>> +
>> +/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
>> +#define PNV_P10_CHIP_INDEX      3
> nit: this is unused as of this patch.
>
> rest looks good to me. i had comment about using p11, but noticed none
> of the qtest having it, maybe that can be done separately.
>
> Thanks,
> - Aditya G

Cc: +harsh +jishnu


