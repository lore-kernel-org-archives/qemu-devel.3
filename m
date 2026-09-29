Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45993CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUVD-0004Ty-PW; Tue, 29 Sep 2026 05:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBUVC-0004Tq-Ja
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:51:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBUVB-0006BY-43
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:51:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T9lWKU3437055
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KLnVegajSovd9OyWjNOR0xPw+kiR4VNR7oJWQq5Mjd0=; b=UBZK0wuQGBN1P2OC
 pQBrrpuRhhz0tsDCyg88hsf3/yI2OyauuLCAe49kYlMAqUpY4562SffR4+Gm31Pw
 7/uklYuWzH4pDcIaEpWiEswIZLgvkwmoC8mXrlq5BuSkelTffquIboaMAWBbgdZ5
 PfD6EcLGUBdKsZXV9kYtu5+K13EF5l5dKs6XiHbN4lI71ED2Dqg9ZL85zDvEHyrO
 tGaR3W33lQUMuZnXMUh/t9E3V6ZejAtRV6cBCrYImlanWkDPEGuEyuJf6V3hQfGQ
 A0ADPYV0+O2aGMdZyiTLr1R0qJWbjCMXT6XlwfQ7gsJYFAeGtZ54m3FYvUsJvgqt
 AAd+QA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0b0v80mf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:51:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93909014c85so818061885a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 02:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790675514; x=1791280314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KLnVegajSovd9OyWjNOR0xPw+kiR4VNR7oJWQq5Mjd0=;
 b=UJ5nTMUC97LPCSAExyZH32XaF6ZKDn99EHNdVJE7JznUsKUKqMG2YO/3laltELfEV2
 44ugg3BhAC1Ax3dhp/aUzs9TsPK7DcEcgKLVABMz+dfZyOCYwToLT5MC8stHVPWVUO4e
 ZcY0KrZYM9R57/hkYwirvMf5ib0aemTNmsvHw6hq/c062gSgs/nQ/DKK6MlH0MGmWadt
 vEoKKc8MtQfuXxHR7Lnf3woAR+E2aV6WDMNRojBoNGXfdLR8xcep45KYW6CZih5cBF6a
 tlZ4SNve7g+ZLdQAGejpoPm9KMval6vJeZJcJHaQ1u+9J7gAcIon2Bma51FH2n8saRfs
 BJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790675514; x=1791280314;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KLnVegajSovd9OyWjNOR0xPw+kiR4VNR7oJWQq5Mjd0=;
 b=xpyJP8V4nn+jd7jPDRadBzM+XsF0i/CxGKNFSvguBGDv6rsP7nlmeqTn6RdKLPJbIn
 BZaFgJRtGQBVqN9h5d5YAo6fFTFvxoX+W9kSPSGuScHVPcYVri7jbPf4UACKOfuvoGpS
 F63kSYcoavUvOK3PDM1rfl6UvqSerfh82CfIVO3CNPPHlL7AzdPKrj9ung/dGxJaGoSe
 bVRwQgxGNiJP/lyNd2dDm9033V/gN8He0diHKTDeW/5lSh1xmH9RMmgYJ28byyAjH14Y
 ziYgMD73QcRbuYxKB5nwtQdjgxrtucNSUbAwrsnM+NG86MJQM9ngXeqKKA9E9P6QxBEY
 gIYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/VcVPJM8ZSYdF6l11hGsnn7ZoG2Rubog2OEtRcyPJrCLqOmhQrrIlQZba5siDPA8o6ZBJRPkUSczS@nongnu.org
X-Gm-Message-State: AFuF++l36DwKJcwPEaFrytl2MTnAjNMjRvD87IJtpEroN4cZjI/6LyU4
 Jaog5rzdBTPCXtEMBm5x2wcRyV+qK7yeFRBnikFBV6A4hBojB6EiCMvkpH6RBhASe1Fy+5pLRvM
 BG0n51B+cM9RKuUmJNvK2B+3HCAA7j1pABxdxVvNMcB+h/4qWMRj7xj1ULg==
X-Gm-Gg: AYBFou2Y1gUCYTwt1L/q2MUPK7XHeN5N29xwDAXCMKNKr01xBuJaC9LeUJsfevo3o32
 GRfTlRzuN0lT7+IJsdPhiMmjt3GBhu7UQ/Ca5s/bzelrxP9yUngD0RTXfbOjKnGVDtpqyCPYOHj
 fRVEBypOxQM93ku6vKVsM5nW8F9CGsbZJVE44wMn1Zn3i7G4icrloxS7drOkrPfOzsfXudoB/M+
 VdrGvZUnKWvD8MaBAJhK0Orl6NoRCeZpjmxvs7rtA1sRvcVYm4CU9PFweJLxxF/jUx+pV/tie46
 29qEXDu8VVrbiGeKo5mK/5CV8crGk4SOWrROFWeGZKkR+DQvKRmW8kTdJJoHqJvfY0Yyh+E3ood
 sviNnsHnGDBYMba6yjWll6+2aO9D4Zj5GGA==
X-Received: by 2002:a05:620a:6509:b0:93c:612e:9b4c with SMTP id
 af79cd13be357-93c612ead03mr1784905885a.58.1790675514316; 
 Tue, 29 Sep 2026 02:51:54 -0700 (PDT)
X-Received: by 2002:a05:620a:6509:b0:93c:612e:9b4c with SMTP id
 af79cd13be357-93c612ead03mr1784904185a.58.1790675513802; 
 Tue, 29 Sep 2026 02:51:53 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00dc06ec7sm36102755e9.1.2026.09.29.02.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 02:51:52 -0700 (PDT)
Message-ID: <5dcc8fda-2301-4610-ad48-72e54621161c@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 11:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/19] tests/tcg/mips64: add mips64r6(el) tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929074007.118970-20-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929074007.118970-20-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Wnxiq8DY55XkhF-j63-lb_XJGkmupL3P
X-Proofpoint-GUID: Wnxiq8DY55XkhF-j63-lb_XJGkmupL3P
X-Authority-Analysis: v=2.4 cv=Z+55j3RA c=1 sm=1 tr=0 ts=6abb8a3b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2w4hv2SypY4VhzKpvnoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOSBTYWx0ZWRfX9d2t2GJmMroe
 ONB6T+ZDp32OFS2MvHa7mGzpZVcfQRsd3FB0xCEHupC4R/gDDZQ4ZuU6xPRxwtK57ku+lQTAL+w
 ufswIm3T/laG3KI/7lSXBf1jQESiPuP01iP/2XtU5x4daug+e4qqhmbQWibtSUyWm3XsIB1Xyjs
 l4TziW5J/3hY5PwGhkKT1NALxTcpDu4jpwlMQeZriQEQibLcpwfLUW5gbkg/Jg1wY1sYMbvKNmG
 35gjnI+1CU+8OT7s8dhLlDYcMvA3dv593HqRHkhPxiNMSU7PW+FvfvKPQm2wifYFt9ER256ISo7
 ZbUbm1m/8jT0DxkyDBJ4P57EyMvr8IQ5L8BiUOZtAjIRJalLZ21r3yt513n2Cn6K9IMMt8lR3X4
 ryyO52OEkCDFGFwavFRwa61FgsFGXjsvoQDMrG6vkEahYeEY3KTeIv+3QCCDhstplUfHc5zJxV6
 vOi7wtdvWzJ4rSuLYug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOSBTYWx0ZWRfXwxTWmAYk1Qde
 E21ujeOqM4RhOfdc0U0JVfI0IwQEUDMQdVL3E4cgfKWXXuLynSZKdYQ+1SsVg5kqvi5uXeaoNGz
 4ew2uLL0VNh6qtZjaK5nt39CzXMUsEU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290039
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/9/26 09:40, Pierrick Bouvier wrote:
> We need to define two new test suites mips64r6-linux-user and
> mips64r6el-linux-user to be able to use a different compiler from
> mips64-linux-user, as cc is setup only once per suite.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   meson_options.txt              |  8 +++++
>   scripts/meson-buildoptions.sh  |  4 +++
>   tests/tcg/mips64/meson.build   | 57 ++++++++++++++++++++++++++++++++++
>   tests/tcg/mips64el/meson.build | 11 +++++++
>   4 files changed, 80 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

