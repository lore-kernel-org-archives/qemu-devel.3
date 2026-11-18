Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E1B606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fA7vI24o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTdWP-0006fW-6U; Wed, 18 Nov 2026 06:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xTdWN-0006fE-Ne; Wed, 18 Nov 2026 06:08:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xTdWL-0006xX-TP; Wed, 18 Nov 2026 06:08:11 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI9u3dA3353875; Wed, 18 Nov 2026 11:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CZRtUZ
 m0CNJQykNoZwgAa/tK+0hbB5c62u0ycej7Seo=; b=fA7vI24ouUEq0b7u8t2LPN
 raeafo1zIyRKX+Wdg1MnHxjN4idb37WJexJ5VrJJ5eSoIIOZV6GOUXm8cS2HrVPW
 9SNvsdPoSaQyyvnsVzYNi5G8h04HF5lB+UyEiuPG8lTu4pD1+buuKDgFjbOopuCM
 cyVyWViddagkfZi37PTa/i/NiiejABvP9QefJGz7NnBdC+wUyEEo1F1g8P8+vz/M
 GJHK2Gm2QZJc0MvGpE14vWmNXVm9YQSHLLMuQFGueQX6KEvKhZKPv4v9EY5DHP4H
 lq0I6SMNmEZk/1FeSwQW+tXSsEjxGFxURs7NpevlnE1g43GtbPdEKEln1TmJDQ9w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rj3ek-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 11:08:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI9o4fJ1832228; Wed, 18 Nov 2026 11:08:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4rmmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 11:08:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AIB84ZM27853366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Nov 2026 11:08:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAE9E581CA;
 Wed, 18 Nov 2026 11:08:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAAFF581C9;
 Wed, 18 Nov 2026 11:07:59 +0000 (GMT)
Received: from [9.111.1.121] (unknown [9.111.1.121])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Nov 2026 11:07:59 +0000 (GMT)
Message-ID: <d6c8b7ba-bb57-480c-bade-ae01a9120037@linux.ibm.com>
Date: Wed, 18 Nov 2026 16:37:58 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/23] target/ppc: Correct Freescale Book E CPU models
To: Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org
References: <20261108120034.1755008-1-bin.meng@processmission.com>
 <CAEUhbmWFfi+ycKbN5SiKbtUyrygTXY0O3KnXG4yGngZ=iyGr_g@mail.gmail.com>
 <5F527386-CC3A-46D7-B3C7-7F4261E39136@gmail.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <5F527386-CC3A-46D7-B3C7-7F4261E39136@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rSr8vjn8Ik9mNCj3-u6gcn1eODgPQZnn
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afd8716 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=HsF93EWh0V1nCGVCUcoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0MyBTYWx0ZWRfX5aeLGw8iGU0/
 T8ffttIIxyO4DTzmXumbbxlQOrXbuXJqQHzHZIs0ki6q6IfCasQQSuKYBLBUcXKcpPoqYi2u+Zd
 p+j9bldg7RHJizXCJREE9hu/ybQSs1c=
X-Proofpoint-ORIG-GUID: vpHyQOHLWiRu6eqUzVXkxxlKwxxeo6ha
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0MyBTYWx0ZWRfX4hDy6MLysgg+
 yXBxifqEvMvt3bvydXDd/qZrUtkMRvRR13rY6ddi8NyT8iv1G3iayv0teli7pEgPFU1OIZU1Gg7
 Wt47q8Py5G5DmxJtw9UI4MFsxAY3VuITd2VvXDUQ63WRa5bbUw8a27x4/j/VZGkq2fft65+PZme
 2mjwsdgOEueni6spOl11brKe31kuOk8VaWMaeqnU67pXniaRgWVdAN3JjmmiIGLvZCTj3UaMj61
 lPM/D4gWqWSLWJFBj+maNSfoNxRekUl8Z+6xTCfNdQ+baBIc969bjv3nIK6Yt1yixCWTnbmVwpK
 ooUuNgR6xe4So078VBLgLBD3YegcWJ5goUzPuzM5xW77vE5sisqXp1J/TqgLUYYSQsxHHDeLxMC
 15bx2ybQ5VmR9LkzML/YVYVNb4jNldkD4zhKYiFUPz4Lo+YkV1/LVveIOrRzftNib52CUKKwfEc
 jVjDM5FI92CdngaoApw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180043
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/16/26 17:33, Bernhard Beschow wrote:

<snip>
> Hi Bin,
>
> thanks for taking care of the e500 CPU models! Back in the days when I became maintainer of the e500 machines, I deliberately didn't volunteer for the CPUs since I don't have the bandwidth to do it. So go ahead, I'm fine with the changes.
>
> Best regards,
> Bernhard
Hi Bernhard,
Thanks for looking into this. Since you mentioned you are fine with the 
changes, requesting you to consider giving a Ack-by or Reviewed-by, as 
you see fit to help merge this series.

Thanks,
Chinmay
>
<snip>

