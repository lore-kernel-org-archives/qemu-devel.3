Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743F8C982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9FCm-00035r-P8; Wed, 23 Sep 2026 01:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9FCi-00035Z-JD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:07:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9FCg-0003AY-RR
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:07:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N3iPuo1399290
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rKD5HvIUFtSc4xStgSQobUtnoW4jHSlatP7jqVvmRo0=; b=ohBAobLiB1MzHJhk
 zNKdE811Xm4OtsuNLWeL26KOFBt49G9BLRsvsM+Nf9cjfbkJOXPqDLt+Mp8HgUoz
 xRnNA3DbC+usOI9aFfZDmfjqDZb8NoDsB+7SXDhEl04qRp560z8L8Tvun5g9v31+
 sebyyVT0wVfHbv42XVpWmOXYFF5EENhNFZYm/UH8yXa1oM3dEVaF57kIEkKUDm/N
 JpzgdpCW2nrrmE7IHsbg81Vf86tuOGlwO8tkTEY9B3xUKAh3zivKl7NpEKN5g4LV
 B9tX0yuRheCO1dJsD4/EU41hx3iPOhUkfB52IKa9UJd9A3fQtv5vhX6/hhYj7Tro
 csNgTQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guuec3mv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:07:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a3f673221so148130285a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 22:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790140051; x=1790744851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rKD5HvIUFtSc4xStgSQobUtnoW4jHSlatP7jqVvmRo0=;
 b=UIF+QCrI1G50qCkqGCb77gIBAiLQ6I3bHHGW1dyWqCGBaOYCI0YblSnvrn91dqpCRK
 UsQAW2J2DhJuSUaIBgfZJYMtU158PdfT/IIhb2dlISdWJ/e4G7+zm44W2Bf0hvWfTCKt
 MNOKNfU7oK4yzxvRsxOIee19/btySTqIxmI89rEI7Jx9uJ7DpF1djIaVoAnF8E40Cf8b
 KK/oKRtlkg+XAKtqt+HqRHpnlCPQ46El//xL9S92MEfUnMEIFwj9FczVRV0O4SnHWEi1
 pp/loSqrTgYlmPyd/Kh2eRKBknQY0OHAgkrorJSL09JE0Ve+UQ9sNExnYyHmAk7pSqc1
 CnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790140051; x=1790744851;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rKD5HvIUFtSc4xStgSQobUtnoW4jHSlatP7jqVvmRo0=;
 b=Rdow4L7aP/Dq29pxTesL7cqnO/CbWcNRbR35KFHd0MFlvvG962fG0l9OGhu2N7PPRT
 KAHGtsm3MjS/BMg3RjyRaQ6U1eELWomqNWvg4fGCMqFr4FRIQTJqczH/ctoRlJptntHS
 QkE8w/gux4knuA5DuDHOUBo2TdDyOtm1vvj+/xUP1mdawqMiwBpCe9oSwjNvsUQo3/NS
 P04DGaGh3yNRMw4QsLUK8c8bLBFsyfDQ1IGFN9/Vs3Cm8xDxXTnLiaOesDJ8+MnHS9J5
 /9YWKhj+KgyZ89UOADnfV6T1/WCcWf5vq1sAGAwJXTOHjUj1USO6KN+OInyUkZifT+32
 9phQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzY9+nVKJQfOy+jqocaTTl8E8kFATqVRIJVjuaHr2pxTvkFLIk1hKxIwRTewj8AMkLLqXMhXNuoM+w@nongnu.org
X-Gm-Message-State: AFuF++kw2B9jWHg3VKkFMz1MY6MN9DbvSbomayMVJaxLVx99PoyJ1n+y
 Cogo0oNunQCFunUE8tQiXrt9CHwizz7644Y27E0yov4jE9SW2B3Hx63CP+PEUFBLy+qFob9MfeN
 PiqfCtwHlA/EJmJJlrTy6Q0yEujUFOSKEjzqj2xyS7LcwAYCd0qmD/BYv4Q==
X-Gm-Gg: AYBFou0G+Y/CmR4hCGx91NgoPxxZrbn9GbM5/O5ejepvATS/3MlwIseuoaTEOwjKTzB
 RivgadkWoR5BtB4gXTP8+z2KyE9Yu8TYdQ6eIb/K91sHcV4W4fYLr3xQdT20TAXYOzWH5mwPQMb
 eddqWBNw2lzdTK2N8Ev4GIAzhKESmYazEo92ftu1AScgawsHaiCfktQhCnkiEEhvwoFf846N0Ft
 mh+fZUJ3FuizUJxdQy4k+NYO+STp0J5kXfyVT3atZWSpN/ps9kQrGUDLYsM8ZuVU1GzE+HNrvZa
 txSUulg28bwOCY7lOAZOHdDiPlpr+5Niygb1lGURkxBJOdpTmsk4FBVXjuL1shAT0sUnh+DUoIv
 93cduOcwIs2XCMQQSmL5cCfuRk83c8X5nHQ==
X-Received: by 2002:a05:620a:6483:b0:939:869:a8bb with SMTP id
 af79cd13be357-93c250ad09fmr243427185a.14.1790140050871; 
 Tue, 22 Sep 2026 22:07:30 -0700 (PDT)
X-Received: by 2002:a05:620a:6483:b0:939:869:a8bb with SMTP id
 af79cd13be357-93c250ad09fmr243425585a.14.1790140050420; 
 Tue, 22 Sep 2026 22:07:30 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682668e7sm4732367f8f.4.2026.09.22.22.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 22:07:29 -0700 (PDT)
Message-ID: <cc2099f2-5e21-49fa-b0b3-c0322d0737fd@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 07:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/kvm: coalesced mmio: check lenght of the MMIO write
 entry
Content-Language: en-US
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
References: <20260923004631.100997-1-mlevitsk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923004631.100997-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyMCBTYWx0ZWRfX8imlPfwDQGGC
 5NRCYmFTEx0RDjOCNZQnxlI8cF5h10qOaUX6uwaqwwg/jrWkVM4PCx6IIB259V+Zdk3ixyluF7J
 H6h+h8Kzc66vkivzbawnYt5kkXrANwR72P83jwHGNnfi98gOlAmBg6OtoMKdqJL8FAhN2yajbRm
 d/PcoI0qYL6bAirBms6DPrw4pbqvGEAIEzjObAE+bzxVyN+k8sQFjxbhOvrnqcqqzTidDT3TWbr
 IB+ObLipCDTaYJqaEp0Fc+bFDN3Jh0mHDVXj1dp8K9bsXlFeajqwcOaX1dZq6qc2qFIxavFPWGc
 tRJqkb3zVH1/QZ+fM+4slJbNq9kUJoOB7pozPa8hIKumIYlEH+TentBW54T9O2RaQk/lhZN5Xca
 6oN8+uC+ze57K5q0E8Rvom7mjTZCwDYnJuK1GMGI1ren2DRxLNcmsWuOH4M/NhiYCs9TOgokpxM
 Z7P5eOD3ZHzzaanf3Mg==
X-Authority-Analysis: v=2.4 cv=VKdIDNPX c=1 sm=1 tr=0 ts=6ab35e94 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=yFwnl5JLScBMSisZHK4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: fB5eg6tzakESIdmJ3tPw9VSXv-38ngvR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyMCBTYWx0ZWRfX2EDler7Z21uD
 LHzvid0FAlrVUFDLcKLO4IW638TIUWJt0RH5iG4nrw23iyt63sxZZCk00ZD/vFB6KGg9ACsKsUs
 y7+QcXlKCamE/tqLQxpvLuAzZj2+EKM=
X-Proofpoint-ORIG-GUID: fB5eg6tzakESIdmJ3tPw9VSXv-38ngvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230020
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Maxim,

On 23/9/26 02:46, Maxim Levitsky wrote:
> KVM's coalesced mmio ring buffer has entries that contain deffered MMIO
> writes.
> 
> Each such entry contains the length, an 8 byte value and a guest address.
> 
> While the length value comes from the kernel, it is still possible for
> an attacker to corrupt the length field using another exploit.
> 
> The attacker can then invoke kvm_flush_coalesced_mmio_buffer, which blindly
> trusts the length and can be used to inflict further damage.
> 
> Add a sanity check on the length field to prevent this.
> 
> This patch was only compile tested.
> 
> Reported by: "Labs, STAR" <info@starlabs.sg>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3863
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 83cbd120a847..82898fd89148 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3174,8 +3174,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
>   
>               ent = &ring->coalesced_mmio[ring->first];

Could we move the check here?

Do we want to keep processing the other entries if the current %len
is broken or break and return?

>               as = ent->pio == 1 ? &address_space_io : &address_space_memory;
> -            address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
> -                                ent->data, ent->len);
> +
> +            if (ent->len > sizeof(ent->data)) {
> +                warn_report("coalesced MMIO entry has invalid len %u",
> +                            ent->len);
> +            } else {
> +                address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
> +                                    ent->data, ent->len);
> +            }
> +
>               smp_wmb();
>               ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
>           }


