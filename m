Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A8606A323
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eFGmxKZD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CmVf28Fb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQI39-0003uS-Jh; Mon, 09 Nov 2026 00:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQI33-0003Y9-NG
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:36:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQI32-0006nL-7b
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:36:05 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93Jv5A042058
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 05:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fKBO0Vntn0zSBNd2LPK6fTS21Ps3a94mrKWLyp0llRE=; b=eFGmxKZDsKj+38s+
 fD1afbWVUaxt1Upx6tInak0GsBFA4RpB7GPKsO9pchsOx/AGOA2Xf6nCn7OOfM2i
 FRgOXshkwhrF2rZZKOTfQmUzKzkLyBuYlTdMXPN+ZbC3MwzSxB4jaDyuMgzY3Rtl
 SdlJtL7XcDg1JzPuseJR0zKp6Sr/fOB/Y2QOnuExfRmh78AANsXwRJUBOcHGegsx
 AeMQTpWXKhrLap6j21b6fIofmO6vtJjwkAC3WyrpzNlLRPx8F6XnugAaNsjVKZ3z
 WDYb49Ey61u7BHtxOnBVzjat2QCVna826DTCv+95XU1+/YNfE5A22E9AMf0tflFt
 a6tGuw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsspf54q2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:36:02 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b25d977b91so772822c88.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 21:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794202562; x=1794807362; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fKBO0Vntn0zSBNd2LPK6fTS21Ps3a94mrKWLyp0llRE=;
 b=CmVf28Fb2mF/Us65lSPg1ssUj0/B7P5mNISLIkm4Dg5K6Fh1/iYwwHd3bOG8Onjqlf
 VMV2zlwM2mU86O0ndfi0YSF1y2cjnmshMp5HF6iUKUuYSF1wdto+b79VGab2BvGIgzGe
 AG/QjuvLJUG1iJSbQJVt7Hags8m5aAL+t4A1pyJ5AHgzq6mX48SKEfOZv1uVIxhthe3o
 BC1NI7CcfhaJ9k5Ue2Jbs4RtF82kBQFlEUolL1ASUor0lj/pqAFb2vFADU0OHFmkpZhn
 8LN1tl4YwVlQWYAnSQSmuM3cAprgsE3DqMGOjCIxZZQnzknqo9QPctjMx+ajOEflLZ8p
 HwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794202562; x=1794807362;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fKBO0Vntn0zSBNd2LPK6fTS21Ps3a94mrKWLyp0llRE=;
 b=U7MdODRFZeVmkJv4d92lFCU+cKvcXdBtqesBvyV2Yz9hOCiBXpXt+rsIOaKwls/qGo
 d/QX8TcNuZBRMUZqkCfSzYe8W7d40VwRnoo5o0PRsJ7jGDQrsSsXi77HVOmbVHG1h42e
 359HSXC/imYW23kQcqrmiY4Vw8EINUV7+HTFRmTi+E5p/ciwJb/NQVzotY5/g1+ZI43n
 OT9EB/Kg+VbGQKDR5Op93FKT8h2ZX882UsOerjlV2iYEGLqpEDC/cUbzpyMetSALxNtG
 O/aUDf+fV2snDS/hJdu/ewPtiBLZfYUK07WAiz8IkCMEdeWavv8HTrJDc8FcF+VwwM8m
 x1Ig==
X-Forwarded-Encrypted: i=1;
 AL+hErHzzhIgCf+zVbEpLxvBzXXG947dQ1EJveCa6Ck4dKpIMpM9QfpgoO7tu6DqsaUt1DJMxFkG9hB0vYkP@nongnu.org
X-Gm-Message-State: APuU4Z/7uRBNZDVC6VNm7qRbgI0yg1rjTcM+oBPQlBRlXkCQv04XQIYK
 /jdHsmLjAV/hlFkhy8Z7iafasgxwBofEpBiEDU0UzwRBY+6T/kmEFh15Bd11193Z/xjWgjgi4N0
 hSGDIiIBSX9d3SlriwjCTQD+cVZZ2IZvMVEyzC3WtHcvNR+JiHeySjYWGwjx8uXGXXw==
X-Gm-Gg: AYBFou2dzWWiqQ0jelQKa1nGM26N/Mbb+fj4kFJDzMJ1NzgXN6oB05dTDJxx768gFqs
 EfnzofbqR3rt9H9SuQLcFzgwXKLwSTxpNDVI1dy/jK8Ew17Xb3HWi9sFL+ID288yrOJajCbwbEG
 oJuBz9D0KQI51uaFhI6hn8N5E5oDNSzkUSPRoN+Z+EZyOotpf2FyvzWmmi/ugDJC3nkGAYTRmkI
 eHhNQsqoZMcpQMeCPxLiqEdgzeKL3472ubrVki+Zd5MqvI+VE7uUH+hThmk5vBMFq0xK0uhGpGE
 Y0g7YMJwVbHKPdSm6X+EAgukcuascSWoSKSjwdYy37A/U72cCVpEjj0xEoJgmBGX8sxWPVaCdS6
 1txSGR2BvT+C7YAupELtBYyIWeUGzd0TSIEmB7ULMvGpr1wrUYWm2JvqNHzv4S77iBlcBpOPvVo
 cG9irX4LBKNhB7cpC/eMtYZX/KXfgJg6evFc0DYuQnEw==
X-Received: by 2002:a05:7022:3801:b0:1b2:42db:8a54 with SMTP id
 a92af1059eb24-1b39fe9abb8mr4943436c88.23.1794202562158; 
 Sun, 08 Nov 2026 21:36:02 -0800 (PST)
X-Received: by 2002:a05:7022:3801:b0:1b2:42db:8a54 with SMTP id
 a92af1059eb24-1b39fe9abb8mr4943407c88.23.1794202561574; 
 Sun, 08 Nov 2026 21:36:01 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b37314826asm11570731c88.3.2026.11.08.21.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 21:36:01 -0800 (PST)
Message-ID: <61b20350-1272-49cd-b1d7-783d857baecc@oss.qualcomm.com>
Date: Sun, 8 Nov 2026 21:36:00 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] docs/system/hexagon: describe integrated firmware OS
 boot paths
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
 <20261109042307.1301438-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261109042307.1301438-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMiBTYWx0ZWRfX8W+Tb0Pu10jx
 2G9pGyw7GrXjql8HVqPixYwhdBtVMdk1VRkLUF0KTyF/uSyTqfdih22vEQ67M4e409sbSb+Wn4d
 FWx13kdIHvBEWgVNAM9gs0IAqA7g1HM=
X-Authority-Analysis: v=2.4 cv=LJzz05W9 c=1 sm=1 tr=0 ts=6af15bc2 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Acpxdlh9m_ZGda-odW0A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: ylPGAE1mEOxspbTK0IGaYJ5ngzomY2JK
X-Proofpoint-ORIG-GUID: ylPGAE1mEOxspbTK0IGaYJ5ngzomY2JK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMiBTYWx0ZWRfX8ViQbSyc+feE
 kKB4nEFHQjcGBWwO3VEQhpWdBJ7W0lZ6Nmg6gb0tTrhZ/57bjYi197km/KViSIZ0njcRDHZh5S2
 aQ02OAdoc2enYDiRl27c90BqVQSuG2y6TTeFX+z7NYUkkV91IIPik2uOSxIQyAuuXRkDjm1UtXx
 +UpfgEFuikiV+zPIsciKkuoimctTvoijHOkPEJ4hEVzS70oJ7o9/NaywG4gGDLPcnnpzXwvDyNe
 gxdddS6ST0679A2pZAzLWgU1UinZ0kxQKBBV2aIqAFxfsQky1W5hQzO9b+y/Ygo/zcHyEUdU5Ol
 auB6AInHom38MlnKxHwTkUJe2PupHvS8F/X00/AS3pm+IXRbJ4byIyePCDL5BS0/5MWG/iCmO+S
 g/B8TIS9jiwbmYq77AGXxh1+jrkmwY3EQW6wQ/+CkQLvfMBgul0Ps3r9YfzRVCXhNHWV37GASf5
 5QTshxV/npPGgyrZFkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090022
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 11/8/2026 8:23 PM, Brian Cain wrote:
> Show how to boot a Linux guest with the hexagon_loadlinux firmware, and
> hexagon_booter for running h2 user programs.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/operating-systems.rst | 50 +++++++++++++++++++++++
>  docs/system/target-hexagon.rst            | 12 ++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 docs/system/hexagon/operating-systems.rst
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

