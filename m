Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4661606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fOleWaUk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XzqrsgpY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMKqz-0002JT-90; Thu, 29 Oct 2026 03:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMKqx-0002Iw-M5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:47:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMKqw-000303-0O
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:47:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5H1NN3341241
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4cD+S3E/dqJnyEtk+qjq3yFdxdSmF50dX7Jre7LoQpk=; b=fOleWaUkj2NFiaH3
 IGY4tFBsPdN7o+Kf28eHaCHbqg4O0WiSSS6jJnH9f3kGc6JXoo3S329WPv8o3qz4
 IwWMpuv5dtoRqyUtc9opLtH+1+pGef1unZf5SoA0qV5Kme3afSNyqRrBi2Jt5l+o
 5zvfAVjdhNgT/1ZsnVxGNLdYO0lEcu8mLLlF6FIYzFbu3w1NHVjFxwCpkHTr95V9
 P/vsJhxja5a8M/h++CetftCMTT+1cLCqodi1EHWPx6+wGeE0UfGkGAvd3oOjUXJj
 r/6cO8HRQDLmNS6ckVY5aJoBdMsQPSR+fO2xwS+7j5Elm2bw4UjBQj+vdKNXllm+
 chQPxg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3ha27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:47:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2eb00825063so3395535ad.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793260031; x=1793864831; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4cD+S3E/dqJnyEtk+qjq3yFdxdSmF50dX7Jre7LoQpk=;
 b=XzqrsgpYwXBbe885LeYh28MIIqiZzz0Cpj78w8FCHMncrnQoj8N/R805C5gmwXllyc
 eU3XOw6l8L/b2Uh+sEqFH0zIWKZkRE3FGESXgrD7kRXeUSNrTTVpkwU3b+TVdNjuEFL0
 aSWNr56e34wfN2PkjobZpruHXrtBT36KEtpijlzbPxT+4HacS8wS1jd+JU8n8euez3Zs
 pzyC/JbMwKvJI7/ve5w1GYXT18uKE1Hb9WdZ7o2eC9X/vM/9T/w2v4SY58tNgg6eZAwE
 FHEXQI0qAfovCvIyul02a27KPbrEbtOJjBuPoScQi6CfGZrfF5KyY/gwFb6CjYI9/LwY
 +B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793260031; x=1793864831;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4cD+S3E/dqJnyEtk+qjq3yFdxdSmF50dX7Jre7LoQpk=;
 b=RPpmGiBu0m9MdoOPjpJdBfQo41JIFiw+cIqtZBIG3zlOrGo0fTULt/peVI1K4WjmyY
 ZfpXV847errPyDZW6YQrCXWbrbuf6GK6URR6d8fRxfsoueZAVjly6jUlKdYTho2OfRCX
 pxOlbpHbUKwyGkD+dwWk6ZXZ/ASz0qGDz/U1i+EKFjgGK8XsimNwwwYYdZZXfAz2pub5
 G7bqWQ4AVcvE5xdl937Qq/x3ZZnhBRBVCSNieSalnB3zK0THNfxQDMfOGuUgZa2/2+tC
 sp8hpsEb0/zYHGHpuaDszgcS3FCzq+wn7JB5soNEab0jgdtMen6pEcMKeFDIh/APuFDD
 w1/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF2xU8hgOU0yIBg0vON8m+xvDkvfXvCvVlwtb5LmmpuHfWM9utStmI5qqo73vOKAM+yag2d4XDhWYT@nongnu.org
X-Gm-Message-State: AFq9FYIuFxqkKWMX5tWCKs4O5HlD/fygyAkYdp0oRxqeSqnxGMiCOkZD
 FnztSADLTrgaGReENO2UJKovTGWB9YVUejSbRzJKKWNkQwVBGUPcACSaDb+e1g8nObSuNMbelSr
 340+93tQk6BgmvTBKFFJtKhUGvv207HYCDLF08UbbbighVX2EIAGuTzLqZQ==
X-Gm-Gg: AYBFou0oMx7GK80txqZb3/sLZWjzu0sM+LCSGAxtvowEn9Jxt2jte1zMysUsaMl7HUL
 Npocq4zgiRPnAMgLG0M48fzmsdzelcFQ1J1uyYJPCgIN5ycamrh/wRr8YH8O54P/kKbd7mvryoz
 OmAT49jqV+Qw0q115TOMHlSr43xKmQWc/zkZwqV8djw/VEXab7df3FwP+VkeFCWkcmG0vF2aMQr
 QTKsgCp/5pZYrMP4bmnRIeRQItOfRBsBQtrsmZwO2fZTsGSrSec9sylORRk1ErV7fxJOxl7f2KH
 gqB3w7GNtrZd5K2fYK366b+JLKfB41HdebAgJtCf4EdtvWWd56tnm3b28Rv1oYystLuhtSIWzmQ
 6IjWwMm4yEHcLXdY6Pvooy1+rM6zIiODqMbxgh7dz1vFiKhfkWwJ7JwzDqtE4bFugPkHbSnAg0o
 Tw9bZL7z07+wXJq40zUa4rU0vRfSSjpg==
X-Received: by 2002:a17:903:11d1:b0:2e6:f3ed:a551 with SMTP id
 d9443c01a7336-2eb1aab257bmr12067145ad.8.1793260030470; 
 Thu, 29 Oct 2026 00:47:10 -0700 (PDT)
X-Received: by 2002:a17:903:11d1:b0:2e6:f3ed:a551 with SMTP id
 d9443c01a7336-2eb1aab257bmr12067065ad.8.1793260030004; 
 Thu, 29 Oct 2026 00:47:10 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c9757bsm29939575ad.58.2026.10.29.00.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 00:47:09 -0700 (PDT)
Message-ID: <83462522-58d8-49ec-8e98-c164cbcab54a@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 00:47:08 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/tcg: Massage MIPS tests for easier maintenance
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20261028192124.30941-1-philmd@oss.qualcomm.com>
 <057696cb-8206-4d9c-8dae-41c39df6fdfb@oss.qualcomm.com>
 <32777ab5-3c29-49f4-9650-765fc6648aaf@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <32777ab5-3c29-49f4-9650-765fc6648aaf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyOSBTYWx0ZWRfXwXMZD+BRCUi4
 Tcky8E08OROyTe092eveeG3R0fi7BV+yyeK+ZdLunNCftOBdb2e6uZXYi8CoYACVZyHeY531eVM
 bwEiGo1v1MbS/K1BPw/6aXK99S1YKlU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyOSBTYWx0ZWRfX/EeoO0TbH488
 AR8sNrQwJqc81IOdTjHetFaGIBV51QfWoYv6Y/3dk7iYVayOQCK5HEeCthWp8q5Atc9gDAEBMlx
 OrJMYBjdiX/0diVoxzbB3MxlFZDEG1lQ3riaLoPKmGUy/Zlctgsjv40e5Ig8BkWR2zpp4CFG+og
 t4fy0OfH/RfMHmHiwAgPGrgjdGkD1CdDhD8OYbpUtQ4mmW9zZhytLfOzPhBZwKYthWIj9NxqkoN
 n1AxY6m+Y9Jsl0kbf2lhaOZeNH7J2f4yli0cZbuBdEV0CatJz/tGdzbSWTyq0x5wXPxJ/9Vmjac
 udG+zMITVn0h/B3bhe3L9A3PbtSpxAtOvHuhRBQ2JgiyALAplk9VaUgFs89K/KzZAL8ho2KqoMF
 Hb8FRlHzhg4RPkbtBiRPj9HdoYwSN5e/EJMPaAm97xVJ60H5FXDpPg8NyZz/NxOaHAEtoMERXbS
 +z58CLSBreKxNiPif1A==
X-Proofpoint-ORIG-GUID: 8mAIsHa8M1LS7Ig1p1exVVKMkpmPyEpn
X-Proofpoint-GUID: 8mAIsHa8M1LS7Ig1p1exVVKMkpmPyEpn
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae2f9ff cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=yd3A85ZR8LPf62z538YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/29/26 12:04 AM, Philippe Mathieu-Daudé wrote:
> On 28/10/26 21:07, Pierrick Bouvier wrote:
>> On 10/28/2026 11:21 AM, Philippe Mathieu-Daudé wrote:
>>> I'm glad we have many MIPS tests but they are in too
>>> many files, taking time to get compiled. In particular
>>> on Aarch64 host via x86_64 docker image... Group the
>>> test in order to reduce CI build time.
>>>
>>> Philippe Mathieu-Daudé (4):
>>>     tests/tcg/mips: Clear DSPControl at start of DSP tests
>>>     tests/tcg/mips: Group DSP tests
>>>     tests/tcg/mips: Group Release 6 tests
>>>     tests/tcg/mips: Group MSA tests
>>>
>>
>> That's a good idea in itself, but this would need additional work to
>> have a clear report per test. We can't trade usability for faster
>> compilation.
>>
>> Right now, a test will stop on the first assert() met, without going
>> further.
>>
>> Ideally, we can keep the list of tests in a static table, and perform
>> the DSPControl clear before each, so patch 1 can be removed. Also,
>> assert could be replaced with a proper return and print information per
>> test.
> 
> IIUC the requested changes are only for the DSP tests, as the other
> groups (Rel6 and MSA) do not stop on the first assert() hit.
>

Yes. Other patches still need to add some reporting on which test failed 
(a print with OK/FAIL is enough) instead of just a global return code.
> I'll rework patch 2 (indeed 1 is then unnecessary) and respin, thanks.


