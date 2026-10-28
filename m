Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57C606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z9lV5xVH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LB/5Lsjr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAho-0006jt-PG; Wed, 28 Oct 2026 16:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAhZ-0006ai-Bg
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:56:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAhX-0006JE-FR
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:56:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPC9G2969603
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hWYsdfBUBiupeyoRh6a+368mcsTHFLGdO3OnlEUj2eY=; b=Z9lV5xVHlYohQgfy
 HaXvWqZjypyHunxBfwlFQTTpU5GNQrLTKBWyPmupw9QG15M6eeW+uv+mwqYNG9Dz
 huc2lcH6HclZxk1u1X+3CUsf9H+83OXMDvEuLeRpxsD3D+PPsVKLIjR9UDggPjmC
 BYCPC5K+FcGNqM5oUSgswCfHaiN9oFQ78UVEOrAHojiPBsfjTWLaHHxpgH2+cWIj
 rDlztPiu9yfrZ++0RkkyUlDNkHX7z2NYjBXohs5vGP7h/K+Wj1mcSWwBvQeEQGKp
 xcshe3KBipB+X5ZVUpQJqTNplwrA8a0n0tJ0Y9rpdxS6htqUNVKs8B0ZtH7+ye8D
 TDpI2g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehsfdp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:56:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3662e7a9299so5506688eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793221009; x=1793825809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hWYsdfBUBiupeyoRh6a+368mcsTHFLGdO3OnlEUj2eY=;
 b=LB/5Lsjr0jwmjDJPd9Mi+qDLAV8GtVChherzBjv3/qjs1iYNwRd+qdM9rD6mjHftyv
 9sBnAkIio6bOh3NmmILSPj/OyLQ/zXz1H0x8o7bLeMgMMcRV5rLdd2F2H+tMlyc4YeZC
 cLC6ZRkrS+eh404pGmACNGUbou8GVFK0aQPGmBwDPVKPGgpNSvtX+C9Sh6mrk9+vbaIX
 i8TgRDkpfWzGJlA/6b7HEifO3km9ZDEwwtSHpdjw2wp3nbQQaVV/trl7sidbHkWuy9cH
 TrUKvCNXTvblXyW8MWuYT1eONV+zhJLC8NP4ODFflBGqdSDUWrDJvxFy0G8B+GzoMpCK
 TgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793221009; x=1793825809;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hWYsdfBUBiupeyoRh6a+368mcsTHFLGdO3OnlEUj2eY=;
 b=0fHuwLKfbdQhkCm6/6+nb5whG783agGNMwa31UceNRaPA4aqb+cyvAq1laYQWiSPiE
 DoDtV9z0RPTGGvlw8w0U+L+jsHsv2Rvijh7rNZmudxPfw0hUsqBLZYTPZ9vlR4yWH3Jf
 QgbI5zvBNe3QpE++0Lke0bYkXOJQsUetMLfJ1F1sn0ftnkxu5QndCKKL2QkemaYj3SeB
 QEOoCmCyk6wU37hK+mz+fDk2l8s/bCVsJrpY1EBpnIbKvWZ+D12pkASEzKdpW5yYXI/Z
 izuTcZ0Gnec+64tEH1+Qc25C5l5S5dUitSRr2cPaCVchgC4kXC8r6Rh3dqDzSDFHGzL1
 zqMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNwG29DSw1O7df7pwdqpPErjngm9lI05VzFY4d4r1rCjiZH8E/CcZJByroL7Hf3++R7li3RTml8F4F@nongnu.org
X-Gm-Message-State: AFq9FYKUzjxanNiUCMYgRInrRy6gkCCGzq0st4A2WlZZu+G7U0I6nKR9
 54NWsD6BkEXjCTwUpzdDvm8fizQl7EqlZqIWsZI0YAt/vz6zDILK4VWmqPZPPLWMbvZRbMpWn+x
 OskwuBPHtxXLywRPqnQ1KJ7oXMbusWEjHx8sNnxShPmn5UWbDsnLiwwqupg==
X-Gm-Gg: AYBFou1Ofi3HUBn9fo7vNv3irEQtxaC7+xKknZsAeoNihMt4LpvxYMaZSpCK1c+nB2E
 MmNNvPRjFRpa0QjacuepHnC1Kj6i4MFQqhs2e1RwwWD6LCSF9tF1kH20Ow0MyVpd7OzUYh7GTpY
 URa0iGPoLQNbJ9p6yl7B+WCGsJhJyooMSoUl8n5N4B7ElKF1QiaEeqvbJz/p/gpRW//0tX0Azzf
 9XE+/MQJZU3svy15VPL1D1mk70lmms28boBISUhXOBIY3YTQ0X+wp+U9mDC/E9M7LR6/hx3XWGA
 Ic8W7rnEhLoQqCoONnZqS6GaMwE5RsN3ZVVKAlafYZPCoxVV59sKymmv2hlzQ+jnm76OjbUsIEQ
 13GyHBwPd96KQOAnf2/i9625AyhI1Fp2julWJyqJviXn2dc4Kk+dNxJIIDeYtg6tihpKuqclXtp
 gEq1eycLsOG/vZsWRsguCe9unNioLwPCBaNupVe1ow3lg=
X-Received: by 2002:a05:693c:4196:20b0:35c:85fa:5a68 with SMTP id
 5a478bee46e88-36a2043f09emr5604192eec.31.1793221009089; 
 Wed, 28 Oct 2026 13:56:49 -0700 (PDT)
X-Received: by 2002:a05:693c:4196:20b0:35c:85fa:5a68 with SMTP id
 5a478bee46e88-36a2043f09emr5604140eec.31.1793221008340; 
 Wed, 28 Oct 2026 13:56:48 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a239644efsm14525270eec.23.2026.10.28.13.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:56:47 -0700 (PDT)
Message-ID: <0c372e45-eb39-4917-9b71-20658dbd3b6f@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:56:46 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] target-info: add target_base_i386() and
 target_not_base_i386()
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Farman
 <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
 <20261028201557.2688-11-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028201557.2688-11-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UgMf_fp0rNosNNeS-M1j-kWocZnmn-FO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfXzPQmVHBArYdY
 BEqssz2u1s+CSj5QF70ovaWFbjWdQZczIjVvzG5Dlih4Zcw7EGI3YWY1Rzj5n36tS3+tIrcjlm2
 mNVWvjvFCVbFvcUZNieTJ1aIO0DRvUPIIDwU2vAmEs4m97s+syZoaYA+uXibEo9ueex266vtx5t
 7znYGdrMrYnEUXljwfrmkjNUlz22DQCFIke+ytWUSZzMmSSAILJ5xYfEyc5OUdJy6dTgQSDLzLd
 rzqmdh59fr0XKUCjfjbnDFYPHG7yzJR+HoMZS/XKWXD/S0UtQIkbyBX4jxl+FDl1uSHWDwfnW4T
 9rGdJOkGz7nWvN3bVWLfUc+ql84dZRHISW+FkgkiE663HfiTTyfDvXl831D2JjjDB66xpdzRC9O
 UOKvmN43s/FuvE1CWr8nrO0IlsKJP+XbOpyRbwLpjSosqrQ29Mp1YeZcBKJVYb3Ul8qQVviIiyO
 +AO+9T95rcXMix0hPLg==
X-Proofpoint-GUID: UgMf_fp0rNosNNeS-M1j-kWocZnmn-FO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfXxsPpYtxqClt2
 SEDGQ+te/fzWE2dBsVQ5hZSlttzX7DdgMtPBOd9SSQUoS2f4fFaIAPCE1CD+wLvHjE1xL2jnAa8
 wU/38WnXkBeUe9/PQ9wrCl0qEdQhERw=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae26191 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=yzYXBvia8gfhOsAmHUQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> target_base_arm(), target_base_ppc() and target_base_riscv() report
> whether the selected target belongs to a CPU family. Add the same
> predicate for i386 and x86_64, and target_not_base_i386() as its negation.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/target-info.h | 14 ++++++++++++++
>  target-info.c              | 16 ++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 4bc25789d8d..48206d01ba9 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -57,6 +57,20 @@ bool target_heterogeneous(void);
>   */
>  bool target_base_arm(void);
>  
> +/**
> + * target_base_i386:
> + *
> + * Returns whether the target architecture is i386 or x86_64.
> + */
> +bool target_base_i386(void);
> +
> +/**
> + * target_not_base_i386:
> + *
> + * Returns whether the target architecture is not i386 or x86_64.
> + */
> +bool target_not_base_i386(void);
> +
>  /**
>   * target_arm:
>   *
> diff --git a/target-info.c b/target-info.c
> index d9e15c939d6..32ba85691b7 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -59,6 +59,22 @@ bool target_base_arm(void)
>      }
>  }
>  
> +bool target_base_i386(void)
> +{
> +    switch (target_arch()) {
> +    case SYS_EMU_TARGET_I386:
> +    case SYS_EMU_TARGET_X86_64:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +bool target_not_base_i386(void)
> +{
> +    return !target_base_i386();
> +}
> +
>  bool target_arm(void)
>  {
>      return target_arch() == SYS_EMU_TARGET_ARM;

Same comment than for target_not_s390x, keep it local where needed.

