Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA86CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSh0q-0000GS-G9; Thu, 28 May 2026 16:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSh0o-0000Fv-RT
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:07:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSh0m-000649-Ka
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:07:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SHUu7h124511
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 20:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DuTM0uFJgZPTfLJe0vxtfW3lUTXLeSHq5gpauHdfXaI=; b=Lq5xa8UU1ndVK6ar
 dnG2WfWrnSx9nmi712fNztgasLvQqHqmotPEj9DS03cZUXyjEbC4Vq3yIExG75mv
 tJ/Xdam++MXlHPr0glDpcTfqtOAfgkwRSRqdKRsZMfeWRdoPC9wyF9j75LOz28oz
 oo5io0/5c2U1rT6TksPIJxrmlWpnTHG6x8NuL37Iiv9Py4BVew6WIJ5CNfiOO5O2
 XgPElKH75J8yHTqa/vl/iktLmB6pQeMVnlPry/kqPHsL3Pgm6iNRJqgRXm+yTzCv
 uiamLHtbJiu2IzPyk2vH1HMtrD/x52I56d40WjPoBocfJDG3/eXwIGDkyFKB/a48
 NHHEuw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ycch6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 20:07:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304bbf2423cso2591078eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779998842; x=1780603642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DuTM0uFJgZPTfLJe0vxtfW3lUTXLeSHq5gpauHdfXaI=;
 b=ixcSDXOWqK207Y6T3zy2eG3ZvPZ5hTpxXX4zLEm7eECQYjcqiEsmbVgE8VAEaNctww
 XhBVSBxC19KPGGj28edWBzD4AE6EjveuNpYr4wxeU7VSh54rbQjMM/1DURfR960OgOQE
 paJPavczFJkOoIV+LtJdMRPYBngQTwiE4zphGpBx/XaOKTdleGdv8YJT8YVDOCm1tog7
 Sp0mmLsOxu3M70LcHxCsKCJv5YNSrQjvpbtc1tVetKzGC3G4h5bXK5N6s2Jlw3o4eBx0
 lBjIifcNSqFdYnaBKSFUROXZxoyZiZVbFczLQtv+sMPsNQxo5vQfKbvlHvb6ay8EF0EJ
 GPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998842; x=1780603642;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DuTM0uFJgZPTfLJe0vxtfW3lUTXLeSHq5gpauHdfXaI=;
 b=VEg8IXJw/9i6WxiqwWI7aIP0Vv0oluPvLDVH/lf7AB+KBxX+KPpG+Ah1hPgwz01B4q
 lGoGiY3bnYVVSLaChVhg92SOuy9luU9yHChS19tiz8U7IaeqMb2RIxC38NllIEMPp8T4
 aF1KLaJP2/3+cZ/x3DcU92WWm0jw2mlV1pubgKkgpy7wvKuxehQc4UENk9NXPLaE8pvD
 GVB7r6OWE7iF+BcYrSJmGIMnbQm5ePgYro8y+c6s302rmuTfH5AUeCopqfjSYlczsMFY
 mHtq1aRYcUazSDPeKWif5pGEtiKyn6UzQw7i4AtZtb3X3E2FIql82BZ9NdmKAwjeD+Zi
 jCjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YbgwCeANBfJHRhHPg4JQsuS6qC+0ak4liVu1wFwhAYLGIKZ9anHBAadFxRzpJ/Nv+WtgjHX1YTyG1@nongnu.org
X-Gm-Message-State: AOJu0YygbBvXfI7lt3CLGaEDcOdpBAiG8nsCC6vMVWZmZBgVwQTNjZjg
 1rr3qX+JiUn7j8vYESdOUiyoNH5wymASnmqGZOSLE+/kyTEhZpyB6PYaMv+rRvvn3pzl6QlybU8
 HcmkDJFUZSBIuK7GD5Tlmct2ZwGTG9zhS4nCksylgOoSaX6MtFCZhGM98aA==
X-Gm-Gg: Acq92OG9V/vqw/2KpdYRjKIyU9OjgLWDIvc3xgmhH/ks/AQqceSDBsJ/fpm67LaFjzc
 hH820dtkIRvlxMaK4jX8oASZpUbZtgTha6kf2JM/MK5nXFHHu0K+q8A25MHdU0gOT2Xu7ze2SKH
 c/rdoa7ucdZ4ghK8ZZyH1ZP+V29DTFdIB+I3Yc+NygpkUszr33l4UxL2k7ue+PLqVlyUDYbhHIM
 yD403RKTOyuLz4cvtaMmtTbIn5FKjttHJa24AaqMncZJ36ShU4JY4sZLiWEowz6BPbBkULx2mCb
 LuwkSw0i4fKyMXdz6yPLZOsJgsJF2JwCGh/kF45Rf5wMfUgyjil5dK0uI+LrPZnUHql1Nw1+78p
 lpYvCunTp9v5YMU7QHt5qXEV/hNqLAVPHjp31KZC0bZHNRtyr7Qj+K3qZejCboB70FfXHuHlzQ7
 qC6CpKHsT7zn1JZyvGG3px7ZDr
X-Received: by 2002:a05:7300:e208:b0:2e2:4979:eb5 with SMTP id
 5a478bee46e88-304e914b926mr218448eec.10.1779998842024; 
 Thu, 28 May 2026 13:07:22 -0700 (PDT)
X-Received: by 2002:a05:7300:e208:b0:2e2:4979:eb5 with SMTP id
 5a478bee46e88-304e914b926mr218428eec.10.1779998841465; 
 Thu, 28 May 2026 13:07:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e994f9c8sm193195eec.25.2026.05.28.13.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 13:07:21 -0700 (PDT)
Message-ID: <d5ea0f32-c04f-45bc-9c63-3c838b49387b@oss.qualcomm.com>
Date: Thu, 28 May 2026 13:07:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/12] hw/riscv/boot: Replace cpu_to_le32() ->
 const_le32()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-9-philmd@linaro.org>
 <9d0853dd-5c22-4c46-9c42-a76d18230271@oss.qualcomm.com>
 <e636c43a-a613-4819-a272-61fef832627c@linaro.org>
 <595550a6-7efa-4e6b-b025-ae1253a029ed@oss.qualcomm.com>
 <d363d6fd-4c6b-42f6-b7d3-fe43e5e7d64a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d363d6fd-4c6b-42f6-b7d3-fe43e5e7d64a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a18a07b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=SHbdnVf6lyO9pmoBoTMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _07XzQM2YAGvanUry8ipgr2W3clBVF63
X-Proofpoint-ORIG-GUID: _07XzQM2YAGvanUry8ipgr2W3clBVF63
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIwMyBTYWx0ZWRfX4wAbpHXyS6TK
 Xugp0019VxztPxuobKVr7EhteiiA4Sg4AFkNtDQyIRRdzjCgHx2pyKzz2Qckco/vDL3l93l+3un
 U82+EYaU5FGaMOxv2hR4tkOEhMaOHJwvdF3t2ootfWoaEqSlvRbZgLhm8rdZ6KlOtf3OEnmcP3N
 sWP6lO7olbY9eUMapgyIWFKW/gqrK0Lss4pb1X6a0mQoaI6lWwM8h/y4xP2Uw1lD8D58mQhVwM6
 dhcQp+ZLdaRbw/sxa0HsG/QHVam8aQO2aUbk/L1BqhrqChERqobV6tUX0ed/ESJba2GTPxbISay
 NCEEaCelfh4EmMu6zpn1KiJfGJ80luH5AmryFQ3gTpDeKZ1qm8P6Yqla9NCS8BpoN7I2/aaChcZ
 vl/kUXCfdvNPUf1wOxd+5fY4YTey3ZV6zc9z/wCxmVCmmHYay1Uw9I6ZWKfpcz487XtlANg1rbH
 wlvWEybk/07W71ogOxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280203
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/28/2026 1:05 PM, Philippe Mathieu-Daudé wrote:
> On 28/5/26 22:01, Pierrick Bouvier wrote:
>> On 5/28/2026 12:56 PM, Philippe Mathieu-Daudé wrote:
>>> On 28/5/26 21:40, Pierrick Bouvier wrote:
>>>> On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
>>>>> Rather than adapting the array endianness when it it
>>>>> filled, directly initialize the CODE words with the
>>>>> correct endianness.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>    hw/riscv/boot.c | 30 +++++++++++++-----------------
>>>>>    1 file changed, 13 insertions(+), 17 deletions(-)
>>>>>
>>>>
>>>> One could argue original version is more readable.
>>>> Any specific reason for rewriting things this way (performance,
>>>> personal
>>>> preference, other)?
>>>> Not a blocker, just want to understand the original motivation.
>>>
>>> Looking at the following changes, I think it makes more sense to
>>> have the CODE section const little-endian, while the DATA section
>>> is swapped. Otherwise we'd need 2 distinct loops.
>>>
>>
>> In this case, having two distinct arrays, and two distinct loops might
>> be more clear IMHO.
>> The function is called only once, we can afford this.
> 
> This was my first approach until I realized this array is
> registered with rom_add_blob_fixed_as().
> 
> We could register 2 distincts arrays, mrom.reset.code and
> mrom.reset.rodata. Now than the patch is written & reviewed,
> it sure it is worth it.

Not blocking for sure, things can be enhanced and refactored later.

