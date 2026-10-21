Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2F606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BjyJq53s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hfhxxUiF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMqP-0007rI-HX; Tue, 20 Oct 2026 23:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMpR-00055p-Kv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMpP-00031q-OU
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F5V83256736
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eLnnq/3t6lFzzm3MtKhLbOXQopIfJhj0UIHSz2/MDuc=; b=BjyJq53spiVQC5tq
 srWJduQAtfXQU5SvqNF9ij+YdXKouqGbrMdTOinkID48YxKHVMqsL/fpBUn67FEV
 z+ag5xijvj7hV+IrTkmlg2OQtfWTPC44FiArNr0HgxN2kABu1FB+/g5BLfap6I/h
 2BjHNdGf6NPznS8aFxlq4NMsKF34A8Ahh7pHXBwE3gYuHm9YUfnBv8aDzCIpkWkh
 zAXDMjUrvTaKoKfZwo8FqLD+KxQwhTTuCs+R0ZEgAnMqDBctA9yPKxjItqhrH/TD
 ajcvVeea2Bx253nBuxveJZ+2HcZCuy0foEDwp2hOk+FZRv/14KWgRPRTMFUR1WTY
 btZhgA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v1rv4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:12 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so6703596d6.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552632; x=1793157432; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eLnnq/3t6lFzzm3MtKhLbOXQopIfJhj0UIHSz2/MDuc=;
 b=hfhxxUiFM+XAVFCXiXvkAAP3RX8uQ7MWzNmVGhVHlt0vfGPX3M3Ufp5zKMcelfCkvH
 HuzXvSJ+vCdU6rwtC1AuBnsEbLfvmY3UVymOlu4iiysN4Wrom3vkJutZYi6TjCULjiG6
 hJFJpOSqeIm2e2gXIDtsO15OL3sDHxHuLA0dGpX/lFjIxRZWBIcFeX2LX+ml+adIwRbm
 b+f5yX3URstE5iMr/z1wanC4iOW3Lab7su7R57YQ/kkC5dUd35rI/bf67SIskQc/b+Fa
 l8HZBAKi1I/JGkd1V037rRkabvEYCfJst8nAU9cKxk4d+gmyhMSgLroaCIL5RdrVv7ic
 H7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552632; x=1793157432;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eLnnq/3t6lFzzm3MtKhLbOXQopIfJhj0UIHSz2/MDuc=;
 b=aRByO4t9SshSy4KM70WkPNZFgULTRubmcKR9N80U1zBMDTHT01H8Ri0KIvVbb1Tirv
 RMjZmmpX/n0Od7zHtGhSND+LyYay2QcTj+7QYkAfpDcB4eTSn65YUKSzaV8kWV3D88qM
 w76Yftr4eJceQCsnz9XrSKSZyXyXJJaJsdafNRbCJBFAD/DYaJ+zVMd31ZSkDkywutR2
 Sc1LAghfjfXTe8G+HMmNsE1U0nykUmbuRvyvCIeBL23Ch9LMAzine97rh46fmL1iD1OF
 N4wdhgmFuXySD4L+vgKTtcFumviw5D0ZXSGzxq9ps+v2tCmvhBEXkBxdYcTmFjwsXSCo
 /9Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4kjp4JquGZNsymEzNyltFODlkBbCs0R9QZSfgBM0Ii9JycIvbyzBlcXtSEOx9OMPFBX578d9/nwAe@nongnu.org
X-Gm-Message-State: AFq9FYIYC2njuh6ibDk8GDdXk786GERJ57XLBPee6JJhwHOk5kF/RkdB
 b7icic9AGMLeJDRhCkOhJpCfrGrEQ745EyOH80JVfVP0vKXpYTzfSgEsCTyNO3fjglaOGcwfuUA
 4xImZiLHWw/1XerwICqkYNgqF8NLmxjMf8KmhONbqKrnvHWnxbV+FaHhKHg==
X-Gm-Gg: AYBFou3ab4LZTttcHvhkuZ/8oclH7+ePyLpAckafbzy6FYPscydMyJDPeWhOlqElfyL
 bVAYxVmqXmKnd/wj5EtTTr3rOmxGeseCzsv+NpJmW2HZomGDo2dCcPmAYaK+0RodlJIXZ+iCKL6
 Zs3EVjEklAW7/ovqBPCjbOXs2Fwf7FnVGynJeepVgnFeu7retq98oR+OBFYrvkOwxZ+jJ+nLfaL
 nyKGRQj9JzwQX0RevS8hMF16uw4tGzOod50Ocxn900zgAiGYO3VTcXkmGaJ1kN8EtME8Y3ncjeR
 VJcCIP7BJMWBsgsOa0hLQ7VqSIMGYXoN9u02JIh4U01MF7kmTit90SSf2oUV8si6VvBuw0vEFlJ
 HOYmRTR3I4kLHRGsMmdEREHNTIc9uuiDEXA==
X-Received: by 2002:a05:620a:701a:b0:93f:2465:26d9 with SMTP id
 af79cd13be357-93f57f707f1mr240187085a.18.1792552632225; 
 Tue, 20 Oct 2026 20:17:12 -0700 (PDT)
X-Received: by 2002:a05:620a:701a:b0:93f:2465:26d9 with SMTP id
 af79cd13be357-93f57f707f1mr240184385a.18.1792552631829; 
 Tue, 20 Oct 2026 20:17:11 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd59482sm16569835e9.4.2026.10.20.20.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 20:17:11 -0700 (PDT)
Message-ID: <bfc253de-a8d7-4b43-ac5c-16a95786c125@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 05:17:10 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] target/hexagon: avoid negative slot shift
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261020151720.728888-1-brian.cain@oss.qualcomm.com>
 <20261020151720.728888-4-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020151720.728888-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX6IIJIon/Dn9/
 9SIZogrELEfkMmbg9BBbAjcNiSIBDrana6oHfCAcXkTKhvWisiM4CT6IgoxfGr8++QRvHE48OVm
 VsX5Vu2y3IjpDiUXaLAyqCKsQLSndds=
X-Proofpoint-ORIG-GUID: wumUQREUajtO0m79apyb4RQ0CcZqlezt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX/bkiKwG1xKE/
 PakS07Ye1pTfhXodqtURWNe5np3x6rRmwMA2dGwDayw/45KQ/SuGFUn2HjoGkhZjjma24cZfGjv
 f/GHty7FLQheFIDPYKKW8vGqE63xWfdh3+GWueupHRVhDgAiVCbUL8r9flfz4u5mE8oYS3k09RY
 vMQfiOK2ayWd4RzyqCa8hudCSHr3I8/yM/I9SGYhDeTAYo5/7trxewh7ZU/kGumK24sffNY2tPK
 HPgVPrGLw3rIG31MyDny5wLJjPOfUn+clcpAlWTPr4qPaY534A6tpRvgeuxTwWR3BY2gvY5XY1p
 1cWfjbKPfPrQlX8OTl26WUFj2qmvQzh+evFqaRJph1PZofRDj29tKM8lp7LUg9JGN5qXYV8YvdT
 s3TyZPGh1lCtydGXXKkfoUCBI4SJ6Q6l+FqdFLCy5HNs5XdFmjIm9FRKZ/Y9vcTOIr9gjr/goUF
 IeTiQpo0lHMFs58g1ig==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad82eb8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sr6vh_Y9SprzQFxqqRIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: wumUQREUajtO0m79apyb4RQ0CcZqlezt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/26 17:17, Brian Cain wrote:
> Invalid packets can exhaust the available instruction slots while
> decode_set_slot_number() searches for a valid one.  We would then try to
> evaluate a negative shift before returning the packet as invalid.
> 
> Detected by clang's UBSan.
> 
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA8CYaJ=jAyc29RSdUMD_SWquJqz4fNQyW7oCrWithZhYA@mail.gmail.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/decode.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

