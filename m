Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AD8C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxB6i-0006dQ-SK; Thu, 20 Aug 2026 18:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxB6g-0006cx-B5
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:19:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxB6c-0000Zf-Q6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:19:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7e8R065803
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MCP/4Tpj4Rt6jZVYxlylT8YisheI9rTpbUpChraRA4c=; b=MXVSe8w1vcamX0lA
 VuAbmpNNbIzWGWLxDP5H8IEiIBo5zu0i8Il/9RLgX6W5SXCnccytXMPeNSQolH01
 zpwERClQtmUqds4LLnzq0Z38+WddhqEjevZ5Ssb01SeRwah0Si02QtoGymesIY1o
 ZuWirWYHptCZKT3tOjxDW/mv4NP16PabzNtSEYhuDwKihxzsei5x0Ca63ffg6E6D
 G4kwgRVEBAvzRm3nQmHklHwYu4fkwt4Sv0n2OKOr//T+PfNmOm9+FisrF9aczY6t
 JeKvjnDfm8YNjfvnpQSjGgzbQSiZMAt+OZskO3AousYUxHkHU2Q2VS5jp1lKyEuE
 7NPVsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0k508-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:19:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso4418055ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787264364; x=1787869164; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MCP/4Tpj4Rt6jZVYxlylT8YisheI9rTpbUpChraRA4c=;
 b=h3Y0ibpfAZ+hDRvSwMFrwDE3jucsusztXj9g29VmWuHFuwoH2fBqZ39DTRiQSEJW94
 qa3snyo6FpBA2YvLoT2Gqezui6bbSTrmeZUVZU2H3kBzs3HpKV/0+jhV2/aPhNCl8teG
 h71+iBPj1HzI2n5R+LmVAXB41KtfRt43hOYMir1E7jkDCa2wGW7y4NNHCAEzzAYED6fY
 /gzixc/3QcCSbMnRSX1mobFkzwlTfFqb5osPhEfyijsi8z14PLiFhYaZbKo9pVTiNIQ9
 z0Goq3cvMlrGJPpDKZH3O0KqBc5nBjyZr8RfnoO5LsJm6bwQ85pXN2l0ZMvE93USrTM7
 CqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787264364; x=1787869164;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MCP/4Tpj4Rt6jZVYxlylT8YisheI9rTpbUpChraRA4c=;
 b=oM2YmTxcbU/WhR5m7XL9vQjJF9TeDW6tcuYDX8mO4VX1iDvPJhW2ceBy9I0BwcRu3q
 RQ2cC+XlhktVod+N0d175WOjPOKGk5B47PXBBLXFLlTaUHVbKB5EoUiI7osjK9O2QrRB
 Kw8UhQqae32AInUY0DYVvTdJkPv507N7aqrcXTRbwGy5+3LlL/ym44xz0zOwDywOWP02
 U+pjmovSmq0LfacAqrg8DttUa8j+KPvCGWSLirwKZVnjs8PYN69je5ZRs+iNd9Djdkvn
 8JOGVCu70/mcWFImr8UP6Gm3mMt6wxMNXl/SiO47V2Jx9jHkR8zfzgorOPJBWcoVGw4p
 vc6g==
X-Gm-Message-State: AOJu0YyKWImtJmFELUBGaZaj4mNUUG09Q1e4ltxdjA8xApE5+qitjNVl
 GTa+jxXKgXVhaP2N4z9Gkjo5d9ATJwwsKD4MaSCvwEyWtjuWuWNAISINd626T+gU42XcAXxMIhA
 JCpXT6UbtFN1TJILfMv7/E15J8L/A0XfsdSoXS9vFXFhXMomC3iCKYywmzA==
X-Gm-Gg: AR+sD13VT/RizLZYNZTGnZ00cUMeivKOQ250Oax8a++xDD6XNhKsTNkQYUE5RhyIrlv
 QODkM2uKlrRVCQ/59OHgTolj1I9x3OOcZ9EkZ8rHD3hwh1rPHH1Cj6WwICuBt2aDGhzOEM9P2hy
 O+B0+KNlI74eoI4+jOdaSt/WR5wSS9qSwzX9O2nVR5gXW/XJlOSASXzTcZTl/TS4N9lu9VvzDxX
 3hG2A0kRabeVmWDvKA0xJnTtM+zWtRGooW1B5ZywSN1gHoWMN0Op6KllCngxixfnKF63ZgQuxPq
 N7yreYwIIlBy64uFMD0dld0CjRRCZAaUjyVmo9tPD7kYzTq/RI3xpiZ74cDsW7WxId0nIasQF5j
 O1VLbbmK+wBVLg+xEbIO4oCVUxAR1azIyGQARP/k+H+nK6khfuLrDIDM9KLPkP2Ytv/kI
X-Received: by 2002:a17:903:b07:b0:2cf:afe8:b722 with SMTP id
 d9443c01a7336-2d64afe960dmr33458685ad.11.1787264364566; 
 Thu, 20 Aug 2026 15:19:24 -0700 (PDT)
X-Received: by 2002:a17:903:b07:b0:2cf:afe8:b722 with SMTP id
 d9443c01a7336-2d64afe960dmr33458085ad.11.1787264364143; 
 Thu, 20 Aug 2026 15:19:24 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327d01ff056sm11949406eec.19.2026.08.20.15.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 15:19:23 -0700 (PDT)
Message-ID: <350471ec-9d37-49df-b50f-ea061288cb95@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:19:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 06/28] hw/arm/smmuv3: Plumb transaction attributes into
 config helpers
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813162446.2806393-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yXUWXyrfOYRg0vXSl8OuMuc8c4CRXG1C
X-Proofpoint-ORIG-GUID: yXUWXyrfOYRg0vXSl8OuMuc8c4CRXG1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX9S3RRF+aHYwj
 d+6VNrqGZaly0M6ZIzu0Z/Vrx98fMNpfwPP3OCeM/Yej7a/God3uzLBl18z27Rb+1J/zO+R8p7+
 yjVIckanYfJ+UohEPM6QGT6uVcly8Hg9dWgtM5xQoXJ+tAxfJSbcpMkbhAXYLVqYAtB+wrSORLB
 AYIhhpbeyuv9rWAUw8jqcstgc+eL1LT4jN0xl1byVmqwo47yFbolD3IgXkAVBmdR4tOLwzW/hhI
 6bzV3ZBp2aCKk2XF0y3UOGAMZ2MHeKZk1kSyTBq591kiOYFJY2X9+Nizo5ua1Q0hujqoEWHScO3
 caq5PpB8mrWaMOkWxEXayn9u8sLqQ324BY6UbYejLIA/Ym9vt3kFFyxLCOOBzGhn7jNIC9d1Mlc
 4YFhe7euJMqNOgd6lb/uvqNBfFgLQRfZe5a7GMmReuxzHBPyDswPqmDDKmRiKbOk4/le5UslVPm
 bzerRefx9IdCZMuVzuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX8Jysg6JQlvIy
 xXeySQ7wA++082RIdKZUGSp/It2JFf8+XLVdWAue5SztOizVCxb6yGfOY86xu8hGYuV71r8yhA2
 4QYbtW/xZKoLTdDsNiN9MyizHgRe1lE=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a877d6d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=fgrLqfBXAAAA:8 a=EUspDBNiAAAA:8 a=ONKyKrwD9wkXZehxPvsA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200166
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/13/2026 9:24 AM, Tao Tang wrote:
> Introduce helpers that derive MemTxAttrs and select an AddressSpace from
> SEC_SID, then pass SEC_SID through the Stream Table and Context Descriptor
> fetch paths. This makes reads of SMMU configuration structures use the
> corresponding Non-secure or Secure memory context.
> 
> To support these helpers, include hw/arm/arm-security.h from smmu-common.h,
> making the Arm security-space definitions available to the common SMMU code.
> 
> The accelerated path remains Non-secure-only and therefore passes
> SMMU_SEC_SID_NS explicitly.
> 
> For now, the configuration cache lookup key remains based solely on the
> SMMUDevice pointer. It is extended with SEC_SID in a later commit. Other
> SEC_SID-sensitive memory accesses that still use the Non-secure address
> space are converted in follow-up commits.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 30 +++++++++++++++++++++----
>  hw/arm/smmuv3-accel.c        |  2 +-
>  hw/arm/smmuv3-internal.h     |  3 ++-
>  hw/arm/smmuv3.c              | 43 ++++++++++++++++++++++--------------
>  include/hw/arm/smmu-common.h | 10 +++++++++
>  5 files changed, 65 insertions(+), 23 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

