Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5F7E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 00:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTsCF-0004z3-9G; Fri, 03 Jan 2025 19:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tTsCD-0004yp-4S
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 19:39:17 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tTsCA-0003C8-E0
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 19:39:16 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503BIxUq007670
 for <qemu-devel@nongnu.org>; Sat, 4 Jan 2025 00:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YRvxyAqImc5BXIrNTr3M3A/7KXlXIgoFJVz5XMwPLKs=; b=RcHdhE9ys+V5baPR
 RDK5wVv6FU16ovSo9QALVHlzKgoJB9xcHPK5/DgQPUp3tHl7Sln3tBpZqLuvYdZD
 sKwOQeGTkyk+1UYCEnTxCUkqXhhZpjuLSg5voxOP61YTm1pQwq0Opk8WpBO0ClB9
 6AQ5ia51UobmX9UrOSZenrLihSw1TOlwnQ+BicnihEyP6kiFyYE9NIJisyFbIoH5
 XEKrDBdOPXVV82Fy7HgLwsnuSFF8NcE45FQ1keykSIUekDFyIhiqUtMlBZDe8sfW
 qcd0yEpiRwNcTWyvVT0OJlrsFNsZNxt9D1poY0GXazCKiFGvnm3xLuPG2JjeZNTs
 JJA5sQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43xewfhexh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:39:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e23e2b8fso1186621285a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 16:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735951148; x=1736555948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YRvxyAqImc5BXIrNTr3M3A/7KXlXIgoFJVz5XMwPLKs=;
 b=iE7Yd42lCghsLosiy1vBNgEvrI/tU9OVuR+XtiQd4zkEiJzJR9U4KhlcU31BfNo2+T
 FkI3wJs6iwTtbkwVYklzceFkR3EXQ0Rm8TCeEXKcWjwoEE8A50zIsugv/3vBE1BvK2+o
 OyDUUt+5gEYwvuSLzmDy4a3BmWVz9VRewrfyxQ3FT3s51ugMskRjJnRJBBuE5XWG2oKy
 FXmSmNHzV+nDuEJQgarWoEg8OUumQKdbT1oeJXdV70NgXif8i/AXbkO1HohP+3yTFTIx
 qvo99chyWj0+2BSLF4Z25LP5PI0k11iapiYAEoK/RBFbslgRxIL5bVXl1D6ZzdxEtKdP
 eV9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxuUxzULMTMHp0zxhQvIVwBJZl0sIE70Kx+6qLJ02O7+Yzb4BZ02sGQzOr1IjsreLNO6gsPOoBj/Jg@nongnu.org
X-Gm-Message-State: AOJu0YxYkHfNDCpwLbQRIxx/RAzJSBodsdrt6kNsrknoQKsOIRJCMAhU
 nHyeY4kR56dqbsbOgxcLin4f3R3NuuddodhQwEbVj/tT30K6d2KKQUPSKJPE02VWVD06Gr8QAV2
 jAXfqbWrhcaU5D//pPtQOzUZZO59tDRwGKGKxc3KF3fkJWhVoL69nvg==
X-Gm-Gg: ASbGncuqc17D38kK8iruXKRKTxA6OViLRM2JXAjGlL3vVekgSsUrVX7OzXzxjQIbuw8
 BrddPBcJoJQBziWh7P9Wzkg/aUwFXe3P1sZVa8ttwsZ5aKMkV2OJBeSbhxMOM4tepj+i3Rsc1D3
 g2ewcgWT/Vr242+s3RPbPglsMVwmDrRGeQZlkk+Fa847DFMnxzbq0vIcHRUFc4YAIDG/pQG1XR6
 H9YSOGCvtXhMSaUCsh+QKPPu4kE3Vf6fuSznj3qEsXmjQQU8gCh7W9r0p1DESCgmYRzT17VMscU
 t+lyjI4=
X-Received: by 2002:a05:620a:1911:b0:7b6:ce4c:69d2 with SMTP id
 af79cd13be357-7b9ba7abfa9mr9672066085a.36.1735951148120; 
 Fri, 03 Jan 2025 16:39:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHItzCc0DyWegcLIMIMLGt9OzwzWQMnAVmGT1mJsrcH0ylOZQPgyGHr8lBgEeIesqcQiL35mQ==
X-Received: by 2002:a05:620a:1911:b0:7b6:ce4c:69d2 with SMTP id
 af79cd13be357-7b9ba7abfa9mr9672062985a.36.1735951147750; 
 Fri, 03 Jan 2025 16:39:07 -0800 (PST)
Received: from [172.31.52.177] ([169.133.32.221])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bc10csm1316719585a.24.2025.01.03.16.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 16:39:07 -0800 (PST)
Message-ID: <a8557999-4cff-470a-893c-9238ff985325@oss.qualcomm.com>
Date: Fri, 3 Jan 2025 18:39:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] target/hexagon: Add Kconfig file
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250103231738.65413-1-philmd@linaro.org>
 <20250103231738.65413-3-philmd@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250103231738.65413-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Rwf6ePp-1-BNyVoOqhxRk5waqlse7XCu
X-Proofpoint-ORIG-GUID: Rwf6ePp-1-BNyVoOqhxRk5waqlse7XCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=731 clxscore=1015 suspectscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501040002
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 1/3/2025 5:17 PM, Philippe Mathieu-Daudé wrote:
> Keep the Hexagon target in line with others.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/Kconfig         | 1 +
>   target/hexagon/Kconfig | 2 ++
>   2 files changed, 3 insertions(+)
>   create mode 100644 target/hexagon/Kconfig
>
> diff --git a/target/Kconfig b/target/Kconfig
> index d0c7b59d9c7..17cfb4648d2 100644
> --- a/target/Kconfig
> +++ b/target/Kconfig
> @@ -1,6 +1,7 @@
>   source alpha/Kconfig
>   source arm/Kconfig
>   source avr/Kconfig
> +source hexagon/Kconfig
>   source hppa/Kconfig
>   source i386/Kconfig
>   source loongarch/Kconfig
> diff --git a/target/hexagon/Kconfig b/target/hexagon/Kconfig
> new file mode 100644
> index 00000000000..7e556f35063
> --- /dev/null
> +++ b/target/hexagon/Kconfig
> @@ -0,0 +1,2 @@
> +config HEXAGON
> +    bool

