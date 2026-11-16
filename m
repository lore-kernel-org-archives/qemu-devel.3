Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB022606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Op9T81A4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xd/VkY+K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT459-0001sU-6A; Mon, 16 Nov 2026 16:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT455-0001fY-4H
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:17:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT453-0001Ky-Lm
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:17:38 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfn2l4147213
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P6DHDPljrmEQd/pDa+kN50lbbrzX/vXEYCbTZBx4vxQ=; b=Op9T81A4yTaBBsYW
 E3xcDgz37+UZSwwbp+94NAuWqKVaxvaEPqjOfU+dtUzcFeOUrZmwFcMaI46DTuAT
 6hp3Le+sPnQaokY+sV99cX6G1+Mb2/SqGEHYuqRhxIt6wNTsCfb/S8kiRlIhHtYA
 Gk7eWfLVhn/q33m9j8eD9bubebFM2+uu8czbenrgCVsU2nTnTKMlynYb3oLoUInZ
 MMs+9fYHUDhA8rreX1566qpkwWxDFHRxrGHxLN2cVVpgazvrvO9Xz5HA5CMqRf87
 livMqnl3YjTTG2Xc39DsgOVZREWOJNJ8vxmYjQH+hf4Uti4A1bvUdGMN5Oyi9YUY
 xbiVng==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f8249h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:17:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3724667bc16so172212eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863853; x=1795468653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P6DHDPljrmEQd/pDa+kN50lbbrzX/vXEYCbTZBx4vxQ=;
 b=Xd/VkY+KIAPVfPhRgT6CEFG6tP6CcAHEHC2iMhoT6UkIt6Shl1Ki9lgf9ZSK8vIZnw
 KUDnBRRj0gegYvL5krIGIx5qqPtQaOEcb+ieGhPEyZricZqbfOJiC+OpNVsf7qxvXutt
 nNHcWMDGmJ+wzWgxaX+32a7m/RgcAd8x2WfMKJrS51Fq4A3zJEQqmn3wMTDENZadpty0
 QVMQhTsb6o/A67ZDiTqz0ij/aQejN2AM9bh7z8uzB2nvHZ44x/7RyR+nyHM8xJyRdQ9D
 jRtDJqnBXIYcqG0+Bf4NXD3Eg8A6eLhKd38hK4/BfOa72BZJT+hHv0aNtCBcbTb23pJM
 PmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863853; x=1795468653;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P6DHDPljrmEQd/pDa+kN50lbbrzX/vXEYCbTZBx4vxQ=;
 b=ZgHBsx6aONqSkFwUvsT0H62/SyfVwrGZAFT4FMi5NBMOLVBvxbTieNKiGCdmj2YGLJ
 Se6U1agM4hri8pWbrW5fl2mx+pjOuT3ZkFNDLJNBGgatmfrKylBzGGLpCDJH9+2pRyB3
 hi/qQKZ08LK9ueuibtm5w6BEpF7LxyasRrsM2OwofS9U0IZ+czNwo5yYrThv37nN2j25
 yV1JoGEtfjjY5nS172GuSCpX9X5he5QAuStVO4adisR5HOEaCEvkZA9GoLPiGLuf00GZ
 RI+aU0ZYFOIgDmoz/LlxGIkELAaVyLwUX33+oCV2UPyjtg7gzi0lMJJj3cDgK1FRjiE5
 TORA==
X-Forwarded-Encrypted: i=1;
 AL+hErGg3auPUr9jHugi33ixmu7KGvsgBCYR0nVosXH7pxLBji56PvGvCyhNcewsmv0HkfL0VyBt+pkzhVK/@nongnu.org
X-Gm-Message-State: APuU4Z9wnGYWTQlCX7B9+hVvBOTup7r7HVaV6QAMQ+IUTH/BodATcWI8
 hMfePvPI11eVwwbZ3iji9nPLA5n5NvbxenRGtfOw/8OqXQsTpUu39n+BFdw86dZbGENbnpD++BS
 /8QT1JrUHyUHHUAs9gex98oYfmRCnD/i9ELrfk121EYcXPJ/eV9iWk+WqNA==
X-Gm-Gg: AZFdTZdPsh1dgx4ylbU1rfQ6H6Q/WxTmtVoMu+FI8HFlycmnrHJJ0pNIMRveogjLcUf
 5fLbgS/Ea6GHsqDCS13T6aV2pTIZyjRsGuU6CzzcmsA8OZ03kOOLVt96fnZv0Lnn7h5xYJQ0Cof
 2eOe8Ymu5l/vIZGi3gXh0yHePunn/YRLTVHOFvIp2ypsfyimfb8M+TZ29VQG0uI+U84dtxev6zB
 F6JBbmipI5tCs3NpfjGJOWy/GYF+SU8vH0E6qPSH+j2AiWojs4u+aN6SnPxBrW5EC8/ldIb/SBK
 JNPLb1ZUwrffBwtzOSsJOyDmiZkNTCQGYTYq9YqF34lM0yyLiyBpfrjJhuPbKlvpI/AIsw8nt0E
 Y2szLG2TtQLKCdclZ79wanNRY+xCohgcsQbvjnYY2OkPT5SjGzo5X1VfbeGZOLRxHEBkB8jMGFh
 vZ7u62err3O52+lq60TeQBj2X2bjzSNyiABVdm8oTiOnM=
X-Received: by 2002:a05:7300:2146:b0:36c:dd3b:a3e4 with SMTP id
 5a478bee46e88-3810bb56194mr876241eec.3.1794863853273; 
 Mon, 16 Nov 2026 13:17:33 -0800 (PST)
X-Received: by 2002:a05:7300:2146:b0:36c:dd3b:a3e4 with SMTP id
 5a478bee46e88-3810bb56194mr876217eec.3.1794863852677; 
 Mon, 16 Nov 2026 13:17:32 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad134sm44911158eec.27.2026.11.16.13.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:17:32 -0800 (PST)
Message-ID: <47e56dac-f8ce-4f63-8e54-df1f12f6ded7@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:17:30 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/48] hw/s390x: convert machines to use AliasedClass
 interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-20-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-20-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfXxh0L/3S1oiEN
 qNh1Hgod8anY30i8BY2xzNlvM46t0Zw8LaK6VyjqNmM5KDftsEc/1iO8Cr53gFKVM6mf0Xi7lkJ
 skUmv/xDfofEKKTcAF5XKuPZXdnPjVJQWxhDs8XAAdNglmzTZZ76gjmQ4g/j/GADxRL592MX4A3
 LQFimGOUy79QSztmoGtg3JFguV1WFpSi2s0kWIGWwPfyS4ndyS4EGAhwvnMmxwFYJkisRbT8zfq
 bGOFM+vyfWnZb3M9+v1RTzg5/FfLjYAIQyHY3ZIy4Af/eDi/WrzvWTKj9azwJ0s+U4AM6LulK0Z
 dkdlvH1pwIAKOs4c8S6MZ9Kcb980wjBOrH/dsESwP99qKMfcZtf1+ndb8nIzg+1c1zSksRqK9H5
 V/Qe96Un1fB6IVVNreAFXGNatKSmJaCavuiJe1MWUSnjTToEyTgI0YJLsfKSebC5VEPbwT9WWeA
 XrbBcapnWCpdtRfG4VA==
X-Proofpoint-GUID: Sk9M5bdxDDxN3yxbMhDETJ23VMpdFVVU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX04Vw9KRI4wLe
 8PsIrN7od6RkW5QkePi4Abu2lIi8D7R6mlVmn4RMR+dqcC9P3kVTpjf/id+Kd7g3Jei6wCFKxXt
 scSCVAZ0/8nFr100xLJj1N6A4ymilo0=
X-Proofpoint-ORIG-GUID: Sk9M5bdxDDxN3yxbMhDETJ23VMpdFVVU
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb72ee cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Kqo8LxV5-QPNKTeuZg4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> Stop setting 'alias' in the MachineClass and instead set
> 'aliases' in the AliasedClass.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

