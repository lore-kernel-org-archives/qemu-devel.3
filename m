Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236DB606A333
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UAg+3OUV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIudU-00007j-UW; Mon, 19 Oct 2026 17:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIud6-0008Ta-13; Mon, 19 Oct 2026 17:10:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIud4-0004ti-91; Mon, 19 Oct 2026 17:10:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJiOhu414806; Mon, 19 Oct 2026 21:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ci0mYX
 s/FwZa16qdc4LNrqxCXz54jI7wq/0DpPDqmGw=; b=UAg+3OUVzeRFnNPiCGoWtr
 /dZdjcA/ELD1I6F9jR/qF41J2aEUHRG4CSRuEBHQNI+DI6r5ZsQH1xxvRimzM3/K
 gp3m179yWGXLWUA/ziPIio0vmoj0/DOgEoZ6p4wENpE8+Ku5mir9DqU63lfXH5hD
 hd5M0hpUH2ZJc3R4OpZTP1f1Sp5BuIMgILE2r6J0nHtIj7PVkbz2p+RRVUQNfnRW
 MJIJQarLtuyhFFPyQgGg2kkiu34ZJ2Fg426Osgbugpr5cfZWMfKgDxPm2hC9mhiH
 uSIU2cjQeupmL9Qo6skV2g+n/IkD4T340NA1j0GRoeqOSR1tLMEBHAdCtCGBGXrA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehw53r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 21:10:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKHcN422132; Mon, 19 Oct 2026 21:10:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmugydg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 21:10:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JLAfwa27591266
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 21:10:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8F0A58059;
 Mon, 19 Oct 2026 21:10:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A0B45805D;
 Mon, 19 Oct 2026 21:10:39 +0000 (GMT)
Received: from [9.61.191.236] (unknown [9.61.191.236])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 21:10:39 +0000 (GMT)
Message-ID: <d96d2733-5fa7-448b-a133-0e4f5e0654e3@linux.ibm.com>
Date: Mon, 19 Oct 2026 17:10:38 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] hw/i386: ELF endianness fixes
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
 <20261019151233.230172-2-farman@linux.ibm.com>
 <2be3455d-929e-46de-864c-09675ee9c71f@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <2be3455d-929e-46de-864c-09675ee9c71f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4MiBTYWx0ZWRfX0XAXbYg9i7oT
 LwzdZesXUttVhQDkWnMuTDQlOeXUTUECYwTMndpMrbUj6jikUbvdtQ4hWDAOlLt1RssrO1Vn2Mp
 Q9RybZCqqr7e0qns0pqAenQWKUCeKtHyiFANu2XYkLrUGdeSSFaQCOm1TyIZdm+B21Zba2KG5RN
 6tyWdaWTe0VWBPhA9Y5JAVMU60HsRRx1L7e68HcYzN7TgjRzersS7iSvSuCOrQpHHsBP6mxjscV
 bGG0BTcDv8OgXOmBPIZ3SJC2PYN0Hy8eu+tycEcozaykjhP8Dn/rjynyrHAOJ5sChLDLX6EdNhY
 H1sDCVaL6Z5A1mORwXpo0E0rwvqIVdkvS6qHquZZcSMCEQ2dzuhNPikuAj0haz/Ufov8UqzNeZo
 +G9BrdEGsgFe8r3+pirK+d6/JJBTZneEPwlLEI5v+mxzleoov/NloHgr1coHVbRWb7NfXzMzPhH
 dHRaDmHZ2yS4fuDHtxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4MiBTYWx0ZWRfXyUi+vomlbBLK
 W1fo7KjFHLsEdzxDVGDtBZGc9wOwc32VBDaMyljeVZeEHEK7oxUlxSROWHJHjhSxbXBeXeSZb/i
 CIkjGfuggJmBHnfzZye7rrUxiTsp+Mw=
X-Proofpoint-GUID: OqAVTs6WZPQ3NwyktLdDfuj2ZZ4Zh_Ti
X-Proofpoint-ORIG-GUID: _oPjz_AI-SMzPHJYtiWvJU4KRDKMXOBD
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad68753 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=heZ_S0Q5fQck7qC87NIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/19/26 2:57 PM, Ilya Leoshkevich wrote:
> 
> 
> On 10/19/26 17:12, Eric Farman wrote:
>> Running make check-tcg-x86_64 on a big-endian host (e.g., s390x) fails 
>> due
>> to problems reading/parsing the ELF data:
>>
>>    qemu-system-x86_64: Error loading uncompressed kernel without PVH 
>> ELF Note
>>
>> There already exists logic in include/hw/elf_ops.h.inc to handle byte- 
>> swaps
>> where necessary, but it does not perform this logic for ELF notes itself.
>>
>> Fixing that improves matters, but yields other errors: most of the tests
>> timeout while some generate confusing assertions. Both appear to be 
>> related
>> to the data addresses in those notes, which are incorrect when running 
>> on a
>> big-endian host.
>>
>> Adding tswap wrappers, which will conditionally swap if the host and 
>> target
>> endianness don't match, fixes that such that check-tcg-x86_64 runs 
>> cleanly
>> on an s390 host.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   hw/i386/x86-common.c     |  6 ++++--
>>   include/hw/elf_ops.h.inc | 20 ++++++++++++++++++--
>>   2 files changed, 22 insertions(+), 4 deletions(-)
> 
> This looks similar to [1], which I've been desperately pinging for a
> while.
> 
> [1] https://lore.kernel.org/qemu-devel/20240929180659.3598-1- 
> ardb@kernel.org/

That's pretty phenomenal, thanks for the tip. I didn't dig that far 
back, but either one should do the trick.

