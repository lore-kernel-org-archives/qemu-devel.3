Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D4606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GqYByBA9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AlurBNtT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFAZ-0000y6-IZ; Tue, 20 Oct 2026 15:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFAX-0000xQ-6G
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:06:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFAV-00064u-O5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:06:40 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7LdB3460875
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5dYI7JzqGqSpbnLtC5dZVXwoYlDYX7rcCsOAZBdFXps=; b=GqYByBA9DBdUnMy9
 P8en+2xHCDlzA7OlTQBeqjfJOsv97bWJa0cSzrv2yJC7JG3b26cVxuD2rNuka6O+
 LNG3mDfvk9Qf9fx71EP17sVrnMp5TvcQdyEweZ7Vm+gl6QWGRCO2ZU8bQ+LjBXgU
 jEy3Wf6FEdHI2rsTyMHXO+dHPp8I2GkiDPHHSaYutLhs62SezuNbXnjRBNQ5jxt1
 Mp67k2cn0lXYjlzfRrLgWO8tw5VpjPlSzZWjmhBWtoE0K6fouoUM0twN6epQEt95
 YgCQG3XEz2Dz3B9crY6FH8dBAL2OnD2zZbm8yccadKQ0pHyerItiqgkCWBMpVSc2
 5fT7Bg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4r71y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:06:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c902e0da2so1279162eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523196; x=1793127996; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5dYI7JzqGqSpbnLtC5dZVXwoYlDYX7rcCsOAZBdFXps=;
 b=AlurBNtTn48z5Z9259vP4HUHBrFzReEQtsV2blAVdm7tK5rtepqZvGEQOvd4kCWrRL
 PqbWCfzyXMu0QTe5whjDy4UpU5JuXjoXEzcX1Y4+d9DhhIVNSMDOoY8NBz06ojQU9qwq
 it3EfJomhQGPAj2D0AtZJZCJ6yxLlCgUCPLViaO3GWBoVDqbl+cCltbSvUPUkuovcjnJ
 bDrqRswzTLmSU20qeojcAm8EEn9z5sZ1LwEZStxiHwP9ciHmnbqMxQaArt3cO49RTgrX
 4DzD2dXpT+AYt2uAI9QkP1DAQg8FsQs255k7SVi+1qUrBYzKABNK+L+uPEdRFIduQq/v
 skKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523196; x=1793127996;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5dYI7JzqGqSpbnLtC5dZVXwoYlDYX7rcCsOAZBdFXps=;
 b=vOP/0fJWcVjuhPzrjru4wrKqAtXWt4bs+EprUzb24hZ2h2Qo+nxpS/F46L6H2QHo2c
 yD8Nm2kuOlazGbgifJCAxgZzOsJ72F/wWoAH7MQ0cJM1dPCJZiQ6a7jFhNft6Alc4qK4
 EbqeLLOFyNvBXBIESTHEaFoBMYAgCYQdeb129U5NDkpAa61G5qUmkjd9tpbfQf91oNiE
 rIXyoYZMiI+4DlPSyQUzeFj4+qeMzskOSUI8jhAtEL0v+Q10DSeP3iyxE6aJ5BwvY9xB
 SpJytFL75I7di3cH0+ZzMNj8Q25tjH1A+IU0joCFTBsj7X49ZqE5vA/ffs92POyaZYTL
 tSYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUcbl0n6351gfo1OgexQiXMredzwPbMbwOX8Dg33mGOEZ9QIs5rFpkZ7xLGi1HmSkn/f5cTz5m7VjV@nongnu.org
X-Gm-Message-State: AFq9FYKOPriFcyMS9xoioMyPYBdMzx3QtL9LfPH4OMBL3kz9L00GdRzX
 s+HCkPEp9dE2Q5QvolPIkEQbzOw1Ay/iHr23L76otMTTSJNYKm1bM7N0xgJlR/Md51pganvznwa
 WuikRczBW9NYH7LcmUwmyvds7aj/tqDcdowHF86cfh3mnacTVTRsDGPQBkg==
X-Gm-Gg: AYBFou29OqZlqBJPKiye4Y/N9cihS4C1fuV80fAOId/a904yhpGuTA17NuJ8l86/Onq
 LlwVlQK64MjmcYnlpMK6h6UI+7gYsZlHi9uWnlp8DlcrJ+qQM7bIsHetOM5OrN6wJdhNVx15lc7
 qfeeWhzQ0600mp6senf4g69TVCXUoq766C4olU/kbiG1QrN+IcKiltvw/yli2/IHvSn8ZvXoj3Q
 1qgTxDBY6G4MiD2UrJST4zlhP6t1BAgishJFBFtyzML21bAZ/oni87aaPQH4bVOlLUfsrmiXw89
 5jwO4NXsCT1CbkdbWO2hvcp45ZQxNJUyNqYrrDXAtW256rqKwxUEfO1OGB4OlX4r+/cIEekv06p
 JBZ137oj0YWTpxkF29bMwgLfEiVtyawu/dNGX65XLGuzavst0ZZlbwLJi8fQuGNb6zqcSag==
X-Received: by 2002:a05:701b:428f:10b0:187:5a5f:3b27 with SMTP id
 a92af1059eb24-18dbfbbfa4cmr3461690c88.17.1792523195746; 
 Tue, 20 Oct 2026 12:06:35 -0700 (PDT)
X-Received: by 2002:a05:701b:428f:10b0:187:5a5f:3b27 with SMTP id
 a92af1059eb24-18dbfbbfa4cmr3461670c88.17.1792523195216; 
 Tue, 20 Oct 2026 12:06:35 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903aff3481sm593002c88.10.2026.10.20.12.06.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:06:34 -0700 (PDT)
Message-ID: <c1cfda13-9c37-485d-b148-f5c2c382d34a@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:06:33 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/27] target/arm: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-5-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X-kxI5gq2j355J8Y-6YxkEm-u_ihbuDU
X-Proofpoint-GUID: X-kxI5gq2j355J8Y-6YxkEm-u_ihbuDU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX/JYrPtE3ld69
 H4dJxgij9MYOMZ8vk5lX/Fdvum1M/UNd4m9A8xAEmF/ftQhYBwvG/xlAXlxY5C4FXktNEyQINk9
 lQnXSxV0p4A1I+nUZ28qnnbMWaeOvRI=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad7bbbc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=aOxAfOeuNJpbYMRahvwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX0nqUfW/EP8bB
 VvxVEkb5XGNqouWwA6IaxekNTOzbtSOXM/mFiC276GCSQObp+mItiwhdA3pyo1ICgMfApbDg5GX
 iCycL+m7JbA8gVuQ3mm9uTKJInoKuW3WucRyH1LEyd9SIHDP/a8Fx4gzRWsNoyVKZH28I4VkhJD
 pzIPffj3FGi6EzRFb5RK7Gb05E3FkNV/9OHYOYTKSBBVQjsTMLfDS+Do39L9FZVrL4t7kqQvAwi
 clpv2tWZqbPhGo+HB1WNlduwjdWN4pcHL+tRI19aWTL3UlygVDnPvn/J2LDL8EFlPUKUWm9a6Cb
 t7a933CsxwgEiRdFc5TPGpcmC9P6fR599PLVNwmfgyQlw2SrQV6BDj7/IrWTPYGDiGehcRiLPM7
 +XPSwbPe6Hf+nDdLCTIKeLOR5JEOWuwjuP69AFiaR8lOo7IiShRxk3PXHxs8l1WH9PsSK53Smfu
 uAFIYjS9FMzLI+hKdEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
> Factor arm_exception_name() out of arm_log_exception() and
> register it as the CPUClass::exception_name() handler, so
> the common exception logging can resolve ARM exception codes
> to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/arm/cpu.h    |  2 ++
>  target/arm/cpu.c    |  1 +
>  target/arm/helper.c | 79 +++++++++++++++++++++++----------------------
>  3 files changed, 43 insertions(+), 39 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

