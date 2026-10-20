Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8C606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j2qRefCi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UkTGEgA3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFJu-00074i-Gi; Tue, 20 Oct 2026 15:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFJr-000744-Ng
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:16:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFJp-000776-AH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:16:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtvng2712198
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RsY0hnqaXLItNuV+voAE/l1QFBua9xQctEobJyCMr/w=; b=j2qRefCiOeuH7Sm/
 fZ9ZvdY3+Siqm/wXgV6zu6PQ3loQ8hCB3+IyE1KKdgEhdxY9KifbSpUUEHfghFoQ
 5BIJZRzlb8LYjTs6/L1f76k5InDV4yOJPAwQjs9SWxzEuVI58Iy6vLkUd5Y797Ax
 cufwg5ju20TXqMs2VU14wnsJZALUXdCw80M6j2Dh7F5xdPid8wMqWlsSv1jHuryj
 ZH6zEIAezoUAwuxx3QT3+sUwFgdjPUrtMZPRJk3/TOZPR0vNA59R9W9k0I+7Y6Yv
 mMxPz3/JjORrf3oxvW4/gkh0OhjRJER6kU9pUtrsBm1VUzAR70IQ/tw9CVAHGQ9Y
 Zo3hng==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nv1he-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:16:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36696c9f55bso723633eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523775; x=1793128575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RsY0hnqaXLItNuV+voAE/l1QFBua9xQctEobJyCMr/w=;
 b=UkTGEgA34iixToL0i4d6hNc7j+XX+9+KEhDRJIfgWqA/308MrfV0lTMl2LQyishs4T
 XINlcprp9a+xN3pXB7RuD5o4IkQkKpzjtXejOSb9Kw48rX+74owMBLKu+WYvRtI0sQ9e
 UJdrNXQYpmxcv658Cdas9hrMxQboVvzv00ilnSEtjsF7B46M22ctnfpvI5o2P2uW+TaH
 +zmvqHHbIZ1A8vW0OavrG/OMLQtMAFlaDNC/7/b/metqN6WiolDESHlXjdQ2Fv2R7OH2
 pJWMfvkGSDtUfxT7A7RW/aG66guUl4hqQa8/bv7GSbg0qWlzoOG/CGlDP2/+eyed26yW
 BZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523775; x=1793128575;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RsY0hnqaXLItNuV+voAE/l1QFBua9xQctEobJyCMr/w=;
 b=oK+VfXgIaGWhByDqHh7SOBJ1WmaT+1K2swyHKvVQaoItVvOKl+lmhfj1t9Q0vPEFv6
 eDtlVVMYrHxCi0gmJacaUkccg2JNZg+pofQqe5nBIk+RivpVtD9pFN/Xh9Tmn7oROHc/
 /VGxbay4xWYji2ZUMtR7TxJCVgM9Ob4U7EXOE5bn82GwXsRzJxpvMbYdmyEVlrgsA3uh
 UVbDtyW0WSbRkJVLY6I//NvvxmJHR71H1JMmbKay/oSKcLqe8kXkOqJ7V4U5n8QDqOyX
 W0BX/rwTTBdoEOzn+gTIx6sOI65YgciozNpLFhRoit3UR/Jw6rZWJQW5YOxxMg8Bgegw
 vbig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIfXmLE1l9T5//xyYCCaKij2couMGHqaCAkl/weitJqaf/3LBzgwyLl/jSYNAatJ9Wp5bu9oHXt7HO@nongnu.org
X-Gm-Message-State: AFq9FYJ+/ii59tL8ccpCETpb39nswtdqaNfyjxD8UcsicGQw7FmH2O7q
 JIz6CP2fsmEApxukB+em408MnBfHV3K3uouPVSXtHnNcMGQrNVlqvdfC2Lw3QvFbHv7hLnigCBG
 ZFq9aCJtKrMCR275tEk3aQ+Zc6/rj6e4G4g6+Gk8zLWKHUDlEq9UkudNABA==
X-Gm-Gg: AYBFou005gGZgf3xEBVhgMGiEpNPRsx47bhbh7M67iawZ7nI+Fr4SH0jyXGQv4KtAPu
 scIov0md2vVPi5KXHxnsfVGctHdut/8SnGyypxtk7QCJNBQMlLrbGpp2EGJPE0HrqK9v+1Ih3g0
 EE+HD7c2quFw4iGeGMaDfeYWWGLSO1ES902z/GqAgmL/xWZVRaADSLH3KcavMpSQYIIatY7t+qS
 TRq7V6JBYy02gAdYoySPsT43fXcJTM6e0z6uBNFyt/DY7vTDDjRo4tuSX/Bvn6JlcLKBJJ2rhVG
 f+Mn2TKL3cz1lcBrc30CH6rAnReDrbY8CeU7k65FGHW4sTlYRJoTRWAbhX6V/BYwTSEhpL+N2Zs
 GTFG6nXYAXXB0uXOPod9gSwlNzsIWay80UYjKzVifep1UnOm1fY3zKwdQH9p2rgC0f04dqQ==
X-Received: by 2002:a05:693c:87c4:10b0:35e:af84:bf1e with SMTP id
 5a478bee46e88-3674cf37010mr214039eec.7.1792523774670; 
 Tue, 20 Oct 2026 12:16:14 -0700 (PDT)
X-Received: by 2002:a05:693c:87c4:10b0:35e:af84:bf1e with SMTP id
 5a478bee46e88-3674cf37010mr213996eec.7.1792523774133; 
 Tue, 20 Oct 2026 12:16:14 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3673e15353csm911191eec.2.2026.10.20.12.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:16:13 -0700 (PDT)
Message-ID: <b6395e4a-a343-4dbb-9844-94b4c8574afa@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:16:12 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/27] target/sh4: Define exception vector constants
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Yonggang Luo <luoyonggang@gmail.com>,
 Yonggang Luo <yonggang@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-23-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-23-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX/VlFuphcGhzs
 llHQr0/ubUBicSNVDcLV1kzaOUcgp9tNWdRzjMZ/Ijas8e8h9r/sWCMY4mFyr0R9DvwNiXkV0oM
 9iw1yf9fEy9sEqCVSThEUmQD01TflEw=
X-Proofpoint-GUID: Mq_eprj0C4WhEE4P7l9V1ttW8AL1ZDoH
X-Proofpoint-ORIG-GUID: Mq_eprj0C4WhEE4P7l9V1ttW8AL1ZDoH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX0jUW+5Dy0dQO
 MyRhDisxK0zmuuFY8r18W9xVRozEmqj6sHK6lV9esiwVgltgwqsi+wCcdsoM9Y/n20OYv/rNmY9
 eEGhyCBn85aZffX5GofdXQtbC3UX8wUYGaDWi1UbG/XWuOFf536R06YfNZAECA91oj2/NciwGre
 KBfybzsNdcAOQlNabC+K+/j3xHN/lq+o/4nl5tSnua4u1havFiiXuy2aj0suTT9upw1F/dW6uzb
 ecQoSrDZ1tGK+vbFsgF61yPyrmyhUiAhcYQdXUeXYLhdktSMv4HRiUilzshwuB8DWM1YU9BhM5k
 hD6Te1ap7A9JWv1JxZjpAD2KdARzUkzJLA97yPPsQZifnmJvOOSBjzRpZP9l49vck7qsMNFTeLu
 hMQRG7jVxt4ycLxngZYt8uJruO5Iji6l7J4eKNBf+0CodGskPp3P6xqbVitmYuLIhlNOTSF300H
 paA23Je/xWA8qxWzyRg==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad7bdff cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=x6TyVZqR_DyvRbJo4DcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200076
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

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> From: Yonggang Luo <luoyonggang@gmail.com>
> 
> Name SH4 exception vectors and use the definitions throughout
> exception handling and exception raising.
> 
> Signed-off-by: Yonggang Luo <yonggang@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/sh4/cpu.h       | 21 +++++++++++++++
>  target/sh4/helper.c    | 60 +++++++++++++++++++++---------------------
>  target/sh4/op_helper.c | 16 +++++------
>  3 files changed, 59 insertions(+), 38 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

