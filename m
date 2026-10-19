Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A80606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DBpLTwT5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VsY0cFTX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIv4S-0004Xn-L6; Mon, 19 Oct 2026 17:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv4Q-0004XR-NG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:39:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv4O-0007EV-Te
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:39:02 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZdm33389975
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CCloK9WniMhDNHAVu/zu2H1EgAqdWn0jTFa8auIqrYg=; b=DBpLTwT53SRsXM1M
 UG/eIdsK2KZPnX7nem28WI+BJgaF6DPnNWi/QEq+EC3yD4ttGlfI/QvTIdyFqBAH
 Q9T2ObfsUsB1CCnq3R96pY6WEcuzHuot6398Z8jAhdTpANBXqqDTTaWsqzSQIxEP
 bz/0J0tOoIMAHDpra4KhvUTvzy8pQCgbfBMJaZd/9m0LsvdB6EkViCSUDN7ohN0V
 poAft6N5mzlYtqd45LApmwMxu05W1ZLfhV9RPh3+At93W0jIhnF1OwCa89ZNaI5S
 eXEUA2xikdmmo2bl1lA14THyi/Nfk5hW12U0d4afV9Eyi+A3DhSVxBkzBSUy4PyP
 YvLLjA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q0qgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:38:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4946804eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445938; x=1793050738; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CCloK9WniMhDNHAVu/zu2H1EgAqdWn0jTFa8auIqrYg=;
 b=VsY0cFTXIgZWpGUgAfG8DJ3886RwSHanSGisqazMdQDq89hVdfypMmBK4FSW/yikGS
 eMqhIVopBhib65qSHlHPlJ1840+690gX7R4MF3q2WZcTumlq0jt+vx3lQ0Rt+JUUlzy2
 kkknWEUltkJ6x5EdqOdGwQo3Zpb1WJkO4G1Fpemi7oVJhEveGimk8c8RenGgrJlmL4x8
 0SE9BY5GjLe9uH4rXB7imd4IVBeFNv0aTSwm4Qmb/V5W3Rdxwxqc9d8+xQtP5axcntJX
 ivb/2GUfLw1jZTHL+uXtBiN8yo1Yhb0aACGhyTBOPR19Js4VvtZybIFjT5uf4jRJXnqW
 +xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445938; x=1793050738;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CCloK9WniMhDNHAVu/zu2H1EgAqdWn0jTFa8auIqrYg=;
 b=0qxBdrY08Jk+eoiZNzowoxxkk0dHFulz7Sd/3GO+UbgKGoZpk9MeX7YuVZ55XW7Cot
 pISyFo2n5cbWnYiHY9mrKimbQeQ5Ba7dcjsh/XDjsO/vMKmF1shlfm7xLd/n+lmzDt6L
 UkYKz6LMHeqcqYLwN9nyuUZx86OwwtPpT6hpJSP8vpscmOoaKjGYQ5iN/985zHRpX/ef
 sa5+beH9Yjklh3JUQ6GtOKd5dJEf0DxY036aL8LVPDesdbAGlZQ/Qoadm3GXbljlUu8H
 EH/dUBm8JIdoQMI1tJvOTXQtS6lTYGX0pMCa6xjPjZ7uZgoeabPx1OjmhPACxf17NjQu
 MjNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWmo5nTaPjsMMBW1XVfE/xbvopIl5ICa7vl5ZlPIqquSf+hL2/4nxvpsJM/bYouTbI/Q4+nCtHHiZ/@nongnu.org
X-Gm-Message-State: AFq9FYKXkQAY8B5ArHfyjrhWygdxeWFbrBQgZloHWAEonJUGybfapTvU
 frb63vaeoaycR2vZyVIk/TyhbSvrGa3lI3TmO+qetD3DjNOgcCMf/myS3D6JqDLa9xVredabKQv
 3THAnCcGsczk7MZeAfI3uf1WuGMJhc9udX0T1wwMg3xu5pjrHuChfHNEbEg==
X-Gm-Gg: AYBFou0rvFzhLKnv8b/i9QYyB0yThcBB9eK3GV8KlhiZ6vY7R+RiI4/tuI856WQaUw5
 t7jofZD/sI5BSXU1vPg/GmFYH6PSezYiggr1A87k7qTRRKJIYfeJpEum+wFHqhepsYiVP9GlTTH
 LrcGfpGDiovGH7t0cyEQWnLWc+3FIP1/0EaALC+idP+H9G8qq2QyLHDkhyUrFonok8wqV0Ygu9f
 jn/hX6/ithZcO2h2FQGGZGoIjJD6MbWU/8iHk+CY2cXavaIexNsF5GZyS/cCbyubgfAlsFDEiH+
 XzQseRFYlBGgwsARoi/Ir8+F9OY0cmqBYjpCqFetRQxlvVqXJV1K904OEHeheVm4i1cHZ0saMSh
 hhHM4KjLTb098dkzVZmeWWAJkh4L9cO16oon8qZRY9pZ4DN12xlqkvpQUiGjyxYDg+Et21Q==
X-Received: by 2002:a05:7301:4b0e:b0:360:ca2f:ce6f with SMTP id
 5a478bee46e88-3619ea236b5mr11837913eec.1.1792445938199; 
 Mon, 19 Oct 2026 14:38:58 -0700 (PDT)
X-Received: by 2002:a05:7301:4b0e:b0:360:ca2f:ce6f with SMTP id
 5a478bee46e88-3619ea236b5mr11837876eec.1.1792445937451; 
 Mon, 19 Oct 2026 14:38:57 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608258aa66sm43793763eec.20.2026.10.19.14.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:38:55 -0700 (PDT)
Message-ID: <c7bf80d2-889c-42e3-bb87-fcc4f974c324@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:38:54 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/hexagon: enable MTTCG for system emulation
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
 <20261019060911.1479329-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019060911.1479329-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -VtKkSqZXZv1R6lr-11o8EQaq7l9AcO9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX7sb+KbOHxD8A
 V4VnsOW9GvNv+VDrfNhv+BHtRCTwULmH2KsZbVACdGNfLd+FC4nH8tPwZIljHTXKUOiWOBQUYL2
 +c3snn2atl9sZFdRClS+vzM80G70gHM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX9gKdaJS4b+Op
 VAiVsHz+44asLsV9a5zH9kCZVaPVr7eyiG/fGmhy4eCaIh0K0Mo/hLKlOZxwT8SOAG5yNCPaeg9
 ZO5eCJw7zW413c0vDf1sYRie+M4T9I7JC1qp4YdorXbva1hJ5qZqieH5wOH7V+QBFsvAv7857Vp
 /3HcmkMuHF65pJL2Wi/fgZfVxBDeHzTcH7Q/oNY/E4Uos0VAslE0Rc/Wyp7LVfiAJ+CgevDo6IL
 Cr/P3YC/pDjsOAjYBWaZ/ETrC2Sljohp1NRiTa4zfdDcSgFarbdU1GeCDh4oOvbxggYNxoJ/VLC
 ALdsjOOun+bTL3gSm2MHWNOw/hRKdIYMtugllveTP1ZhHTkD6jQ3hJZ6dicmwuPt06MHpi4X585
 ZMA826WVukuLGfqZ+IMp8LOmqd3dKP0gtXHDMLqEJoYMLfNVgCOF+x2iu+fUQa7lkl2dyl46n4h
 WOo4uXjx1TQ83Od3i9A==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad68df3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=xD1In_5HaLDmBRXTTaEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: -VtKkSqZXZv1R6lr-11o8EQaq7l9AcO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/2026 11:09 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  configs/targets/hexagon-softmmu.mak | 1 +
>  target/hexagon/cpu.c                | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
> index 1ba6420d205..633b7b3f8b7 100644
> --- a/configs/targets/hexagon-softmmu.mak
> +++ b/configs/targets/hexagon-softmmu.mak
> @@ -8,3 +8,4 @@ TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
>  TARGET_NEED_FDT=y
>  CONFIG_SEMIHOSTING=y
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
> +TARGET_SUPPORTS_MTTCG=y

This one is not needed since introduction of TCGCPUOps.mttcg_supported:
https://gitlab.com/qemu-project/qemu/-/commit/a3d40b5effafdd299d1850f0c9956f60199b5b56

You can remove this makefile change.

> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 896d72825a6..0416c37515b 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -809,9 +809,8 @@ void hexagon_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>  #endif
>  
>  static const TCGCPUOps hexagon_tcg_ops = {
> -    /* MTTCG not yet supported: require strict ordering */
>      .guest_default_memory_order = TCG_MO_ALL,
> -    .mttcg_supported = false,
> +    .mttcg_supported = true,
>      .initialize = hexagon_translate_init,
>      .translate_code = hexagon_translate_code,
>      .get_tb_cpu_state = hexagon_get_tb_cpu_state,

For the rest,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


