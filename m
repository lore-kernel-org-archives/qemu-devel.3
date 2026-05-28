Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A25CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 11:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSYs9-0003OP-Gd; Thu, 28 May 2026 07:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSYs8-0003OE-C3
 for qemu-devel@nongnu.org; Thu, 28 May 2026 07:25:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSYs6-0005rv-FH
 for qemu-devel@nongnu.org; Thu, 28 May 2026 07:25:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vZrO1697191
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 11:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xvC4O/VzAsghJ3cak4K/4nkHcm5qEpf+KeiSd0usVfg=; b=XejF1p4FwrXTn8Rx
 ugZA3AujfFrWDADd4U8I2loNBAD8FUEdyiKcoxnNtm5RTkI8QjFj7jfl2JCFTldH
 bbTkU/jdwKa7BxmO6upX29OqgcY6gcg46fPYQUdpnVRQg2v2sTo8AcrI57dFjB2F
 zaK/bNwUqeKHNLrjmEKx1DTQQI6yJLim+YVQYc8QSfURcq69Rul/WnCqeDMaVohW
 UUYI7j8lKjWaIW1bVCoB5Rdnu8BbKlz6SIDKsCCQtuFJsC8g+xSeJLgxyZFtcIBw
 HONRD+qprXKzJheZsI84qhDGTbwdhkSIf1UVt1/tB8za1wsCjsAeqNwigG0/W7eR
 ffI17A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yajj01-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 11:25:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-910b2b92741so2326811185a.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779967551; x=1780572351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xvC4O/VzAsghJ3cak4K/4nkHcm5qEpf+KeiSd0usVfg=;
 b=Srdr08kn8MjJXGJ99F4c+l331zLNopwQWKvmwt0mXlcTxIdnaGDzo36/8yR9jhMHil
 eFRL4cOEHmkdhiaXztfGgfa2O0MxoL/ZcKMqsfN/e6N4IIUF3lVY2i6vcCaTqmzT8W5e
 GoSs60FAXPtf0Zp8Fio7QJBh6DpK6aKZ/qfhfnMotG7hRIsu+u8Drli8tOMARUJ96k6Y
 FQB1+Ob0atmHqTsZmcBdR4Kw6RRkxaJsCIKpbul7TbefQf3U07IuQX5XQ4uUjcwPxNdm
 Pg/8uCJUxkMYEh82OsbU1lVzK5gm5EXnIInouybFUg1fnXO0w7VEI4Vgmi3ueJiA+M5i
 bTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779967551; x=1780572351;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xvC4O/VzAsghJ3cak4K/4nkHcm5qEpf+KeiSd0usVfg=;
 b=nNgT1kOi5naV+BDGR8BMkR4T/s1wymQj175SzaSiKXAvRcQKtS/OVH3+Znt3bG50G6
 vEnoEG9y9PiSmMlrYs3vAciK0MnJ4yn6Qek4O9w1q+NpILhdsMEEzKurzmHyRhPanAUe
 JXnBobkRp/V+Pb8Dcj8obESjPvYPhzby6nN5/LnhSJ4EF9CBDRxeDZLjDNMLufB4tI8L
 o/sqyOCOHLkcM9cRfepsaoB4RH6f8jcyWv0KKsgL2vZDec1tKPNiNwxbjgwNa8XgPV2a
 SrixbZT3j8OzdjdhxMuexAz5s7yT7oHPtfrDdfo0XHUsWLoOslaZbDNyhhNaelX3nF21
 DXtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RepMaEkCFWjnfFfCd7BtdU8axbVPSQTy6dtkWor2VDo/8LafbQkUXVzN/AviOgVcF9tjy9hYQRTmB@nongnu.org
X-Gm-Message-State: AOJu0YzNfdDsZJbL6wgyMD/SBWzs6/pTBRE4weTUsyE5DllvB6LCusl5
 mm0OWDXX1hystcir6lh/gusCuTGgd52RADFjUhk7nwU9Et2QhTZxSja+j1ZoylIT2EiZr3JkBE+
 MXDn4Je0x5Opc0BYvNOOjNeU9IvP7BgttEipd1syV3k4RZqqHXluEScoMZw==
X-Gm-Gg: Acq92OGoQWa2XREeP69Rhho6D5ju1F8bzZKNiXHg30SkZggfLKCVxZzhjU00pssw+A7
 nTUBA0KhgL0j+aTALRtff49CH7CK3ZtbBjRp/ouG2LI+7LbzR7J9zNa+KP3h4Jcp9XUts4nAaO/
 HqU+Na+cA3TZ2t3eJs7xrFRMeCEo+z17ny2/YW6TAC4Z3hTgr/Tj6Jq8NDvFYiERnEWFj8Afl67
 pYgNf7/9QEgMSVDV5RJj/IQU8PAs3fz+tg8cjvqRpt1lQ+z5QC3n1G4PFobotBI9cas/Hnbq56P
 6S/guOmwlrg21oIDVgx6Uamg2xZWUQgXX2CFOnTyaLEpCfEuk6Fc389GGJyzm1E3KYf5Ioqtgo6
 DBT1TwwePsjpD1osib6r0yhDtu5i88d6nyXCzNepycL11oejIBAgVx31km6GTKxVmNZc=
X-Received: by 2002:a05:620a:1a0a:b0:8ee:b817:9a03 with SMTP id
 af79cd13be357-91521698cd4mr93125485a.9.1779967551167; 
 Thu, 28 May 2026 04:25:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0a:b0:8ee:b817:9a03 with SMTP id
 af79cd13be357-91521698cd4mr93121585a.9.1779967550624; 
 Thu, 28 May 2026 04:25:50 -0700 (PDT)
Received: from [192.168.15.11] ([191.205.133.71])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f87d1a9bsm774491885a.30.2026.05.28.04.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 04:25:50 -0700 (PDT)
Message-ID: <ce9f76c7-7a19-48df-a5f9-675573570b50@oss.qualcomm.com>
Date: Thu, 28 May 2026 08:25:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: Update email addresses for Daniel Henrique
 Barboza
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260528083814.32795-1-philmd@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260528083814.32795-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LCuS_dSf_xXzInMR2ZQUALhS0ydL36sp
X-Proofpoint-GUID: LCuS_dSf_xXzInMR2ZQUALhS0ydL36sp
X-Authority-Analysis: v=2.4 cv=E/r9Y6dl c=1 sm=1 tr=0 ts=6a182640 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=K0g8RY0zJyQ20+JeH9dlRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8
 a=VnNF1IyMAAAA:8 a=1cGLs3X8AAAA:8 a=bDdBU3oEAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=TMBx9dqlAAAA:8 a=QktKnYkmAAAA:8 a=uCg3u4N1cdyLUkh_HYgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22 a=d8ghUycwObenwynNfMyN:22
 a=DN7SgORnOiO7RqxRx1GC:22 a=hD-SeztmQn9HBm-AZg8e:22 a=XkBopB_elf-j1KJO54R-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExNSBTYWx0ZWRfXyBHwYt8HcDq7
 4jXhqCmMvg4075xAVYOA6Ze7fv2sqCNtV83p/PvrKgx/0NZ8412jhox/k83GoRUVeyDPltDgWZQ
 qSE3MT7ZvOpB04s3b/igmKZqfaewCHVGaVx9J/TCBKvfqMRSDWclY/SbJS0O30551zmd1h2/q92
 gqzIhAHV6tZG9Z1hSaAZwpETpwbpLwsr7yO+1cLy2ooKOxq3/G4P5IMXa3aB1IK6F6JoYvtdhkn
 Ke96C7QyVPdx9Qn2w2iF8kf+kkGJ2f/ZIkuSg9S89UMqhVDidYVNODy7g7Y5KybJw+ccxfRCOYK
 Bgti8tf84XHHtEOs6Bn6RijgFaMGfKotLY6iRwQjE48OoPb6THFalPjbtn/ts2eBfIRa+73aWN1
 dhtC0/rBnpkTo+ZFtuNfjw0oksBzvFw/k2SwgGKYWqNJ7DWdZsxhzgzBxoo8soKavfiJDzspONu
 DcDSg48X3JLwWxUU3Yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280115
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/28/2026 5:38 AM, Philippe Mathieu-Daudé wrote:
> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> I suppose your gmail one could also go

Yeah, got a handful of patches on that one as well.

If you could add the entry for "danielhb413@gmail.com" in this patch
that would be great.


And also slap in a


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


And thanks for doing it!  I completely forgot about .mailmap ....

> ---
>   .mailmap | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 273661c758e..6335fbd6c84 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -82,6 +82,8 @@ Brian Cain <brian.cain@oss.qualcomm.com> <bcain@quicinc.com>
>   Brian Cain <brian.cain@oss.qualcomm.com> <quic_bcain@quicinc.com>
>   Christian Borntraeger <borntraeger@linux.ibm.com> <borntraeger@de.ibm.com>
>   Damien Hedde <damien.hedde@dahe.fr> <damien.hedde@greensocs.com>
> +Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> <dbarboza@ventanamicro.com>
> +Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> <danielhb@linux.vnet.ibm.com>
>   David Hildenbrand <david@kernel.org> <david@redhat.com>
>   Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
>   Frederic Konrad <konrad.frederic@yahoo.fr> <fred.konrad@greensocs.com>


