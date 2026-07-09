Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C559C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmJq-0008V4-Q9; Thu, 09 Jul 2026 06:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whmJp-0008Uu-SF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:49:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whmJo-0002wv-0m
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:49:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669AiIRM1436933
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 10:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2n6tlerMAHjqwQImBwNF/d2lQqhj2OH/GyPyDXEuCKM=; b=VWnQh1CF9FDGl/zQ
 ekw1kL7WzyKdyr4o7J9OoTyHIFT1KVOPVSgO6F9ChwSa99USf5aYeaBf2IOGDWaD
 /P9o+qNuGpTyr4B0xeKzbtHsbh2jFqSrTQMjLobt5AG7KjL+yMI4TzZgYJErXnId
 eojcoSp0ZBA6q5joegpQwflhlerxE3rrFxF2MRRc4agn+2zb5ZaZO1J3ljCsaa51
 IwgVgMHkuJ5exU+GlY7CzVRNCgLb2brqBqjPR4F/+vw4qlSeswqvUQv/dQS2hoDK
 saBfMVG38XTgVmw/9RPK9S0jQZ8L79r3C0iu0oiEushthIjlmUDxizL/DNEO/KSD
 LQ5DfA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u3ca8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 10:49:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso13747421cf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783594161; x=1784198961; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2n6tlerMAHjqwQImBwNF/d2lQqhj2OH/GyPyDXEuCKM=;
 b=hRJBNUnTuX7EbyzGqootj4cdV+GMFfuNRaZ6UG+3yAla0mcCvw+583zFxaSYy9zqwR
 JoE0ijQiVMutF7J2HibkCbgVyroS0m2EnpI9mocYgHLSHtCUc5PIwRvfwItVfhqakMFk
 /99BfswhQ9ZM70wPDaMTVb8M7lRrOZfTrRZWKHKPjL+gm8Pi0PIwiB/2zJe75RzNOFKk
 pYy1YIKRiKwM3r+VGblTblLGtrxdT0At5XJNVQi96EpH6+lOPek+ZcKNNygBi++0AY9w
 Z00tedZo9kS7UG37ndkulyNzTIwOAJ+glmqMClKDDsgoCb7gF+0+BqafjwlGkXCSeXnV
 km8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783594161; x=1784198961;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2n6tlerMAHjqwQImBwNF/d2lQqhj2OH/GyPyDXEuCKM=;
 b=hAfs5+BgL0Wk5Vuy6q58lsrx8Q3JLIG8QR9AA5syP1w02oc3Ib6NqR1I8eZ+ilwE58
 1FqJ9bzHbuUPgAdEbGxplnXpQNCeeQJUpS/ROvZpQcnVKzBStdyXn2h6yxC34D2Yh+fl
 xMxaRWCOE41y9ZLgtiU+WaqrbQKi++1wZtgd6GjoenNTqyUq2Wv9Nc/AwtGWvNpYT/tS
 BdfTzhqL9x9bjMHy3WKRohKBM/GU5CHrmKhkMdHWdh0yvf6YwcFVrNVSXYlaww+GCA8I
 8qT8a4BcCGqRorUNcHDNL3dMviWUiNs+vB01S0anED2ujdLhBTzut4sV4FDjyzEvfoL/
 +M9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8Jp0NFzjvJGQCCPPDmqy9lVrBjmN+S0JFT0RBf8GewG9Blixk5XQ4oiFhqw2n6du9SfskN9jqlpmp@nongnu.org
X-Gm-Message-State: AOJu0YyhuAqkYRep1ZNF+Y2sMrrAYeyDR5e7SHg+FEBM1OuUYNb5CZiU
 dKq7iU7L5KoSZf8hBh95yMBm4T58d4ExdNibGHsv3XzWyusWu8CdUpl/mzvQzRw+qdTPLLGzf8U
 FX5jCvf/HjAgS73cBMLl5EK560fZey1bvl3A4rWvkzKIDFBgN9QjXuHBT2Q==
X-Gm-Gg: AfdE7clGF0hFo+AjhkL0ue2ZKWEzrPxurGpKMWtwKqFdbIJTAnMk+ul56lbvnTRr3a7
 yrOLCn9tOkMDz4e0TREvckUDXBpqfLk8kSQVTZtJqp1ZHNN54/tUU9ztf+/ajY7ys8jMmDPgLog
 ZZzU5cyja4gygktmpAK4eNGC6F75lKW4eafZLqmZUkHyJBPrTOgbwndEUxUX88WWDatElpZsxOo
 ZFYYPyr9Uy0iriceC3Yx5A2WUitItjzQGgZLXOc+W2ZHlLiiOcJV1xPPcjvQZGAZXy57jHDfd95
 23H7UqwgNVj+FwbJg5RSzY0C5HTBRb2j6wwy51Ye158n4BywNPCCK91mr3NEI5U94WBMy1oX0oR
 GRUX3N7nUKSJu9PULBHReJglD7Amy1rFt0SLE8r0W9NNVCgp0NfrcuBqmC67aYA==
X-Received: by 2002:a05:622a:1b94:b0:51c:19af:6330 with SMTP id
 d75a77b69052e-51c8b2e4600mr67973611cf.36.1783594161135; 
 Thu, 09 Jul 2026 03:49:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1b94:b0:51c:19af:6330 with SMTP id
 d75a77b69052e-51c8b2e4600mr67973291cf.36.1783594160761; 
 Thu, 09 Jul 2026 03:49:20 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm52233131f8f.21.2026.07.09.03.49.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 03:49:19 -0700 (PDT)
Message-ID: <3f808266-b208-4881-84ba-fd1180c18459@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 12:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/91] tests/tcg/meson.build: add logic to skip tests
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
 <20260706223343.988769-22-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-22-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwMyBTYWx0ZWRfX8YxSafSiMcqn
 mwFy/1jo1dmi6VFRSMSuhZMkMZnHZedL0OuHPiuHZznyEHu7dpuLjrbw5j9oyh0tlFN13f7DVkd
 rv2CX5NyjauiHgL9AoQFP17UU7QTJVQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwMyBTYWx0ZWRfX1U7mAmOrO5d8
 6PSF8BAYIYaK4y0dVQ3Lrf91EpgYQlfNvYGi2I27BhtxmrpUUHAmTU1gyocHVd81Dj1GsP/TnHo
 ek2zvfC35tEhK7JrNQtWtEaREVmCw6JkBRmynLgh3a3glPt/qrt6Mu8hbmghjiqWvP/1qFk/YP2
 osWMTg9R7N4NtTT/KjXWxgPA175ihWhUmOAHI8/igNfnPeE1xq4kvNW5QJCtZRURtcv7HP9LGUW
 DNXyCu2pwYY+g7sEzx6XVQcDJv+jbx2RkOywc/+7DewPHJjfeBhJt4SFT2z/Py8oPkaS5XXIydp
 fje5WJKUBh7fFm3x90+F3b5YqhYGqVCMACyYLAS+0UAUYuXTL4iLkfnlTqw72kByD7Be7FxRQxz
 +lJDSDfDqgRNvMm1g+YToZMrLghyN8flV+1AGPHgDN6F6b99g1TmswQ6YFjF5pSHtNadOjw1xmC
 s1wrqRQ47gmUvZ85yEA==
X-Proofpoint-GUID: nsvDQOu2AzYCjp7NtH-cJOV1yHHITnrl
X-Proofpoint-ORIG-GUID: nsvDQOu2AzYCjp7NtH-cJOV1yHHITnrl
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4f7cb2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090103
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

On 7/7/26 00:32, Pierrick Bouvier wrote:
> Instead of skipping tests and not declare them, always declare them and
> simply return an exit code 77 (SKIPPED for meson) and print reason why
> test is skipped.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

