Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA8606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HBFC7Px6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g0qOnIes
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0s9-0000Ag-ND; Thu, 22 Oct 2026 18:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0rn-0008R4-5R
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:02:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0rl-0001K5-7Q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:02:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKunpt792139
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 22:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bLaS+22z3mPHgpd8C4clhGZUYWYKO+97rwZKWT05rQw=; b=HBFC7Px6g4efyvfr
 mAUHxYi5iE8YHTmaPwkQLUpHcxwfxLKUHhcu40Xm1wO6pJgxuVlJ+a1w0XOYe3ef
 PHVUEkckFqXEzI/AwAe/RyzNxvjF4WXBJeg2itouJdIIZsG3U1TQutBK1ddDsuR5
 inVIi3P9EaO7CuP3R9pR3euVm0pG8mOqjSmV/dSO9/h2TdEisUZQG4twOJfE146d
 bNpPS1q3ZLFQa9Gx+iR8Q7D8zgBm5h0CYVTTf6jpDfu94eYTe2MDLNJ2IdUKMvyO
 fqXfFz8J8zWQJTi5ScHjZ4lgoZ3Y3JZfG2H/o0GFgVgquQKKLa52SplEcoHvje41
 sF1tCA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk86dc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 22:02:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3692c5b061bso745359eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706547; x=1793311347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bLaS+22z3mPHgpd8C4clhGZUYWYKO+97rwZKWT05rQw=;
 b=g0qOnIesGnLcqhMhj0L7LUjcgaP5rdP4nHBtMCO/HIF6CaMD3ShMlQAfOF+x5q23+O
 F8LkL7ZOO9B9klLzamLmJgg6eoLE2Gd1CloFNl3dE+2sL7Um7rVtZ3qCajGDVL3cqA2Y
 pvCRRSoYKrunCJPOO7dViPEJSCMimogIXEl3JUvIClIP6GuFtBUwOvsczthl8QJNNrjB
 WsO1zwttmMzDKl0TnagggOEes4eaI60d9mubY193XMMi4WAGw/FixDP9h0Ml1MY9/8D9
 6AlCENVcGps+nuGYZUdyT01E8iCo8D9vuU0dd/IV16axsNGhAzp4TIFdf30EipDGNhsN
 d5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706547; x=1793311347;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bLaS+22z3mPHgpd8C4clhGZUYWYKO+97rwZKWT05rQw=;
 b=jv7ObgUS4S+Pf9G7GNgmM+Vv/yl8pV2Dz1SwRXFWCPp/w7XIaQCLSFoz4SKYCpsGSK
 eXvQPmgwgsVUbv/X7Vp52eIJkwJ1S9jlRoEVf4fwYbcxjpN4wCbY/nOyRcpkcAnyBCrq
 ojQ5jX80VH5M7vHHLBy9+JFjblvT4d+pS+h0SvwzH3gtXAZP+8mHNLH8u8ZxSxMJXrzs
 FyrtnPJeM0bAky5LtpEe2eyeC3sjQprNBso7LHXPAHX4AIQWd2SI3uj3MJR6syM2xX4G
 u5ycoNN9HbvC2+un3h+FkQI8SNacADKiEborTrCbZTxT3p9RkyKxyGUhI1KptE5x7jHu
 GYkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxd8+3sAF5Aj6AXQ0U5652JFYQalZkKIkLdKikC8LnnjVebq8/sqZdw8dWuebTf/oVXBq6GkrR1z4zL@nongnu.org
X-Gm-Message-State: AFq9FYIVjvm2mPDNpIuTF1qCOuJwo6GemjMrbRSHwTzpwiI4zPB6ea+n
 HH3hX6rLYq3dwI8xusXWhZUNF6u8KBc+NM5fP9jSIbx+DrZV3HikZkPJWoY2HfseT+c1QMduFhg
 6vddgo8Y41TQlqDE7DJb84oUgIW45JJE3n3oMT2JaGfjnNpY7bQNQQWu2R726zffpnA==
X-Gm-Gg: AYBFou0wYzHtR0C4ggQoSOf/3AfOkM9yA09rnqZuNAySms0LXc2bMMzAp3DqFs5aTi7
 0gPqfbMSwj3Y2Z5HISnubl/jReV06eGXqKPb8VK5grYrG/YHCxKU2h9/2lNELv3IHxLv+d566yR
 h8NRMqdUfJA1tcfoKAC5l/VZ1eWt1jFeL+x/VAoOJfn44oXM1sULQRl+L9InwsZDc0Fn4Asd5ZB
 CSHhyi5opJm8T9uwTSVhmU5PDOWI7YRo+AKqPaqypb7dLFf4P4RqvwQsRarjEnLdEg3s7Z2coqM
 n51e/+TB2LQBH6aHDyFNW9aGjZp6PnUwi/fxnlckmEu7646qUXC46Uv2+jX9BzIrpyQ5ixH2nCg
 +hOA/4/asPGClIFt1hMv5Wihxj8Ojm7sG0uT1ZB5XgeyBquArUoJdjMs7yUtAx0IKmhTnvQ==
X-Received: by 2002:a05:7301:77ca:b0:35c:8abb:b4ae with SMTP id
 5a478bee46e88-369d97ecd90mr506247eec.25.1792706546943; 
 Thu, 22 Oct 2026 15:02:26 -0700 (PDT)
X-Received: by 2002:a05:7301:77ca:b0:35c:8abb:b4ae with SMTP id
 5a478bee46e88-369d97ecd90mr506182eec.25.1792706545945; 
 Thu, 22 Oct 2026 15:02:25 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9dfd68csm1257895eec.25.2026.10.22.15.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 15:02:24 -0700 (PDT)
Message-ID: <2a0c3801-f74d-4812-b627-5ccfd87f4fa0@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:02:23 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/33] util/cutils: Add STR_ARRAY_ELEM_OR_NULL() for
 string table lookups
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-3-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022215115.19680-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX0m7LXc3pt6GV
 D+R69Ihl5c8mVdBCCaHRQawuEDmQcNK7fB4pEJ6TY35J1Jb90axVvc45Td2SLsyHWo0b50MsF3X
 oxjYw2wcFtMXuEmarqa6Wnyi9xfQeG3cKBZjOrVNIcnL0lEh5TnINbi7sdiNaMmK6rac5J9IYIT
 Zx29dFdJwv45N3RYhPvvB5P5cgTl2vUcq+VV1vktF5xLBglAN8m8YIlTz7MIPcVmTEQ0Q6fWU6c
 JoHrhdv9Vw8J/xQSKLZx4r1arSd4HySDQAMUGyL94b4L6VQEhifu7l0uxeCF2VHxMHru3En8o+Y
 VhYPFjEy2iajvQ4opxQctAq6YVxKC7PbiiscPLTRTMsDvkqPNyk5KG6S7mDm3+8xNj060DTdo1j
 BCM0P8H/Yv0VAnnWOSFotdBg/bYizuZCjYc2e1WX8DqxsWDoFDo3HZ9/SYaeJpMxUWPqyC0yT6T
 Hzil7gKjWmcPy6rtrVw==
X-Proofpoint-ORIG-GUID: LWEBA5rB-OJZcT0Y57Ah0qk_bvNbguK0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX2Z0m6s/Fog1V
 e1t2mFqF0aLWXTC8V3OzqK4IwrIrbQFtt3ikFOr3saPT8U5U2erYPiNhOPApUY0f58iD4idqIx5
 h/kQil8YPsAH4FjZuqNCtYEtW4f+4zo=
X-Proofpoint-GUID: LWEBA5rB-OJZcT0Y57Ah0qk_bvNbguK0
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6ada87f3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=NHwZ5rgcAjlzrDOJkcYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
> Many functions map an enum or exception number to a name, either
> with a switch statement or by indexing a string table after an
> open-coded bounds check. Add STR_ARRAY_ELEM_OR_NULL(array, index),
> which returns array[index], or NULL when index is out of bounds,
> so such code can use a static table and a single call.
> 
> The array is passed as 'const char *const *', so only arrays of
> strings are accepted; hence the STR_ prefix rather than a generic
> name.
> 
> Misuse is caught at build time:
> - pointer instead of array: "negative width in bit-field" error,
>   plus -Wsizeof-pointer-div (GCC);
> - array of non-strings (int[], char[][N], int *[]):
>   -Wincompatible-pointer-types;
> - array of non-const 'char *': -Wincompatible-pointer-types (GCC),
>   -Wincompatible-pointer-types-discards-qualifiers (clang);
> - pointer as index: -Wint-conversion.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  include/qemu/cutils.h | 17 +++++++++++++++++
>  include/qemu/osdep.h  |  3 +++
>  util/cutils.c         |  6 ++++++
>  3 files changed, 26 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

