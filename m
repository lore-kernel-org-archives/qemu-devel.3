Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021A0C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgMt-0004Xc-Mn; Tue, 11 Aug 2026 02:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgMr-0004X8-1b
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:53:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgMp-0007TN-Ld
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:53:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMpvxm3008782
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RqiMKwVv6Q0VTZdsJcqDtE+8MVMVsYUh00La/2h0Yqs=; b=jUT73gDBu+EsTvTj
 VAvHuP9B/5HLPQiRN1G969/5XOvVamiipICV2Hi6crZEqHhzukkxWp0+Plqk7l8Y
 t/7zlZeXIN7BBv6Mka657weqOxsFaXSRWcXari3hSO1SsGr4CB08F/UzZMXyO3JA
 b5X3gDNGytHtPGFZTZdRqB3bHPQM+ha9QhGvno4aL2jkTq55QFy/u0By3DxgLjNN
 H768ASrg0u+kf/2Syd4K7XAET6UWonGPHdJm2SlPBfUDvD6h6CvabWbfyoXgu5oB
 YfsC5mq+0OxZVO23kNAubE42OkXWLyFt8zNzdGWFNuZXTJihpX2MvxFnTBXOwAeF
 4dDblA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjtjrqt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:53:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso51847341cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786431222; x=1787036022; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RqiMKwVv6Q0VTZdsJcqDtE+8MVMVsYUh00La/2h0Yqs=;
 b=ZcxazMq5UtnWQr9d0mjJU2+lK3RHOUaeFVjOR0ULCsQKgYT+DjvqxGo0pOWOhlnVjf
 KVFgX8V6NdSzEQ8fZR8K9k0tI4OE/d4eoJwda7BFP+oxCBBjkLoRwr5GddxjWBenA4hL
 TaQ5ht77CPIduuX4zOS8Naa+dlNf7ko2x3VMJBAemANRXI0LjynPVVUCXlH65vSt84/d
 hMxelee/IVz+JQPwvbPrjLZS70/5XmDGCvadr6o0Yj5nNY1s4Rrely5JPt4T/mTkfaUZ
 LQepEP5zQLhzFVdnNY8DZz2K1hLUpT2G6t+2f6x+yfTd4YF6jTZ6RV278r0Cstwc8Wvb
 ehtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786431222; x=1787036022;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RqiMKwVv6Q0VTZdsJcqDtE+8MVMVsYUh00La/2h0Yqs=;
 b=iH1y6244BJ1+OZf1F4Y7GmdAWjQ9D9hcqrBy0eGTGS7N3icsfexULm61Mj0fFZrgYX
 p4LOmcO+VvHz7eueLDFeR0nbUgQT4nTaMAw7s2kAK5dd2vGWsI7/vDY54upc1ylCvKmo
 yN/8AIwmlNg1PZpVD1fLUqwNr54KKxnc9e8skF6HxVIL6bZHCUXaBZcZE9kSGLd7/ejF
 kk8O2LjhG4/wVjZx4d+QAWlxe9E+8pl2E06lSDO2iPwX2Z3zFetLzm11fN+3fH5oX30p
 Mc/x5uUF0OhlWuIcz2ktHuYBctFpM4JYMsflO7DbTr/X/SpvT1sjEQ/wt/JYjUOwNI8u
 Gw0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCfXSMev0/c9irmHXlYjNGeHCZUNltBEzlpdBrn2OToqOVhiDChWkO48YhrqYWLn7TNo/6vHeaWJlr@nongnu.org
X-Gm-Message-State: AOJu0Yw1ZG+LgsVS+xarmMhAZPKkk8lLV00vWkZuurgYUNCF+Ju8jm7f
 RKi1nTCf8VruMCzuNWQ+xviQ8DvKHdNzCsMEIFXxMJDHS9fORF0dRFYUxgWoNdPTWuZ3v14qOip
 Hh+bPnkKuIgOG7KUZU2RslwXXvo3GNf8qlooxAnMFb+bMKXy1usHQnGBLQA==
X-Gm-Gg: AR+sD10G8vHy6VscnDn9Ya1flc0PmspW+0jLbEvI/Fw/0ly3FI360PW5d5MzlLnWZci
 lbLOfwzy/OqPHv9H1bmS8evEOSAPStXsNuVgCMCldaIhitXFIN3hqwWzmHiOeabUkZcqYPDnaCQ
 VoQ/zUoO5893+AO7BmEIfg5zSp5JdE8jobF85VDUHk5OGRKsKBi0M2pxQKv7WAdFRrK6RLuNVk7
 2tq3j/3idX8Fn4DbhyGG9f2sQUtAMxOY7SO0casN1kLH2pnzUzJnjtT8CnLDhlOJgkCg4bVwGpY
 sDnaxm7e4Jb5GT2/u/Ge7MLZrHLQLcG29pBWrMkyHawv70+IXL1l/kRdyc3iG+RE6yJWaQRKr7M
 9o+MEWfoDwA9H93rVgMb5FUqjxxemoHXtb2k2OiJR
X-Received: by 2002:a05:622a:2614:b0:51c:f8f:13e with SMTP id
 d75a77b69052e-52d58694692mr9825891cf.40.1786431221855; 
 Mon, 10 Aug 2026 23:53:41 -0700 (PDT)
X-Received: by 2002:a05:622a:2614:b0:51c:f8f:13e with SMTP id
 d75a77b69052e-52d58694692mr9825721cf.40.1786431221476; 
 Mon, 10 Aug 2026 23:53:41 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5ac70dsm2451358f8f.5.2026.08.10.23.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 23:53:40 -0700 (PDT)
Message-ID: <40d58867-a792-4609-9604-a70069edaf40@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] tests/tcg/loongarch64: Tidy test_bit.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811045605.1246543-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1NiBTYWx0ZWRfXzBIEsIaf6JS7
 zc/IX7ResMGT7LAgQ7oP9/tGR1GIaBIXCanBtmJ558S/lsPTwEDXPR1PJfi1esVuPdLHdG/L4+I
 x5YL4lgXvFcwmVSCcEZFAKz3cFHKubPNQfpGReCiCkGE2uJA2MhAMQsUrt8SM0lLkcA4XkfJRtc
 NatplAdzRYKXQ+YMKATR9hd6uu1a4ZU5ZaOLVKW5b5F3hfx7VSVSxFbdG0Ygk9d+9N9sSgibi/x
 1f5u/tVH8HWTwg6hy7adJl+hQNf4f+IRdytVjwDDMbymIx3wGh2JJioZLqEXoeGrzdW6TR3PlH+
 7Pb+XHQFNxb1RWDWGbQ9HzFLNPS8iP8z4eI8EG7lTzKlpy8mgrFOW0sqR4SjVPyF1oqBhOCfx0d
 KHE2BkR5ZElC6RPyIeCdTUzC9PiYVa6zK2x8JSuuZzBgkrYMdFVnzSW4ditGIK/moQjE/k9d4k+
 hEqJu7LucJZjTAcJpEg==
X-Proofpoint-ORIG-GUID: HpemnZlzER1tzcLmCCn4VxeOmG04Yyv4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1NiBTYWx0ZWRfX8xnGxCyA1uXQ
 Qw/eIKyQMiGS1dRVB2vvSK2/Acz+xvdi0McmRDwpS/kTrMeXj9OSlJFW4yVreCBdWtnHPC+Qlnc
 SfSjVvAVIv+fMUcvbwomuE7f64RjW3E=
X-Proofpoint-GUID: HpemnZlzER1tzcLmCCn4VxeOmG04Yyv4
X-Authority-Analysis: v=2.4 cv=JsHBas4C c=1 sm=1 tr=0 ts=6a7ac6f6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110056
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 11/8/26 06:56, Richard Henderson wrote:
> Use one macro for all test templates.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/loongarch64/test_bit.c | 69 +++++++-------------------------
>   1 file changed, 15 insertions(+), 54 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

