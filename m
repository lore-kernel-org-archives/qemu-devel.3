Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C74CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPxs-00019j-Qe; Wed, 24 Jun 2026 11:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcPxj-00019O-KR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:56:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcPxf-0001A1-WE
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:56:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfJ4q3300991
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 15:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FVNkk2krXTfsL59fYbCMYRzONLbzYXEbb1/AnCkaF5g=; b=XgWL2IguXHGJshWu
 hdYE9oZrKS2Zu2KpAdBKyNhjhvdq/QTnxz00hzUeR5l2/S9LvTSuhxzD/Bx2hzfd
 mHyemXdobJ1DpoCnXhh3pN0RVnhG7cyPglmFj5FOJcV3zd4Y0OQ6JH1WIK61mbXW
 XUbcu/3nB2wlrA1B7txtbRe8XZZQbGYSfvlQOZdbAmaE/FpBSHG0v6GrB7yFuIJH
 ZsPL9qzML9MyJUDGm8yJ5Z2xae1N0KCNsjdgh+9zshHZoXHyKEUYBzCmDNdhGrtq
 jpOetp7sIqe8U9rV2TThtoLjQm3Fg1fl/bgcRJj0gIzvXb3OsjqabmvqtErcu0U5
 h2tdhA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05aqb345-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 15:56:22 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6c89de84f33so1309331137.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782316581; x=1782921381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FVNkk2krXTfsL59fYbCMYRzONLbzYXEbb1/AnCkaF5g=;
 b=LRfaSjcObsPlNZYynTy4d89C4XK5KUeLFDDazQWFJx/GtIQnSk4f6l8GBnj+lp+Bmr
 e7SoWR67Q2jbrAq3FNkuz+O1PrC+xdkJoD1mhEv3BWTASEtECbN+m0jxCsZhiktmTh/+
 NCzzaBdW5Iv5iMwVIrFXBsKSDwsZgYjc0lXlTip7G7J+WfuPkgl170gUx/SHp2WUfiia
 0mCXfIKmr7H/GxJhKmx56gY9a7m9OCH9RNXmd6/G+ZgWRmgL50gZxo4GmOS0D87WVkBZ
 UAxquSBCWyw5W15xChEowuGQ6QnkX3gipv0Viwgff7RTfOVirleW2wqLNS5BxBdXNcGc
 am/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782316581; x=1782921381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FVNkk2krXTfsL59fYbCMYRzONLbzYXEbb1/AnCkaF5g=;
 b=eavNlFypu1VT+fZNrnPjsqhlXGIxvWlEBoddpWPT1lPJvXD6KruxyybdLnM/53uiKw
 hRK+66QHln1RIEY3tgo3WsHERtiHHoOGHFskd6ADooLAVlT/c6grDGKsDNdgjOax2s0z
 Bi30TRNPFFn+1WzNG8SBLdmH6oR3qtIJERwvi7YbiQVwuZi+e4ZmPPtiSTsrwcrNWfmx
 FJTAJ+95ap6QnTWgtRp1kcKy4xLpPvT3uiI2Oqetd+VN2/WJ4j+Uu/lYOBKwFQ+JRAsp
 5pa0Q8QuxqEe9xJea+k/Qrp4W5nqY465T8ouTPrsyOh8p5Uh9kuD8nuk//88C22sUt1n
 CFgA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrESOY5XBJUHHMyZP/d1YTXQOKSQze1DG0uHdce83ZO4llCFooC2TlQdgSGTXpdqQVi8kMTD3QUaonR@nongnu.org
X-Gm-Message-State: AOJu0Yx9tqBvq3Ev3sHuelErAj6Jt1iVgGJf336vVQAHSPWnldeMn6kR
 CAYMbvf5IoqM1iC6Ys5NkXIcndi5uW/SfGhBuqunragfzufwH6ELck5LVUUo90EXbLVoDneL6xN
 GONqGr3t7db8d0XQBSAMBO5q4WIT0LpB2nc5fDkJi/6ixdeoZpQ6zVqSJZQ==
X-Gm-Gg: AfdE7cmJ70aWOURZ+0cq7zoIW3sZJcmyMY19snXB5Z8i3ezaBBo25SSvjqI7db0exJD
 3tmbr6SRxIWqJeFI0jLaa9GQdI+oezDSTowqRX1vfeU/jAiuKMCTX8ZzlElEG7FDpX6IfICrcwA
 vdfq4MEYpF5hg2Zefqw+DnzATBDiDCdQ1kf0BgyEeh4sRv7J5lWIWryQ7/mctBkjDoVqPDC/Kor
 t2PtVGObQJ8wfQ0gB2lfwKgXvTjJpv1U8ApOJ6JHOSXJPuRiswuGQsRYQr2tt5TedjOWeug5ucu
 kE3/mXBqU6pPzfftneGUHKfJG8Rmvi2WLd3X33shhns3cRv32B9cWKYPTF7EmtjmAK2av/RqF6C
 u3zR1rFFK+iXA1T5v38sFlPWFS7Mq3rZ79hNYIg83UeHn3eIO/VItDfaGqaZc7Q==
X-Received: by 2002:a05:6102:5124:b0:631:4580:6a33 with SMTP id
 ada2fe7eead31-7311552ef6amr2235797137.21.1782316581250; 
 Wed, 24 Jun 2026 08:56:21 -0700 (PDT)
X-Received: by 2002:a05:6102:5124:b0:631:4580:6a33 with SMTP id
 ada2fe7eead31-7311552ef6amr2235767137.21.1782316580861; 
 Wed, 24 Jun 2026 08:56:20 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c225b2988sm7414995f8f.25.2026.06.24.08.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 08:56:20 -0700 (PDT)
Message-ID: <e954e6c5-0a93-4fd1-94fa-5014fffd2ef5@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 17:56:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] tests/tcg/multiarch/system/memory.c: remove unused
 variable
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEzNCBTYWx0ZWRfXwTQm2GJ0+jxi
 p+ewlql3wf4AfNNdn4jdrVlRSj22MPEfbrXoSr4RFYGUFepj2BEr1v4IKRoTOsNeDg6q82bZnm8
 QHVAoqq7q2Snd7NE7Ma8vYx18VVRCBw=
X-Proofpoint-GUID: HjVl0787RSQmnB4BE1dxBmY4BOENAox0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEzNCBTYWx0ZWRfXzhutAtUMlEX5
 mRjiwE/LJzTSIz3akRogqQ1GFBYsoMzQ2OgKN7NqwhmLzM37jiS6Y2BAvuGxTST4c7f6N0l2meu
 qec4PLYLAAaxIWex0XKOuiAx6jKkxk7Piy+EWO0tqXDDfzaITDt9NKkrg1+89O5ciy7O073l5dn
 mesMCjWAoc7DromLkC48L3JS98/SrGGn1egRaIAYpws2M3FsVSuZoEkULDFzzz7MKwDkY0xz+H1
 5MrSWGnVWJeZ+Ayix4NlcbLoS5ZwNWB2J3a+vspYeg6bpX8SV6d80gqdAHN+IMmR/4HblowY0nD
 gV2aZWPrhDivWIB8c9gvoB2YXwbt/V1CSKkrfZKoj98juOsi1VnX01mJsqjCDt90vfL/LK40sKn
 rvtBJdmIhG//f8J5BSS1PjbgpN8LXg==
X-Authority-Analysis: v=2.4 cv=UphT8ewB c=1 sm=1 tr=0 ts=6a3bfe26 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: HjVl0787RSQmnB4BE1dxBmY4BOENAox0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240134
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 9/6/26 23:47, Pierrick Bouvier wrote:
> Caught this since by compiling this file with -Wall, -Werror.
> 
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c: In function ‘init_test_data_s8’:
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c:97:18: error: unused variable ‘bottom’ [-Werror=unused-variable]
>     97 |     uint8_t top, bottom, *ptr = &test_data[0];
>        |                  ^~~~~~
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c:97:13: error: unused variable ‘top’ [-Werror=unused-variable]
>     97 |     uint8_t top, bottom, *ptr = &test_data[0];
>        |             ^~~
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c: In function ‘read_test_data_s8’:
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c:384:14: error: unused variable ‘ok’ [-Werror=unused-variable]
>    384 |         bool ok;
>        |
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/multiarch/system/memory.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

