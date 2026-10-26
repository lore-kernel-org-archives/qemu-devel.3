Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D62606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VsKUx0eB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fWx+8hhA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLMkz-0003Fw-RG; Mon, 26 Oct 2026 11:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLMko-0003Dp-VR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:36:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLMkb-0004FN-8U
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:36:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvmVs4168179
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 15:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2qazO0lZgXIp/1jXXtlc0Bcf3/t+w0zLymkEPSalhtA=; b=VsKUx0eBKchUX1bf
 2GH0G/GT4TjyQbozfG4pHEmfu2LmIqf6pWhUkNZ+bMqR4dvasiVSR+rGpqWsIG87
 9MNgvKM//PRIRidFo9BuORNFXmxXR0J8Q8NR6/xyGbm9um3AbQkUiNXPUi9V586I
 Mum+qRWMAM8LQnuIYZ+TuZlNADkNCSJ3ueI2B1Jo/lhL4Zn0GarjlW7wwrvBIPMd
 HcpzxX+pqVvohzgU+sX3FUDyPXCE0EH9Kz0cGusj1KAYKDZjtdqMaZGbejoa+fxr
 mM+soByxmR7J/8mSVVqKuzRwAQwH7w1xTZMCQLo9hNQxCiFDeDu8QYfj7CpLKrSu
 IEvjqQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf18ny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 15:36:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91bc57d4d11so78797486d6.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793028998; x=1793633798; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2qazO0lZgXIp/1jXXtlc0Bcf3/t+w0zLymkEPSalhtA=;
 b=fWx+8hhAGghYRqgmS07LpUHIdWDHIEP9GMQ63kFgWzToN+YiPlaE91aHhz5OL2HYHD
 zOZsTIuxKqjUMJe4TOveOfDCLu4bUfkzZ5y4TRr/aDZnSuC+j+PAgT9ebFNFkcjJU4B2
 rvlC6yV33L2iQxEVD5LMqZCwYSM7eRlY4av8RFPrPeZogWbB8yPFGo+vmKnst2OlQTJv
 SIdKlext44o1yXHj4f2GDrlCdUOpMjdGcDno8eViQGstBKZLdp+VXxHtp8171j27VR/2
 Gq/ViizStcxGDfEHBWedu0Crj/5GhqqRAHmmuEYhycXpaTrzu7jnauaUbuoKa9T2FHbd
 O4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793028998; x=1793633798;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2qazO0lZgXIp/1jXXtlc0Bcf3/t+w0zLymkEPSalhtA=;
 b=R9orQ+DMisRsfFnjUnkUV9QxW0toaSlRBCYHTT0Zfl89o0ZPYdVgc475j3GN06w5Zo
 4KMnNtm6NowpuEKO8rxg8lu5SR3eSybm3jQXC85o/szmI90NwwrgwqgVRGCzDRSP15Fh
 tBuliZvvqMPzNVOKCj0n6svEGocU1lD32nJG3xI/GAWCAZ3TZWK06JvtLQRcHIaqMUg1
 zcQ4yv5V8KLDT76juLZ9XyTRuQFoIWsBXT1umwLlULETY5KHAq7xaZZL/udHuURpkWq3
 fdxlNj069K4RAHCSTC0IKy6bQSXhRZwI8LHT3pN/QFcnPA/yWa0BzFCWts7htHgiFxXQ
 j6Hg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRff2qbRCUu5Hx+iAS0e9TQmnDXmVYjGYeCpUUzidXwtEGwhJTK31BarYG5oL/CQvAjgey3WnFEFuK@nongnu.org
X-Gm-Message-State: AFq9FYLTbmkLV3B9CpxIQahynoR/WstI+hZdcMHR5Zi8SUzQJBc6lQ1b
 8qxteC9PMwtfXGTDIoa6qzK8/jX7QRgSXnN2acSkw509LleJXwdymj+HOTAfUqS3YOHNkchCWSh
 YoAZzUy+BXmN9NbCdxNtRggtPSfB3q+CTIf9EIMJSI2WNYPNjjedHmuvXjw==
X-Gm-Gg: AYBFou1Ua1StWBfMd7mao/PVgSuiL8v3dhsUY4bXGE1tNZx4e8eESLnPtCh+PKh86Kc
 D7JU9nQIE0dNsA0AhIh8Oo5ODaRWZattRloIEKOS9KmE6GqXZppWvWYPrRxUp6jrBq1uB7xQpGn
 uQsyJjZTSaiOOjj4AC4jKUMKImGGsQCUOXopz7HxcP3DZtY3LAeb2X1UHV79oS/DU49ayTUFe4h
 xpU+VJKkNmmNf7OUFzAmHsPKsr4HXMquNXvOqQ+exWvtg9L/37+xAki0K9uup1jUP04rvM3fXG+
 JGsPx97mMl7/QABoYJWPEcvhnhzUtk6N2rAzzujcnwGRwNFWIgDbmbppPDLHPvnqxQNX1MmUUZT
 bQTgQ1A5+sacLxsnRB/YsW9vGF9RmWjnOtg==
X-Received: by 2002:a05:620a:684a:b0:93f:2463:f78f with SMTP id
 af79cd13be357-940ef97fb8cmr1048242385a.62.1793028997463; 
 Mon, 26 Oct 2026 08:36:37 -0700 (PDT)
X-Received: by 2002:a05:620a:684a:b0:93f:2463:f78f with SMTP id
 af79cd13be357-940ef97fb8cmr1048237385a.62.1793028996982; 
 Mon, 26 Oct 2026 08:36:36 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48e0sm17732035f8f.38.2026.10.26.08.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 08:36:36 -0700 (PDT)
Message-ID: <e139462d-bd88-4f6e-90fa-c4529f69ba73@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:36:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/xlnx_dp: Make assertions clearer
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20261026152409.2869104-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261026152409.2869104-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2MiBTYWx0ZWRfX8ntpjdyqDKzd
 LyGpz+LqcyNCOLpM4Wr6EWqymfTKKBpTd+VhB23pJO8VQrxCk9jftR7gMmVcJ65sXF3IkWCuAHf
 OT/frR51S3HFQGbj93/leTlAreqr2rQ=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adf7386 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=LzL3Y7srNPVuGF4Lnh0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Ft2jDdv5rKpai2Dt9rcvNsQpUeVd9HQr
X-Proofpoint-ORIG-GUID: Ft2jDdv5rKpai2Dt9rcvNsQpUeVd9HQr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2MiBTYWx0ZWRfX4H/cHClT5bbP
 C6JeGkM9KoTfeaKuRqcrSdAziGfDw+HRtM7REpvfbnEIzSNNOX7rNb8FR+/sK7vFyWQ5m/hF8NT
 woHLm9kfL1dOHl95g6gRpG0jbYeKDbRP4jr1r/LqS8IxALaviKJb2g8KXdR2995HpX4nFaKa0if
 rGdwQfIfrh1hLZBQ/qxlj0BJ7QYmedfy3jjVTiKWdEXCVfT6V3JQc927aqDSreTUquhHvArjpuq
 O3XonjlJCKgt3fBsM+1UfQzFoN3eypD9prfD8OIlz5NkF+jJbihMSAr/KgO1+TUOkc2F0yx4wPW
 9VvmjzTb2FQRnyEG6QPIr4WDh1AR+JGtQCrpri4s24Kcmna3dhczVDPwE/svecrRy8bwbp8X+JV
 2DQuOiyEp39SwRs2Uy+bo9xYRZ+bPrpdnNHQF4YefwSNOBeYRlzv2gBa42goYMzGOT9w6geYmV8
 UoDnNFDlq27syeTIP8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260062
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/10/26 16:24, Peter Maydell wrote:
> The xlnx_dp code has some assertions in its read and write functions
> guarding the fallback "read from core_registers[]" codepath.  The
> array can't be overrun because of the defined size of the memory
> region, but the read assert is confusingly written and the write
> assert seems to be completely garbled.
> 
> Replace both with a simple check against the size the array, which

Typo "the size [of] the array".

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> makes it clear that we're asserting that we won't overflow it.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4586
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/display/xlnx_dp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


