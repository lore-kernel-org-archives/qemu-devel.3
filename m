Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0158FCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxCm-0003Zn-TY; Wed, 30 Sep 2026 12:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBxCb-0003Yo-Jc; Wed, 30 Sep 2026 12:30:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBxCU-0001T5-1e; Wed, 30 Sep 2026 12:30:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5Vxm2986288; Wed, 30 Sep 2026 16:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QkmmbP
 HaS+04YcG2ytwQLtsg5VyXpUIimScM1NujMJ8=; b=NlR/pC2Q55i4g2zw0NbH7/
 SZt1rICcHDQ5FI3ZSPDIO9ZpqZvvMzXdJhmIj7C7nE/jumGr4pb7Tm78proK29f5
 tyQOMcbwm2vHk9APw+aXdIF8IwoTCxkQd3rA2vFnBqxlzbTncsYNG0KcPtKwqXMo
 eplwOrzutKOGNKk4PMitJ2sPNajaZHMBGoUWcXivguWFQbvTQbvBhg/jt+GYTBCI
 gEBANn/0Ub60oAePCebGUsVUv/cLW+glvqEX2bXEKfTX/EYFYognaaLDsSZrQH8f
 lLx2nzhZ19F4ayAQDBx0+M7Wz14cYZ7Mnl032k43FS2XceEFKUBOi7WeTKN/aYog
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkdkn1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 16:30:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE34Dt3576911; Wed, 30 Sep 2026 16:30:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23mj87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 16:30:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UGUSWi9110020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 16:30:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D16AB58064;
 Wed, 30 Sep 2026 16:30:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1776458054;
 Wed, 30 Sep 2026 16:30:28 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 16:30:27 +0000 (GMT)
Message-ID: <2ee98743-546b-4726-904a-6fe828dbb175@linux.ibm.com>
Date: Wed, 30 Sep 2026 12:30:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] s390x/pci: Add PCI error handling for vfio pci
 devices
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
References: <20260922171756.920-1-alifm@linux.ibm.com>
 <20260922171756.920-2-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260922171756.920-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BT7rsyDW-S2LJLwhvtfrwIsm1s8uBJ47
X-Proofpoint-GUID: BT7rsyDW-S2LJLwhvtfrwIsm1s8uBJ47
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX2uYtpf38oLyP
 H1eXoKwlwfDWvBs8l4gVCkj23ouiMpxxWLYM626InKsAqJLicNYbg/P19CTm3/7zPs2Nq4UseNZ
 LXjJdZ4BQdARhxdOLYCAcz6X1r0/rJw=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abd3926 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=IxgaH5Y57_YtJiJIwBQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX1xzIWC3mU7CS
 OxGa7VLooactSy3pGRg8K0y9RDpne7JMv7TYiDr6zdFPKsiEMh/T5XvUvt0xy8b9UVqqLYYTZV+
 CR6HmYm3eKL9ZWqxAru92VN7IEczBiUR50Lnsx1/MD1lUgq0cx9wiy6FEFUrrNsJjOqflwTsRf/
 mhX0USG787UHxAqEuii6GS/JKQNqECqFIRhA79rJm464R28GbUyQIatKrk2xxr58O2ZPYTcx79l
 TFju9oWnayl3NGF5slznChHXUrbjyBM9CYSGuLy1wjAJE7Kjg5xku1MWMMxhpesQvOR8sTi3/P5
 G7FVHwfJwVSLmWL/fFwz+DtY0NCCsojIIvNdRIu8tIjXU6HcJ8axyj8hND7b47T570xVGF6odqI
 toxXfuheNiw+2vjCu3bPu+38ZVHAFpyvnJ02v8u8MYdvButLYHAScQoSL/y73V47M28R+gzjrpo
 n7qmweJWprwgrSBBXsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300064
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


> +static int s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
> +                                    PciCcdfErr *ccdf,
> +                                    uint32_t ccdf_err_length,
> +                                    Error **errp)
> +{
> +    ERRP_GUARD();
> +    int ret;
> +    size_t total_size;
> +    struct vfio_device_feature_zpci_err *err;
> +    g_autofree void *buf = NULL;
> +    g_autofree struct vfio_device_feature *feature = NULL;
> +
> +    total_size = sizeof(*feature) + sizeof(*err);
> +    feature = g_malloc(total_size);
> +    feature->argsz = total_size;
> +    feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
> +
> +    buf = g_malloc(ccdf_err_length);
> +    err = (void *)feature->data;
> +    err->data = (uint64_t)buf;
> +    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
> +
> +    if (ret) {
> +        error_setg(errp, "Failed feature get VFIO_DEVICE_FEATURE_ZPCI_ERROR"
> +                   " (rc=%d)", ret);

I see this was changed from last version, but doesn't this fall under
'avoid useless error object creation and destruction' described in
qapi/error.h for the -ENOMSG return value?

We create it here only to explicitly destroy it from the caller.

Can we instead switch to the negative/non-negative return structure with
something like...

<0: error as defined (so we set errp)
0-N: number of errors to process (and we do not set errp)

For the non-negative case we can realistically only have 0 (-ENOMSG maps
to this) or 1 (the feature found something - it is reporting 1 error to
handle).

> +        return ret;
> +    }
> +
> +    memcpy(ccdf, (PciCcdfErr *) err->data, ccdf_err_length);

You already had err->data in void *buf, can we just

memcpy(ccdf, buf, ccdf_err_length);


> +
> +    return 0;
> +}
> +
> +static void s390_pci_err_handler(void *opaque)
> +{
> +    VFIOPCIDevice *vfio_pci;
> +    S390PCIBusDevice *pbdev;
> +    Error *local_err = NULL;
> +    PciCcdfErr ccdf;
> +    int ret = 0;
> +
> +    vfio_pci = opaque;
> +    if (!event_notifier_test_and_clear(&vfio_pci->err_notifier)) {
> +        return;
> +    }

Another one I should have commented on during v5...  You're right about
the recent patch and Z support, but what if the patch is missing on the
host kernel?

I'm fine with the feature not working with AER is off rather than doing
our own setup, but don't we need to avoid referencing this in that case
and ideally give some log message?

> +
> +    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
> +                                        DEVICE(&vfio_pci->parent_obj)->id);
> +

We can get the pci device from the vfio-pci device, so would it work to
just do this?

s390_pci_find_dev_by_pci(s390_get_phb(), PCI_DEVICE(vfio_pci));

Then we cut out the strcmps

Thanks,
Matt

