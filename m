Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EAEC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4JeE-0006uk-Gq; Wed, 09 Sep 2026 10:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x4JeC-0006oh-Cn; Wed, 09 Sep 2026 10:51:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x4JeA-0007rx-5n; Wed, 09 Sep 2026 10:51:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689B1riS2666426; Wed, 9 Sep 2026 14:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wLOfP+
 uWGOQGbhZjmMqXVrEI+0XuYOp/S3AE6PBozbk=; b=fh+VakPiCvZ4FT0B5Sz3uk
 /dj1AIyK5YrpbtwbftHi+AeUc4hcEJnpx7BvsBBF1T7j3zSoWmG1/I/IgnwHf7EH
 68B2cdIS/T48DHgmZtbbmMQvh8qQXH7fE3Xx6/pTyw5hWmWJqTzmI1Jsaq913jMK
 jFExrWE3P1jULIG8Bxb1N3npMvR95D5GMOOT2NyFoFIhRrg0zALgnvpOtSZdk3N1
 SbmXxdfnvB1gj7+amxk1aaIh8WX+vGjGhcbial/TT1V4UNb0/zOq6BMyxP9Yx5Gq
 PHDtGFQUD3LAK/tmIb2Kmbs5igDFnPiFKx+hMlEGxn+jYL5Nl1z+rq6d2cWR+9Kg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrx6tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 14:51:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689EfF1W002345;
 Wed, 9 Sep 2026 14:51:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwswaxyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 14:51:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 689EpSx027853380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2026 14:51:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF76E58068;
 Wed,  9 Sep 2026 14:51:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0F2D5806A;
 Wed,  9 Sep 2026 14:51:27 +0000 (GMT)
Received: from [9.61.97.36] (unknown [9.61.97.36])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Sep 2026 14:51:27 +0000 (GMT)
Message-ID: <b2ecb508-3485-4c3e-bee5-6d09548618fb@linux.ibm.com>
Date: Wed, 9 Sep 2026 10:51:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Extend secure IPL support to virtio-blk-pci boot
 devices
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 mjrosato@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com
References: <20260903155805.1881366-1-jdaley@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260903155805.1881366-1-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa17272 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=-ZRkNidKPp__wogR8t8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2MiBTYWx0ZWRfXzhzeXqIdJ5kT
 qA/lSJTE9pAJEI2yImpCFIaj+e4j1Su19wnnZBR2eHZDBS9ElXNbJ+UbtZDJ/0NVs7vxxe47jpm
 CmGDZVBjlpRfqXJMCbKuUwVytb69aJA=
X-Proofpoint-ORIG-GUID: rkJwIbgfg3L9WsIjsR-30S1KUV0h-lAY
X-Proofpoint-GUID: rkJwIbgfg3L9WsIjsR-30S1KUV0h-lAY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2MiBTYWx0ZWRfX1RYK6fCe4szC
 9FzOzGVWaNx4Q/3xJ4lWqIKnGmGdH+QDUBed/N/qAhns4+MOGohgtQf/dwYAniuICpdhQOBurHf
 us2eRmrZtdbfPouU9PIj2fpVl0VgGiTVi9dFD9hEg6gwNfW4+7p5vbaY8IHi8pphAH+iaBjbdST
 obtkAAZNHOxKnKA3yQtvKXZbB9yfJR/lITx9gW3a1X1fLtmxYKlbBmiNNh8mK3jj2q/pKS16k56
 v9G1P0mnJb+78+7bJu08qDwkHJWVMKGQRnbSQlFN7qxeBJTPa/PhJMJ6BHMgJJLDwaTR/l3zVxy
 C5lBop4448HebTImjEjDBlWWcdpvGYl2fPHQa3pwfT6XEJZSt84JQBO1kYG93nC+DWMnnlDHz4R
 NdB16MC0j8NFCZ+yEtwkIen+mTlrbQ55NHgdnKdYC478PYLs8nNp5eTNeZcg9Rtic3mdZMGPi0N
 xkj8YyskpihVlm5NBrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090162
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 9/3/26 11:58 AM, Joshua Daley wrote:
> Changes v2 -> v3:
> 
> - Patch 3:
>     Added _host_lacks_sipl_support flag to skip vm setup if
>     we've already found that the host does not support SIPL.
> 
> ---
> 
> v2 cover letter:
> 
> Changes v1 -> v2:
> 
> - Added RB tags to patches 1 & 2
> - Patch 3:
>     The setup step is now run only once, as originally intended.
>     setUpClass and tearDownClass manage a shared workdir for the
>     subtests to use. Instance vars are now class-level vars.
> 
> ---
> 
> v1 cover letter:
> 
> This series is based on Zhuoying Cai's series,
> "[PATCH v17 00/34] Secure IPL Support for SCSI Scheme of virtio-blk/virtio-scsi Devices"
> https://lore.kernel.org/qemu-devel/20260730214624.2328883-1-zycai@linux.ibm.com/
> 
> Note, the above series is based on Cornelia Huck's patch,
> "[PATCH for-11.2] hw: add compat machines for 11.2"
> https://lore.kernel.org/qemu-devel/20260723163806.368127-1-cohuck@redhat.com/
> which requires a small fix to apply (see Eric Farman's reply).
> 
> ---
> 
> To add support for secure IPL with a virtio-blk-pci boot device, we simply
> write secure boot flags to the IPLB when using such a boot device.
> This is achieved by calling s390_apply_secure_boot() in the PCI boot
> device case of s390_build_iplb().
> 
> The secure IPL functional verification test is updated with an additional
> subtest for the virtio-blk-pci boot device case. To run the FVT:
> 
>    make check-functional-s390x MTESTARGS="func-s390x-secure_ipl" \
>    QEMU_TEST_ALLOW_LARGE_STORAGE=1
> 
> To test secure IPL yourself, view the "Secure IPL Quickstart" guide in:
> docs/system/s390x/secure-ipl.rst
> 
> Joshua Daley (3):
>    hw/s390x/ipl: Add secure boot support to PCI dev IPLB builder
>    tests/functional/s390x/test_secure_ipl: Skip test if SIPL not
>      supported by hypervisor
>    tests/functional/s390x/test_secure_ipl: Add virtio-blk-pci boot dev
>      case
> 
>   hw/s390x/ipl.c                            |   8 +-
>   tests/functional/s390x/test_secure_ipl.py | 157 ++++++++++++++++------
>   2 files changed, 116 insertions(+), 49 deletions(-)
> 

Applied for 11.2. Thank you!

