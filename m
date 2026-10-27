Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A97606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cmllVrhA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kLqzohTo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXuI-0005Bn-2Q; Mon, 26 Oct 2026 23:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLXto-00044Z-1Z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLXtl-0000D9-VZ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:55 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2ExST866306
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qb9a1Xok3KOXSG1HguVlOeAoQK2JjtK/C3APlmIkeD0=; b=cmllVrhAIYJqBA8X
 xf7LxP9Fsng3AOi1nBh83YUWM62mH7cN2X0CyM06PvqPzIJAlgBAnA48Mn1Ux8H8
 Vrh8/FyKj4onZcOMv97TlbcBY4IeLE4UJ6tgHBdNlKnSTn1bne1BPp2n/RQcKQRq
 /Xnx2danrPtLOMKep4DImst5pP7UiS5bVIwT4dz3lkqHR/0+Z6USKAxqthICdV4X
 CexFGHi4tiRdWXiTQIbZzraT0xBi8N7+EU/8enuD4e6lE2zrBuDvs/k6x06z8eel
 39U5WqkGS3RQ00uD+WV7JzH7tf3jhUUAJJXhgbqW3ti7sB5JPxK/+QYhBG3yHV0n
 M4Ig0A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xtw74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5ab5c136so647699485a.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071846; x=1793676646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qb9a1Xok3KOXSG1HguVlOeAoQK2JjtK/C3APlmIkeD0=;
 b=kLqzohTox/3rRbJEiKoWjh4YY3f/t0D2bfuHei3B7EMXhUqpW8KwygivdnLdkYq8yw
 Coc91WOuTTrXSjaqlmhUwYNVWtxefyF+L6DXNr9v3pQGUt4iEFXD4RO7OMCMlsJsVB7X
 ycA3e2Cib8Nl1h7Ho1NSKo5J8gRZORIX9Xm3tQP/lilxDGRZxrqi9hY1Iq8eBIJTpdc4
 gK/SXXxbwCyJtHGVn2TjE5UHSwDBpD84f2XwnoPG62wEAoB3aedmL7TAnxi7kinV9yC6
 RrF37B+0W1FgjP0VH+giuHNUwUKm1SomVfJkfQ7jok9BbF8QyvnbsAvmHlfmCGF4oajM
 RgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071846; x=1793676646;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qb9a1Xok3KOXSG1HguVlOeAoQK2JjtK/C3APlmIkeD0=;
 b=UVXfvhLWFxFeNWOU5lkYc/MmB4No5RoTqRSFrt8oHM/y3F2tIlV0UyOh8RuigZWies
 oji9ymf4XydrB7luiA0AAKkRhu+NJ7Zh3dlQnK6F5N49fg734mBLCI6IUYRoX2H9b4tw
 pDt0n+GBtahHq44PxfjND/rjdLJUri8jowWpOgrxaGhpa4mGLNLUpf7K9dXwqXK0d9i5
 v10FAn5XNlMvBTeDf0rBTtryECdMpzkTkrSaeSCd7tgYg9DuOcndPWR4Qr1dhyG/qYut
 LC3BDpsEFsYnuL5wEXcyhm8tA/UssnU6P/Jfk/wjBrs1lDekxb6gDsG7eKf3szqeVHK3
 6uUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLR/i+Jy61Ry/FOtFxayPV/WEcki0YNnub0PIQMhSFeVT3GHVc74+b6dI7ZSC4MIVxrKLC20TPK5+c@nongnu.org
X-Gm-Message-State: AFq9FYIgL7KlCfwizxwK758to2o8Z8bPJzymQc3/r43ccx89vACXzVgO
 i4rufnjKcmfEnm8mXLrRhv8Qj+gPinNezvGopPaAqS/gVPHED6ljI8CzDTbE05z20KDDfyNnX9h
 InaaHU6+nXSVGJZKi45C/irqWm/gYN6S4zJPDjcf/FeX6Erw7cwPGR9zG5w==
X-Gm-Gg: AYBFou1sWk/CErX03jVNPFTCttio7nMgu7fw+ZIb2QEv7QbI6cAlmspz0Xma0rB+q8v
 F/EsLxjg5ZbeCWH+S5+aYXXkXqCpyubEAqXdeBy7oeQeVdurVwUFOsq2feJO4v7eyZzRGU5D8wE
 8EodKX2brbcweClHKdRYkswaqFXvgrvpgCi2QGFVWaEeflUWCvrOGcfxO4FaJXm86W3cG3EL/YG
 P4I3i6RR/6L7CZx74zoFkmVWt41l3cgz9UsASW9ewHTgEXdijOHr83TMTx3gC8q6BeyJCoF4vjD
 LNH4mJqK45x7aS6uDw0Qg7CmjjFYGUQ75kUjgM0oijz3GFUm8gq6VK0WCBxH60wR4J4dU9+q6Yt
 +P+2i0w4DnhyN7ZMtv+I/lO+YlPuaVTPPyw==
X-Received: by 2002:a05:620a:40d1:b0:93b:d7a0:d9e1 with SMTP id
 af79cd13be357-940ef980fbemr1269478485a.59.1793071846257; 
 Mon, 26 Oct 2026 20:30:46 -0700 (PDT)
X-Received: by 2002:a05:620a:40d1:b0:93b:d7a0:d9e1 with SMTP id
 af79cd13be357-940ef980fbemr1269476385a.59.1793071845831; 
 Mon, 26 Oct 2026 20:30:45 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa0bcsm294330145e9.4.2026.10.26.20.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 20:30:44 -0700 (PDT)
Message-ID: <16f83269-7894-43b4-9fda-779271e80c4f@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 04:30:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/pflash: invalidate TBs on flash update
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>,
 Elliot Berman <elliotjb+anduril@elliotjb.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261016-pflash-update-invalidate-tbs-v1-1-3cf1ecaa76bc@elliotjb.com>
 <f54905bf-8641-4554-ac44-6d526266876c@oss.qualcomm.com>
 <87wlr4jhud.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <87wlr4jhud.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S96dwMYHj8jI-k_40vxXc0LGffuGMxxJ
X-Proofpoint-GUID: S96dwMYHj8jI-k_40vxXc0LGffuGMxxJ
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6ae01ae7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=-LS97c69AAAA:8
 a=AZLFTsxzCJd3vtj9kKEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22 a=m2i-bEnOsJtWz63_nIdQ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX57oafssnaYqJ
 oy5maP8MgOMcOftpqBa5RaRcIaP56+uXX2c2a6ynb41kpgcDUHj71I+v5BAuXlvAxrFhx6giTvI
 wJCez0V0+RJUg8ttL/cD82FE7via2z40GFV6blzrSfqHZ/HmCmpluEIFCy/N/K4C+ZHUjkatwI1
 bC/3xVXRJjJxpATQInThwfhIBD32EbUJTmaimwBuo2NQqHAwJz+BRERXGw2upAAI+e2FBqs/E5+
 ITGzJxYF0+FBU9oi3RS4D4nR5tyxrYtUBoYR69KiaKrqQ/q21sBIssAijpSiW4vaDhxT1inUP7d
 kcbVVH0jnjaqs5Cae8J07hdLJqIMYbGM7hWUgg1Ga01nck9O5QDQigUq8z7OP9Tu1qJ/lEoaygr
 G91lFAnwnn6m7DMHlL/lVi7P2ObVN9OKE+urRuHxZv8MMI7D+ePpUvrSHXpv9UNx/+YLgKTlanB
 PHtRflgajxruVJYdgQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX8oVnwID4DzZH
 PlXKulXp4CgkbsdsJqe3BB7/uBtz0UIlK7ht64WK//T8m9wzCXsd+UwpHNC/f7kgdyBQ8tHtrx2
 oaz9UmjwtxCZ+O+QtarBLQZcWTK7fGo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270013
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/10/26 22:02, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
> 
>> Hi Elliot,
>>
>> On 16/10/26 21:15, Elliot Berman wrote:
>>> When pflash_cfi01/02 are out of Read Array mode and being reprogrammed
>>> or erased (such as a firmware update) by a guest under TCG, TBs from
>>> when the guest was executing instructions from the pflash are never
>>> invalidated. After re-enabling Read Array, the guest continues to
>>> execute instructions from the stale TBs.
>>>
>>> Call memory_region_flush_rom_device() from pflash_update() so the TBs
>>> over the updated range are invalidated.
>>>
>>> memory_region_flush_rom_device() asserted that the memory region was in
>>> romd_mode (i.e. Read Array mode), but the pflash is not in romd_mode
>>> when processing MemoryRegionOps->write() commands. Since the RAM can
>>> change even when !romd_mode, relax the assertion so it only checks
>>> rom_device.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4490
>>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Elliot Berman <elliotjb+anduril@elliotjb.com>
>>> ---
>>>    hw/block/pflash_cfi01.c | 5 ++++-
>>>    hw/block/pflash_cfi02.c | 3 +++
>>>    system/physmem.c        | 2 +-
>>>    3 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>>> index 486fc6350d..66ecdb0969 100644
>>> --- a/hw/block/pflash_cfi01.c
>>> +++ b/hw/block/pflash_cfi01.c
>>> @@ -388,12 +388,15 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
>>>        return ret;
>>>    }
>>>    
>>> -/* update flash content on disk */
>>> +/* update flash content on disk and invalidate the guest view of RAM */
>>
>>    /*
>>     * Flush modified flash content: mark the range dirty, invalidate the
>>     * TBs translated from it, and write it back to the block backend.
>>     */
>>
>>>    static void pflash_update(PFlashCFI01 *pfl, int offset,
>>>                              int size)
>>>    {
>>>        int offset_end;
>>>        int ret;
>>> +
>>> +    memory_region_flush_rom_device(&pfl->mem, offset, size);
>>> +
>>>        if (pfl->blk) {
>>>            offset_end = offset + size;
>>>            /* widen to sector boundaries */
>>
>> I'd like feedback from migration maintainers: could we be writing
>> staled content during live migration? Or maybe we are already safe.
>> invalidate_and_set_dirty() gets DIRTY_MEMORY_MIGRATION set via the
>> memory_region_get_dirty_log_mask call. Hmm so this change also fixes
>> migration then. If confirmed, worth mentioning in the patch description:
>>
>>
>>     Direct writes to the flash RAM were not marked dirty for migration,
>>     so pages reprogrammed during pre-copy were not re-sent, and
>>     postload_update_cb() wrote the stale content to the block backend.
>>     The memory_region_flush_rom_device() call now also fixes this.
>>
> 
> Yes, this does seem to be the case. I couldn't find any path where the
> writes from pflash_write() are invalidated.

Thank you Fabiano for checking and confirming :)


