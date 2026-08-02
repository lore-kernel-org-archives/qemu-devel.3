Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5F0C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX29-0003Cn-Cu; Sun, 02 Aug 2026 10:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX1w-00037L-2P
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:19:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX1u-0006ZD-Gx
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:19:07 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B7NHm937346
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DSpmFKbb0hDL8gEyB+qD0im1eu7cAFPD0PPMJtLwtAQ=; b=GvfK3L1vlEyA+Vdn
 mH7yxPK3/gwRx4hyvNIBI+3DDOTIE+LvCAYoD8Lj6R3mC/qgEBzonWHwZHzi/e5J
 HC9UKAm429wLQJ+v9YoWQhnGfF29SxOAee23EnjY/KwOLmKaU3ho6w/UoDq+upZy
 aKHEo45apyux0/fzPXRUQQ0GuNqIisH7Z2RajI1KjQSGh2pCCUC/aIoF13f98GQt
 IPchJ/lNXr/v4EPBqMf9dQr5yyLG+w/0MH24yGV5L6Lrc2eMdGCZqXJEJmfkU8x/
 Tm/rnYe84JIpIl/b7/BdyxTxDdbEQ9NowNalznkLOizQ987CVqa83cku+XNKisVC
 bSFASQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9ygjs7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:19:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c07f25de2so18586871cf.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680343; x=1786285143; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DSpmFKbb0hDL8gEyB+qD0im1eu7cAFPD0PPMJtLwtAQ=;
 b=I4BaAvOdzJbdcmalAx6no+D9mx1EUgtgfnSD2O00475AScG3XpeTxeH5/B/bO/wfXV
 pNcRh6VIcJVYCkBOwmUSqJ6e3dy5Ya7CJXqMSnB6Qjshe9qA1kKMQiAW4QQnGFrew2M5
 6uHI5B+97ISgcBmJvv9ApkUSXs7YVnQTmjO3P+GOBFiCz3gpPyPZfza77uZT+2EtIgo7
 2GlNNRJ/ql7Q6J/3E8Kj1y8JYqXIptqDv1k5mcqJ/RMZxh3zx3ofeCTg3jXmNxtvxfR2
 svJFnjgfwcwtWYY3yKnZEKPlep8gK3FRnSMnWHr+LQe/EeD/yPxlvPZ0nDsdyjtkqV+8
 D3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680343; x=1786285143;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DSpmFKbb0hDL8gEyB+qD0im1eu7cAFPD0PPMJtLwtAQ=;
 b=ATpNK0n7pMyVCuVajB5rewFLywknNHrss3aXODp1QAmeTTjtsEMl+/YTA1cKUq5nUB
 vOoSaFddWaZmkzBUzCuJxuZMW9bFzC7KAV2LYTude2fx2zF8U+8xb3+soJybr0m6F5rW
 96EKdZAYWCR15giAX996kDybed/X0hu2KLf8AisoUgAAZUv9DSr9QfhUl/T8YS6XRedw
 C3OmvfjYlZ1ncsok5PymjjAju6UyvUIJxZvNE9hT4uKw/CLrKMuDm/OulOrFV0iJsdIQ
 /htModxRpV0HtYS74qFD6X17ccpOje6F+jGAsn7Rfwl7UWAqnyStrWz1mbtII+Sv+096
 IClg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5DVJa1bkb0SP8cd5NNMulkUqXcpqhHgYRtlcLLs71qaNdTcsianP+H6WILm3/FeaqYqoo+K8K4hN2@nongnu.org
X-Gm-Message-State: AOJu0YzW6gl+Iit2lxqZVsd30BRDDnzyA9vZcQw4Z+MMY/93vSN9M18k
 u9kZdOk9xZ+ztKZbZsg3tjVhuYlPQGdZad/AU57Ks9mWJvySmlwE1q3MxxUSMZxRxUGJnpTzjTD
 R6sXEG7IxLZGnnqCyiUcucZDI3zUIfNAVxwaPowL0SVqiiLs4xIV6ptt63w==
X-Gm-Gg: AR+sD12ePLrTTQRapPtHzD2oKzi4dpdKk0qJb3qi45UPYoJfifFJt+SU9nYasMvy5p8
 2awuOjDfsT3N4hWh8n4Ck4B1S9klAhUJm2FkrVoVdNuWtHfpa1ncalC5c2LkwCtREQxjsTt4+Fy
 EpZr1TZUET55GoeH0guNAyYNbRqhboZuHVHAgHOKsmhjD1jza0HmslVjwoBzEzqKdl4qyn+9/yK
 D77zTPzpSPMtDZw+6vN02Cy+yoZCeGc1qRz+OJjhkE2yzjIjWIwkIHzs+yp+lr2eRTrwO1g3sam
 aFXWGgfuwKoCtYT8KdNwuBoY/0BGRmgpSRwdSmht+rqVs7ykTs532z0aqRt0SPFwWBiZDXOWAJH
 F79JwoVqbFKfTq75Pw8KtiG78gFlZdUZ21pGwWYSzZbVpFh0ciQA=
X-Received: by 2002:a05:622a:1f91:b0:517:7b6c:4465 with SMTP id
 d75a77b69052e-52b56752f3dmr148968901cf.22.1785680343567; 
 Sun, 02 Aug 2026 07:19:03 -0700 (PDT)
X-Received: by 2002:a05:622a:1f91:b0:517:7b6c:4465 with SMTP id
 d75a77b69052e-52b56752f3dmr148968371cf.22.1785680343199; 
 Sun, 02 Aug 2026 07:19:03 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980878dd0asm139684025e9.14.2026.08.02.07.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:19:02 -0700 (PDT)
Message-ID: <3ea2483f-3919-4b4d-bce0-e4185d54ef4a@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:19:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] target/s390x: Convert op_st16 to op_st
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX3LvW5KKrR1mI
 4681gnIADkQEFjopbVBdxBG1Er1BwloiCT5Xnyibr8lxARIZAT5f5i3ji34AF86wPk6tZXtO2jV
 E1DTBJ5oO8Q+9gbspaGbtppDu2sZfFs=
X-Proofpoint-GUID: DW1Vx3NRrKyfCyFG69WahlqmuzrGHV7f
X-Authority-Analysis: v=2.4 cv=Gu5yPE1C c=1 sm=1 tr=0 ts=6a6f51d8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DW1Vx3NRrKyfCyFG69WahlqmuzrGHV7f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX43lAyuLIaCPH
 rPtrIjRFThO+hsP9GA2XqvpKTvPutE3CaGFQMMqQzTfXmE9UUEJ6ACgfkQCELLoGdKyBoA7Hlkl
 WcXchf+41Wj70TN/UhIOQMGwWj7wBVRU7AFEwl8YNop20DcwEwIk5g099ggQ7tRqj3g5+V+lKlE
 i6VbCqXaG8Vcrzg7QfGnsKaMGyDGA0hnnGhaQuDZj/wuitdnQfJgKVwTdEt0bSCAPxJJMh7aUcT
 jz8FV4PpX4ww9TYE8AxcCKyv0byZAM/Ic82c63CLZINsGaEAi+oaxHYIOBtgymnY+UT2SxpdWwf
 nb3FL7VDAz/rE0pw36KvXliRlNRmjSUXSdgNWqynBKUk9Sd8ykNlEux0WPX0zRaq6B5UJiOtjHr
 A0nZEy9DgddoDvPtFy/NzJRtu2478bC/PX3v932W3LJ6IsiYSG7qs0Y8d/b+f38WJ42AJt1RIwe
 Ylkz/cAE/ARKv5KIR7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020126
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

On 31/7/26 20:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 6 ------
>   target/s390x/tcg/insn-data.h.inc | 8 ++++----
>   2 files changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

