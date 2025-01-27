Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D66FC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 20:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcVzw-0004Wk-BF; Mon, 27 Jan 2025 15:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tcVz8-0004CB-8v; Mon, 27 Jan 2025 15:45:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tcVz6-0005Ik-ET; Mon, 27 Jan 2025 15:45:29 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RFuuGg024891;
 Mon, 27 Jan 2025 20:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yikQf5
 Td9iWZ+OdZ82r9eakd0DFG1AHIi5HGrRwN1Kc=; b=judsDqi6lEuxZYFPWMHDwZ
 OH8X70J1uvo+BOo0+JfxWQKU+MR90IKbShrUW8RGH0OajZTOoBe7hzVgzzz+bvtQ
 W+WHrXX2EAskqMe7rTWNBb2MEIhMFbRiEdMKslHgjQc8yOLW7NuA5NVaFIffKlUN
 UHzAtbK0T50JVuNSpabkf/imQflFBxMQu3pdv00tzzG1H0NnFK+iEpk89TmEOvJ1
 hkeVCYdJwgFzigeuNc8HFLHLIY9iaoa+dHhGhxoCX+GbuPBA3zZk+kFD6bxV0w8I
 pmDMiZ6wXPJ6W/r9mAxzQSrtXigtdbjaGRrwJO19z81pL0QpM5jHzi8a0vX9jgAg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e3y7vaxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2025 20:45:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50RKR7Rt028072;
 Mon, 27 Jan 2025 20:45:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbsk7ygb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2025 20:45:24 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50RKjNwS30868132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 20:45:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A30D58053;
 Mon, 27 Jan 2025 20:45:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BEEB58043;
 Mon, 27 Jan 2025 20:45:22 +0000 (GMT)
Received: from [9.61.39.122] (unknown [9.61.39.122])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jan 2025 20:45:22 +0000 (GMT)
Message-ID: <7738f623-e580-4ddb-9998-86ffb8a97cf4@linux.ibm.com>
Date: Mon, 27 Jan 2025 15:45:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390x/pci: add support for guests that request
 direct mapping
To: Niklas Schnelle <schnelle@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20250124202115.349386-1-mjrosato@linux.ibm.com>
 <20250124202115.349386-2-mjrosato@linux.ibm.com>
 <c965e6300a0f93f764fbb69a52e8ee0d8414d5aa.camel@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <c965e6300a0f93f764fbb69a52e8ee0d8414d5aa.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mjnPYu5DCwBbaGKtr7uq2wEdNks_6E6t
X-Proofpoint-GUID: mjnPYu5DCwBbaGKtr7uq2wEdNks_6E6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_10,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270161
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


>>  
>>  static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>> @@ -1488,6 +1518,8 @@ static const Property s390_pci_device_properties[] = {
>>      DEFINE_PROP_BOOL("interpret", S390PCIBusDevice, interp, true),
>>      DEFINE_PROP_BOOL("forwarding-assist", S390PCIBusDevice, forwarding_assist,
>>                       true),
>> +    DEFINE_PROP_BOOL("relaxed-translation", S390PCIBusDevice, rtr_allowed,
>> +                     true),
> 
> Question: Do we maybe want to default rtr_allowed to false for ISM
> devices? Performance wise it doesn't matter much since they keep their
> mappings fairly static and it would help us catch bugs in the handling
> of rtr_allowed == false devices, the ISM driver and increase security.
> 

I've been asking myself the same.  Believe we've discussed it in the past (off-list) too.

I'd be fine with that.  I think it doesn't change the line above, but I can add a check against pft in s390_pcihost_plug() after clp info is read in, along with a small comment, that changes the setting to false for ISM devices.

Note that there is one side effect I can think of based on the kernel implementation - if a guest has, say, NVMe and ISM passed through with iommu.passthrough=1 specified then they would always see the "Falling back to IOMMU_DOMAIN_DMA" message for the ISM device(s) because of rtr_allowed == false.


>>      /*
>>       * If appropriate, reduce the size of the supported DMA aperture reported
>> -     * to the guest based upon the vfio DMA limit.
>> +     * to the guest based upon the vfio DMA limit.  This is applicable for
>> +     * devices that are guaranteed to not use relaxed translation.  If the
>> +     * device is capable of relaxed translation then we must advertise the
>> +     * full aperture.  In this case, if translation is used then we will
>> +     * rely on the vfio DMA limit counting and use RPCIT CC1 / status 16
>> +     * to request the guest free DMA mappings when necessary.
> 
> Not a native speaker but I think there is a "to" missing in the last
> sentence and I'd have used "as necessary".

'request that the' would probably work too...  But yeah, something is missing, I'll re-word.


>> @@ -362,6 +364,7 @@ struct S390PCIBusDevice {
>>      bool interp;
>>      bool forwarding_assist;
>>      bool aif;
>> +    bool rtr_allowed;
> 
> Nit: In the kernel in struct zpci_dev you used rtr_avail but "allowed"
> in the comment, just for gerppability I'd prefer the names to match.

I guess in my head, QEMU is the one allowing it and the guest kernel is checking whether or not it's available.

But I have no strong opinion on the name; can rename the QEMU variable to rtr_avail

> 
>>      QTAILQ_ENTRY(S390PCIBusDevice) link;
>>  };
>>  
>> @@ -389,6 +392,7 @@ int pci_chsc_sei_nt2_have_event(void);
>>  void s390_pci_sclp_configure(SCCB *sccb);
>>  void s390_pci_sclp_deconfigure(SCCB *sccb);
>>  void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
>> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu);
> 
> Nit: I find "_dm_" a bit hard to map to "direct map". If you want two
> letters I'd go for "_pt_" for "_iommu_pass_through_" or maybe
> "_direct_map_".

OK

