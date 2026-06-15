Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A49CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ3Fe-0008O5-DA; Mon, 15 Jun 2026 05:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ3Fc-0008NL-FE
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:05:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ3Fa-0007Ju-Vg
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:05:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6Kxsf3828200
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jmoc2bqCyy/BgjcOTiLr/yZpyh6nOwhx0eAq/0XyEhs=; b=nxhZS3kdLd42YA4a
 lQ7rnMrfEAsEyPnHnAMlp+Neo19oqOlE9ijTCrMz63/co+nExjV+b/M5Q5RP/QU0
 mF4AWdRvH05zg23A38DbqU5kGDYT4zih8Ue5JS5n2qddREZ8seXk5JJMQ4J4ppYO
 URiifgFMZeyFUWmVhqqTlrh7PyHJ866y97RCGAWsGJg7bWq9vC/iW2qyBMuhOkHU
 n33WF5nG+7NVtmvSECPh2UHl/Ez47/Sgq/SGlwtaYFsL1b1MQS/y1Srenh57+UUf
 Gyl+Fo3jKq3qOuVeh4TAsPNiRzQI6NujIKSDEfPb8unjrqsazbUBuMUK8QU+n/h8
 erXrEQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u6j9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:04:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157de5360fso758467285a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781514296; x=1782119096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jmoc2bqCyy/BgjcOTiLr/yZpyh6nOwhx0eAq/0XyEhs=;
 b=dExj02x9gTWjz3s6BrrIC98fbkZKLT+WRzAfO2++G1whL2TCnDwPIAXq3u3emX9vca
 RIImJPzW98tOyrNIAFGigJmSu0SHtxjiWlwpCABkRkvHOUj2gMUQ4sxsN+yZdgnRvPLO
 7LkdpKg4BWwRT3WVQRY62kj3Cr9R4U+owQOPq/QhDPtzdmGiKuMHlEAbmf+zFuuqfGLz
 3szpln+KFzXFRwufwYUhWZeB303xGepy+tUG6vJXJwXF2L4pEUeQ289RfO+ry2TGjjbv
 dzGvPZlRWZwabrlEQ92MCB+99qgvPqZffSbCPO54FBokfLNrZks8HOolSvNScSlqu10A
 l5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781514296; x=1782119096;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jmoc2bqCyy/BgjcOTiLr/yZpyh6nOwhx0eAq/0XyEhs=;
 b=POjTrQAN5H37sfwwvO0awQ0nOeq0YA8skEqqq4MiuCYfLG3FP7HDwiG87xqsOXbOEP
 H7eb18Wm6Kyj7NxvakqYUflyVZh0k4yBsDYOhhWY6QUP51EE+TjG0Gteq3zZrTyWfQWo
 XT4+y2H6FMtLzqKp6/XvUWOAbTymAzLJxXHD5SibTuXczVokjy/pYot3sDHVutp8O96d
 lEvX+FUIiEx/xEMrsKrgrAf1AAhyTeqTRIVQB1KS2VmptMs3XGDOxx6whyED90b/+adJ
 xmhbFL6bCvcOxuawAJ5Zjc9tv3+/23U7wYi7sX4o09PiFqugYsc8k1m+JpuA5EjoL10q
 y+gA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+pglxJf6Di5Ww0rgNeoQmeMhEnhyECjdEb33cgJgTFCtkBml1GG/h8idJr6wn4MdU89wSm59G/v9R@nongnu.org
X-Gm-Message-State: AOJu0YzyRaApTSP4r71xItIlQMS61dSI7gld5c3E7CvVk3+7RKwNKj/j
 sFjjKXVdBS5MljHD6NTIC4WubW7id82aRzv6DZOfO7b5fEEegiDP57+ing5HZX6PVox/Y1e1uFs
 yYgqj5QeW0ekGcFS/9mKoqwArzd2+UZkMeFJ+Pg8ytRSrUSbSE4dik/ZHKQ==
X-Gm-Gg: Acq92OEUVgeg6MeTfNeAmeNgagrpyb1FxqXb8d2HtQ0AlSBw+LQdpmdwAfcSWPDZ0i7
 E/SeEPHYIkroSTwNXiUXmGe2rcXWdpGAxDPX44vVdiZV+IvLZfaqeBpWUu2MOZlxAXdYrarRBHZ
 N+tstUjzaYOZNEUTxx9Suzpi6ZPaVkSU2WaCU70fAdXVoDpsXH/3qBd9QkG0JtZ/ITM/DOZdUDe
 7BSJs4bVVxBvMbc2Ql3xB2x+RoN14s8eXjhf5BF5xjJJaVgDWXD3A1aL5Tcnjokgga2MbNp9UPe
 UwFS5Tzt393vMWtNPWuQVCutKeHFD3MBrxlhVixQt3HuITQIdhVIUiPtu5SpxmEyK5OYVH+PizH
 jwZKeKEAohINKblVk+ORPnXYsbL+SjHpUkrEScOK5daSMmXsr/q7ZMsq7PBwkdF14RyCQz2Ju
X-Received: by 2002:a05:620a:450c:b0:916:1765:b774 with SMTP id
 af79cd13be357-91619eff271mr1687548185a.21.1781514296452; 
 Mon, 15 Jun 2026 02:04:56 -0700 (PDT)
X-Received: by 2002:a05:620a:450c:b0:916:1765:b774 with SMTP id
 af79cd13be357-91619eff271mr1687545585a.21.1781514296075; 
 Mon, 15 Jun 2026 02:04:56 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937948dde4sm3119467a12.20.2026.06.15.02.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 02:04:55 -0700 (PDT)
Message-ID: <8e12b7c9-32e9-42d9-a4bf-107a0bfb1a3c@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 11:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/kvm: Fix CET SSP MSR read feature check
Content-Language: en-US
To: Saul Freedman <fre3dm4n@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 qemu-stable@nongnu.org
References: <20260615033338.1563854-1-fre3dm4n@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615033338.1563854-1-fre3dm4n@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2fc039 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=U4MUTAyXVA4O6JjbmIcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: dTD4EFMNNfkbtqCiE1cCaN6_RQuKpAJh
X-Proofpoint-ORIG-GUID: dTD4EFMNNfkbtqCiE1cCaN6_RQuKpAJh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5NSBTYWx0ZWRfXyg357iVgfk+Q
 3ONTMJikkz2kvUznSR9zyxqaKd+Z+5EOirZIujbA4ZRT2ewq7QZzpcCOlpeIOv34Ai1YTZ0R4vw
 jIQzlDRdNqsQFll8oxQxVgdJpX/Vx8BNS3+bJouTpj4mCKNIXk16smCVNFebAXyf4LA0vl5RKve
 enUAmsHj9NXsj/it1LHA81hI1V9TRa7NrZ+xP2S8UqC5qD1M1N8oxBavWfsDSE1dB4C8gOYayfk
 ZsHu0Hgfct/Ujpp+CQVqOBZhzcPQI1kXCm2JyT6ZpgvCkQu5dhrYMyWH12JYXkzWpGQdCbKSdeR
 FJP7wAB2agg3K45pvUKrIVHTy+UK2vOHo86+bUzPzLRVuF5A847M5n5iFsX0/69wdUdvBDzlhpL
 ll3mo1iFXHOBleUTRqMCYkniue4C7TNOy5L/9iV7rO3ujHVLXQ3oCFi+VQI3EQqO0ur0/jJAr/J
 fa+vYcw1GN3HVamKjbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5NSBTYWx0ZWRfX1BMCR4y50FxI
 xLCo2lSDU59jowsXkaN8OAvwKILQYeJRpDvB6MbGB6rx8gW+bI6Z3RVBgN4KpfqbJNhkZkILusx
 4PklVCuHieNQ81QwM2dWKxzIFGP/1Dc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150095
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 15/6/26 05:33, Saul Freedman wrote:
> kvm_get_msrs() adds U_CET and S_CET when CET shadow stacks or IBT are
> enabled, but it checks FEAT_7_0_EDX with the ECX-defined
> CPUID_7_0_ECX_CET_SHSTK bit before adding the PL0-PL3 SSP MSRs.
> 
> CPUID_7_0_ECX_CET_SHSTK belongs to FEAT_7_0_ECX. The current check
> therefore skips MSR_IA32_PL0_SSP through MSR_IA32_PL3_SSP even when
> guest shadow stacks are enabled.
> 
> kvm_put_msrs() already uses FEAT_7_0_ECX for the same shadow-stack
> condition. Use the same feature word in kvm_get_msrs() so QEMU does
> not restore CET enablement with stale or zero SSP values.
> 
> Fixes: b6f85c5e4527 ("i386/kvm: Add save/restore support for CET MSRs")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Saul Freedman <fre3dm4n@gmail.com>
> ---
>   target/i386/kvm/kvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 9e35288..3f4a241 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5021,7 +5021,7 @@ static int kvm_get_msrs(X86CPU *cpu)
>           kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
>           kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
>   
> -        if (env->features[FEAT_7_0_EDX] & CPUID_7_0_ECX_CET_SHSTK) {
> +        if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
>               kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
>               kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, 0);
>               kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, 0);

I note this huge function could be made more readable using
various has_feature booleans, such:

   bool has_cet_shstk = env->features[FEAT_7_0_EDX]
                        & CPUID_7_0_ECX_CET_SHSTK;
   if (has_cet_shstk || ...) {

Anyhow this patch looks correct, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


