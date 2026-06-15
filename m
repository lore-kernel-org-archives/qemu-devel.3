Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE3DCD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ5vg-0001aM-4R; Mon, 15 Jun 2026 07:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ5vf-0001Zp-3M
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:56:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ5vc-0007qR-OV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:56:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAobrN3956158
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fRG6nGkDjdyplj5SH+qoXynM+BgsJ+Z7WBRfu3nOdT8=; b=nQE77fiIGUhPBXD5
 kIRfxNKBxQV0zCoITep4kvb1DHAmyKhh2RlpDuChetiBgyyH54lwoAbsIqEqizKt
 kPehaGvZzHFPFs5jRdz/l/aa+NOhDGx9IQDK4h1Yq61Yt86FyjjAEvcqk0VFiViM
 LP83OVeAENh0CJXFwRB/AlZmFIZvdVm5cRHPpazG7REaJILtrh5n48jFoHM2du0m
 9xwOdvMt6X7kVuFV9eYOXXSLlaHACws2y+I4OLhQkbtaIiFtrgYgbaR+93e0pFwj
 8BRW5Ds0XO2sh4OyKyOaUjTBPsb7tb3Wj1zBICaiNc6Fkq2kMbHt7Ghb6vHdK8Rr
 EeyW1A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter00h5t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:56:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9159c4b210aso536206085a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781524590; x=1782129390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fRG6nGkDjdyplj5SH+qoXynM+BgsJ+Z7WBRfu3nOdT8=;
 b=Rx0DmEOSNvrtZ2P4nkJjd6bCjh25wQe4chS3s6VBm3KuhOltOFVCqZHKeMXEB8a2vr
 RTQq+pj1cNzfPzckq0qUOjJmqfsZYAd8zYmP9a1qdHW2/iMOO2V1TJ9d/YX/1DUN883T
 L/Au3HZCQFnuaQRltGsh0CNQQpY1g8yNiue03C9Jahdfy2vXhDgaUynMwGSJ3gN5x9Js
 si1DoF3T1KdCji5Q5/aozwgUpIwJCXJAp1F4zTXeiS+0RDPtKstFASnAnwcJJPZnu8XD
 YuEeQ6FSnEG3Trt+yCLY3fVySzE2nfmclFa93bg8I5gz26F2f3RXAEcKvyGpmYh+abGC
 lY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524590; x=1782129390;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fRG6nGkDjdyplj5SH+qoXynM+BgsJ+Z7WBRfu3nOdT8=;
 b=jCNE9SGHlmvh1nMnhEhWQRKJN+KhlZanUMjOfuloAeHy1VguiXFjAHgxy1A2MBrlPa
 ChxAI3WNS+9ivbofmw/Wco+LadRZuJY2fOrirfZiXnL6mK+bzkkJlznrRX7s1hkg/qeA
 X+hv3GUw8evtkpeH5yG7/9DU2hx4fX1SF8PomBjuQ8s3IBvNWb9F/bDA2TZ6sQFi5+lb
 Kl1k2vqkN5NElYSj4PUTxXzcQZYye24W1hNHg6DeOx72Q+2qHS29U2iNynK0zEh6uYYz
 4ibErXCCjdzwG59B7PggL87+RUSfXy17nBuFMwMsy50oLucfrIX+AW8wsu/1+FENSdEq
 d5fA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cWVLXDJpjqp9S1fkiT2CAJ3YCb5bVjYipVTaC2U6CSBWcAK2bL3KbfKbUnN0H47OYsOQ6PY+6REt5@nongnu.org
X-Gm-Message-State: AOJu0Ywi+kn3L7znGV2tbSLZwZOD0vHItvn2/Cj+21MbUT4fsC9QjUkl
 6b4b+J3nTr551F9AinKLi0rt7qoeIboinY41qdTj43IZiOaIJhsPnAYDlv6t1rya2uRSBKCXSwP
 hl8Pd9HMHApSiVLi6unasOE13Boiu3zSOLW3eT5uMMPUBxp8uYhODIMsDeA==
X-Gm-Gg: Acq92OFHlrj3wYF+LW4+JCc3+eecJ/L1b55Dukgoq48izMyn2Ml1mAI8+70wsqJ1c7r
 dhJWGG30WESClaVaaDJv6FV72tT9jiV8AJ1cW5679oa5pq9dlFO/qmhIllfbEs1sSl7VnIiQhqF
 96IvdVseevm9Hv1dfXaoKGdgTOom03cTg+0JbS/vYNYukck9Jiwp+3cjuLfuCGoc7WGmqgEK3Q5
 Kg3tlixoOQ8J4d3rBvB7/HLYTiqB1doiF32fsla+dZvzosDPGJ6CBrUiaCfk99xI3a2FUl7jWmm
 hyJq98YKZgKC+cyhhO7JQB9VlIDNcfY1stVR4/Anfm0XnFx+In+iXuNDpr9rBp+s4PRxkHZOr8l
 1jLIP+M2vsWwGqYoS1Lmtgpm9N1dA82iRdtATf/dVE9WdXuSzVeVzZvwJgzfgxOfLmWS+8fzO
X-Received: by 2002:a05:620a:450c:b0:916:1765:b774 with SMTP id
 af79cd13be357-91619eff271mr1746232285a.21.1781524590188; 
 Mon, 15 Jun 2026 04:56:30 -0700 (PDT)
X-Received: by 2002:a05:620a:450c:b0:916:1765:b774 with SMTP id
 af79cd13be357-91619eff271mr1746230985a.21.1781524589751; 
 Mon, 15 Jun 2026 04:56:29 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb4b22b21sm457499566b.16.2026.06.15.04.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 04:56:29 -0700 (PDT)
Message-ID: <803b6616-d223-4030-b556-65a427d27789@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 13:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/arm: GICv5 cpuif: Recalculate IRQ/FIQ on
 ICC_PCR_EL1 write
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260615105029.2898872-1-peter.maydell@linaro.org>
 <20260615105029.2898872-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615105029.2898872-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y0RVqwlxZIhlreC5sVy5lgZ5b5ec3vPY
X-Proofpoint-GUID: Y0RVqwlxZIhlreC5sVy5lgZ5b5ec3vPY
X-Authority-Analysis: v=2.4 cv=UPzt2ify c=1 sm=1 tr=0 ts=6a2fe86f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=9dWPDvEdnF6fiLz_tfUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyNiBTYWx0ZWRfX7P3RLZowjwec
 I1hX/39TooLp2yLCfxsxtpndKxC6Npwko9JZUQPLd9nOJRnrKh+p2Ir8L5wNP7A04DNfSUjssLV
 v+CP6x4YyOLMQt4+Czmh/WsNVP0OQn1x/mhoIrzNqhp02MxmJy4i8VnRKa3nZJL07ji5YQLzsl8
 /DE7NaG0hWIOEY28iYntV3v8eRGmJcOnuou9CsOSUNeu9PbCpbbRTEEqD6wBn9Wbpr7OIObFCLp
 eh7/FnKqWQ4wx9E7zb1+A8uTEYCb8EpY2dIf3KR7qGrCqyiOll7OChjrufYvQXyvZIND+q1iva9
 IERwOY5StdTitej6m5pt6dZR00J9JcQoZeS/jRYT1g4LL46yfW3nmb8QPUB6+4vyiNBb9uSCIgo
 X0D++AnbnXFZ6YSBStfjGJBL3vE+6USE26tyhS3k0p4AlamOIEwCRpRuDQo00IKYLxQcOwPESyf
 BUTH0ULhP0xTssBPc+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyNiBTYWx0ZWRfX1hyuvQsPWVUh
 Y7POd5vYQwJfeRJ0gXChitc/h6MQ0zOcb3v0V7LDD2rfzHQYeh1qBG8+jTcuMDv+oSV67G72brB
 JxbCnblfrvpc9siCBWKnz8/AEgYksTQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150126
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/6/26 12:50, Peter Maydell wrote:
> When the guest writes ICC_PCR_EL1 we should recheck whether we should
> be signalling IRQ or FIQ, because we use this priority mask value in
> determining whether the highest priority interrupt should be
> signalled or not.
> 
> Fixes: 9bd90bddb79b ("target/arm: GICv5 cpuif: Signal IRQ or FIQ")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

