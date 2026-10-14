Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C640BCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpO4-0008Mh-LG; Tue, 13 Oct 2026 23:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGpO3-0008MU-1p
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:10:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGpO1-0007iP-7w
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:10:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E1iOar3017736
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 03:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C6BTd4+DC652ck87k+ZtCTKEsPH8cHM0ghdA8uo+Y44=; b=ZlnCNFuD7SCZXmi+
 uabp0W88iB92cnAkVLIVVtIIkl8UGjzbHGLW7/1jmRk1FqeAnCV6WKUZy/yu/QiG
 uJ9tmEdj16WkKxEnXXvyT5t/MNVYKYGQBIlV1BLt1bUIe+K7QTlgixnAZT2EvaYY
 5eCI2W4li+NYFKmybgN7waLe574RBVE/FXgWKW3MdQVqMBwVfxJXRkutNAFv4NaJ
 oSl6Ea8B+O+eA4Z+wXTLS3HwYyeivuXWWERLeksizQrrxbohtcTlEtH3er1VeqVr
 m6V0W5yB4kU23iGGt5qMVv0LsFM6XT0wd6YA36uCNoDHvM2HjN5ZnDlYJJgjPVXk
 2T8ZPw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b23r9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 03:10:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc40759b2so806589985a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791947433; x=1792552233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C6BTd4+DC652ck87k+ZtCTKEsPH8cHM0ghdA8uo+Y44=;
 b=eh3kgFCGOYO3k6c+ge8Xr2GV2W09Kqfpv9qHfoi/prclLm+/lfCOEvR2WE/GbEI7GT
 +UXXDhtSRIzgzNpBwj5CoH1WDb118nAusEKSlAtij5qBT4bTrzmOQWCo2rs6FIouev8b
 i0KmeE1DXu2BpzHe2/aasz1grhpY6S3WKfOZKLhba3XQaxBt7/Mg54gxFgolKGUKw4Xe
 ln+Sx+XC0hHWAkh7UYntGnsErsj3GGvNrmRMv2MOZB6uDCGO+AT9SEsoXe53bW9WVeBa
 EoURNWrgjzE0bFhc2/gG8znKF57rM1r+xnGQVWYJWiYb7kYnPsCOgPn5E9pblmtTfgZB
 D6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791947433; x=1792552233;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C6BTd4+DC652ck87k+ZtCTKEsPH8cHM0ghdA8uo+Y44=;
 b=x609H0JS5xv/FZ+HEVyc12tAulyfYTeFnNAZwm3j8qlNcsQvITDwG2N9oGm7V7xSxS
 ZpyZJQqxl0eLLZExpqDECi8gjcy5ijcRafv+mxGHgLnB35RltyOv3iYb/lAsoplxxS+V
 raY95s8LR5aoDxHbVrhTjHcNiPu2tCEUTQUWyr4483VbIw6+r5YDFVaVY1jMc6ejxclA
 9IcOeRXP6fertZ9JdsQuqfKYlQUodLkiRBuOi7UHVBXqlvYhoonIRb3n1lbquUqa7hyG
 fWjHrAv9HYA2H/ClrlVg48d/3U/NvQDDQCSYNRid2nJBMTAHWZ3KUCrLg5JDPmiH1yzG
 jtGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxveF14CNrny7pCEgjdXdKLbDruPJCLPoK42wKZzzdx0FaPJvRtK/M0X5skN76HWwdD30ZjiitNhx92@nongnu.org
X-Gm-Message-State: AFq9FYKHjVt0IbFfU5lqjOSCRpHnSI+YGoRFNJH7lawR9LRltkZABNiJ
 BMZJ0/5GQQvVYyemkGjwp5/1JyDr38VjBNSQzRurfzF9OUtvmT2LIY62mI8rh3rG/5XXXke8k04
 M6f76DRigUv81sagM0KxFsuM+dITTtFvRNG6fgb32VJyvXdwO6v/dCkKHKg==
X-Gm-Gg: AYBFou0yIURKPa+XX0r+ab0mrzmW0cXTYmm3PeB21eSLGoPy9uatIrnQ1BmZt1mkSv3
 Gy9yXi/869vYPhR1vQB1JALpdFiqLhwVCdMemU70Ge3qlaXvYtHYXNpmrx+XJMzP0tnGsOFBrgb
 Pzs+P5QfGR9e81QRfyzNHXKTFuUB7ZpjAIoi+PILboJ7gLKIUWHDqpIDDphwIl4R5XsevVG7RV+
 0JwbHAq1khfdqCtCQZfAYHg4S3Ukl6kCURS4zsXSyQZjMGTt3p7FOCWWrrtsEGciiRCy+ebraM4
 GmkUM243FMEOdLdS3AS8Qs4m9X1vu9yoY16eyuU3nC8ecaf5y3lDkb8Hgb+lVIlWT+wxKfARsIs
 w7sGnmrmyY0aC7GipIe6/rIOauJXrfDcg8Q==
X-Received: by 2002:a05:620a:1b9a:b0:93c:5ff3:2244 with SMTP id
 af79cd13be357-93ebd2085femr2272917085a.35.1791947432944; 
 Tue, 13 Oct 2026 20:10:32 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9a:b0:93c:5ff3:2244 with SMTP id
 af79cd13be357-93ebd2085femr2272914485a.35.1791947432463; 
 Tue, 13 Oct 2026 20:10:32 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea0f1csm587045125e9.9.2026.10.13.20.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 20:10:31 -0700 (PDT)
Message-ID: <ceb0694a-3ca7-4112-bf23-48c0e117ebbc@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 05:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/microblaze: defer PetaLogix endianness default until
 init
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20261013195929.1648-1-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013195929.1648-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6acef2a9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=zfSE7H3uAAAA:8 a=pGLkceISAAAA:8 a=90ak46tRxeTLrPC98aoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=r0bLQnNZBtpSUBZG6Bsk:22
X-Proofpoint-GUID: cB5FnIPUkNisOoBCdWzCo-_57e9EznTx
X-Proofpoint-ORIG-GUID: cB5FnIPUkNisOoBCdWzCo-_57e9EznTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxMiBTYWx0ZWRfX50ihy0vir9Zo
 IpUQEW4ye4x9R3+77cTTpo9LSXAUIy/8HGhwV4NVxRFiFbFjZ1FsjqPcMw2jkGdsLOC6zey7K9Q
 kCIzqPCM24nPxXmlfkhagfJR2pKwk37llbtnUpfoLJ7W2IoB+Yi4ELV9LBiseN9w8YL0CkOpD7O
 7v2t1woIuqjSpKS9FmZ8YAD8VuRP+VDQHKpwQQ1wl20LVLba9ZtuyRjbtvYNjrba/OQNXgfyQ6B
 JsdKz+2BsBkaKoqxgNJkP3djnuiuegbHDoqVYbyouvSYxLzBjw/cTAyanDdaBxhkFounp5Ic9jM
 nD/c1xJ2QdpFJYTgB7tFwyOOBDZfsLUThAp8beEJIxg6E4jWAMmk5xES2J0ZmGsOLcvkAmCbBgL
 oUmvpoetU8qTTf6lhNEFHTQGsSRuz7uPpGFn7yggMxoeaECojoU2c4Jhh0YkQMyDxSYNykvSK6t
 VHJeumr4V7/wPirZvYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxMiBTYWx0ZWRfX/sdOZmpElbH5
 C6Je2Xi9atic3Ss7oasXB6TnEmm+G/DYZeVzGxmcPRppimOmMtxtq34e5HNkYVHtdjiiSAxSRzo
 nyi62oOyx+XEKygSw29g38XmOowNgJY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140012
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

On 13/10/26 21:59, Yonggang Luo wrote:
> This is for avoid call target_info() in class_init

Why? What is the use case you are you trying to fix?

https://cbea.ms/git-commit/#why-not-how

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index c5f64319009..43140ad7bda 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -83,7 +83,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
>       MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
>       qemu_irq irq[32];
>       MemoryRegion *sysmem = get_system_memory();
> -    EndianMode endianness = psms->endianness;
> +    EndianMode endianness;
> +
> +    if (psms->endianness == ENDIAN_MODE_UNSPECIFIED) {
> +        psms->endianness = target_big_endian() ? ENDIAN_MODE_BIG :
> +                                           ENDIAN_MODE_LITTLE;
> +    }
> +    endianness = psms->endianness;
>   
>       cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
>       object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
> @@ -178,8 +184,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
>                                             &EndianMode_lookup,
>                                             machine_get_endianness,
>                                             machine_set_endianness);
> -    object_property_set_default_str(prop, target_big_endian() ? "big"
> -                                                              : "little");
> +    object_property_set_default_str(prop, "unspecified");
>       object_class_property_set_description(oc, "endianness",
>               "Defines whether the machine runs in big or little endian mode");
>   }


