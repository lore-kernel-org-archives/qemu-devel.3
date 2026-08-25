Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D41C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyz1T-0003U8-3L; Tue, 25 Aug 2026 17:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyz1R-0003Tl-LA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:49:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyz1Q-0006oD-0k
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:49:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PL9hoY2498710
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i0Vtsa9IPTGTxsdnNlTwNzKOYtMUoaBWvhK116U7nuY=; b=BFvF0VS+GYW1yBxo
 U2WuxyoMfF528hougzdEYRtfTyef1eUg85Kui4IG+r59B7yYnSis58Hb/nSNIFuD
 mgoz962w61K12yMBgWDrSu/kci5vmRRnBJdW6O8zfLvU34ajiN68UjYhSGiahd+w
 V/wWigGfQ7mhxY5u9zmIz1nuacZAdBs5j/WKOryLv+fWE3/H3WM+0D7tjs6HDnR7
 UfZPSsBQIYr4hAFx4CHtlmwZDdLV4u4/IjV1HUlchUmhv/pUxcY+rCT7gGgOw19U
 o6BIMxRqaF+MVwwD7oycA62MpqGyglZGdHu7dYiFmemMpvvmgZ92kXSpE5/2hcge
 lqjDMQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fjn0vy0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:49:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f39a46efd9so12457386d6.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787694569; x=1788299369; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i0Vtsa9IPTGTxsdnNlTwNzKOYtMUoaBWvhK116U7nuY=;
 b=KZJoj3hLn9L8cwo6iAuq0XJUdvCFsHin2skWYLetfgRwkoA6DrqZIZdMmlKBv/34wK
 tYk4yPP8YpZPFemq9nba29BUJ6C0jVRpyYIKj66fonMZQz9JSWGuYsNTTMyFXSg/zs2D
 EzYeWFS5Z3BKphYQThpMYB2D7ClSj405vWD24g5eIrumYcmeUA88jgEhPNd155DYikF5
 bC+5R0YCSVeZeNaN0g+9l6JG2URfk5N7nleexLk+/3YE4tt4VaqEps+R4WMY2WpoS5PC
 w5GpeYzLz6f1NH1nbGlYQUqZtci30pBv1f8fzeGWjBoy40LjuHyordPnRb7bphQk5W+Y
 PXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787694569; x=1788299369;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i0Vtsa9IPTGTxsdnNlTwNzKOYtMUoaBWvhK116U7nuY=;
 b=N7PJjoDHeQuwpCzPgWEG0w7OelqbjdlCsH8GpYsIadoKsxrXpLUVp3xLGjTqlBha/x
 NWhzagapGKep/HT38SrISfq1/3nsS0pG9Szakk745/GH0c7kebuTnbNaHL6RnUMnoyHY
 KXOiAngLP63KC5bCay4tjmUXfVEWLpwzoxMzNbtNWKKuIGR340v+K81mFqH3d2OfZBDh
 ipMwgK7efClevMlNVupJs4f5cFy2Q5Yp/xO2wkzkxqjk9R8B+XuMq7RbkaaYlnHU7fAV
 hrSDMVf+7PpnbhnqbkQ0I6IT4C2BtP7Bh7BEkydM+2tepdRULGpkwB+f6UqC2E2wTOm0
 tmYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpijFGV4t/+x/htBlg3lDLPkoV5fX6bvEtE0UOwBX8OmejlI7T9nTys02tySBzR1nnO9bmesVOifhVG@nongnu.org
X-Gm-Message-State: AFuF++kP6/wBYKW5aauxAP0MJjl79AhagtwJZ4bNh2tKVOdweiYBs38x
 OqZYrBLTqPPaVNUY4eLDFWfKpcxqV2O09BnsR/6RiimjeMhNRWs/AbcDkM7wJTyApKOp1oKndDh
 xj7+oJJ5WdtPQT9y2erdYTekuLvyylrHlyi8iLjGeCMbeuHwKor1Q/PxFMg==
X-Gm-Gg: AR+sD10PcGUeXFicP+WXPyhP/ZFtasj8IH5zziyPSVcnEATgWiHMlvSnvPwiN0b/90g
 kKGlJSXPMDBTunJK2i9D1iBzeB+KPWHQZHb5lf2F0a/cJ/6FckOfhqo1ZiLqZKqIDKvujg4nmC2
 H00UZCInMzEm7HXPuk0gDcoMF3Wc1ja2m/2FT/vRoUpc7nogp5a4pK5F0oS1zH2aKlnF/aWLtJh
 ciXUDTFSQa/ORTUJwejdPYPA5vE6jkDfCyzXgs/7RkafvAcIvpubjsRuWEA9gcaoA1/0+u7HfHp
 i2CooBPjNljU2oiP8eWcwZ/IHJPZW6ZDn02ZTB5LnxbiTpvHcFxMNTwr9SpQoHyrx27NihMbQDc
 2BWeXREe11rRnD6yINctelg9BZnuZxBQP91tDxn2V/y5Xt4okZDI=
X-Received: by 2002:ac8:6f05:0:b0:52d:d12c:3ee0 with SMTP id
 d75a77b69052e-52e2ecc086fmr118391671cf.11.1787694568898; 
 Tue, 25 Aug 2026 14:49:28 -0700 (PDT)
X-Received: by 2002:ac8:6f05:0:b0:52d:d12c:3ee0 with SMTP id
 d75a77b69052e-52e2ecc086fmr118391371cf.11.1787694568509; 
 Tue, 25 Aug 2026 14:49:28 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dbf33sm702454f8f.23.2026.08.25.14.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:49:27 -0700 (PDT)
Message-ID: <1fa7d135-9484-4eb2-8fb1-9c6431f98454@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 23:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Fix typo in tcg_gen_hswap_i64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20260825154908.20472-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825154908.20472-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Z_kbLLpPXOT9lHxyuH7hjqSNI2LnoYTD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NiBTYWx0ZWRfX66oLEejQ//ps
 NiL4sMiXBdbhltL0EV8gEdqacFVZTV9WGQSnRfFCLfiDzi58GLCVGCtGr07sYjfThcg8hGPp0i/
 StCyTIQRBL2HrGBnZEd7t99LqQJt2Qo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NiBTYWx0ZWRfX6PutrllyJ/Ku
 YBQvq1SiNpmm2KwV+Ugt1TXFzfRE93xXBDuzEGrGUrhKCid/975p1KQlwo5nNjjn1S4y/NdhRs3
 cKMMMCvXSrm4Vj0hxFYRDoBTvaopL/LKYdbcqFcrxiL7NxNa25wTAJZYoS1JIyBDhHuvs1Q6ruj
 W71q5syhKYfZWlFiRaeBvXyMWdYDfPbNoVNdL0vC9b+CwZK1DNVn2pb/1v5eBmNbwV5BH11KLHE
 TEyUzbcVWYDIROoroz9RM9/R7CQyoi3R9aF6rk03hZjtq4c1Y0Al+IwtdQ43ZNARuZdivCDGDX2
 9H3ohLCyIJWZ94Bb75UyZLpbe5MXDOFxZeiy8GP2N+54xMPPTWfXJGdPlZ2C2b+uWEIydIhnSni
 Q+WNUeZKfknn4pUO7aFBAKvKY203a6qrrjk2oWhHxU8xkpUWqf7z/WOyeZ1+H5hYcedBcr03Iux
 SlnJ4iQ7BNX1B9RUz1w==
X-Authority-Analysis: v=2.4 cv=ccziaHDM c=1 sm=1 tr=0 ts=6a8e0de9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=iGhS3xDXLE4JnHo6SrwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Z_kbLLpPXOT9lHxyuH7hjqSNI2LnoYTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250186
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

On 25/8/26 17:49, Richard Henderson wrote:
> Fixes: 288d39e26d ("tcg: Simplify bswap/hswap expansion using bitswap")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4229
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 28d3b2a847c..2c88f4f7ca9 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1887,7 +1887,7 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
>    */
>   void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
>   {
> -    gen_bitswap_i64(ret, ret, 0x0000ffff0000ffffull);
> +    gen_bitswap_i64(ret, arg, 0x0000ffff0000ffffull);

I was pretty sure that would be the kind of mistake but missed it :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>       tcg_gen_wswap_i64(ret, ret);
>   }
>   


