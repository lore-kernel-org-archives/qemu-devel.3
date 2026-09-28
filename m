Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCB1CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDV2-0006B3-5v; Mon, 28 Sep 2026 11:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDUz-0006Am-OU
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:42:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDUu-0004qp-0p
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:42:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEdxo52863988
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 15:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gJ8ExRsx0IVvhbnpegRBRfIS8563P7tMxhwh49xL/dw=; b=gGJ+7sgU/IJQQpVw
 5CHdGo2uW2Yzc2BMOonLOpyjUXWoam7Ss3O/e3QNhiCv0wXrYTrekLSDcRMU7rPx
 g0wmb21Ejhcs3WujxV1Eth006AIWYnZbu9ebScMXN+aV+xTFoBYHULjzA9Rn/2TH
 FNYFkaHkbaIL7NeHBCmBAHJ40CCvXHvq8+jYXSgClQAizFg1eDgi8gVaLUgI533H
 QJ2VkHkWdLGKqFNqzQ4HW95pQnDlWzSUNnX56N1mkbN/ai/qbi0mi5FQltNGZaeb
 DJPYBDj0eK/Acy/B5Rg3bVBUSvL3XnEEBDiL1vz28tUWd1QT9g35doJr3LgyMC8z
 HBA6Ww==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t29a4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 15:42:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91452ce83b9so29995956d6.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790610149; x=1791214949; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJ8ExRsx0IVvhbnpegRBRfIS8563P7tMxhwh49xL/dw=;
 b=WZ6RmcR33pg9diIfaY0KwKnYS3pYZXw5i0pYcS3E8r+qNfJgnIOtaYa5ssCNVfFnwO
 l5P5bu0YddMdP1Xp3TGp6CbjQmbZNGV750/uDE5qBWlYER6msmeOOF1IbuwfReXMlosS
 u9iwehLu/oKo5bcgoyJCFN6dUcCfQ8pwbXAz2i6g+0XnhKlUPlHIXy38qPH9rtlGWLDA
 bk9gvYzzI9ML+mJjJvo+0woNGZH7fPRetue+Sltq+It+sBM/0NUdqNb7H9VoHNc82B5V
 QucfSRfjqg9uhy1OqnXzGULQJ7JoZDP6fxnButRY2ZGSz6iF9yBsK/ppA6bIVhEhjhD4
 O5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610149; x=1791214949;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJ8ExRsx0IVvhbnpegRBRfIS8563P7tMxhwh49xL/dw=;
 b=NtiA5BO8dvvtAuxhNDV/3h+WCyKV1VEPVIqr73nZ6/hU4N21x4RmiTdjx+ACkAyHRF
 nydkzIuDaUGf9gpPOMeXmtBLfbUqJuqVdA05/aeAI027hiRQRVvo5Mg09cowfnbKRwMx
 1T2PEJxvUcdPf7+tgRgCvoPvFyAewcbJG6Ao4VAyxmjjJxIpF1lxGLOarXMR7EjWqBRv
 4nnJMdB94a/Nkf0Ahzngo2o5osRCIvefGHgi3n07CcLHok4GwtM+v3KV4lvjb9oLfuB9
 pQHvFtvElTotL68h1yXBgBzfbAob1WTyvf6GnsVuNnW2X92ply36dse0ZIDQGZXrrGYY
 JwHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpOeKLGJZpoRQ6P6PYNHyi0ojnFu/XTVktWLWrpRqDn0cTZBFNkLtpnphPPumoWFZ8xL9q5CGddfKS@nongnu.org
X-Gm-Message-State: AFuF++lRcpihGk3Duj8E0TitQfrYmXMRjHWggNJjzKHb/VYOSLTpmt7Y
 KEKcsZW9XAOqICUynrcvLN/GdO4q+ISAOQ/Wcmzmx8tXUQuTcyxU3Smfr9ksYw0AECK5B727lco
 kiEqXd7ohKxyXPsixQB3aoR83Qj7EDNswVjzL2YFBARFbGmKRUL1ZhwDc4w==
X-Gm-Gg: AYBFou0BaqP9ZV8uoI+0t9iq3R/zL5/aY8SYftEjSLof418EXN1KKYt1823dpZlMCPv
 up4B4shgdkxoraap9ciLUijLwiBvgyqbqLCpvubIrhF42jZu7hwq0ljf7zRkKwx8tlkZUgM4GDH
 LyIghdBwUDxJW1w8BuokKj/rblGpnll5DQ1ssf99NoZaT8mfygSXNq8evpUI9WZ4lbhR5we9Rac
 t9LxmOozN0iMW9vwz+btP1xhO+guyILqfVYTdmEqWWECZJSeCO9/3cNACqYs5pYT3oF9B0zZbef
 HJDFgq+zfUV76jZ03sHiuOneb8ndUd4l7KtOTKpHtar9ZBU5HZH7tgGJqoHGrngQB7nA6WrDOgy
 D7KHXtuCIyqYQNFTdSuUByjhg1kP0mzlTdw==
X-Received: by 2002:a05:620a:690d:b0:93b:eb9a:ca47 with SMTP id
 af79cd13be357-93c43cb6afbmr2171645085a.31.1790610148869; 
 Mon, 28 Sep 2026 08:42:28 -0700 (PDT)
X-Received: by 2002:a05:620a:690d:b0:93b:eb9a:ca47 with SMTP id
 af79cd13be357-93c43cb6afbmr2171638485a.31.1790610148199; 
 Mon, 28 Sep 2026 08:42:28 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a3625ccsm30083295f8f.22.2026.09.28.08.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 08:42:27 -0700 (PDT)
Message-ID: <117acca2-d586-4b1e-a5f0-b5fc1cc469eb@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 17:42:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 030/101] tcg: Generic expansion of tcg_gen_xori_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-31-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfXz+wF0g7HtQO0
 MQ2u21DaQJF91d2ihYJA7N8A5mvcDW0X2jC/1WZLaFRl1XfQUpo77BNGGS1FMtVLfw05T48r0ZS
 Y+BRbgwRqAyui+EDqHKUQE6S/VaU7jpTxgRBaNtZOvyDFLTX9U+hS/jquuC1S1EPrr2r16+g78y
 fWPJrsqWMosIaNkpofX85rULhI36KBJKuyb7er2ECM3viYCZlQ80vjKK/CH7MpOLZYOU6tLvcR9
 cmkhQp2tHmsvvHcpjK7S91uoajKc3Dw3eW0Zrt2bqNTKxmA8G9NOLUdSuxA75Wn/e9BcfhIiY8a
 fZw38wQfzjRFafouwNKFzOiCP4b/9Ms5/QiLyqbztp/ZckM/VMS5GGLb2BynD90Q7HacFKG7aiy
 K4HSSLJLEHbT5bH+m/FV5VZASjz8gPjUy6Ndq9gdESCSvFUo6og0SX6Wi6UAlx24JaBImX4U6eH
 We6zA/iicjqsOpx6c9w==
X-Proofpoint-ORIG-GUID: 5PQIaUlEYFNFUwg2hEDhbOhmhf6eNaOy
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba8ae6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5PQIaUlEYFNFUwg2hEDhbOhmhf6eNaOy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX+yksXW1jrDco
 8l6lzGNP4jtdPpuJSsj7I1W/VPJRNUVl4HWxkQy8VSB1Y1BK+gizDF3UvSWRYUKpT8+3Quzv6hu
 g8+aTNIjlu3wK1DWpp8oQ2PQBkqUPgo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280062
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
>   tcg/tcg-op.c                 | 34 +++++++++-------------------------
>   3 files changed, 10 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

