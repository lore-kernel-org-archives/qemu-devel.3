Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCC8C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJpN-0001uk-QH; Fri, 10 Jul 2026 18:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJpM-0001uc-5c
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:36:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJpK-0005EL-R3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:36:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Ug11752826
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eACMqvxgIUuj70p4pjX/Z0sics5nGP7Iw/hIwAOd7Wo=; b=Mh7n03Rzjsth0WCH
 TN0YD/pH9plftIZXruQ/qEiiEzZYjul49OsF2Overvk1ArRhcxretyqsKy2lHJbk
 iEYykj1HCLcQ3IP/CsIF/zZlDTPuhsKQ7hEhUn6h5FVqWqSEFPNO+SC57K3EdBBg
 +t6Y6WgwNGiSe9CvHx2oggBsa+KzoPeNjZ6sI4izz+fxrywBpBLumEeTEfFFuTmL
 HwOSA7V4bJHA1sl14yVc6PTSROdt8IlRls75RCDYkqXKUvlzm0YfUQfROK13pIm4
 /7rHjXNXQuwMN8t8wykQmol6MHKZfHHFg42jtrvRVrC2SUwp67tFllEXPEHweVnX
 dDVtIQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9mvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:36:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ec45d9628aso1311386d6.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783722969; x=1784327769; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eACMqvxgIUuj70p4pjX/Z0sics5nGP7Iw/hIwAOd7Wo=;
 b=KUu3pL4z822iCxOsUVst51bNwxkxnVZ+AnBsK4F2JxNniQ4iddez2SSQCI6mdw6dHZ
 hT4xWi3Vdu3geXlR5sVQR+qAFgyiorVzkHCMSEXHt+xt2aOggugmxhptQwreNK99fVS1
 REC2ElVUaYoOUMLa8O0tpznI1fXy+/0I8aAcgNK4XiWnTUJvJtZ8zpquvbAaApXKm9f7
 jDfapD1bwAJUptMxZWkdKwRiclkI/x4uXCnDmaLrMxzU+Ylu52fFWKVcw/PFzHjbiYNb
 L2+7fvazKqXwXwWpLsZcT4isdz4jJqLwNtZXmsgyYOVDtJxdYDWRZ1RfMd0ldMpUSafi
 /TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722969; x=1784327769;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eACMqvxgIUuj70p4pjX/Z0sics5nGP7Iw/hIwAOd7Wo=;
 b=mPaUDXgvAT8iX78giccJx0jXTDRPT4ZTCBktnSw57lP3CD872Ers4upfOlOlqpRPBc
 EFwBKINpDf0Vm+HAX10XXmMdzCTHDcNWC4POg8SQYZMQQbTvyMJ8xfvPNPK7hwcBjQ3T
 dEffRuEvZAWn8tuwfrOSgV/oR3tPVPWbOnop37rIOLLI72w6V0EeSA051yZ/1WdjBnp1
 B4bHyxIGNntaSafQDGFoz21ec+f+s4llXzhHIY3JSj1xR8j0rT+EOw6Q+z55OJ3uKNuJ
 4BCe7bs6sHh+QAlS4+wuXNE8FyVsHjXyn7Y1eudduo7gfhhesxUvr7RYZePFxH8vH13D
 8bmA==
X-Forwarded-Encrypted: i=1;
 AHgh+RooYYa1bAxqjf/Gv1hKLUXSZhK8GBUgPjN4ZjirH7H9jNKff5HCm3M8HZu5yUPKBrYnZHQx1n1FvDqS@nongnu.org
X-Gm-Message-State: AOJu0Ywh2DEHfDQjB/hYaBktnzYeys71XfCiNy7GxsGnm3BvpB72l990
 2rA0qJcq5pMkhyfRw/ieBYqk9v7KokClUsocyeQNRH9lJHEaKnD4WVen39BioJnWgJQwajsT8nc
 +/eBrZ2T45k3VNAt3akVwOKwj315BWv7tPXhEN3CvxiYVetiF8APeFaKHMA==
X-Gm-Gg: AfdE7clGqr9KhnDZcQA68fenoK749vMKMjLf7kxddvYYrZruB1LrLSXPyF0NK78a5vG
 PYeJ83uSuKOdXymt4880KiDBxs920rSR/QZ/oGlQ6R5yr5MdKx4QT0IS2EHVPqx0K7YXOS56j7B
 PvpHkLwje8O3QEVNUWbqJLmMJyxEErKhmekFIpj0X6gs3qs7rurcwVTlH51M9le0TW8pluY9Hq/
 PfbPR6z/2f+v2Gk+IQ5lMcWkWRjCdl1wB0OPXn22RNi6cJR8k5m0MN7VG1ySJhPKh99x7CS1wHx
 I0yGGghPaz/NT5dJRFn/WzFjj9yWcnu0UxFR4Xgf4LXmGSKcxDtv7b3CylfM4eynT8dpEvOQGq7
 wRXsdERsDJrWzl+2Eze/okM3Jhou3ARc8iA1dWyA2inq4h5d8nWnaO0EQFLrZgg==
X-Received: by 2002:a05:622a:53c7:b0:51c:7b12:120b with SMTP id
 d75a77b69052e-51cbf2ff3f6mr9802761cf.73.1783722968884; 
 Fri, 10 Jul 2026 15:36:08 -0700 (PDT)
X-Received: by 2002:a05:622a:53c7:b0:51c:7b12:120b with SMTP id
 d75a77b69052e-51cbf2ff3f6mr9802431cf.73.1783722968514; 
 Fri, 10 Jul 2026 15:36:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f213e8sm61449951f8f.34.2026.07.10.15.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:36:07 -0700 (PDT)
Message-ID: <a5d4d163-efdb-48d9-a1d2-8b185d47abe4@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 96/98] tests/tcg: remove remaining Makefiles
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-97-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-97-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNiBTYWx0ZWRfX1GBMBcnxsokh
 30ikZCUpvst/uhIoov+5/Rt9lmzb3WGmkLM9As3FKZzkQ2HcRQWdFVo6Xo2I6QZhLBQUQs7UjO+
 +7qJs4VB1A1mge2e1MxI8LrB3HTmKKDhKy9y7hUhduznMsC1huU8DigezWmXWokUHqWVU9IOh2v
 kNPnULEAu5v2ScOwbpiXZVyr+O7n/eva6duMhHadIWsbj5EfeLGuMx30IMOVmQyTTn6SOvNNEy/
 5IbHee928PgaJKH4FpQMSgQNuqBIt2HQdm4576fV7V2dHDPY+W0Vw41zHNlZD39j1811ZO3OwAp
 tEpuOXkriPcdJa8rETYVnQi7DyeeNygTvQvCYeikcvI/OAeHDe+d5UOuC3JItjXjZl7LbF0Arfo
 qRkbX4kECeKOClvFGFEq+MBXFLJeNsBFesdJVymlrSEfnaI/hTXjNnHP0zLjSM8q9FTWgCVJora
 mv5CI+0ZVPh6eCzNBaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNiBTYWx0ZWRfX/CeLIm+yrCfH
 pwHIwkzdjlZnsirJUlyQXH+r3N+syT41JsGUDezQaC4LL1FkyJ4FDmjqg0KzBp3VKqyI0vdFvQD
 2Ek0320AvovUMr1OhnbDhb9ycty1d7Y=
X-Proofpoint-ORIG-GUID: miJNw1de8G67BmLTIbzAxrhnxnRC459Y
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5173d9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=dsyYn1boCWmjrq3IxZ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: miJNw1de8G67BmLTIbzAxrhnxnRC459Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100226
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

On 10/7/26 23:43, Pierrick Bouvier wrote:
> tests/tcg/mips/user/ has extra tests that are not currently run at the
> moment. Keep their Makefiles until they are implemented.

Ack.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/Makefile.target                     | 287 ------------------
>   tests/tcg/minilib/Makefile.target             |  21 --
>   tests/tcg/multiarch/Makefile.target           | 223 --------------
>   .../multiarch/system/Makefile.softmmu-target  |  81 -----
>   4 files changed, 612 deletions(-)
>   delete mode 100644 tests/tcg/Makefile.target
>   delete mode 100644 tests/tcg/minilib/Makefile.target
>   delete mode 100644 tests/tcg/multiarch/Makefile.target
>   delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target

