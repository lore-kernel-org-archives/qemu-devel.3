Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67693EA8113
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnVe-0007Qo-Qs; Tue, 10 Feb 2026 08:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vpnVW-0007QO-HN; Tue, 10 Feb 2026 08:10:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vpnVT-0004R2-Dx; Tue, 10 Feb 2026 08:10:22 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A9L85g402492; Tue, 10 Feb 2026 13:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XPoh8Y
 Y+1gsvGR4HxTDjBSj2Mp0dYBu7xUc+p+49rPM=; b=IX8ahuH/1xqUy9Z2gix19J
 9bpfwAqaOQQp0TBeTfBvyfQkkggR3G8WMIEY1AW/DL9J+n6WsAiGvJtkwsFCicNi
 hDYrGf1nm+ctCWoBYw9vUFMepUkIgs3OqaaxGK0ldDHy+dJOKA03DeSEqZBlUgLy
 rig0JCLu2PKY17vPGJemHusCqxj6YS2YqH9Yjbt2gkH+ZcQoR8q7uEDWLHUfhGRF
 PQqjdk+sCIaNvYMj06X/O/1lRsSlAbN+JKmAvmU/xgiFJcUPG1qjNCTI8FbB2eTm
 aiQ3QOudbKKdxAIGTmQZaAR6l/Q9gfPKxhEoRbzCOi6Bur6MLUPtl4ny/rLxZOCA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uc9fp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:10:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AAFnsk012693;
 Tue, 10 Feb 2026 13:10:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7k98uf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:10:14 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ADADLX28377784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 13:10:13 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3527A5804B;
 Tue, 10 Feb 2026 13:10:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A0B358063;
 Tue, 10 Feb 2026 13:10:12 +0000 (GMT)
Received: from [9.10.80.137] (unknown [9.10.80.137])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 13:10:12 +0000 (GMT)
Message-ID: <b35c4a66-05ce-4453-a259-92ee87641617@linux.ibm.com>
Date: Tue, 10 Feb 2026 07:10:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ppc/pnv: Add unimplemented quad and core regs
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com, harshpb@linux.ibm.com
References: <20260126135507.771552-1-calebs@linux.ibm.com>
 <20260126135507.771552-3-calebs@linux.ibm.com>
 <aYrXdeZol4koVzYX@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <aYrXdeZol4koVzYX@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698b2e38 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=eadkP-VQdgytgM3QQfIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _CC7Eb-WQZ-NPFyVBjeNrsZcRDk5XhDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwOCBTYWx0ZWRfX3ThThvmOmFWE
 5vRYjFuTGqEWKRqXxkPCXLvWLY6GwS4BX/4ovEaEn9K7mVdTYSFT23rW9P6AHU/ziCVHXWikpA9
 s3h2EeL5Vg21s9y3zRep0XTiRuJiuX5b7QX8aMRFdFx3k7VhLVhIvQoZsjVC2dDHh7vPH2GHQzM
 ApvMecbbzim0107xmRgm76k+0e+wwaqkBgc5MCaOAVPyYRSkSl6+mbBJiSSaYMGz6nVIxsRIVjb
 3I3/Lndkd0Y0/CT/EB3fCeASPL/KxIYRzU/sQPS1eylMmD8KzBmybEOtY3Uu4b+Ux24g4cfAcWV
 AxbnzelbtDiExuqVE7aRfAX5ypjD5xsYf7r3d8fs2CPESRetF/jcL2z6+rkRoZ5JMSYfEpxHxs0
 a6zdlu50Jj395mYtI8uh8SFFCCRgCnzyE8Zg0gAeqn+Td0jHgx4seB/J8s7UTcyqZTXunowBnez
 P8ZUTtAAPUGR6BckcUQ==
X-Proofpoint-GUID: Q6pp8w7wCsHrr6y_FxYjRQObcZp4mE4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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



On 2/10/26 1:04 AM, Aditya Gupta wrote:
> Hello Caleb,
> 
> Was going through the patch again. Can we add a comment doc, about the
> scoms for which the unimplemented warning is getting hidden ?
> 
> On 26/01/26 07:55AM, Caleb Schlossin wrote:
>> <...snip...>
>>
>> @@ -284,6 +305,15 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
>>          }
>>          break;
>>  
>> +    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
>> +    case PNV10_XSCOM_EC_CORE_FIRMASK:
>> +    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
>> +    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
>> +    case PNV10_XSCOM_EC_SPATTN_OR:
>> +    case PNV10_XSCOM_EC_SPATTN_AND:
>> +    case PNV10_XSCOM_EC_SPATTN:
>> +    case PNV10_XSCOM_EC_SPATTN_MASK:
>> +        break;
>>      default:
>>          qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
> 
> Here, the unimp warning is getting skipped, by ignoring writes to those
> scoms.
> Similarly in other places, you return 0 as default value for few scom
> reads.
> 
> A comment about the special treatment will help future developers to
> read the code.

Sure. I'll add that in my next patch set.

Thanks,
Caleb
> 
> Thanks,
> - Aditya G
> 
> 


