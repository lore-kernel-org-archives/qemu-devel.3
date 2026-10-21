Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8C606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yxg25ws8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hGbHuZag
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaFD-0006ZM-0x; Wed, 21 Oct 2026 13:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaF6-0006Yp-Cm
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 13:36:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaF4-0004tt-Pv
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 13:36:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LG3Pxw900401
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 17:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jwp/CuICmRDMcr1Of5cTvxcxON31RSfltCpTmEKcDfY=; b=Yxg25ws8uEjTWHUa
 vXqt2hZrD3RTSSCZhi7Xdb4tRT5u9bR5ixqkTTGstbT03ctecr3i3O48WNpDHyQV
 3HiOD7YL5e8VdWUeciIiT8JcYmfeI4A3ZlgFpBooySgclKBd5jFpDAchhgFvXk9R
 YdY/llPPlc2wOeHgRAoOO/cptQqbWj2PAyDPCxgozUWLa36PxRnQvLdECjAPQgun
 kH+n7y/vZbDUCY/4evBayCnSDdX4D8SPIUiTX63pVpbhLev0WtUagKdaO0tNk0ol
 XRXJV/GH5dh7fy2Ngu3U54stdIhlBoyDAozoH/ip5Q1hqBD8qy+x3oOJW4krcrv2
 YDcRgw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2gdvt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 17:36:45 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-18eb2616974so1664951c88.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792604204; x=1793209004; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jwp/CuICmRDMcr1Of5cTvxcxON31RSfltCpTmEKcDfY=;
 b=hGbHuZagMfBFZbFaLxxJHsm3WITGp0Y/rVDK+NDeStMhz0AIjY+aWvyvFan2jITg20
 g8mS8BxNwe3IfdXz9kIpEuFtRQQ9Dps5vXCDAagJY5ilpa/C78CiMnhOjqvO+4JIzOuG
 5kJFg058gxMMLGac6U68wgdB8CxXck45/WYdE+YhVyZIK3x6bmtSyyo8dZALhi5gkSJ4
 A+1lGxvZuJA7Gko7V+5rRlEFcpjUM21O1f/5SjPD8CXUIh8/v+U5pGeo7T3Nt/ooApn2
 5iBA3vUN07Hg78yd9zlSogEmu454UD44LzwCtFHD53tnfmHPD+7U3KynXRkwFeMNDX6a
 ZkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604204; x=1793209004;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jwp/CuICmRDMcr1Of5cTvxcxON31RSfltCpTmEKcDfY=;
 b=0zxFpau8Z2c3N3IrQd3IQUAhKP8/pO/B+wTDEoNIhoRTqICyM9cmLg6mzu0eODdFh6
 cdMSdIXumlUKD8Lq7GbbivIsbfgx5J3Gh+wZrmTa0XeqC0jh7x2DnDyb1b9tsVnkWWp4
 7iJr3WJKpAwv8DtvJpaf1dlfcEgcu/K04FEAXEF5RuJmEX84ii8mNaCZp4wy2t4Uw4cR
 ngg4DFf1gMVmH/LJAVn4AnyJQgtqIHwI5PyIjRifEoh++3VyArsFMJrE/4neTAFzvhFz
 k2vMerpbBoDm0pjoByzF/ttAGYuyIliCk+YTuLrVMhK67UhqVogOC75h7bZx0WfmdkMU
 ScnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8hXwXhdKJAfS1Fks76YodqbWHISeD5onKcePutIKL6tE+ufhP0SM79WR7KMnv9WDxQlgIG/Aye6cD@nongnu.org
X-Gm-Message-State: AFq9FYKJD7vH5qrY9+SJwlSJzhirovTiY6uBZppNM0TMxLGQYMEpLgyh
 uLG/J3ApwJEjJ7qdDC+9qLaK6pjTL3QspNUFKyJc6i1Fgv3wpC8vzVXV+oac+NbufHL4uRu05ni
 HU1tsJwiQL7a+OnzXQ4SQ/HLqtiXXtGaL1fGPe/nkRuWQWYgez9ltKSzPEg==
X-Gm-Gg: AYBFou0zeELumdeGQrdTBnM4eAXtc3ZZ71IoNPTKOJDI41M0sqyiOmzWK+NJbMKS3tK
 ZivF8tSwwxNw7oZatgsAfispi2lreKmAdcv7DJ0Z8gofWbxQpQ/lfT5tGo4Jnarkolsdb6L8XHA
 T4v4hSo/IPqCdcryjRjMwYQ6631yhSEaL8qtN03hJeo/RCAU0tcDItYoYqc/j4YbUuOleju+3lH
 s8WPW71FbRLmrFZwcq3gtWqiDoKKOhk1OwfJ/Z5AvhNskG1uug9zEBCSX4l+vlH3whsVR26YVyo
 oLZkkQ3UX35AFTMDBlcw9Kf+Tj9rx+RyGwkkdC6mHaYqimlTvkOkHVLpUZyWSr0bi2TrdTsOHJL
 1xFuYaWRGhVHukbOpFEIDRp0lED5V2Z4HqFeFl+vAcp1WxiHaohH5ZZbz0p42Z58AeeRw0w==
X-Received: by 2002:a05:7022:b054:20b0:16b:fdbf:4a9d with SMTP id
 a92af1059eb24-190a5d6f355mr3306169c88.27.1792604204060; 
 Wed, 21 Oct 2026 10:36:44 -0700 (PDT)
X-Received: by 2002:a05:7022:b054:20b0:16b:fdbf:4a9d with SMTP id
 a92af1059eb24-190a5d6f355mr3306116c88.27.1792604203436; 
 Wed, 21 Oct 2026 10:36:43 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19035926fe9sm6257686c88.2.2026.10.21.10.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 10:36:42 -0700 (PDT)
Message-ID: <6e31d5f0-c2e0-4829-bf2d-85078d11b726@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:36:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/21] hw/core/sysemu-cpu-ops: add get_dump_info
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-6-pierrick.bouvier@oss.qualcomm.com>
 <18a22eb3-9e56-441e-9d1b-e1ecc9eb98a0@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <18a22eb3-9e56-441e-9d1b-e1ecc9eb98a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX17GA4ckJTowu
 zdFI2xQBr993OAnO+hvdGxbtd/R33jotwINFoFRwIkytgNl3Ia3oNAU3n/203fUDNl1wakWXEDo
 sCS4axiyzarg96mzxjGdOrNqcanyVU0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfXw6pq/j7it71C
 5Dz/G6t6k8lrfpefoi67Czrdp8Epfd6lDAMuO2dX7dPeGDfWLdtTOzWtytJW4MJ61O8P8yg2g/D
 KPu7hOc6nMP+IxOb4LJ1NzjK/do8SazmIzn3hu02GhbSH4yAbqD+ptSjF//L+9VVc02ZLlG2Kwx
 P/QNYc8TEJsqyrcgzGWftU+KAyNk+xTU3oIKqZ92Lvl5LhWk8cw+xx/LkOlEOEdNE5Yz0oDzdJW
 HrVCC7shca44O+ErSBgaP8roZXrHvuAsmphKnZoVsBJmcODnBLoDJXwnSN7ORhYEiSJJwsn0hTV
 hDIULarfSf4C0ql/pxtN396oz2D4sW8HCIiXnd/7g6nc3wpvdDdCgkCXCSQGbO0ACYg6bmDvCXk
 a6aODxxA64mwlrk8p7eZZmHE+2eHVPOnsMGsOZ7r5Xd1Qfx7W4idrlCe6maQnUAmymKd9Mk+CR8
 u+2uk82UphSDDTZr2pQ==
X-Proofpoint-ORIG-GUID: QywKKku-nWqn5gFGXrhSdNKympF7596F
X-Proofpoint-GUID: QywKKku-nWqn5gFGXrhSdNKympF7596F
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad8f82d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=6gx5Ui9-PGFx4esVa5gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210070
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 6:43 PM, Philippe Mathieu-Daudé wrote:
> On 19/10/26 23:26, Pierrick Bouvier wrote:
>> This allows a specific cpu to declare its implementation of
>> get_dump_info, needed by dump.
>>
>> Reviewed-by: Anton Johansson <anjo@rev.ng>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/hw/core/sysemu-cpu-ops.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/
>> sysemu-cpu-ops.h
>> index d125540262d..2c7d0b94767 100644
>> --- a/include/hw/core/sysemu-cpu-ops.h
>> +++ b/include/hw/core/sysemu-cpu-ops.h
>> @@ -94,6 +94,12 @@ typedef struct SysemuCPUOps {
>>        */
>>       int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
>>                                   DumpState *s);
>> +    /**
>> +     * @get_dump_info: fills @info with the endianness, class and
>> architecture.
>> +     * Returns 0 on success, or -1 if the guest memory can't be dumped.
> 
> QEMU style is to return int when errno is propagated, otherwise
> a boolean is preferred (bonus if error propagated in Error *errp).
>

Taking a look at it from this perspective, we never return any failure
from any implementation. -1 was just here to say "not implemented".
So I'll switch to no return (void) for get_dump_info, and size_t for
get_note_size.

Note: the global wrappers will keep on returning -1, only sysemu ops
will be infallible.

> Getting the prototype right is simpler at its addition than later
> refactors.
>> +     */
>> +    int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
>> +                         const GuestPhysBlockList *guest_phys_blocks);
>>       /**
>>        * @internal_is_big_endian: Callback to return %true if a CPU
>> which supports
>>        * runtime configurable endianness is currently big-endian.
> 


