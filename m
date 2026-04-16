Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FE9F433D8
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 02:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDCNk-0002Zl-D1; Wed, 15 Apr 2026 22:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wDCNi-0002Z1-7f; Wed, 15 Apr 2026 22:23:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wDCNg-0003sx-H6; Wed, 15 Apr 2026 22:23:01 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FDoUPZ1834705; Thu, 16 Apr 2026 02:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Pt/vF7
 Eu3/Dn+793Fi4XBlHt/qpT6oNXMC//l9SCvIc=; b=gUjK6/b+vyonmHegxMhwkv
 kYwK58GCj8BoDs+0vGD3iaabzztyp4thrH1DzVrEC2RdnXWCG/VI8ABSTYMkE5L7
 ilSq580NBNULZqB+LguN/jpX0SoWuPr3dctRfxpFIujcgTmdtX+UrO4Qgdb0kdxs
 vcEwIe0ZPUT/8Jai+8lICh/BGr6d1mhTxUePUyDPKHKiC74/TocET/e8EyWKKhtH
 VdFaowf2KxUNPZeJQQVfTgdSqDBxqyj7M5rj/mf/f58XpKul15OfZygQIog+/4ea
 qsAX8TRVnjugOTZZ56ogZB+2UxVLdiggnrG25xeBKsjaLunOV34AP9mV/yD7AZ/A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rk9re-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 02:22:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G0aHSW015164;
 Thu, 16 Apr 2026 02:22:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mss6h4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 02:22:47 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63G2MjSF32834280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2026 02:22:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A894058090;
 Thu, 16 Apr 2026 02:22:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2E9158055;
 Thu, 16 Apr 2026 02:22:44 +0000 (GMT)
Received: from [9.61.14.120] (unknown [9.61.14.120])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Apr 2026 02:22:44 +0000 (GMT)
Message-ID: <e780174d-fd97-42c3-8f2a-556981e78421@linux.ibm.com>
Date: Wed, 15 Apr 2026 22:22:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Prefer MO_128 definition over magic value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
References: <20260415220358.93063-1-philmd@linaro.org>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260415220358.93063-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAxOSBTYWx0ZWRfX20gO+1ORKVT8
 /ddYN70ZufPRXhUXHIjdJW/Q9LdtFu2PnLPRZktjVvvZHRWKrNz/MkU990E0nwYA89FHNnAlj6Z
 cdyuqvDdj6MI5kHmwtqwIrYuWRpTbs/KqGq9Gzx0qZdAv2b76nHvGrDB4kaxboxtT2sPIyNe0mm
 v+GDAQDhqqGcaOB8+5yfFGOLYfZO9BJE1aISb10GBZCEtVhQXV/HuqDs3IUnJ6HB9/oTAqyF/Zh
 T22FQFRcASno9WJ0TjOgQEAFn9/gXJidi1aHH9y0HlLpqdqRg10aUMnPnEb75J1FW8FQ105A9UO
 JQaQ4cmzUwQTjlb7S0Au5veSNHF8vfwd3rm5aBHt0SofQvmoI6mrQuTsIg+dq/LmOXQZ994WDV6
 3PZ63diicox/aBmEa3YyqY45HFNvEPzPYrku95Rec5UNqQInDwuy91KqLMVEnSlxCjFnqEQfK1F
 XaMUDcW1Xvgifq6RLKg==
X-Proofpoint-ORIG-GUID: wxyTkz8GZNJh3gnmU2n4jGOAzQGZpowv
X-Proofpoint-GUID: wxyTkz8GZNJh3gnmU2n4jGOAzQGZpowv
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e047f8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=ZsUDtwrC3IPfZBtdUEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160019
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 4/15/26 6:03 PM, Philippe Mathieu-Daudé wrote:
> The MO_128 definition was not existing when commit 6d841663be8
> ("s390x/tcg: Implement VECTOR GATHER ELEMENT") introduced the
> ES_128 definition. It was added 2 years later in commit 4b473e0c60d
> ("tcg: Expand MO_SIZE to 3 bits"). Since it is now available,
> replace the magic '4' by the more explicit 'MO_128'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


