Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607D3CDE009
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcpue-0004Qe-NR; Thu, 25 Jun 2026 15:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcpuc-0004QV-QY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:38:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcpua-0002Od-Vo
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:38:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFe5NL2161732
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 19:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +JQYEF0aGyKy+CM2OteYhqx5HBRms9/kJBmLEu7pxug=; b=eoCReN0QyY7YKebn
 4hzoaCTPjrb9R8fObAdd9OiXvU1kWU+2qJt+WmWwbPfDwFDCIN2cEc0jzUjzGhdW
 hOQth0/CkEhsOZ0Je9qDsvvndIlnDSH5EE/wMCjze78W5A267le9NjL2z3nFz+us
 YA6NDZNxaQfOt5swzv8TiC8OqQioJD1W4bwuCnVJF9y+o8QK7bPYSaGN5q2X+Skm
 LDmf7nCNSqba5zlABW5C78XlYAM3fE362Mj+9cFTa7206J+XYkNdrV+gB0goaZjr
 uZVUPf8h6IU17DqYtfEC4N9PcWOY80bhCanLRHBFwzneAtL+dsTGBaq4cT8uRzOD
 MVeypQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ymv2yve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 19:38:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c17bc96afso650145eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782416332; x=1783021132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JQYEF0aGyKy+CM2OteYhqx5HBRms9/kJBmLEu7pxug=;
 b=F4r+BwluYyqRcidlUzbkSbmfzI97GMYqWpg1UOfyD/ZEBPRC/NODQKiN2jp6jyaSRN
 5cYc6YqeAcQFA5irn8BYNZpgQ5a/WIfIDwKsmTZumUNTDtGC3yDsRMRqZ4Fqo5jGkLOa
 8f/r3JFO9g8bGjIIDKeJwxRhoqyEO7JDkrOI94ucSvHy66WjiDK1OXKbYAw9b1VSOPj6
 Cj0pUk3Y6ZLLhcskp0DCtmRPYcHIYFpuqsEhQV2SZ+7v7wL+8vvg/WqgnNCCxmDDEP1v
 xKtpzalmN/V2OauJPw2Xv3kTwAhTomEt7t5+6l8O551m4jGkyC502UFzjejrY2jPxM4J
 HXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782416332; x=1783021132;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+JQYEF0aGyKy+CM2OteYhqx5HBRms9/kJBmLEu7pxug=;
 b=Dh2v3+/8rJuS4gSEKIMM6OgUGxRJE2/Kz5ItP+GhOOfL7xIrnXRTejkHjgzFnhcqoD
 znpmxim6oI/Zbe9u57t9JOZuyslYVGBtqzt7opMbc6kU6YmMv6gJ/AqZfNQAZlkgt43H
 EGVY9DO6J+xBhXWh4QqaQ1SXR6FhKjkL9xQYm0Lx522PIHm9WaodYrUlPO+9Y0StQInN
 35CK3RzHVMPnEbg7Ythcu848kpAsi0kMcvRVENDO6PNR7JPATSghLiLVPY39z/LGLO5x
 OZkGpPJ6zswnWjTs/CSBPZWJRZI8B/DPlSyFwAKXKC2EXrnSxPAUIyztpAeLveHzr1rp
 lLww==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkpzdM9U2wgAISkCdaAWh++0UaDjKEhj+pIIC9wiyAdb0jvkfyRNSuBdRBtFeOvPU8qDLZFT/U8Zz9@nongnu.org
X-Gm-Message-State: AOJu0Yy5H1eKq1ZBhkZBfSD+1f1iAtrQnLYrDxoJAlXboUOVCKHtRGea
 kOmS/q+E7Ake/RHou+qPWpnJ29M67FuX+UzYWNUB2Tf1Yql4tIQ/SZqrjIj/3qhFzjYDdY6/9ec
 OZenvSCP6u99zdZp53pSozyF6sTZUfhgA/LB6MRcq3xl73IMa00zoRW5p5A==
X-Gm-Gg: AfdE7cmig5Qo2sYCw1jU/yq8f+A+6vG54kb3wJ/0yMrpJKeqHmTYnitpy19Ac2uCtUg
 aGJD9Cqxb0M6/z9hHGr4+yEG4RVszRrUN7AXhIUaGbtGDMBaf8olMSXJ5P+zJ3md+rJpPN4yykO
 to8mf8wH5LWcc6lurEiNavj7ztNtwgB55QE5sAY5XIPgRhDNm5pZfFDJXLkeH35/jZ8qo1RKBGe
 xpUvEcLKWPQjQ0x4cQr1SKXAgb14Lu0mak8WATTO2BuYnfo9BVah2xVkm3YqL5NeloE2E5lqixs
 PL0kZlrvCIGUPpn8NKF08GE7Lud/3v2QxRrcURgKfb4iMcuJMC8RZu2fgw1WZE9HlJCh5+VTUNR
 j/qWoI12fPzmNITTxPuprXEiHCEApDgaAzOI6JV6XEGRrpykhh9CIwxt0653dFHalZOJO2C3sUD
 NBiCc=
X-Received: by 2002:a05:7300:2146:b0:2f2:8857:17f6 with SMTP id
 5a478bee46e88-30c84b6cffdmr4501086eec.4.1782416331927; 
 Thu, 25 Jun 2026 12:38:51 -0700 (PDT)
X-Received: by 2002:a05:7300:2146:b0:2f2:8857:17f6 with SMTP id
 5a478bee46e88-30c84b6cffdmr4501048eec.4.1782416331394; 
 Thu, 25 Jun 2026 12:38:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cac87dcsm12274697eec.31.2026.06.25.12.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 12:38:50 -0700 (PDT)
Message-ID: <c7d5dbd0-f140-4eb7-bd86-21eecf8d1597@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 12:38:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: bump emsdk-wasm64-cross zlib version to
 1.3.2
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260625193320.260312-1-stefanha@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260625193320.260312-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DqBmPm/+ c=1 sm=1 tr=0 ts=6a3d83cc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=fXms6y0vAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=vpyjAW9b8HGVlQNqSUoA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=c6Zb8eaUoX5VaqycxFvw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE2OSBTYWx0ZWRfX0gzRUeD1sxCq
 Yw0RR/5EEp38+lfu4/NYSjHFdK7KE8gZjCYHpfhi3eRHzMtQUF9fgG9bLgRqxNWtq7iB52RyOui
 w+0hTPQvbNra135wY/GqyhYbkxlUcSI=
X-Proofpoint-ORIG-GUID: y9ReYuqGedEp1utuIce6BLRkSUgrOGvR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE2OSBTYWx0ZWRfX5ZjajTmA6iKO
 j2DduiYcLiE8UaE5Js/FRKeUO2mi5eINiWG2CT8nn6YZjMzAnXO6t0+ETamDmaTXBDnNO1ndibF
 7XjgwMxDyzYg/f/jACaNpgeSiDfPlzZNxjZIOErAzhREHLlONmZs2gqHtct99w3jPL/EN4nfYH2
 eBovBXm480o39FtnpLUq4cOOh28Dxi9XD0bsdTnuycwZHv3iFXIasBmZpTmgIYddSU/FOn+tCM6
 RCh1CFLaU2u8LkDTfZ1kunpdBj6MfL41GgXlzW5nOGkZqe+MqoUdc2/kxjRAcAKY3zvXpx4ifSg
 pQOfs42W0nl0YjAcIufNMm/4JQJlBLEvpuwzcyffyTD47OqWnOmp3OBRGlAIKhc7bzunr4/yjpR
 Z4F7bAZFA4ngXolIARSpuWz5/FrMezyQ4Rwayb9w54MokC2jxZDRYXgVbkM4Ia6kBXXc8IvTkHY
 +RjtdxmL2mPh2Cn8RIQ==
X-Proofpoint-GUID: y9ReYuqGedEp1utuIce6BLRkSUgrOGvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250169
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/25/2026 12:33 PM, Stefan Hajnoczi wrote:
> Container image builds have started failing because zlib.net no longer
> hosts the 1.3.1 tarball. Move to the 1.3.2 release from February 17,
> 2026.
> 
>   $ make docker-image-emsdk-wasm64-cross
>   changing dir to build for make "docker-image-emsdk-wasm64-cross"...
>   make[1]: Entering directory 'qemu/build'
>     BUILD   emsdk-wasm64-cross
>   ...
>   xz: (stdin): File format not recognized
>   tar: Child returned status 1
>   tar: Error is not recoverable: exiting now
>   Error: building at STEP "RUN curl -Ls https://zlib.net/zlib-$ZLIB_VERSION.tar.xz |     tar xJC /zlib --strip-components=1": while running runtime: exit status 2
>   make[1]: *** [qemu/tests/docker/Makefile.include:43: docker-image-emsdk-wasm64-cross] Error 2
>   make[1]: Leaving directory 'qemu/build'
>   make: *** [GNUmakefile:6: build] Error 2
> 
> Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Cc: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Feel free to pull this asap.

Regards,
Pierrick

