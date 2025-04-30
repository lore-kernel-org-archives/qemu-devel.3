Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C872AC3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAbY-0003WS-OU; Wed, 30 Apr 2025 12:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uAAb1-0003Dm-Cb
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:47:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uAAaw-0001lB-C4
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:47:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UCiLtI027617;
 Wed, 30 Apr 2025 16:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qz0JS/
 QGD7Wjsbb4Kkbv494WkhtPkz076lv1F5yqVOk=; b=ZWgRJM/kxarenFty2ttOT5
 2bEkkbRSarlsA943XExgFAacytPAqL869xujNK5Lmd627+o8emkqx3247POugIuR
 0vii9mJKPzFtWrydPZipwSueXnf69UJ3rgI/IjUINLACD+gy4qy0m9DPWjGGPSLx
 TbMqJTa34kLMZSeEvvPaOEqvh7ic8QoxI30vDlv+IVItqnVSVIYBgCM2Vzr7vlXa
 +iv++r6P0bRv7Gt8JX5ad69YfUsbnW9WZB5MHVJCgPgWNF42PD1gjcigi7W14ofy
 gFnoFeWd2NGVHMUU5KbqYv/5I4bRs5ovUI/e60zLYPOA1PGtJAfiB+zryL8OP1HQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b8r0uwxk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 16:47:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53UFhqMg016584;
 Wed, 30 Apr 2025 16:47:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70gvvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 16:47:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53UGlFaS21693012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 16:47:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4C5758065;
 Wed, 30 Apr 2025 16:47:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7D6758052;
 Wed, 30 Apr 2025 16:47:15 +0000 (GMT)
Received: from [9.61.242.230] (unknown [9.61.242.230])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Apr 2025 16:47:15 +0000 (GMT)
Message-ID: <e07375e3-6984-46aa-90b7-848594539f81@linux.ibm.com>
Date: Wed, 30 Apr 2025 09:47:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] include: Add a header to define host PCI MMIO
 functions
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <20250417173801.827-3-alifm@linux.ibm.com>
 <8decd67b-f1f7-4dcb-b2d5-519ea907e317@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <8decd67b-f1f7-4dcb-b2d5-519ea907e317@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDExOSBTYWx0ZWRfX6ZJjylh/MfdD
 c881UV5DsWFOAN5kmAa6KIlseJ7/g2hKiPtF3hRLcrt5WmF4w12VjH6kCfL3CBS+8qnt0O5EscA
 mbRxSgQmfdIKtAvNvmU1nYynK4MZ8yG3fMNeiyNKVCKL8UqXelwjYPNLxEpcrskkBmOsxQ2d9Rv
 AWlyCWuGW5DmoJjq9McqTjF7JTcB4Y9zQiRbRRcyZgdoHioF6WR7kTRJALl1gpSI355N9mQuVwP
 EFa27JEjhMTYV384rsXAm119e+shF5n/ACEGD1PV5gGbqnWIvLbWxJKt3L3OLRCiSYwb9NRcGf2
 wuDfZhFVIqglLpnoTkETvd1jGa17W7hPNw7NQ35pgrZazD8giyM2Jl4txp6XyzVj2Dg9Lvl6QwZ
 6B127VzYGLpcpjTkSW409GgxsUhvyFl5G6FBfwsjmgBARKx669qfwEgyS/tLpBLZ4SraAvRW
X-Authority-Analysis: v=2.4 cv=OqdPyz/t c=1 sm=1 tr=0 ts=68125418 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=t36QTN9vQo2riXmBCDYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2VmSPwMGe-5TWUdFKDAJzEklrih_GRUL
X-Proofpoint-ORIG-GUID: 2VmSPwMGe-5TWUdFKDAJzEklrih_GRUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=974
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


..snip...

>> +static inline uint32_t host_pci_ldl_le_p(const void *ioaddr)
>> +{
>> +    uint32_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = le32_to_cpu(s390x_pci_mmio_read_32(ioaddr));
>> +#else
>> +    ret = (uint32_t)ldl_le_p(ioaddr);
>
> This is the only spot where you used a cast. Is it necessary, or could 
> it be omitted?

Yes, the ldl_le_p returns an int. We do similar cast here 
https://github.com/qemu/qemu/blob/73d29ea2417b58ca55fba1aa468ba38e3607b583/include/qemu/bswap.h#L416

>
>> +#endif
>> +
>> +    return ret;
>> +}
>> +
>> +static inline uint64_t host_pci_ldq_le_p(const void *ioaddr)
>> +{
>> +    uint64_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = le64_to_cpu(s390x_pci_mmio_read_64(ioaddr));
>> +#else
>> +    ret = ldq_le_p(ioaddr);
>> +#endif
>> +
>> +    return ret;
>> +}
>> +
>> +static inline void host_pci_stb_le_p(void *ioaddr, uint8_t val)
>> +{
>> +
>
> Remove the empty line, please.
>
>> +#ifdef __s390x__
>> +    s390x_pci_mmio_write_8(ioaddr, val);
>> +#else
>> +    stb_p(ioaddr, val);
>> +#endif
>> +}
>> +
>> +static inline void host_pci_stw_le_p(void *ioaddr, uint16_t val)
>> +{
>> +
>
> dito.
>
>> +#ifdef __s390x__
>> +    s390x_pci_mmio_write_16(ioaddr, cpu_to_le16(val));
>> +#else
>> +    stw_le_p(ioaddr, val);
>> +#endif
>> +}
>> +
>> +static inline void host_pci_stl_le_p(void *ioaddr, uint32_t val)
>> +{
>> +
>
> dito.
>
>> +#ifdef __s390x__
>> +    s390x_pci_mmio_write_32(ioaddr, cpu_to_le32(val));
>> +#else
>> +    stl_le_p(ioaddr, val);
>> +#endif
>> +}
>> +
>> +static inline void host_pci_stq_le_p(void *ioaddr, uint64_t val)
>> +{
>> +
>
> dito
>
>> +#ifdef __s390x__
>> +    s390x_pci_mmio_write_64(ioaddr, cpu_to_le64(val));
>> +#else
>> +    stq_le_p(ioaddr, val);
>> +#endif
>> +}
>> +
>> +static inline uint64_t host_pci_ldn_le_p(const void *ioaddr, int sz)
>> +{
>> +    switch (sz) {
>> +    case 1:
>> +        return host_pci_ldub_p(ioaddr);
>> +    case 2:
>> +        return host_pci_lduw_le_p(ioaddr);
>> +    case 4:
>> +        return host_pci_ldl_le_p(ioaddr);
>> +    case 8:
>> +        return host_pci_ldq_le_p(ioaddr);
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static inline void host_pci_stn_le_p(void *ioaddr, int sz, uint64_t v)
>> +{
>> +    switch (sz) {
>> +    case 1:
>> +        host_pci_stb_le_p(ioaddr, v);
>> +        break;
>> +    case 2:
>> +        host_pci_stw_le_p(ioaddr, v);
>> +        break;
>> +    case 4:
>> +        host_pci_stl_le_p(ioaddr, v);
>> +        break;
>> +    case 8:
>> +        host_pci_stq_le_p(ioaddr, v);
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +#endif
>
> Apart from the nits, patch looks good to me.
>
>  Thomas


Thanks for reviewing! will fix the nits in the next revision.

Thanks

Farhan


