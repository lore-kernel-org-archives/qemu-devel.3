Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55160C5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws2Li-0005JB-PV; Thu, 06 Aug 2026 13:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2Lh-0005Ih-4l
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:57:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2Lf-0005Ey-O6
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:57:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676HPO5i2927765
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 17:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fVMm80MZuOIFfsshSWXb8ISJozWwBNCO58IeqlVamBc=; b=SG4ofUqt1QuT9dp2
 ZZ/HxRPUil8/CcBrwwovwxseb/N5ccH0nSul44VLEqlQHpIcY6slY6rlWBJeXt3D
 Jqsev+CuceLDrmPTxXbPL1hi8lBjbIEguzv+hIxwDUCDkgyPL/YHjpGJ4AkvbBQM
 lDMnGfQWVSd/J1m64+T1BBR09txMV1R2YAWuEQazzTWDNbHPqH/6sg2CiCwHlQvx
 8/L6kbwI3UGso5n9ZKx5j01oapMTr4xrqVH9lf4HsOKZXb3D0lCOFZ4xI9kx2zQ/
 H/zF0rY24gfVewdMPZ49hA4EFgIYh7G8KWkrwjUdxKYU3tqETh/ROzfbn98c4Fkt
 jP9CHg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvxne85cq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 17:57:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bf321d786so27352331cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786039062; x=1786643862; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fVMm80MZuOIFfsshSWXb8ISJozWwBNCO58IeqlVamBc=;
 b=UKF/69P0YmDYk3Ns6+2jC+FiKm5nvkIDT//9O2PbFCkKqnZsM/bdxb1fWxhasoh05b
 HFlvEfeqWuJR8O5o5ETwFwi/TqphPNk7+H0V06aO5mikhKc29PyH10D6XqFMUj8RQdDP
 YbsBIgOvhHvAbmIQVJXrRWJO1Kaf37NRt6n1uXlWuCdXMjO9/9KeAhAaup65seFtPisM
 A9k1h1d02Sib8I0vO487XpLVDxHlW3TSykioW+XmOKL3XS/+STqE+fPuYp7ec4RUv+Dp
 u82ihERU6Sf/DHcbmbZYZX1Lw/WQUlyEM51FN0QgHBml8c9vH2PCdZveeiKz3gQOZj2u
 Z0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786039062; x=1786643862;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fVMm80MZuOIFfsshSWXb8ISJozWwBNCO58IeqlVamBc=;
 b=LtqFjS+EcEID7w4qUtwWmHxl1dV4hvoGq54M4Efj6Ajy4sUXJoVwaOHCtK2DVjpvXw
 xjX4g0xt7mX5qX82X+wCj9fHKk1yG5EuN60/LKPbufWFnNM7L2Jtsr1mgacu84Fa/A7y
 04stVfMtFOTVfT9br2Yx1/y+M/QMC/Vazc9BIdrAzZPH5ScyocX81xEtiHemtabnK8yW
 VGxX24kdpazQNfkDjjK3sLV0Ul2EWuwGyoEApLPDZNCNQZxE7thxkZLDK74Esvkrkmfa
 3fhPB4dSsvxhXls6eswFtyx6W0z4U1qoSV1LBo+I/2J3gS6zUvg9DJmebxNror+Q7Mfs
 8SrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RonsVXiUrU+HTEzmzvPHYSeVwUwYkvzcDuVjn/oWUwVYp8oxIYFuQQWkJzVZIJFf8pK4hlDcizdBeDj@nongnu.org
X-Gm-Message-State: AOJu0YycFWRm3XuT3D+/OJw/3u9SLnyUV4LdFwBwHW0Kaww9XljkruZ3
 wypLcHJ7INwOC/m6mNR9wjNDA11zb4iRU3F6EeDHqwH3aqaSwzoezEvTzOncrlQ9EDRDXA7BYy7
 d575TY4HMrbWChOtiT2uDcs+xLZKYdxVOfxvAKPAOFoVN86KusSTTpKkPvTKKT/nQuQ==
X-Gm-Gg: AR+sD13jqV19JSG5VmYXoI5H7ibtovI+kvKzRHrpMzFuTzXQrg59ZPuQnQ9gAnMroGv
 275MBfIKxgNFudEPgdkgcpE1RDYnfJA4dt6AvP73wbeUbVZgmk+3HGwOmFzvz4+Pol+ht9jvpc6
 oCXMfS1wdEL7hbVtimYlk21jvI8NLwU9i4zGBRlMhqRnDzt1JKQBqKd7S6LUhxiKNAxKD0Eopo3
 OQ7gwJCz2ABKNqW5P6SGNztWehtQ4i3u99iFQM9XO4XHSh2cNZmhXOVBJ+/x7oFYOnDju/Ac0gr
 YJbsrYjGUFHKfZXQeVxPd1EyPOx3VGfOYyzSujF41FYdcv1XlQDmHdJCi14jl8DX/18rgsuBbLM
 dHRgRgIopCfTbC6gtV70qEP++pdzlw46z5VI=
X-Received: by 2002:a05:622a:148c:b0:52c:dffc:4645 with SMTP id
 d75a77b69052e-52ce5f2ffadmr163775501cf.7.1786039062075; 
 Thu, 06 Aug 2026 10:57:42 -0700 (PDT)
X-Received: by 2002:a05:622a:148c:b0:52c:dffc:4645 with SMTP id
 d75a77b69052e-52ce5f2ffadmr163774861cf.7.1786039061539; 
 Thu, 06 Aug 2026 10:57:41 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49952f2e151sm35754675e9.4.2026.08.06.10.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 10:57:40 -0700 (PDT)
Message-ID: <316c76ac-7d02-4414-ac45-12e44aa2aa74@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 19:57:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] target/arm: Sink aarch64_aa32_a57_init into
 aarch64_max_tcg_initfn
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260806163939.328201-1-richard.henderson@linaro.org>
 <20260806163939.328201-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260806163939.328201-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _GtRrZm7oqJIMYW8eX2KUy-FRJflvv73
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfX8/7686gAPny6
 IogCoUhSHznZPkkF2eiXqc8MxBZz2+NtnZXs8EBMqdoNBtI9w+1qUTYnm9ODQRKldTpG5BGcuoG
 W8+eIzyxHSo2qNSXcWrdDkz7MMc99xk=
X-Proofpoint-ORIG-GUID: _GtRrZm7oqJIMYW8eX2KUy-FRJflvv73
X-Authority-Analysis: v=2.4 cv=ZYQt8MVA c=1 sm=1 tr=0 ts=6a74cb16 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfX9ZzHhHu2oBcj
 oT9wMZevfMcdfJ3zI1UY1McKNQfdzZCVs2KWw2kH+idDgX6SiiSqJ88OGS6lIat1A6D29WqdnmX
 Fr/HeRPnp4xemqkDp+8dVQhrLivP42h5kcg4JARGAiHwTaylXa/zKcjibk9BOcxUAoKHQLyOG6B
 Ek+JAbQ2scgkBr+nB2b+tIeiA0VXjfnUggPeF2sqBj1ynk3wiHOXDflDyPQS3PPKklM3/mRdv5O
 1tctlkc5vmwVXOqdQPJdUqRfeTOUy+RwXn6q6Gh5TP0coD8NPSpzE0PaD66WInT8hO5ncEHlXFd
 wOB/fhodrG9s/rOInHhcF6Uk4LBppjNsVD/B7PgS/N5Q3RADs6fPXriYFz0MxsliA+v1lLZzSoU
 BlvyjOqeEhE/ts8XgR3f/Rc8VzJ/JeA+O4Jvyv/KYWBCpXyUWcK8tnpWxoEl2CYq22tC9TJHO7L
 /TbxPLOuhDr3YlOQU9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/8/26 18:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-max.c   | 3 +--
>   target/arm/tcg/cpu64.c | 2 ++
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

