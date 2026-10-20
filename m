Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095AD606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ncgTiY6r;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e/nfdf9L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJEyP-0005kx-EV; Tue, 20 Oct 2026 14:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJEyN-0005kc-MN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 14:54:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJEyL-0004qE-Jv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 14:54:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGu0NW1198916
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TcvFQvE0mbHPQHVX8n2wXYQxGkvYy9+Mr2Q4lO1HcDk=; b=ncgTiY6rmc0O2001
 kmNHmmh7n4fp/AbhVXTMaedOHmanCBlN0wyTKb/KLgfyg22GdDbdKWkfUVivtopz
 OScfWaJLvb3tj3hJNyDeQw90lUhtePz+of3kRfMsOtAqtz5ucwTLdy/MMBF5wmnA
 FSU0IwJzy3y3q0nxID9nEmlh6sffcSLS3tVqGBuYMzLNs6LX84Ak3CgTy86owVOR
 paqEf6N9xud8y30qOWhwKFZLsBvu4r29ltYtX/QI0yrr9fcOFLCILT9+PYzCBnO3
 F2qnZ4EZ9TmAf1K7CCmWgLdjUYmpz2Jnuo5H7wbV1XA5O1VVmV2xwXu1ZWWKMpzs
 ZRtejg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5sv04m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:54:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so6170971eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792522442; x=1793127242; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TcvFQvE0mbHPQHVX8n2wXYQxGkvYy9+Mr2Q4lO1HcDk=;
 b=e/nfdf9La1+ScCXQtWqdI6j0xKULI6NX9lI5ZTTttmkldL3AAkKDzjkIlD08n/nQ/f
 bJtRuhw50T+MNJLUpf0JIu3aBSmgUio/ZODJtEEp90MJ0J+Dgsx6VVZlk3ofZjvXX5z4
 u2m2dBrbG3KPeJzHaMg7FHKWhLKPqAXFkbF2spPGzVia6s1SoIegXbT5yR5ZaJmuYgS9
 Bt9NJqzuRj7Hka97xc9X4ffHqkUcktnqp3jXV3U09rcHcr5/Qps2wTyxiJSXiFL4U5Xr
 m/nEbUlmx2pY5DbVFdoSg8WYCvAs+WIVQMqSgedOoUoCC39uaOkFRR5m98d5Heu3Uwgs
 Y7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792522442; x=1793127242;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TcvFQvE0mbHPQHVX8n2wXYQxGkvYy9+Mr2Q4lO1HcDk=;
 b=A4mXt07VUUrb6zkFggOuUozYYhvILUR1RpduimXcodTpQBa6GtrYR9INSJLHIx7u0O
 TZZ7POsBnh6AStyzYHEXIiiP7cxN6Zj1bGMvw8EWclDa/zfYKHcMBKoHHr9UoFrD0BAi
 wNJczZa/jKfnQG3MQAbriK6PAAqsY0if4sMhtdXL0akv6OKWXJnEASj3P1CD0BoVifJB
 W98xrSBlDArmN9e/8k2Z6wNRwjiK3G7pBFWPWEdkhdTTJnx0fYZjUTS5qjw/6TAhoX98
 LFqKPZ4W0c+DVxDXGy3PQcb0/Zl/tmNzi/xe39ZFF+Gvhx+RKHsbRe41pOqu4UxF/YPQ
 MV/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/giwhf7U0hO4mahsjXZYPWTTm/7OYAyg7Pnmx55qy5vmru7PI9sgTqoujQnwhn4yYIjEp53yX9PVj@nongnu.org
X-Gm-Message-State: AFq9FYLlfMV1U3dbId8A8Kf7Ozt5sdHnTZGZqiDwDVauDqL4PaJy722x
 jX6cisDRn6wsRlsgzXPu+poRoUnM3hKPGtxyWmlKtC2sGOHHvNn+/l56vAgU8/yg67hrSi03Ofn
 90YPhnLut0N57cCa/viFigagl4bqqCmnnnKN1scz0L/psKhOHUN64V63a0A==
X-Gm-Gg: AYBFou0VyzRTIokVPgsVgAxWi0LaSwDIr2RK8b3EPEURds93gLBpECGmIOohWLYvRYS
 VrRflMuTpHcNUQFCtAWjNuXPpxr1UqVlcAzw25weTI5JcqYdNSk3/4pITXeNVRw/Mx42umUDVF7
 XOutvH/hWO1alVneiaH1KBCAwGZFpeLap5/6e5YwF2H4ayvOL0WMhi5jQjcTh+egl4a5GYBJef5
 VRJsU2Zfu+/loYXs7NNUQs/k7LhLPMf+WKpY/a4BeWMWvqR+PbeJg8GqYk+T/JYn6IJ7o4MsM0k
 hTuXoPPs9pSWdr1uVhbaIFB+u8UEgcJzX5GKEsx2MWvvzGviA3lt78K5xaWL+OlRsEDPfAsnH0W
 sQVXfvYcTc55FCJKsjJj4NWMbfmgRgfNBmQb5MVDq8JO/5ma9kkTG6oaaxxhIXQaI/Vtksg==
X-Received: by 2002:a05:7022:7f01:b0:178:d38c:eafa with SMTP id
 a92af1059eb24-18512579328mr15231092c88.21.1792522441845; 
 Tue, 20 Oct 2026 11:54:01 -0700 (PDT)
X-Received: by 2002:a05:7022:7f01:b0:178:d38c:eafa with SMTP id
 a92af1059eb24-18512579328mr15231058c88.21.1792522441180; 
 Tue, 20 Oct 2026 11:54:01 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903cce5accsm602204c88.18.2026.10.20.11.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 11:54:00 -0700 (PDT)
Message-ID: <a1ade3ba-c490-4f39-afe1-8197b0e304e1@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 11:53:59 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] target/hexagon: avoid negative slot shift
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20261020151720.728888-1-brian.cain@oss.qualcomm.com>
 <20261020151720.728888-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261020151720.728888-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NSBTYWx0ZWRfX+XpS10d/M3my
 7XoCjlmo66MWXzA5vYcJpdNhY+nAA62NOz3PxYShiD0Lwk2WMEgpPTVIQWqXTGY6pzyPtzqcTZo
 Mgk2IstB3YfmTjABtqINe4ex4VOY0TNXH1g9GCFjYesGLpwTz8YA2ZQ0nCLnTCmIexlLNcW/be4
 Y2FTcK1EdZ5WXW/nt9/zmQ2gNla4vw+Ds07ewojDiel/Xjrzgqhdg9Vo1b1jn8QiKY5h1h5FP0r
 QeDxd3E7gwfoznvQPaqJzGnXeGP8MIzm+bfTZ+uK/yK26lSj/vcGZfpNkSLnOtQt6WGofRYNz8k
 2BS470BnF0tZYfftApsjKzF1b1D8ujGXFTThuFT8qwKOr2X0l7FjilySSO+zeZunvUGdqhR99Q5
 4o28hePGNIwnHQeWlR30iLha06vyK/OdHYB7RUEXjJ5X7b0bC+wx6ieEHl5xhZJ5TyqHQ+xmjgR
 QWfJfM1FybHe9wpdHHQ==
X-Authority-Analysis: v=2.4 cv=fIusTpae c=1 sm=1 tr=0 ts=6ad7b8ca cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=lY_foJfWuXWTEGQqE5wA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: xCjOt7PNJuruF8L-HxCoFPyfIiQtPAoq
X-Proofpoint-ORIG-GUID: xCjOt7PNJuruF8L-HxCoFPyfIiQtPAoq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NSBTYWx0ZWRfX7yvvQkTbw854
 EAT5BMwRAVNjxjnW4LM794e6NzgrVWJkYPBdJXhQ5vh+FiAEq/h4TIeDxcpDU4d73RgUhfbiaDu
 6040d3v3jcOUtW7H88SsX7hH4/MbLJw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200075
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 8:17 AM, Brian Cain wrote:
> Invalid packets can exhaust the available instruction slots while
> decode_set_slot_number() searches for a valid one.  We would then try to
> evaluate a negative shift before returning the packet as invalid.
> 
> Detected by clang's UBSan.
> 
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA8CYaJ=jAyc29RSdUMD_SWquJqz4fNQyW7oCrWithZhYA@mail.gmail.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/decode.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

