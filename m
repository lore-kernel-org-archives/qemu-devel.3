Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4542FC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 09:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsGnl-00032A-Fx; Fri, 07 Aug 2026 05:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsGnk-00031Q-5s
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 05:23:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsGni-00053L-JS
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 05:23:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6777VOWC3477121
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 09:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NtP4NnRpENy7kPPY1Vn0EUsspazM3KnylfH/1Ayv7oM=; b=jLIpJ9GnDfRrlJpH
 XV1m7tD66t4e7t+7F36VAU2MrYGDZk9NxsIg1fE56M18iq/lywNIT85pCPNoG6vk
 zIY8w8Dv+gyXf/gRYQuD0J1FXZHZezQDqVM689AW/cwfU5P5oJ0mq/eGgKO/drxf
 3mgE/LjpR8GCAVrlHk3Od+3/FOHx/7hOckuMMdljHSKJM09Lf4PyKtS9iMDKp7s8
 Crc3ab9Ol9JOpnWcnWRIaWqu8/Zzd82hXEnAaSpNFty3XBbDCP3kPkiQrimeRVUR
 0XrvgfIbiFDD3bwqHhEbH4VTSLZ0qUk64lof0oh7vvMSphw+m1Gwu7QH8+Tbhjcd
 BfKpSA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hb8d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 09:23:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso50196931cf.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786094617; x=1786699417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NtP4NnRpENy7kPPY1Vn0EUsspazM3KnylfH/1Ayv7oM=;
 b=jR4c385hMZ7iABuqeT6res9z8XbHzAAzMV23elso2II24Obc1KSUfbmzsZ+xVoWUsv
 7HOh5XEjuozE6kYv/IQpLrI9z5yHgetrXAduBIa27hSCJaz5Thtk0X27m+rnTcI0xqWr
 9i8b6WMlypoo3V4jsH1jK8itaB6dagA6+G9nxLEWMdoEWAN+HGhKOlSOq1QiEYGg4F8n
 o3R15L6uLknBN8TCCYAgO7KSI5bnwhRg6mZUxIb5BdOl7kXfYbaHPGLss2MJmHbrYxDz
 um0i9lDfhWCkLW78ZlY6DGTaJy8OtKKXfl1jtpMgzIpeHIj8VDJ5Ecov936Fsdgibmfx
 /lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786094617; x=1786699417;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NtP4NnRpENy7kPPY1Vn0EUsspazM3KnylfH/1Ayv7oM=;
 b=bmMopkqaH3FHIfJHriH5W1MebgqWLaFHwy7hkO6ECOryYuzyugqvDCODWoEYfJm+M/
 bSCJPdyzn4nt5t0jDJNKxIXV+CfnTG3I2j5xjHSVPpdNd6u165tOvNOttlracVdpXSc0
 tjJ40gDOV3YlFh2V74P2gDDD4KTkhPCpxgLyeAdCNTiGGBiTNfLlMzv22cyDB/n2ZrXt
 BOQDyrvjqwG7//q0mXF/9TEznrfdESlchQNyTf2tU2i+KwGOQcenysHzk+9wm65ylmwu
 AM8dSpuK2WZZ/91JLMnMgZk2m+qCI/ercyDv9Se2NU8Muc+SkF5B0sx6MSgipTQ+ZloD
 fUzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIpeGdL22dVNZjKnOF7cspesjzVGhxdsg66aVvXiFJY0sT6twkQ+5TEkrm1GNGvbKJnVbToDCOay9T@nongnu.org
X-Gm-Message-State: AOJu0YzR6qmT30ZF2LMJdNw/HwMu3t6Huhn4U1Ee1+OvEdEaJjkp+96f
 RAJCOuQRKIJnjwrVWoNfFtAz+62OYGJ3d7fPZKB1HJlFLrqnHPF6wJpi7q/ibcLvpBiAKADsRNK
 hfa7qFOIwy18FuZL7vmgg0J1YA9dH451fcLqrRIs+GNzGScT49wgxRX3PhQ==
X-Gm-Gg: AR+sD11O34+Ppk85HDixhx3fiQvNrpgswNhZO1YefamIbCuzPJkigzWozIET1vcRPuZ
 1bI4/vv1W95JdA9gog+/dgL+QdmVph7oT8vQ637v8FfB75oHH9CY7Q2QQ8GzX2y1v1WoHY8uhuR
 vNCQ6Gnvh+CREaG9qU/sf1rrekUy3HB8b0gUH5/2gdSJ9BFtmvGI8BBqLdl2gcrw/PbrcELGGcH
 eoy/Wo9Xx//atMOcO41VA76Nc3yfYXzQRcjnk5DDfVW+L+DQgQYjFbRlauf/uxwyVIDw2tk7Okp
 mCYyVQDgo6xCiZ87Bg4xy105FGZCqPsyT+D1BgckYLGx4ZMoJ6Sc4h3VNcWg1PEkIn9JUya/I8U
 O4jNELEJANDbdMRzqJ6am8NZy2zjwxNDPeONk
X-Received: by 2002:ac8:5d53:0:b0:526:d595:c7fa with SMTP id
 d75a77b69052e-52d0b21b43amr80037661cf.31.1786094616949; 
 Fri, 07 Aug 2026 02:23:36 -0700 (PDT)
X-Received: by 2002:ac8:5d53:0:b0:526:d595:c7fa with SMTP id
 d75a77b69052e-52d0b21b43amr80037511cf.31.1786094616592; 
 Fri, 07 Aug 2026 02:23:36 -0700 (PDT)
Received: from [192.168.68.103] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a92fe515sm4756816d6.24.2026.08.07.02.23.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 02:23:36 -0700 (PDT)
Message-ID: <be5d04a5-1ff7-4654-aa48-e53d55bab914@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 06:23:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: Allow UXL to be 3 in mstatus on rv128
To: frederic.petrot@univ-grenoble-alpes.fr, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260729083941.103646-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260729083941.103646-2-frederic.petrot@univ-grenoble-alpes.fr>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729083941.103646-2-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GnwroaoB0PeKwwbqS-1rLZgRJHtUvCrG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3MCBTYWx0ZWRfX/0euy/pK2giT
 nNP7FL8OgflXHmnG+YHew9M67Jd/RFZgs8ClSBIh4DAT/J1ukbg9AqilQ4+zp+ZltyhyEQTSozQ
 4nvUi4usudQSRugJNluCuruiIN3udWsuxvqXEtMpPFyJvyS636KJgwcKiDHpkiRqZivgLuovl42
 ac/SjO1WsEMrpl190HeHY3SwzdWhzHpyghiBHgkpiDwMpTx+ARYLRBAJX+GJt/Q6zZD6jpihOxN
 m0hbEuS5pvi/oY+ZWPiPLzZx237UWjJlKkDznn5kysXKG3IlX1Schqmday3jxSrGhffYesbUmt/
 5WpqHpv/1g7SR7Ng2YrNuLWt+Rt6Cm+8XRhwy5F6LzjyNZUMsWYg/4i1CWOBfhCtzt2RBGNBgH5
 UU6Be8Ffe0cMfj0XQ/fE+YMdCm7IOfqdkrPb+QLyozhA2VfNxAsNaA1ldFnVCUnrYokJuf5IH1L
 M3byz/teU1wGMYc99GQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3MCBTYWx0ZWRfX1mJAE5Dbsbd5
 nEAkKZh4diwH2xZkWcOMfNEQIs6uKxnCUO+EAgZJpGpCJP/FzY8NRXtTYTz1BS6VTeN/vKAyLxw
 Oeueu4dF/s/QQMhw1T4uDr3OcZeEH04=
X-Proofpoint-ORIG-GUID: GnwroaoB0PeKwwbqS-1rLZgRJHtUvCrG
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a75a419 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=swibrC5bZXBqt7sKYMAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070070
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/29/2026 5:39 AM, frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> Valid UXL field values for mstatus were restricted to fix a
> reported issue, but this inadvertently broke the experimental
> rv128 support where a value of 3 validly represents 128-bit
> execution.
> 
> Update the mstatus write logic to permit UXL=3 when running on
> an rv128 CPU.
> 
> Fixes: dcd028517749 ("target/riscv: Apply UXL WARL handling to vsstatus")
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/csr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index d834b77714..5eeb9f0e0f 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2014,8 +2014,8 @@ static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
>       RISCVMXL xl = riscv_cpu_mxl(env);
>       uint64_t uxl = get_field(val, field);
>   
> -    if (uxl == MXL_RV128) {
> -        uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
> +    if (xl != MXL_RV128 && uxl == MXL_RV128) {
> +        uxl = xl;
>           val = set_field(val, field, uxl);
>       }
>   


