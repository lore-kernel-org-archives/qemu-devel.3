Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5ECCA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoUs-00074b-Nl; Wed, 30 Sep 2026 03:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoUr-00074T-H7
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:12:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoUq-00006Q-4a
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:12:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6pDUH3845721
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sJLa2Qjf7Q7aXW7iQX4nSIHvODKveoHTygGeZModHnM=; b=BItfFLw4qK3X4DN5
 fco4OoJ8ThS6akOD4cslGGXv6f5cEfEGao3MQoQP1CJj9ZNioSwThzHelVWzEpS5
 2lBE89yOP+5Rb+8fapVQGP8cluAtaBnf3zMpGBiSnGWaNiHgIEycRbSsJsLUVfP6
 rMxekm2v1igTc66VDHnEHFj5L4d7JWScqth2zfcrq9FyrZpklriwhTKL3yy4yXRq
 QDDpXr35gS3ULIAwXDJGRh0yPDEswq5sET8FK43y5WUUt+y7h2q4LSIopYgKgrkN
 M/KP6vk6+pW119aT9s+wwAHdA2DSu6Nb2PG+7QG5vBzI5h32+ZAlz972WyHeRDek
 tLJXaw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0et2c1ev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:12:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93be1861d2dso823179785a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790752373; x=1791357173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sJLa2Qjf7Q7aXW7iQX4nSIHvODKveoHTygGeZModHnM=;
 b=Vu77xCQbLaiTyQSC2tfED8KoHr2/e3ePR86SEZmxkOnesF0+FcVa8QZGl5ktuIpQSD
 KD+7CzMwgP10cEwsMFAuO7UZbB8PSTGwNMSwG/XHHbnDUxY2f6aFd5BQi/d7s33Vsmkc
 j14FKR+jEaMD2L2+smQGH/MNfohBJRwdphHjcdY7zB/42irhui8iLWxjfY+5WdNd98Ey
 4yjz92SfDStTk8BvsDmrL9qeh8VkuV3n/8kv1WB4Rd7sqWd4EfETST0xbOp6RnQaL0Q9
 ZSISwD8PeYqIlj5mhJ3R7mPWWCOqrWNpG3LiCFoUNZYA4ODIK6KoHkte7fAWf+E/Zkgb
 gJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752373; x=1791357173;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sJLa2Qjf7Q7aXW7iQX4nSIHvODKveoHTygGeZModHnM=;
 b=oxEOoVyIjnoGcLoJ4cJlKBBAy2iGz1BDp4gXh4rBINv87RhVm6Ay3MPL83B09kIWFp
 AsARcZm6OrITLW6OxlDDU+dmn+kYjr59lxZwTaZM3Fruj2n5ZrT6Hua1nP6mqWgB9+Sg
 KlirqeiFqoWF/vXEfXD+Cp1Z5W1bNYYOpPqe/T41YSQp/JvuBIb/HxsF3z7f3UZmpuXN
 zfXMw/s8uF0tA3kcZzsTo73lgn+EsDLHzDE4x64qeUoF9OTeW0KLQ2CCdfbey5h768rL
 vi6yUvI5NfGjz6bX44WV/Kj3CSWwuL+c2zN2bc4xaae//oh2SmAZjWUgNUMo3rn4YtPE
 /omA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQWfBPZaUrbg/qL1OJDrY0z7qan8fkmqGbCgnaF62udUEBojpu1ddhIYG7yRPpr/GdBIgJmhjt3GSR@nongnu.org
X-Gm-Message-State: AFuF++k7PuHIL6DIDW70+gZtLJ9+npbkyjDT6HMY0+JDCBH58o3yKOBJ
 UdEk8jK1h4Q++QVPK2/jwuJctuZ87dbtQ9ZgSlSyZCHKg1FvxREW3tFOn5G1qGvkE86MVCkYxT7
 W55de05Vok1EnqD9eag7XvD5W0EFwp3IszQkuydqZuGUXYQRMMhnQcJMIEQ==
X-Gm-Gg: AYBFou2Dw4am7hFCVY1VXa9gvK1kwSZNA28/GOe4QXFmKHHVGoNwMyLTiCfHiCxw8Pm
 PiWJkV7muvdU6mhsJMV3ZqDIpnOzEdbGS3WO+rKzb++Hp0Esc2VFJie1vB6rs/IlQmmtkj8AGF3
 elnAr0b2qyj1k9aIl6kpbWJNXg110PX+/vDgovaz6T2vIuOXkZq2joZ/BS91iaGG0m9gXd0nMWt
 M/9TMCb2Q1ggzxImpdg9FpB7K1JgXD2UpnvxjClxyYtxaCduWgMjpAACXaC5UXFDyeZRYEnxMyU
 JKxaep1JduEVflbxLudhKql46Ulmp8hKl5JpbnBA77/S5CtvwLbvou1gEn8P6gIqsIup5xdUpr5
 FtjYN8HPEg6N4KxxS9RXBRBfDDgnK6B5kqw==
X-Received: by 2002:a05:620a:2793:b0:939:993e:bffb with SMTP id
 af79cd13be357-93ca97440b2mr68140585a.22.1790752372843; 
 Wed, 30 Sep 2026 00:12:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2793:b0:939:993e:bffb with SMTP id
 af79cd13be357-93ca97440b2mr68137985a.22.1790752372359; 
 Wed, 30 Sep 2026 00:12:52 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a015cd1282sm45725425e9.4.2026.09.30.00.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:12:51 -0700 (PDT)
Message-ID: <1a6a1079-100f-4d5e-9e88-1585aa8c7497@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:12:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/24] tests/tcg/mips64: add mips64r6(el) tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929212439.110454-20-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929212439.110454-20-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WZH0bfu8ERe0Xv0KiMNQd6LZ5UcU9wKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX/MysJlDB+47H
 EwdPvvjjJyBNV3io+KZ/LAuiVb96r8xwDvIAPqLowYLc3rYKgXUAw4obdC733glpjH0I+p98vAD
 XDrxPc6oMlCfwmJ4o0+BklVmJMDZO0ukFhHCM0pjHJU7YuDsnUQZAmaZqXUJHvJEfYr6SGQZ7u4
 r8OXMWKCUdVfWlSBOb6wyl2gpB/NjXljtq34O85cBUe9ahGPfbCyELDabIMg33bZMzEUQFdkF5G
 ORIC2fMLjRf0lwZTkSEe9Zt5cqdURaZcEMWqtK0RQ1Ft20Py2ePWtCGVhx48jG0jFLW6JE2Qt4p
 EdeSu6TeTXl4R+7LYQn7QLJ0+dFJ/qfK2Dei81TvX+ihkMrVe7IUE82ZGcPI2rAjJov3c6bpNlC
 jwaThO8DREZOMbNuNSoN25fvX7XWZ1wdz4l8FSK6ljzDt+LqKjoJcBeSTQyjagqPlF2820OzJuZ
 OGhmW+fYzcifg+eBt6Q==
X-Authority-Analysis: v=2.4 cv=cokOAF4i c=1 sm=1 tr=0 ts=6abcb676 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=2w4hv2SypY4VhzKpvnoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: WZH0bfu8ERe0Xv0KiMNQd6LZ5UcU9wKF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfXzA/b7onMP1lq
 eYvKt31yVJpMnW3Hw3zessELzlgLHYIgqRqnPk4MLBA1q0LFAgSeolQvZEMRKhBLXUUqQdGS05U
 lOxklxG+TzvxmLhGocuIMwCiz5OGv+M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 29/9/26 23:24, Pierrick Bouvier wrote:
> We need to define two new test suites mips64r6-linux-user and
> mips64r6el-linux-user to be able to use a different compiler from
> mips64-linux-user, as cc is setup only once per suite.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   meson_options.txt              |  8 +++++
>   scripts/meson-buildoptions.sh  |  4 +++
>   tests/tcg/mips64/meson.build   | 57 ++++++++++++++++++++++++++++++++++
>   tests/tcg/mips64el/meson.build | 11 +++++++
>   4 files changed, 80 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

