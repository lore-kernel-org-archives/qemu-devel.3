Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F13606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D8vvL4DZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C34DNIAT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJG0R-0001DM-M3; Tue, 20 Oct 2026 16:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJG0P-0001Cv-7I
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:00:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJG0N-0002La-I5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:00:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI6CbH2079877
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mwtlFGKsO+qSxSLUuN+vbWVT+ohu1h+9TmaMwFLRi0M=; b=D8vvL4DZd4ixwA7/
 xVob79w6xv6DAcFOuiGE4c2PT6rZTR8xGOA8ZZvOrofU50lD6SPemp9dQAWSDoXF
 meM8/qCWS08IRI81UemBM58en/CaCNYzPS3SAE7iunn6TQLG3JRtOrFK4/9I9hnL
 lYFYy5YN72vXsGqbVI21ksRjrfXiqrHc9d0/Q9sfNpEz2ab/KZgITXLH1XK1OQgJ
 zPptrhWDcbkeOScIfGUXx8pquPwIeVppUFgt1A3aPJbKiZmaZ8sLVsmwIWRNUKnl
 0BwVWyX7OmDVWnzvpmCOZjMgXOQ32AQ+v8tUBDUnZdQnE2bGP5DqpN0xTq98+anF
 6IYmlw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9hrcnt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:00:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ce7a85f04so8066885a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792526413; x=1793131213; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mwtlFGKsO+qSxSLUuN+vbWVT+ohu1h+9TmaMwFLRi0M=;
 b=C34DNIATqbPRE4ccK4GHflPx02zhuTxENOTyJZZ0Thjr2NfaHXqVDsewlNIwaNZkcN
 qRSYm97Mcr0QnvOIbLJ8gj4GsROCtNrjqQSyRITK+0p65ppHpQ1CeHzXCuVLGxXeFpb+
 9tdrxqTU69BUuxyXfVorGr7bTlrGXOuj60riSWWQpPaXqTzQ3BAHhxfePQyFUnwK9Yrb
 5qFlHdtEDcjdw48hnProAKOQuG7iOo6kjOU6AW3bBW2URIDf5hUoeVRU1A461RQddP31
 yKAl9vlCH/yt5trrOSFjs7h/4WHczce4cruaFMgYZBaZbF5CrAxbqmwNHjd7nOuOijtj
 YH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792526413; x=1793131213;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mwtlFGKsO+qSxSLUuN+vbWVT+ohu1h+9TmaMwFLRi0M=;
 b=0mbq1yEIBFpS4yLNPiW/mjfIOCj7d0xjw4ynJu0Ybj0xjtsLaAy4vj0wwLXZCwv0H2
 PEsxDWxyZNKthZK380qWeW1BNCqn0VA22yY6aGY2Dkp+wkpJOb3DNoUaCWb5tFNBnMwU
 OvXolcS93nHLfSCa1b3tP0Ji4VflTCU3d4BDDcz/btHKeUv0k65/3JMeMLjinsblmzRv
 Eb+ME5jg4oDyh2XomLNhEQc0apiJZFyi7FPGNgPDuC+ZP6ekgZn0qvQB6LaH3MQ4sOZv
 +y0QAkxoo/sShEItGEplenLYhpVoS06T9+VsX7LrPAYWReY3Eu4CGRPVspY4U0WW2Wct
 /36w==
X-Forwarded-Encrypted: i=1;
 AKwUvBytF1cIy95waDD6wUZrop3dfkRDyC4owWV9EoBw7gqeH9rHAfISUOuDQ+8AdbYDhcDLpDkISBbLW4sI@nongnu.org
X-Gm-Message-State: AFq9FYI/FhZBKuCh9fGOrF+zZilOXZJEZZachsFN39n2p/71LHa8Qq+t
 20a13ZBzADwWb4ucPTnxWqfwK0otQMGqynr+Q7kzV1sAWHKc99mmFMxnXv+6GG8yShpmTag2Xal
 C5s7q4NB15UACZvSMkdkM50IU8JecALxXhK3Z1Ztr0H5BI3nA6NDuyxqtZQ==
X-Gm-Gg: AYBFou1P3+LDEwHoclDJqfL4DNcIIO3PKkk+5aNVewyNpDSoeWvEjKJ4u7AvtVnkDKq
 rxM9XQPqnR+gMuqI610iujCDY6dI6Zki+H6fCRp4QfZswDygjsuovF5za6yXKm1VpwaOBAHpumX
 +lpBx7MPm80BMDIXGgSV1gov+7lmemX83MlmXTud1gfzdIScn+/erk6/Q/85mBMl3t0KhumZUQ/
 Lx056AykVYnZpeRgghUWUBOQdJPqweH2rbih102orwn+Vv30Mag9vGC4vcd6BUXQJMlg/NhLEKE
 XsyDLogDsBTsK6Omkrwf9FWE0iFiarHujnT8yW7c7X/wQKlbB3oMKEXkYqSI/H5gMc2jKW+tzpo
 hi8zvydDqjDtUXXaa1coJPeUMS2ia/dFqUw==
X-Received: by 2002:a05:620a:3942:b0:93e:c12c:f128 with SMTP id
 af79cd13be357-93f5800c3f1mr49214985a.67.1792526412808; 
 Tue, 20 Oct 2026 13:00:12 -0700 (PDT)
X-Received: by 2002:a05:620a:3942:b0:93e:c12c:f128 with SMTP id
 af79cd13be357-93f5800c3f1mr49206885a.67.1792526412248; 
 Tue, 20 Oct 2026 13:00:12 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25833b9asm573557f8f.33.2026.10.20.13.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 13:00:11 -0700 (PDT)
Message-ID: <f32e4768-2b61-4da7-ae29-0e6637543e3d@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:00:10 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] linux-user/sparc: Report HWCAP_SPARC_CRYPTO for
 crypto CPU feature
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-8-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020145530.3385376-8-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad7c84d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JY-uzDWvo9T7PBqDLksA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3OSBTYWx0ZWRfX8voho4Lt0Dhu
 JlcQh/CYLpSxExbjAIZArpkEWugEivb9yfwMAIMB16e4maC3sXbWy4iuhUXrjTePhGj9bH52aNY
 lSW5FIaC4TrG1XXag+v5LK/yVkahH5c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3OSBTYWx0ZWRfX9EqAEnvQkZ6N
 StVrhgVXW7pHpL+AcdEI15UoDJN4O+7a3ahQiojTv9vaLN5SsLxjCUJV690Lyp7UTnIvmTFrvUF
 cPOt+4OUjxaeZh2Z4pgl76XG6shY+Nm1AihaRe/Jbii6o4IWllHlkTOeFU/5ed6W+BmIidCL77u
 qfNDZAJAaUNNcBQZPaWCOIz/DstNlo6tVmuCHVonCbcyR+Z6nWxRFEdarP7HLiavlIOHQozQuYM
 PKUh15MVMZKyxXN5gVvTWjiez3HVJ2wVrpTBwvsa0U0K2sBzo2YocahXTPC/9weFSaARHVI+2SS
 5Mf8uyzADhr2ctaQyt+vsLAGVXfsiVHyW4866F7K/aJTXwffAwUMRrGB5KX+kxIyn6pLjhtt409
 LIQTR5iM0qZR+Ol2Mlk8hBlOIQSIy3jETSrXaOUTiMykBGHqErYv2PvoquqQRGpA3OVcdgC7Chu
 pEL1oUcuZEjVSqKhlEQ==
X-Proofpoint-GUID: IAYDTUiuhZbE_nirloc-llGPaZp6GNOk
X-Proofpoint-ORIG-GUID: IAYDTUiuhZbE_nirloc-llGPaZp6GNOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200079
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

On 20/10/26 16:55, Stian Halseth wrote:
> Set HWCAP_SPARC_CRYPTO in AT_HWCAP like Linux does on real hardware
> that supports it.
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   linux-user/sparc/elfload.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
> index 181f1e00b5..0412741285 100644
> --- a/linux-user/sparc/elfload.c
> +++ b/linux-user/sparc/elfload.c
> @@ -90,6 +90,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
>       r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
>       r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
>       r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
> +    r |= features & CPU_FEATURE_CRYPTO ? HWCAP_SPARC_CRYPTO : 0;
>   #endif
qemu-sparc64 defaults to TI UltraSparc II which does not have the
CRYPTO feature, we need to enable it manually with:

   -cpu TI-UltraSparc-II,+crypto

Worth mentioning in the patch description? Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


