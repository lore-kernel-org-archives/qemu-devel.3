Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC380C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgBn-0008EO-E5; Tue, 11 Aug 2026 02:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgBj-0008E4-NI
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:42:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgBi-00049q-Am
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:42:15 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMq4cN2687911
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t1Db4S1cuB8EadWwjzcmyxzm19hPepKN6VjuYqGuMg4=; b=DORDWKWub/IF1nSq
 p5h0Aba1RcA53Rv9jCC/1TxOHwgMA0SkBZam+zr9c+nqbOGX2sWVNuJk7MZTF2BN
 LTh43LfHtgQ/5I+450WN6wJcREa4IYnnew/mP8Tkv9Wl09z7Jd8z6hgBcDKAQjAx
 ogTw9yfBcHNaA2d7fIrXKjj8d+4Ec9jtSMIp6aSMnm0VBOX6CVuG1f43j3dK4z+0
 MlgyVRs7yZFDi8Hje8rOuumrFBzxxqSdK94d25VfK5MN9Pt4R9zG72+N2EAFs3v7
 a605FSwmFHmMeL9+sV5U+fXcogWFAnT5wWuVksxABRZfnEyInI+vgWWT71fmLoDD
 QbgJfQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjsjsjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:42:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52ce64c41efso49676851cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786430530; x=1787035330; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t1Db4S1cuB8EadWwjzcmyxzm19hPepKN6VjuYqGuMg4=;
 b=fqjftaw0LIWYN5+zyoe1YszKDZRNh2fEKIW6IFKeFz5jBf1OSTx3lDONy7h3rDMkkH
 o8yEchfp8APzWLkjXfdnWfLbR7cd+eN2LTYb9zWL+OmQ4IFtE1DBKPGPLqEy7Bv7ncn2
 KK6L6gn3Wk5e3/Ioy3Rrb4qYjnT4xK5AIj9ocO7707bmcvvhiCNTVuEw03NfRlDU/x8g
 uiMP3ohQ82AlZ1z4MQp/wIT/Y36SBEcHwcnf9F7nysirn1FVY5aiuY502W1uVnwy/i0q
 omSqqV/8tZecjYsl7LZL4mUNUoN5A4pXcOkoBgPARSY//K2SMyb39NOVa5exINfihN1I
 QCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786430530; x=1787035330;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t1Db4S1cuB8EadWwjzcmyxzm19hPepKN6VjuYqGuMg4=;
 b=V72+nb0uD5QKrQ5qcjZJkJGWb9lSCVHUM2JiPX6CECPoQkIDXn8cEGWoxWuGOt9ahj
 swNTW49SMFyJlakkyBC8Ig/m6/4IY3YZ79qNPe/2UybA1f53agRwYb3WWJjHozfIUTM8
 Go+aIATyeBHQKDQdlcYuZq3Gqkklq1QNJz85/Mbhww5cpXyoUU5s2aMo/Uh3lP8NZQov
 nCNtyFE0o+KvQQ9Z6vOhuI76YNm18byT9iRHv2jq2rqKRUrXacHHW1tIx/nZ0TU2MK+V
 qft3oqxmxq3Bi7AfE1hyO2kqoJNPVJ+lt2QY0cZ63SibVbmLDPzRr8B1/W1PNvDFf6PV
 Lm+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1F1HeDiFM3IORsZeLSkDv4XYAK2hXCNDtdVPZkJF0jTGFFQFQDqpXW67HBzm0QX4lnhYUC4hxaqkD@nongnu.org
X-Gm-Message-State: AOJu0YxCLBbR75g4UZ27NAmaafHGISZ8mGnlJY2xyy61pZgEVfmortdT
 sA5lW1ENHHmSm76Mk9MZsJFALnoEXuJ9r7UJ/LWVLvfz0LgEk/e8VTYNSfTQBhm36CwUScUA/A1
 dJWDPw27FqfFicGdOnD8cpwEkrMVSMZSQn41xiUy8VTVEC/pCCqkLp6YWxw==
X-Gm-Gg: AR+sD10nQ5RPmetKltprEYowpYrzJxpiJhHFOs/20jogK//H+a1hN+rZGDInoM560WG
 4zXNbHVwIRXEh15ebP95B4DJLsjWAlYMeG5Ic8yaFcFSZA2ZXeHytq2FdGp/7ire4XYqEuZIylH
 tqhqRqaO3Ag0z2bkgPTOsa/91WlbyskWD3ZLmFGbYG9pe89DkUbHpORlgv2ru5NmGSaRN40jj7/
 yTQSq/GO28GRJtLTu7UrG7rAi5PedeuASlr70EujrfM4y3t9UV8pzVMdUNvsZkQkqleej57H0I3
 n/6FkBrPW2/7M8QayOBGKHbIgvR1Bl/+7u1t18qUx+yibhKzzP7GgNDy3t/9MSBNKDvaEu/r9+I
 bJ1yte3/41LfBVmciQViBolWkxo21XkJj5Fg4jmzc
X-Received: by 2002:ac8:5855:0:b0:517:7188:c47a with SMTP id
 d75a77b69052e-52d58496330mr9304541cf.2.1786430530631; 
 Mon, 10 Aug 2026 23:42:10 -0700 (PDT)
X-Received: by 2002:ac8:5855:0:b0:517:7188:c47a with SMTP id
 d75a77b69052e-52d58496330mr9304231cf.2.1786430530333; 
 Mon, 10 Aug 2026 23:42:10 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a7162f8sm1711012f8f.25.2026.08.10.23.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 23:42:09 -0700 (PDT)
Message-ID: <fd065888-042f-4f08-8835-2b8ec1720c09@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:42:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] tcg: Simplify bswap/hswap expansion using bitswap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811045605.1246543-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1NCBTYWx0ZWRfX1wszB4B4TLm4
 r12cb9KBjsOzbRSta60kYpACkXHme0cNCAgFAAkIzBfOmLpG3VnPblUGCDL4Fh20HGRIW302EPj
 uAr0AtintnwQc1oWlykQHRQbCMi1d40=
X-Proofpoint-GUID: vFSIz_0JJRk8sYPKECU6pHYG3dIy0y46
X-Proofpoint-ORIG-GUID: vFSIz_0JJRk8sYPKECU6pHYG3dIy0y46
X-Authority-Analysis: v=2.4 cv=cfDiaHDM c=1 sm=1 tr=0 ts=6a7ac443 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1NCBTYWx0ZWRfX6NOQxDnBkaUx
 PywlZvzXbipMoAEmgUGiLQ60VfUM+FiZJXyURQlStIlVwd9LT98EPoWz1UBTg3L63kdmS+94pgJ
 mdkRani5a3SYFUqEm3Fls9McaYF4JMrv55axuU2ejpVI0KplPV+2O+7vMq+gKQrphgD6lruQ1aK
 POx0l1SqZNQxPh1IVFr8JNrexsoZPTBQBc8P2ciTxbH2r68v4bIYFdGgED5BFA7DwpBrJRLH71f
 ypwDnbO2StcLpuu1R+b6iIaZP6v9dewzbJX8RrqWvI3KkYdFOSWDwGwaDEFVm4kQEKiK7yAFx2N
 xMavUkTr/stlGluL5yxRQ7Yr+ShDoI5gnPeFM6yS9ny7DrQN6mc3azRj70WCcVVMNgCfhVJJXSO
 A3ttftVIxBVtgLDeIyFHgaJtFlWbISVt9g6BO0VFx9IP+QLZL0FiFfGgRej3rWEVtTCiarF3nuh
 JK1x7APooZrgr29uJgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110054
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

On 11/8/26 06:55, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 72 ++++++----------------------------------------------
>   1 file changed, 8 insertions(+), 64 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

