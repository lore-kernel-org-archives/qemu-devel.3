Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AA606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kuP5LIc6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KaOAZqv0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWuu0-0000Um-VG; Fri, 27 Nov 2026 07:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWutr-0000T2-BG
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:18:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWutn-0001mO-U5
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:17:58 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARApZr62058138
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 12:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5jo6hHiesgGV6U4AmazkA1v4zMOTThFbYW5M7zy3VkY=; b=kuP5LIc6GiAN8Jds
 J0wg/RHvcWlYHRvHUQCHtMwZWDrrehlW3UJMDEisbIcElYdjSgOIJqIXJ7xK0Nuo
 iyGYU+Dpof0crHc0F0Dh1vC2EDX36D9HH2hKQcDMiAa0joKU6DT82yNy4ZWTjAfm
 yObO3EG6mnjkR7w5spPJhaNMoZblJODGlDh9Iy5cR4pkdTU8AyLVTFIvyiwAdpGy
 hNH2hjde0wVrDjVH+BOuLLDBojKNWslf/zXGCVxrMzbuX7hTUGXjz8kI+kT3neXz
 xmKX9o0iUXdu+yMmpDfjW4mAPzR5kf6lsYOYZVp/vl9qHiNsQ0FxxamOXLeeMP+c
 BUKyTQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gascp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 12:17:53 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-86c3a053d9bso103202937b3.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 04:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795781873; x=1796386673; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5jo6hHiesgGV6U4AmazkA1v4zMOTThFbYW5M7zy3VkY=;
 b=KaOAZqv0EnqFDUN8mPV3CuolmF1xWH9oqnaJ9B8IVH8NQjbp1LZNU5jSkjN83QwerH
 QzCHpdrmpGbP5kx9H4xf92tRN27G5Ak6i+DL/7CoDlsb1NZRum72Pu6MS4RQ0v7ujmxj
 AH4H8mTEWaZXZNPje8rY4MBaeS+Aqt7Ybc89DxIglMzwgik3BgO8q6HOEhibZhakff5C
 wlOW8MhD6SjOck3ODVeN83YXOva79IxUjYaZm7AbHKmimXi3zL2fOJWRWJFMIft7APnL
 nGIsuzIoU2dzIAZw2L2ZJObpoVdJW9/QjdeuHtv19rQO53/edD7GAUpvddEUw+w1jbVR
 XCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795781873; x=1796386673;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5jo6hHiesgGV6U4AmazkA1v4zMOTThFbYW5M7zy3VkY=;
 b=MAdYwgBOS8vk8MR4G5PYGTNF6JoHX5VGdiKs5C4iFn95G2wkbAroLltCySkf6HvamG
 nQaG9M4euj9pZVNJ9wPsiKI/izot/IvFswPchlrp+AveaW6eYKR4YLZQT/J0sJfrMoL9
 khdxXBBDP3XPimxP23Qf90kwWKuo4xkXkNmFJPuyPdE0QBEKGyevga8e8FQw3JuAlJRP
 0pHN4409Pa+BxpOkvcuz1DCTlVptwTI7rc2zGETkqqCdnTVsckpvqTF8iufZ6Y4/C206
 phNdEMHNoGeTOUzi8PyC9Od3WrCrcXndnOwHTf+BJ8j1qaHeJuSsXpMWuC76vp1qCStV
 ryIw==
X-Forwarded-Encrypted: i=1;
 AL+hErH/htOGere9KZwWRAgy2iwyVg0lScSGMAuLCSDFcvw1RQi1MQfhdpXRwAKKnmFFjVAvoEtKpZhKyjiM@nongnu.org
X-Gm-Message-State: APuU4Z+qyEiRtb6WFKRoXZduKV0x46FKIAAI/rcyTgLeTXbHwqddYGs0
 pWFUeHZ0pLaUYZ25Irfnsxfhlfz1U51yeCJOTBHYli5IdiCKhgVwEgrZjQiFAs+VOnX1A+Rs1f2
 Sf/qLzfZcOt5eGKklKyZZMGEt/GWt2epQTSY2DMTvilA70rfj1klt4qEXiA==
X-Gm-Gg: AZFdTZe1y4aBtK808Ufn9yaYMtwp7hfpxFt4Tz/SBx+AX7AtQmbzhdxk9gbnafgiBly
 uRNWm8gao3PbwUSGs91r3Oebz6Y1RzOjnEov7qYppw+DNF6cQ1Nij3m4x+TkxxITNpt5BZXMecp
 57A/RklzLweMcMpDSRojEozNiY2ND1de0thCnpSWi8N6VDReixImDpoRfk7qmDdCLURXEf1b2fS
 2tUVVVX+1Rm5yZQg2u/xbabcihhOz6NRCKuewHirQcz9InfioOgBrKL9dJZhIFIGmmgqySGLXwW
 GK7WuVps3Ff4tLYV3GB3nGTlJOK8WxuQkI0wmHkxTdjykIUeX9+WpcmtGy9r0cKCtsxGnPj9tnu
 Ts0xk5jr/Reou4EbzsCTvrlR/QturKuZJ6gHXyv38PkzyHW9PVjUyIdjupVdmuF2J7z5SeQ9QXs
 tLuPWHc8E=
X-Received: by 2002:a05:690c:9a8f:b0:8b3:17fc:1066 with SMTP id
 00721157ae682-8b5204e150amr106553457b3.44.1795781873286; 
 Fri, 27 Nov 2026 04:17:53 -0800 (PST)
X-Received: by 2002:a05:690c:9a8f:b0:8b3:17fc:1066 with SMTP id
 00721157ae682-8b5204e150amr106553307b3.44.1795781872739; 
 Fri, 27 Nov 2026 04:17:52 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm53767390f8f.24.2026.11.27.04.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 04:17:51 -0800 (PST)
Message-ID: <95b82703-0cad-45ca-87bd-5c4ec034189d@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 13:17:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2] hw/uefi: accept a PK enrolled in setup mode
Content-Language: en-US
To: Martin Pitt <martin@amutable.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <awkUHTIhRM_DHrTR@piware.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <awkUHTIhRM_DHrTR@piware.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5_y_tOCATo8gYhDRbcyeSqiQLE6OOkTt
X-Proofpoint-GUID: 5_y_tOCATo8gYhDRbcyeSqiQLE6OOkTt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfX6TZLV/vPtfZV
 Lmj1w5PZAWyje+Y/qrgKP2i+abpodrBWxkfHODb0/ol0eh4Y/bK6vf0iwZ5zCDc29NemVtLCeDE
 tadS0gFf4KzVtTls1R9+TadE88GukrpmFoZ9eZV/vAlb8zF6IzSeIBxkG2x4/iGUVPvGI1ksCAo
 INh0zoY1v2yeDXqxWGsuz6AenE2XCjGptFFm0VVv+8Yacc/KBhDw5TqBjNJtarMaa40ElGPjJQo
 xudC3pQeaFeppuVNEdl3HNjBrqSyqYq8ptL8XpEGdrO+9PFHDR8772Z1dGpu1ARiaBBxSucet94
 u+mkWQPz5LczAOBFY+1AtX2IhVRuOUN/xElqWSWzUkyF8mFffmFEjS0GQV75dM8A22zhfU1sAmd
 u3icZqBjT2bW4tAj5Oum37N86KSGun3sZdsYmlGVvzQq8myRdOMF/f7qa6wK/KyRsM37ZOTlPQ+
 s7ZwGrMXrsEk/2Uclfw==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b0974f1 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Oupp8ApFAAAA:8 a=EUspDBNiAAAA:8 a=JeaGrLk0m4AF4ho8xWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=O_ZY0FNv286rkAlsR8tl:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfX4deB8dZvYJsq
 QnpjOuS0+9PfXP1VpgAFbCMCKqn4B084CEd1lwsqOCCe19/e9Fq5Wt/gLWZgpS3c88zu7lOl5VL
 +oq2saYknD7uDDPxi7x/myPXe+cTLc0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270048
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

On 27/11/26 06:24, Martin Pitt wrote:
> From: Martin Pitt <martin@amutable.com>
> 
> uefi_vars_check_auth_2_sb() returns an efi_status. Commit cc3cf42e618a
> changed it to return "true" for the "no self-signed PK is required" code
> path. That value 1 is interpreted as EFI_WARN_UNKNOWN_GLYPH, so
> uefi_vars_mm_set_variable() rejects the write, and the guest can never
> enroll its own PK. Return the correct code to fix this.
> 
> Since commit a1b96fcde870 ("hw/uefi: improve default config security")
> a self-signed PK is not required by default. This bug can be worked
> around by forcing the still working old code path:
> 
>    -global uefi-vars-sysbus.require-self-signed-pk=on
> 
> Fixes: cc3cf42e618a ("hw/uefi: add require-self-signed-pk config option")
> Signed-off-by: Martin Pitt <martin@amutable.com>
> ---
>   hw/uefi/var-service-auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

