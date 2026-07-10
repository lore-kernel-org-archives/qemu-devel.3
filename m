Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E5AC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJCm-0003Q5-0V; Fri, 10 Jul 2026 17:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJCk-0003PN-RV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:56:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJCi-0007S9-Ud
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:56:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3brI1833153
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8iP6kt8t3bTU1N5vlzkqvhMKaOCsn7tobbCD7oudaIs=; b=C/MYQcTDTsqUh+da
 TsznlF61RrBzQqauqZTxiLHCfgqDhzSVK7Esmi6mG6gOWh0UMJmdQTBdLv0RKltJ
 S3r3M6LdNv0QYWIeDa+ua/tOa2S88ypWxoTqNhI8MCsuK5qOuF6RCyPREdTbFEht
 ogoMfYqCGyW4k7k5skMxiUWjBpYEwYhnAp1YLRtdhd0uOK6cOXgwXDSv9gqpz8Gi
 zCE+CUOvvsv1/l6zbbDDc+0FNAIMr/tXdkE1IbgXZrbwm7omd+W+WI+tU9TTBeTb
 dMgikbO0O6diXA/Kzrh0TldHtsyQJ2f+kyir5Od0FuQ4Swa2R3HIrBqQVSiTkacq
 YDyp/Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanweceux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:56:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c01ff996dso14192681cf.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720575; x=1784325375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8iP6kt8t3bTU1N5vlzkqvhMKaOCsn7tobbCD7oudaIs=;
 b=N6NUWTQW2sOrmvUltVenbsnIK3FTqckAc2pwA/6ZhIIty/+jiiXGL7ej09NyN5jq52
 zNWS2ks1UgNfpmd4HZsveCREp2TSP7cBdMIJ2qOxCLiRcK3bcLn05BuHTmNN62QdIDhW
 ugOCgaWMZeOypy6mv2mdgBIaLPEMZKyH2iGF3I80ceP3Giq85TQjR4/cDZjBIKKqLmJP
 PPYA15gAbNoQTYx2S1upk2/JYpXm8PRV/yAH6CB2fyFDpO0mnayzHxJjLsNHOCYYJ7QY
 8wjuo/2IETgSiV4SYtkWzxw5VibG7A7oCwC3dCZtnlB0y8JDX2vCUASq6vcBKA/SB/lh
 5P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720575; x=1784325375;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8iP6kt8t3bTU1N5vlzkqvhMKaOCsn7tobbCD7oudaIs=;
 b=mBj92plKjxnt7Cg4mK7/ClaQKHZdBzgcIuQrt7OLRYQepKT7OXwtFtN6veo/qLpxTJ
 H69eptKUmgu+QaB/2+LF90qTaTI8VrNYKYalkkzG5HtzoLlwRpVNtN+yXiuJMupKmi9z
 vaoABTBrTJPs9EN9hKp6HvoH+ttkOUHysYHfDR5alatCgJ3dnEzaM/sGDREyGlYy8H+X
 ndrYe0rPx8PBOPUa/daV18etKPAZJjSvmqmpPlqIdcXnqrcmGyGwm9OMzwOqnu/cJ3jy
 w/0Tq1MYWBipSEBkeMbiMfKIkfvjJ5v8GMENhrcn0fWwleQfdY6UVkkxZ7OoqQiRfzHW
 i09Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoirvyI5P1kQll1XmgejbfvAi7IsR7vPqZm10sdnL4FOmXdf05ngWwztS4/sM56Dvsp+MsqmJniXlol@nongnu.org
X-Gm-Message-State: AOJu0YysRQkxfaFbY7nvUnrwNwIFGOtG239NG2UqioOZVui0xcOC4i0l
 h/xJ8ANNceOu2gL9X+AOjq16VVaVu+HsRET6A5etP2k1rYC5SZewDJ0SHrRmAu2kRe1dDk3DGXp
 +SnodK/8091l0pY7mGPcAMJh0Rps8+8fURrI2I2ziPyPLbd12mmwjhTyi1g==
X-Gm-Gg: AfdE7ckiZ2+E0ImDVYIQk5uJCov/R8ZCcWuGT2jJT3s9QUIFocoUEE5pq5iJFnGWKVt
 dXTSFbV9sdIAmk7RMFoG987ItGnn77TLgfd94HMcc43rBjdecu0sJg0RCWFm2f7JztiWHf0bVZA
 y7aUIDzUQcRxw+Jr8rq1W+JinWo9xo8wrocuCJca4eRRRWc7fM0CK8AkJKEQ3icvIyGY0BusT3+
 FROBhwJrnPhClYRcQj5HVRXt6NpqIHhGIzw8HsOXii32BkLqoW0Z2HcMkDPATyJM5Os1TAwX1ua
 7mlo8JWboCO6vjqE0RIQM53fNjaxB4xdC8V51vwN4RPHUZvbe5wrEFqemnuuInoCVOX1s79ojcT
 bukbf+bfsX9B2b45G+JJyafDniwPKuj4OrlC1hIu8l6aL7jWXUUqCo7z0M4DagA==
X-Received: by 2002:ac8:5d08:0:b0:51c:217d:d772 with SMTP id
 d75a77b69052e-51cbf0be5d9mr8411241cf.19.1783720574629; 
 Fri, 10 Jul 2026 14:56:14 -0700 (PDT)
X-Received: by 2002:ac8:5d08:0:b0:51c:217d:d772 with SMTP id
 d75a77b69052e-51cbf0be5d9mr8411021cf.19.1783720574203; 
 Fri, 10 Jul 2026 14:56:14 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3b85sm270081995e9.2.2026.07.10.14.56.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:56:13 -0700 (PDT)
Message-ID: <5ebc2b12-ba8a-471f-a0f8-4ac57fa6b9a4@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/51] system: Validate flags in cpu_watchpoint_insert
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a516a7f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YsH3jjYhZO1Zdoctmk0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX/tquApocJoov
 2U5aJ5VpKajrbdRMv74V5N2FlqnOS1oVIEVrXlQFd1YKSvMkd3UBdH/W5kGELO4jfsrEQ5KE+cz
 thqaq+UMdIkSvHswDc/akwwPR8lKIHSQqNc1FewxwHwUTfSSb10tef3f9xcvxULycHR4fWzrCUJ
 lzgD25NUcSVUibCfXaniM1b5bdlRnuOQHUicxK4/fE6/ZYDodhh7ymooiGiXNKKXzqMaj5qAHNE
 7oWk0sOSlu6Qydsmb15EqguXUEL6pxPKRmKf0CrN/zyfS0DswJc7NoFmVh/YqqIAFSxWNE/OKge
 giMA1P2KNoK5ix40B0akW9TETEAZR3IPzYs7eFvbz0MJWBaUIVRBgCg6U3dnKlyhx8P9AWziwMP
 JSId0lOppUedH6zKen4n4uFz3KTPZUfQQArJAby/jH0ZDuyJqN3LHs4d1SkGYU42k7Qwd1qmWDZ
 2Bh6t2uluiC+dh1HS4Q==
X-Proofpoint-ORIG-GUID: wsnzBm4Rzq1rhO0Sp_lC9ranv-qURBTY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX0T+34P6Z6kAh
 8iLz/kNEXZsw6S5LhA4PJhrqCXO+ydnF0EelaM37vUaHoKVmZuxJM13MB+yKI/wK+asXtZccIK8
 5Ij4vNwDVWKvGP++WkBu/huXyvM/jrM=
X-Proofpoint-GUID: wsnzBm4Rzq1rhO0Sp_lC9ranv-qURBTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100220
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 10/7/26 22:53, Richard Henderson wrote:
> Flags must watch reads, writes, or both.
> Flags must specify GDB or CPU but not both.
> Flags must not contain extraneous bits.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/watchpoint.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

