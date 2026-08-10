Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50609C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtGAG-000300-AS; Sun, 09 Aug 2026 22:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtGAC-0002y1-KN
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:54:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtGAB-0004TJ-9X
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:54:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679LDMdF4103422
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lzftzAbo4lH3YTjQtfkJSbwiwmb2QKIenjp1G6pbVzM=; b=caqo5fA4iu32asxq
 NTK2HzWMeRmj9p6SjTX7dqUoGibFT1uZt2fzI13lj98iLww2ergVjpQWEEC1c7U6
 hBsM15aGvHCwQCEdC0Hr1cjFa7nrsRCgjrZQb72F1QwNGPeN8Ex7ETGDkI2Cvzbq
 Uwvb0txArnyc59beHFyTwkm+94QdveAWA+np58K1KD/F8efLP2VLUfZDD5bpgM45
 bedtXPqzyOk4NJU6e6sWa9jekNkHBTvWLefWBJJDqJj4UAh9O15yJ/x87VkHtxuO
 Kz1GMGC0XLu6Dvz+RnyH0KZFQRfTi8trrt6XttDkVxoiXiRHKlOqDCh8yUDDt9S0
 P4khNw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy18xrjhc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:54:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-907c59bd73bso26825816d6.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786330494; x=1786935294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lzftzAbo4lH3YTjQtfkJSbwiwmb2QKIenjp1G6pbVzM=;
 b=Yc4ZPeSYM3i67/UB2fE2z1jK4bne3BKbxqpnDBWh9JYIqWTVuzJtDebak9hvaC2Jcz
 Qhw9Nf5GWf6vs5F6g1jnjojquDmoS1P4J9LJpv6BrRoPh4HaAIX9khjxnLmSMSkQOGep
 JxKTW/9V1OVbd4i0jqSITEG0cR5rtxbeEy0omubZiHrO3lfKpPxOIu81uqqXnAKxG3tK
 OWBKlQcHNTYs9vNEhH7nCKdcOvQ8op2WX/OTUlUi53qqWonJwGlXwMscKAan729333Pz
 HfW75Guxd1ruaNYbYu1VNH/9DweWEbh0nZmG+iNVLcTKkXimu0R3aCKW1gM4e2Gt5efV
 9K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330494; x=1786935294;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lzftzAbo4lH3YTjQtfkJSbwiwmb2QKIenjp1G6pbVzM=;
 b=dQVHVT6G9UlqaZ40Cdb8uuXDw0RDNRF5W6lG1jbt5kj0rzMP/uueoJnG6eWUt9p3gc
 V2tJ3X2/yYE37RNaw/o7nad4aPZXSoDOYwykfBDdi98quBs9ZlBcvNWPJafSQQIIqXaY
 wCRUgFBFMkHdL+hJo+ilsg+5d/wSHKOtHmUEE+E9t0XX6QzkCNdnE+1a6rw/dIQhCrc8
 bFjAMdAO7PTvcD/+rYL/z3JXm9G9JjB2yH3K4iZDnVWZw6eUr/3Px5jKFW2GTwUyWqqZ
 py+qZtQQomV93Lp4JLUPC8sLcdyA8RW4DdXt7cuRcJx5jNp/aBDtFK8VOn+GdchVD8CI
 /8zA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHtF2/B3GVaotBkcQ9eZVtUasYnoR2Za5Kz1bYOkOeHzZLOoYF6osla+u2u/CVicVnyB7X66M/sBDu@nongnu.org
X-Gm-Message-State: AOJu0YxX2aLHRIe6kp4VPdqn6Mk4chcvWncj1FMApchbH1oOki4bmSxf
 XZzMl3NA8e3hv7QnF8drRTXLHyVz+IHlGqRLzEYSYx25wvCIrqp6c7JFH0jKuyx2gmdUskIm2f1
 AntZgYjCDglPHGQF4GrgDMQ79oUqn3aHVx/ECI0Rxx4kliUr0Pb9hbXYvH3kdN/3fGg==
X-Gm-Gg: AR+sD11KPGKvQOxROEJxAYOWrB9n5ou+mArsVlrO1nskIhCc/9W4l/Ig7lsdmw78EiL
 FrOJ/t1KnQSoafR7jq9jpzp8AsmQ2ZWfvgtvhmC6nCMmxkBSVg9gczaNgRQF/eF+dFqZaw1sfGO
 j3zQeVkApLMEB23cExlRjkMRgXyGDp4mSv20lwdpFW9jvQQPEvt5v/g35bKHftAUbwaBzyZfa2s
 u8+BSZeMTb4SYZLlr+kcJcGe8/PQ/a94zzePL2a0l72v0ZhZiWQ46XRLVRwNmRaoQUYgMGm+WFZ
 Xyn3o9kh//nh/ls2EAr4I/LuVK1S8NOoKucL23pcSFq8mBGIDtirJAINliYwLLzPSJtLZxqQuug
 jH9EYvBQ2dpXlsezJzclAb3YWAd4mVRMA1FA=
X-Received: by 2002:a05:622a:2448:b0:51c:1117:c79 with SMTP id
 d75a77b69052e-52d0b193284mr313776391cf.24.1786330493627; 
 Sun, 09 Aug 2026 19:54:53 -0700 (PDT)
X-Received: by 2002:a05:622a:2448:b0:51c:1117:c79 with SMTP id
 d75a77b69052e-52d0b193284mr313776181cf.24.1786330493299; 
 Sun, 09 Aug 2026 19:54:53 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea2d84csm216889355e9.12.2026.08.09.19.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:54:52 -0700 (PDT)
Message-ID: <e9b5dc62-3ba0-45ba-8159-54764ee7ed2a@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/56] disas/riscv: Tidy dec initialization in disasm_inst
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809223545.730664-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfX51vNaw5w3HSU
 HhB4m0AOSjoZhF0g9oStH2W4Ivuk8YtnM6xU6tQMRkPgirJOpx8+kYARSmbJD/9rbcUj8l9UYjc
 yURjOJZhj/8qpuadNFYu3NHD0IQBNPE=
X-Proofpoint-ORIG-GUID: 44eSU00AV7yTTl8vKBxrQJdPNrl_F7JY
X-Proofpoint-GUID: 44eSU00AV7yTTl8vKBxrQJdPNrl_F7JY
X-Authority-Analysis: v=2.4 cv=bfZbluPB c=1 sm=1 tr=0 ts=6a793d7e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfXy4Qy74oWEVaE
 mGsMJoLMSi8Y0ArEEuxht+2POp0CLlqeU/pdBIgDfBQEOAK6lkVDtLlfHaKUVMcJl3FXdJ7brlY
 TFsPpx90O9wjbxB6e4DDzr5nCOhIB7SjTqlVMWE99PrMmsY5PB+IOp3zPZ98zRn0r+Vn9Ll1mWu
 p87WfYPjtW/qlyVOTq4yQTXSaaGjlF/ZNFzRhZJ4xztVUyqTQX4rUXrAxzdOyDxuAEppKjfCx7j
 cumdkCZc6+KyYXkaeXFTNvFimMA7BB6OeRnS4DsUkTZYrpTq+K/dTba8VX8ygFXFs3F9xGBplUh
 k48dsOVJWPENgK+t2qLLKf9xZlr3B/kZG8h5I2eMCSdIPbS+dgdHykSI+OZeEoVySYW90eybvZI
 lam7j9Hv3wmtxjCgW2ORpnbpxZ3AuPjo3RSRrCnDuGREyh5uHrd8zEgbXIGquFQj1hRYz4ANvXA
 tWyt4cDK9OMJUfUCcaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100023
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

On 10/8/26 00:34, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/riscv.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

