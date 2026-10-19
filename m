Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724C607249F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a1jC57nG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HnU4r1S9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIpje-00089v-Sj; Mon, 19 Oct 2026 11:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIpjY-000898-Kf
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:57:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIpjV-0006tO-O2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:57:08 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFP6Cf2091672
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lPhtiYRpFQ6I2F7Drlpq1h8IrkKgpyVyryH6S87xr3U=; b=a1jC57nG1Lpe8Gek
 LsQPv22/U2RjDLPFDEHWxOTthOAaazizjPNyEpuhPIgfP8UYCycPUEFKdeKX8hRg
 Ll3mSqVKrViht6+PIrDdlyYjI6YWC60gBIwN4vR5vIGiOUpxSzstwljMZY7vnZPI
 ZF/893BSLpYvxtVloyofnHq6eLSwoQrOmbK1Df7nzPhH3YT3n6xtstZKmFN8q8Cu
 xneEfSs2MxXydc1x3rls/3yUmhvfPXqHYx+ma+V78wAWmdT7JcNfUFSnZX2Hcuco
 yhisgUtPRPxo8v1a0+NuI+aOj0hcmq6W5iU7E8392qol85KPpgYQYdA8ermkadJn
 CbVsaQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5ca0hw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:57:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso6284797eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792425422; x=1793030222; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lPhtiYRpFQ6I2F7Drlpq1h8IrkKgpyVyryH6S87xr3U=;
 b=HnU4r1S9fPT7iYZNSG6GUG20IyiewAbe3JI2D/PmuEz0Cf2xBQoqdCV5TAxehNfPJT
 KdTW4CJVthNqcscD+/EqCCXaA2CmqSC2RTE0XeiwOvTurDqvabIyLTkXissJJpvoP3V2
 6SJ0Sp0x+jkAmSaTmRVo5J8yfsKghsLKYBtopgKcVDR7RmYNDpenqVQ3sCbgBu/Iavi1
 ZXZVMVZE+y8X3MC98kFru/9a0XQ42N5hdAmRlR+SjBrdT/DrQQ6L3qvbJymP4v+E87B0
 +lpDcJsl3YUweD1cmAwLYNCTH9YVrcw5V6NmupjeEIU4AXRzKdqBJT9YB63AJeYxwGbR
 TAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792425422; x=1793030222;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lPhtiYRpFQ6I2F7Drlpq1h8IrkKgpyVyryH6S87xr3U=;
 b=nfZ/Dn1cgXUVTT4ERui92MNcyRTcFoqxx1wC/ADTQT1L9nRVzrzXPExPjy5yIYB8lI
 y5bj3pjWrcMOHvqb/oIOp6gv3xZAVY4FJ4R/AzUOiCk107KA023kKEm1lGcmsxg7NtkF
 t+UlSMerYj1YWuDF/xw5jbKWCB2km0vtlPzYMva6yt8S/hQKGnOEI/6sHZ/b7CQCKbCn
 9fU1KzzY+jM7wLTJlkEjMiHjWd/G8q1elo8kjEI+n6dwiohaCHEZz4c2ohrrm9715CPc
 AUGCp/+XM6Wr0J3ixzeRdbJPJUmJmTcxa2dYV4Fzk2oKD24b0TU0QLnlBIsdt7rqt6h7
 tdsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/UTLYo64l3i5sP/sKwDHh7RgWgZ3X/+HwQebscfnvtLcrYfVJa7A3lba6Kr8xijiikMhdQ7GY3OhN@nongnu.org
X-Gm-Message-State: AFq9FYKne3CAOkBlo70O+krQMLBol4uGnKr+dVCBaKMWx4BUS8+wFLgK
 3B7HZ/GC2nHYZ9dRSJL9cXpc5c7yFBGLhXDGvnWRHaFgKXlppX3HdThSx21EC1MMbMGWkWCw+nG
 BWXJn0LZAtzbM18nyIzf28yzJPx7PF+V5iyNA3zJShEttwhij917Vq90WjA==
X-Gm-Gg: AYBFou2w33PWe7J45wfoVwfbtM8wAQ7+KZvwKeZSHlsDNl9piUWo2xkWBND8PkweX/x
 epti/jRVsx38p0ZKIDtyPHfLwR+q+dRS8N6mcHMM+gIbirWc7n2sVBv+VDCRrv4DCDrrHj0HHKO
 ZM7ykxDUPMCGrM80I6D9LzjHgYvSycuuI6iaR5vhA6cmwIrmt6rFRx3LQonJVRbdnAvBG5DRgrd
 RzTPJF0xUYrV3CGr4PgwBEGAchDPoqC27O65np1RyLcgf2pHYEcB4Jjb8AOMavv/M4s+C6RBPYJ
 Qe3Fm8ZVtOB0uSjF1tSmVCKHKnDKbgiTjyVnykbN8OzhJ4i1Bm56QbdxU60EQsUFQ3WC7nNsAnq
 RuDszMtXORMDPUzpS15q5M9YrWTPUkNdQsyGcSqWgvUtnLTs2i8ovYdFx+O2wveACQ6NX7Q==
X-Received: by 2002:a05:7301:b15:b0:360:ca2f:ce38 with SMTP id
 5a478bee46e88-361a1865993mr12110839eec.12.1792425421885; 
 Mon, 19 Oct 2026 08:57:01 -0700 (PDT)
X-Received: by 2002:a05:7301:b15:b0:360:ca2f:ce38 with SMTP id
 5a478bee46e88-361a1865993mr12110804eec.12.1792425421080; 
 Mon, 19 Oct 2026 08:57:01 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082a7b33bsm61295916eec.24.2026.10.19.08.56.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 08:57:00 -0700 (PDT)
Message-ID: <b9b0d2d6-76ff-4580-8833-e6badb2948b4@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 08:56:59 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: match custom target name to executable name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261017074226.1347492-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261017074226.1347492-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfX1C0xVvgu7SJk
 ZBpAwOmAhsOjjmVIM668a7+W6JMRomIzaD/9zWYiMIwhn75lqkqbn+MoYGhBYxNI0gWda8en04s
 tsrHCPvTEFyWN+xn6opzKEFRxwRD/eI=
X-Proofpoint-ORIG-GUID: FYYzk7wZ3p9f0vzCHWYdd4Kch-FplVJU
X-Proofpoint-GUID: FYYzk7wZ3p9f0vzCHWYdd4Kch-FplVJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfX4qnzHuL/sObm
 iZqH5de5p+W9mFTzIT0uqpU7ObPn1HsR33/+Rn6ZqYn2146Q0Qp294lsg3mjYb2oUo69DF+S2re
 esgy1pAe3wlVFaWvjS7Hu1wREmZFMoJbyYOsymhuwBCJ4ysJxS+rvXfkds85lt+w+BJ2AmdBRPo
 6T5jG3gRu1q2iBrtatVHBYfgqiXB+csDjpwzi8rfewk9KUbdc3EL2sG9g0a5ulcHG65awa3OZLZ
 ntuPvMWfYtE+1L/uJr4uqUCLR+IyyJVA/n5su/5eogevf39UPk4ZAE2bvn8GWDyEq8ysW+btQDt
 6LTdSqz08Ofx4Z2RyfMPS8BgEjypgqBxdyvrCAqPFUFfUXmz738JbhhBGHvjTT6e5SXffCE0SXG
 J5qC2+6DWlf8Z6/iqBtd/u1+wKOkF9X3H82iXKvZ8aVF2/s0d1ZlKX1hqIGByYfRKkuuQi/8l/h
 T/WLrfLcgjWEEhkidPg==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad63dce cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=LqGOkDN_i7p1TiLf-sAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190063
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/17/2026 12:42 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/tcg/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 43886ac9269..1ea218c7531 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -433,7 +433,7 @@ foreach target, plan: tcg_tests
>  
>        # build executable if needed
>        if exe_name not in built_tests
> -        exe = custom_target(exe_name,
> +        exe = custom_target(exe_name + '.test',
>                              input: file,
>                              command: [cc, '@INPUT@',
>                                        '-o', '@OUTPUT@', '-static',

This was merged into master (1c8440e9162d7f98d8e41ff4de0ccacb08fb65b8).
Thank you for your contribution!

Regards,
Pierrick

