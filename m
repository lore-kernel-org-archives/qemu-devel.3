Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCC606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OZKz2OjJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DyzMon1E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAaR-0003aw-Rh; Wed, 28 Oct 2026 16:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAaC-0003GF-Bc
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:49:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAa9-0005RR-Vl
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:49:16 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPDA62969628
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KPiLMfEuY9N9FK6Ioiqp9e8AHt0hBtl35Btg8aT9T94=; b=OZKz2OjJsPEgWcSY
 rCS+cmLjaxDaUqcLYUQmz21JL0ZOdI2tWUnrKNR3Hpz6M8bv52BaC1J2Zip4SMm6
 Mskog2kubNylVFDiliQ2ym7PwUzPfF54qKhB8Szs182zaDdzlFJACb1iRdMRZtjk
 slmhqEipCrr35zRBM/agIU324TSrlYM5yLhgk1Qed3c9sST/GIQGHC2Q7tfPVzKj
 3t9jLHT6R+B8ITkzs3QbfAgzYAStJ6xtuvieOYot5TwiHYZHDC5WJPy7IBR/NBS6
 abouQUwGVjNyG6/QCGbbADhqxX+Yo6YFiI3gOn3ZSXC5UM7ocQJBenxbzLWzbzd8
 c447bw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehseqw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:49:11 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so4010620c88.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220551; x=1793825351; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KPiLMfEuY9N9FK6Ioiqp9e8AHt0hBtl35Btg8aT9T94=;
 b=DyzMon1EF1xrPvzhG8Uo16Nl5N/4KVRHIv1ONdWJN4dSsgjdkTQsfhcL9mDmnVWMb+
 aINXVCuXmpdl8bEhBy1nRwgr5g8vbjlalkOicUIwm8yxt+JxsPlTO7z6C3PWynpWKCQT
 G8+AZ+ZG8+pILvCZ17CyPbjNAQaQYANVXEEfltt9UN71gtH8WLOvw59wKPOlko5k2I2a
 STazg9XzSLNjTUB1YA/l56S55set27aJcA+KqZCjJCLBEiKjgEifXdw/gxOXPICGCfmu
 nVizj0pXj5ElNHDK7JojvDhyiZaJWymCvxoLs2jbLUoGhAPdDfl+vgYxEJv/4hYvjZwR
 N+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220551; x=1793825351;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KPiLMfEuY9N9FK6Ioiqp9e8AHt0hBtl35Btg8aT9T94=;
 b=lGVD61WjXx1BGUfGFkunf4fkeDVgIoLfM0sI+GJsILHzQpDx17wLGa71Q4v8G6PGNV
 oStgjyVDJZ3TALwgyDL7kdmRhc2CXkH5eHCl2z3kYbsWRyVGGBPYjhiFvrCtAbBJLoWT
 TWGVf2TAd7Bnp5Dd1me9RRsk8ifGqUElbQxixV2aX5yYV67RVY8Cnuw5EaIqc/vRpnRj
 DjsJhkhrN4Ih8pS0/tKC6nm5onVtwRTwcZO4vAaGyoQx8BCCwGvrZRq3XNCxax44T84o
 faJo+AS/PsHKx8h8Fax54F5lgO439MmfasglqXoqgBYu6Z4L8T+ya6VbphqaCq5CzV+O
 Dy+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVU6mVXBP97nu07H3hrC70m8fc5T4Qysv7OnqlS2ALCsfWR6o68Ns4Fk093T11YgAU436OTHtpvsWG@nongnu.org
X-Gm-Message-State: AFq9FYL0Qpuc3VIvgMMDFoDWV4rp2EcnOw3hoGKIZuYnGgLpgWBl+Bw4
 GQiHfrGNuVGagysp2kXNZzixGsbyMwITYojl2NlcpwDz3XrbfvAsloG/cXZJWL7xMfrqv1RkZB7
 sG2M6LhuIeuI8jZMr6sbLlSBlJo/TEJR2FXpb7Ted2YMBNSAao39zf1tsLw==
X-Gm-Gg: AYBFou0EKPp8mrcbAUBm85GYmP+0f1NAxqEa+6yFImiuwrRLhEAiEue2Wl+TsyCR3w5
 T7VuqjbxvRQqXOziNFlL24TEFpX+IP5h94bDG/UoPlxuU0msMNNfgq+PxvIo3SPexGvaXs18lYQ
 HKMH9o14Uo8+vuq3kJFlFuudrhDsZ46KG07MtG1JYeoO8fHr5P69ZVSdD7i28fJe5djpx5rRoJc
 IXGlQNYEHyGDAOfOdInqs6lj1uZcCtun3sW0viF9K/pK4LLLuvlDDcFbMKd3QIJ47ZmHh45777k
 yogdk48qrYMIZuylKipOSp2kBvLdICBOw9aiyigQrIr/dfaxtP4RMTbvR6yVqyYu+LBUQPxWdxn
 IcrEk3eIEtFp7orxd/fD28SPMtY4tGTMFAN4fgDtgSZNaN9TsnxucECyqo63ZZMer4fU7PeLta/
 MOhpf55abWtKXgx7xRdIGjeXkUyJ7Xt/lu6g3j3CWU3LI=
X-Received: by 2002:a05:7022:ea45:b0:17e:ee5f:6715 with SMTP id
 a92af1059eb24-1a6cdb52f07mr4327236c88.27.1793220550748; 
 Wed, 28 Oct 2026 13:49:10 -0700 (PDT)
X-Received: by 2002:a05:7022:ea45:b0:17e:ee5f:6715 with SMTP id
 a92af1059eb24-1a6cdb52f07mr4327207c88.27.1793220550003; 
 Wed, 28 Oct 2026 13:49:10 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d85f23dsm6901679c88.11.2026.10.28.13.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:49:09 -0700 (PDT)
Message-ID: <50baca42-5591-4d9d-8071-07ef3237fe2b@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:49:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] target-info: add target_not_s390x()
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
 <20261028201557.2688-7-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028201557.2688-7-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1hy9p6A7peKKqPrAdTJsBvgDBz68omH6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX1tu9E+z4zN87
 xsUbJaz/tn0padzmD0z5aOagvOPS1EDd57Cpbv/4PJBcIOQGu3Tg1uHoop4RkW9Kdxk1Qxj/0or
 qDiMW3obf9OQdBl77J+2i6iS5+fy1NRYj8a8lhQxxmb3z6AtDJvOJuUH+dw6GbTwuQCt98eyA3K
 QkjZL6VoBl/LKVdyKnVK9En6kKm4GFhnwXhYarGikW8uQRkIEp4Z9TAZY0Ye/TM4a1rxadon9G+
 JjXIMxp+ZRJopHVbj5RRwRXKGwSqxMX2G6G0D/BZHaS7d/SVb/uYaz86gCdHiTRkGta2BHtVTaL
 RdbfzLtM/3NW6k+OcDFhtA9bio4+I+41UANn7U56d0CtdP0LIcBrdIEJAYTnhMWaZMYHsspTpym
 SvRl97yfVDW415UobV9uE5fyviyN8cMG0t/q6BLwEv4+K2NwecRKtrVup8ENs5xGZtwkJvXa2u9
 a8aW8zOVaG+1y5who1g==
X-Proofpoint-GUID: 1hy9p6A7peKKqPrAdTJsBvgDBz68omH6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfXzGJ3cjIb+QUC
 Gg0vqbAp8JR1zoBemre6NoNMHHx7lj1gwiliPw3JI2ArKSfnb8TL0IXX5SqD3F4Qwndz4jWS1Jl
 ZUSveJOk/6psey+Q4Ksyo5sBIGt+zu8=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae25fc7 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=cPbV9nJD0Ymvok1AWO4A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> Add the negation of target_s390x() so an is_available callback can
> select every target except s390x.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/target-info.h | 7 +++++++
>  target-info.c              | 5 +++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 1d6c6f4472c..4bc25789d8d 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -134,6 +134,13 @@ bool target_ppc64(void);
>   */
>  bool target_s390x(void);
>  
> +/**
> + * target_not_s390x:
> + *
> + * Returns whether the target architecture is not S390x.
> + */
> +bool target_not_s390x(void);
> +
>  /**
>   * target_base_riscv:
>   *
> diff --git a/target-info.c b/target-info.c
> index 07dc88fd366..d9e15c939d6 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -126,6 +126,11 @@ bool target_s390x(void)
>      return target_arch() == SYS_EMU_TARGET_S390X;
>  }
>  
> +bool target_not_s390x(void)
> +{
> +    return !target_s390x();
> +}
> +
>  bool target_base_riscv(void)
>  {
>      switch (target_arch()) {

Let's not introduce this globally.
Instead, we can define local functions where required.

Regards,
Pierrick

