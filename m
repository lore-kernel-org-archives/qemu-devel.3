Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098E0FEC0E6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w562H-0007xB-0I; Tue, 24 Mar 2026 13:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1w562C-0007wW-Cs; Tue, 24 Mar 2026 13:59:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1w562A-0003ZH-S8; Tue, 24 Mar 2026 13:59:20 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OH1I98188501; Tue, 24 Mar 2026 17:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=q50fEq
 34shCCMeGX4OMTAbAMW4v8QwcNKr6CUBpkt4Y=; b=Rstt44Cfub/tulmRxt4Hxg
 QWaJS6mXXxwrC3LH9gLmQoVuZmY+peyVRN8a2MoeXmCQNKRNI/T80YiQdUjuL7f/
 gKZ5vei3exfklEXErby/2kg02A/mQPfRaAtHa7qKWdd/hcVWM9wId6goBajxQ+po
 4+glyDJogUnpvMq7MccTWhglaEIaGR1Q24HYd8SDl+BTmZN+PbehKGmas5LOa6u+
 fQRBJ6oH1I2tlTWB7Ulvb7bT007Rq8isMyfSeNM23re4Zzk0972VAFpACtRKi08g
 8ZQ+hiScCrBNaIq6W/NicThnMD4CtJBlaDmc1aNyKk3VwGnmRntk4LqNSxyaRRpA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kummd2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 17:59:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OG4c7i026864;
 Tue, 24 Mar 2026 17:59:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275ku30b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 17:59:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62OHxD8e24511224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 17:59:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A63C58054;
 Tue, 24 Mar 2026 17:59:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C4925805C;
 Tue, 24 Mar 2026 17:59:12 +0000 (GMT)
Received: from [9.61.9.100] (unknown [9.61.9.100])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 24 Mar 2026 17:59:12 +0000 (GMT)
Message-ID: <a6fc0e1c-30d2-4c37-9df2-0bec2b8d30fb@linux.ibm.com>
Date: Tue, 24 Mar 2026 13:59:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/15] s390x: Add support for virtio-blk-pci IPL device
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
 <a626d134-7664-4b5c-8502-016b406d75d6@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <a626d134-7664-4b5c-8502-016b406d75d6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LAzz-PBP7Js0Qk92ZEWUyqGlfTRFk7g8
X-Proofpoint-ORIG-GUID: LAzz-PBP7Js0Qk92ZEWUyqGlfTRFk7g8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOCBTYWx0ZWRfX5fPBjsqEc6VR
 S39N4P1qUzq4u8Q3KMjpuUj96hF+souA7s8r2N+I/0F0Lt1EgSSPjJPfP1B3FNP94H+6b0472G+
 oYXkS0mVk5zashW2Hnwuv8j575a7vcuvn5iCcwvglh6pZvByrNK+FADhmaC4UqZi2AnZ3xJOdiX
 TeJ7YOvQgVpqKcf3gVMPeZ5SZ6yjbQ/JeZWH2uDI8T6U76zlusyb9vi8egu7U7VzGc7z9YTZXvI
 uDZunyRtL75xofgcOjb4KI1AGlWAW+1KRSB09dZd0xlm9uJWXmRFCbulByroaatzsLxdhBFk3Ay
 kiqtCAbuIVoTwNGWc2CeYrh22YmBmWNm0tQz7ns4bGVhhWCINemDhWxYYhNV4lo+1jyJxf+I95u
 /t98UBM5lkRvOctDigmRE636idYlQP5Wn4PoF0g8O7U+wE4kcCwJfd5ye82cupv4ysA82Oxyfde
 kaPaYFobvIGC38WcCJw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c2d0f3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=D9NKTAG4h-MaFii59fQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 3/23/26 12:55 PM, Thomas Huth wrote:
> On 09/03/2026 01.35, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> This patch series introduces an IPLB subtype to support PCI devices, 
>> which may
>> be built if a device has been assigned a boot index and is identified 
>> as a PCI
>> device with a corresponding s390 PCI Bus device.
>
>  Hi Jared,
>
> FYI, today I noticed that in some rare cases (maybe 1 out of 50 
> boots), the loading of the Linux kernel from a PCI device still fails. 
> I filed a ticket with a reproducer here:
>
>  https://gitlab.com/qemu-project/qemu/-/work_items/3350
>
> Maybe there is another virtio_reset() missing somewhere?
>
>  Thomas
>

Hi Thomas,

Thanks for identifying this.  I will investigate.

Regards,
Jared Rossi

