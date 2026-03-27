Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9631310F2862
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Bkk-0007Y0-UQ; Fri, 27 Mar 2026 14:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w6BkW-0007Uk-CF; Fri, 27 Mar 2026 14:17:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w6BkS-0004Ew-Az; Fri, 27 Mar 2026 14:17:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RAEePP2756529; Fri, 27 Mar 2026 18:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F12uDh
 ldy8+N39jiJ4rCxJgwGCmT7wHVGWmUp8zjwXQ=; b=rMp2sM8uOt+9pN6FaocmG7
 dEJzL5KKGCowMbhePajvDv9FrbVcvhZsAFqIWqUnWOqgkXm1BFe88Yscqv6nSEtf
 fdu0dAqQPj9a8vsn75rbV0Ex79dHIGPcdzzGVcyjZ4mvuXYKR35Ti/VVoVYz3FD9
 TRPDp9jNNfIxOnsqtzc7s9qlT/zzfqGECklJtiwLCcR08yGALCCeFQBCbMHZUhUP
 2b1J/alyYEOC4jGHp6yZ6IlmgtHgCRl845S43LcEZsBhDB1NoImQZItnc7p7STPQ
 rkJuHUY1nqQQxKYDnHBnhW3oGFGcPEOAUNr076GJ3fi3/EYpHVR+OI7Nyuvt1JQg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kun2ep4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 18:17:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RGZWPP012177;
 Fri, 27 Mar 2026 18:17:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkggrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 18:17:29 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RIHSB431064688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 18:17:28 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EB6B58059;
 Fri, 27 Mar 2026 18:17:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D53B58058;
 Fri, 27 Mar 2026 18:17:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 18:17:25 +0000 (GMT)
Message-ID: <184a1a43-d41b-4b23-bc53-768a12631884@linux.ibm.com>
Date: Fri, 27 Mar 2026 14:17:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hw/tpm: Remove instance @ppi_enabled field
From: Stefan Berger <stefanb@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <70bd2f29-9f33-43e0-897f-52f0b2af111f@linaro.org>
 <ece64b0e-7f05-43de-b326-38788a9abe8b@linux.ibm.com>
 <2c06e37f-477a-49d6-a65b-fd826fcdc5b2@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <2c06e37f-477a-49d6-a65b-fd826fcdc5b2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: j6xh-coaq-Cl7O1UEkag1SIptt2NvNZ0
X-Proofpoint-ORIG-GUID: fLvIHeD_Z8N8na90ZFKyW-lS0h7LMBz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEyMyBTYWx0ZWRfX65garFr8Anxv
 Z3qlD1u5jkMBhze1lUUbrOVTuXWEwitdlXREtzaYD6dNkLyxyIC15BcYLRB2ElH19LJqXMX+cKO
 9vGpRCxfdCH9OfuMR1fxF+wpTr4gVA2lkjQJZaGtgIme6JW919Vmh3rK7Z+s1HIDAlglbux9cib
 dvhWIgxieOaDNRB/+mY1FymR6Ui8vyIYP9b+fD0A/6XYw1mMB7ueETWxZDXcQG8WEtRNwUwzrXU
 3H/nbb9Vj7ysOxd+9NT6F2byCVtP5PoMpw8Wcyl3DdAv0n83w2eJRhw3t1MKl4PrVlGxVEIptt7
 atPLQHc2DNhbhKU4O6YD23+qTwmoIlJ0mdBdpru7ozKD9vMdMHmt9my7VQAtpUC5B+EuKu28qb9
 Yt0TdLgaMPY4p1CoiT6BGzabKXciwpNVwT/qOiIwTeWfZmh3xINFHU6hhyNR3F+sZHz6FA+mWr/
 Gb8SXDE6qpatnv3uMmA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c6c9ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=bqUz3AZQgHb6977Pm3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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



On 3/27/26 11:21 AM, Stefan Berger wrote:
> 
> 
> On 3/27/26 11:18 AM, Stefan Berger wrote:
>>
>>
>> On 3/23/26 5:56 AM, Philippe Mathieu-Daudé wrote:
>>> On 17/3/26 13:02, Philippe Mathieu-Daudé wrote:
>>>
>>>> Philippe Mathieu-Daudé (5):
>>>>    hw/tpm: Factor tpm_ppi_enabled() out
>>>>    hw/tpm: Add TPMIfClass::ppi_enabled field
>>>>    hw/tpm: Remove CRBState::ppi_enabled field
>>>>    hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and remove in
>>>>      TPMState
>>>>    hw/tpm: Simplify tpm_ppi_enabled()
>>>
>>> Series queued for 11.1 (typo fixed), thanks.
>>>
>>
>> Here's another TPM PPI related series. It would make sense to upstream 
>> them together. Do you want to queue that one as well?
>>
>> https://lore.kernel.org/qemu-devel/20260327-tpm-tis-sysbus-ppi-v2-0- 
>> d8ec84d25dbc@redhat.com/T/#t
>>
> 
> Actually, they will have to rebase on this series first...
>>
> 

v3 is good now:

https://lore.kernel.org/qemu-devel/20260327173209.148180-1-mbawa@redhat.com/T/#t

If you want to take it let me know, otherwise I will have to wait for 
your series.



