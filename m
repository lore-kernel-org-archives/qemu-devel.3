Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0894CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU7zY-0003ZI-HF; Mon, 01 Jun 2026 15:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU7zW-0003Z3-Ku
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:08:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU7zV-0001nA-6H
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:08:02 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651FEJdF145128
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 19:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y1vbuQHOKI7SG7FbedF09b1ubs+hOO1SM2Qkn96RJD4=; b=H5JazcVbjHAfHBlZ
 fPsPPLuVyO/tgitbcSjyCd0vrgc7fxoUxSKiBnKsJN3kR75GVuc+pneSBvcrodWB
 Tp96eIR7hf87j1sHojw5e1HnOAqTWZqTdg6m1M/Nn/hDLFA4POGPzJqfzR9ZjH/d
 4sOQTTq7vF2UtC1oUrbX1J6cvA0yqjRtD8tF/45FgDi9JvX7aoNS3omz4QBWoKol
 q/2q6cjIsg8Aopdb/yqjBJk5CBN4phjHGyd3Dyhdfwcw54vM0y605qaHC33cm/9/
 n0cEvb4xZxLbnnLClgqipS9R3khnXkxdo8OB8Nv9/HiV5tLEo8cdfappMyq0AAh2
 ogLt6w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sttk9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 19:07:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f1820babso4242310eec.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780340878; x=1780945678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y1vbuQHOKI7SG7FbedF09b1ubs+hOO1SM2Qkn96RJD4=;
 b=Dwa7JdodcU/LLgLW5IQIy87tCgOzs7SYm80SV8bS3/j4J/WTkRSPfnjvSdRUJl785E
 TWEHodlcsCEaYZl+eyQxf+zpXGpudHmzjqoYlMFs9TvlcY4U/6FGj2i25LmSC+I0OPN3
 r/4FLfklLgSdH9jzckIzyD3uBxD0pvHk2CbSPGGqc5sNw7L7e6u8B6hm58Fka5Ou2pKZ
 euLdhWycxOvwL0uvDV7inAAuew/LtOCXIUfWJ+3uVDh9xqqJXrR67BHDnRtXGwHRfYva
 aZSSYIVMITW+34Var2JzlNSSvMXUHHeIPdaIiomQszgQ8gZqQr9Wk0JRx257AY9epBc2
 mxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780340878; x=1780945678;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y1vbuQHOKI7SG7FbedF09b1ubs+hOO1SM2Qkn96RJD4=;
 b=a4DlIHlrFu5VNuXAtNY+IlOr/gq2mUjnADGJ+eQxyx14lXYTzBkkL6j+Jvdo+6ljJ2
 NqZqXyh1sseHD3UWFp8iYSg44TGvEqrb2CT0obEigO86EzkvzvcMOkrtO7fNJ2HFwmXq
 prmdWl1pRl6KGUylImKY0Lj+whgZDX9CkH1E/+lVTRJ/Rszj2pHWFJ16yDuSvosxo/zz
 q4i4t16kxz5e8PgU6qQ+BhUH4P+2EbYG/ldMVsTwnXgouhgWay2+fDxVT2vRWkkOgMq4
 nUd3wGT/XlOvpgSwSTtWinW89Ips9Dg4NgxXhOoLybkU/gaeliHEf0CyP5gAwH0hzSSR
 Qjhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Xwk90X1PcsDYKoZnWTDUvOwqItNqokj3a08kWLVuV5/OQGMCH4svC9MqiXjBC/hy3KpYqPKGvafp7@nongnu.org
X-Gm-Message-State: AOJu0YzKHQzXONhE30m+1BqL5jIjFpfRgHWP21CA1wNgKPyN3n0Npq+T
 wK40TfVIDmkESyfaj4Zn0Bf+6qzwksrTznoCaQpNZGwA8LHRyBpX27CRaEKTkcrpKjIuMbjgNc9
 3InF3lgcigcuz8eaZLuUmlyO9bA+GYsMH67HPQyxyrNvgEyTZnRH+GULKrg==
X-Gm-Gg: Acq92OG1ZDTmh+VHhNU+3u5X7MT4vkY0WqNEa1w4cJq6PnGVq2Tv4K8icuIdjPy1uaN
 T3O2W1Ks8cyCxQe4BHZiURMLuRfMJ7LqmnRZuByKz5pPinnIUfPmpE47zXY6sFIaZfCm8bF4PYC
 gsjLyWTRxl3ZWsQXWhhM4p5X62bqkZ+QsNvs8E+KRkIfMTxB97/COOfNiKJnU9KwWWHIQJR4VuJ
 A9rTgZun45tjTUgLCrAZTCzCr6BUBFdqzC3blITZm6qgTcLYlPYHGG6O65FgY/0EZ9B4WdOCJtE
 gD2/avrFlW4FrxlFI13fGDCLVeMhCXL90ItXW+KZsWXA7qQDzWHwLuwAo8HktMAxgIVIJ7iZ9i7
 BZqZRziV9r7RRQZZzHIlGqDAcUdOYdoHz1UfW8iOeKc4bPHDgVUSZuGmQOXi6AHjk02QMeqvZya
 cH0Lufq4duRuSqVdLZ2jQFWr2S
X-Received: by 2002:a05:7300:6c84:b0:2ea:ed70:3ea8 with SMTP id
 5a478bee46e88-304fa6939demr6003425eec.29.1780340877472; 
 Mon, 01 Jun 2026 12:07:57 -0700 (PDT)
X-Received: by 2002:a05:7300:6c84:b0:2ea:ed70:3ea8 with SMTP id
 5a478bee46e88-304fa6939demr6003401eec.29.1780340876944; 
 Mon, 01 Jun 2026 12:07:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed53d06asm10209822eec.14.2026.06.01.12.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 12:07:56 -0700 (PDT)
Message-ID: <fdd815fc-fa56-46d0-b797-9350e7be212e@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 12:07:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 35/38] target/hexagon: Define MMU_INDEX TB_FLAGS field
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-36-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529215554.606133-36-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE4NyBTYWx0ZWRfX1ysjTQbXjM+V
 KOfFlGMo73mJWCiIJtjK4D7w1wDj29FXb6r/c5H2BSyCgggib3R1QigKmwVZNcz+LSWlaw0P0nv
 YWLBdJmO4Spg6hgVgPm1O4reT+gctkegGOl7/4ixDn20zh0Spbqh0rKHrpimlRHZ5svlPaFRhMi
 9N3+EMHSVx8agt7eY8uejgeDskI+IHX3d1BwKRBeZ5ZfzYdhWe3mUD+K+K0t+kIr39A6rsgBNDJ
 C1K10yLaCW88wl4UMujnUuoiSnkMKlbRP8K+xQBT5nHob1Fq++lFc1vD2Bn7JsawyzPD/BZGaxe
 UEZNaAPgnEPfXfAn9rCC7bZuEd7zSuef57qGzJ+aAwslyqrNHevsbHkmG0YpQ3UO/qb3+5pvu39
 f27jJ3BsMNV211zGS9Fd2hEWhZxQngoHHnFoCUXof9csxyrUpcQ9TXnhUI6syyeiim8/CnfMgsc
 95mxx5XIDA0SXDpYbGA==
X-Proofpoint-ORIG-GUID: IYPCfNgnfno_3I5AaIEqJTBlyPQEqTZs
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1dd88e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QYv2NUX2lCEnOMxcyc0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: IYPCfNgnfno_3I5AaIEqJTBlyPQEqTZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010187
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/29/2026 2:55 PM, Brian Cain wrote:
> Declare the MMU_INDEX field in TB_FLAGS and use it to extract
> the mmu index in translate.c initialization.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h       | 1 +
>  target/hexagon/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

