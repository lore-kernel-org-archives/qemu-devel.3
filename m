Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396FE606A32D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kLM5DBmM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HOP/Oxi9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPODz-0003eq-69; Fri, 06 Nov 2026 12:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPODm-0003dT-Es
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:59:27 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPODk-00083C-RO
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:59:26 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6HtTLa1101012
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 17:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ca2LWgPJo42AdxTkGZKZukyYP0lfwUeuA3UfJnlGT3o=; b=kLM5DBmMyHeQOKE/
 h3rhmPc67k1aXllIZganTf5D0w+WFJVzDE1E2V12/tkT751U4D1UEkQ4vyc9kgQi
 VD4xOTouajBmKt2z4i1FPL/NNl5BB9J3nsigDTAsQwLs/M8Xu0WecNUg7iQB1sJ8
 6UKwhGO5YDga4JyLgxzsmwabXOgjWf9KrmP6T261NGUE/GgxAu6WF3IJuX9cvZJf
 55/fOmkGwxFhDstyuREdpLx895tEEytlWKxou5P9WaYff4ShMKk0jnr5wHY2e5ay
 7qsnJhuFZbAE4GN1lMFqPr5fuTSgmLUUaHr6HBXwZjaTdc95i4bHuEyR0phJB/54
 G6prjw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pav1d6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 17:59:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1634485eec.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793987962; x=1794592762; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ca2LWgPJo42AdxTkGZKZukyYP0lfwUeuA3UfJnlGT3o=;
 b=HOP/Oxi9jZdweg6M9D1Bk1FQMOIJwccn3RCOxtqiXQmJB4qxDvMXpgtAqaXgYrwchw
 5SpwonI1nlvEa3nyIJMOWQLtmE60W64Qhms3ZexFyWMxVBxNIYbIfGiF+scTgiPj4uQQ
 vN+BX5yS0qW7DYNaTOiG1rvQaxLfFD4pErvhVnEkpHgD2iZ2qW15et8x2r23uyWlmy06
 +giMfSys/BwzmfkxsalnqHUbwoAUZqHezp67tfhPZ5rAMy6Z4Xr/4SN18XvIzrEM7ljc
 FmuGAAteZDc9s0kxDKi24yA7tJVzCSvrZ9gSxXhmA6lwSP3C9wg3MLPX+AuIb4pYWc+x
 MGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793987962; x=1794592762;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ca2LWgPJo42AdxTkGZKZukyYP0lfwUeuA3UfJnlGT3o=;
 b=AghxJSeRfiVifGfviG4S633XPnbBCI3HUZUdVVPZdWKCMOAigWnuxl+7/S4xV0aRUw
 z0ZAmsII4DHgoEW8cfCdPct4SMOfYkemSeFOz71OIBvzVlgRRl9a2D5qVvc76kSAd2gm
 E3a8Pn8YLvhV7fd2193JALfVNBkPHeFKhCPE9AfuDELzAOLt4jpkg4re3SxBs7o4lZbG
 o8MwXTjlUYZjXzxMRXpPQYwCducDYuvcfdf4B6wYsulhg404Ku7M88AJwywvcPvxqlUG
 bp0CPuLhZ9iRhbeR9pho9UIzJKl+gm+S43RO89/iLApTnOeiY94Ec8ufpj8yAof60ZTn
 UmTw==
X-Forwarded-Encrypted: i=1;
 AL+hErFH7OeUhD1xP0q1YqDUyE9WudW6ERcLAzHflPpEIK/p/nkGEuLcXBLHFI2nuuaYEVUSh9EK05/PHIQY@nongnu.org
X-Gm-Message-State: APuU4Z8HwTxesmho5dYYjepjht15yGW00rqbaTT21VE/yvcfqAT73Ok/
 PXVMGwv22ygeZEXTCJ5iZ9kzWrRYI22EbhDt8jwU1emmv1vBFqOjO0AQPI0OzzoEWBINlXvWkPu
 k4an0Xbmf3ro2gAETD9Y21NfLv13uuNjiu2hzo+Sfbpe3JOXYWDLmbKnC2Q==
X-Gm-Gg: AYBFou3GvzkYOoME2jkxx9E1AX0hw+CWt2X3DXoOjVGTi1bb2YLQORnVWnbNhM+zjtI
 KYaE+Xc8khqX+nb4PKr+Clniwo2r9DFqM3sStOtEizHsUo8nR+SWrzqOWjnF4UE+DHRpWiFcehD
 /JZPHjXj0inFbFeLHiSsCDjWmRPUYM17ROTO30pIVJh6mrDW2eDUHoBbxWCBG0+O02zD9O1dYwv
 gZSGwb9dUYDFbA0gL9JayBCxNO4I/RwUWRyE8vj4D1OW1D2orbNMMqTMtzWkY/lJOTbBykQKf/R
 0HwAvk30lNCjejO74W3GZVS5R+p2mtDCIR/5U8qO1P5pbysc4G3tvRKwboPb/rv0VaYIxzmgzJg
 Ot5F64P4qGUYDmfaA5cFTtvFscTdQEAfSoK1M3+h+mJWlMFj1o9rncNOm+spCtMpzwOtndRxk2E
 /7NbfdxrAaPYGSwJokBvN5SSJqBv3a00ofMYWgM7D6pw==
X-Received: by 2002:a05:7300:8807:b0:36a:4a68:84e5 with SMTP id
 5a478bee46e88-36f7525245emr4799753eec.8.1793987962172; 
 Fri, 06 Nov 2026 09:59:22 -0800 (PST)
X-Received: by 2002:a05:7300:8807:b0:36a:4a68:84e5 with SMTP id
 5a478bee46e88-36f7525245emr4799719eec.8.1793987961436; 
 Fri, 06 Nov 2026 09:59:21 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8c4f28dsm7707429eec.9.2026.11.06.09.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 09:59:20 -0800 (PST)
Message-ID: <a97b0f72-fb7c-4f5a-bde6-b542056d6e5d@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:59:18 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] accel: register CPU parent only for AccelCPU
 subclasses
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20261106023936.772-1-luoyonggang@gmail.com>
 <20261106023936.772-2-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261106023936.772-2-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MSBTYWx0ZWRfX70j72frsPS4c
 MiPPsJXimngRUcA8EZT/OXRYvzmWIFmbJ55Yk2TjKAcON25Dwp/7Hiv2jn7hjwmUKbi4XcC9Qop
 rtC2ZMU4d5KPe4r04otmE8+xnCyIaWJZsOUIj4faTIgfoOJYIBe/WHJTWnGYZrYS3h6c75CBaxp
 9v2EXthNGR0erAHWTpyiBrb2ji+MTm5vRk354jSMLYQbQm5wyk6GxQw/6HHdjCJMdoFWVW5Fytm
 ChLTPDoCx4qWK3l2sfjBTxkHUkqTLCybOUK2IQtysB3/2oCFnjEO0nOWTuCvRzISkJeEjEjyZAH
 uXo3LbJlw4wFhUxD5A6sXclOvCztCz0DEr72eqOJIRWpVBvoagims6q3+kjMtNYvkUP4y1mrv2k
 uGAX1Yh5mI5vj3pPYxjOSxZpzwx/eZiaE/8ZrkjETYhDkItESK3OZRdiby6mejKAdO24QALp8Xf
 XhUgRVLzwxAR94RvWPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MSBTYWx0ZWRfX0jNiRdyuabiA
 sM374ajhFYQrdB//OWWYN0uCsIy9fQhaQhO58xXFY89IRRPNM0nmUFH28WmgSYCBl1W6/RPbr1u
 YV+cYR2QzvlwSVPLv+T1xavvzl5Oukg=
X-Proofpoint-GUID: 9ga2LS-EhkL2HDG4JwOLNtrGLd_j1JRw
X-Authority-Analysis: v=2.4 cv=P4ivFSAu c=1 sm=1 tr=0 ts=6aee157b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oLONm9El9VE_NHCh4NYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 9ga2LS-EhkL2HDG4JwOLNtrGLd_j1JRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060071
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 6:39 PM, Yonggang Luo wrote:
> accel_cpu_register_type() creates the abstract parent
> accel-<cpu type>. A subclass names that parent, and
> type_initialize() aborts when the parent is missing. The old
> type_init registered only target_cpu_type(), which is one name
> in a multi-target process. Call the helper from the CPU type
> init of each target that has an AccelCPU subclass.
> 
> ARM calls it because whpx-common.c parents accel-arm-cpu on
> aarch64-softmmu. i386 calls it for TCG, KVM, HVF, NVMM, and
> MSHV. i386-softmmu and x86_64-softmmu each pass their own
> CPU_RESOLVING_TYPE, so WHPX on x86_64-softmmu finds
> accel-x86_64-cpu. RISC-V calls it for TCG and KVM. PowerPC
> calls it for KVM.
> 
> Other targets have no AccelCPU subclass. Machine init looks up
> tcg-accel-<cpu type> or kvm-accel-<cpu type> and skips a missing
> class, so those targets do not need the parent.
> 
> No extra tests is needed, as these QOM types already be
> tested by the existing logic instantiating all QOM types.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  accel/accel-common.c      | 6 ++----
>  include/accel/accel-cpu.h | 2 ++
>  target/arm/cpu.c          | 2 ++
>  target/i386/cpu.c         | 2 ++
>  target/ppc/cpu_init.c     | 2 ++
>  target/riscv/cpu.c        | 8 ++++++++
>  6 files changed, 18 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

