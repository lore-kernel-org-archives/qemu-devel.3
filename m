Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8756DD46623
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 21:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgUTR-0000MX-Fx; Thu, 15 Jan 2026 16:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vgUSh-0008Li-Ng; Thu, 15 Jan 2026 16:01:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vgUSf-0005U0-Q0; Thu, 15 Jan 2026 16:00:59 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FF6SVA019683;
 Thu, 15 Jan 2026 21:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hOr0/f
 N/U6ue1ivyUjvqQcstc9IJ4uXFEJkk0nfRc4M=; b=VDf65Lf1ytZN+Ys4JwGlJz
 XOP281OlhmBg3WKY9ShYC3CfyniTBawq+pf4gKHZYjWoQOavrqZ4TCOxUUde4EFh
 RsnNEYc2e7SoYpg6Ulq+L7FDEMdycxtzFeFRb7LKDDpWzwNwCq9ebQB7RveOt59s
 FG5mkvg5GB6ebL/JBLpvtvsRAkmu5X5RRfvlIj1KTUem1GX3Tu5ppboHwyLK6k58
 FdvzD6LteLfgqO6Qd1sgN91hwxzyHoKcYCr05/hdr+oAasEUnY4/xLGfpxHuyrTo
 1+6gAhkiTM0K2pGDvz+FpFE+p7YF0Sm0dHRyyXAaI+doJ1nZ5tHdw3GzH1nufHXA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6hgdb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 21:00:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60FKxW2n025838;
 Thu, 15 Jan 2026 21:00:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kktesu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 21:00:53 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60FL0pk062980574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jan 2026 21:00:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9019958054;
 Thu, 15 Jan 2026 21:00:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFEE958045;
 Thu, 15 Jan 2026 21:00:49 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 15 Jan 2026 21:00:49 +0000 (GMT)
Message-ID: <44ded28e-2c8c-426c-8cb2-7364b6bfe8a0@linux.ibm.com>
Date: Thu, 15 Jan 2026 16:00:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/29] s390x/diag: Implement DIAG 320 subcode 2
To: Farhan Ali <alifm@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-10-zycai@linux.ibm.com>
 <b3a03c68-c011-43e8-8c85-e14fb7f39399@linux.ibm.com>
 <d31a747f-d2b3-429a-9ee1-924e55ea3aea@linux.ibm.com>
 <63047cd8-76da-41e7-bd71-ea569f158234@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <63047cd8-76da-41e7-bd71-ea569f158234@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vyEjmIjIewdxBzJV6TysSEkohTr9_3NA
X-Proofpoint-ORIG-GUID: vyEjmIjIewdxBzJV6TysSEkohTr9_3NA
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=69695585 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KqAmC-_ZIRpAcpYzGWYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE2MyBTYWx0ZWRfX4DREC4GAYhHF
 AdFxZgCNLIvr7rdYFCOgDnghaU2s4D/uBxnyVp9Dj66sWhfTfiMdFI/mEP6iDXOwpzCcUGaK4P0
 kpeuhULqh/z4mJ6F8HBd40CyeY8HNOdXdT4Pquf9yiKSECE4CtMT+su/7nNy858h7ef3pnmSupk
 PZyHikE4YaRDTl0txQ/kwasvBFuuo3eg2vWQXcubBAjuqlCnFrDLzS9gIqSXmlRYPovrpk0UPjX
 MKZZdvAkZmvYoz3KsgyAwQhmmwUaIaAZfHkGENOfdx+ScXfGXT3R9aszrRGSfAZMTmIfdNXyIpO
 nuFehLMawK+rZJiSQgPcMhkSspf2mdJnGJscZIynWBDXNoXi3+In0T6L7NnUZNmRoshl9zECJt2
 utELcMLOGbLmhFONm1xgNib+dAaq8jIupG7NHEuY2OKVfr5ptIvA01K1yC7kS2VHHsIn0oS3VUp
 USaZeeyB/O8C8tW2jOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_06,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601150163
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/14/26 18:06, Farhan Ali wrote:
> On 1/14/2026 1:54 PM, Zhuoying Cai wrote:
>> On 1/8/26 5:54 PM, Farhan Ali wrote:
>>> <..snip...>
>>>
>>> On 12/8/2025 1:32 PM, Zhuoying Cai wrote:
>>>> +static int build_vce_data(VCEntry *vce, S390IPLCertificate cert)
>>>> +{
>>>> +    uint16_t keyid_field_len;
>>>> +    uint16_t hash_field_len;
>>>> +    uint32_t cert_field_len;
>>>> +    uint32_t vce_len;
>>>> +    int rc;
>>>> +
>>>> +    handle_key_id(vce, cert);
>>>> +    /* vce key id field length - can be 0 if failed to retrieve */
>>>> +    keyid_field_len = ROUND_UP(be16_to_cpu(vce->keyid_len), 4);
>>> If we fail to retrieve the key, does it makes sense to build the VCE? I
>>> think we need the key to verify the signature of the certificate, so why
>>> not mark the certificate as invalid?
>>>
>>>
>> The key ID is used to identify the public key in the certificate, but
>> it is not utilized in the current patch series. Therefore, I thought it
>> would be acceptable to continue building the VCE without this field,
>> though I am open to other ideas or suggestions on how to handle it.

With respect to the VCE, since the key_id is used in neither the secure
IPL process nor the kernel, perhaps remove it from the data structure.
I don't see a reason to waste precious BIOS memory holding onto it
otherwise.

> I looked at the kernel code again and it doesn't look like the kernel 
> uses the key information today(arch/s390/kernel/cert_store.c). So maybe 
> its fine to continue building the vce today. But IMHO it's a little odd 
> that we are marking a certificate as valid even though we have an 
> invalid key field.

I agree with Farhan.  It's still important to sanity check as much of
the certificate as possible to ensure its validity before continuing.
The better approach is to handle any errors that arise with the key_id
parsing.

-- 
Regards,
  Collin

