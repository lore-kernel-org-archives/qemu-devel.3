Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE2C98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 09:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAOoP-0004zz-V2; Sat, 26 Sep 2026 05:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAOoN-0004z3-0o
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 05:35:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAOoK-00006m-Rq
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 05:35:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68Q6OjIL3446997
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +0a8ywQTFMp/tnfN3u+xSfg3xISyQdBYzxdRITV/pVU=; b=K/EFsaZb3ia4TC7h
 0CdSFJrJQywIJgZwzaAlar7S6kWwmJhtj0v1QHHfozIZQxO1Xc3xiqLZ09bhYqJ0
 2irG1g8DE/6LijO5sjpFs6At5he3iXbO7vrvrYrD0g/QT2hEnZ/a8BlMyiYtyKJq
 Hhj1Jzw09P4xSvZFUcrkzbrC9KoqzeTGJs+Gx49iUSvmG4BmP/11qglZzhFSiwKW
 jxSxZms/lG89a7Ly5w9xoMQ7xMl89+Zu4YY0Q2+yRy8StDnc0NY6u0KzWk1WQEKR
 wqkitPEEiPjTunPGaNvioYd199ypiFOf1wTvuR1szy9Suf0c9NTM9qbOM0mcv9EW
 3bzwqw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6938jwy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:35:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a0b66ecd9so249945285a.2
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790415310; x=1791020110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+0a8ywQTFMp/tnfN3u+xSfg3xISyQdBYzxdRITV/pVU=;
 b=g7RYzomNcS4ZSIkG5mihyZhAzxXiH2IUWocgarWOIF16ZFLNjF4sDp/3mCMgofZmGP
 l4wKUAloTsEvcgI8RR87wzmgEGo0Rr4oa53qsQb+ZF+jishODFnCUuX/hYDr0zLPOu9g
 2NffOJ/ynqAQkcw0OImvQ/eRdqyk8Ijxq1ljfRXAAUd6bLtUfyEqiOa7WpL566X09WWs
 6kdV4Kmd3dQqw11ZyDn4Sw/y9qiLovZla3sLptfqO2Al9aRSrMb7uH3UUAv9W7s0aChr
 Z18+wqOYglvI2asrtxeSGuo8FH1uRBQP9LHxb+y3Ag1JWy7KiGASc5Uk3a+V7w9EfWjW
 XeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790415310; x=1791020110;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0a8ywQTFMp/tnfN3u+xSfg3xISyQdBYzxdRITV/pVU=;
 b=B7kGsr0CsFpFCT/8ZbxSWDAk6lZlDLy7mMWTq0aE+XmidDpAtiRDw/K1z1HB2GCxR1
 ex1rJrbTUuSuciPa8beQrVzD8Ib/emOsIi1rE9HVxxSPXa5S1bhBfIge4ElvHHiXXTfu
 57EElmgo18WJ8hZPG7314falcJqBRBA058R+4x4df8dol4Yi+m0RkAveBU9WyZSyLotA
 BG15MTUZXxYawbC7XTEm90dxqxttEaGhjzTc+bMvxAmv1u7HaQMdIYPjmWW4Q//uoKTX
 uQ9qAOTiXeVA0vH5h0vtmjF+LUafhDbsN9+5/aW4iuSS6qNQy+qDxtuyeVnFpcSisbRL
 yGrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSogfMoY+T2w7tWfLekohRmOvjYugQ6sreXZvXqZWBVysWnt2sL7FC9cDnMN1MXHunghcR/cbBxKeR@nongnu.org
X-Gm-Message-State: AFuF++kx6qjBPLGf5y/Lx9k0cqr6WqNyOEztnfoPJakWnhlaUywjtlfo
 gwhImDGqQBPzoGnq1zciLHELa1Xz5zqCfdnqeVdhJc+zlyXB2Fu0iR3b5TyKy15ean629F8hZrh
 Qxm7TA3Faf2z/5XnqfArxqsTIyD8LSwkexrwY6HIrXMYDcVHaQJIcmIiO1Q==
X-Gm-Gg: AYBFou3IB3ASDk6Bs2IokeEiOrs3PwO1yzrhcFIjcgbDDaLOBTDwz5dzFxVFvWgEL33
 6xw23Q7aQtevE9t5n7+yIvkC1qPnqRrbFz+OZErmoFpNO1lQAXukIyFo041WfonAQAS83oIKq+3
 DuaP8XqI3OJJXq0wXuUmSXsS79Q2Umo8hQuZvOXv5+37K0reXs6niFrmXep1VhIhUjYssTnpOUg
 YSA2l6s15SFEFVT1qSB8xBwXvkEXDKPzCN/Tp4mLkhry1ejVnWMFz29MqW6cXMCLRE3d1VlYvxs
 fOokxWB3wjDPGrRcmhg71rYZ0NAtwPsM3BPD7QZLko11KbyyQGBUbjJwzwqinPGaxAA8LisRf37
 e2dIZLiVvBwsvjKnDntTkU3VoMx6Zvkg4hQ==
X-Received: by 2002:a05:620a:3912:b0:93a:2d2b:a5ed with SMTP id
 af79cd13be357-93c43dccd3dmr936001285a.47.1790415310101; 
 Sat, 26 Sep 2026 02:35:10 -0700 (PDT)
X-Received: by 2002:a05:620a:3912:b0:93a:2d2b:a5ed with SMTP id
 af79cd13be357-93c43dccd3dmr935994385a.47.1790415309590; 
 Sat, 26 Sep 2026 02:35:09 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef4fc959sm110478295e9.2.2026.09.26.02.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2026 02:35:08 -0700 (PDT)
Message-ID: <5687f0f3-052a-4e16-9747-0be60296e07a@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 11:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 028/114] hw/intc: use kvm_enabled() in APLIC AIA helpers
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Fabiano Rosas <farosas@suse.de>,
 Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
 <20260923131635.1894-29-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923131635.1894-29-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAzOCBTYWx0ZWRfX71G6/wBI+NPC
 eE3ug5vZKvkfkbStmJKSRlDqxyX29Tr+QnIjEBNOCuU96uMh88PamkRCobryCb7ameHBf52Cf/e
 tBKrUkflfS+kCYtomSyxI0AnVnrzSKc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAzOCBTYWx0ZWRfX0EJ+YsMpraVK
 zP/eowgDubfQCMATbMp7GSUv8SP9mpEJ4uiJquYGIQUouQ+iyKgdnIeTjy9NCrYs/3LK2aN2xwe
 CI8qSnha39dbRKJpaKOsO7zQrY7jdf39zGyCXgZ/98qH71lYM95HRf65fby1hjorHTQJPTR5qKm
 EwpgzyLE46rJywacqa5BWq2N1eUQSaiS8ZZKX3t6b0LVrOvoFvnhiGJKus7t1QrdF1sDzkuyJrr
 UhjBpe2UALMZPnSn6Zf8Z6BBzCDSnohKriLF4VbZGufuK1P0hujnHIKYLXgzbc9jCCAeWCbMB8c
 C4UmVJ037C1b7xbUvcVaAWF+cdzHgqtK5wUX8ZqKoEjecK6jVLrSf/g+MDo5fyLtjq0pFh+DosC
 m6Vj+DC3V8ThE+fXR+6+wSBrlj+alC6jDAC7wJFMNKQ5ZjZ9HeM+37RozLy85kXkKyYmJ67f/A8
 o/UfFrayomLqihIyHpA==
X-Proofpoint-GUID: t4JSiFfUTNLstrKOdiKwlh_7kpiS9fuQ
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6ab791cf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gis2z1_H4pcAoy-0X7kA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: t4JSiFfUTNLstrKOdiKwlh_7kpiS9fuQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260038
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

On 23/9/26 15:15, Yonggang Luo wrote:
> - Replace CONFIG_KVM ifdefs in riscv_use_emulated_aplic and
>    riscv_aplic_set_kvm_msicfgaddr with kvm_enabled().

Can you provide your S-o-b tag please?

> ---
>   hw/intc/riscv_aplic.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index d8e25bfda14..03a0852b8b8 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -167,7 +167,10 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode)
>   
>   bool riscv_use_emulated_aplic(bool msimode)
>   {
> -#ifdef CONFIG_KVM
> +    if (!kvm_enabled()) {
> +        return true;
> +    }
> +
>       if (tcg_enabled()) {
>           return true;
>       }
> @@ -177,21 +180,20 @@ bool riscv_use_emulated_aplic(bool msimode)
>       }
>   
>       return kvm_kernel_irqchip_split();
> -#else
> -    return true;
> -#endif
>   }
>   
>   void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
>   {
> -#ifdef CONFIG_KVM
> +    if (!kvm_enabled()) {
> +        return;
> +    }
> +
>       if (riscv_use_emulated_aplic(aplic->msimode)) {
>           addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
>           aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
>           aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
>                                    APLIC_MMSICFGADDRH_VALID_MASK;
>       }
> -#endif
>   }
>   
>   /*


