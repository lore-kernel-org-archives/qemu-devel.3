Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04B5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgdi8-0005uw-4g; Mon, 06 Jul 2026 03:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdhs-0005tm-JL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:25:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdhp-0008QR-G8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:25:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641nYX3614699
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 07:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JOiC14V63fMgVMwPGxlpye9C0USpEkcK9t4JhKU4El8=; b=HEDLrIMGxM+/QKNZ
 xbsRUqWj26eJjZz+TyBolnCwOwsCGy4grs6ybQgWuAwX8wWX8FY7nBoI+ZWMr0V/
 Er7a6GP/nCWKs1RE5DiGRjsPgxGz1Q8Uo5uVAUNjPPLILkmXDde9sTWOC3AheegE
 X0uTlcLhnSz6gmRI09NuROR/MPMozuTG5beNk2BF5+En4cbOtPHbLtQIOfQVl6NK
 E0zJTAL3VI6QPtbhgPBJahmWK5vIm7bOr7zcB0h+VBC+yP0mOtnZfLIybpujYb6p
 vBi2s4IS9qAfvzbk/DsHU//sVN0dpRhbrgecgP8eVyFgu6t4HP1hCiL/lWQBptIm
 5be3cA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvn36u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 07:25:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8efc093d7e5so24171906d6.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783322717; x=1783927517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JOiC14V63fMgVMwPGxlpye9C0USpEkcK9t4JhKU4El8=;
 b=b/2b/mDK9EQuAvKCLodA9NIG+Rju+TtGErVarqekaQMMyTF3BXmZIt4Mp7J+sIEgk6
 c0fsa9frFAdJz51ZlG+NNbR2FxIF+yZen7FwL4mtj6TMWcTfE5LSxtCV7to/Mjz2H6XV
 xHasvtsHE1ZeljIilbz5VjRrDaxVMdzzlXSm2w0Dj7s7QQsAIZjJkYP7kgd861W28y7g
 NFwdYaXN31TL2LGN0GuncUsRznyKokjyKJHeddYAEOddAyAY52MHhyFJDRHqdIeXdL7T
 a8KoenGrYYpp0xUaK2SJQDQPRk4L+FcXDHhF+FYgA4Jip6iivR8ZNCPf1iFB+TUtKruX
 UggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783322717; x=1783927517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JOiC14V63fMgVMwPGxlpye9C0USpEkcK9t4JhKU4El8=;
 b=rJGUekL6MR2Y7i0wDSKhxVY5YZnjm7jaVVYjIJhmIUFBrWZB7BkguyoLSRzkqtB0K2
 1b3FYB7H+MGkJQUTiKpPI4+KnrQaVOi3txC+lcAyJRsdxzx/W7KGx2J8+R7nhvXe2Sm2
 L6y8VI/fBrmwumnEnKNXXM2dqT14n9hRwzQwWFqCqcJ1NlJ4Yv2BNOnekAGENfXwd2xj
 Fl9n4nRPxN6DdWq2u7gPB5KlBtxd/0ax1+sJkkT7hWU0dlIQTU/9lfTUFneCB25so7aW
 OgT1VQmSNnvEaHGBrSj4YYULbEIAPeUuyA5lZuVhb6uIXHDK7L0u9aGLeGs14LyDIlwP
 f4pg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXO/mf1N8UDq6o3Eobjqh1adfehK9JwDNkFBvbAxWU+fHCxJXHyr1RYFWyeKE1qcPoVto9/V0uC9+5@nongnu.org
X-Gm-Message-State: AOJu0YyUv8LA01B40LEFj6FTxMTr7u7MtgLfvIwlqtOex3/Kl+4jBve8
 E+NaNZob1X8ZuVWLOsUergkp0OlldgQcTZ2BX4tXdrYm+IFll2aakQ3PKIfWLVwP8ScNdCa0xTd
 PIvdmmcXyd9+m8vBa37LP05VZRTusTBdjL1iLdypo2CulGWcp4mS63TQpqQ==
X-Gm-Gg: AfdE7cl6TOu4xxG961BC03/4FXChOZ4ohbkfqFCAo2cfdY/1hRO7FbZlXOtSMBz/JXf
 qTDbVfyCJwKl2jUJQzb3QabV7D6G0pSC4q54MHMFAj/e+CMiX2HdD7mP3OwJjFz/uytsCHEENIS
 zYA+izc+sLH6Gzlu4Bntaq3bJJdK9BTCy7Cv3w3MQBQOMoWD78EMrbVDmAh9sFl+67LN2ivxSv1
 8dNx09CrcUPdevA4ckc5VhCJmpaxg3HaRCswKGyD/Td2vnzheVyl7U4jiHkDhvRsB3kJQzsxhuN
 XglFHpGPyIEd8TeQRFpJ1eWqVUNUfb3RbUzZibIno4tgfSrZ+Wf8OeFqv/NEl09WoK+qdzXnQhQ
 SMd1o3Wwtw/VR3eNxnHt8UYQJPs/tVb1ovaSHqk809yLgXEXo3ZcNgt6o0iXNVA==
X-Received: by 2002:a05:620a:1708:b0:916:15c3:cc6b with SMTP id
 af79cd13be357-92e9a49f48amr1221616385a.55.1783322716321; 
 Mon, 06 Jul 2026 00:25:16 -0700 (PDT)
X-Received: by 2002:a05:620a:1708:b0:916:15c3:cc6b with SMTP id
 af79cd13be357-92e9a49f48amr1221611985a.55.1783322715608; 
 Mon, 06 Jul 2026 00:25:15 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm245120625e9.4.2026.07.06.00.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 00:25:15 -0700 (PDT)
Message-ID: <36bb0bd8-3d1a-4de3-89a2-b9c7aa8267b1@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 09:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/mshv: Fix pointer to proc feature bitfield
Content-Language: en-US
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?=
 <dblanzeanu@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
References: <20260701130335.418156-1-magnuskulke@linux.microsoft.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701130335.418156-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4b585d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=yMhMjlubAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: lF_y1ivLv4l1_uQmnI846nOVmvss1t_w
X-Proofpoint-GUID: lF_y1ivLv4l1_uQmnI846nOVmvss1t_w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3MiBTYWx0ZWRfXw2Vig1QCtNDE
 QZy5w5fR0nE7f2OKCatMpZjV/en40zRHwpZBphAx7T3Aujs+n3v/ebaRKGREDtcf29rzapqvlSa
 oJsMCVn0ab7utr/VF5+w74j6couuNLU4eZaiB3wLkq4d8lybitkipe2UhZjoRRAJl4MZ/RfI+CR
 n56zzLguHx2yGB1MHLMVDUSsysUMDijKIC+LsaEdQ5tOyWqLeHUFQmGsCui7JSoYm0lGxsWD/xj
 1dik2NUYdjXwgfSLu8NIsYL9vr+nvmEPdmMqxkjnWrVpiNCV1ndbLNkHQARZRlh3OxjSfv3DD/N
 BlH2u0KERg3uVNvz0sAFIFYtI/Ro07v8rGkWzd2nI7Y+qpJ1yujZy5ZNRKOVkYjkoTsOts2yE3v
 5ATsoegl+F5sYDyf3Td3M1BqYyOdDzfYMZtDa9p3MgqrJvB3rfognrN2EpQKL0LPljQAFZ0GD0V
 eWYSb+baDRUs75GMfjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3MiBTYWx0ZWRfX6nvXHwG14AAP
 Y5+UFD296tD4aEatZxtiYJO3qcYHv60L15890JtpzUixCBeWpiCljmMuURwlcMSSimYX6FmfNUp
 ur7vV9SpqclQWgMYwsoNYTGCkznLoNE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060072
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

On 1/7/26 15:03, Magnus Kulke wrote:
> Processor features are stored in a union containing two "banks":
> 
> union hv_partition_processor_features {
>      uint64_t as_uint[2];
>      struct {
>          uint64_t sse3_support:1;
>          ...
>      }
> }
> 
> get_proc_features() to retrieve the 2nd bank was passing a pointer that
> steps over the whole union (+16B) instead of picking the 2nd bank _in_
> the union. This manifests in mismatching feature bits for the 2nd bank
> and possibly other side-effects caused by writing beyond the union.
> 
> We need to step over the first bank (+8B) by using as_uint64[0/1] to
> correct this behaviour.
> 
> Fixes: 2f6da91e8a ("accel/mshv: store partition proc features")
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>   accel/mshv/mshv-all.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

