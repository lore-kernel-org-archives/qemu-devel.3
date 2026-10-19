Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826AE606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ijlvg1mX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yi+teNB+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xItzl-00014R-UU; Mon, 19 Oct 2026 16:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xItzf-00010b-Pa
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:30:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xItzd-0001AL-2b
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:30:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKLvH550480
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 20:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uFcSBw7cP0/x6T7fKOyD2rGsjTsBhxhuGN9Ak+bQMaU=; b=Ijlvg1mXjqzu80y2
 czh6XW9N4ftwewvAoco3d3T3T9D4KIqP3fIpys7pY9vr0L3KI23Ykr3vqcnTGMM3
 /ASjEe3nwqh4XousTGSJouooeIqlGhMS7gRgA/pEB/cC7R+c12n7tQ3m4dH3h+wc
 fOc5D9mBEY60gNDgEii3VANx5HvMSkNuXgyisEcubkJoCedwrUufQe+CNe4SIVxn
 LCmmNzO0ovGdy7Uo0OT0LBZUKnRcYRPjfzdvFgvm+qa9UrTMWU08drvo5di9iSPj
 U8rBauUZoe3qWQvgJ2z+sb1ZXwUaCT/l5TwBTlqZZqIsIiChhtLy3hnT/OLxxzaf
 Q9V7IA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47k6mj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 20:29:58 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso4855997c88.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792441798; x=1793046598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uFcSBw7cP0/x6T7fKOyD2rGsjTsBhxhuGN9Ak+bQMaU=;
 b=Yi+teNB+yPq1j1JMnhfvWdJ7kxzip/TqVTni/2IQroM1Akkhl0p60dW/v0T5IxI317
 5sohziloDY2bHrkFlDAqic4xQFNroBcrtgFJQpJuS5Wm90eS+/OoN2vCV46VyaJPhR7V
 Dt+4IcD53aPH/vo0NvXgdXpCidpBWS4vLaGipJYga+JhcRBTN7XB0EMRYqA4Ud7rx2Fk
 Wd3AjUaRTIhuz/nlK4vZ1uoOHbuq4vvOUA8oUCM2VhnyTkFd7S2BxLPIptolAsJr4geI
 DB3NhRd4MhqOGeAvdzfTirLGu46kE7IdjieUyY1kk64rsrhXQ45D8DCLdUrLz3qSOp5M
 mYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792441798; x=1793046598;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uFcSBw7cP0/x6T7fKOyD2rGsjTsBhxhuGN9Ak+bQMaU=;
 b=KyPk1X3wdgQiA/fFtnU+B9+1dUJfogqKMZizeLhjgZH8FPMGOLcplNuKDkPPzuILIW
 Fyh+RD5p0XWM0FlXt94KDtEFQYB2STapKAWU48MjPZX5Xs4w48/0QkBd/Wkh57GLdCph
 7MSvm8csie6rV0WoqXdH0B/KmH1VyxKp4t0+R4QL5CsDbizskknHTGSfmWlahsMMC7gC
 ulR0PVkwNSOeqc4vLTyHGtI6TCUx3ZVOlQu/IKEkVetj8+lFNtnxRw6QtMu/gndLDTFZ
 G2pwV5+trvYxR/9zzF6R0ObIlod6nuziAPdHeQoUlP1ZL47Fi03SDAq0GHhl5D3WYdR1
 5teQ==
X-Gm-Message-State: AFq9FYIPze0oeX5zroHxaSf8ld5flL6V8nL+/MsyVePlmf3RMxxFtR0e
 pgaf/QdGz9Z0hvOyMuMQ9NVWxUg/XmPYVG6Svkcq7oHOZdbfY5mMaPerpihi7fS2RtJQ+h75PRM
 lhnM8YLI7E+/sldfP/RFNUEK85L7ROY67VzQm+MEbK8vcStf+rUIynkmXkA==
X-Gm-Gg: AYBFou1X9755Xsn+dCKMaGEY0R0zJAwD3VSpDJNn+wOhQlPQ/xDVYCJpNePeakafAyB
 NVZFDR3exy+t1Zy/UA/g4ImLuWwJRkbrLGVMgs8EZLqEcNhIqTPrTFM0AoBHq2ynGa6gtIcrDdA
 DVYrt4+9OMwh9LeR7YoYeLXs68Fjaxg6Bf6JixslIFNg5vsU9nlQXXw4Y9KyCJC/TVQGwgODEDg
 pv2zp4ujg7RHkk5/dQDCSn54McIHMlOhZCLdxZ1Klqc1JH4LRa3fBed2rerWJlbK+INVLAJFIzU
 7Iu6nHEVLMOXz5rAC2EvkvFFjEiWYRqRtG4Bal8f9FrWm8pfIbga7mXN0CZpgLXPvRGOnyjRULb
 w9AQMM+dAeWIvYa4aY8bCDVcB2Evy8+x1U8KvKt12WobWZTxvMYgj2h6iaFiwjMNWG0DLEw==
X-Received: by 2002:a05:701b:42c9:10b0:14f:b5ac:ace4 with SMTP id
 a92af1059eb24-18513e79fc1mr13586473c88.44.1792441797389; 
 Mon, 19 Oct 2026 13:29:57 -0700 (PDT)
X-Received: by 2002:a05:701b:42c9:10b0:14f:b5ac:ace4 with SMTP id
 a92af1059eb24-18513e79fc1mr13586410c88.44.1792441796368; 
 Mon, 19 Oct 2026 13:29:56 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm29511060c88.3.2026.10.19.13.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 13:29:55 -0700 (PDT)
Message-ID: <cee46a83-aec3-4725-acaf-e52d16e327a5@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:29:54 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/tcg/ppc64: Run float_conv* against power8
To: Eric Farman <farman@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019185600.2031729-1-farman@linux.ibm.com>
 <20261019185600.2031729-3-farman@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019185600.2031729-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: svoCMubtRNCT0I5-votMNyqhZ7a_ehmM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4MSBTYWx0ZWRfX+ZtrqcvtGQTH
 VheEQfDyQPNMnaQnr1pRvdXipQCXxFn3Eymo0vvJg62Z/Iyok/1V8bK7wHOOFCFfQEJCCPbm3p7
 c8BNVRpjwMtAtEEcs+SX3CDpChnawtF4U9bpaogRbQFkmLgMqnSH4DyVj4UfTSgOoyQQ4TKio7h
 R4NIGdW/sKbh6CAIRFFTIm3NlsossT8R2QnU1UZ9J3bClBvKBVGzDVGPnYLLcJ1qAJ6Q+uIEy7p
 ZIDgbVFfgSTV2Akx2j5kxLNjnjN+cD+dSdFjDWJx4ZtTn73TnkL1Wqf9HUaYPbv7qF15ZJiQvot
 +6bhjqk2lixRxteoOmwvZnrNIHUjb/rdZf0Hf5neUKDZhuJI3wvr3ayhnbe9T1G3FbXCrvjcJfT
 DReudE5gTZVqqSYqpCuf3HKkb+o1hu4XmCYP+hx53cXhobGIjJXh8qHUxDizXy3rWtC0W22b1uf
 6Sqg8IrdIOh/BlvEiVg==
X-Proofpoint-GUID: svoCMubtRNCT0I5-votMNyqhZ7a_ehmM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4MSBTYWx0ZWRfX8HLixuBwx6Ve
 PAO3bhxkL5zCFe8knCWTJseztsVjZtiOrl21Ta9chNOqRhJ0RumV0sZgBVR35Tzu0S22R+1Htxo
 6djiQ5eAmaEe87Da54j38v+2kcdp558=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad67dc6 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=us5S6Rm9lLuFFzw-OnYA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190081
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

On 10/19/2026 11:56 AM, Eric Farman wrote:
> There is an oddity that turns up with the float_convd and float_convs
> tests, when running from different toolchains. As one example, the
> expectation at the start of tests/tcg/ppc64/float_conv*.ref is:
> 
>   ### Rounding to nearest
>   from double: f64(nan:0x007ff4000000000000)
>     to single: f32(nan:0x7fe00000) (INVALID)
>      to int32: -2147483648 (INVALID)
>      to int64: -9223372036854775808 (INVALID)
>     to uint32: 0 (INVALID)
>     to uint64: -9223372036854775808 (INVALID)
> 
> But, other hosts offer a different response, e.g., this debian guest
> on my laptop:
> 
>   ### Rounding to nearest
>   from double: f64(nan:0x007ff4000000000000)
>     to single: f32(nan:0x7fe00000) (INVALID)
>      to int32: -2147483648 (INVALID)
>      to int64: -9223372036854775808 (INVALID)
>     to uint32: 0 (INVALID)
>     to uint64: 0 (INVALID)
> 
> The explanation seems to be a behavior change when compiling to different
> versions of power hardware. When building the arguments from the multiarch
> directory, let's ensure these float tests offer a deterministic response
> to these NaN tests by explicitly binding them to a CPU architecture.
> 
> Chose power8 for no real reason. This behavior change appears between
> power6 and power7, but other tests that rely on a specific architecture
> today pick either power8 or power10.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  tests/tcg/ppc64/float_convd.ref | 144 ++++++++++++++++----------------
>  tests/tcg/ppc64/float_convs.ref |  80 +++++++++---------
>  tests/tcg/ppc64/meson.build     |   6 ++
>  3 files changed, 118 insertions(+), 112 deletions(-)
> 

Thanks for the update Eric,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

I'll let you pull this as part of ppc64 subsystem.

Also feel free to pull patch 1. Maybe let's just wait 2-3 days to see it
Richard or Paolo have a specific comment, and then you can send that
before the freeze date coming.

Regards,
Pierrick

