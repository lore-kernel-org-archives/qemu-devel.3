Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF2607905E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KAoWIXfx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iBHwX6Xa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuKk-000411-BB; Mon, 02 Nov 2026 10:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xNuKg-00040K-Te
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:52:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xNuKe-0007Gp-N8
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:52:26 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpLQe845675
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 15:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SXst/Gu+1ySFqXZ2J3WXPjGy9vGqtunxav6TxQeiyw4=; b=KAoWIXfxXYqEz1Gt
 78iCpC2CVCVYpOGDNoChFgao9IOMbzmn30Ty9frJTGvfjLQAYAMAjtBltJVWTZy0
 adDWW9DXvYiP63OZg7DWdWQucvAxGrd/m6I+wTdYFXoROOV0fCGcyichFIRVguez
 fNzek0bfM0k6mL8fL8EgyWb0//775eMjVdxvA2N/MBnfgIdMDFBP7nKAMZFFB6Zl
 sHf5UAYTXF3zPjM0uDWDHc1M9KdwaRe/fKjCkYsSFB05pV6Gwjcs1PLRHi18E3I3
 qFGl6HG9GhpFpbQUuhVvIpkAkesRmUkTA6B8jC5uzzifNzPxZAAUcaMeSBw+bnAn
 +CnWZQ==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1tfts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 15:52:20 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67694007c9cso5989441d50.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 07:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793634739; x=1794239539; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SXst/Gu+1ySFqXZ2J3WXPjGy9vGqtunxav6TxQeiyw4=;
 b=iBHwX6XagI1IdI5Z+QUbCS7ooD1AukcltfSEUgZSU/zlp7W9ZWnvGXBpNifUEOoaXH
 uITlBBOqa6Yo32T2nAHU+Ilp5QGkLTEw5k9uKs3xpHlWiWy6/96ljRly7sBBf/YUDrnQ
 k0gMODKA7ENgxoLnPOoOtyE3VPshbBvPtlDXWlzP+vrzW+w2/IOetN4X3j8kzr/9ADq4
 /vFmZO4IuHBahA7/psyj7dDS27xVTgZyyiEGVBBpoMjr4GM6xN78l3kE01peHaahW24D
 o6fMuhHBvIU3oWRroNf6PTYLxebXLjD85VGGjoDL3TMQmCyG6Az3luPX10nvdN17fkxi
 RQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793634739; x=1794239539;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SXst/Gu+1ySFqXZ2J3WXPjGy9vGqtunxav6TxQeiyw4=;
 b=kTyxgm66+lSVQeFHYkK1XyJeitbG7z5SRjVf7cpVK2W2Wz1ebeLAvgzXT7L93XbvpW
 1P+DI16h5Bx5QylwHiMwadMLgexwASQNqVVvLrSWWPRxlOsbSM4g4+u9tnQ9yj+oQbyX
 OrRhlW3f4kHzZyiGFOdOHf0vqgpdpL3A8br26xlf4tCo2bXDmW1/jUsEKw8NMsBTbgDW
 EbWk2VWt52oTXmYMg3Kvlw8Xu2X/6Pv3wFltt+WtOjQjQy1Im6+s4kmss4p487KoUM+L
 bRLRcZvJWLoq5/sskl0AJHvwWr0eUffYyJXBAc7MbwaBved4bqawEHINi5xPpM87mCAO
 /dUg==
X-Gm-Message-State: APuU4Z/UzPvK7JTsJ9SPzAbumqbEw02pdBdgRTrUNRp4WvfMsVo5VZhT
 V2zcJCkg4SNN+6Iu8FcK72rEdBdK1R5w2EZQWYt9gRrrjISVq60kFdlZ+096JLEkjlX+kLxYBgf
 cN8L6KoDhNweh2SmyFBk56k7O1QLpGX85YUgUJ7G2qHr7+Bya9rUXnL8O+sGDL1zT+w==
X-Gm-Gg: AYBFou1r0kDTe7cqjJesusRxQ+n/nyVsXZq6Zhzj6joDTEtl2GjslOlbjaACae58oVJ
 ceSiCpqFoyu3DqyAer12UmK0n0Y+MpjzuHLzmANB48fXhWpzT8ZYEH+DpO50fJ05lG1jS3R0s1k
 sLc9xhSYfVmJrbn6ttcSFQAN8ySIBvamr6vy7/lzohaiYsYI6OTSd5GM2vUhI6BqcHpsY8Q/CMq
 W1IJVMDzZ+FMVJIRTn8y8NyeMPaG6KhlCsfm39kztR1TQssThEp/UssiTsIVcT7aXqu4siNlLi7
 il76JQWAprPDECAaowJnV4RHqC+9rChL6XyhwSFPUL4OHv1lCKGrwkmU1H1VsO5I86Y3euQSGd4
 S21Y20j6sZ4LAU5d50zx+5fM8lcxp4EE8TvX9aM2b+Trnldf0FuCTr4uJ7CLLbnLK7sQAEx3bOA
 8/qQ==
X-Received: by 2002:a53:9011:0:b0:677:ac93:d97a with SMTP id
 956f58d0204a3-67ba5081327mr6318508d50.107.1793634739421; 
 Mon, 02 Nov 2026 07:52:19 -0800 (PST)
X-Received: by 2002:a53:9011:0:b0:677:ac93:d97a with SMTP id
 956f58d0204a3-67ba5081327mr6318494d50.107.1793634738947; 
 Mon, 02 Nov 2026 07:52:18 -0800 (PST)
Received: from [100.68.183.250] ([12.234.128.130])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67baf27263csm5323957d50.4.2026.11.02.07.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 07:52:17 -0800 (PST)
Message-ID: <751b1263-850d-448b-a2b6-27f2876d4e50@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 09:52:16 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Qemu qurt and fastrpc?
To: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org
References: <aue3t9EKkoeb0FnG@gallifrey>
 <C972F7F0-CAAD-4BC3-98E6-0A1A4CD70ECA@unpredictable.fr>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <C972F7F0-CAAD-4BC3-98E6-0A1A4CD70ECA@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rDrruOJJx_aQSX-NmLLVkAGjE1nEeUL5
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8b1b4 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=NEGcsKYL+Ze+mpfIX/eCfg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qC_FGOx9AAAA:8 a=3WJfbomfAAAA:8
 a=KGtsNZTloYa-i4F4NlgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22 a=fsdK_YakeE02zTmptMdW:22 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfXxxvIR1td6oD4
 usfZ3seaUyk2ocjPRHsNjK0b/hwlLP9/DdG2ukWgpaSJOzKHLleFlsN9puOvU0IsuZxnhksOC8r
 oLr9/H/493Umfl2hXYd+7UXV1GB7f1P9Iwr/RikCbn+sN844XZ0oqyu5gjY2yRtkYGmPcpeE48b
 26epFkgk1RuTeYEZmBY6I6JvSXgT0702ONVnPeAunvvS8f+v9fZjNRVyu/aAf8c9xIdJt716G5q
 C/mMbeytcNYkwiz8Lj1KbPO/FCllj6PWoYCzC39OEtassTyxRX7t1W0FYlbOswv+tcioPiAGiy2
 dcJ+z0gkON9xw7kJ0Nbazp/9F6n0i+unF5QctAcL5oUX7Kfvi4XxibLdMABHQN/W/csDxlrsr7L
 vcmE9zARFo2S4dgyHBtTG14C3KFzt2jcSBx67tlhxtKwlQC8rfr0HXuEz0dnMq09QXW4a0my/tq
 PQ9lb7H+w5KbZx2WwSQ==
X-Proofpoint-GUID: rDrruOJJx_aQSX-NmLLVkAGjE1nEeUL5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX/oy7xDNpq0eA
 HoeMVDQoWQXJjNBRl3zWMh/KxoboSfM+zASQ9qrZwA+l/Vl8XThKigcS6z06EJquZpJO+lQ2U6v
 sBmnNjgD/OtuD8rRve/8EpaRt3+J87o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/1/2026 5:41 PM, Mohamed Mediouni wrote:
>
>> On 1. Nov 2026, at 23:05, Dr. David Alan Gilbert <dave@treblig.org> wrote:
>>
>> Hi Brian,
>>   I tried your hexagon support booting qurt images, very nice!
>> I did:
>>
>>   ./qemu-system-hexagon -M virt  -kernel ./qccdsp8380.mbn -nographic
>>
>> and got something believable.
>>
>>   Do you have glue that lets you run comms to the emulated qurt via
>> fastrpc in the same way that, say a Llama running on a normal
>> Linux host would?
>>   It feels useful for debugging/watching what maths kernels are
>> doing.
> Hi,
>
> There’s no FastRPC… however:

Until we have heterogeneous TCG + ARM apps CPUs + SMMU + SMEM/cmd-db + 
DSP machine it's not likely to support FastRPC as-is.  This seems like 
it's quite a ways away, unfortunately. But we could conceivably craft 
something that resembles glink/fastrpc using ivshmem + doorbells.  That 
seems very do-able.

> You can download the Hexagon SDK from https://softwarecenter.qualcomm.com/catalog/item/Hexagon_SDK
>
> That comes with a version of QuRT that is semi-hosted as runelf.pbn.
>
> A working QuRT loading on top of that (w/ a semi-hosted -M option):
>
> -kernel /opt/Hexagon_SDK/6.7.0.0/rtos/qurt/computev75/sdksim_bin/runelf.pbn \
> -append '/opt/Hexagon_SDK/6.7.0.0/libs/run_main_on_hexagon/ship/hexagon_toolv19_v75/run_main_on_hexagon_sim -- libmain.so'

Indeed - sorry, should have some docs on how to do this coming Real Soon 
Now.  But that's the gist of it.


> The QEMU on Hexagon inside of the Hexagon also (used to) comes with an oddball QEMU Hexagon
> version inside the package that has HMX emulation as a closed-source module, but that’s a
> separate story that is going to be wound down thankfully.
>
> If you don’t want to use the Hexagon SDK, there’s another option through hexagon-hypervisor which
> has a very partial QuRT compat story. Or outright Linux on Hexagon which works too…
>
> The (modern) kernel tree for Linux on Hexagon being at https://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux.git/log/?h=hexagon

Yeah, now that we have a decent basis in QEMU, I'll work on upstreaming 
those kernel changes.  Some have been reviewed on-list already.


> A pre-built artefact exists at https://artifacts.codelinaro.org/ui/native/codelinaro-toolchain-for-hexagon/23.1.2/qcs6490-cdsp/ with the booter at https://artifacts.codelinaro.org/ui/native/codelinaro-toolchain-for-hexagon/23.1.2/hexagon-hypervisor/

The h2 hypervisor is also available as a prebuilt rom in QEMU now, which 
is convenient for booting linux.  That h2 won't forward the 
QEMU-synthesized device tree pointer yet though :( - so it's probably 
easiest to build your kernel with its own internal DTB.


>>   (Not urgent, I'm just trying to get my head around it on my
>> X1 laptop)

If you want an X1 CDSP machine in QEMU - let me know.  We can include 
one in 12.0.  We did include the X2 CDSP - it's SC8480XP.


>>
>>   Thanks in advance,
>>
>> Dave
>> -- 
>> -----Open up your eyes, open up your mind, open up your code -------
>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
>> \        dave @ treblig.org |                               | In Hex /
>> \ _________________________|_____ http://www.treblig.org   |_______/
>>

