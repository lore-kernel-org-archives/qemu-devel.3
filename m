Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F0606EFC0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EJ+pMZEw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IM8zSs8Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIpmC-0000fz-Jn; Mon, 19 Oct 2026 11:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIpm7-0000fF-Hc
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:59:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIpm5-00073Y-Qm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:59:47 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFPNLC2816675
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dSXdnyxNi9Gyju3VUQ5yak9ya8kuc2rxSbDxaLOnzEs=; b=EJ+pMZEw65JlA+k8
 q/NitlH1+9sjLBBl8v5MgQf0KaidjFrvVtQjAvypwjawI2ogn8IrYzN3oVd4UWjO
 9lhrj3lZ0Xfgga2AhpOTJ8aaZWnXdiQmrjxw9bOTctiULhIDHQ7L3NnpxTT83EWk
 cEaso9FS/BB06XbztXgm+VRRJziSrXH/IOIyelbLpLw7QxEDXQe0q/cJMNVm6gqQ
 q5Vs7/XuAD/9MEEjnE9s5M//+s/QCarAktWiILVcS24r2GADhpULBNyZJ0groToo
 DpQ5kao7pzTFC0Kh8iJJ4m4+0dvXjj/CULy3hKzvSMSafbxu2GJ5LjmvpJY86JBe
 E9RXaA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfgukk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:59:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35cbea41088so3877293eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792425584; x=1793030384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dSXdnyxNi9Gyju3VUQ5yak9ya8kuc2rxSbDxaLOnzEs=;
 b=IM8zSs8QqBqOKiPLY7uBZD82BTUB5OVD4neBynr73y3wD9aT/PodLG5Ok/g2q1ffNc
 Lo1Cu2JYqINpJb3URKaFYtWvyq+6Vs958+YudL5zy2Ip0vpQqxcGUvXsxU0avKht2APc
 3JhtUli0brRROTyld33aiTQ5nf+OJrkGXAGb65TgoWM60AGIoAswRSV6NGBhD4KA+WUS
 X1zRwHKPunfjiaPSOUspmJwc87FxvET9paaCtZ4vSIe/kZvf9HvbxzVlw+Eg6h2G82eD
 gx04ntueZXPG5dsZTGM9ASdXG0o37lj6wg/h6NypU40BhtGhio3+XljuFPRG1cHnsbah
 +nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792425584; x=1793030384;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dSXdnyxNi9Gyju3VUQ5yak9ya8kuc2rxSbDxaLOnzEs=;
 b=kup52BCYdfpwjB/zAlLC7m92cZBhzZZFvV6mnP86963EdMRzpap4p4OmcKVw8GC9T2
 gpyaiqJqOm/rmFMUtr1zc8kEgYO5KiybqJbtvW5b1xQb5iP7gc5noruHyacdQfMDSmVg
 7C//iCXZ/rOCjON7Ajy0rSXX30RbnuZ77u54AVWZJgyhupmDYDPGwnNqSlSBv7KWeKmp
 GvbPzBvEyo1B5xMQU3ZgQi5kuwAKh9RpcFaLwzz0cYAq4TnNJDUAQjguCmgcwGX+BIKH
 AS3774cZJeRRU0GhyebpIQP8wcBgGQO76baAY/XP4HqkWe0xrQqDgHuiM37SqY8DQfYq
 lH3g==
X-Gm-Message-State: AFq9FYJiJabfk6dyOxf0XAqIzrjocTStSFUZMXstdVm0iMOV4Gl9voLk
 LA07sagaEGyyybl0n0E3BaAYN46kIVrxs+QTBQHu+TKj3Z26xlu6R2ql3ZffgGJHyswjTrYIhXZ
 f2VddQYLsYe7I0cIgxjrud/1hgxFKi4bvAQ+ztOyafPqDl8WtfRVB9qCPXQ==
X-Gm-Gg: AYBFou3zCVj2XJa3VfvoXTC7CJaMt7+YhNr1Qog7mCyhKzO6oQBPHSGZ3MJ5mmm0Itx
 W8fzMTLutyqbSUEE+LPS62hFVZVM2UaC/pMEWRbHrJ1FT5vQtujlTfbyPKq1W35K1vK/B5Zt2lT
 ehAI7LivlbCgZi/qX2JIt+ygVYW3/Deir7EHplq+uM8W4hzw1SjpOTDT5kllbzwOQfPgLKHV5R8
 ae4jPegGTPZkwlfqzmUcIuZjKMg9C70ZxdiwxRPZQ4QOIs7x4K3lc+tzcxLTeyaPNhZQzQJHNfr
 Eg1jbPajHc5dwqtU9Y/i5hpa62bSCQHX9BtDXeMxsGNSC8ugQQFJAbUn6mBXR6uRVP5i4k+piMT
 4Xxp7OD9H6B9R+ak0uMLKBb7FHgNouuogu74IdldCTyqMsqS/B5ERrOo90MZrJEM4si7Ttw==
X-Received: by 2002:a05:7300:d588:b0:360:58a9:2704 with SMTP id
 5a478bee46e88-361a1471311mr12491736eec.6.1792425583317; 
 Mon, 19 Oct 2026 08:59:43 -0700 (PDT)
X-Received: by 2002:a05:7300:d588:b0:360:58a9:2704 with SMTP id
 5a478bee46e88-361a1471311mr12491701eec.6.1792425582715; 
 Mon, 19 Oct 2026 08:59:42 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b684dsm33184675eec.10.2026.10.19.08.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 08:59:42 -0700 (PDT)
Message-ID: <9c7fb198-06eb-43ae-b945-bf789158a68b@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 08:59:40 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] tests/tcg/ppc64: Skip float_conv* tests
To: Eric Farman <farman@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
 <20261019151233.230172-3-farman@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019151233.230172-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: q-CqFFNWR-NmYLNHptmrroZtDEQtRd37
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad63e70 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VnNF1IyMAAAA:8 a=pqZqSU6Hjj0tBizNn4wA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfXyvgQtIAB4x8/
 TeWJdznUjzJfXubmn837NApkHjh79VnO4pLy1TaV/uZd2prkYzlIy/5vR61V9o18KfLGL9vo199
 83ihor8rEOSxbZ0XPPMKdyZB4XpCeZbr7S5OirEvOoiM0wEW/1NgVdjQ4shhEH9mxMhnCa6JUTA
 PNCATWKK92orMhD2Ce3VF/OarK03hLuIL9Q0WBZ0ZF6jTy7jl3JKDpJEk+a7LWtqPtjXteIJoML
 zxp4Qw9o9BjdgOiaRyrgib/1QSU/9mILUGRJrG0ZxDkP4rf4vCj5+kTHvkA8Gy34p6AqwRgr+Mu
 Sfpq1+sxbpxKD7rBzzcDwGffQvZ//Q8qCO+M/qz5d8rKV8hv/NvcCa3etAsIFBB1Es7+WfHn4fl
 PPb8g5vHF1Wx1UH+wj6olzQ8Yr3d8mdYXxeWFugPqQMFCXkE6HNGurFuD/m2suHFCoyqqZ+n2C4
 p1tAiVt235bh5xyYqnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfX1YYKKDQQ0Yg1
 htwevnU3ynfDDkmpEI65G/yz9KgWr1yVt87sMK+SfrXUdTBewcbEZtMvwUBUhwh4nzQMtRTcCha
 KqOvkdtWdUSgEGf5+eDf7agefjXRnMA=
X-Proofpoint-ORIG-GUID: q-CqFFNWR-NmYLNHptmrroZtDEQtRd37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190063
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eric,

On 10/19/2026 8:12 AM, Eric Farman wrote:
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
> on a laptop:
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
> versions of power hardware. Disable this for the time being, and it can
> be added back in manually with the correct responses.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  tests/tcg/ppc64/meson.build | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
> index 8cca4d65a4c..ee86a75c23a 100644
> --- a/tests/tcg/ppc64/meson.build
> +++ b/tests/tcg/ppc64/meson.build
> @@ -13,6 +13,9 @@ foreach t: tcg_tests['multiarch-linux-user']['tests']
>      if fs.stem(src) == 'test-plugin-mem-access' and 'wrapper' in setup
>        continue
>      endif
> +    if 'float_conv' in fs.stem(src)
> +      continue
> +    endif
>      tests += {src: setup}
>    endforeach
>  endforeach

could this be made deterministic by setting an explicit -march or -mcpu
compiler option?

Regards,
Pierrick

