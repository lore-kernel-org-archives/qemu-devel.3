Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B8CC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8hGx-0004GO-6n; Mon, 21 Sep 2026 12:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x8hGu-0004Fv-N4; Mon, 21 Sep 2026 12:53:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x8hGs-0007t9-L1; Mon, 21 Sep 2026 12:53:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8HhH1902958; Mon, 21 Sep 2026 16:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YLsh4e
 Kx584A5OS4tPFMuKsRU5gDP5hfG88Dj7fu1RE=; b=NYhPi0L4DDDy8C9F598b23
 4txexBrd19gouhnuu2dq38xP6dKFGFkXQDfxyPwyZCsbgA6ZJKpo4gg+dd7r5QWd
 4nM6lhMMM5cBRi3Qf9WTBu5MY+yk50S5jaoipzRIpAeR9e6Zjr8RIgnsMNjikPcg
 3kenooFwOvzJSq/q/5ka44M1TvBCt1HK8CBIM/6D2MFi8HnaPeGxyEqHXuS6BGB8
 KTx1wVn4N97/NP/hhkfbR7c0GCPXIeSPLlbBJ3E+nPG9Z+ES0gtlFKtEiOsYZ8s5
 Jg/hcPA69n0khlY5oiTsNhJmAX61vFSH0rm3Av5KIc7Bjyg0z/u9F7yE8th/4JWQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv1js0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 16:53:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHT331489428; Mon, 21 Sep 2026 16:53:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq6bey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 16:53:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LGrV7q31130130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 16:53:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 371F358056;
 Mon, 21 Sep 2026 16:53:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 735E55803F;
 Mon, 21 Sep 2026 16:53:30 +0000 (GMT)
Received: from [9.61.240.58] (unknown [9.61.240.58])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 16:53:30 +0000 (GMT)
Message-ID: <cfaf7d76-ef2c-4b9c-9e11-c94bfc99fdaa@linux.ibm.com>
Date: Mon, 21 Sep 2026 09:53:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/16] s390x/pci: Implement migration for emulated
 devices
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260911152137.676602-1-kshk@linux.ibm.com>
 <20260911152137.676602-16-kshk@linux.ibm.com>
 <7a2ec98c-6756-4c9f-8f86-1b0db94c8053@linux.ibm.com>
 <aqwkyvY8mxIEqDyH@redhat.com>
 <0e59d36a-4757-4dc6-a72d-a2f185db835c@linux.ibm.com>
 <arFK6US5kWAMvDPp@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <arFK6US5kWAMvDPp@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ytx4ymz_rnu7LztbC0tCL3mpbLaE9Wsd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI0MiBTYWx0ZWRfXxb+FU2lRZFqu
 7Y7MgPWESkWFssEaQjr1YAejS7HCi2Ll5g1RaMBf/uj919CHxkvLbcrQXvWEzNvmKwd6IHfkUqE
 QKU0Q1Ij3gNAqBewLMZGF99S57rM78s=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab1610c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=OlAlvAjMd6YUtngKZocA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ytx4ymz_rnu7LztbC0tCL3mpbLaE9Wsd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI0MiBTYWx0ZWRfX+xzDSBGxQx4S
 OWr7ehPvWAQSSh3kZjBs4jfzoKzcVmWlFPTxkEOf3BxIFM+mGly+0nbPd8KLsYH663HUSSRxUYS
 sT+QBoMyEKPsY8hyEBaZAiUDb3lFisQJ5SKHnxujzqYv+ngyGWiEIzdU2fQJ2xTh2RRogL35o45
 iuLZnWQVtHP7Hh5K8StJ7o8zbpQa12rva/28hCE2fHmcKax5clMrqJiRhhRsmxW2nMhMfTLHMhk
 wFwA52Cz9ceALLtF1b5y+ex9OQnkiq+4yhOU+nVI8RMBR3Kc98dZDNyCZbrbqkFkMDEYlpkpecU
 c6kEkfb2C5g7cMKraMaFrL6Z7D2qBZkHEy4AVT6s73w3ONq9y2n0c15MFuWaTfKcoYwW9if3LaA
 Sq5Wov89EJfZkg6lysDiDnSDfxqDEmujKpHEumsVzysbtS1k0yucs89amgF9soNQrEflZc6K308
 eFMxRfmRGCyRpr0XuGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210242
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 9/21/2026 8:19 AM, Daniel P. Berrangé wrote:
> On Mon, Sep 21, 2026 at 10:12:34AM -0500, Konstantin Shkolnyy wrote:
>> On 260917 12:35, Daniel P. Berrangé wrote:
>>> On Thu, Sep 17, 2026 at 10:25:32AM -0700, Farhan Ali wrote:
>>>> On 9/11/2026 8:21 AM, Konstantin Shkolnyy wrote:
>>>>> @@ -1303,11 +1380,22 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>>>             pbdev = S390_PCI_DEVICE(dev);
>>>>>             pbdev->fid = 0;
>>>>>             QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>>>>> -        g_hash_table_remove(s->zpci_table, &pbdev->idx);
>>>>> +        /*
>>>>> +         * If this QEMU is running a migrated guest, and was configured with
>>>>> +         * more zpci devices than the source QEMU, extra zpci devices could be
>>>>> +         * excluded from zpci_table and invisible to the guest and have
>>>>> +         * pbdev->idx values duplicating those of active devices. If the
>>>>> +         * pbdev being unplugged is such, the zpci_table entry for pbdev->idx
>>>>> +         * can find a different pbdev which we must not remove.
>>>>> +         */
>>>>> +        if (g_hash_table_lookup(s->zpci_table, &pbdev->idx) == pbdev) {
>>>>> +            g_hash_table_remove(s->zpci_table, &pbdev->idx);
>>>>> +        }
>>>> If we are migrating, won't we re-create the exact same state and devices on
>>>> the target host? Is it possible that the target QEMU can have more devices
>>>> than source?
>>> It is expected that the source and dest QEMU processes have identical
>>> virtual hardware configuration, and also no attempts should be made to
>>> hot-add/remove devices while migration is running.
>> Do you suggest to completely delete this hunk, or keep as "defensive tactic"
>> and correct the comment?
> I don't think it is worth trying to add defensive checks, as if the
> config is not identical, the code may well not even be reached as
> vmstate parsing/loading typically fails during migration.
>
>
> With regards,
> Daniel

I would agree to remove it, it was also a little confusing for me to 
understand why we needed it.

Thanks

Farhan


