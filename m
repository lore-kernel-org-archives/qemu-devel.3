Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3390BCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKHBn-0000ku-2d; Tue, 05 May 2026 10:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKHBd-0000kC-BC; Tue, 05 May 2026 10:55:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKHBa-0003Ke-Rq; Tue, 05 May 2026 10:55:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6456vE8l3189768; Tue, 5 May 2026 14:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Jv8L4W
 4wToDOP+sP4QST+lleD5k6Pbf5BJjYH3oPUJE=; b=dF3GxItspN0uP3j8d0ctcM
 1vZc6rU8sL3mPFj1PjmSKRbtAHn3+o78wPd0BvowKuxlkiIa/NOQI4+HO3shRxYK
 yhmnYPaNxdTEdemgdTVhhhRcD8PM/lHDejSFH2BoXJ+jkS9HdvW/WcEChsOIcvQ+
 6NXy4pOenJ4QM5lGZ0Vfhua7fZnVlCM9LxYJ1uj9LSer/SiR3MHYGDVpS5ooFE4k
 eLhc+z6LDktU5csGQRlx8ioShhk4+njqjw7DQUQfKkai4R1FqfPCTJbA15MwfMhz
 pnPFq5iz1oBAZvwyGIWrTMrK2OPqnE8t//3htu1dzLDc4lKhSC4CQmOofH8uBS/g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxkuw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 14:55:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645EObfW016971;
 Tue, 5 May 2026 14:55:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjt2s6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 14:55:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645EtZUs30802542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 14:55:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E058E58052;
 Tue,  5 May 2026 14:55:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1339758045;
 Tue,  5 May 2026 14:55:29 +0000 (GMT)
Received: from [9.124.208.117] (unknown [9.124.208.117])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 14:55:28 +0000 (GMT)
Message-ID: <a82978fb-98d6-4538-abac-db6c9212d396@linux.ibm.com>
Date: Tue, 5 May 2026 20:25:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] pnv/phb4: Implement read-only and write-only bits
 of registers
Content-Language: en-GB
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-5-saif.abrar@linux.vnet.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260305060923.3753402-5-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0MCBTYWx0ZWRfXxZs2SG6mKsiM
 gocTG1HVlVxMauH6IuDQYPe11/P8RqEEGjAWfs2p3w5DdvyvQNcfCIT46EITaKVrYpzzqN+uCc9
 YfXDVncUDY5VqHRel1Q8I+x7xR+5/5mwxsjOMDRVRIw4jx7+i9rJ0AdH146/EtGkipf7sZx3A5p
 s2PiaaEPogRxih5xWjH11fgv8lYbHAmrG4Yo3k2ajJyt5vy4AG7+r+fT+ZgF8Q0oM1o3YaemPup
 bvNnSlxtXYedrdzdj5sKZprGjrVE7d14bjJ9ckMlEQf11o/Ik0+aRXsRgRvqRkBQznpl2cNarbk
 rFkow/bP+94VifZ0SbnT+a4DgeXTRlZ4rt2mQUBaMFgTroBdvgLTs7kyt5fE+Q2tBFHFuHwH0bF
 VdSt5u5vBnbnGWcpi2Mkx8FPUrJHbKHLXn4xSGOWxcvIvsQ0Xxkg0zao4ioeTlF/ZjyARD5Ds51
 SkqAU7r7lhQbqYLFwZw==
X-Proofpoint-ORIG-GUID: LPnSkg74FdvkEe2NzSgJrNFfrb0mkYgB
X-Proofpoint-GUID: dGCQHKZk-hz5uHpVj3_slxb5DuzIc2N1
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fa04e8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=4ttVWu--HP89ghpr01wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 05/03/26 11:39 am, Saif Abrar wrote:
> @@ -1755,6 +1819,9 @@ static void pnv_phb4_instance_init(Object *obj)
>   
>       /* XIVE interrupt source object */
>       object_initialize_child(obj, "source", &phb->xsrc, TYPE_XIVE_SOURCE);
> +
> +    /* Initialize RO-mask of registers */
> +    pnv_phb4_ro_mask_init(phb);
>   }
>   
>   void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb)
> @@ -1934,6 +2001,7 @@ static const TypeInfo pnv_phb4_type_info = {
>       .parent        = TYPE_DEVICE,
>       .instance_init = pnv_phb4_instance_init,
>       .instance_size = sizeof(PnvPHB4),
> +    .class_size    = sizeof(PnvPHB4Class),
>       .class_init    = pnv_phb4_class_init,

PnvPHB4Class is introducing per-register RO masks which is supposed to 
be a class data, but this is being initialized in instance_init which is 
odd. Shouldn't this be taken care via class_init ?
I am not a QOM expert, but this looks like a design issue.

