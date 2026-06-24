Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB69CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 06:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHC1-0006BK-DS; Wed, 24 Jun 2026 02:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcHBw-0006Ag-R4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:34:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcHBt-0003la-1W
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:34:30 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O5tqa11892073
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mGVWnDM4oc4gp6rZjhr1WvbMx5KTqohkTft4QVWNh2Y=; b=JXOrD7naQ3I8G0QH
 JbtweIj0Chwr0AWY4vArwLtkg4Fro5uqEzPjSmjfBNmgI5/69BTxak43u3knlgab
 h8yrc//QD0toogJP7OR3jsNLkvUQ+5BOABfqKmF7VfTZk53NvDVkQPcGtEYVqXkf
 ElXl3UF8lt5xopXFDjJBFlwssD/QCQSK+3myWJQjtm66bxjIOx8UQdPqPDTCNmFA
 tV7e3iR+w2lN8AeFPU/N+De6xdao4Gr+o4axGsIf05PXdkTd9as8JQ0FhuB8CG2b
 mE6PCO6FkSQCf0gWMnRcCBmwCwx0wIpjNej1iFZWIL9Vf/j5xlVYxeUbi/fJVASR
 RetLdg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05bf8v8s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:34:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157de5360fso343030885a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 23:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782282862; x=1782887662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mGVWnDM4oc4gp6rZjhr1WvbMx5KTqohkTft4QVWNh2Y=;
 b=PGDz4OfDZkDCMG/f3mO/d/kdcVZCEPKWvgjOrHHSH4YoAarJB2zvhtAgI6j4QQP9/x
 MWs/tXOzRMaWJYoshunyVmzzHVXw3dzUQjOMPeyu9TodYHiB+ps7c08Mxr7XXvH7C2AP
 eq83lF4k8LruF98AmFeU2dbTPLAselSbO02mLIHiNxZhdJ+x2I1YJx7L6yQsVmCIxaR2
 FmyBLRGjgs1ovo9hrCkBmMiYQ8SCJmtEEpzoGhbVfTk5VrixeOsZpma0llzBnzTpYIuz
 l7ow1TnjvApH3DnTyg76E93FDSREq87yF5+ZWbHlAQJfEEkptMsWjyRE1n7mJj4NirUX
 LvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782282862; x=1782887662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mGVWnDM4oc4gp6rZjhr1WvbMx5KTqohkTft4QVWNh2Y=;
 b=GJMbTKcqGlWUm7C9hZ6oTzLvB8iKhwtzpDSqeHxJvQhy+605LZ0Z84eaOGdG9rc6Zd
 C3vfQaHS13ON/KKotHFzOXNymlEMxwC3vKEHJiUjYr8Kuu34AVpSMIKTYKw4JZPjJ3hX
 YPeAQYP9nGpzr51+lU0C2Z6SchzvfiMeEnJaHGCGtMsEYKRXVvk7Qsecm66ZbaiAxtvP
 L10/AGee/oyNLZQPwv8UzK621/SjZIcj6Lwiy6YwMWKFbGdDzkQd+WzhD4WIY5DEwwO+
 T8YgSMBISeCNzUYakhEefVC1opTLVY1Dceojx5kQ8SmjSdSMp9fLw3R3hQ9fWQtjxep0
 tiHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+x85S40QuwSuqvutJ/Jpz+NuLjwLI7aH+he7r0x7fLanr0cxXnj2vq0m/N0/3M70OBUNVs2KOv6zIT@nongnu.org
X-Gm-Message-State: AOJu0YwA4lb6zXtblymLLWPQhfxSqQmuBhbhNcch9AA7irrP7S66+6Kb
 2Ixm67jTWhO1jh/Bg3re+4SjsW0eox5JRXuGNFCdWjFCq5R7C6VS4d4gD1U/Z7TpPlXYRy6k4dw
 nZMLqWvlCvPGr8c6KL70Q/K52yKhLGCrPgyfTA1TBQuiWlYiM50uyZ7VKJw==
X-Gm-Gg: AfdE7cmpjyX2MmpZh/xnwYKkXIXPHeenyaP3MDlBQg4WvakwjGsFwtk4WGH0NJIDxX/
 7kv+u/dbTzSx2japXigZUUqcisIUHuuI6Bau+wK3X3eUtdbB8kIy1YDyd8uZFFpiBHPgVpx5FeZ
 wxycRAinsvpDjShO1l0lgrufN4sYNFAT8LjZ4Mzb3ERhpkdAI/pCU9NykD/TmoKGA2OnQV7YYfj
 Wax5LgdSlX5MV/kKQRFJAPIrQf6UMmKPKHZpyuFcbh7xUtb6Bhh3yEblEfIi+QoNfUZDpakpbg6
 cNqdJM64pAuyZvIJ4NFJXvZDG2lG2IkaQIAp7lzccUlAA4kgv4oURPkDu0PbzyJPIjuuEJ5Mo+O
 SRuvIAUEiYuYufPUhvojy+XUcI07W1yCaDApCmcNSL6qCZ64zhgns8+r8ZZ7rjA==
X-Received: by 2002:a05:620a:269a:b0:915:ab5d:6763 with SMTP id
 af79cd13be357-926039b4cc5mr375354385a.43.1782282861959; 
 Tue, 23 Jun 2026 23:34:21 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:915:ab5d:6763 with SMTP id
 af79cd13be357-926039b4cc5mr375352785a.43.1782282861505; 
 Tue, 23 Jun 2026 23:34:21 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240084928sm447146315e9.15.2026.06.23.23.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 23:34:20 -0700 (PDT)
Message-ID: <dd48e432-ab04-42e7-a88f-231d1c9d55fa@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 08:34:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: add flex and bison to emsdk-wasm64-cross
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stefanha@gmail.com, Kohei Tokunaga <ktokunaga.mail@gmail.com>
References: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X8Bi7mTe c=1 sm=1 tr=0 ts=6a3b7a6e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: vTuhdf8mbwtnLxvU7p48qaUY6X5Z_FV0
X-Proofpoint-ORIG-GUID: vTuhdf8mbwtnLxvU7p48qaUY6X5Z_FV0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA1MiBTYWx0ZWRfX0U6hZjwLd9HE
 OzFUCH9ABoSTDVB7o8Wzaqor5rmj+TsxVYzOsgIOfCoSLHoe9opcIHix7nzhi1J1y5gHlO4kbHS
 2jtM7rtGduPfcqwkPwtqbZJc29HjoL0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA1MiBTYWx0ZWRfX8nNZNeOQGqyu
 5pAxJf/1c5gDSj8glmr7LYVarw6zhRAJiHDLnMpCXxUo1yLJhQ7LqYkgiNhRPi/tkdmhEa34ABN
 sKb3eHwpAXs1KBu5Zv0IvpYlac0mnJnWWN4hlZHpMS6a7sVfDAlPQA7F9JYWPqFh7hwnhV508NO
 YYj5kAaPWX/DAK+ogsaLzin2o+78Q0ItMOKsS68/NO/p7n09NIefjYjd7H+wHH+Mz+3CUWWRjxP
 nAz2d0TWMikSx/4ynHEUd4xKdnbFEh/z1N5KuR7+DGbFtn0FmHWv/aY5Ui3GswE+TZmg/g75Xep
 U6juU4s1E38gSzhuGannKpWj1RKGKMkDmS2IZoMLUdfQG5sEMZfSX4U05vYMdLjJvALLZzfCGWK
 owuIFAkJBuEJ18RfIjvOrhJyo6d0CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 24/6/26 07:48, Brian Cain wrote:
> The hexagon idef-parser requires flex and bison as host build
> tools.  Add them to the emsdk-wasm64-cross container image so that
> wasm64 builds including hexagon-softmmu can find them.
> 
> Link: https://lore.kernel.org/qemu-devel/CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4Mk-44-RQo0k=z3w@mail.gmail.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> index 8a924816f92..5debbc77d08 100644
> --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> @@ -19,7 +19,9 @@ ENV CXXFLAGS="$CFLAGS"
>   ENV LDFLAGS="-sWASM_BIGINT -sASYNCIFY=1 -L$TARGET/lib"
>   RUN apt-get update && apt-get install -y \
>       autoconf \
> +    bison \
>       build-essential \
> +    flex \
>       libglib2.0-dev \
>       libtool \
>       pkgconf \

Maybe emsdk-wasm64 should have been added to lci-tool first.
(not your responsibility).

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


