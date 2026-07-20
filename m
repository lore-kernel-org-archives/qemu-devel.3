Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D5C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljeN-0001Mh-IH; Mon, 20 Jul 2026 04:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljeL-0001Lv-Ks
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:46:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljeJ-0003wg-C1
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:46:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K7YNed2044270
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bsACjlPiVtM/l6lfDK/YHMrN8KeP32hWAAwjXnFruxY=; b=mv7QehUA0QafWn7/
 9xb5NYdDgYg2oRjmbjna1ZYfzrFM0uD15r8gM7AZBT5fBaI4k3z9UqTHE1loVfjy
 o+8yE3lY0yNBOSNrhYu5SyOgYbHTeWrcybJlk85Thk+NvCu5+bz+z0CeSQPNFC8i
 hh2hby/82TDzU85ZWhIdmNb0YJ0wHDaCbW2D9e9S5uAOblhG3aOHcVQ5R70Wvt5G
 ooz4HVeRnlxp6djS2gHB8MGLrcAlUrjO+jFzP92L3LEWglWTpowM72iI48qdFMq8
 aESCoFsqiIyozYfk/1/HmQDR1YyBPdJbUhpVUIWJMD1huzKx/ALSgCSuRX15cN+8
 HU1rmw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdcg8t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:46:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c083f1818so124408601cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537212; x=1785142012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bsACjlPiVtM/l6lfDK/YHMrN8KeP32hWAAwjXnFruxY=;
 b=aTbVGwmqzhWUbEMmZrtUda2y03hgJU8Jqo+fa+4LWG9URdajhi9lV6IbivhQ6Zg6+K
 hWaIKkqmy80Jc5eFtLtWuHmFkPpBPgsU5BGQa7RDhvdvWsUZPVbAgGYtVqpQCkZr+E3z
 c7U40FwZQazZkXGIiSCynKkgh0+iEii07IBmgIkYqdxNcu0hPmgklYwen9bvVj8XCB6b
 h8yb3L34jlp7TAfSe3F9hD5R2DGaToFerCkS+FjPDYiXJPaA/zVZh0mfoltz70NcUhbw
 0EZSHpiwCvPimOTa2q/O9/hpk7nS+j2JOnuW2l3akXz5aQ1cyOaxWm4gH2t0iSARW9RL
 7STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537212; x=1785142012;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bsACjlPiVtM/l6lfDK/YHMrN8KeP32hWAAwjXnFruxY=;
 b=RVH8XC/jD0Yqjd5558SNGBgBUJanGJ+s2M+RplmdERXz+2ffdgrV0SpsJMsN9D1RGz
 iPOfXnBXQKMBL6oPec6pxUC8J93S7Q4+mVWbwi9FAV1Ct63ikgZ3RDdv7PAmswOAW9nt
 T2V7OxjzDAgf58N4auOcQFfVxVj3tVhXeU0W0o8JbDEcE/yWWsIa2i4+b7sgnzbj+sI5
 3VpygFug7Hdc60oOBorvQKMqFa+bdnjWao+/U5xkZheV5NyahvzBQzkfgpknhuSJ62TQ
 47wY15919+BvpClp7yNHabQIIgfEqm6qlynP/WsImyLuj9S79/dKQFASdxIko3BZV7RZ
 F5pg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rplaqg7Icnc5pi6ZeT1MN2YDSVgXOtGzCE2T6Py+IX5CpuA+R5AOxXjDHFk7EXfcUMJY5nDErUAPjp0@nongnu.org
X-Gm-Message-State: AOJu0YyXE5ojztkMiIF1BJTQ5LKnbZt0zZtYbpom2N7pdqEYoNxrYUHV
 2r8n0QAMaASG+lYsK74/YHNUOACh5qY+OM7HobDNdknQ+KVXLhZHDAlR0bdSFRQVp5vqCuNKimR
 C+n1ORj/HXPkdZ+3zfEb+gy838q7NAelHfjWDXwzLZmunV1Lg1OhHfLSBDg==
X-Gm-Gg: AfdE7ck4mIUhkMZNmShmnSGcPuvHzPAiuwnW56Pca5F2iLQHOIcBLyAjVmiAXgTLxWR
 cTM69S83tTW1GXucB4c54dwYKOWfIpDSb92yY3Gb12Qzeh0DdJJljO3pSOijYy2mcIGuM8lMYI9
 74Ki+9MEWyPDp2FU7L97mR2wXe/qfiQGxHlPlfDiSoMrUKuhRnDONbNC6x7cbVTRn6KacbDEINS
 wDzsptsTg7kBjzv9GqT4nDliV5kIg9heGDjOFzXSDV2UMLoKnhxlao4sOxlwLaFnlHrngq/19se
 5BE+ZmJVQWKABDDWAQirVnV1Hffo7maMsv8gz8volo/gKdLo8UNBCI7zpQYbbyU51TmCe5IWqTp
 Wa5UBSKsqRYrZZWUet16ORvRohfxICbnaN6Zu1Oqk0N2KpxgPgeY=
X-Received: by 2002:a05:622a:1453:b0:51c:2022:cef5 with SMTP id
 d75a77b69052e-5213b147021mr126224451cf.26.1784537212081; 
 Mon, 20 Jul 2026 01:46:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1453:b0:51c:2022:cef5 with SMTP id
 d75a77b69052e-5213b147021mr126224301cf.26.1784537211707; 
 Mon, 20 Jul 2026 01:46:51 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52aa4sm28734194f8f.10.2026.07.20.01.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:46:50 -0700 (PDT)
Message-ID: <0633cf6a-ac8b-4dd1-818e-e6147fdbdda9@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] target/arm: Return struct from
 allocation_tag_mem_internal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260717232306.378988-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0IH87_HT4ISX-guVzghESsWbCGeK_RLm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NyBTYWx0ZWRfX1FGikcC/qiK9
 101y4mTqw1byULtfJg/kBrR4DAifLc1m1mpzhS8FOBR4nk3wSR62A6YTQEFBBdPGqqq60g2Vm6N
 Ymj3cOlYWGYJhTijaYG1aCUSoxSJiopiuJ1cI4OhI+KYp4cWgwapzasxPwiLXkj7IhORVlJKNOW
 oahPeTxwY5MhoJr9NJLhDwzS3gvJrJ2w+gT5qelglmcYhruIPB+DFkMKRwRVu3y4O59Hmp/EjlL
 SnsLZhI824+XHrI7rdSGdxUTdJEX//CY08dz0EAtvZdVTpvgGf7QBT4JD5S7dmhPR4bHe6P0qx5
 cBVQseLzaUjlO1WzLWLhWJsq5abKftbG3XNK5DC4IQFqh8XY98yMtAiAmnUu31WbM46HusRY6n2
 JuGn21vb1oeZjfK3g2xwe7OtQdEuZ3UfNuAdJuRvlhLnA/FzULKA21kckQ7mPrIVEzEn7lG9Fvy
 cC2miYOrR78hiHDRopA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NyBTYWx0ZWRfX9NWz5Ym/DMoM
 t2s4fUsNEcfAoNJpSj+0JB+vD6UZf5UYQskFd9HUJx3phryxNxUzwJFd/zruI2OQ5O4oIpEajZR
 nwgxS5OB+VKTwOdUUZZXKod8YAdpVJk=
X-Proofpoint-GUID: 0IH87_HT4ISX-guVzghESsWbCGeK_RLm
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5de07d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/7/26 01:22, Richard Henderson wrote:
> Return not just the tag memory, but the data memory, flags,
> and attributes.  Make sure probe of NoTagAccess looks like
> any other page permission failure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 102 +++++++++++++++++++++---------------
>   1 file changed, 60 insertions(+), 42 deletions(-)


> -static uint8_t *
> +typedef struct AllocationTagMem {
> +    uint8_t *tag_mem;
> +    void *ptr_mem;
> +    int flags;
> +    MemTxAttrs attrs;
> +} AllocationTagMem;
> +
> +static AllocationTagMem
>   allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
> -                            uint64_t ptr, MMUAccessType ptr_access,
> +                            vaddr ptr, MMUAccessType ptr_access,
>                               int ptr_size, MMUAccessType tag_access,
>                               bool probe, uintptr_t ra)
>   {
> -#ifdef CONFIG_USER_ONLY
> -    const size_t page_data_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
> -    uint64_t clean_ptr = useronly_clean_ptr(ptr);
> -    int flags = page_get_flags(clean_ptr);
> -    uint8_t *tags;
> -    uintptr_t index;
> +    AllocationTagMem ret = { };

I'd feel safer starting with:

      AllocationTagMem ret = {
          .flags = TLB_INVALID_MASK,
          .attrs = MEMTXATTRS_UNSPECIFIED,
      };

anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


