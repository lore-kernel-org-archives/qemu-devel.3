Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815C606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XR1dZXye;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KdMxtzt2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVapD-00019h-Qu; Mon, 23 Nov 2026 15:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVap6-00018x-7i
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:39:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVap2-0000c3-VC
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:39:35 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJuWlk720818
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 20:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NLUbQ+pw8kNVH2HWuNKEB/3PR8RGWVT2ZfxbcCHsLWo=; b=XR1dZXyeL20cursr
 OdXnoblqncVEqTs4mDU2eHM76W20t0Pzj4fPXp6b5LqvmhUgwKz7kJOAjCBDu4hI
 K+Ti1h2n5xPFZD4mfmjGM/6mM81iXx2fMcGOgyFERDNTd4sowJXVwg0n8YJNrhOK
 N81khd2pGVz2KbYS0Nu8arra5ifKGMUbFx74XQH5mYG8HKFk7ueQYwh1DA1RDBvu
 NDFryS2hsWgYvmguUujsa89gONbPFX2IlCeIW5Eadz5NbHGWi8Sm+GQjXr3Dqi6m
 cXu4HAzaKI9pCnVRVfF3e+/lFNKE0khgaLNCE89L+6kr6uqLK/9l+xiNhLjnSBxd
 cI9dnA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukqg8wa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 20:39:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-55d2bde4c78so56946371cf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795466370; x=1796071170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NLUbQ+pw8kNVH2HWuNKEB/3PR8RGWVT2ZfxbcCHsLWo=;
 b=KdMxtzt2JADEVhd8kDutub55mgRYinZ19p6F+4CpkiLjfX1yTDz5mWPhMPaxGK12M9
 vKZXja4ryrOQpbZnj98pBZJjNATUOIOUe9RKwrPoNEHjwFcxhh/3s/Pw3hFYHs3C9AeD
 JG1n8/vbblXQ9ocJJBP1y/r8F5Gx9odpOL1DN49WTIJXjMEFcPaSgfpj/d7Nt4LO3Lqe
 Lxb+bmgYiV6SjUdWe383R50Q1sfCrh7LRbvBi5tLZeVD5iPNdls34goDJw51kKvGJd33
 MPFF23byrWMZVISPBu8RazZK8JE19Y9O43+FBfm4wq8h7W9tRaATid8xUzShc3gZZLza
 3sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795466370; x=1796071170;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NLUbQ+pw8kNVH2HWuNKEB/3PR8RGWVT2ZfxbcCHsLWo=;
 b=awnlnJIH95t9r+n9488bdDB6srUZEBWsK7TafGXjYrllzAl3yrW5eoCfVVxy8so5CJ
 Su+XnXhdwXlZTMIgIIM7IjJCKWtj5MsA8PmeVlNnGPGV1a4ZslIM0pV8o0+1e7OOtvYA
 5i94oSmA+uNjzhBd8BATNd2OhxN838Sg86R8HliN77QqZ6yzHy7QD/3rm5PdAISTe7wi
 tUpuZK/UzyZRi44ey2GpkHDaoM8VDIEq5TcFP/UhtMZBSDQ1VdHnS9iw9qZhgvudYdYr
 cswaQB6ah+Ld7ykBk3Oag/oymclFv+eT8iYSLAHCBGxMxdJ9OwONNk0hWsRZhATkji5y
 Ws/A==
X-Gm-Message-State: APuU4Z8DBuP4pzb4myV/vRGOOkq6NBASGi322LKgV4f/7uWTzHfZ6aDd
 QxuzchE1BHYygZMbOHGTYUbzyOYjg6dq/L9Iv9OtKi/+uIlL2WM54C6F2bMWze27uT/ktieKLi7
 Ru2bvZVUIwwcF3E6y4MZoH9QqNGUQ+xhsuQWUbbfKSOrxgVVC90WsmvVIbw==
X-Gm-Gg: AZFdTZcHCcnCiiZfc0CWOYQPzIaJ1B3jGYxlYUyaAnCAMwb60kwJftjyeEerAGeNR2Q
 NK2FKzJ5QAT2LkH2tlanC7WtkE7ssaM9AgWrUwLLFSLqOOJhtstFpJ6zQDSRQSsXFm0Wwz4pSa4
 Qy4qVO26B/ACzsc9L0BfvsarFSFwUT/S9db6Q32ApNqlfUYuNyp2Vix/c7AUziV2pbWdeaMW8zP
 J4cd04mktlxBfmlLY5sTTFmI9s1rncxA/4Zn3L2OapeeSXJquIHLSYvtt6HmRb5gHRS2XQfiX84
 NiZ4/53Vi2N5JQMH89YU2NMue6nFJWXXBkv+7h1tyyQmFUX96VrAibzq8/1V+I2xH1ZpMHb4gwL
 ATn9x2UuiyHecdbxaTIz8zPvIvej8Ojl+BCCj7llGYKUuQnZlEYk465YPejIy1BF/22IJXPTpNa
 CDAMU36rJE
X-Received: by 2002:a05:622a:4ccd:b0:55d:17e:f7e with SMTP id
 d75a77b69052e-55d76aa8762mr208061371cf.75.1795466370342; 
 Mon, 23 Nov 2026 12:39:30 -0800 (PST)
X-Received: by 2002:a05:622a:4ccd:b0:55d:17e:f7e with SMTP id
 d75a77b69052e-55d76aa8762mr208060681cf.75.1795466369749; 
 Mon, 23 Nov 2026 12:39:29 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb40ea12sm887679785a.35.2026.11.23.12.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 12:39:29 -0800 (PST)
Message-ID: <a39697db-832b-4746-b16a-d4df27c5171e@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 17:39:24 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/6] hw/riscv: implement CBQRI bandwidth controller
To: Drew Fustini <fustini@kernel.org>, Sunil V L <sunilvl@oss.qualcomm.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Patra <atish.patra@linux.dev>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
References: <20261111-riscv-ssqosid-cbqri-v8-0-121f6dcfb573@kernel.org>
 <20261111-riscv-ssqosid-cbqri-v8-4-121f6dcfb573@kernel.org>
 <87e5d269-d875-4afb-87cf-2b2658a7b740@oss.qualcomm.com>
 <awSBkD9LuNBoZLm4@thelio>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <awSBkD9LuNBoZLm4@thelio>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Wu++otfv c=1 sm=1 tr=0 ts=6b04a483 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=V1jnuoLLAAAA:20 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=GlCrJtrt_9WjeoYueIMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4MiBTYWx0ZWRfX9NujUwUPEIST
 ribU1EPEmqTHasbtgJscMeFP0rIzgqRrp2/IlXfp7pLGP4MALU0ix/wjuiQhk/HARDras0mKNkk
 BDk/gaEYzI7zIUSDvMo7E6VHCzBq/NaQKHagRGsv9y1+x6FHzPwuqF+a7cK+5PSL/ShEgwPN1vC
 Kimz2PnC20jAZB2pbi4wCNB3X4eZZVW/Sm7jM/AwvAQhyoG3tI6lPpCis61fRvz6MnTpHO0qC1V
 BhsTi/gq8IJtEM6qz3wjn5Ew5fftyBuXuyte09cylQ7EECLEOFjPnc3+jmgxwgUoi34YiTICN6A
 agTfXvGByeOZd5pOzqN0DQpqBtaT1VGvVzbZBfP26d6Y7+SgvY0Z5B1cbCaD1OX9xV+TAGpiYdo
 YMht8BMdj3JFsLD/OBQ3uxsvEEjT7bQGtxI0yeYqOqMS+vtKPMJ6TNYFjrYClx5vp83VNNaZbk2
 kPdwD1BQuZ+U6SH18Fg==
X-Proofpoint-GUID: 7Mn30UZw2LAT4xSkO6YU90CP7L3FFKSH
X-Proofpoint-ORIG-GUID: 7Mn30UZw2LAT4xSkO6YU90CP7L3FFKSH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4MiBTYWx0ZWRfXwJMI2Rzhqkwu
 VjX/HdA0G+AO8Z0yG/l5S/T0YtnnmmPrndCSYMjCfVM3K6gYeusfec1iELB1xPoksTulVhvBPJu
 KIgzicJCIR57ofx7a8yBIko7rrgVLFI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/23/2026 3:10 PM, Drew Fustini wrote:
> On Mon, Nov 23, 2026 at 12:22:03PM -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 11/11/2026 8:38 PM, Drew Fustini wrote:
>>> From: Nicolas Pitre <npitre@baylibre.com>
>>>
>>> Implement a bandwidth controller according to the Capacity and Bandwidth
>>> QoS Register Interface (CBQRI) which supports these capabilities:
>>>
>>>     - Number of access types: 2 (code and data)
>>>     - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>>>     - Event IDs supported: None, Total read/write byte count, Total
>>>                            read byte count, Total write byte count
>>>     - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT
>>>
>>> The controller gives the Linux resctrl support for CBQRI a device to
>>> configure and read back bandwidth limits per RCID on the virt machine.
>>> Only the register interface is modeled. The configured limits are not
>>> enforced and the monitoring counters are always marked INVALID because
>>> QEMU does not model memory bandwidth usage.
>>>
>>> Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
>>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>>> [fustini: rebase, add fields introduced in the ratified spec]
>>> Signed-off-by: Drew Fustini <fustini@kernel.org>
>>> ---
>>
>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> Thank you for reviewing.
> 
> Alistair told me in the qemu riscv call last week that I should have a
> tcg test for srmcfg csr. I need to send a v9 with that added.

We had a call?  Guess I missed it :D

> 
> Alistair also expressed concern about adding caches to the virt machine.
> He explained to me that the virt machine is really meant to be used with
> kvm and there really is not a role for modeling caches in that scenario.
> 
> I had recently considered sending v9 with just the Ssqosid patches and
> holding back the CBQRI controller patches until there is a real hardware
> platform to model as a machine in qemu that implements both capacity
> controllers and bandwidth controllers. Atlantis only implements capacity
> allocation for the shared cache with no monitoring, and there is no
> bandwidth controller.
> 
> However, I am thinking this morning that I should probably just post all
> the patches again for v9 and see what people think. I think the RQSC
> series is more complicated since it does need caches added to some
> machine in qemu and I am not sure what the right answer is for that.

Fair enough.  Don't forget to add all the acks you've collected along the way.


Thanks,
Daniel

> 
> Thanks,
> Drew


