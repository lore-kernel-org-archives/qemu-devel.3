Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DFA60A261A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R6ncszs5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WT0MZKeS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0ha-0005VR-Sp; Thu, 22 Oct 2026 17:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0hL-0005U7-Ec
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0hI-0007RN-Pv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:43 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtVHe387720
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uId3daMCrFOAvnbHidfTnmDlul9HOu80TSKOeSxnRck=; b=R6ncszs5fXGrfTVZ
 IqJV2aFKvpfz+dBMqkWqNpq1zyDIX4c/gc6gvGkPWUiyFyGkElDDIAIZLCVwmv8j
 xKry7IV3Wrb4mWb8lP7Rv+3WL0fsklYT/UrWCbPbc06Rj0ojGrzi8qidEagzeXxn
 pfb/qb858PWSzHDDQAKPFPT7UFlju/WnP0y7tqOBcmVFn1DTPckbjE+CAPFvcnGZ
 NwKkDI5p41H4BG/tVfZ/k522DWKjvAA93otdRgN3d8q1bQ4db9sK+8SCoM1+RXi1
 FlGSqsC4V/qjrGgGraH3MxLPyde+qgYU/U2TPB/z0cJWf3fgvyzZr1ZR+2j+zkIH
 FOP7Xg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4qs1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so1145425eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705898; x=1793310698; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uId3daMCrFOAvnbHidfTnmDlul9HOu80TSKOeSxnRck=;
 b=WT0MZKeSDd+NFFa6lKCt6ZpHQCwZabvPNNZt62NFhBEuOw1amenPeBbrYoEWdpsMUj
 0SoEO1A66N3poEzjWhVeuyrw7GpB7ds49YJUSgNlzgAbeP6onIXDztL9KSCN6DKNVyEq
 3sY5CaKznu/vwuwbEfZuU2s9U0QY0Ked6v7Oo/78Urfqu8tTdDfeEiA5lqpIaZ14uz8z
 8Ug+cb6SeyD0hCPUlq4fGSFoe/W+CyXROtTsnUZnbv0FP9JXxlvRWMGso4sqcAfkFQxk
 FDOuwpRJe1rJVvqWdS5jt2jVC4GzRcUpsThOntKbzqQT4pVkNYG5zK12Q7qhOnGBJRjX
 axDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705898; x=1793310698;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uId3daMCrFOAvnbHidfTnmDlul9HOu80TSKOeSxnRck=;
 b=2dPKTqvnj+kg+RLudjkaGAQvOmnXDGlh8GVJXPuF84Fssv4cLiwDazKMRdAu7RTsQm
 NO/B7QTMahZIHF1gxujuHBw3BbMIsfXdhFRZW9XbqJIOE7p4RlHeFjynJrHQ35ZT/4IK
 1VkTrI1y8WsIK2ak4KEviB/vbXyUN/duiQfxKGMQLhtsiwxMqhnoV2VbqbCn0+F41xRE
 VGoz0CXAQoM0ednVNKdsu/6MsxIhHD8PDriOHTU020LhTrW58Rg8ps92jnJ81/3PZUrT
 gKzicOzGH1LOkzQ6eVsmRm6OhDHxGVfBPmGXU0Sk5mPrfi6FnZuMBnT/nd2i3KKGoBny
 QV0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkmbvoVKG8qkTf8opDRN9pohCgB+TUuU5z3SyI2yFZtT/Hj3SeIn7AoSagozczWr0b+X1DvzeE1vwc@nongnu.org
X-Gm-Message-State: AFq9FYLqe7GwxNkE/ON6hDFzghBZHIujLmZ13IO8DFhHfdJGnsE1boIR
 rMM3BcoXxyFZfhs5Hd1WTZiYC6brnqyIgIuGsA0Uj/igBgLerhHktaYOy6caNzFUm0zovR9gaA8
 IZQtXRWfDPvaYAB5w2FgaLngYDZScb0Gii7/4eSeMq8H6U0GhvYQP8OpoSw==
X-Gm-Gg: AYBFou0NTlLSCmqhZrQuKMq5LBgpt5+oiYOZ/wiCZ3QTkEHt/zGgoamlHfA1+ZvVA+t
 baN7Ed86crSsf/Mrd3/5BlKESKYde8Ig/ENk27QIE/t+hSvc7L9jtUl8yNzbVYzmEESdp5yxvZS
 Gf5jCFu62C12fNKQK+yXpQFtrAhf8f5T0fEWjnHNbpk5AI4ZKOUpisyqN+c7vv+VkMHTOioSR1v
 Dxfkp4f2NkDnD2smFEpk2i9jGU8pQksTxRorP8ItrZ8aptNlDR8/MjGZYC9/STNulI88bOP9Ttj
 XTIcJdwS9jrzJYY40dXl0PRZtHW3Am8lUruZCN5eaLERrN+rXorYBxik8KR2W7QifFsTJ4x9c7w
 I86B6b+C3SUWtsQaTnaFYEgueEUeCX5GXUJzjg06p0CNW+GMOkz0gdYaP1HZAXYQuyE9+3Q==
X-Received: by 2002:a05:7301:4549:b0:368:78c9:159b with SMTP id
 5a478bee46e88-369d980b970mr500637eec.27.1792705897808; 
 Thu, 22 Oct 2026 14:51:37 -0700 (PDT)
X-Received: by 2002:a05:7301:4549:b0:368:78c9:159b with SMTP id
 5a478bee46e88-369d980b970mr500596eec.27.1792705897286; 
 Thu, 22 Oct 2026 14:51:37 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9db7970sm724640eec.19.2026.10.22.14.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 14:51:36 -0700 (PDT)
Message-ID: <b043527a-bdfe-4e10-ba85-494f77508740@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:51:34 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/18] MAINTAINERS: cover m68k GDB XML files
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
 <20261022-query-reg-v3-12-7ad902b9a7cf@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022-query-reg-v3-12-7ad902b9a7cf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PhElAPqZf0_N3v93redmgSTcd0WIbVVb
X-Proofpoint-ORIG-GUID: PhElAPqZf0_N3v93redmgSTcd0WIbVVb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX06sn2ASazKKE
 yU5CWn5Z7HrP0llbW15iE3N2M5Q09EkrWRx/X/YXSjSCRkwbRH1zeb/V0wbBL8IWRSG+x8S3MBq
 F9Zn70isSaEy7xWDL+4mobgyAPhSMjU=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada856a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=WhzuZZbzbfkQEceezbMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXxbG1gOpKPBCZ
 EL41Rb3bFsQRunnypEFsF80iuxqHMKWqGayQYXR7kQh5UHKxp4+0OM38Ogrn1ajk0gVtmDgtx7o
 w6khF7WSlC90Apwtuq4EysK1wP4Jh8hN1XW2XBr4YIFxJxytnSTZly/0588iwrcn43NwBMd71Ns
 zpEyz3Vx7oNp3CeivL+BrCX1dhk8ybGOmzHZBGvgRX9WuYbMEZD9OFKVvSMq9g4j9mLxgfqR4PJ
 X2q1eiWsCa3TcafiRKeO7+qw7nY+IEAQf079F3udTJgCMhzAbGU2lb5tBcEaREIYuDvaNTkrGD3
 2JZgsUEpG+YW/4JikrdW2QAls5IyXtpkeInshqPUWpm7bNw2TD1B0yp+WdyxEcGezfWTsOc6d0l
 temcFtgShQg1PkqMeufns+pwo7CTJX4A7HvDIyeSfHuHKS4SCPo8i8fpJiQ5SazIuqgSokXszyO
 utlJ8eVjqCU5HlwYCfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 3:56 AM, Marc-André Lureau wrote:
> Add entries so changes to these files are routed to the m68k
> maintainers.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

