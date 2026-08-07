Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7CAC5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 09:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsGnR-0002zG-3p; Fri, 07 Aug 2026 05:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsGnP-0002yr-Kp
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 05:23:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsGnN-00051T-Jx
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 05:23:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6778FvPf3477036
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 09:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qD/1TcnQ4KzM/ZUd4tMzr2gYm3twFCXOprs1E0ZjG8k=; b=OrLX3iALAnhMMuri
 CqZGr/qMy8xAkS/FISm7stHW9SSTMVYdNAcWa4FjZnYJb8+mWOpwL1MmaDByKYOI
 EZmS4U7TsiRJlVv8SMpCGIfEJ4ccCxoUHbo0ZYBZQtinyqWkkt0RONsnyMNn8kF5
 Kv8lir/EZJ+ui+GxPP6fOFEr/o7TWN9+wzCx23SMdUEkyz6qp9g+6t4WCHT30rmU
 7KsWaeH/QA0VQZB1x8Ei6SVQnCEd5cSKA7AwvCFXSjt73ZHMipACpGZMNfgdNgo9
 3FK/Rw0iZTL0fJykjgAVFEKZ196XDqHV0JF+g3r9VuL9DS6yGjmH3Ah6Cb+WeLYB
 8xq6pQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hb8bh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 09:23:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ec3146553so528994685a.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786094595; x=1786699395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qD/1TcnQ4KzM/ZUd4tMzr2gYm3twFCXOprs1E0ZjG8k=;
 b=WjYVMejWcV/MytzFD7mVbP4y/rxCbNFDHpHb9KvzMRVEzHLF3y1qGGri7r7wfVow8S
 nvbcY2TzaUXLuufol/m5S1FXGtfI/ZPczqz/A+USgV+7bS5sP4/G3ripj6462ZaD4NQ1
 07Ef2UhBYrbIcYlO/uj9VlctuHY2X5CiLeZkix7zV6nGJPBFEICM6+LYnQ4NJzxks7MG
 o8TlFYA45YHq52MB+N49PBHLP7Tr1UFXal4Ikc6wKaeItaW5M/Wh/nMPyp3N/zMtlcG4
 W/CMG3zk/FHu/CnC1dHqrQDZhXIC4z+1t6EaeZG4Tgxv2ElZoch4s6hSECgbWFCAzgmN
 XD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786094595; x=1786699395;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qD/1TcnQ4KzM/ZUd4tMzr2gYm3twFCXOprs1E0ZjG8k=;
 b=HBFY4lJF8UbZzApGarTZVPYMyaa157vQ/txpJdoIDkPJ2e9PjUoVb1z0VV3p0YK84T
 cMJp3/LT4dqPU0ciO/11NWPwI109OGOrPbMD3HwXhNFtbpWsasUBElV9UYDnejgoFtuI
 H8dYH8G/90C9FnVwuG9r2100m+Zc5cy/+HygJw+JF88E66gVtHHYMiMvTcpTgsybV4mx
 +oFGAuVnyEPec3/2A27W8L2HGNab++MmTEx53i6Hd9kCSXlRly/EmNdiDlSVNozk3m5a
 IVJbNtUPnVTstpBa+b34h95MA14vG4zdIiU6YBCicOTsTZ1QmCry7qt8VYtaFW8z7W4x
 X6kQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2T1ULrrKiqG9WGraEG/9HLKHweW3prDC4kXDS67xDbTmarwLf4HoF3udxCnrP0F/eamo0UQ14iN1l@nongnu.org
X-Gm-Message-State: AOJu0Yx8M721BrqMsrclVbhtqZ1QiOazW9g6BTgnS5DX4FcCyMbdfhb5
 wEwuUA32H0me9Mv5AemQVMPMT/JNSBhtjmi0oe61yUINiQvkfrC2iYE5Gv/ctnDZZ4rZOo2Vr2C
 XD8ZOwwJtHpNrA+YTEgPEaBzB7IhNGFRFZvL3cUL3/XhhqYGLWpRVqzJngw==
X-Gm-Gg: AR+sD12Q6G1D0W6ECM62tAw0SvgLdBvE8Zz9XkvP2KOg5P5Uba9aGNnDTmDN/D3nn3b
 apcbTYOZ+/NZI2FNxuCbujHDL8/b9eUzUujHzs1rOOf1GPaOIYYzPE69SPNZ8dYd5mXtXBkGNLy
 GJKP5rd18JSDfZXgsX1sipO6AV3YEBEI53KEf9OUfrtHJh93TAaldfX4MaKpuWV3uDEmfd04oZM
 w2CKq2AGiND169jsmkEfA4KDJmOnfZmOJ9nGIIGsictLBWl954oiUGwxpweVhs21gAlsa+p0sN9
 DTLAv98bics6UalakBg6Dd1ibSZlQkq5dx/pBDpm5vcPpTXy9izbJqsz7OtPNE+NuZqfKvJfIRc
 E5MRDhzHmw46IeRUq4bhhYwwUc98eScGmauKH
X-Received: by 2002:a05:620a:2255:20b0:92e:5554:a80e with SMTP id
 af79cd13be357-936491f5d43mr1741578985a.39.1786094595322; 
 Fri, 07 Aug 2026 02:23:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2255:20b0:92e:5554:a80e with SMTP id
 af79cd13be357-936491f5d43mr1741576785a.39.1786094594802; 
 Fri, 07 Aug 2026 02:23:14 -0700 (PDT)
Received: from [192.168.68.103] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e226895sm108184085a.23.2026.08.07.02.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 02:23:14 -0700 (PDT)
Message-ID: <dd93f115-dcd8-4fa2-aea0-ba4d7ea40dfd@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 06:23:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Fix sstatus update in rv128
To: frederic.petrot@univ-grenoble-alpes.fr, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260729083941.103646-1-frederic.petrot@univ-grenoble-alpes.fr>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729083941.103646-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: r-boiRjY1D6tsbMYXeEYbCLUN1PtZOb0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3MCBTYWx0ZWRfX8KyBXgj3y4qN
 3jdO5ndR8RUpk39cPgeOzLFB8WYOcYgT06FifvWpHrFOK6wB5YlV1p+MH4rREkEuYZNGICnX2S+
 g0ViIUe6o0Y63WgoNHYUTVIyxt+j66tulzkxS+3T2nw7/MB4zE0jnrLKvPBvBuOANU/A8m4Dl7S
 lcBq4KLZRJYLbEph/jvCOjlngMw68o4HtoQEbQPvT/oLzwJXbNUMQv843C2h6oKfMvRaohSaL3D
 pl2fOEXx4hvlCqa38w0Tu0ruKRBSzVBhyimnm2DerK2yDv1vHJJqL18RchOUYe4bvsioKgsfIdM
 grHZ07GPDNHNNGi63uZfExfsm1mlODV5UEKudlw4CVhNCaK3e/PTjhCw+2X920P0SzfQFSI2Yu9
 /F0yYoYoVGVrPS6athP3MNcBryawm0YC6lx3f/CmxJ/pSjAUBCYo2VKo6vIxZznrie7s7mHKrVS
 mQa7agqTsY+dKVUmbeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3MCBTYWx0ZWRfXzz15Ti+Qo5hR
 SsG9l0+F4jb4rgAeAZjsVcLZZLlL/e99e1mKr7bKyU8WlC/XWhROYU9oHXjMn52AwT3RR+6Qx6x
 F4NrDsZsGaD4QrJapoHihE8njtFMvU4=
X-Proofpoint-ORIG-GUID: r-boiRjY1D6tsbMYXeEYbCLUN1PtZOb0
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a75a403 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_IHU2iZSYYauedWJTUkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
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
> The sstatus register assignment was performed before the write
> mask was fully constructed, leading to an incomplete update of
> sstatus fields on the experimental rv128 target.
> 
> Move the sstatus write after the mask completion so the full
> write mask is applied correctly.
> 
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/csr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc5..d834b77714 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -3984,7 +3984,7 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
>                                           Int128 *val)
>   {
>       uint64_t mask = sstatus_v1_10_mask;
> -    uint64_t sstatus = env->mstatus & mask;
> +    uint64_t sstatus;
>       if (env->xl != MXL_RV32 || env->debugger) {
>           mask |= SSTATUS64_UXL;
>       }
> @@ -3995,7 +3995,7 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
>       if (env_archcpu(env)->cfg.ext_zicfilp) {
>           mask |= SSTATUS_SPELP;
>       }
> -
> +    sstatus = env->mstatus & mask;
>       *val = int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
>       return RISCV_EXCP_NONE;
>   }


