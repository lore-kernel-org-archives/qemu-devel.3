Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D4606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C2lrAai7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ArJ3lEQz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQngS-0005Q3-5P; Tue, 10 Nov 2026 10:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQng9-0005Od-Ek
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:22:34 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQng7-0002nn-SF
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:22:33 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAF0CNs3713592
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 15:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e1N3/etF/jX3oSEU0AUbGYXaoUY/b9VItWOvx7JsGhI=; b=C2lrAai7lsxl5s7H
 /Qk9wAhJpyWyqVBw3k1G/Xn4gUhKyPiPmk+vh8GKSCIUHHCQXc2CyKvajd4dwU1Y
 VufstQwR8nfMsTRbbldZSk6NFHFlvvxfQCXRJzby5FcKcSEa080QvhRvZAXgxkCI
 NUHMOdhwP+1pNqLeO1hXNbNHyc2LtNC2o9AIwtIZai31mHK2SW6eBKQ5eabI7n+D
 k47xmQnmPybWQdnXUsB13aX6ZLCLkR6wZPjNSDO+MsXrNNzYS+ylunkOYxtC5MXe
 v5Cr7+RXYwlDDXRkrrpmcmMHESjC+gp0XWHcVx70KZnoO8BR06BPaVpPh1yqT5Y3
 RIHT3g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huvtda9em-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 15:22:28 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso3077360c88.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794324147; x=1794928947; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e1N3/etF/jX3oSEU0AUbGYXaoUY/b9VItWOvx7JsGhI=;
 b=ArJ3lEQzZpMsdmhMZvihbl8lONVjn5CQ0NogRO0KxK+Uji/zyiIdpr1Wp9Ocdizmgq
 PZw5jbeJtrDoE5zDZxg/MJIMdHI2CiiYWbrq9e64OAEOrZ7Z1BN/X2xOFXcN0tbDnrTj
 b/GwL+6AgbsOHTNiz2301mhWik4Th50OXl2clXflpal6SfcjftSJ7+UH8zHbf/o110s/
 QJZs0b+btUCvPj7HlYi4iAM4q56dIuYbIl6sfP1NKo9w0Q17VT7xahdPXArL2r5NEFBt
 ZISxFEwIIddPzyIORYxQfm7jcQJBhwPZ4qoJMwP/FnUwJ50J7Og1ezWXrPxervtFe1+d
 NqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794324147; x=1794928947;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e1N3/etF/jX3oSEU0AUbGYXaoUY/b9VItWOvx7JsGhI=;
 b=0Yh7DcFTJuTqxfdGEnkImwo0AEzQdnJeI7E0YeWqreOeKuSUAu0m8AzQrmgJUlDekf
 H323x0y3SNXnUhSiUuar+31VhCTIpBnk+TmN9smhmiqm7zVHZzCq2jU7rn8iV8Z+rxx0
 Ecq6sxzBAvlW+NG+0WKFGrLzRgybjmcHdGznqHD61zXWyPvPw8SjsplE1HO5fZN21tNM
 j3Ukt94gch/wUsqh6B48COVz4kz8r0EU0vxoNATl9/btygVuqjWMHxRfpS5FzlYn4W4d
 CbBIzXi4hdDSBh7W9qOGoPgHsAt5Tn1UR63wMjvZJ3vqKDDtnWRQhCq842KqFCGLppXx
 iKpg==
X-Forwarded-Encrypted: i=1;
 AL+hErFZfYfRdr6O3fj3IY98YO6M7ELLsFNlojW8CRR6YdpZYftbkGy64sQ/csIRmQmw2EWcCOrgAIQt35vV@nongnu.org
X-Gm-Message-State: APuU4Z8Ka0dJGvHohPPecdkFEDbOQd1IeX/+c1ir3VJSieTimeKkxtto
 dI01DgtY94QrLWVMod32s/z42rEsdqM4KLcUzDyCxYcdSROMEn0KOoQsYWbX3bczrAZVFlnvd3l
 EjHK8lXdA2IKcG38AcpsPq7FVu9GHMbwE+DASJC5Y/qqM3i+T8cULqr9DuQ==
X-Gm-Gg: AYBFou3zD6CNanrCWDcXW6RzJKhspWWEhfE/o8ddSuoY2LSnHfFUQjVrrxlBaqj81+B
 S/xdBDLJ5/pIoypqOhve3v0rCcftdHcNra5xl058RImlAYKullRJHRqHFlGgoHudfoH4Jaqsa8b
 eROoE0vIdRoaJPZc8DtRBOKaroYjMvWMmRSQkdIDGldAYcDA/2ZVK8LUI+0dH1jomxHWtr9g6Wt
 UuSMgbkMaMBuk6cocOSOcxC1UDvu/Bi2tE/3cweZETWM7kXNd/afufKZodXm3TgLwKYYrWzGSM0
 QPFavAaoC2ut4W7l5A54kTkDpkJZ7IU4hdKBOlHXkd/6xt13e9Nc7FSaMTCP/hizShoGfJrMf0i
 UqdXV/EmoHu52zn2WZ1FxzYe4eN4wfYs/eDslyKpHghn3UpF/e7G7R8AJ2BJGwyI8mVOpr7kPQk
 thcWuyg6cZdmdiR7Y9Qv6nBtwN1LY6h6kgN6pFQziyk6o=
X-Received: by 2002:a05:7022:2514:b0:185:b157:f271 with SMTP id
 a92af1059eb24-1b3b607af36mr5115498c88.23.1794324147266; 
 Tue, 10 Nov 2026 07:22:27 -0800 (PST)
X-Received: by 2002:a05:7022:2514:b0:185:b157:f271 with SMTP id
 a92af1059eb24-1b3b607af36mr5115447c88.23.1794324146668; 
 Tue, 10 Nov 2026 07:22:26 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b20c55sm6955790c88.8.2026.11.10.07.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 07:22:26 -0800 (PST)
Message-ID: <f532aa43-7f09-4872-b73f-9e9b4b863240@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 07:22:24 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Python: add support for Python3.15
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>
References: <20261109193145.3557626-1-jsnow@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261109193145.3557626-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: m4LAadF8OHPr8QNUwKV2aPvMj-FwPy4u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2MSBTYWx0ZWRfX6ZbV8Zf26gve
 8hXhRRxVmGLKnilB78F0lL8sucQJa7l18q4vzg/8JYsHLSmomB7k2OKbiq3W24dXLUSCAz+DSVU
 4+tlqeSI0XSnDpwPFOhd+CBOsEl9pDA=
X-Proofpoint-ORIG-GUID: m4LAadF8OHPr8QNUwKV2aPvMj-FwPy4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2MSBTYWx0ZWRfX7fua59rLWSIh
 8bFaIxeTuNQG2z/iRLsWZSWn5NZ6zikSv96guOhAAiruG+Ltt9qwFnzlTqLcCMTA+sch5+J4jbR
 xmVNj8bTbNIFznXcp1FxMoN3Q8ay7NISmpjtd3a83x3NwtdQcdO89IZu+K52au64jAYFg9KRpdd
 Xja20R8bReI5+5MoQ+5ET0gUkZzyIl1z6HOAMDg1qAqpco7j4omUF9GQkWetLz3eHeMfWdQEkA7
 DiTGVaYhy/C60Y+VQ8RSVv3+jWMvf9WRL8SsK/Xyl+j7UfieEKyjtrhS7oPkS6EgUkE6x3cwZ69
 6CAymAiW/dNnsfaWQN2kcOPGNoY1JsIFnFaqEsaBdrGgnW1PBwepV0zp6vUaqrgem8W3EyIYB+R
 90mB+NIwlC0+Wt1gXxvEQznClCuzstMKn4gc5k353A/LkYQmJWEz0k2r8mAXS32jKY+nofh4HHs
 T8M33ngA0s0bOq37FtA==
X-Authority-Analysis: v=2.4 cv=ArR7T+9P c=1 sm=1 tr=0 ts=6af336b4 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Emgt8-0EDi_uJxs7RdEA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100061
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

On 11/9/2026 11:31 AM, John Snow wrote:
> Update tests, docs and infrastructure to explicitly support and test
> Python3.15.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  configure                              | 2 +-
>  tests/docker/dockerfiles/python.docker | 5 ++---
>  python/Makefile                        | 4 ++--
>  python/setup.cfg                       | 3 ++-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

