Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0112FC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x15OY-000293-Pl; Mon, 31 Aug 2026 13:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1x15OX-00028e-IQ; Mon, 31 Aug 2026 13:02:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1x15OV-0000KC-Ll; Mon, 31 Aug 2026 13:02:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VG1qI61616006; Mon, 31 Aug 2026 17:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kJoAsG
 yyyKs2vRGBKN2VTgVriBWSx7iBaa6lLYNrVUU=; b=f5pFWsqUuA0LHxdvfs64zW
 fc3YpMifmi8wST2ypHZlFpxn6VswNELErU8MMa+jd4EyQVmS8dvquC9aqmjUqqM4
 HVg0ctIXQFqa1hUE9etMVPJwQoUgMfPm3P+P4GeygKIBmCbbVygbFJnYDlG0yNrb
 vbQ55qHKYYYtl+3mgZhfT0S/evjuB8CS/oDgaWFWrX9NBGFTP07nciRpGcPRM+Jk
 oX2D4xVSkWwNm3+X33fWfFCnWE3bTOMCXVbPHPvYf9qEVZm/2TtUufNlxXnuY0W8
 Lp0r1Qf1g53FJ+1+iM53/ugYSnxB7aJeu0i4/l91nfeMYfB3Vgkh3GnUsFobhQpQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudjq6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 17:01:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VGfJW2023765;
 Mon, 31 Aug 2026 17:01:52 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexxurh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 17:01:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VH1pPa23659262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 17:01:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8BF058067;
 Mon, 31 Aug 2026 17:01:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 726D458052;
 Mon, 31 Aug 2026 17:01:45 +0000 (GMT)
Received: from [9.43.79.120] (unknown [9.43.79.120])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 17:01:45 +0000 (GMT)
Message-ID: <f1c63dee-d07f-4975-a61a-173318b2dea1@linux.vnet.ibm.com>
Date: Mon, 31 Aug 2026 22:31:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] pnv/phb5: Implement sticky reset logic in PHB5
To: Aditya Gupta <adityag@linux.ibm.com>, Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-4-saif.abrar@linux.ibm.com>
 <aljDwbMnI_w8R1Nu@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <aljDwbMnI_w8R1Nu@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: SNodsKEwA3LdLAyDA1jaIu3-zR-UmY_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX5W2wl2k4elzX
 H29ZkcjowOsgeW29Oq0+JWW7VhpVXogXl9gK56EYfqClgzrT+hHXTUv5y+QqEM9hUaVsd2HMsEj
 nmsJzZs4UeOzJldT4G1Aw6gwnu/Er92lTrttIO8fv7yVEjAz/WmGOUPu3tsECNar1Z+gflu8zG/
 TLkUZP7UoeX2XDYqV9agVm3YGe8hvucVRpwmemjip7VfLlfb/hxao0Pn6ERfL5b9hDUXb6JbBv5
 XP29Wt2xqPqsgfPdbYt6VFGR5S+VrHEcOyNWuMz2hj7mxL0JFFrGmZpL8EEP5Ro17NPLYHH+Khf
 Lb3mJIwb6/wxrg1wEGcFk21Qo2+ugYPGYbv+ko3RCYBqR0jqiNCVuyhDt1VdTWHn6YpkHScWAwV
 2vI3Gxa0cdJZZsiVCWU5ML/0mxGxUWe1YMFp1FYkt58jO9nzreJvtc4KGZHl5SOAtJPaBGKePPp
 Va973v1PzFSY0wrStpQ==
X-Proofpoint-ORIG-GUID: ViqpiYAgppSoQUlWxQo9m4ve3WHR7IZQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX9z64R8hIAbl5
 bYzp6h49b7VyuCCeeZg7KoQmyx8WGL7OiJwz6f/O33Z4EzmUV3zizLslAuxOKeiq/OrdKrKCvVZ
 JXb8Lai72iu4WlFOv7P+EucpzPoWuwE=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95b382 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=vK7bBsrLjRi3Tw1mNiMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310147
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 16-07-2026 17:21, Aditya Gupta wrote:
> On 26/06/17 04:50AM, Saif Abrar wrote:
>> <...snip...>
>>
>>   void pnv_phb4_cfg_core_reset(PCIDevice *d)
>>   {
>>       uint8_t *conf = d->config;
>> @@ -557,14 +570,56 @@ void pnv_phb4_cfg_core_reset(PCIDevice *d)
>>       pci_set_long(conf + P16_ECAP, 0x22410026);
>>       pci_set_long(conf + P32_ECAP, 0x1002A);
>>       pci_set_long(conf + P32_CAP,  0x103);
>> +
>> +    /* Sticky reset */
>> +    RC_CONFIG_STICKY_RESET(exp_offset + PCI_EXP_LNKCTL2,
>> +                                          PCI_EXP_LNKCTL2_TLS_32_0GT, 0xFEFFBF);
> This is different for PHB4, which is PCI_EXP_LNKCTL2_TLS_16_0GT (0x4)
> and for PHB5, spec says PCI_EXP_LNKCTL2_TLS_32_0GT (0x5)
>
> This doesn't affect skiboot anyways, but good to be correct now.
> Rebasing/separating phb5 should fix such nits, let's discuss on it.


Separate methods of PHB4 and PHB5 now take care of different values.


>
> Rest looks good to me.
>
> Thanks,
> - Aditya G


Thanks,

/Saif



