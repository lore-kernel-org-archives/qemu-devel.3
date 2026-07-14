Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE697C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZJp-0007YX-U1; Tue, 14 Jul 2026 05:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZJn-0007YB-F7
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:20:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZJl-00079D-P8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:20:47 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E7YJt04101952
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b+i73UuNTKuCAns2V0XVFFRRshnY9OdFfkHtv2Tp6FQ=; b=JydWKHEtpI0+UT0m
 iKPJaehcyNNv4a5b8QrtoDAR/llBaYQiPyJWhoXnkFp24grsG0bqN1uIey/bowlM
 HjlGDNoYtJTd/NR5uD99QY8pQzoyP7x1VPYhVaNgtt7Tw79zmNY5h3h+10AlFsac
 vealTwF/UOCHh+m5hYKoy3lT6bRGrSj0d+Hx77qc2fAv9lbJovapS4pJCkPbYmM0
 knGKdf00pCp+Pp0VmWU/y2cv8ZhgWMQU8EZfToRgoEePhOPT4tofnlWc2Z0LD/dx
 T4Z67y7Pqj2pruza9i1AidZwOdqbigLzYI/wOHFYjUFqZmJwkUOlCOaP+Y4SFfox
 ARBUsQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudgd19-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:20:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso68198121cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784020844; x=1784625644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b+i73UuNTKuCAns2V0XVFFRRshnY9OdFfkHtv2Tp6FQ=;
 b=iqkpqsAogANIX8kZ8G4poo9kuu/V2mIjNMOpAWEuE2rd3cJZEbNStLHjyUSQrJ/3Cw
 8tX4R9A5XZhyx1YSRdYOIuvdv2FM+9m6UB/c74dxA0kRd7CQ3s2vnI2IepOS66c21hC5
 HC8XS1mu1RzW/lBLskC1fCJzp3cvY4FQnJpwkqWyHeZkf2Vj0l8qTKfh4D67ipKazcWC
 E0g3q/cx6JJtW2gi4GK91OnkZ2f5t8i4a5ZMEzO5f5yDvxD75wvZHuWKxFjxTDNplzBp
 7Uv7bd4xzq0Nrerl3olWcOM2NDSe45LwTTeq0nsnRelx0PL5eOm0TZjRhrAHqvZ9fP0b
 VJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784020844; x=1784625644;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b+i73UuNTKuCAns2V0XVFFRRshnY9OdFfkHtv2Tp6FQ=;
 b=HDAUMGCs69qtCstEsY6zbWCmhxZvipPjXlM9W7bvwy1ppBuER8B9Vp502RuvPglVo0
 jYYtTyqUjspWB++AP7YadzvgG0Y93Rsic8WA50dIJPpB95wuq/xqvniUjzrhzfRl3SVr
 jXzmcm2w3wKxX0E/QkFXtXI8exIWlfLDVicI7bpvN1g/ngIRmxNOUjJozV7mAU8HU+X8
 F9u/m2YzePNB+SIalPWpOsdv45BzyMCmBGD9F41FgEfTqi5QrQjZMxTxE9lKCPexXP4P
 Hs5uMJAfKFhdhzbxMPYVr3qBxAKaWmy62AKkKX51WF3JoSP3gcGjTXzZk+1l44rZW4h+
 8fOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCtFeIjDg5oTm8rM3M48uZrF9PCdT853yd0iIHd2Hf1v+K41UHJyvbc//8HpN9+gr72kwXXm4uBEKw@nongnu.org
X-Gm-Message-State: AOJu0YysOOvrcTO2uw3ly3ltJLpr2VK4wtNdXlKHXdLsyp+6rKNNqr0l
 5LqLAhoXWiL9kgJo9ZhsAeJ1TT0hfnsMUm33UZne+FM6gf0TaM3aN8LCY7NTLb3bsp3J1c3LpNC
 hoaKxHy+hDJSRjTHbWOhHcKYXh3+4bsQwgdgKpSxT1ju9bW2HHtNGGgombQ==
X-Gm-Gg: AfdE7cnfQqEIu4+jR7HUbyWeHOWmrCAoGmfA1WbdHvAWH8DkTEo1hg8jxxo6/KwGBKT
 6kk386zEd6ekhXhYbLEfY6qdgGtucWp/OCldNkbngaeSaAG078qx0E/+q2qh2xClrB/rlW77ubo
 RtumcRJdgC9MPfYpXK8trgWRirljUrtx3Tc6IoUYS6UVna/iuAOx65W41ZghMKmLdPPNrqQCy7W
 VUYIQe+nAh/tgv8MhMtiHerg7FfPooVIKlxyQ50oPC+MEqzR2sU29WBRgKIkMZhs3yEW+oV43Z7
 ie+kYVPTeeArCzzM8HMrZfAp0dJV15Y2fpAuZN95OWojbXPhtdTTdTq/5enoFgBPQPOfz0KpzyF
 VKYLm8DelQ9SslMe+OpZ3kdwONYLBpQEkXIUkAtLEYRmm2VKPZqMLqEk6ZCoWmw==
X-Received: by 2002:a05:622a:454:b0:51a:1a44:101f with SMTP id
 d75a77b69052e-51cbf12be72mr117685271cf.21.1784020843830; 
 Tue, 14 Jul 2026 02:20:43 -0700 (PDT)
X-Received: by 2002:a05:622a:454:b0:51a:1a44:101f with SMTP id
 d75a77b69052e-51cbf12be72mr117685201cf.21.1784020843486; 
 Tue, 14 Jul 2026 02:20:43 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15db22ed68sm816902666b.35.2026.07.14.02.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:20:42 -0700 (PDT)
Message-ID: <5fa3be03-0357-445a-b0ad-d12faff90131@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: GICv5 cpuif: gicr_cdia_read() ppibit
 should be 64 bits
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260714091806.3568281-1-peter.maydell@linaro.org>
 <20260714091806.3568281-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714091806.3568281-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qlTBWz6r6ggjy1YOe7FdZ8Cmw4A2ZxSA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5NyBTYWx0ZWRfX6Ed4u4Vy6tJY
 Q6AFVo/GJ5ZbUlXjAM3F4r+wbSMaEW5dfxrYlr9lOiaU2Fdn3+ybvT7/Br8Mteuicm5tr7VCNz8
 1HJIsks2MwT2evf/T+on2GuNcGWxtnwychID2lnTyMz2eUkVfgnI/rqtgrVkOjmV3fOODSKoygz
 Brl1xxglWDBsjcap8PgGmFFb5AQXd2a/mza9eNh80F/3Z5qojkKbdbUNAqEigz77q1loQdAMw5r
 dKi1TDRAC1sxDsesquebmrDsLt0KDQqFwBItsRGNdfS3Ymrdoeo3wefyH5KGNpJLmF21Oho5twJ
 i3sOKVVOUA8q5Wc6h0cpASg5q1vduLT5BweFT96l4kXjEEJFUejxPw3EgJoFFWem2kMCHOrOiIV
 /KPOA2dftbiitJw5P4sg0hva1IkjYLYbj7RPL71yGan3yqwZ8C/C7QrwtDC71OnbjwcDwLi4UYF
 otgo6TZYOqeHvFXbjng==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a55ff6c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5NyBTYWx0ZWRfXyvI0fgU5MJSN
 695WuHO7o4l0z0n2810LGfh5nXgGqwvyz1XT9SOwSCklfEBCRd0WJDAn96+qrDdPGq7xwD6ArVl
 TFf1O470wsgyKoRYcaf+sExz67jIdog=
X-Proofpoint-ORIG-GUID: qlTBWz6r6ggjy1YOe7FdZ8Cmw4A2ZxSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140097
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

On 14/7/26 11:18, Peter Maydell wrote:
> In gicr_cdia_read() we turn a PPI interrupt ID into a register
> index and a bit mask with a 1 for the bit we want to change:
> 
>          ppireg = id / 64;
>          ppibit = 1ULL << (id % 64);
> 
> However, we used the wrong type for ppibit, making it a uint32_t.  If
> 'id' is too large we'll shift off the end, so we won't ever update
> the state of PPIs with indexes above 31.
> 
> This didn't have any visible effects because the currently allocated
> architected PPIs are indexes 0..31, so you'd only see this if for
> some reason a guest was manually marking as pending a PPI in 32..63.
> 
> Fix the type of ppibit to the intended 64 bit width.
> 
> Fixes: 3f79212abae89 ("target/arm: GICv5 cpuif: Implement GICR CDIA command")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

