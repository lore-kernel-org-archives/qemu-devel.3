Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F1606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nkq1l3hb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTb1N-000362-Q3; Wed, 18 Nov 2026 03:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xTb1I-00035T-5r; Wed, 18 Nov 2026 03:27:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xTb1E-0007gP-Ra; Wed, 18 Nov 2026 03:27:55 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI2SSJf2432379; Wed, 18 Nov 2026 08:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lVwZUK
 gXmG+GyiwPE2vjnLxdHvL6jl7K/3+zcyi5oJ8=; b=nkq1l3hb5rfrjCICaYjoNq
 TeMC6EqkqyDa5AYy+7vrey3rKJZN0hN2CqRYhcZjHdwZKatU5uIGak5xJjWfXshm
 5HTTor0Zqze2QsynQUPQ/Y4gFU/ddIn3pT5LAGkETGRoT9vg5F12DJnA9joAHqfq
 bw94/Y4xRejLXyWDjOKk+H6klcNJg2E4JgthjbBC2zbR1u5hHUWS2fRbbh718G8O
 Fa5iydbuOMzs8Gsa8l4Ge2s4+kUzbnexQQqCyyiitu+vRa/w3MtwJFZ9oVL6qvn2
 Y8WpCQRVGJqHtvt031nqNQ0sQI6dXBeDapELvEiblEbWuxHwxAAT8z6dAVP/l3Jg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rhj37-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 08:27:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI87KJr2766468; Wed, 18 Nov 2026 08:27:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt7r3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 08:27:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AI8RjaL11207608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Nov 2026 08:27:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8DF058052;
 Wed, 18 Nov 2026 08:27:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED05358056;
 Wed, 18 Nov 2026 08:27:42 +0000 (GMT)
Received: from [9.111.1.121] (unknown [9.111.1.121])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Nov 2026 08:27:42 +0000 (GMT)
Message-ID: <639f0cf2-f637-4fd4-bfb8-645c584a9377@linux.ibm.com>
Date: Wed, 18 Nov 2026 13:57:41 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/6] spapr-vscsi: clamp adapter info DMA write length to
 struct size
To: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Guthrie McAfee Armstrong <git@gmarmstrong.dev>,
 Gautam Menghani <gautam@linux.ibm.com>
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
 <20261028052024.38377-7-harshpb@linux.ibm.com>
 <CAFEAcA-CML7CFxn7WC0d2uuE6cHJbM2-p2Lv-wcAXWU9kpsRWw@mail.gmail.com>
 <e2e9c608-f139-447f-887f-8fb4909470a3@linux.ibm.com>
 <CAFEAcA8M6PhCQV6EtKSp9VtqroA2Ah82y1--q_8Argg686_YwA@mail.gmail.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <CAFEAcA8M6PhCQV6EtKSp9VtqroA2Ah82y1--q_8Argg686_YwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NS37BvVQr6epYuHvpcYtyRgo-GkIODIe
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afd6183 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=mzCaFhDXLt_ih2R9WysA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzMyBTYWx0ZWRfX7ZhVe2wQxwGi
 RGEOHlWncforQS8moRuzqqQi0E60/LwFpmK+ub5JWwTGIygLt3Tucjun4dgTHloKUv0VwY81AMe
 JxMBgaHSW3B3L/hNmcFTzAORfhCbBAU=
X-Proofpoint-ORIG-GUID: NS37BvVQr6epYuHvpcYtyRgo-GkIODIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzMyBTYWx0ZWRfXxuaMY+Oy8a4B
 laOvh8ZOGgHM6DLrPVtNJySPQNAtiqwTQD/c9WrYjlbsNUb++Jz6EFPJJl6onf3eG1SPWDv8LSN
 IjBsA4XhMre4Da4hxDzQ69j87PNBa1Xl1zb2ExB5gShIbVTncPl/F80/z7zRRC/SSTBwwQkNO9N
 lNIAQ2ioUDpBe7y9Q1xEDQunZ+a39DF/BG3/x9vaV+nNIi7u3fVPHkgAI/Y1DCrt7RMZ/mJk9gx
 VJal2EIpJ8X6s+PyK+Zkn6MlUDCuXC52hY4RZA77o7RHG87E6JbaWwl8atHl9gGGjPfjm+py1WY
 MiJk4Z1Kup1JYKkt8YfbYyltcVthuQod5ScUSXmrPn6qZ6KPL/utOx8qnUvcCB51z3TeQihnUg5
 8CSvdwYEpBHuA3Q5PcU1S3Wrphv2i6WozvSO51/YR4CCjz58kZcyFlw+jMMK9I2NfJ88QvJtXCx
 6w951Zget54II7ikmhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180033
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/17/26 20:47, Peter Maydell wrote:
> On Tue, 10 Nov 2026 at 06:54, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>> + qemu-stable
>>
>> Hi Peter,
>>
>> On 05/11/26 8:57 pm, Peter Maydell wrote:
>>> On Wed, 28 Oct 2026 at 05:21, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>>> From: Chinmay Rath <rathc@linux.ibm.com>
>>>>
>>>> vscsi_send_adapter_info() used the guest-supplied common.length
>>>> field directly as the size argument to spapr_vio_dma_write().
>>>> Since common.length is controlled by the guest, a value larger
>>>> than sizeof(struct mad_adapter_info_data) (148 bytes) caused
>>>> dma_memory_write() to read past the end of the stack-allocated info
>>>> struct, leaking arbitrary host stack contents into guest memory.
>>>>
>>>> Fix this by clamping the write length to sizeof(info), then using
>>>> spapr_vio_dma_set() to zero-fill any remaining bytes the guest
>>>> requested beyond that size. This mirrors the existing pattern in
>>>> vscsi_send_capabilities().
>>>>
>>>> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4626
>>>> Reported-by: Guthrie McAfee Armstrong <git@gmarmstrong.dev>
>>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>>> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
>>>> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
>>>> Link: https://lore.kernel.org/qemu-devel/20261007144434.374749-1-rathc@linux.ibm.com
>>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Shouldn't this be Cc: qemu-stable@nongnu.org ?
>> Yes, should have been marked for stable. I have CCed it now though.>
>>> Given that spapr-vscsi is supposed to be covered by the "virtualization
>>> use case", have we deliberately decided we didn't want to give this
>>> a CVE, or did that step in the process get missed ?
>> I think it got missed, can we still request for a CVE to be assigned on
>> the gitlab issue?
> I asked Dan on IRC, and he said:
>
> "depends how far in the past it is - if we've not released the fix
>   in a major release, I'd jsut temporarily re-open the bug and add the
>   CVE::Required tag, and close it again once assigned
>   that way we at least get a record of the CVE in the issue tracker, even
>   though its missnig from the merged commit message
>   if it was already fixed in a previous major release, I'd just accept
>   that we dropped the ball and move on without a CVE"
>
> which sounds like a good idea to me.
>
> Speaking of things that got missed, what about
> https://lore.kernel.org/qemu-devel/20260819095855.115823-1-rathc@linux.ibm.com/
> ("hw/scsi: validate IU buffer bounds in vscsi_preprocess_desc()")
> which is another one from Chinmay for this device that got posted
> back in August and never applied ?
Hey Peter,

I have responded on the original thread now, and shall take care going 
forward.

Regards,
Chinmay
>
> thanks
> -- PMM

