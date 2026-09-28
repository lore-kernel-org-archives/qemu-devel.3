Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7ACCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7ys-00048S-Ck; Mon, 28 Sep 2026 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7yf-00046o-Eg
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:48:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7yd-0007jR-KJ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:48:53 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M8on2057202
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W+f+vDawG9EjEDyE0ztPTZnCrttNeNrBYBwpzvFzOTg=; b=UujtgG4i4WFLapzL
 d4LJMss6Zem9cRBIMkSsj4o8QGMrum/AsOBCpQQWPiutPabZ+5u+W5SECSLi0vpM
 LO36J87nQ7MvzQ/Tv3ULrpECKzNHQNs89bmo1JDbB22bJJC5nLcpZdvMa5+6bw6F
 B8D+9B8+y0TcbB2Dqe1byjtGtuoynhWXgATho6kxAzOSeOz8Dahuvtzl85DdyewT
 sALWv+E5+nSoIToLgYEmhZhQPJeK0BfE2VCy+W/vhYYJNINYK0UEWvOl/K1shGY1
 akaVOFtg24Fycisxqj3wFF176M3qqko8UBfzgozccOXRiW4V3dlqkhpIoG6fzPW0
 DWgRlw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubgyhk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:48:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-914489c39c4so15909556d6.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588926; x=1791193726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W+f+vDawG9EjEDyE0ztPTZnCrttNeNrBYBwpzvFzOTg=;
 b=WcoVpakNvn/O2MQGZ9lGhCjXr/DBkzwL0E7LwBdKQRFQr42LwU3bsL+yTnpd8BcR2t
 2kBqDrlntkfLQHoZQG0sSHoi9J8JFWqTFReBAE1VVVgVeoDo3FevsMB7feyNDrzjGHhF
 ctAQnne9gYl12xp18YxMoAwOedo2iq/RK59USBfl06P+1zQp+Dlxh225dW9hVKwV/qjn
 fYSBczBxQHor9HBHGJPml7QsGpafHKxFUo+ZerGa1uhXwcvfInQ2ZImRdNBDGQ7tVPQX
 aVe4tDNTrVh7kg1yA42EOFxZAY/JlGNAyBnZmw5SBjl5DL04bFcZsvlDiX9351Gm+z77
 6gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588926; x=1791193726;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W+f+vDawG9EjEDyE0ztPTZnCrttNeNrBYBwpzvFzOTg=;
 b=GM/kh1oRXajA0UtTSG1dvcY5QqcMnCASOeAKQoDQ6ED3H0TW9wNeXMfwAdNesKAp7j
 MUWTNeuQlh8R6rORuK35wmkDL3gRU1nFFAKZEidn0/ebZ3RtgYKzQtTelPkjb551XFk2
 26W39taW+2jmRvLyf6UI6ZhYmKivyEafoyMziBFu6Sc4U2EhrzjhsKlrPEgfXx57i+69
 K6t0a/0FQY2bbCZJLH4vyTsPi5UtJO1s+Pm03ZarAiENB4wXHb8KcKc3NOkRI6QdXMn7
 6cBZOwixNVuFWgo9Md8xLWxZvnTfsXrpZgk7ISZrGwvLW1j8II0Ek9f6G0PQG7PeSkgj
 tJow==
X-Forwarded-Encrypted: i=1;
 AKwUvByFTUAtoV4sg06xiiAVTTgeG32zjy0HqEYP0STxhD9T9urlCa/xefHqme2iL7PVInuIont3E4dLhU/j@nongnu.org
X-Gm-Message-State: AFuF++n7aAEyH5yJoy3ZPcd0ljnvJo5PiCbp9qR1ofFq7V/FKuy6UsBC
 iwwt+Kd0HWQHSDBPbHC8ztH12lQdh12tgOYqd/9x8fIAERl35cLq6DfyBjwSz6lUY8ay+7+WbtT
 UZZdFG0UWbBjTO8gMnMmI28RWkaIIAFQF/RnymmA9ndKBMFu1mHaXYznWdA==
X-Gm-Gg: AYBFou0HtiqNRAW6EknG142kGBpzl2DZgIg/0u6SSSuCn0u9FL2AdV2Lfn0eXYiKUbT
 EKi8W+xbZWsBqhqkRJ1JBljvuGunrqgXevlIx+aR6I+iuxh+/kKXmRzATjf3LdEuCUVNgq9Z22R
 abZ0SxEArfV8/i112sO1ZmeGSfT80qMA38K3aStPAg/MusgV9oaK77KrYdPxtO2JCvMs5IGaI1N
 H2KfpaQBKO2Vui9UJEpFyLr5G965DF3Or68r4nhgV1Nwo3MFB42Tn72PyDupBq+GaYMTG33d1MH
 RhE1pLr+UWVsPw1ijaCQ/vXxyBjPaGQIQcRkvBhHkzx6A4voejEqDO1CQ9NxSEkD+ZbcExomKA0
 xLcl1H07MA+In/qMn4xZ4uEsRm8SQhGMcAg==
X-Received: by 2002:a05:622a:5597:b0:532:af50:8d7d with SMTP id
 d75a77b69052e-5330b68e180mr189807001cf.33.1790588925884; 
 Mon, 28 Sep 2026 02:48:45 -0700 (PDT)
X-Received: by 2002:a05:622a:5597:b0:532:af50:8d7d with SMTP id
 d75a77b69052e-5330b68e180mr189806791cf.33.1790588925447; 
 Mon, 28 Sep 2026 02:48:45 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef4fc959sm238496165e9.2.2026.09.28.02.48.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:48:44 -0700 (PDT)
Message-ID: <39bb3bb7-2614-4df3-b46b-b41a9e194c67@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 031/101] tcg: Generic expansion of tcg_gen_muli_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-32-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 73NOStJaoO9tADdCKTZ5tSmPbPNdoQ7N
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba37fe cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 73NOStJaoO9tADdCKTZ5tSmPbPNdoQ7N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX4cxY9O1+j5vo
 QVG8PzLlCIiy4Rx9xfIWE9EYc0KeQJXHmaB2aBZs4TQa0qwpPhcs4EFXS7AWtVa3h828z2kFBEX
 pWKugvl2PDyfdL3SYo4c3McBXr88Pb+HQ2gpwjj/39mPaFWHP9Yy0W/nDYgMKcvMCBlFuGXV+K0
 8TiKzhvG23Q+9aOr7Lu8fsT+7gCW7RVKq2nDUuFOsuh+H2Wjd1s/CAbG5+Q6N5UVN7EpzFyrTLV
 t0RAMAQlWrsjgpUFgx6irskndoJld7wVHu0O0Q5DD9auSvBwGQs3HTFWzkSb4c+jw8YZa2JG8U2
 8H9vsrVy+I74vRSY72ZnqZkZITK4oKVJrvJEJo22BkOeNihGG5Aq1vo14tRcHHvLjAzofaLOqNr
 zZOzOPAh/QWZQRvmoJfLTmnVQAhzdka/+CbvxVfQJKKRzqJrKnzxBnAZBuEHA8VyvYRHOU9kkhY
 dj9r7360Wx0GflZyBcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX/PckRubrrZMi
 CCSYDwWUaTI8IRSeR0nFWErl17KA1tet3SDaaJYBwbwKFo9SyslHMB2PvfmLISP7bevmjyWS8o+
 oKBuZW8Wk/ChH2tLYqAgeeX4XnO1Rmk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280038
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 33 +++++++++++----------------------
>   3 files changed, 12 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

