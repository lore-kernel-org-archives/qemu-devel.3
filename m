Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1B606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LAykDIAE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W7jM5q/H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSwtd-0007dF-SF; Mon, 16 Nov 2026 08:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSwtX-0007cz-4I
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:37:16 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSwtV-000457-I7
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:37:14 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0nos1482579
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 li7RhSsld9Fwt9VIVXRViBOaARXLuWLSiJfAoXX812c=; b=LAykDIAEO8j7WXzx
 joeVyGbgoj4Uhxy4/xbUho0jZYz7CNO4DLu21KIKiT1gCm3Ly0ljcJTINW0Uxnpa
 /WI5snIIzpuwy7wWgSl+FIXMTxQMNBUgEXbSMdtwFF9jMIuV03jTBII3HJ6hEjZx
 MDjXXWOuvoYH7fQLy+PgrEZqYYIsqCNrt8E7NOwi0mAWXBBn1VFIbI8fvvOErXC1
 DI6NuzDSBwETW+C1p3LSosJ2njQG5dcjvH5zuiFPdSInp4zxphAXc6+ybxOWxCm2
 vP5LrcdmldjVdkF+YMq/B0mosQ3IMG5jAJbG00iPUM67MqR8y28pQsDhrc949q3B
 BBsBIw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqgqfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:37:11 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7b206156cc6so1128541137.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 05:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794836231; x=1795441031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=li7RhSsld9Fwt9VIVXRViBOaARXLuWLSiJfAoXX812c=;
 b=W7jM5q/Hxxbtyb+RuB3+lGrx7XR+wZfkjB4E7OWqbY4KmvWaJmLtHPQl0EBDprYnB7
 Ez8+xtK3hhskZJm1tQesEtH5NIM/TURKC5gQV3zRM9jaL6bebz2DdnqRDaPTg/xi9e6E
 Z53q4lrGEVEk3Auj3wkrjGg7yFBCJnv1kFHZipqfU8SqI61JI0XQAeIqCmfGiGSt75+q
 t99+i+4jbe4o1G438rWtVYXU80hq8vg75kLvqUX1LhSdigBIG7VBXvF550y9wvquVwGS
 47BE2+q5HjQ+jLhhxEJTZpAf6FRCUqqRu9GjskFlyVlhfn+Cf+jiyMRxNbouKxfKqs9D
 bQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794836231; x=1795441031;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=li7RhSsld9Fwt9VIVXRViBOaARXLuWLSiJfAoXX812c=;
 b=mlHYaaR3alonKPa2f4OUH8/r477Of9qL/ULYRgtCa9iiMf+J/XDl3ghawwtoAI6QtU
 xwgSVaRIGxKoP0kz5+iKHUKJuSupFmohAw2UHBg4XBTclnILq4vehoU/l4EC68d3dHpq
 mEyvY0oF48y7iCx3Xt0JXNfwf9WcfIHvCLDJnFeYWcWf4afCMKUbMqPTA2vP40pBdB6R
 lRj8UfCt+YQKyCMCFCF9dGNipsodHGQRaJ/qvA0VRSoUic78drOXY3TIc/kVo/fkaiNl
 gV8wZhZHVJQv8pnoMHBK2+Btcuk4lmKubT7FBAMHe3Z+wYFQYzZG5ELM1bAF5Oex+qCy
 JPUg==
X-Forwarded-Encrypted: i=1;
 AL+hErEhjtCD2BjlLvNQauhgwaVprKcNALUza/wMRBBw2I4PVEgQXLvEPg5y6Yi+k0gYBHRAmltpXlwlFbhO@nongnu.org
X-Gm-Message-State: APuU4Z+OdIOEV8JmgLHIoCBeaTpcORw5u+HRrJQTwA1m8Up+wDl3tw/4
 PCThpJVtAXP2WLraWg2iAMYU4eu5aNrtudw+QNMqnFdWfjNjrUnG1gvmdbBXDYldj/ZIwt2nG2e
 3HkQoinxxrWWAyr7+2aBGKKWgRc7NJqnMR3hVbvd0avOPDnAk/Te/BgEb8g==
X-Gm-Gg: AYBFou0U0EK0DJlb8bC5S6Kyh3tU2r/TsP3s8ntz9f6h/1nSOPVRwhnsZK4xnch+fvF
 BcSjXdETxkMOYoh5euNTXZvEfGm9pqLxxLBbJPg00VRhWFyiK0BmhPYiqwdAA7rlswuQWmFfXdV
 uIMfkHti4sX9JI0f2ne+3eLhxDPj+Yh7R0cnfAbAk6TB9DoACHTny8laJGxCtGjmE3EvtMEeJx+
 HBEETbmvTL7NZrCtdGi0QbfpgbPhoUm+Kpqik2vUK5ggjA9hr6lV0LKrFyZ34qWAnV1Drykrspd
 dlSP4gMOqIA1lq8QGA6UKhmdcM2aw6ILtvDsvj7CjUcuoHUJKpsNIZwUuf+Xd+K5hzYsXVo4FsJ
 oT2J9JZ9Pf6NsLxHronFvRPqj9S4ZG6vWPCafPZXi5J4aikfaA25mVojRg3ncxCCJGAQH+w6qzT
 Fvv+ocDD8=
X-Received: by 2002:a05:6102:f11:b0:7a7:198a:c2bc with SMTP id
 ada2fe7eead31-7d64d8e23f8mr3554533137.36.1794836230814; 
 Mon, 16 Nov 2026 05:37:10 -0800 (PST)
X-Received: by 2002:a05:6102:f11:b0:7a7:198a:c2bc with SMTP id
 ada2fe7eead31-7d64d8e23f8mr3554507137.36.1794836230069; 
 Mon, 16 Nov 2026 05:37:10 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7292c04csm71676585e9.11.2026.11.16.05.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 05:37:09 -0800 (PST)
Message-ID: <3cf772ce-e832-4ac7-97ff-e47471b55767@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 14:37:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/26] hw/uefi: mark the EFI vars service as secure
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
 <20261113184254.2524253-22-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261113184254.2524253-22-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afb0707 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=g8pHR05IO5SkXPeJrvcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: p0hBlO3fYlwsQ-7g7VJD1ImlRExVQRwz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NCBTYWx0ZWRfX/LgMduykmHLb
 d30Qe/e65Kku45kyHDfs/LJva4ESx8pYOkq2f7Y0aH5EnzFcc9NuZr8QQZG7QBGFS2+IERU3AZd
 9C+14i7IqRBYZKRO6Pmh9rnt3N2p1FfhPF0ygWGD5j5RtobHNdiaEvhVsr/QgnHzIzi8Zwmr+sz
 Q3xU+JgWrwfW1rEdENHYrV40ljAv9iT/i0qJiuXTw3Ffs5HzP/zGtuxcKlrH0kNm/VDQj1Oi1PB
 GmsVaUNhWlcWqMB+LMUKLhHUYp9JkP3voERQMljX7ohp6hQIBIRyrfY4alTpVqhQOcbXIumkiju
 KWnw4iojesYAJuOLr6J584M3ea7ZI+cOQwApdaLCXe9/iBH1z2sUX6PwRJuOCul46qev/RI8ZyF
 F/AbDSyhrntiLwMQjHv+TTD8C5wIemQsG3Xt/Hit45RKhxfCFlokPaGMmvJsKGcH0V7MapvNeuc
 pAEubcunwUFmsfJNsvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NCBTYWx0ZWRfXwu1sxod+R83U
 unhixOlVdIoszAvUQ9ySOkeMICUZdRYftQo53CYjCnnG/MOx0D59fb5WYqOf3b0pUUeKyVqFIz6
 A6Nc60t2/3URPa7pKDSBXiV3uLYovUs=
X-Proofpoint-GUID: p0hBlO3fYlwsQ-7g7VJD1ImlRExVQRwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160054
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 13/11/26 19:42, Daniel P. BerrangÃ© wrote:
> This is used to persist EFI variables when NVRAM is not available
> or undesirable.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/uefi/var-service-sysbus.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

