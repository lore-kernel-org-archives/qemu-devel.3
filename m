Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C444C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 18:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlsO4-0007Ot-7R; Mon, 20 Jul 2026 14:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlsN7-0006oz-B3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:05:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlsN5-0006DP-QN
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:05:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KHCLhR3088259
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 18:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JENTQiWoax9s278Q0MxnMEt1UbxVdOvMzI7JWSOcJL4=; b=ma6ytE7x6PBfBEQz
 bxt/KV5TvMVuAQoHm2gvxM+9U3Uwqqa4ld4D4puX3b1h3J5sc7OfWIXwKkvRx5N+
 6cpSu/P/FRaY6D3sFfXCPXsDmNWnVFa2CZ64zO5/dPe5iZDHBPUQ/MG2BsYwo5n4
 crqA/6JZtD5A5hzn7D5adLWrtxYfiee8d/K1A7xemln9Py2axGPK7N6Bh/4Y2zI/
 xUo1akYZYhFtYxl0B5w7akaWc6v5ZaPGoutFZCvrsyEfrhHyaJg64RXTzGnvnzYJ
 jIx8YRrYJb1NEUpjSdUEUbgzZ2u9oNa7/sAHtw6jeYcA6rZZEoppHGYWjf1HrxQQ
 rAtIUA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqvc87j5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 18:05:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb5ea36f969so3191299a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784570741; x=1785175541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JENTQiWoax9s278Q0MxnMEt1UbxVdOvMzI7JWSOcJL4=;
 b=jRgd8djFLcQKvqU77sXzKlG8Rs8J12OjG+ZSLSVMVZksWHzwEcFQxHEdDjIIUk8slP
 qt70xHe6kGlgeQ2l5o1bWU6Fp8J2SASb/WDBgFU4EmxRnd/eSQ+0rZe7oioLO2ymLAoi
 pbf/2lyZwtcHFylzkZRkib5pZ9rLZXCvokTxql7pJcxu3gfgxY/H+01UFdn9i+aQW7BW
 RIiMSb53lF4lDSbmmc67yVU/qTG9ktGBRPqTfNss/qZhMZWpzdjU0EVg+LcUaFPJSixr
 vNHg/qMLpj77hgvnRMU1dkDoTS2tjPkrij1YsuQYrdGdzFp5vWKzLrXXXKo+mBYc3bey
 sDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570741; x=1785175541;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JENTQiWoax9s278Q0MxnMEt1UbxVdOvMzI7JWSOcJL4=;
 b=M7ErEygLdHB1YQ1aYddZajwa17vew8IF7nQbf1V8JRcezADAXgGpz1jeUPOUCDHOCc
 FEf9oKKymw75E8HhaPhLdJNV+uoxAtf6y9RrVIPu9WUciQoyPL/5ZAJTbjv2Q51DPvjz
 3UQLmYHtjp9SIgIeDMvQxI4RckXtRd4QEGxEI6vUJd3nje8CASOtRs4MwnNTlyprWWCS
 83ayo2oez2btKgHAzyrkzPFurVd/j7vxY4bdiTi7pcN1uhh1A2n96eqJzP8oCTDxuKUX
 R/AWsQOEfISh1BOMDnqd7eqD9XH1M1kMmhK5V9lnYeycPX710ojwiD207gpWyZ1n7vQE
 B0+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RptVp3+jGDsbJ1hRUxJ1WX5WOJaicpr45hFJdBP/ZR337I6TDKr4dVhiz2RYBAoXsLPiqGScLQM3WQM@nongnu.org
X-Gm-Message-State: AOJu0YxwrNn4yGCqXRUddGUwsiL8qSjZR1IcGHsITcuVEhN7bxVx//fW
 s3zUU+w4Q7G6+hc3JU9Y72W/fzg3ZJB2C/3JUkGyCui29/ujV0/L1OCPvro1fWHzdRFOYVcVzlU
 V2RExj1bAmelxv36R8lMhV+kjPUeusDIrcyyqkq8aCJbTbuwyD/mOV/RQlw==
X-Gm-Gg: AfdE7clmqw2tVn1AC66sZd98JU+rm/v5gpSYZVjgeaotmg0KmlcAQFRQw1R8ogfJr1d
 1LhanPZKuJTgB2nHnsXQQonvGc7xVZKmsKzKrryuZAVpa5oDyYHeIMmT0Jg15ts50APULKZsiY9
 LGmr9cNnEB2d+CoBrd1ZwDqXT9H1CsZjJ4NOmbUREdi2o9M+aCMFXellrhNp4FRpUycOGe87hKa
 44/HrENmlC56V9/uACJ7SyJvSGwDD/jEnNKmGZiISDStovHwRZ/xRND6qSbw8utQnhoxfKxCX2X
 DkFJ6d9zImKcLxknrEUglnjZ8h6QM9IlMwmms/Mid0o80VpeYdg3Y9EotrQxg6jtUlwlPHt7XCI
 Htn0lKdzyHYapULrUpEXdkBvvQFQb+HOwdfUrLFjy3qG7JhpHlTZ94nAZqmiGeEbIYScF
X-Received: by 2002:a05:6a21:d8c:b0:3c3:9c95:c0f1 with SMTP id
 adf61e73a8af0-3c3ad8ecbe0mr17383217637.41.1784570741367; 
 Mon, 20 Jul 2026 11:05:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:d8c:b0:3c3:9c95:c0f1 with SMTP id
 adf61e73a8af0-3c3ad8ecbe0mr17383174637.41.1784570740861; 
 Mon, 20 Jul 2026 11:05:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429fe4677sm35367051eec.11.2026.07.20.11.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 11:05:40 -0700 (PDT)
Message-ID: <0ed56a66-1301-4a80-8938-55e932535a8c@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:05:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gitlab: remove gdb from MacOS jobs
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260720180459.2542918-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260720180459.2542918-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5NiBTYWx0ZWRfX4B5Er01ha8RL
 72nvcGCwswv/GJ7Sqmsyq8E4inQ5N5vA0CCxug71kIKzHjXuo2RtvIFVti/THG6/2WfNVvquZPm
 CC+mE2/nZVDv++Znxll8+ohj/oybXrc=
X-Proofpoint-GUID: _uPGV7gljLWP4BmNv_DV0qKe4v-hRinG
X-Authority-Analysis: v=2.4 cv=OMYXGyaB c=1 sm=1 tr=0 ts=6a5e6376 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kSw_Oucy0xvbQDTHRSoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _uPGV7gljLWP4BmNv_DV0qKe4v-hRinG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5NiBTYWx0ZWRfX3ud2IYe+Jj2r
 b0AP17nQmA2VOKqbMusHDbdPweROE6xnD6+JdjqW9gS+Z6WSobl9fKpo0GZxdmSvhA1PSRBDB5u
 eIfdMfPDfpuLsqSna8N7pPM6d/o2+nJOnALz1zyns0HiWTNw2Nk2TpTXnkP7AhenYKpQEPFngDj
 fyRj4yWDaOJGvv15VaApdMOtZQuCr+I7QSef21iCEkQymm3XOKLMMxKCtCc1Ot2qmf5xiLCQqds
 25qx3AYqNz8NpAJ15nrYsRvNEM9J9X78epxOS14cFRoGSm2xgoElkysttzTKO4brknzhPQUwaPX
 TtLuNGxR1se5XevebAsNJ/8/ezmPeCQd58m2WuLftQnL/CQd9L3/HesmoA5KUaEAsqqB980OQd1
 b/jqtcs1z8cus7vHkkbWD2FjTDIna+HRzULYOCog7mzqFM+eYksWDSuwNBPXYL/lmyLMX+iHI8q
 +w5zN2d+lNXfxYePAwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200196
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/20/2026 11:04 AM, Alex Bennée wrote:
> The gdb jobs fail on CI and although I can't replicate locally on the
> machine I have access to it definitely fixes it for the gitlab CI
> machines.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - better commit message.
> ---
>  .gitlab-ci.d/macos.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

