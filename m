Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE3FCA5FD6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCIwl-0003DF-8V; Thu, 01 Oct 2026 11:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xCIwc-0003A7-0F; Thu, 01 Oct 2026 11:43:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xCIwa-0004Hu-2L; Thu, 01 Oct 2026 11:43:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691DbEt51889786; Thu, 1 Oct 2026 15:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9tq1jq
 +7nWAVIEv9UdG/nSono4ibzhnaSWn2stkxD4Y=; b=LHBFItCMCVKzvJpJCLCDCu
 1M1iET7dZkNj20/qrnE3+GEkz8nZHSBwJZa2ODoQ+GxibHTqNdJDlvxv0oBH6opK
 rdkFOB48Buoxf6HYpbPDAb2ZADC+JOaWhYpQjr3dxdwMvF+hcKAMdK9SI9NBWJrL
 MtYAGX7lTKiKhxUKc/QBncucOAfjFs91yBZjEIfJTsJ85PYw9VA7fmA4dxXHtsOL
 bvZKyEixLxIbf0+4ECAiGTC037eMjGqHhsXdOldOUPfxaBfleU2ol/lBALrkKdKZ
 qMOnuwViE6FVBPHldi7A84wODzePRwx4dmuSnGwxN6NAZSHm+p3p8gMVoibph2aw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptjvad-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 15:43:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 691DlU2t1043320; Thu, 1 Oct 2026 15:43:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7ukkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 15:43:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 691FhTs041877990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Oct 2026 15:43:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84A7558054;
 Thu,  1 Oct 2026 15:43:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A78DB5805C;
 Thu,  1 Oct 2026 15:43:28 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Oct 2026 15:43:28 +0000 (GMT)
Message-ID: <07bbd091-14fc-4767-92ee-6c2241755d9d@linux.ibm.com>
Date: Thu, 1 Oct 2026 11:43:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] s390x/pci: Add PCI error handling for vfio pci
 devices
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
References: <20260922171756.920-1-alifm@linux.ibm.com>
 <20260922171756.920-2-alifm@linux.ibm.com>
 <2ee98743-546b-4726-904a-6fe828dbb175@linux.ibm.com>
 <28cc3141-6db8-418d-bd7f-5ed6efe51a01@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <28cc3141-6db8-418d-bd7f-5ed6efe51a01@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U3Wem6qtNTivYIzOrmOAixz-YKQwnQOy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2MiBTYWx0ZWRfX5+I2GWE2MMBG
 6KQT47o7Z/N0uL4QZEVjR68y+n2X1Pluv99mNJ3BmQs+hvsOvVOjh41Ka+aA+YRBRoOEACfAe0Y
 9G3wexkuzK6MDCioNwRma36Cg6Y8z+BHc0xwR6vRxRO3NrDkaSub0bSHl7nkaSa0oBqkmQfCXBU
 /9e37qV9UuVHFfOzEYlDfalfLMbl8S1IWpDg2Obtd3WjouRJ2doKooRfJA8uFwaKxScsqq8yP9d
 Ngnj5ndZV9WJnQe2DlSdEV8yHtJmayLtJlzR0aTW1q4icgtIclc6Dl5celpXMN57hEzn4Cj6vIL
 XJbCitm1qom8HdnnT9phdoIKzX7XnjgAmDyypUPb9EB53CFDdhrxnfN+JFJ/S1vjgDoU3sHbJed
 75+hfrBkiegt2Th4n+rydNdJrtdP+q/Re7Ame9fNzc7PdnL/V2geoQ8I1acfyO553UoyMxnA69G
 2fDLKyUii7KRmjlL4HA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2MiBTYWx0ZWRfXzLB8bsS+TAqa
 3WJ7CBfTgPFmK8QqbmsFJ+aKNKa2TCL5MvNOkfW8NJ1sSJ4Y/pyinv3kCyhy5QeLg/0ZDtFXY3Q
 b0iS9hGjm7kmI0eIdGkQHSOLAgKcOFI=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe7fa3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=P-IC7800AAAA:8
 a=Y8FCvOAAzpBorN9fmocA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: U3Wem6qtNTivYIzOrmOAixz-YKQwnQOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010062
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

On 9/30/26 1:46 PM, Farhan Ali wrote:
> 
> On 9/30/2026 9:30 AM, Matthew Rosato wrote:
>>> +static int s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
>>> +                                    PciCcdfErr *ccdf,
>>> +                                    uint32_t ccdf_err_length,
>>> +                                    Error **errp)
>>> +{
>>> +    ERRP_GUARD();
>>> +    int ret;
>>> +    size_t total_size;
>>> +    struct vfio_device_feature_zpci_err *err;
>>> +    g_autofree void *buf = NULL;
>>> +    g_autofree struct vfio_device_feature *feature = NULL;
>>> +
>>> +    total_size = sizeof(*feature) + sizeof(*err);
>>> +    feature = g_malloc(total_size);
>>> +    feature->argsz = total_size;
>>> +    feature->flags = VFIO_DEVICE_FEATURE_GET |
>>> VFIO_DEVICE_FEATURE_ZPCI_ERROR;
>>> +
>>> +    buf = g_malloc(ccdf_err_length);
>>> +    err = (void *)feature->data;
>>> +    err->data = (uint64_t)buf;
>>> +    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
>>> +
>>> +    if (ret) {
>>> +        error_setg(errp, "Failed feature get
>>> VFIO_DEVICE_FEATURE_ZPCI_ERROR"
>>> +                   " (rc=%d)", ret);
>> I see this was changed from last version, but doesn't this fall under
>> 'avoid useless error object creation and destruction' described in
>> qapi/error.h for the -ENOMSG return value?
>>
>> We create it here only to explicitly destroy it from the caller.
>>
>> Can we instead switch to the negative/non-negative return structure with
>> something like...
>>
>> <0: error as defined (so we set errp)
>> 0-N: number of errors to process (and we do not set errp)
>>
>> For the non-negative case we can realistically only have 0 (-ENOMSG maps
>> to this) or 1 (the feature found something - it is reporting 1 error to
>> handle).
> 
> I was trying to follow what I assumed to be existing pattern for
> handling expected errno[1]. I am okay to change it, but I would like to
> understand what is the preferred approach here.
> 
> [1] https://elixir.bootlin.com/qemu/v11.1.2/source/hw/vfio/iommufd.c#L408
> 
AFAICT the example you provided is using a shared routine where in some
cases the errp generated for -EINVAL is actually propagated vs just
thrown out immediately. (see line 483 of the same reference)

In your case, this isn't a shared routine and the errp associated with
-ENOMSG will never be used.

But anyway, I think we're at a point of semantics.

You made this change based on [a] from include/qapi/error.h:
 * - On success, the function should not touch *errp.

And you've done that successfully.

But I'm complaining about [b] from the same file:
 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.

AFAIU, the point is to always have an errp when there was a failure, and
to not have an errp when there is a success.

Do you consider the -ENOMSG return from the ioctl a success or a
failure?  It seems like a success to me (the ioctl worked, there was
just nothing to get), but you're treating it as an error case.  That
satisfies [a] but I'm suggesting it violates [b] since you create an
errp that is guaranteed to never be used.

So as for preferred approach for this: I would prefer not to create
Error objects that are guaranteed not to get used, but I will also not
reject the series on that alone.

Thanks,
Matt

