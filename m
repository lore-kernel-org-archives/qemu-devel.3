Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B9606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FxzHDsgo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RW6OsoGw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOGV-0001K7-SS; Tue, 17 Nov 2026 13:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOGS-0001IZ-Ju
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:50:44 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOGR-0000Cg-3N
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:50:44 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHGYSNr2743248
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w8GYpltXwlSOppYJhxwVwL0mt/e3JV25bMk8AacCoCE=; b=FxzHDsgoUECrXJIF
 QPtj0I9FDo3d54fMZoDD2iumBaP5j79mKeTHgTCgET8tEZYw78Polm5Qsc6Q87C5
 mVSKpi4iTiG27FdK3pUP5A6diu3tT1tSkKLvMaFyFlKeR7uIz7ojCpePchUBn/A5
 3mxliWDcsn4AzBI0iUnmZnJ8pCxCNEop7Wwi8Dcuj40kU4tq/h6aNNKjYChfTaGD
 7xPePBHm4GfXtIUMDpSAwVDRL8AH49Rr7FempZTbhNP5W7BB7VOcG8+NWcMPAAhn
 WGZumLqA3GHdYdMx05qPI0SVLj4KJTQhDct6HiijUaFzN1pWmg+mVpwyJFoWaLjY
 DwnkXg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0tjm0n7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:50:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e92aad34aso36621885a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794941441; x=1795546241; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w8GYpltXwlSOppYJhxwVwL0mt/e3JV25bMk8AacCoCE=;
 b=RW6OsoGwgE/fJqTVxqrBOPZAZJCUuMyUX5cQKd0jxO432S8TSH45XeOQ++6cPNyiiG
 XlPI0xXZTDXCTGxRet5SgzpaKuYlxkylGlpo9flMQMYaFwczdWk9xt3YdouHU+s6g/xB
 NLC4OeMEGq0phep3hStU052P6fG+ZmcI9lHzFcXro227DoyTsKHPaklMjevTUitaXLCW
 ScFaXsXS7h3Q9cXz6C68rBEQVe96JfNkCb8WHR0nOua7P+2vEZscknvQiaJI0uFXh7JY
 1r3kC3j3Jqn8XpqG0HgzVkIZucwPaOInoSvXXdZ6HRMa6lBcNqZZprgGvkp4dZjsBISu
 tVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941441; x=1795546241;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w8GYpltXwlSOppYJhxwVwL0mt/e3JV25bMk8AacCoCE=;
 b=MKaOrrzwpZ1pIYQRrMpb1/FwYp1+HwW2CdGlaFDn4d5jPfbbyGW3YlWDYFHUaf4Lc+
 hv1/bTDqAn0sMCClpyiI0ZpFGVXlYvkgw9ufYfaCxA738zgB/+JKrs6XZoZNWVOo1+sG
 7TRXcBIUhLn1UCYkOwWZs6Di9LcKSAu79mDWEpNZvyxjeW0e7UapmVImYHpEPF9wLoal
 CWQ/JJ8Q0yfTYcv3nRQEXVK/xxpPNZAwSo3wm2zxk0S5gf55aFnYAmwI8diHNpD+tvzp
 z2lhrihR+o/cdej++CLF9j6umAwV3blE4gmqINBCsWDR/vTq/SQpkONGIf4CluzTglPw
 mXkA==
X-Forwarded-Encrypted: i=1;
 AL+hErGARrdXuTfdysDzBw3cQIJjTWFwzxRI/PozezMKD+2/spK3khzZub6TMG86W0AduxYKtqpnj8NuRakF@nongnu.org
X-Gm-Message-State: APuU4Z9/QouGeDXnjZ/WlZ36Oo1cNlFN9pmu6HlMy6vFYGTShnYOIUQU
 /5S8Gh/UD4EuVF6s+o88xepUle4Gs97F2pV053C+HU4HTCz2/xMW3nlRasBOec09ffYJpiXIwUJ
 yxsgHoyB7V5CGMn1+como7PAXUPhLpD5bDcRrDBat/K8wLNrYfh9+na6uciiS5+8f2Q==
X-Gm-Gg: AYBFou3Ig2vHszDZcr3ealUFG34kebWJQwCLZ3nYDXti/7vS9S/RD4bNf0sX7U6/7vv
 d4UmkN2uxyIRsgXhaJs6k9hgsm1Y4jrDuoO+ySNXQZkhaJBxf5p802hzcjP+p+u063oXreGKim5
 zDGRUIOQPBstrgztZdswfs/RTTUaS29OiFmCZXc9tDvRsNhTUFR4alhDO9F/VgfXDlQD51KqwI5
 0O+o2gA7LndNzQ1FhlcZCtGuJjAGikOiWzgTC009IsBkXUPVRpvXT3VllGArLRumxrm9B807kIx
 QcHj6reeVIdqzFVi+wAcusG7fiLkMK8osSyf7MEQevWR0PmVHqTwEC1e4QTFAfUIrczxVlCCITo
 b8sdKrA3E4c+TM2d0Y4MesEJUrvXSLmz1PzMSAmiCWGSxrsSfrMr6NUhUM5sQ2XZilAWxwFPJg6
 F60wpPJKAJw2mu0OatxOeejpg04z2wB9Ws2zAgVw==
X-Received: by 2002:a05:620a:1714:b0:947:b201:fabb with SMTP id
 af79cd13be357-949995e0a40mr108944785a.58.1794941441337; 
 Tue, 17 Nov 2026 10:50:41 -0800 (PST)
X-Received: by 2002:a05:620a:1714:b0:947:b201:fabb with SMTP id
 af79cd13be357-949995e0a40mr108939585a.58.1794941440699; 
 Tue, 17 Nov 2026 10:50:40 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c5fd154sm1134197085a.2.2026.11.17.10.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:50:40 -0800 (PST)
Message-ID: <3b9c4b3c-6961-48b0-a38b-959e142b1f24@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 12:50:39 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/hexagon: allow writes to V85 USR coprocessor
 fields
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-3-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261117183629.2002840-3-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX2NTrGg/8/nJB
 avzsYUJJgh7ef95BVXPtxhJwE+tmGfhtGKphdJ27Dw+M6jbUCX39aKbBhzDFi2t4N0n6O8+wWwP
 /VNMVeCmC+owIlu0InS13Av1bBPcXF5ivvPz/i5ShLr+nZkBcNRvWuW63rEGVPx1+XGs+JdVlxi
 oRMT4+Pbf1pcv/igkHRwzvYsnU8xQ++Lf0ARJ9HiEqjQrL9NwPqkcUBefFv5C4b70+TcDUlTB9z
 QQOOrJTqOAsyM5yRIYdiU4HnTPuhOI+LBJYQTTPCgdbawlBvPueNz7xUHXgUKALF34fDMfHydJS
 tRzpAVWs3zmwT8py6HXZL8f+XF/3nJmp3hdwZ45E4hrb4ItGa3cep8OM7huB1AA23+1s3wJwWWt
 nP92oezN//Bb3TbyxWuCzV9lxI+CoNxa4MS8PppdmQNNmIbxZM8GFrwv+hrLbi/Z/sgGagK5olm
 Y9Doi4HN82omknbuQrw==
X-Proofpoint-ORIG-GUID: Ue1Zb3k8bKLMqhg_v_VKFHgrn0FvvHCA
X-Proofpoint-GUID: Ue1Zb3k8bKLMqhg_v_VKFHgrn0FvvHCA
X-Authority-Analysis: v=2.4 cv=Br8IUoX5 c=1 sm=1 tr=0 ts=6afca201 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=RHQx16COzDxkH58TiCcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX1OxSxO12XNjK
 r5s3wW4Oz3zO7kgwWjlYPTgHjmYdAHGX7Xmy9TuKus4BlEntEdnuUpcmsgz+89hinmG5fz9tKxK
 xbTASzNVrY047un2Dx51Y07EpvBgb60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170075
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/17/2026 12:36 PM, Marco Liebel wrote:
> NPC and FPCOPROC are writable on V85. Remove them from the immutable
> mask for that revision, without changing older CPU models.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/genptr.c             |  6 ++++++
>   target/hexagon/reg_fields_def.h.inc |  2 ++
>   tests/tcg/hexagon/meson.build       |  3 ++-
>   tests/tcg/hexagon/packet_user.c     | 18 ++++++++++++++++++
>   4 files changed, 28 insertions(+), 1 deletion(-)


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


