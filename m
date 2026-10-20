Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2F606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i7+xU+gb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NQ9S6mvB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFI2-0006Sm-RG; Tue, 20 Oct 2026 15:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFI1-0006SQ-86
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:14:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFHy-0006s1-Js
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:14:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7IIo3460843
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 774Bucc7SBLCt2HogrHESBVoLikW5S5B2QAGOTnXtF8=; b=i7+xU+gbDtpPj70e
 6RTSMxk+lnOrAkAb0rcZo9/mTigK7CIGbl3IyOJ90QTlHXoKNLjQQaHPaTFQdqns
 n5Nd50UgmpG8UREN4TOtRSfDRfmQidiMVYkeKJvGfAE8HdXS33un+kV3j3RhAB7x
 IVxvu9J4/ebInUT6s8obc+nnLsDjukY4tHyvr08NF4mLcCDs+8xOvjVAnugwBkS2
 kRZqX83MoMMD06iZXgETg9l5BNika5OJ57+nuCT/vkX1JSdmi2Ts47XOOyJyWBC9
 8Hy2do2Iik4EJjFfacDYCZ6izVyQ44VFjbP9e/T9JNluMjATA+WRxUrJvXbiuxre
 FQw83w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4r7wj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:14:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so10056556eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523660; x=1793128460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=774Bucc7SBLCt2HogrHESBVoLikW5S5B2QAGOTnXtF8=;
 b=NQ9S6mvBT/gmKJ8Gs1tczYoaYdjgx6LxIJJcVO8EzLGmsb7qxqqKhnt8CET76CpnwN
 HYg/FKe3qmmhzLMeBC6hJCHA1XgBX6rgQrBDxTMRALZZzbT/vEDGtfF44FOR07vPRgSH
 +PR59IMT76XJylMCEkAdcN1xv0oynNoR5PvZOIRGJERvX8OD3H+t4FVHcEoKQEpqJitO
 2975ggTtjtr7F7yhL1/3SZfJ97i1HOLOUMjTw/b+ZM3BgJ5serHKCWHyrKyrV1lYXWrC
 NmsM+cJBZ306W4/vTnr/qjm8usyjj+xi6J7mgHXZnrx9CltgViHJ1xZuC7dQ6S1QOJh+
 4Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523660; x=1793128460;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=774Bucc7SBLCt2HogrHESBVoLikW5S5B2QAGOTnXtF8=;
 b=eezdr9oKn33lQtGSzPthTp3hL6kedBRngPZIZVOj6WCZP87BnwWpmuymkFyWh1y12q
 1WhS+FhioSnsP8n07LbQrTYRA59LxvhHANJx5dbRcipcwKeV8livg98wtR0GmKBmWT8L
 Hd5M56Bvwjq6XKzoThJ/COopHUflQiM0FvfXjVKaV2UmxZ+9MEZnViSk4sr9JFi/RjbG
 VI7Sl55F7jr4KQy6kEKuhz+m2suxHghFP8yApEszbs73v97fAnQ8hdwv/6/DYPTLFmwC
 +FrQAeK2GD8qvxchX226GKgI1dnczVRJxou3xtaSB1E6uLd9vu2/jyx3/8o+zBv5Hwk3
 mrGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlQMOb7iyR1+IpB7Rb9ZisTSBTqSbbsA2AcHa8q+MKdQXisx0vyaz9wV7PVH4oVDnNs/4TIjbDtZ0v@nongnu.org
X-Gm-Message-State: AFq9FYJhTplPbMsyAvd2tkRka//I2d0TZsF6UinefBGoUMS8utuNK4e6
 o9oITGyycmNqOEL2l2nwwdJH5fY1YzXKLvHRAYsstmg+qjbVvZ9weDk+Cvi53OcUGJYgtqaAMad
 VzK9LO0fN5NqQdWGdXwYfwuyA6KUtbp0sE7/3p+VF+n7HVMCVL8nb1NDUdA==
X-Gm-Gg: AYBFou3d9v906+D8eWIPR+aVN0EIBQNWrIRUaDPaVoC1LOQN6FrjNN0e/Vcdgg421gr
 eEjleDT28y0kMkvTQTurDos9HESxvCJg7uBGSgezxTBO7hhmnV4V3DkT78ifyUMjIe3J/eGD/xI
 5aajxSRElHTyWis/Ce6KDzJ7j4H6RzmEnWZ6XGGxFS1CgHy0MrZeqKOFAbqIs9yUemLTMAQ1JYB
 YPw7AzIT33sbHOB7mfax+ltTaNeOTX7IEYvKxr5lh2bbJtJKnjEW4rpwla2CxEEqXH6JgC7j4K/
 JizK29vkbMrhLP4auqI0zpOkKd5QrHQ74Gis57ohVmmlGmJwKpWRtCFMDDVUzJfo+kZL82vRy6K
 ZGYXSwMXvU/DRCoHbDA/u9ad/GminrW7yQzi9+wZc4EIBaDN1kbC0K/nlzW8p3Vxb37mOrA==
X-Received: by 2002:a05:701b:4242:20b0:160:a80f:3ed2 with SMTP id
 a92af1059eb24-18511eb6884mr17291454c88.10.1792523659609; 
 Tue, 20 Oct 2026 12:14:19 -0700 (PDT)
X-Received: by 2002:a05:701b:4242:20b0:160:a80f:3ed2 with SMTP id
 a92af1059eb24-18511eb6884mr17291400c88.10.1792523658240; 
 Tue, 20 Oct 2026 12:14:18 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903a74624csm559640c88.7.2026.10.20.12.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:14:17 -0700 (PDT)
Message-ID: <d97e0457-1040-49b1-98ea-fac1f311f613@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:14:16 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/27] target/rx: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-21-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-21-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P_wXk6XUck_GVYP36Fce-u6_pxTtkzgX
X-Proofpoint-GUID: P_wXk6XUck_GVYP36Fce-u6_pxTtkzgX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXwxJV3ooJUvxs
 f7Kl9s64Kw1TdmA5pJwuWKyDCcxNPlTaiStnTcjaBJB6ziconh6Kl8/6zCGT4ob2CPb8aASmrZl
 mKpdDra89CmlXseWB7cc/sXqljYZaNY=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad7bd8c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Ih3d5bOS9KtO35Hy4WEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX6mx7yUfifgTn
 DDkIOXJvxQBIgweMMvMIG31P0CXH7VrcTyg1jTMoWvzRszFILbHg4sp/0ZVyVwxij62uQKc1qdE
 1wYhAkB7As1KknYRSedgWTkJqq5FPWFJvusclHTsoPi4dh35oBGryPlEG28V4hlb9VFLc4KodFh
 fYSndO3MUmZxp7trAgS1z3NxJJJ6cPAv6V8j5n+84AIbUqgzQNIx6ebkJnPxzVkolwMYKaCv+jG
 dMpb0I5fuuclvb/gWZCxErxsfUq6/M2ZvzZaRRe/oIWCqBGMnWGKuAsvaaLTlAYrjYCXMvaYEvu
 ndr8ungkFAv0W3ChkFAKlQjlL1QYqnxjACvLl4rIGuFTwLsPU6vXvHO6K1k9Qs1GD7e+FQmQsuU
 GuoGE82f6LOvfe4qABSamZm+JIdkA9F7bsn8OgFC+uPifhCPaXDYGsK0LjOba4qrAwWmIPtNlj1
 IkwlYC43cO+1Zadbj7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
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

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> Factor rx_exception_name() out of rx_cpu_do_interrupt()
> and register it as the CPUClass::exception_name() handler,
> so the common exception logging can resolve RX exception
> codes to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/rx/cpu.h    |  1 +
>  target/rx/cpu.c    |  1 +
>  target/rx/helper.c | 53 ++++++++++++++++++++++++++++------------------
>  3 files changed, 34 insertions(+), 21 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

