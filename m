Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECF9C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfBH-0008KN-Rp; Mon, 06 Jul 2026 04:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgfBF-0008K8-CO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:59:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgfBD-0000F8-NQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:59:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6668N2d04072465
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K3ht6EUOPtOUljnYz6XeEjLZNZS2GzokZUyIMxkvDE0=; b=dsipl/AWwMCc0rqS
 WZN19qCktKSkKsIe1Qy9OZD5kcx+H6yQiO/bAJWWQYC9LAxnCmEB3EKIcH5Ej6b+
 y8oCypB75ao7HeS/c/BXfuL22GarQC+o4eQosT+aFCZlL99py3I3a8lkEyhpJjLY
 ljRteYWh29vDC5elBZf+bCAVebdG9UNRiyUOiLJFq+ieOVySt0i2prjpYiI4ApZ/
 vK3kRTqpEDu7ZBmC8jSdFlOclDY1UNI1yyczhstZDi8HQeTvzbRxGcOI61sZI/Pm
 FZo+nKkvA0P1fr1LiPw7mB7DbqRIYCEASaslDt/qZLzX0IKzq2HALDn5jo9ItLih
 mYEajg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t884ss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:59:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ac0a54110so301224085a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783328393; x=1783933193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K3ht6EUOPtOUljnYz6XeEjLZNZS2GzokZUyIMxkvDE0=;
 b=eicM4PF6MHHgvw4xG8JYNQNCL1fX0ZNaw6fFnXirJ4QifXkR2QeYMScS2EgIp68fgo
 zC9ucqKb4bybGrgE+dUB6xOZFuVq4AlY4pN31nUZkXZIp9CTc1v8KqYPqmqtZFaJDM3d
 PgFgtwfBL48xV6FNUwksh7thdmSzxMFwhFQlLva8cOmNWTr7tsZqfTCVRZdG4NU0BE60
 WFb5THgJl38bKV/oFetvzb/KZqMVn39/KkZk9wNrNjA5xIJzwjJDXtI0c5DjPlbStsnI
 piMLvqCj6KJj6Eg7rX8vw/KT3WmHNjh+UlG1lJryv96z+7xQXEew34+EaZeJGuDVxpt/
 ZILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783328393; x=1783933193;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K3ht6EUOPtOUljnYz6XeEjLZNZS2GzokZUyIMxkvDE0=;
 b=MYh61t9DfLhyHvuSo/+bgE2S1TqqsKnkSwPHoDYn3t319Yih4i+07tTSDROgUGW+f8
 gV8Xt/Zlce/v1R84lAc2fmTUDMYBdjvx4+1b8BnBaCx5PUFwQszmwUDVD64D71EAoDaT
 5BXGpXxK0vFAqGJSwL3WxTjThJgo2Xm2Y4msHN6icKMX2rARvMb/YmHbKI1NxFPDBI+q
 httoONay2RbX5aDSY4GPD3srhpcRXsf2px3F69P41wFWmAz/+XDnRpI3v/+hjNCbszoo
 vJ9PPQ8/U+TmFWIGBfc0j4fbMTDvQfizPYHd4NdKrwZwaU4/9yj8aprGTrDqUmRCYKxm
 VUkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrsAGqFPlZHlCmo9HQSYeAPLU1IMxuD0NMtprA8YtRYKFgXhWZa5YhjrIKTMcTTdnwc88qEX3h5Pg4j@nongnu.org
X-Gm-Message-State: AOJu0YyaivulhhgGE55G3abmmVa4ny+XpL1cneTokHz9ifqQavYFVypw
 BnEOkLlrlIsLwCxW2tmO06JErwY3woftFV0VoTCJfH8zNgWgHF3VFKlDMbpI/4XcH34Calp7PRm
 /q+lXHHw09uGz1BzcaV6RYD73bveHEvWOHAvz7+KplZbfhGLBaJe1C8C7mg==
X-Gm-Gg: AfdE7cmWPmcqQf9L0WX25ZjA9EIgVe/7XJpXXfsgnBTb22IHOC/vCtU+vbvr/xfgTXu
 XWePkWy60Sy+dxLqIBn9c+IqBZV0aYc+yffNXSL+/ys6pI5zSr9ZSOFaYe+MUvef5nB1KQdIQ5X
 V+JyFUoxbz31DPKFDiH4m1/EyVjLG4+CrSV3y9WemFTHX4D1rqSCBNnWc3LX4vaoWl7ja77BFnO
 w/eZkle8NtPOrZC+kbBPAyD+WkgIcchsqoritrtnrU+B9SrTZH2EsAN0Ecea/yxTmLmWeJ5ZAU9
 o9ePYPfHhBvF9TRyN9KS0N1qZdxQnpi4ThhEgUIv5GUAc59UOL7mbpuU/tJDM4iloAK4gqY3DLX
 80OJzW44dIhkciE230gb8GS5KMsDnn9xMxGtkMrwx8Is/yDom+KK8s5IZNTaXIg==
X-Received: by 2002:a05:620a:4621:b0:92b:6805:eae7 with SMTP id
 af79cd13be357-92e9a51eedcmr1166699785a.68.1783328392703; 
 Mon, 06 Jul 2026 01:59:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4621:b0:92b:6805:eae7 with SMTP id
 af79cd13be357-92e9a51eedcmr1166697985a.68.1783328392088; 
 Mon, 06 Jul 2026 01:59:52 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62c779dsm683576966b.53.2026.07.06.01.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:59:51 -0700 (PDT)
Message-ID: <b7e519d9-4711-4a99-bd6d-f818ea415283@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/mptsas: Reset doorbell state on reset
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20260629185035.2138238-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629185035.2138238-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5MCBTYWx0ZWRfX9GTgt9QEscoG
 bPih8pm8SUwhN41C432GyUZ/VpDhw0rkeCdwFMRvKy8XqOL0HLfyHoYARSbQFHHa6k3l/FTVUnI
 Ixx+faYHs267u4FRhTgqqwY2LtfafOg=
X-Proofpoint-GUID: MkrG49J5CEEjW1zNszD-0PQ1AH6ftco5
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4b6e89 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=BxYp5kjD7oKxsPU3rKwA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MkrG49J5CEEjW1zNszD-0PQ1AH6ftco5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5MCBTYWx0ZWRfXzxMa65qTTdk1
 5mMfs4x8glhZ0tUbZKx2f/iC3PCgRqWmQN+TvpgXKq91u2078OANiaXO+6xeg7s/7nXLWDbj5Ec
 B58KC7/gotI3ByeiSxyHEyT21OzuECdA0Z/Jri4nG6OC0UflmTZStmATsyh0jrqSHsHtxzYAXDY
 yTtwse2G0mfvUkuW6/26bl1+dFOGWxTh9wusYzaWkaAqywJMYkaWvoAt0h4JmChNbX4zdmVDc1W
 FBUqjUqB+RY+qZsjHSPCOqdIj+0mJ+EGGPauEs30axQ2tPNoZAwwK9ZSjWW0x9fhdB/Jut/eKSV
 NdFUwBfWhkDlW7k9Y7mKIoaQOuAoeGxnUnSl2bS+e735od6vMWqJnZjtYJv+5LcKzkRaQuwuQ4k
 puoS8dkkZmhcskRAgfx5x9UaQCo7wKzsytCBncOzsEeHUfkDriU33kPYlbK0J+S7n5rGjaN98Ag
 rvBV6+rY87Z3Xz4eOzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060090
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

On 29/6/26 20:50, Peter Maydell wrote:
> Currently the mptsas reset function clears intr_status, but it
> doesn't reset the doorbell state machine.  This means that the state
> machine and the interrupt state get out of sync, and the guest can
> trigger an assertion failure in mptsas_doorbell_read() where
> s->doorbell_state is still DOORBELL_READ but s->intr_status does not
> have MPI_HIS_DOORBELL_INTERRUPT set.
> 
> Fix this by having reset also reset the doorbell state.  Strictly
> speaking we don't need to also clear doorbell_reply_idx and
> doorbell_reply_size, because those are only read when in
> DOORBELL_READ state, and the code always sets them up before
> transitioning into that state.  But it's less confusing to clear them
> out on reset.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/304
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Disclaimer: this fixes the fuzzer repro case, and I have
> run "make check" and "make check-functional", but I'm pretty
> sure neither of those actually exercises the mptsas device...
> ---
>   hw/scsi/mptsas.c | 4 ++++
>   1 file changed, 4 insertions(+)

Queued via hw-misc tree, thanks.

