Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97BA606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sx3/lwQu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ro8lHa6D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFLh-0000Sw-O2; Tue, 20 Oct 2026 15:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFLW-0000M6-Ug
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:18:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFLT-0007BU-C3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:18:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI6EoF2079975
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pSjTrzCpbOLxRViZLLGWr8FfKeT+STLvE2Pdc7CGXfg=; b=Sx3/lwQujrsNQiuE
 3Kui8kLt+I9ZgihojP8Q/yIRFnMTFQ1BUdqTloPEDrfUmN59axIynUd4QbyKCRFk
 kHu5fzw7DZhN2wowWBi3iZPWvnexYP4LcnZKGWKqdEaaC+IzrMmQObYfFTAb/nad
 5xT4dLVs/ZBnWzdAXaQ2G0OwXgYIwalgMrrpcslJVWZu4Wp/GiZjagGui5EmAIph
 dB0Rf9u8n5RVa3ItaYwgZ3+hvnO5B3GqdXXWRiTSk80Lm6E49e9FF4WEB0a5XMHb
 NxfaD/aoxvQoxzYSR4nDrNFwgbAauHZpmH2KGN9PecfsL5/Fr+bpY8xF6SB6vsdV
 xeIWEA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9hr8hv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:17:58 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso6542631c88.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523877; x=1793128677; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pSjTrzCpbOLxRViZLLGWr8FfKeT+STLvE2Pdc7CGXfg=;
 b=Ro8lHa6DXzFWkhPwGE3s3r3AbAI4KJv0D6/WH7pDC4mTAsepkUoW7G4Mw6gP1/0d9s
 Wop0UCjD1G0qlsEk8VM8/aE1cWBzhrfwHL4ZC7P/DjJvFa1z5LTdBkELZyaP0vDLURkN
 wmxWLliqLagrHiU8r6m8kuTdGeyx7wZeCePLuDV6yNcI0LI3GUVR8K29yHnBdk1ctK6T
 k1kRjsjGDSTeLFfpggkxy/WhKsnd0nnFBBVWmkFmPAomhiZ72jOLG6Vt3+04yrILrYCt
 HTxliHb4wPuLxi/7/0n28zkDqQ1/ncK6FncEmwhXH7Vt4XlVaeKnOzsmXIHX97tcxiu4
 OR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523877; x=1793128677;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pSjTrzCpbOLxRViZLLGWr8FfKeT+STLvE2Pdc7CGXfg=;
 b=T1ZUlpl9ayvHHTC1qJ/vj0zAXZQ01v9vHGvG1GxQLyAv1m13qRw3pDM6Tij6GW21qm
 7RXQ5tIVo1C4FjMyjds87AarmgqdDWguNqZcs/UdAjLvvoPO01iITpBl4qMZ4Svi76Hu
 raROrDQhNbF1KpkTILZ5yUEc2EcwlnxlXdh+Mtw9I6JvcQdXjN6pva+LU1v6nOix1Gs0
 wF/4B474pC86JzYMT+A8sfpIdKWHr2uPK8eLbFq0hqq5aztxXFgJba0/hLTkNTaF635S
 cxc/KV/6BsleImDKFo9+cdnzijd7HQhge27z+yd+AQimxkyuAaT2iBuwhpihsu1BMKH9
 SQ+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBweDJoB2heyXFcgRqT92a6f9rKvP8jxIoI0vDiWIydjAltd+BHTS4Ku4GmUXTQD2sO8qsVNSjXimR2d@nongnu.org
X-Gm-Message-State: AFq9FYJ65LJ9DIEfTYa4DLx+5NfvZGl8u3bwdZ2CA2V9pra57Vo7VRvt
 7a+9vAbR0T4BKTZ603S0px5wibPD2cuOhWbcdhkRtPd6ShkOC5M95/q/eLxbrR0TImGwuz1tVfg
 NKwApPNv9VfhlpJyjgkUFTqtfhtvfJLsiA+mAP0LmAhnTIRf0u2Pt+ViU9g==
X-Gm-Gg: AYBFou0/RHwVbqk3o42xcxH72jqxpJDrGitPw+NKqEYxLXN1m66lJuZjTD/rbb9IP3Z
 r/mzxbB8+AzNY/Mqwe5TqGOM3He3s3E7uJLZC6dKeYgUDeBBfAz7S12K7Zo7qeSoQyF4lSkfrby
 SmTrSzqma+4zEvLOzFBSBSh3FWL+SDlCskIIlDFyntLs6y+1sketqEjoEYwV0F05pHGDc3DQA2o
 dcaJpCInVE3UIIm8T50kUXtr7SBMgLraT1vF5FKaHzjcPkT7nZSG36N83RtKGSce4Zc/++2vFH9
 cT4HhVjS0BjS+GLcYU+1YCL3qAEEctI7+38TORWp/clmwfYTrH8JVD+4Ky/nd7ekuI3y9U0MZyI
 WbdwaV9f/BeKEatOvgsh+N3CAOHr9BfY5SD7Eic6Yjo4K6CXmMaDZhzz4YykIAP8ta/vTFQ==
X-Received: by 2002:a05:7022:e808:b0:14d:baf5:c40e with SMTP id
 a92af1059eb24-185118edb1amr16635032c88.8.1792523877087; 
 Tue, 20 Oct 2026 12:17:57 -0700 (PDT)
X-Received: by 2002:a05:7022:e808:b0:14d:baf5:c40e with SMTP id
 a92af1059eb24-185118edb1amr16634995c88.8.1792523876559; 
 Tue, 20 Oct 2026 12:17:56 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1902f96dc4bsm723495c88.0.2026.10.20.12.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:17:55 -0700 (PDT)
Message-ID: <2a3342e1-2ec5-4c6d-a628-05e8e609e408@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:17:54 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/27] target/xtensa: Implement and register
 CPUClass::exception_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-28-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-28-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad7be66 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=7bPEEZRh3NEZ-oLDEM8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX2ndswPv/mRYH
 Q01UZmCoxg6RG6l9jcHtJ1N47F7pYQBYj3tCrgfrXNl7T1janmFszE0I3oLICg86J8umfZwMynp
 +vw6vzV9kjoJ+cb7G17XIPbCi5uJyks=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXyhLPZLwO8Hsb
 HETaTY2pHvbuiRTnnzfMseMMWBFHxmyoSiXYgQ6I94ldM3Xskl0qV62MEG4gGjNDMSG5UTMLqQg
 6tUVT5tf2mHrm0c8DRm/e/4SzTPjThJY1+j8wjlAbtWLEBk0URSxDrIKX81HpWm9MikWtOdauAS
 ruJ7+l3f6gtr2eDDUIzVdqwdDltK432zD/ocHstgk9TYSFgk5a5AKA/8WawSo5H1VUFfyWSI2ap
 dXsn2ELhHAwwjUcQlMhYybL5R0XN9hv2KdjPKq84EigOQV87fOaQyF5tmVDriE2PlV9M6Od5Ude
 EVFQOlApMbQ11rr2i35AaaNugiCzx0pJaU8pbob3G44/0eGAi5d9fThoScWutMiJl8ahsG9se2U
 nsKIWvv4AA9cd0BwW4nRTgSr5R1B+2wuFElD8OipLbvVkUKBK4J+xXjBQwc6BTw8PMKWTFI1QRj
 EpqnKeHZ0hJJtg+4Oog==
X-Proofpoint-GUID: AMmUFT255N86ZBROoKgzPQVKseeBou9L
X-Proofpoint-ORIG-GUID: AMmUFT255N86ZBROoKgzPQVKseeBou9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
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
> Implement xtensa_exception_name() and register it as the
> CPUClass::exception_name() handler, so the common exception
> logging can resolve Xtensa exception codes to names.
> 
> Use the new helper in xtensa_cpu_do_interrupt().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/xtensa/cpu.h        |  2 ++
>  target/xtensa/cpu.c        | 26 ++++++++++++++++++++++++++
>  target/xtensa/exc_helper.c |  3 ++-
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

