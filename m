Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962C60A3832
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LbaWCNr5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fk1qP5pD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSc7-0000aO-B7; Mon, 09 Nov 2026 11:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQSc5-0000aG-Js
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:52:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQSc2-0001mM-Op
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:52:56 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DFJBP971483
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 16:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xswqXLFap+n4qh3awN1gayXYZW43iMv6d2aXg6NBjmc=; b=LbaWCNr5Mj/SCR6q
 Hk6Nm+bZr3SZHgEbou8CAKbHei6OhBoDHEWcPSL5aY3v14eSRAgETBzroDesWQ4x
 w7ZULif+oUoU6eihuOM/KDcXHH4ObPtgkA7PANZY7Xs6d3Nizp9uqN6VeOhQmDC6
 FefADZkkrN3XP/u+N1McmmG2ahQ8BaEJcCmsHijG3dfvIXtLlew8pSe04lNu34Bf
 pn3/7wymt09hhmgr5vvZm09NT/nrDBckUIBN7ujQlxVaIODNFRUlc1W8idjB+Dod
 7urkZ03vRpKBfiFydWNKN7h6M6pMFE13DXt4GsBHOmCle6MfwLdq+zwJnru7YiBR
 GJYEtg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm44m5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 16:52:53 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99089f9591aso219742241.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 08:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794243172; x=1794847972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xswqXLFap+n4qh3awN1gayXYZW43iMv6d2aXg6NBjmc=;
 b=Fk1qP5pD3tZPxT9Z64B+bLHrtzo3m40mkrrt7T5bdxJTAfy2yu1ZgVZj+ULgOYe4r7
 iTtjWEhYCyQDHP+mKNorXcej1poVAJDYXLNJGA3jBI/gtIQ6H28txCjf77qrVwtLalm1
 sZQ+KVL027EoDUpHr+eNwQnvCMDCQTXa6CZmrRk2de/Tom4F6t17jsjp5Seytm7H100z
 ye+qUtmkWOlK8p9OSkUYJyH8uTRs0srBbfteEDWNp9tEDxe5nM1GXhF3VdLAnQRJ3T7W
 uF1Why8TOVfFWNIW5xfgebSXYiS7Y/pFEj1Vu1O4eSlR6EgRM/HutYzlSHeZc+bZoRMr
 0W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794243172; x=1794847972;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xswqXLFap+n4qh3awN1gayXYZW43iMv6d2aXg6NBjmc=;
 b=FOgUrGBtmUJNnVITTvsoKrixFHo96EV9/CMduli6ZQsv99YteUKezA4CU5YBNtW6BD
 BobcCLSc0aO7tjhDvm7su/gZRxjG7oj4p0BnY/M0fcjFMSu4Ul8CD7hBeBuhJYSNRRdF
 p8SkLwVEIlPmDwEkUoy0+W8qvAV00Z0Er5JyMr1iq1dDZ+YoCJppWXmU7/9NgO3JgFj4
 MN8s4wRJbk2kx5boyhGrNBfnZV9555p7hY4uB7zUuPbd80JQFdE/Q/SsVpZwBI7BU39m
 DEx//N64C2C+oh0L6LyDx/h/fysL2jpN5jibJUrJ/lP03pbjzYKZpZGKVQYbY3ubHJ46
 FPnw==
X-Forwarded-Encrypted: i=1;
 AL+hErGcuAlvNyBfkzKaQxmfFxKSaXbSbQfFmijC2HWg3SoqUx8x3sMCQm1Sxws35UlNlq8EG+qneppCKBsL@nongnu.org
X-Gm-Message-State: APuU4Z9fu39OI5+Izvtn8HRfMMokZs3kgacE+AEBLHzG9Cz9C0kZJ+Mp
 cO/I9BK0nBLUQfOfBbq2ukWHvcrszNcn6op2WPsn6TJ3D3UccflHxDo9/pbcHsadF84Y19rf3eV
 VKkqcTbC+ZWrIuSWWrZpqYUiC9LLIidnaCMZanzxfBZ7BrP1+Ws2+JXytOoDA3yUnXw==
X-Gm-Gg: AYBFou0Ve6wiRbhx5xRvZXntaeae6FHOnm5uU3dpXG+r3Cw1BiyiYjQfhsqduFUXl8Z
 XYogWTFAWEKgBji1BWEFUkXSS9t67XiAqcboCAdP1xhOU41d0e2t/0BhjtC9qVrL9eXkM8RbLgf
 +rJfiO6vgNMLDGQ59y+L7zNRmlXAAksvhnVewPJshxJVvK3NNo8GCxOvFeI80AxBefWqkj1HLI5
 KuaIdzHY4cnccnrzyZv75Qeok/LKyKm6C74ZJvi1Xx4zOUCd+SOVuQ1/pfctDp3FP3ta0rl3pS6
 6tddDioOxYWYDXLX3wMRPvpapaC4xTy3mrwpdsgjbfMyU1ljzSUK7okabLRpimVXU52hMAJ2JBS
 a7GeWIRCzUZRXohyN5q2KnvLnNxHMVHQujhqc26UWcQv8VKUkYip/IwmjtbPPESoTLDv4bfK8uD
 9tdwYvow==
X-Received: by 2002:a05:6102:5086:b0:7d2:8dd0:2e1 with SMTP id
 ada2fe7eead31-7d2daf17f30mr1237025137.6.1794243172342; 
 Mon, 09 Nov 2026 08:52:52 -0800 (PST)
X-Received: by 2002:a05:6102:5086:b0:7d2:8dd0:2e1 with SMTP id
 ada2fe7eead31-7d2daf17f30mr1237018137.6.1794243171812; 
 Mon, 09 Nov 2026 08:52:51 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe9357sm202035e9.9.2026.11.09.08.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 08:52:50 -0800 (PST)
Message-ID: <7abc1bd3-feb8-4dd6-bd78-3bd1e788ae65@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:52:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel/tcg: Adjust tlb assertions to allow stopped cpus
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20261109161016.43218-1-richard.henderson@linaro.org>
 <20261109161016.43218-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261109161016.43218-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfX1LBoMf5UCtum
 +ElWs4qQs24jCItPBdOaMPEw7otTXfSLXGrUmUq//mfJMYB1EoDpzIcZFt4rCay0hUOwdp/oABt
 XoNM1xxuOi8VxvOm86tlLA0IAY3BXmI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfXxjI8+JOs3T+Y
 Jl3ktd7DxEXvgAt60Iai9jsQNkvyXJX5mTJ/8LVWDmdDbceFUiiFhn0+p5m+Q9QQkKIFgS0zVdl
 G4BV4J90M2tpODUMl3kqk6df5jQjwvGZGT5RG+F67JFySn+/X+bkqEjs0cZGYpDQcc6GboMP1Af
 p7azRiWZDONTgUU9dcwej+qD1Az2Qtxg+F8qzPHS5zWEcWlddYxVaYBtU2zgyk4YUc6bNetMahh
 hcr6wLrxy/Y6bZH0RNcFYuQPWnbj/pHnPVYJMHxREps8nVvr6oYvAPJp8MhmlnDwr9j0qjZbz4M
 PiPdi7v+5HAvLwW7psosk+9llmRPXb79QNhiuHG7MVil9lHP/6ESnvHVy95X49i8AXrmLHKA/s4
 lDLMzC+cGh08VEp1t91Nl6OTd/e4cNI3jIzZv88KRg4CV/Fy2icRj8s2K3o1uqh3hDHiq5ntpXk
 o6bIWMTY1xcfloExxaQ==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af1fa65 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1UMyL2Y6xOqHBy24DUoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 74pLfTtV9QWCZ5Ih1u_kYXBlhP4974TI
X-Proofpoint-ORIG-GUID: 74pLfTtV9QWCZ5Ih1u_kYXBlhP4974TI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090067
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/11/26 17:10, Richard Henderson wrote:
> The intent of the assert has always been to prevent operating
> on a foreign running cpu -- we must use run_on for that.
> Not created is certainly one condition for not running but
> there are others, including case at issue here of reset.
> 
> Rename the assert and expand the condition to all stopped cpus.
> Enable the assertion with --enable-debug-tcg, not a private
> define that is never enabled in practice.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3092
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 36 +++++++++++++++---------------------
>   1 file changed, 15 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

