Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A181C10F2841
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68wy-0003Hc-Fp; Fri, 27 Mar 2026 11:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w68wu-0003Gv-8I; Fri, 27 Mar 2026 11:18:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w68wr-00054i-RP; Fri, 27 Mar 2026 11:18:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R303fk573231; Fri, 27 Mar 2026 15:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NstLXW
 7EHnx1sXup0lF+m17eVPatto5Bt+6MbmIAh8g=; b=F4tNjeq8JO4FnIfbE4kt10
 L1sb1Z1yeJthE/YOE1ApCEqaspcBarSC11NM6IL9HOU+4h+lwZ9grUX9WPYCixYr
 kTFR1Q7WtAie4eAubVM1jWfqkrSjspAqLdiOhbbAItJNyAkxwezncJ+pWUBJqW9I
 JLpiP3yvWPgeNg3pwANv0Nj/eq4k7m8Qsu2tq9DSxsY8n3PaXQDhcbw4o4GrML23
 psTL+K5VrFo1MeV0mB3ILeneT29vHiy9x8HRO/Biz8MeOZ//3fFzR/TxR3w29GVF
 7P6/O4YBAHpRIyct4nMEy9XhkoAAipseFgudZSuBL/clq1E+6czr5QqOxSp0RlvQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0hj3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 15:18:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RApb57011824;
 Fri, 27 Mar 2026 15:18:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkftj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 15:18:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RFI20x58130882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 15:18:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC4A75805D;
 Fri, 27 Mar 2026 15:18:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DB0458043;
 Fri, 27 Mar 2026 15:18:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 15:18:02 +0000 (GMT)
Message-ID: <ece64b0e-7f05-43de-b326-38788a9abe8b@linux.ibm.com>
Date: Fri, 27 Mar 2026 11:18:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hw/tpm: Remove instance @ppi_enabled field
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
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <70bd2f29-9f33-43e0-897f-52f0b2af111f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX8Xsnm2Vnj6a8
 UqnalmBe1LITzmkONGahamrUiqHFqmTx1QA+BlF0kSP52W79Ij+BtbLrtJxW+6b9v7/+gjfTMCP
 6eB4w63YbJorAIcI74T+OrbpO8hSyYFEEztS/WfMGfbY7yl/Xg2+h7DgEgHdc8/GzGj1Ch+mJW4
 FMRFHChZGss4RDi41UBFlhUIl6undnCpYvEJ+hGjnPtg5sbOjCZiE5CXzVQIUnCVnG0hE7zKtrR
 Nxa8VUfG+Lal6SGtLf5FQmwyhdX/yoaL2iLbhZmDiyslV+6HfLJRCN94z6wX3Njwc9z3mpV+e/3
 yF8oyAvDNpkooxg7+E0TsKKbI7b+6dsJu8DaderenybjzcuF0aGLajeaBCSTDqFSeMtG++ipmM5
 hsLAAqJYW2mx2tvZ61P41kN1CWUfVS/BKlT/xraK6CYhadiUmiCe/VJIVwUKtTLtvogCPFY4jHf
 yAQBJQIiRb7pWz3i6kw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c69fac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=3flbI1uP9kseeW6so38A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lVadWSKRwIGHjbI3yHAfVls9URywigjB
X-Proofpoint-GUID: rLL2Fpxiy4ToufxuesP7s7yBGMF8pNOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105
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



On 3/23/26 5:56 AM, Philippe Mathieu-Daudé wrote:
> On 17/3/26 13:02, Philippe Mathieu-Daudé wrote:
> 
>> Philippe Mathieu-Daudé (5):
>>    hw/tpm: Factor tpm_ppi_enabled() out
>>    hw/tpm: Add TPMIfClass::ppi_enabled field
>>    hw/tpm: Remove CRBState::ppi_enabled field
>>    hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and remove in
>>      TPMState
>>    hw/tpm: Simplify tpm_ppi_enabled()
> 
> Series queued for 11.1 (typo fixed), thanks.
> 

Here's another TPM PPI related series. It would make sense to upstream 
them together. Do you want to queue that one as well?

https://lore.kernel.org/qemu-devel/20260327-tpm-tis-sysbus-ppi-v2-0-d8ec84d25dbc@redhat.com/T/#t


