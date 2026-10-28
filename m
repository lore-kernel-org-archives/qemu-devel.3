Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C59606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mbN8zYhz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=djAG08Op
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAa1-0003A9-6P; Wed, 28 Oct 2026 16:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAZH-0002iI-RW
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:48:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAZF-0005O3-H8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:48:19 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPDsU2969699
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LAkwRzYca/WKna8XVjdkSzZgLeMIOiNmQHSxXeVbc/s=; b=mbN8zYhzqecEXOUD
 +oH2G07T4WXahgohdwObpeOCVmf5IjYXlq4AJBurHpqI25j8Df5/Tfa93gO/dKlo
 lL4izVPO/W7Qrdxs61x2xUPWJkJh/PANoKsCKD7Ei7pMohgLMHrm0zRO95EVAoKP
 gH/GKCUU5+7t0mTlTXzAEGIJQCRPn4q2pK1iRcqIoS623UO8e2hMjrpRwFteT9UH
 +xqrpG4v64iPZFigCCaH0DH2Jr7dK1x5O94oX6i9nHgEC81vLdFPYLU0jAM5cWBg
 QILAARC/31+QVv5Jl6SDMCY8F8fe82JB0lvtHaVm113SFGwwGRl+19ebIsKmT2aN
 qWMMvA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehsekg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:48:15 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso2493017eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220495; x=1793825295; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LAkwRzYca/WKna8XVjdkSzZgLeMIOiNmQHSxXeVbc/s=;
 b=djAG08OpE3Ro0na7Q80OPDiciHv9uwiOHgzVAGeYiWzXAc1ew81bdKbzHX7IFhk8E+
 MCR4AxhAKGpQb4pYRZwgM/t0SYQIm4RNX1GsB/XnI83Tjx9beNXhxejeGNn4g6GkYy+N
 N0+Ag5TUbf7m01jhGW+WmjizykkO9c8vUm5/d16xEseQqm4eKcpl58eoc85J0P8jF4jr
 PUzZ1RP5djosAXzDwb6YnyDlAm9aHBs1oGca2k73n+9vUg3BJXDrXOulraKFIDZ+CWqk
 vPWirp4jAOWfHyyQqwMxi8LBQqoafDjQqIyn6yB9sTFX4HGy5roabd0OPANfSctxDVb+
 o7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220495; x=1793825295;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LAkwRzYca/WKna8XVjdkSzZgLeMIOiNmQHSxXeVbc/s=;
 b=OAbdlkK+b+YWgM8xCfg4fFuE7e7XArtCWmHDrKjKUbP8DnZGquGqerunNBEt+ECnmk
 Jzw8zC44PphcT37/4zWOh6I0o63sgb091cFacBap/2sQ78M+rOAvPjHSxxSlv4qgQwoQ
 7ojP1chD8vYjGafE/RY/sHUnKwZmKQ7jOJlRPGG/tGX79wIQ63kdZKD9SokK1aJcoJmd
 yOjCTQ3PaVHBBBGjUUgRYTYRFWzd49VeihfKDDIr55wX1Z3xbwFPHy3yHK8UDuk9HoMW
 jZUEyo1ZKJAzReevCQ0ApsBL3cNHhz+Svw8gYpud6cdxLL4JOJ0RzPi704r1WGHpNAZu
 FZdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/UG/BbFeJDvwsNsWIXSUKd3mYoRnTW1xdhCB2uIpraLUdkDJhNoRB9Y6VidrJH1O644YDIiX1qEn6@nongnu.org
X-Gm-Message-State: AFq9FYKwFPcD+PWFVxEcJmsTeU3JkGThj5fA136nZkJDT7lo2fhHAf8c
 WyLh/rv66D7EvUgRAXacd1H0PM3/uQ9ZI7sXWfz1zNkQqzgIdGUuZ7D8R7uuknwHBdx7p7Zt3lo
 TgchZdZlm5Iv2WjbR9HBZ2Ozqxbnp2ZrAW39CfP0aw5TSEK6qarf4EULsFw==
X-Gm-Gg: AYBFou2qvIWFjt5iaNDxObbkGxuCicvvGS/UKViiehWf/ZEoc2aXexRSUQOJpll+DuF
 /ComBT/7Vw7JGt8kpWeWlJtxONpZElOnNXRCoHS1ydw5JvULD+dnSUwrl/7GPzlte9TOe2I0sex
 lFlxX36O71FNV3VKJHHqOajhVtGGWY+2jH5lP0RZxqumFvaoEPlH75VSKjrzz12uQWzLLMWku8Q
 cL8gJaxW0RDgooeURXl3woU5HgUt9JTfCu1/iBkETr+ko/PtY3auyWX/aNHy2uqp8aGhhZ0fDKR
 vLAx2EiA9jSJkXLq1AoEWHdKXlaH50VsfDiJ07v4tvQIbZXfObavcQIPRiIE1hKqnQ5frb2NjNV
 kjlYl49f3Q86NFlndzKkzq6uo/Rq/4nAIuKBTzbED3+yHpelq0f2w4q9HXUUlPJD7Wq1aLQdRRb
 JVvtuYTQxSGQfvsSIsUK/kF7AO8TBxcduQEwEwhXFHF0M=
X-Received: by 2002:a05:7301:fc14:b0:36a:180f:3154 with SMTP id
 5a478bee46e88-36a2015a1a1mr4249120eec.18.1793220495169; 
 Wed, 28 Oct 2026 13:48:15 -0700 (PDT)
X-Received: by 2002:a05:7301:fc14:b0:36a:180f:3154 with SMTP id
 5a478bee46e88-36a2015a1a1mr4249087eec.18.1793220494648; 
 Wed, 28 Oct 2026 13:48:14 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390c6dbsm8214851eec.13.2026.10.28.13.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:48:14 -0700 (PDT)
Message-ID: <7f759b24-a115-46f5-919d-0fbc773fc6f1@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:48:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] hw/xtensa/virt: select virt machine types with
 is_available
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Farman
 <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
 <20261028201557.2688-5-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028201557.2688-5-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ItIjLnwuxvu1VjyVAfHcsx8Wvrr79JRY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX/qDB7aZJSKgm
 WpWE+AYteCkOd3zlMAdxOfB7DcgrecfFZs/I2V1ICcPIssDA+LeAq4WYkSgEz5dmUEyWpjxN/dU
 l4lqF1KZtD9NaYYirAid55zhP32ukDo3lcL+7Q3c1nYbm6Pm/if5C7hnxsV3wC8osgsK1klEk9z
 +PHjUyq4mSjjLDYbKGFXnrA++9paY8xUUPAtE5Awfu+sIRyunLjwp+tmEA9KEMzzrI332CqwODr
 OfFCFlfjEH76UgFLodqKitVfhOlTALrJeXiHEOc+9fzU8F71nO47kHgavVar3UixDxblS0ZDh4e
 Z/ctoRW8yKLmJG1RYhxm2tbdMHHRa4zZbB+RIiC5K1q/MnrwD9eGpZWFwKBx+haE8u/3+MrySdx
 DgUiJZHzMfmNt6acQ3cdCYEPy0BTjbbA0NgylqubKRImZ2znMyTgg88nGwy9Qb+TsfiIk0LBpkc
 M2DDzrxOaWYuqsxxEKQ==
X-Proofpoint-GUID: ItIjLnwuxvu1VjyVAfHcsx8Wvrr79JRY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX6wciKzX6jWIn
 FKgxbZIjlTQ7ZR5/bjkfgVlGIJzytzr9xPKlgCgNPINqVFTvA5W1JZrIqQTJJ47fY/ljdGruy5w
 siQCYRCZq6aRCwlaRUMPepxEeGKkQrI=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae25f90 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=O3Vq37iqdNFKepAcUuQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> The Xtensa virt machine uses the QOM name virt-machine, which other
> targets register as well. Register it only when the selected target
> is Xtensa, via target_xtensa().
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/xtensa/virt.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

