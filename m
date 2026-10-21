Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D2606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JQ5/coz4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jLUDxkSP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJayd-0005oV-FS; Wed, 21 Oct 2026 14:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJayb-0005nz-LQ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:23:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJaya-0000e7-0V
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:23:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpiMo4040016
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V0rwOne78GCz/YC00rgYJYVTVDvpgUtAJsa8hN2K1Lo=; b=JQ5/coz4UdubbX0H
 0ooTH3rgTHDNSVeWogLPVzspogFSt7U77pmE+HmsF7u5N3fuvTwEWKSTVuIw5Al9
 NzzF5QW1Sfqtaf7Jp6GtlSS7ffv6nJEZ2vmG6UH3TBCXYyXbUyp4L+NjnHgoEwIU
 MgVPlry62dL8hBwhulJdIknbjQQwPV3zJ0l0AI7WKbrsZVmxNpa/G7wBd/3EWvAL
 gyjuwUaJvt5iwOMziP0IOiqJA9GKLoHKSB+xpMc+wYF8yzL/m8IjIGSEhnKVeG6W
 BFCL/WOxYd8Te8nIBoKS66i0+lgZYnsMGCuNaxuXoX7gxmS6TgpkGs8GGoghnbFr
 gWw1VA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy7ajs6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:23:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936aa34873bso192750985a.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792607024; x=1793211824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V0rwOne78GCz/YC00rgYJYVTVDvpgUtAJsa8hN2K1Lo=;
 b=jLUDxkSPlV/SgoRm2x0hbdwzQBlHzSejt6/GG5iRdHwQmttdOtuBulbcvqn5kf2ec9
 dFb7lYtMCfwRPdMAEXK0Vf+zYKsufsz0g2E+CqkBV/RDSkpAfFp2X8yU/KcavBK6J5cK
 ct6swu8Zikdi4yKfK4h6DnPd9CAqvnsm4gzgmFj8TdEOoaWpPa10HEGhqTKcGVhqWNK4
 jB7erVgH1WAgmYfoYY9SwVUBrd6GPRsxnA7h+HsC/93+MDMPP5aH6dDugkR3QEJpg6i4
 9JlW3AVU9WKaVLVKbuxhespaBFKt2zmH60dKxfG2bTpN4ryWXoi86uC4rQZkwyv5eX4i
 nCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792607024; x=1793211824;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0rwOne78GCz/YC00rgYJYVTVDvpgUtAJsa8hN2K1Lo=;
 b=Vc2L8BXIkrJM0TmENxJCnoiLwcnxGW/KWaQgwoavVRY42sqGy7V1YgL1JkaVFtpQRU
 8dSg68fRLNGMTZa5IGSUM/dpALA8t/WB429tpTN0LUL9xAcqu4vwGrNa6uCMv7o6+GNa
 otnL6KZlduTpjeu6w6UhmaP6UQQSZvgZEP0eBNtBsWd/pKOyL8ta4hjaGcsh7Jlkpu60
 ovuL57olAbDmv1LuT/T/wO3qHxyjJOt+6hej27+DA3/GzMvO+xG6t2l0bdwzWmsbniLa
 WP9TifD65hS8p0jdMvFakFbuabS7NfpyOS6ZqPMApEzzSGLSxc3SuCXSsAtCsmW1C3nU
 KC1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxI0rnSqRpHyCjLFrycF+ZwYM+mrmj5ELN4v6OnANilEivDiU3TSzCV617aLC7kFuPb9WHHb7+AYBff@nongnu.org
X-Gm-Message-State: AFq9FYJhyr5ezBDGW2nmhIZ4XozqOPhKSwU2PDvUlhM2i8HQT5RxWs1v
 Kt/Qso5W9HhKmwMfvqAsKKXnFb+OE/249oVGe+I4CJCqdjyPeHrASP0kGBhESOfLV1sqr4A4FHG
 nLtScJXYOv+1VmvIyv4Igk3TMTOOtFmKSgLTUlOxE/x9sXvV6awjtcwXnyg==
X-Gm-Gg: AYBFou3/hv8QT5RPPPlhTNyiPIXJuwnrlGNk3PetrmV9cAWjLIZg0f7H5CkYTMbl2hV
 hMVVfTpc4ohg6eE+RDxYe6dpw2kOn/IyzyVNEr2jdWjRAUbOmGmvW2VQ826hBRyin0Kv3JXygRI
 ou/USTkWvUHcg07S1YJXt+OKOKZns9lDB2VSDkQ7PvV0IRGuFZG2jgk9wBtsjWwquGI3lzcagXb
 KnHHzaKDI1EVg9k0gwpsARMmRol5n/ClWdR695nNjdTkat69iPGd/r9PgWIwx/Mv/iwOX8DkmW/
 9tym7A8piuPDHFJtkb6wpIKjowQKVy4hIhAqc2aOlRe941uCPm+IPcxyaTmjBsJWdJcHS+5FayA
 MM5P/FipjxJt7JzQXWflfWmXO/TfBKwzbg59klMl8iWrPOZoKoh1Nnuuc+kIYfYFkIsDMiJ0j
X-Received: by 2002:a05:620a:2a0b:b0:93e:94f2:ada9 with SMTP id
 af79cd13be357-93f57f79117mr582689785a.58.1792607023855; 
 Wed, 21 Oct 2026 11:23:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0b:b0:93e:94f2:ada9 with SMTP id
 af79cd13be357-93f57f79117mr582686785a.58.1792607023340; 
 Wed, 21 Oct 2026 11:23:43 -0700 (PDT)
Received: from [192.168.68.101] (200-204-190-237.dsl.telesp.net.br.
 [200.204.190.237]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f56e0952asm312395585a.34.2026.10.21.11.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 11:23:42 -0700 (PDT)
Message-ID: <91d62753-5841-456b-9869-32b73a0ecbcc@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 15:23:40 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/riscv: Add SBI STA state to vmstate
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20261017145211.219258-1-wang.yechao255@zte.com.cn>
 <20261017145211.219258-4-wang.yechao255@zte.com.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261017145211.219258-4-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BaGfRHW9lSCpXTIlQKxaYQrxST08r1Zw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MyBTYWx0ZWRfX2sj2tn2dfI4i
 JsV1EQRj7RS00nKGDOp6w9/kGYlOU1sW6Cl5/O8F8WbdCYSWn4zd9Lh6tPd/2r6gHlEfY4Pgofy
 Sj7kf3yvTYUT/tWAPv7obv7GT421vWG3x7ZCOMAqh0hCwroCEYuEpVlj3CxHZTwNSiz7sav4uek
 ba4cd92X8omJrEkv/BYHYHajHWz3PW0PVO/EOXOS0GQdc27f3DewlPzjSXpnQvN3PVMOoIQdTBb
 eYR3PMEQJa0hSHPjRgU7C4JXOYIv8x6aZLwmyYi4VN+WO97CrbRjbRvT6caLEh4X9hY0Lv2iy0l
 9Z7qNulGI0IhZER4gwsXXj0yEGh4u/awyjUsXf78EPMI7jYnErswQ3JSgWmyXOCEMdeILkgnoMI
 4Vu1NjI/WRxBYKzeZYUKLRQfuwwxAoH0NIceHje6cfSj5V9DuI6TjwqUGJd+uI6Dfhe6iRlo3Q0
 Dwar5KBX19VQOJ1a5cw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MyBTYWx0ZWRfX/9fBtNCUq5HU
 BRtmZEemNdYKioI/RBy1HYaRuAsCfJ0EaUL8yuFxUeyrIs5bOd+C0CMdE5zt80IS8HZ0DUu6XhD
 6XNjHbSSH4NUVJOsS70RuQ9pXumP5dk=
X-Proofpoint-ORIG-GUID: BaGfRHW9lSCpXTIlQKxaYQrxST08r1Zw
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad90331 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=1RTuLK3dAAAA:8 a=mdeikwMS5mDVz4aCriMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/17/2026 11:51 AM, Wang Yechao wrote:
> Save and restore the KVM SBI state as a vmstate subsection, so that
> a guest using SBI STA keeps working after live migration. Only the
> STA shmem address (shmem_lo and shmem_hi) is saved for now; other
> SBI state can be appended to kvm_sbi_state as it is added.
> 
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>   target/riscv/machine.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 0de06e9588..b8cdca79cc 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -318,6 +318,23 @@ static const VMStateDescription vmstate_kvm_mp_state = {
>           VMSTATE_END_OF_LIST()
>       }
>   };
> +
> +static bool kvm_sbi_state_needed(void *opaque)
> +{
> +    return kvm_enabled();
> +}

I think kvm_enabled() isn't enough here since there's no guarantee that
the current running kvm driver supports SBI STA.

If we take the existing mp_state as an example, in kvm-cpu.c we have:

bool kvm_riscv_has_mp_state(void)
{
     return cap_has_mp_state;
}

And then, in machine.c:

static bool kvm_mp_state_needed(void *opaque)
{
     return kvm_enabled() && kvm_riscv_has_mp_state();
}


I think we can do the same here.  In patch 1 you're setting kvm_sbi_sta.supported
to true if SBI STA is available.  We can add a:

bool kvm_riscv_has_sbi_sta_state(void)
{
     return kvm_sbi_sta.supported;
}

And then you can use it as another check in kvm_sbi_state_needed() too.


Thanks,
Daniel


> +
> +static const VMStateDescription vmstate_kvm_sbi_state = {
> +    .name = "cpu/kvm-sbi-state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = kvm_sbi_state_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(env.kvm_sbi_sta.shmem_lo, RISCVCPU),
> +        VMSTATE_UINT64(env.kvm_sbi_sta.shmem_hi, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
>   #endif
>   
>   static bool debug_needed(void *opaque)
> @@ -645,6 +662,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_kvm_timer_frequency,
>           &vmstate_kvmtimer,
>           &vmstate_kvm_mp_state,
> +        &vmstate_kvm_sbi_state,
>   #endif
>           &vmstate_envcfg,
>           &vmstate_debug,


