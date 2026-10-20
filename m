Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41704606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xu3wEIS/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pin+iIfM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFEQ-0004h6-FH; Tue, 20 Oct 2026 15:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFE1-0004bo-Lt
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:10:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFDz-0006ba-JK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:10:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KHexss2328326
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GwJCaueEtJ2/PeqFSArWqvf2oNZ/1JPnboDYKi/iC/I=; b=Xu3wEIS/8PfMtaPw
 T7oCVkP17Z9CsdnmzB9qzOuHIMRl7R3E4/vZaYXaJj5JoQ91WAIwxZZMVCZJWa+6
 B7PaFz4QWsRwR1PljJhfFINbop25fafZqtujP2144hjN/QbXcRiAdfX9inUJeJMG
 V05mFzLt7S/szx/l/b/yeSpsoog9XqZQ0AMAQ9PKlBOI7+IXUJXiuvZPxN2dM8vF
 /I4/1aBn+nV2ysSGXuweNNuFCTvFNQSbjOyulepoXGlPoU9R3PLn/zuSgLek6len
 6MIN8J5C8pCkU9BUvA1I/3dpNAslBG8YK/y/n/tqZ5bo7v2Rg310aAiJbS25w9Ij
 wFypjw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n4499-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:10:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso6679016eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523411; x=1793128211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GwJCaueEtJ2/PeqFSArWqvf2oNZ/1JPnboDYKi/iC/I=;
 b=Pin+iIfM5sSTJ+f3RF35FAZZ2Eb5hblD8mYHbjGegj3fREETTh82GKeb0AMjChdbJf
 0lcwYzbuG6nhUBA/cYQ8NW3KOLYLGEHFf5cDRBgmWpj98q3sLE5NWAFnj/avUuvoNpfp
 NcZGuW2LFDBDLFLscQ8IZsEUe/UeB4j7EESufJ9nDBT3PJv5zFxvKlwhz4fjnYoYu+GU
 pERtK6rmInyDKfaPBepwZQ7C2mywMXKdkxWTMc5FBDurhxq6wb19V4o1N6ZicGo+eowc
 tU0CsOI/DnmQBKeM/dJojNRdaOHwP2YYGTKu0ei3C16RheR+3JivFuNC4q7xVHhQAWaE
 VYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523411; x=1793128211;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GwJCaueEtJ2/PeqFSArWqvf2oNZ/1JPnboDYKi/iC/I=;
 b=pAOfmrnzUSpQe7EmVVhdNqnMFsHzAAGCrSHi11P6Rir8eWevUprqgMv4ZYBy66JG0i
 d5GT5t+D1n+Vbv6+O4Smq21H8APoLEQMlZQIGS3fTNEVg1oxD2Fjf2NHLhistpplkxlO
 T6AXQmksxwAlUKeXI9Wmkt69M8ct/JuZkPTDAsmWTf7YRcxUV9qwgDOM5Pi192s2bwKf
 QaDQq4Ddn+++hjdWH1XtCnopGWSkckmcCnsTbEe4RvIUF8EbEL7tXjBoCUyFlOxa1IJH
 4ANWR47BZC6z/oUOaV3XnZt5Sm8YOcwZCF0O97QQOOjY6vA4+gMGgrePyCCh3fH4vIt8
 g1AQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByZs1/uYGXBBdpYTzVOMXsqc2gZsr2t6jUWpyQ69i5vuAxsMzetd6l9Y/VqYRrMflDwMTsgzP7/jhkd@nongnu.org
X-Gm-Message-State: AFq9FYIp9GklWOkjOzby7mIwk9XOFI4t6092AUZJv7mp1OQl47Wi8XA/
 omJcrSR3VvDwTyNI56l49UnUGZTipGl8ww/u0GP4Tq6SGpDcU2oE/ar/4NLOf4PfSupKlAN5C3n
 Hl1Fbwwp7/G4kiK7Co4E342an2y0pcrAM2qR1/q1SsLrj/e8hdTOIM/g5Fo2s466lJg==
X-Gm-Gg: AYBFou3v7KXIAmvMq5ozfqhKB4DmRk9vtCEuiDFDvohgH5wzsb685J63Eoumn2GBalX
 vlgE8IxP1FOkj2BvqjrghdG10V/sVe2Xgb9I7L1P9BpfpCcN7GUg3/vJgDSUAWVSV5sCBg+2q1Y
 XjLgiQHmKgTTY80G/2ni5bRnlXCResK4IX0yRUOyLlZY70BjZQsz7D9JvSjDffnN+Lc1Z6G1imG
 tqKbIu2GaWGDFKXpIaG6FYHVq1EfAmbra5qLY+qCHkcATKdriDG6+PJOjw7+kcCLt2Q9qH6o4Jy
 jIIDmo0M/KBmOLMdBJTy55vtzU991ZrrHLnsPEoL3IIVMWOn0IK3j8iJSE/Ue/GcY0N3X6xUtJN
 X0PwJOj5hC4ZdIx49swFJJ29ujEU5mhoFNwzGVRd5tXWWtFU5xdNelqV43DfQZmymkPZYWA==
X-Received: by 2002:a05:7301:f89:b0:35c:85fa:5a61 with SMTP id
 5a478bee46e88-3674f1186b6mr185054eec.38.1792523411474; 
 Tue, 20 Oct 2026 12:10:11 -0700 (PDT)
X-Received: by 2002:a05:7301:f89:b0:35c:85fa:5a61 with SMTP id
 5a478bee46e88-3674f1186b6mr184995eec.38.1792523410338; 
 Tue, 20 Oct 2026 12:10:10 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3673e15353csm872165eec.2.2026.10.20.12.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:10:09 -0700 (PDT)
Message-ID: <18e0e003-003e-4084-8da8-ea08b03037ed@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:10:08 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/27] target/ppc: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-17-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-17-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FuYQXsOLt7-vrB_7_oJPV3ot7G0OZL-B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX49bZPdZ9WH1L
 1XXGJf9eWVq6Am+5TzswyTAqsbWsLtbEBLRBIrl5D8YGDTrI7Upsu0DbIixtlI7OljoB6p+3Hmq
 KCPbkw+pr91CiB/J1OyiFrZvZuddEyU=
X-Proofpoint-ORIG-GUID: FuYQXsOLt7-vrB_7_oJPV3ot7G0OZL-B
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad7bc94 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=moQw2Sb4fIttuYUfML4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXzJHhaGIwK5SC
 x5DlaAKBZeXOPwz6f8mHZebrw3bCLbcHFwFGmdyQ+NM95oJD+1Ug/MLaHDRSYBVZ1z0m6KpSCpZ
 F2W44rY/RZSMr4/zxwU187MKYhLp+NwFGBjuP8zh+Crxv7u0LStJsW/9eniWaj9ZL9r5TdBBJl7
 afgrYh8hS5pV46WU0x3ssIfnqEjVe3jLVMKgAmAbSjRBoQSLJSfPqa8gN9GaiBYOQ6+BvDSKjEw
 NugBM4Tc4DepLt/g3p3wJyLFVa8p3Vs599rYh1Gc+0oZtD+BSewOoJmRP5RwWRKiUvYlYlClGO7
 DkDCTq49/MqISSaUUZas+ZTInp9HVlS6iG6lP4JBq1aGE41tSMuUfq8NXodU4Bs9doLl+e2c3YU
 FXV/SF9xLcU8AhKsZqGz4XLieb8n9a96iRewOifne8/lUrn2sCGbe/UKoAwYLt5r+jOwZkUXAC4
 CXJucdhWaL2FYSPRLPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> Expose powerpc_excp_name() prototype and register it
> as the CPUClass::exception_name() handler, so the common
> exception logging can resolve PPC exception codes to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/ppc/cpu.h         | 2 ++
>  target/ppc/cpu_init.c    | 1 +
>  target/ppc/excp_helper.c | 5 +++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

