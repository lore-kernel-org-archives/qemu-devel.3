Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F81ECD37AF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 14:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLj78-0006SJ-4h; Sat, 09 May 2026 10:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLj75-0006Rh-Py; Sat, 09 May 2026 10:57:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLj74-0005wR-3z; Sat, 09 May 2026 10:57:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 649BcaZA254248; Sat, 9 May 2026 14:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=sDCTXgwOkZ/dzyZHJ+2V9W/rAooZzR
 3BbNm+VlS7Zo8=; b=CCgnipHjTm/b46rjDAB0QU8btkxmaPAw5lE7k942uPQA9N
 CQn3UcZVL82iQBVeJaUYaTJ14CjGnVLv9TlOszMj2LZKqbsvWdJrXCZ2BU0Y/WRa
 PQh+xK3eSQyV/kLgY70U18xegJWdATxeXUrLQMfEGJvEWax5GZcwCYC5s2K3LjZ0
 hh+KvYMYBQ0ZjU5DYVVULgjfqR4J4aKqfCvb6DaSaROLI3boZf0y94el2Ht7PaYY
 iKviH4OYCKP/Vulvza/21xduFrv2o3kGz7t04Atz3Xa2FjcbDL7MtNks3aJbbyxs
 k2kp1jsfRg6uE6OwRgI+ULFWnpLqNumVeM+l7kyA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve6sxry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:56:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649EspkT002668;
 Sat, 9 May 2026 14:56:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hmugj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:56:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 649Euox652232476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 May 2026 14:56:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 085F320063;
 Sat,  9 May 2026 14:56:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8A102005A;
 Sat,  9 May 2026 14:56:42 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.188]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat,  9 May 2026 14:56:42 +0000 (GMT)
Date: Sat, 9 May 2026 20:26:39 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
Subject: Re: [PATCH v4 5/9] pnv/phb4: Implement write-clear and return 1's on
 unimplemented reg read
Message-ID: <af9KzhspN6Suvb_Z@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-6-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305060923.3753402-6-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE1OSBTYWx0ZWRfXz92zWzRUkbKj
 dHqm9AC++fGiqsM1tbhh02JBhd7uIg4ayJzvVkspe+6YjEiqPKbv1cQdVPFbjGKH0uuzkz5ldle
 yLTbYm6l+g9LIphuUPf6Qp31dXm5DSx/m/Hp7IeZ1Ag9RrewLLzYC7hhVO2y5H9R8J3PA2RDPEc
 vxVQdg7wTc9EprnRDT8dXENke2MMw5SuNT1CGsMVOA4J6+TyoutPgKp5um5kYGS6maen0Q2jtmQ
 5LZXNwok4idiAVFQgKSjXj3OK+51TEyivqBfHtbFgkscFfNy2Y53B7KYoZ5HKZ5VrWa+lTzlgY3
 cpGDRZaK4c438Rsz3Si6TIMnxcMPpKvOUa2pfuF6skw9m264ftAUg5uOs0GDIFgRzg7LM8j9P3/
 PxWZm+QtwjOrepKbck+PjVUNSvmfk2qf1oMyqLsG1cQp/kDwHuFz4O3ZnNFuBn8BBsEYHis+1Kp
 giIsvFWHkhNAwdktBug==
X-Proofpoint-GUID: EFvmGBtnAEkMwqCiT2tUqc0XjXV9xvmB
X-Proofpoint-ORIG-GUID: z2tnj50ryQl0YzUMlZCxx2iSB8RCaGz2
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=69ff4b37 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=F6GtwFHsoswGsLgS7joA:9
 a=CjuIK1q_8ugA:10 a=QFZsRp3igpIA:10
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

On 26/03/05 12:09AM, Saif Abrar wrote:
> <...snip...>
> @@ -773,27 +812,63 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>          break;
>  
>      /* Silent simple writes */
> -    case PHB_ASN_CMPM:

few registers removed from the switch never got added back, eg.
ASN_CMPM, is it expected ?

- Aditya G


