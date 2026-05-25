Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA754CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX9f-0003iH-Lu; Mon, 25 May 2026 11:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRX9e-0003hJ-5j
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:23:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRX9c-0004ph-Cr
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:23:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PE5oBM2823029
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YiKqaiI/7X5Ux6G5O3Dn3rWqaQ1tbfmp3TDVYkQAvEM=; b=K8IVTyV52RSV3PqB
 33lmefljuk5Toe3/STg6acqBatHbAfgFTE7KLRr/7pBqD/+XAnZ+7jFdoo4mlF27
 H+WzYn5nd2w4FPmBEmucsCU5mvc8ven9LU1IrmSob9C7T3Bm8dsqIrHih/ZsC96P
 VxY7+n3hXs6mYIVgKw1auAlY67iE6YXNt78L0RZz7FT86+Qagj/LTE88N92dKA2E
 L1RKiO+0k9erEvRQ5A8eVLpNeQ7BkPX3WrjDvqUGXpkgtpyNRJCkR4gfcLOklpJH
 +H8VgbLj+y6tSRE1JJJTfPhFvi7a3llB0gBK7aGyHzS9Dr9THIVcOhIxwpvyUa9Z
 +qa6fQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqvwr81g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:23:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so15266937eec.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779722621; x=1780327421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YiKqaiI/7X5Ux6G5O3Dn3rWqaQ1tbfmp3TDVYkQAvEM=;
 b=ivanPA1cfxtSPlsV+2adaB6oBwFLUw6+yDknBPB5IV2V6RY7HWr+IZyW52BOx8bxQO
 g49+4HcStNBUiSOE3kAB0JDUKF+y6YNut+oDjSOof/obi4rRm943WEO4G/ubU72q2LtM
 v2Ndsz5FF3VxlAGAVHCgDek9Axi7WiB3bKNPXYNfgqWZnPJmln8C0HDVWSKD/4yV92nW
 jPJudjiS6UfW1PUtL+9vTRHjet92iV/AjInWYglM+NYeaypdmT+HHtUikZCRMcF8zib4
 v0LwB4Sp5TAK/iKU9o5CkrPNEFno6DdH2rvkVIyEstp+KQY11XHwyw1INt4y1C1Ru/uq
 hxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722621; x=1780327421;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YiKqaiI/7X5Ux6G5O3Dn3rWqaQ1tbfmp3TDVYkQAvEM=;
 b=j8PtJnE5HJBQ2SIcU7Gpo7r76E8d/tGDkpsWLk75PWHMDr7rgvydBWdA0AQhFD/xDW
 zK7GwH2vWLGt83oZcOb+Gdo7htHycliKtnVMW3kjDFCKkPwK3V4qRvW5/Z6v4I0enuSG
 7xOyuHuhWihD3ZoRscfYk7e1cegbprNAEc0aVkEXHTCfLp/8IbQPwo9DGpG70y5ujM7+
 IEFVKDGnURZAAQHIgOhdNs7gATxbq/SQicpwRqmgffF8sYX7wgIa5I1rEwfe0DqSM5cS
 ws70sAYhpkLKgSUjDZHn5Wi/5B0DcA6QP8ckg2v3hD1i6G4WENTct9+9iB3wei1y0ajW
 afFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KeeY1m6RZI3J/59+4EpTb+CFMqhhHciyh17vbaHfzu9FSK0H5FRxPL7T5TKYAkB9GtIBGJjyELb6y@nongnu.org
X-Gm-Message-State: AOJu0YxkB15cW7FoDaEKLgKdHaMK1jT9aGF3/RpH7OLDA/hvJbenkuh0
 yJK5iX3BLxLzAHJOhdJdYhhw2t6g2Lq/DMEgvb+K2F7Z/AXKh3Fw1jNEB2RG3tDZuMZIVJlyGmv
 wWtoEgC548IrArPX7GDLhhdFwSToR/5Mr0Le8pqo1QuB23KY4rG3JNavO2Q==
X-Gm-Gg: Acq92OEI3MoK1jCfcZag5KnvOwrU6NBBkH0CyqRQmrm0rCM9UdbWX/TGnIVFSlUXIgx
 CnocxbOcc79tooKrt62q4+3MpHu3D/4jwFyJNBK6zcum2Y71GSBtSSzQcdLiriEp3XACGdJR8x5
 +jxLYY+n0XabmdZwvCcF/2GzL85kL/4t4DuSQAbJ+LyZqvSZ02y4/NZlb9SM2jEu+HLQGxP3HoD
 Sv0vu3mIfgSCClZH+3q2KMra4zv4NGuN8PAsckF5FnyycFQ1d0tR3S8g5jYECUZrleyrTmIMCnx
 HabxhJSlq+dwdBzHoq/gYbs8MSgcEuIGZV3y/EmZmuFNtkdn3TuvB9ArdWlKmWw4d7lfyLPGiwc
 v1olyvjulWFxrzhZq2+SNgcOkF9pngr8XYccrbHmLdYKgMFcaL3Dtd3g2nwkEyv2ZZYtOznTBTR
 T8z9gYHsaEqhlRow==
X-Received: by 2002:a05:7300:cac8:b0:2f3:5266:fdfc with SMTP id
 5a478bee46e88-3044924e434mr6906203eec.33.1779722620917; 
 Mon, 25 May 2026 08:23:40 -0700 (PDT)
X-Received: by 2002:a05:7300:cac8:b0:2f3:5266:fdfc with SMTP id
 5a478bee46e88-3044924e434mr6906177eec.33.1779722620272; 
 Mon, 25 May 2026 08:23:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef4719sm8028245eec.1.2026.05.25.08.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 08:23:39 -0700 (PDT)
Message-ID: <14ee7876-9f44-4ad4-95d9-a03516519647@oss.qualcomm.com>
Date: Mon, 25 May 2026 08:23:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Fix typo (s/exist paths/exit paths/)
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260520-exist-v1-1-535f929a87ae@9elements.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260520-exist-v1-1-535f929a87ae@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iDdUms9BLM-pSGuApp_vC-bhJHzCa30f
X-Proofpoint-GUID: iDdUms9BLM-pSGuApp_vC-bhJHzCa30f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE1NiBTYWx0ZWRfX/p9HUAlyE1Mk
 IUPmFZNEUkz/mBLiVSpOCNKX61STCDj7XxzFt+41MwSZv297+GrHy95jvmBdshAMDy7aAZLIwpo
 Kl4BG1OWuug2+pLSIhde5kBwEK+V+YxqphgVZ9MCblHF9WqJ6iaH5Ljm36ztrkiwJJNZSOUg7Qm
 iDvlHRhU30Ins6Mw64bdyBwLYGAidLzIMnse8byV0camL94RpRq9N97L1BCzuT/iYyiFjOYvQNQ
 mS/sR3u5i7ybCjGChM7BZfMI6XXPFC5X8V22UgChZeF5Sy69+xzyilDNPtmjIPYnLu+ATgudsA2
 Fklkjh0P9OyruZ6180z+lpUf5gzYcjihlygYEJ22/ilv15jGpsOmZQ2ER22R13c3LGX5S6W1Iyv
 vxwKnoy5bOvzR20E2PNSNdGfvkA4tdX2HSnQT3EVtrD8/FDg+rjRZQ9Yqy7B3v2jtuSV/4yTLJx
 9lRY6u8m6Gxc3aytOyw==
X-Authority-Analysis: v=2.4 cv=M4l97Sws c=1 sm=1 tr=0 ts=6a14697d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=PzGKxP3WAAAA:8 a=gXoBCMzGXRRVMpZuEKkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250156
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

On 5/19/2026 11:44 PM, J. Neuschäfer wrote:
> In the discussion of control flow through a function, "exit paths" were meant.
> 
> Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
> ---
>  docs/devel/style.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index b8edcf9316f059fe15415543098118b28fcaf99c..f4da16a0e83ca6fed205e2516fff4ac2cc941d04 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -469,7 +469,7 @@ for a time/space trade-off like ``tlb_mmu_resize_locked`` in the
>  SoftMMU TLB code.
>  
>  If the lifetime of the allocation is within the function and there are
> -multiple exist paths you can also improve the readability of the code
> +multiple exit paths you can also improve the readability of the code
>  by using ``g_autofree`` and related annotations. See :ref:`autofree-ref`
>  for more details.
>  
> 
> ---
> base-commit: 6d17fd91f6cf88df5cb2205e578640d72605cc43
> change-id: 20260520-exist-b23e143e9bfe
> 
> Best regards,

This was merged into master (cbf877d67a812be17a9ce404a589e1bdf722c1f6).
Thank you for your contribution!

Regards,
Pierrick

