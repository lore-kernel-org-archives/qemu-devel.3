Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748F7CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVBVi-0001No-79; Thu, 04 Jun 2026 13:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wVBVb-0001F7-HL; Thu, 04 Jun 2026 13:05:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wVBVY-0006Pz-2r; Thu, 04 Jun 2026 13:05:30 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6547bsD72666058; Thu, 4 Jun 2026 17:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kh4113
 J+s6OAmwkIx4eGyI0EMlsjgGeeFEFeG0UdQlA=; b=JgrKkImUyYOkc5w9lSAGZo
 Pd93+YmJjJnjZt1NuVfz2Rt+8945PRdQGZhDJkRhKwgofnx8El41Z0dh7a7f2Zg3
 VXDZlyoCfe4gqmQd7s5aEgnox7v55r9zJeLz1ueJsf2/FwKteORGTdWaV0svfc2Y
 YQBj0TDWw8LMJvYBKMjb1ecbWQw8ldHOAYoqsy+vLSzVyHqK5yKfI4FeoW1EP9Cs
 VNhCD3jo4sEg0Iuui+QE3VZjD4eBPEw83KO5WTiID/S2Kl5Vft2+GeSMs/68Izmy
 kBj7qmyB0iG1SNjvc7hU68fC8RzIPLJXy0AJuIqX7YLD679GjFotr4dTu1ZGJwVw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtg7f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2026 17:05:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654Gd7SR020936;
 Thu, 4 Jun 2026 17:05:05 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qp75r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2026 17:05:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 654H53hj21496454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Jun 2026 17:05:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 981BC58065;
 Thu,  4 Jun 2026 17:05:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A51658052;
 Thu,  4 Jun 2026 17:05:01 +0000 (GMT)
Received: from [9.61.150.19] (unknown [9.61.150.19])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  4 Jun 2026 17:05:01 +0000 (GMT)
Message-ID: <b7766539-ecad-434c-b191-231665f572ea@linux.ibm.com>
Date: Thu, 4 Jun 2026 13:05:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] accel/kvm: Remove need for
 AccelCPUClass::cpu_realize
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anton Johansson <anjo@rev.ng>,
 Claudio Fontana <cfontana@suse.de>, Eric Farman <farman@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Reinoud Zandijk
 <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>
References: <20260529194940.97143-1-philmd@linaro.org>
 <20260529194940.97143-6-philmd@linaro.org>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260529194940.97143-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8AtGoXBI4OtHsNOqzXof9lXTErzx2ivV
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a21b043 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=aGwGTAKf3ZeqeKgWoQ8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2MiBTYWx0ZWRfX8Mz7cPK1l/HC
 EHaTG16Ia4TV5Q1UbXicmsrbHbDnDzHhWpFOoLy6kbfjyh2SClrJOg8LJkLrCZdMaEthwri5rFR
 Hg/HMlaBlxV4X6uExW70LPSWYlyNW1lbQGdCgl0gtNL2JEwaIXZ2FUAhWpUUcBCmaPCWNtBeWz8
 VM3uCedX8u8hvS+kjp0gSvowILbUrbyYdl0kMdEQxtAdcAltVCyGD/OFQpaE2jZ/xuyRo/8xHuY
 SVn7gwuDxKudEnTaUJUNSAKEugVAtRevIZZIjH4JnjVDYs8qE+BbK/81jIMwms9dp5nSHJXL/qh
 263JCUGKm7foTpCDjmEPKx7hCvhgjOEcCzN2cE7u6Y7WojKG8I/hv+YLQTKY88kz2cHYbo53ZAT
 uCWyRmsmua8H82w8k6TdcaMmFrRcepiLH+HwwkQ8xWPaWMgf9sFK9/ph0zAzQ6YXrcQFJbVQlWe
 Dj5OpbCfnQ+/EOdWAOA==
X-Proofpoint-ORIG-GUID: Cz79bif9iYNnv7TYFdMn15K7CcuJH--b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040162
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 5/29/26 3:49 PM, Philippe Mathieu-Daudé wrote:
> accel_cpu_common_realize() first calls accel_cpu->cpu_realize
> then ops->cpu_realize.
> 
> Rather than having one handler for each host architecture, use a
> single host-specific method (prefixed with kvm_arch_* like other
> similar KVM methods). Register it once as AccelOpsClass
> cpu_realize handler. Add stubs for when a host lacks such method.
> 
> PPC's ACCEL_CPU_NAME("kvm") TypeInfo is  now empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  include/system/kvm.h       |  2 ++
>  accel/kvm/kvm-accel-ops.c  |  1 +
>  target/arm/kvm.c           |  5 +++++
>  target/i386/kvm/kvm-cpu.c  |  3 +--
>  target/loongarch/kvm/kvm.c |  5 +++++
>  target/ppc/kvm.c           | 23 +----------------------
>  target/riscv/kvm/kvm-cpu.c | 10 +---------
>  target/s390x/kvm/kvm.c     |  5 +++++
>  8 files changed, 21 insertions(+), 33 deletions(-)

For the s390x changes:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


