Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C3606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cq1LXc6G;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UapfEvZH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0rx-0008RZ-J6; Thu, 22 Oct 2026 18:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0rc-00082G-6U
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:02:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0ra-0001II-FE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:02:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHHOI4086715
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 22:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 muSjYFdHVKSLn/QvenwfsYT/stPlU/Ztyz5iR6geoA0=; b=Cq1LXc6GLVQt1xep
 tm4+FGtfpXoqbXwI+R1lhtijOPimX/KAfgxe278iTNxTz79ZGUihB1GtyCBwYa2U
 ZFQUdbKe+pOzcwQP8zzz8e30jz/K/Koc2J82N2+pBzEDg4SENrsWqYg8BUNx25l3
 X3sZLdGMEcBY6Q9Vu7Ae5d03tz7Jdu9EiqtAaf5zYzBmyDPjdtgSeRPY53fk7bBM
 NLvd1IdcPxmbyWcS7UzgGpjMD2223a8tgmVlg0qpN0tw2Gk3gPLi5T8n0xQxU/me
 wirZGvjBzKiJMrPZiiL1ZHn+jLMP4/Zbrt9SsMGifffs6fplf1K8JnCFD3l6Xjp4
 NQIXzg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtrqn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 22:02:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso411273eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706536; x=1793311336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=muSjYFdHVKSLn/QvenwfsYT/stPlU/Ztyz5iR6geoA0=;
 b=UapfEvZH8z3xzViD4bDajI4qZ9aAtxgO1lEivoy2pDz70ukx9EuJJVfFCVxBQKgl6w
 hm814/rrIj4c9agE+dMb0tn/mE5H3C0S5xDtrpxTv6pmjv3MdE+HPJwyZc+XqXpWo3gg
 KN6rOmTo5WkGjMYb+W/X2rghoGabFVzvdISLgnM7pir9PPh/lXbwkdq0Ym5aOoUSNeBu
 qxOcAiq6gTVfasZAHlWIyG4F3x2lC+zL4+FDS0N/+0Wy3V//ZZ5gxHaIjNso51YEzca/
 Az/jW7qyAx6qd+7b/nZCgmiu/dhQMw15DuHkIRHuNJYLJCvvcvAHUuKIzbs9gQbxmNfJ
 1i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706536; x=1793311336;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=muSjYFdHVKSLn/QvenwfsYT/stPlU/Ztyz5iR6geoA0=;
 b=g1B9VoG4YM5sZ5d9kbMXRMaOBovQcRZQ/ZHZWSwFPSHWHtqM1kpCHz0SOSQcXudtU3
 GeE1Oki35sxvEi2P739qXnQjsTN6+ym5g31g+ppUnPEvMWlanbxLjILA94+9Ag8+PFoN
 4oXxhGrKemLEy1CHN8TpIGbl0tzNNl3WzbDgDBCqFKHl/DFye0x1rlQ00SJ78nsPuBMu
 Nh6M+jk3CFaKrr4R0Rrf5sYxqVDxixHHxyyBz7s05b2kK2y81mzV/Vijh4XcoYdJW6cr
 j5SgyQOhknXpKI3n/OOwqEBchwLmBzuVhi9aBoZLMmMtytr7e2tHKb2qtesx+Hwd7or/
 MqAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByk9ywdPjqob/e/NizroRcRjLLvMoQgpxVnGNeifWCg3gwx6ur+aspqokJEc7rrqiplKISfQkvbdKMD@nongnu.org
X-Gm-Message-State: AFq9FYKHbiyKuXPwt2kK4COpsQmq1bpGLt/9do0h6UEwKo+mY0KsD7+U
 RFZRJBMsAOO/nr0uYCrnRcft72ROlcGRw+gmNRU1UmbA+6vLMHqQRGu2kk+HnF0OMrzK8pKBR0E
 Z3Yll0tbXepGPvIuLIlSPlAie5x1K+gA1/VsEZurdBDFaD8RESjpRTM2nCtebXg1rGA==
X-Gm-Gg: AYBFou3vqQnDTBGOvDbmNR94IGCkKy4oc1AxOFEVHNFX7wOrwhqmuREzRkozz/K0R71
 2ZNeBmOmN39negSWYbc7ODK+8fIzldFr8Vy/4Tojy+iy6Lv127RDncBoDfoMeELWQJvU7zQUn2N
 SiKxT6DKBZ43l2jpTtpi8IbeREgUOe5UbzmVGbqw0WDDOHohVFra7xbpptSFHsT7HnWpfkrHpQG
 ti6xKlAcIAylVUCKIyISTLbkqD5e1ilL2cYo10cCMDqkJ36BVX0S+XonOJn6Hr3Fk5pL3Qb/kuV
 KJgO05wqPtsP69iGTHGhGrKw13ePfGzVt+a+6J9z6e3vl8/mMVADYXKuOHUuxH+Fn3ydKVDqnQj
 m97ukjcH4/pEUvg4aQEEdgSGN/rHZ01qW0GFnGmIDVWgoaIaz3RxORmNERtRenmWMeV4IpA==
X-Received: by 2002:a05:7300:2aa8:b0:35d:e9b1:1c6f with SMTP id
 5a478bee46e88-369d8f4ff6emr579077eec.0.1792706535683; 
 Thu, 22 Oct 2026 15:02:15 -0700 (PDT)
X-Received: by 2002:a05:7300:2aa8:b0:35d:e9b1:1c6f with SMTP id
 5a478bee46e88-369d8f4ff6emr579030eec.0.1792706534939; 
 Thu, 22 Oct 2026 15:02:14 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c15883sm908153eec.3.2026.10.22.15.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 15:02:13 -0700 (PDT)
Message-ID: <5c8be9f1-7862-410f-8e37-223730e05929@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:02:12 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/33] qemu/osdep: Document ARRAY_SIZE() macro rejects
 pointers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-2-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022215115.19680-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6ada87e8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=NdPrxZTIlIzi1H5XRikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: YOaQdbWnvoKx8Hy_V13aoyFzWEFKlwpI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX/BIFJGh4qwCd
 SjMXzOKHOSLOJQoJvY0/Yuas4RjsqR7oWESAMyz28dFVFz06zGBqP58zUr8WukemVkwHPIKsAHV
 askOuuF6ohs8aFDuwQjtR2rZv8peHn2+8wYtyTut+BCrlUuOaY/DiYSoohWr4XUG/PQiApXpfPT
 u5HvidTSUI/ohxq9NuY/6uiqjoEle0UvLDTqYnupnmEjJ0FH4AIbw9miirvcY83gNR64y3/ung7
 xzKtkzTqFVt+eLK19U5rqcF6uJHzJAVldeM960ZzhG8E+k5lxRSWO78Odr5hCJRoCMKfQDimVoW
 +qhBzXiH1cC32rGIxs5T5hI+mzQwQIX93UCG3Z/SeQ4yv0aOlEplwv4fOxtsR7RHqw4YhnAl6Vl
 O9kBrywTN0miltUtmrUpJyWAfPSj3wjV2jxzjHPnmHo143AiSuIUYGem3pNLdxqZBiUG7rsTK3O
 qwbMAt0bckr5iFYZMkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX8Z4l8j+1jD9k
 fd3mVsNKMxINWVvQpzuMuqxIZ4vRHD0SW/6sTmN4cke+MGyVKSZx1K7CR+M3Th17UplwfPjRiOA
 63IYNUojnFLpxLIPZ3Rbd7bn+LYVwaI=
X-Proofpoint-ORIG-GUID: YOaQdbWnvoKx8Hy_V13aoyFzWEFKlwpI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
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

On 10/22/2026 2:50 PM, Philippe Mathieu-Daudé wrote:
> Since commit ed63ec0d22c ("ARRAY_SIZE: check that argument is an
> array"), passing a pointer to ARRAY_SIZE() is a build error.
> Document that.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  include/qemu/osdep.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

