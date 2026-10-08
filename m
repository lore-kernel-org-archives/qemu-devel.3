Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D7CCA6016
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvGY-0002B6-9r; Thu, 08 Oct 2026 17:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvGX-00028z-2H
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:03:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvGV-0000va-74
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:03:00 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0BEL3858745
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SFJ9ItgeM8gE3OE5r58NqWvAQBQkX7ueNPcVdt4tuBs=; b=cWQpiXuWmz4uS1iZ
 PDNGbUwL8JDRhf2/9B9RI9K/xdWYRWQG045KsuGIp5IoV0XvlbneSMrI62wTbU0U
 XX0KydXfvqZl+m/sl4J3+XlkKJn49R0tve/yscmaL7TWnPfbfLp/qjZ+hsrvLe29
 PVoAwKuSj1dMQBGdN0YVbEBmHNqEqh3WRW4taQ/2SL9/FFm2T9JkUn/R3Q7gxfZc
 Ie5j27gnvltvGvMm9x2enortkpcJuKmYDXBnFptke9lzSevj6Ui1fpRtFyREM5nS
 19uB4AI31bdW0KiEctwYZUOkB/S0DozFKIe0C0zi5/u6nKzNbjyTfow0+UaI5YJT
 L0LcQA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6b9khtkp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:02:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-313d1015161so16328341eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493376; x=1792098176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SFJ9ItgeM8gE3OE5r58NqWvAQBQkX7ueNPcVdt4tuBs=;
 b=blE+823LIvjbPFvbswGzLtg6jfikxPWuj8kUCoICUdpqEtUZMu5I6Kl9pyJ2eNv5xN
 MkwIpWgXGRdrRE8kXmI2qn4bXvAXm5AJkIAwhcJKPps7xdrg5avn0KDxBFx5Qrf09wef
 lXoMJUa6x75KOLWEpI7/lKtupQRHqvwtfSCL9OJkR+7T74UktnKpMt41/HFb7iUvkjQu
 8o51WQDsFbP6kVxDQ/UjRRGlj2RZ4YfMwSpnY+jmtHjhb2RLR2remZ9Rq7cuBQAJKpp4
 9IqniwZ1SQbpuHox4YyqxSHMKJi6dHwfPvgbp2Gn5gbmjep9gzp7hx9D2ZsD2cSNTEVL
 h4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493376; x=1792098176;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SFJ9ItgeM8gE3OE5r58NqWvAQBQkX7ueNPcVdt4tuBs=;
 b=RUSYjt8Jh57UACVmurSKUuYRgy5YSTpGZJeUD51Vq4WqfcQkFE5G3+gcYloAIHMtVh
 nOlWsvSBzyVcvb7uO0abOV4HSnFRBHnF7Yvx9O6hpkf+zbemdnKzvxjgeYJIJnFScSLx
 9sDLBUYxzZ2vKvCgc+IYnc1aIs4Lmr8h62XfNRVHYZSYkEM6wcNNvijPZokzPGEO6D6D
 i4+eyQ/KSHXx8xKR9O1rf4vw6SRJRl6qXttq+5gH4aLcXSaeaGQovmA2PSFD49PlhZHQ
 QETAt1cNDZkzWwP5SbH3Vvvc2cxrUwsxoUCZy4R+VEI6cA4dwd8wkTFmg+eGVXR8VebI
 MU4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMz6JTdkxflJS/23lfSv4TU8DEBNTHGIimTuW3CTo5565deo4ytgWNXpZGz5/y1Jm0JtHsLrD2qVZx@nongnu.org
X-Gm-Message-State: AFq9FYKWWqodqxsAYpb/ZMKtJeJlEC0El7yfbuV3y60YupsVOTXb9GHq
 EF14rGBL0rxfl4kCbbmQTOzKuJZep5SvEfs54PwVm8nTCPE82pH9Eaxn4fWaa+0Fq0gh+sHjQxA
 a/J5HLXPn29aUEgpYCd7uSynFdFsRUj6iZmLvxP72SAt+xwTggrkwPPLWCg==
X-Gm-Gg: AYBFou15Y/BRSpPF6gC+xciXYsK41FU96Vz8MdikJYYA8Kbi49048mdefj6pN+s06iN
 HtZqONbe4ph5wjZqjR9KAZXsd5iArtPDivq36FS4L0/JXvrI22S7KShovofHgisVY78+Ga3ETdP
 yAo7oAPTAGGHEX0BdMNMsNUS+AMDekWslNeqEokXNLGOKdvVbWOpBh0gwkNUdeSk16pt8aYS2v7
 9juXUs5pgS800SNKz23H373FmkBLeIN+iPcMe/9F9rkehBXPrk79xshCHdP/pwI148hlw9sf6at
 MtqFZuiSi2qPsznGyuVkSe8SPJiB756QUtBto6lu1Doct4NMh2V0L2/jGpNWvkbXcEbLaE14Kiz
 7ZvM/KGELIzkd76xlydPpzoiEhHpdknXPmjzNNtJNt9n7lkQsYWh0uaieNRluiAw8t7bBEA==
X-Received: by 2002:a05:7300:f408:b0:351:58d9:7d9a with SMTP id
 5a478bee46e88-3537e13378dmr58675eec.38.1791493376107; 
 Thu, 08 Oct 2026 14:02:56 -0700 (PDT)
X-Received: by 2002:a05:7300:f408:b0:351:58d9:7d9a with SMTP id
 5a478bee46e88-3537e13378dmr58640eec.38.1791493375371; 
 Thu, 08 Oct 2026 14:02:55 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb6a2afsm561539eec.31.2026.10.08.14.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 14:02:54 -0700 (PDT)
Message-ID: <0cb19453-637c-4eba-bd70-859231e6d98f@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:02:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] target/hexagon: add v81 HVX compare, align, and
 convert instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>
References: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
 <20261008003711.3984454-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008003711.3984454-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JTIzGj-IpVrf9rEpxxkV1XgLALjSmgri
X-Authority-Analysis: v=2.4 cv=U98Hnuru c=1 sm=1 tr=0 ts=6ac80501 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=l1EwPZTvEZe5bsRDspcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4MyBTYWx0ZWRfX5OmST2oGIox4
 6+PulScAyf95DDz8/cNt1BePUboypQtHks0PfVqHxAsalDK3WGxzhoGHmXQBKkJw4cpH5Nzlsic
 SMQeKGmFfFGUHuMYdYcFRVHmj3D40+g=
X-Proofpoint-GUID: JTIzGj-IpVrf9rEpxxkV1XgLALjSmgri
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4MyBTYWx0ZWRfX3qgG+d8V1Vhb
 6vBfdR9Yx+eyoSiQIBVU7wlexC5sUPjwS3EXvA75g39GsmGqnUZdJsaZUidcxyAQHimq3m2s18N
 c8zX12yEscMbz0jDOoP+hWEKbDNws1nYX4yE6fkPfVdqbhOCThowWDIid5hZRSLdyebWn22hSLG
 TICkPpZY1qTtTHdue7Om0cg2QlG83rPYelTMMhgbLR5N1eEpRtMzGDwmx+UhPxhpgjr6L5NYgn8
 iQQVhKBEVqZVJlT/2OEZ7D2GxVUW5Tzktpo2s+FAQc4/sKVrn5xnoT9y6d/qO4+NUzScrsRAE1j
 JC6dNoeF3WTUoB/XcUnha7k2eJwuwuWmoOc7ZOt4hkLN/pCxhOHjmT7mEyRKbEtX7LOy3DXBUAO
 6EYtfKE77xccPkZY3nCOlMknAl3cVr3khQcwVlHDECvthGLMMJebx9SnMbNETFnX5odqm7NiHfl
 QD0v2ZZwsieaZsZjFow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/7/2026 5:37 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_ieee_fp.h           |  2 +
>  target/hexagon/mmvec/macros.h                |  2 +
>  target/hexagon/mmvec/hvx_ieee_fp.c           | 15 ++++
>  target/hexagon/tag_rev_info.c.inc            | 13 ++++
>  target/hexagon/imported/mmvec/encode_ext.def | 10 +++
>  target/hexagon/imported/mmvec/ext.idef       | 74 ++++++++++++++++++++
>  6 files changed, 116 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

