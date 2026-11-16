Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F173606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lDJW6ZTB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NwagTl+b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT442-0000Nq-WD; Mon, 16 Nov 2026 16:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT441-0000Nb-6v
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:16:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT43z-0000qh-R6
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:16:32 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfEgw611761
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +7j4VCuH5djwOlL6DRSWLkoVFtJ7QHMzfb4hjx7s8UU=; b=lDJW6ZTBAS82ijEr
 XZr3NOs2rM8sORZzJKcYdyDKBmotY/QQK4maTXu/O0F51G5BVxOi/TBzTIeOfOtO
 bHm4Jhv/d86wC7ZJVXlHlJ6nlbfIg2F2Jv398XTeaSigL8x4Ah2WsPjUVPaiZJfo
 PbS4DG+EhcRnl8Ry7zAVaaJBJLljPK1ZjttduFykFh4jWKolppBv07YhL+hCw3CW
 sYQbNnwXUw93O2jAE2uuAYEpky4WQ/D9dFUKDdr7PX9KS44+pzeLHVmL5AiWXhce
 /WOD4FZ2yZE7NvxMc3Dzra0BkriT74na9RslLpdYHNJvDAhGxuhlkR2ou1os3Wtr
 HE5DdQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6gjqmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:16:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-375bac6bd21so210228eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863790; x=1795468590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+7j4VCuH5djwOlL6DRSWLkoVFtJ7QHMzfb4hjx7s8UU=;
 b=NwagTl+bMw9FTmPZd4CFJDoxsjUO3aGaTo0UNsSjNs8UEMN8JmhDQtqjeMIVcsARiE
 ZFLWgxXSlPj3/0ZNwNR6PwtnEO2YL5aK97YBGfR7aJ3VE1yV4gR9QbXivrs1VOE2uJPK
 FPfcu1sm4sG30lYhdvHJ/kRBZkBsmN+NXXz84IEFs3XvnMJMjLxifyTUuFXuM7n0QF3G
 PqhQUFeNwSdOwcvb8Ubcx6x18kgTCsNYjXb58zI/wR26O6sfV1humPmZXYNWIU3QrXmx
 IrmehIvEQfWReyRbYxL2zj4zDzKsDPObFZjmCO7EgMEzK95VEz+UQ7YD3w4nfsxOlh/S
 nSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863790; x=1795468590;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+7j4VCuH5djwOlL6DRSWLkoVFtJ7QHMzfb4hjx7s8UU=;
 b=b6lkkCycjEcxq7o1blglc7R5eHkza03/lqnkvrVVlN1apMIIR8f9jZW8m5M5dVf7/T
 PGR1QNFOjM30FP1Ua0Bo4cxAZH5knID5wiKC18u979thpL3YerOJ3Jt2oMLf9NgY+Cm/
 rSCpwbQ/JAvj+VgjcTA0+dN7pXdm23APOg2FUEP9TS5djg9WBHRxY+Yq2T37Qh4m29qH
 BSucwWn/ycmGm/VpTVPZ6/5K4qQr3Nh66fpN6nU8h41koe60H1BG6W9kuaT0X1iFlFcX
 v6M/ZgJ0ULXPWyXnSdLtItuY3K+FtuDBgSkeyR5oaHO8sc6WtmVSAhvfeFeuT8Qg/L3h
 apcw==
X-Forwarded-Encrypted: i=1;
 AL+hErGaO8nyY5vHL0A6DIKoveFsT2pkIfrhgWzRUJCPcuyLHJRxNS+G4QQ3Kq4ZJCUs9TUq89pygYdoKN6B@nongnu.org
X-Gm-Message-State: APuU4Z9jI2gF6ZRQb6mmR60gHnMDVtVUsewOfB70bzyI+96SS7Oilwhd
 1Tc2HS7ZYKEerRi0OJ2VZTLaczM5siEAyaBIAVcwe8npN4KlheY1S+/3ogahFNEoJDXw4KraX4z
 fYQoInCXPQLgLZ5iNKn67bx7bZaQgShFMzWrIDnp4y1clOo7aBiKjRRb7RA==
X-Gm-Gg: AZFdTZdxCzQODysR5otxaEbgqYO4lF0bbIgjjk66qgvG7hrcOvhNcYG/T2cGvsTnVWT
 un+GfiEtp0f3tO8RwGeN0ACeDwoup0Q+XBlGgy22TIV+pcATbe3RKHmd8Z1qCk5g+yakLu/45FW
 SHCZW9zjijIc5ekyJbkB+J6H467GLozHkeFDKUjdVMFMpCAXTt3NI2SzS5r4IFdiVx9KW08KczW
 zr7U5gnlCXppIK5LBlrlZo+5mqqHJUO5h29vNPl5Qwh8kLneXZyegzugwyejxBihC0HUQwX0zHH
 ZbVsUsaL3sRxsbtSPXa2KRrGmoYsLzrSdCUdYkjzn8NF42sWUhtsbDntTbVKv/dHsDlZsfxH+qX
 ACVFid610Zw/aCCHsE0ufZNW4E5hJfihZZ1iwaacPeHsYicTE/00LoFzbdtLQL2I9bvQpPqHulf
 gV8zHdbvRT/EUZjnf2JVZZyTDdpPJQASHguGKKBaWadgg=
X-Received: by 2002:a05:7300:2146:b0:375:6fed:8e71 with SMTP id
 5a478bee46e88-3810e419ea7mr827396eec.7.1794863789739; 
 Mon, 16 Nov 2026 13:16:29 -0800 (PST)
X-Received: by 2002:a05:7300:2146:b0:375:6fed:8e71 with SMTP id
 5a478bee46e88-3810e419ea7mr827368eec.7.1794863789207; 
 Mon, 16 Nov 2026 13:16:29 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378d7e5sm36937145eec.3.2026.11.16.13.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:16:28 -0800 (PST)
Message-ID: <0196511e-2fc9-4155-81c6-af81ec19b809@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:16:27 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/48] hw/avr: convert machines to use AliasedClass
 interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-14-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-14-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfXygFkfuiMmj7k
 iQlBksJ+99djk6HqqcbQ3p5xkJ8C5dwDg20YVEMIEYUjORWe17eGLOdHRiq8n4XNQWeTR1RVIJW
 qtK9g23vqHzU78m3UR8CGDeSRAvXEcLo+0ERiw9OMdm1RZMVnWf4+JdTKpLmwQ2cOIE+m+eX7At
 Y+kASHoEM+KOC/61+RGeW3tLvgytzkKEVIACmI017eQa81B1YwXzs1hp5b/ohW8re8IyVoZ0wSv
 133AfcnP1iKHMNQrb2xWU1vsZSaU6nw5ufVrJ3twaQv+NscTy/KsR8Hutgg7jDHWMDs6wYUFrm9
 BSolaBdaR6Y/JHli1c/iCIK+yw+MZ9p8wFqhBKS+cYPWwKqnrXR3m1PRCv2vo85YX9E67jwivLn
 QhMg0MFM2H6poWFRi2iPveK99QWkoX0uQwKLHSbYf7Nk/eleBGfMneAxnv2MySmdHl1eDWA+Upq
 aTh03z4fHwd0/g3nzRg==
X-Proofpoint-GUID: D1WlbSFSjW4UjKWfkJQpbbIUKw8M2-8b
X-Proofpoint-ORIG-GUID: D1WlbSFSjW4UjKWfkJQpbbIUKw8M2-8b
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afb72ae cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ybAMhFZisXIHgEKlDj4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX0Xj7r1pOqrN0
 fxjni7cJ2UpyL7kurEbrPvKX0qsqgUFx0ciRoN6vGbx9e+gVROEl8iIhSyHLHvRTk/ieX5iO8cS
 ZzRUbqyZtUhVziERVYRdnymxPHkkyKE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
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
>  hw/avr/arduino.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

