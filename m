Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D9606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LsWdcZxk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Eq4cWo8A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMLJl-00074E-KE; Thu, 29 Oct 2026 04:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMLJk-000746-Cf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:17:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMLJi-0006jN-OG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:17:00 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5Gx1p2427217
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GCrbmKZ3y4FJpgXmbkusZueZ1LXhw6lcSN3r7eEJyfo=; b=LsWdcZxkZVS9agih
 mKEJ5ovSrDX3J396lxZeUUH+4STANI9BZE0Y2+khr58uLJP43wHcyCPLnDeJ5xp+
 d6n8GPK8hAoYAOB/3HMJCGbkcdCnTiuus95fwzR4K/NhliQp+LvgJP8s7hBlEx6e
 T5wKY1Q219IqFOKv00UvGLQUUq0kPZKxj1W8AMWMA4o0rbjjX6pDswFsQf018VnT
 lq/7Nerl+/Pv09qJ0zwagIn83HEYt2ZZ9Ja417/PK9JxI4CqznUvUJimOiCza0+r
 Z+ja/KXce4z7164cYZRXwhiRr3nIxNi42hd9pLFj2Zlc7zkLH0MRSsHadXSfCdF1
 SIYwpw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb2b0jy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:16:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c5ab5c136so283100285a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793261814; x=1793866614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GCrbmKZ3y4FJpgXmbkusZueZ1LXhw6lcSN3r7eEJyfo=;
 b=Eq4cWo8AB9M8rgd8BgC608xgxt2Rsqfy42YyCD48pqk0F76zStrD2rD2Wp1U41jUZJ
 ahdx3qMNPMbHYC/9sysNeV4q4Hgusf65bvXDOEc4XZPuURWogrm4Ee7AU+HeND6aFno7
 9+ATLizrDbBulvmdYAF9gosQ4rmAHQAPHkJD78+i8XKyXW0G+dPb6bNQg/VuY+KSem5P
 cT/A909Q2hd0SUWJXOwvQ8lhgKwrl+zT4QT6veHUKLe+zEbPPrU7DPVerg4PVo4WtHbr
 ZIyVPUwMXKm+5dnkNL2hnm/PFZaxi5i8o/1PuPioh5yhcKD+MYhhJaK+PWcL1Boq4G2S
 pCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793261814; x=1793866614;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GCrbmKZ3y4FJpgXmbkusZueZ1LXhw6lcSN3r7eEJyfo=;
 b=pwISXzTP8K/+KLdis2xKZYKmCCACjKH5wvvg9Kk6OldtgMT40h9UTGxFm5EOxcIDfM
 QWwCNYZWp+NtNAqRsq93n0SDy+XxINP6z8QbxBLh0dvjJI9Z2WvG6jQFlMI+qghgcW/p
 p+laRlQxFNOYvMCBLukZ9lu9thnGS/qc2WAz44G5SrZoLS47kMaOrSYz4p8oJXSkplJr
 bPvnakeWX6XCXvQCZz+vU5HHqcX42KKrmPuK+CcMldEPgFbB90S7TOiwC5s5jlqulDwl
 R8YZOkGYDKU6sHDy7q94LUZqmQGN9AyE/3btTIzR3hc1B811IHC1mnVVGTs/pKzjp/63
 lGmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+XnZym/UHP6fIZSf4Zot9Uv7DtoMqS31PlI5fyrTSnmrai4HfB1Ixhxk1t8V+VxpU056q8e2j3cPT@nongnu.org
X-Gm-Message-State: AFq9FYLpokK/DvZHIoBzlqPVJjcf5E90bCxJMTz2HNmgqhYgQuf2rAZB
 MqOdAOThEVgLasb487WSo9Ho86bANIe86tsZcBqh/uC2KofB4FiRCAycKaJoQDMhJVk8s4Gvip8
 GzEi70s7aCl2MBcoRCVXJQXjCDc6WZmeA7/vepXE350inLUHn5buTZe24AQ==
X-Gm-Gg: AYBFou1CNtEAI+0TiKI8pmZPHjRQ0455GjeL6+AT5o9Djre8dlrTNOVSeVVSh4y1HkZ
 c3ISuQzo1fBO56J7ZNNSZpEJ+gl6K4x7jGAMzZ/XoQQCzYIPoAhZzSzsqBOIJK80sgX7uoo364d
 ay0MiQq7macapnB7bbcCatUBUzmRfPm573quhDOHBGCyNz6/mFCPg+4djQWpVc2yw8YjjU0p+s7
 99TrSHO1LuNadDBDaW9d4HW3X2dfVrgz7HF2tgiUJGaeKHX7fXxLmmtVE1bxkIzUTUhEevO+rhM
 NnrrhZJtAzvV2W7e5wDcTKV073xvQsYpFn6M50vOMn/riuv3HXsu4z7BGAuAy+bNeB1dH15irZi
 sQK6v+l2WwCfPI9t4jXM6+GMzegNuD5g8cDZhEL1sMNXsr/idEwcrULmwK67+bz+9jRecqkJh/9
 2MdaOJ4JSwQ277VvufSNxMWaQ=
X-Received: by 2002:a05:620a:17a4:b0:93f:2ba5:1704 with SMTP id
 af79cd13be357-94408cb5c48mr726712185a.18.1793261814646; 
 Thu, 29 Oct 2026 01:16:54 -0700 (PDT)
X-Received: by 2002:a05:620a:17a4:b0:93f:2ba5:1704 with SMTP id
 af79cd13be357-94408cb5c48mr726710385a.18.1793261814167; 
 Thu, 29 Oct 2026 01:16:54 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94eb8dc84sm41871905e9.2.2026.10.29.01.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 01:16:53 -0700 (PDT)
Message-ID: <b5a48399-4a42-4f8d-9cb1-cab4d5b342f6@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:16:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/tcg: Massage MIPS tests for easier maintenance
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20261028192124.30941-1-philmd@oss.qualcomm.com>
 <057696cb-8206-4d9c-8dae-41c39df6fdfb@oss.qualcomm.com>
 <32777ab5-3c29-49f4-9650-765fc6648aaf@oss.qualcomm.com>
 <83462522-58d8-49ec-8e98-c164cbcab54a@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <83462522-58d8-49ec-8e98-c164cbcab54a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae300f7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=DIytO6QhXqaAQeevGK4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: LTobes6nNw6bhQo11T4ye_8fo8zwRVvr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzMSBTYWx0ZWRfX5bovghyVaeA1
 SqFjov48x+qphJCRdEno4XmrxSZYcrMpvAc/rovJzFwmVQxTYJjlQh4BgqHelbcrsaGG+q4Hs5F
 kS6MaOvbIlRiaSk6x5FoQ7cPwrr5Mfo=
X-Proofpoint-GUID: LTobes6nNw6bhQo11T4ye_8fo8zwRVvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzMSBTYWx0ZWRfX13G4sT5oUGA9
 yDxfI6FSoYiZ5cpzEgZFys2AIKfvskVJizUUmLiAIMc9NE3DPvLKGF0lzDZPOpsJr/hp2pmY8j+
 xEL76rUiaPafR359CFx9oAFu8fGI13EpjFapqRyFJBKBomzpLodidLzJjSddT5N8XJXm9a8fpnw
 YXkjCtRqpo/xUZopTZd2FYdJvqJGb2HSlgAMcRVZtHvaz59EtwZpT04vkqqEw9ybA3pJUa5ZKlj
 /tjDTATpbHe3kzIdUJ65VvPliauvmeKd0R407bwyiIh7UlVfiBOD5DAyjj3oRzkcwRYbYq3fHR9
 tgfcQIZCyxsEQBguKjNKhS8L1zqYnE3mxhdMfv0WPBxih3oGmTsTH9DEpKQ5qnl/MWZnvWAPzkZ
 aT7hwPGl4sQsMmX0mbYesTLjW1NbXhoI+I/tRUIXD/vDik6VMvh3H1foR9io7dlWfVYaDdG+R+8
 cKZ/j99xrWbep6b56qA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26 08:47, Pierrick Bouvier wrote:
> On 10/29/26 12:04 AM, Philippe Mathieu-Daudé wrote:
>> On 28/10/26 21:07, Pierrick Bouvier wrote:
>>> On 10/28/2026 11:21 AM, Philippe Mathieu-Daudé wrote:
>>>> I'm glad we have many MIPS tests but they are in too
>>>> many files, taking time to get compiled. In particular
>>>> on Aarch64 host via x86_64 docker image... Group the
>>>> test in order to reduce CI build time.
>>>>
>>>> Philippe Mathieu-Daudé (4):
>>>>     tests/tcg/mips: Clear DSPControl at start of DSP tests
>>>>     tests/tcg/mips: Group DSP tests
>>>>     tests/tcg/mips: Group Release 6 tests
>>>>     tests/tcg/mips: Group MSA tests
>>>>
>>>
>>> That's a good idea in itself, but this would need additional work to
>>> have a clear report per test. We can't trade usability for faster
>>> compilation.
>>>
>>> Right now, a test will stop on the first assert() met, without going
>>> further.
>>>
>>> Ideally, we can keep the list of tests in a static table, and perform
>>> the DSPControl clear before each, so patch 1 can be removed. Also,
>>> assert could be replaced with a proper return and print information per
>>> test.
>>
>> IIUC the requested changes are only for the DSP tests, as the other
>> groups (Rel6 and MSA) do not stop on the first assert() hit.
>>
> 
> Yes. Other patches still need to add some reporting on which test failed 
> (a print with OK/FAIL is enough) instead of just a global return code.

Right. I'll try to use TAP format so it better integrates with meson.

>> I'll rework patch 2 (indeed 1 is then unnecessary) and respin, thanks.
> 
> 


