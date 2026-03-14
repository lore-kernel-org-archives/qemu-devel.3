Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D047510706EA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 16:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1S0v-0007ml-VH; Sat, 14 Mar 2026 12:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1w1S0m-0007lZ-IB; Sat, 14 Mar 2026 12:38:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1w1S0k-0001Yw-BN; Sat, 14 Mar 2026 12:38:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62EDF5G81391237; Sat, 14 Mar 2026 16:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SfdDlz
 m7pOBq56cNHM7kUhJUhZGcBAECDMq2WjVjXhk=; b=JIMgOtk2BrgtEiMOYBFAil
 1r2ZXlEOetI2O/FeYfFQUR3zO17P4iTVV5VUCGUdsiqTkBJuFJ6LC6crOozjMqk/
 8cA18DqejYSxGC7OfdVXBf6LRPjZXC++J0aKGoZ09zgsvLmCDa/WD1ZZhrSKOUNT
 Dzaxzc0eqalqTRKkKLy12aILsj0XONMy1lb1lOKzfpU5tRV9mYHqgZJTduTRK1x9
 bsD9QrrS4eJjWd7gGw8uVPsuuk23ktkmZWWP1HdnP5nXOwr01dcu95SJaYKtvU4Y
 eXYrBb+K0cQrKhv/SRSgVMwshh54kp3sSTG2qqW++JrrJgCsMzvJjvSwI2RrHK4A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybrsq5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Mar 2026 16:38:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62EFnEvR025686;
 Sat, 14 Mar 2026 16:38:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8ju85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Mar 2026 16:38:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62EGcbBk29360840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2026 16:38:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCAB620043;
 Sat, 14 Mar 2026 16:38:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CE8320040;
 Sat, 14 Mar 2026 16:38:37 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.88.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 14 Mar 2026 16:38:37 +0000 (GMT)
Message-ID: <0a1a66b6-eaf9-4b31-b65a-4489d3f8db0f@linux.ibm.com>
Date: Sat, 14 Mar 2026 17:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] MAINTAINERS: Update the s390x maintainers
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org
References: <20260313113424.15583-1-thuth@redhat.com>
 <20260313113424.15583-3-thuth@redhat.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260313113424.15583-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b58f12 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=GV4ZO7Bm3-sm36HQjc0A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: IiiMMwFFJuHHLWeWx-_m0vsBkaaACKoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDEyNyBTYWx0ZWRfX0qvKVFV8wBF4
 t5jxr59rtN5Y6dn/sE6kSwQWfawrGgxtpRT7H7Z/lfOlMS+1yXXorEDIbHbSomdeAZMglrnX4p2
 vXskABMswK5QCes8fYpyv0+uq2PLRK2/V89cCUMZLp4rBrRQFqpl8eNUoQx/QWARpo3GrF+grhP
 RK894k1FpjUys3LvJsedXeCo2INqPy0+3LeJ8rbN3HJstEVA5B5j9YSjqsDbsMJyYGn5BH/8cuC
 pAXrLr1ZE0t29eWTj7EBNpphj/wHIPU0k/UUCwBw5gWgP5QeUCuyL471joPLgpEldfKp3aqO18g
 OnX+hwGGNII8KTE7cQZRra/BxuoObyJQyAAu0gbPZaIXVnEmmBB32isP/CO0FS9W4AUqy1tCzmY
 kKOPn8nHcKCdqbhX6wuzIl1sMJQNJh9anieS3Npf6l2CztX2KIHhIOUNTzkz0kVpI5flH/SCke6
 a8CCh3YdqYIA/2STVhw==
X-Proofpoint-GUID: IiiMMwFFJuHHLWeWx-_m0vsBkaaACKoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603140127
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 3/13/26 12:34, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> I'm going to move to another project next month, so I will not have
> enough time to take care of s390x patches anymore. Fortunately,
> Cornelia volunteered to take over the job of collecting s390x patches,
> and Eric and Matthew offered help to back her up, so we can keep
> the "S390 general architecture support" section in the "supported"
> state. Thanks for your help, Cornelia, Eric and Matthew!
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49e9b7dccbb..9a859e4133a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -102,7 +102,9 @@ T: git https://github.com/vivier/qemu.git trivial-patches
>   Architecture support
>   --------------------
>   S390 general architecture support
> -M: Thomas Huth <thuth@redhat.com>
> +M: Cornelia Huck <cohuck@redhat.com>
> +M: Eric Farman <farman@linux.ibm.com>
> +M: Matthew Rosato <mjrosato@linux.ibm.com>
>   S: Supported
>   F: configs/devices/s390x-softmmu/default.mak
>   F: configs/targets/s390x-softmmu.mak
> @@ -1862,7 +1864,6 @@ T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
>   S390-ccw boot
> -M: Thomas Huth <thuth@redhat.com>
>   M: Jared Rossi <jrossi@linux.ibm.com>
>   R: Zhuoying Cai <zycai@linux.ibm.com>
>   R: Christian Borntraeger <borntraeger@linux.ibm.com>

Hi Thomas,


It was a pleasure collaborating with you on the mailing list.

Thank you for all the work you've done and all the best with your next 
project!


Best regards,

Ilya


