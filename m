Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C281AC624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nkC-00025z-Uw; Wed, 02 Sep 2026 12:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x1nkA-00025P-BZ; Wed, 02 Sep 2026 12:23:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x1nk7-0005Gs-4c; Wed, 02 Sep 2026 12:23:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682G1ned2784389; Wed, 2 Sep 2026 16:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4fwjJM
 5usCiTKfuS02EIt7Ujf/0Xf1jCOrmpfPEzcH8=; b=IQtPdIfxRZg/EMZXut2wij
 72eiHj1tzL3yyR/iNyT1J2BO3Ue7KAkpnpqfGtQBPmGlrt7q3+8kQepNkEiZnP3D
 XHy0SK6bzQmz2ub0I/41rQN0ljB3tCGaB3PYycS0oxr+HKnWu/nXk3kDPUWzysiJ
 9IoC1ON80GsQel7MA2vd4cZWW7/ImRglSoHcK+AkyrUERILvY68zGkTGN5o/y204
 V2NWJAn+HoFWDXNm+2DeG1J3iwJGL0GXPPLlwKG2bllV9Orh3zb4PErZUNaLibzz
 1o45fmJE9m+D/Y0UcojHBDXsSmVe5ZRRnDfIBieo43YFbBTYUqs3ym+Dm2kFmf2Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rfx4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 16:23:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682GBI30007207;
 Wed, 2 Sep 2026 16:23:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygjsbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 16:23:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682GNDk430212780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 16:23:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CA2758054;
 Wed,  2 Sep 2026 16:23:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AD5F58050;
 Wed,  2 Sep 2026 16:23:12 +0000 (GMT)
Received: from [9.61.241.1] (unknown [9.61.241.1])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 16:23:12 +0000 (GMT)
Message-ID: <2bd79117-a66f-49b9-a936-592ad2e00ceb@linux.ibm.com>
Date: Wed, 2 Sep 2026 09:23:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] vfio/pci: Add an error handler callback
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-3-alifm@linux.ibm.com>
 <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
 <87ecfc3pj6.fsf@pond.sub.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <87ecfc3pj6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a984d73 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=UqCG9HQmAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=arvWr4xHkTDzlkb0T44A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MSBTYWx0ZWRfX9GBcIuZB/m6n
 z1L63qqQHfL12XoHPIN4zmgLwubg3d2nEe/OeFxo5Fc8iBvSp+JaEPt6drSRD4wJBFi87gBWg7S
 2A7sbRJLJrwpigaTEgitIRFavXmyHGZW/EU40cdjCbhvUPLHidcyXAwWyIvNAHjdM65KupvsHes
 s5k2ya8HX2DaDrXQyKT1zcUOorCPzvb4YVViiK3VQTi74ytMXkN86ZVx2b7HV4maHMGslnumuLX
 k90Bu22aY7jzPKf0xpmBhlJEpO0GgjdSdfWH+jqWb2neEtXxMUBnQ1ATAHXoTE+s1lB/uEHK9a5
 CtFy5TQJS8H/8b3CauIu/h35BHjMkCRY0C6F9lHzccZh8Hy+m0Z+dx/RAU3baSEGmxN33sCfcHG
 VspbO7kBJKuQwgJRJCpDy/GYit8EbULNbwa9UOhWBXrzWAru96XFe6+QX7pm4f9+JIq4KAT2Tli
 OljCeBBkrUTeXHpKfxA==
X-Proofpoint-GUID: d8r902DPFQt44KBxZp-lw54svGtrKwVk
X-Proofpoint-ORIG-GUID: d8r902DPFQt44KBxZp-lw54svGtrKwVk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MSBTYWx0ZWRfXxNTdDMMhDolg
 g0Vdsz8CJnERCSgvrMF1aBIb7Sj90nUbfRWkLzjYSHm28K57/z3cFByDU/XEz4jDuuReoAxi3jx
 vMzjJL8m/l3TJlLWL+fExSKnc9yuO60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020141
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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


On 9/2/2026 3:39 AM, Markus Armbruster wrote:
> Cédric Le Goater <clg@redhat.com> writes:
>
>> +Shameer, who is looking at forwarding AER errors to guest :
>>
>>     https://lore.kernel.org/qemu-devel/SJ0PR12MB8614DDFEE3A9575564EDEF99ABFF2@SJ0PR12MB8614.namprd12.prod.outlook.com/
>>
>> On 8/31/26 20:31, Farhan Ali wrote:
>>> Provide a vfio error handling callback, that can be used by devices to
>>> handle PCI errors for passthrough devices.
>>>
>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>    hw/vfio/pci.c | 27 +++++++++++++++++++++------
>>>    hw/vfio/pci.h |  1 +
>>>    2 files changed, 22 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 428ab2f069..a2f489b34d 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3244,21 +3244,36 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>>    static void vfio_err_notifier_handler(void *opaque)
>>>    {
>>>        VFIOPCIDevice *vdev = opaque;
>>> +    Error *err = NULL;
>>>    
>>>        if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>>            return;
>>>        }
>>>    
>>>        /*
>>> -     * TBD. Retrieve the error details and decide what action
>>> -     * needs to be taken. One of the actions could be to pass
>>> -     * the error to the guest and have the guest driver recover
>>> -     * from the error. This requires that PCIe capabilities be
>>> -     * exposed to the guest. For now, we just terminate the
>>> +     * We can retrieve the error details and decide what action
>>> +     * needs to be taken in err_handler(). One of the actions could
>>> +     * be to pass the error to the guest and have the guest driver
>>> +     * recover from the error. This requires that PCIe capabilities be
>>> +     * exposed to the guest.
>>> +     *
>>> +     * If err_handler() is not implemented/fails, we just terminate the
>>>         * guest to contain the error.
>>>         */
>>>    
>>> -    error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
>>> +    if (vdev->err_handler && vdev->err_handler(vdev, &err)) {
>>> +        return;
>>> +    }
>>> +
>>> +    if (err) {
>>> +        error_prepend(&err, "Unrecoverable PCIe error detected for device %s",
>>> +                      vdev->vbasedev.name);
> This requires use of ERRP_GUARD().  See "Why, when and how to use
> ERRP_GUARD()" in qapi/error.h.

okay, I can add the ERRP_GUARD(). AFAIU it will then look something like 
this?

Error **errp = NULL;
ERRP_GUARD();

if (vdev->err_handler && vdev->err_handler(vdev, errp)) {
	return;
}

if (*errp) {
	//print error with errp
} else {
	//generic error
}

Thanks

Farhan



