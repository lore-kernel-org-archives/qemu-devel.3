Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1F3C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzE1-0007VH-EP; Tue, 07 Jul 2026 02:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgzDz-0007V4-R6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:24:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgzDy-0003ly-EZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:24:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6676KQ5V2922442
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BZiyjh/6THqBRC9A6NGP6YMLHdYhc+H9ar32mbGngwA=; b=NR5vTwsh2ww/FsEp
 gr9gFzwpxHcoR1sk1PYWCc4WRnOKV9+J+th8JOCQXa0BhAJj6hpn+DwqiBG8Wz6W
 IAsW+tPy2xk8ZtQyMpWwD4RD1BC0X8b/0Gegvp0+CMn8e82ydwqdSpJ7txKkqiII
 zH2R9QYDpilCO1uDnc7CCnEdS+IPFlcbOLwe0bpAexjWyw69DbumJgN3OLhUA2am
 buYNEvcNbqJzI+sprDB17T5KSO7wC/qx4Lbam/R/NXwRXWDX6ebBWC+b10fqq/5R
 szsqwN0aC5kbgYHR8Y/7NJBC/z03nIp4xEDm/1nEiRHoA760RRKdqSCYC9XkeIUE
 1rWs1Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t80cw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:24:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e623b0e95so319191985a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783405444; x=1784010244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BZiyjh/6THqBRC9A6NGP6YMLHdYhc+H9ar32mbGngwA=;
 b=XdcHTjYaruJVQnz/ZZw/0B7WyHM15iIM9lD0Smw0RImX6ySfLdg2q6l6Yl18BEatNE
 +QRfkyVBMUcOOYtfU1SuiURY/YsphR7aIW8xybuUxWY79OV5N0ptnBs9JS/Qsb6XGIIz
 hSJmy8VuaGwsgxew48wZ35Y4c97nLmlgJ5De4Tf7RYoC0kyiZGnYaoiOT/W98DkxQIK7
 rinKRcttybeQET9XRz2vVsd5t9RNkVrvGeJAys8s7hRKlr6RHBp4vP5yPMHzL64NZi89
 IjYzZV4E1lOObNeVClT/Z2nQv+oyDE2xYyIMFibzBox/j4uE9TWU7KFNoM0qcu7RcE6i
 /kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783405444; x=1784010244;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZiyjh/6THqBRC9A6NGP6YMLHdYhc+H9ar32mbGngwA=;
 b=XsIgmrUcufS2Pw+wzcAatKqLlZPIFa4NHLu7KyJDYzsciYtfA/dRrXyUd9A3GEzwBO
 kcwnpUXFpBnpNcAM0dkWQgLSjiTj0sWY7OqkgcnwowfXJ0Tq8lkC+YvdBPe6u/jvrw06
 c+0uhAVLcjUR0l4bDDPEpnkZIIvuBL6rjdA5lPD/ldXD+6S8Kc/rumLxPw9c0ILpnDgI
 7UG4ANXl0zzqpqcldJh4Sw9bCbELANuMk3KJdIlG7uQzgUDGcwwkGpJ1nBjmIZ7CBW3i
 XwWaT99LyLRqecVlmV0RSBW6tNJM/7EsJRZdtcHgbYkeBDOXreXYPBbkFQhG+dWBNm6T
 c1JQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9FrGOrCtQR91QLDFP+dXPk9oSapjbtTUq3pGKg8rU1hhSiG2Ndt3b6KeARvD7WOaV7iw/jdIuykU7@nongnu.org
X-Gm-Message-State: AOJu0YxatyPGfrAtVHaFawFFZIIvqB5/Fpg0Ml/fsbJ0+w08NYGyB2OC
 kjA7ceYk453EGtfXA7gECqjP/u3QeNggSgE7aGyPMTk8EYPVc/DQniOXaCdNVFKaSgqf7xuB39f
 vAc+mf4UHO1W5eHmUFjC7QFcgEVwndpUHTWzc4UogPXubYZPaIZX8DaxzIg==
X-Gm-Gg: AfdE7clTqOTme0m+yB/W5K7etAlvkz9epVwmRt/e2LSr69nrkndfsgznPssg4DhJOe6
 rS8rkr8KhzrRMlZDPjaYAhr3F/bNcBlRAyBpB7VPvqfE4JZ4Dg1dU6j88XO/zZBOE2ATgzHmtmB
 biCv3S8/f/w6xfDP5RTAJH//9KFoD3bz5+4+DBm8u8P/c+nHevcqIdn/MTM7YNEzfL+9GVpdDIz
 NLU8FWO2Vnn3m7G9oRsXgJMy30sSpJeu3lPfKFp+V1vv7m+QMNnzvEjVRv/MhSVjP1y8JoiaVkf
 TKrzR1aisP2bEC0BnQk+K1bWcRm7FXGbHoC6tRNKwMQl/mRDrRPnceuC6ciLd7zTQLURjoSvieO
 UJNRtJp+ymABx97DfBT9xxyUJzb7ntbI9RF/6zKK2NGHOxrco7dcFAwGLTLWgsQ==
X-Received: by 2002:ac8:5dd3:0:b0:51b:f40b:2fb5 with SMTP id
 d75a77b69052e-51c747e64b5mr41719641cf.17.1783405443926; 
 Mon, 06 Jul 2026 23:24:03 -0700 (PDT)
X-Received: by 2002:ac8:5dd3:0:b0:51b:f40b:2fb5 with SMTP id
 d75a77b69052e-51c747e64b5mr41719361cf.17.1783405443411; 
 Mon, 06 Jul 2026 23:24:03 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f32660sm30405535e9.2.2026.07.06.23.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:24:02 -0700 (PDT)
Message-ID: <94f0c417-d97a-4b0c-a2d8-bb66b0eb06ef@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 43/91] tests/tcg/hexagon/overflow.c: add missing include
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-44-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-44-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wWfpNGnWBG3HOtjfsxbO2IRMVnGKRvoN
X-Proofpoint-ORIG-GUID: wWfpNGnWBG3HOtjfsxbO2IRMVnGKRvoN
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4c9b84 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX4JerQ0Z+t4v4
 Ic7SQzIXmiySB2c60i1aNq+NhpFDmrp1dAyxiFboSzq3gIXdPasEbpI5jJf7KrRBCiQRr0AGG+6
 cail/Z/1T/ZaM3mGRQ6g13G8+oApNqRbz+fDyz9fyRkALiXMJ0BDsx3xdLY1hu98rWHMSPA+GXM
 whcleQmXpGusOpp9HY42rmP0F34DKsF38nQAxWlcrjIseNyxO8CUwqPoXXH+vnmWagwXdeIXnBr
 QkvIMUorNgYgPsxvVpR34Iy8w6UmjR+XIhGi5yUMLOrHdbtP/ZnkM0IoVAsY6JvZ8g+ayLyzqbi
 HSJSa5U2iUNdAmXbD5FuAYqllIru1pnb/levbs0VwgPXFneTRYdDUkNC5uPjKCambIyDRG9ScOP
 jbb13NAv2zEUPJVoJTUk2fSBaNRHVo9IhckQYol4dN6doSPdLfYBrj4FG2krOcIBdvwYwusnl/D
 nNs+Hvb2Ji/0YcqiwRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfXxwVlXeYDN06U
 4Pou+E2yeMCayLm0HkytFnu9BLsTGaPKSTgjZPVHfoHhhGbKZog7KML2rBS4lwczrTxFO6N6ig9
 EXBYuG4kfmaNrLIPGY/mFLK/2cy9c9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070058
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

On 7/7/26 00:32, Pierrick Bouvier wrote:
> ../tests/tcg/hexagon/overflow.c:59:1: error: unknown type name 'bool'
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/hexagon/overflow.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

