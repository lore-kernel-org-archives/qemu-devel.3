Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688F2C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHg5-0005Ft-CD; Wed, 26 Aug 2026 13:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wzHfv-0004nt-R6; Wed, 26 Aug 2026 13:44:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wzHfu-0005Bt-6A; Wed, 26 Aug 2026 13:44:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1fNP3492819; Wed, 26 Aug 2026 17:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JWwRUU
 rIyxNecryzpojfdGJ4q/WUaMCAPCf23uYSqVM=; b=HTfU0nRCxcFYMh2C8OtxBq
 mwF37vd0HMDbkg3ho4+fk2A4MuSF6rhsUhT+srTNfBT0sOjGi+u8duAfYS1lmhhJ
 LmbcfTHaKzV7Zzjvf5GU8BE2Yg7mpyRa9NqvcSeBq7bnxYPBYEl+GRW+O84O0zsa
 s2uMn1WBJhr1H3lPrIcLi8Zf3uI15LKWUqdTEwxUqRN75BFKbWSwkmEqBAHyx3M2
 QnpLJcWLNLgz3INTLAasYoy9xPwjSWB1+w5MlGl0PArelM/J9q2pSsXjaNDrgWS8
 Ekbtf0sFvxIYYpsSIWFYBFmqkTMvy/pY3JvTzlatwHrTS2UrQ7qKKF1KcgbPXZ6Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726er4t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:44:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QHfTKV002032;
 Wed, 26 Aug 2026 17:44:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k38jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:44:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QHiUsh20775606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 17:44:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94E2258058;
 Wed, 26 Aug 2026 17:44:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1D0458057;
 Wed, 26 Aug 2026 17:44:29 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 17:44:29 +0000 (GMT)
Message-ID: <085b7ab3-a8a0-4170-8a35-bd1a723c8f02@linux.ibm.com>
Date: Wed, 26 Aug 2026 13:44:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] pc-bios/s390-ccw: Introduce virtio_tswap helpers
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-4-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260818205324.580199-4-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8f2600 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=t3pJS8pfw4iMo5hlopEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NiBTYWx0ZWRfXzy4LOKveUUMW
 vsAZuAxTCizkhRItcJN5vdWJg3JYmbMJ4diKdDLuPgrfMhdCkefHQrO4OFVVDlo89/lDv2IZ/qU
 PAFLlwNAgIzXy7I5t6hqZ8Ne49asS9Q=
X-Proofpoint-GUID: E7xhr2mfl6ZfExRwzp1IJ_6uX9CtfuR6
X-Proofpoint-ORIG-GUID: E7xhr2mfl6ZfExRwzp1IJ_6uX9CtfuR6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NiBTYWx0ZWRfX0H6xPTMJO1FD
 hEuaLjUOxzb5ul0rSP3g5VOBP8Q6UBfz/i2oG3SyS5z6amX8fPDoVv5OBSJ2hvIRbdzxtKTJhQl
 NTu+twD8ntEj59ngms6eJVHHUwVoQipP/30yXkiCrZjlskgz9KKPbDIWKVPDiFx2cX/yGF4RyVJ
 E+n4B4nOUvYbpS+e8SOwFEInE6LkW5sDnHMDyGz9nvLu6O5HE07O5anuSuaFORvsesCyQh2nlzt
 zNpd9t9Y5D+WY4EnDZ/2xBwTbXS1Q2gMxfCL7qDn7/ALPtHw2nM8sh1EFuwCxDYTjd1f6VQ7Hw0
 3zIVOxgy25GYFCQhjdpVwHQx7vTODGYmN7cZB+Fvkv9lxttZfL2Zmj3lgkvHvpDVhY7PSYxr3cD
 0bCdTQPCfh9CcVf6DNcnbx+QxcVOubWEOdzVo7jJuloJAEiCICACCeeJCOtcKYnmrtSpdW8G6Kw
 hJE5jTNn8JiuMjm/8sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260146
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

On 8/18/26 4:53 PM, Zhuoying Cai wrote:
> Replace the repeated pattern:
> 
>     be_ipl() ? x : bswapN(x)
> 
> with helpers that conditionally byte-swap based on the virtio transport
> endianness.
> 

Maybe worth a mention that while the 16 variant is used immediately, the
32 and 64 variants are setup for later use -- since they will
technically be dead code at this point in git history.

Otherwise:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



