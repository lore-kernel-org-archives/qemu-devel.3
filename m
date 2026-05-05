Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A48FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKGa2-0004bm-I7; Tue, 05 May 2026 10:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKGZv-0004bB-M6; Tue, 05 May 2026 10:16:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKGZr-00027o-Ru; Tue, 05 May 2026 10:16:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6457vJ0Q2807278; Tue, 5 May 2026 14:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gwHkhP
 r+EdLRDJxzEwwIPtvmrlK8iPFVuZymsT13dUg=; b=NRNybPjATN7rErOzUeuGud
 P2JL7tD2UcvDOiarMp6MYbbrp5/Rgp7qmLrHLEgYJDmTCTqNg00VFPxGuQ2y98FV
 jc9iMyn31+WtWQSic4HBCGkgBVYzb9PjaARvmKUnzLJCOQiMOaWPHa8Lh1dYSXKf
 5kLkkUDL0yQSjrEsfucnsDARbi/vOsucnYBH0aVJsUCswgN9gGBesM0OWWYItfqH
 cm01SpmH1Q7967ER1DLhBg9EXocpuNVkars8YgKNSBBrqrtyykiRBHX+sOGk6b9m
 hluc/cgfJ10+RjoTJulDqHrvicqZBvkaBVoT73WVuPnf0bjMyRXZz6WbLhdzNteg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4krjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 14:16:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645E9Qhw025789;
 Tue, 5 May 2026 14:16:36 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h1whq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 14:16:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645EGZo528377836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 14:16:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40E3A58056;
 Tue,  5 May 2026 14:16:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 603AA58045;
 Tue,  5 May 2026 14:16:29 +0000 (GMT)
Received: from [9.124.208.117] (unknown [9.124.208.117])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 14:16:28 +0000 (GMT)
Message-ID: <a9e49acd-855a-4506-98d6-edd8cfca8792@linux.ibm.com>
Date: Tue, 5 May 2026 19:46:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] pnv/phb4: Add reset logic to PHB4
Content-Language: en-GB
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-3-saif.abrar@linux.vnet.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260305060923.3753402-3-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEzNSBTYWx0ZWRfX9oMJImBx9B29
 QdJjlm15oamiFh2TVigvQ8z9kzbo49zcgLbUntYAosS0FVyBIJ6nJEtaTLQqGZeHauYQqPSmW/p
 Sv4D8v/jRmH9YvZwW8SldLTaJZgigSc8dnr7YrFYgrDqFtrD7YJSkXrI+WrqS9N0x3G/7s5tsBO
 m8cnwqdWvlfLH/xI+WaggeECO2OPGM/NGYZeJUOm3b9HfTjduLhUHrDJpLFOf+vOXZ9IK6Cenbp
 1Ea5mDXen7V7Whb93uD218HVdkLFidGhojjiO4arlNkpjsGAQ8A2bJuPjMGLVGJ+8X0gGFQzabf
 PdNqrMFG2Xk3S31p0r41CXJZsr5ip7b7TXlblC9aYcZq15REU7Sfg2hQ70PRqV4cGIA36qASKeu
 a6nUOIkiHBtfZneTceCnaEFqD28n+LtI/VTGSWY8zqBOvbgjSN9DYOTEHWLxn8NkYMLDUSM+pgl
 Nf80PlQt2FixBG4ZX+g==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69f9fbc5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=gMJvXaDhJXIUK9gS6cMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OUOKqeTfuQlWwm3DUMo_auQ59j4gwt0l
X-Proofpoint-ORIG-GUID: 6smLb5vfMfG2z-W2n35J8yFZIB6amL24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 05/03/26 11:39 am, Saif Abrar wrote:
> +void pnv_phb4_cfg_core_reset(PCIDevice *d)
> +{
> +    uint8_t *conf = d->config;
> +    uint32_t exp_offset = get_exp_offset(d);
> +
> +    pci_set_word(conf + PCI_COMMAND, PCI_COMMAND_SERR);
> +    pci_set_word(conf + PCI_STATUS, PCI_STATUS_CAP_LIST);
> +    pci_set_long(conf + PCI_CLASS_REVISION, 0x06040000);
> +    pci_set_long(conf + PCI_CACHE_LINE_SIZE, BIT(16));
> +    pci_set_word(conf + PCI_MEMORY_BASE, BIT(4));
> +    pci_set_word(conf + PCI_PREF_MEMORY_BASE, BIT(0) | BIT(4));
> +    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, PCI_PREF_RANGE_TYPE_64);
> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));

This duplicate looks like a copy-paste error ?

