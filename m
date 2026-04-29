Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920A3FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDsK-0000r5-W3; Wed, 29 Apr 2026 18:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDsF-0000fV-Cm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:59:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDsD-0007hP-EL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:59:19 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKcA9O434909
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TxU1Z3VAxw0yFKVs3Uca1CGZhb7bU6Pd3wWjvO2M7D8=; b=hcsAqqZKxtkOabq9
 VohsQCBngisST+SUi+PugHNzaq+aQkF39sVCDrxEXOwbptPm7k5QSYaPneEaIYXa
 88BfcsOGHXi0SE4b6yPveM3o9GViHHPMuoJDDVNZwoAGIHRyHZ8pZmx+2pNyeG1n
 Gi+gtwIlLUskp9DDTXIIy4wi0TkwSUYGkkSPPHDRdSsKpINJMIcXhP+Rey1Nvder
 DGTKCQ3lF08KRc863+Jdwa0tMOTZP92MHLi69p5oHUqyYTo9kJ7VV+c3xZ9ONWg+
 5a8OaD+8rb2n86ih4kFVJ0aI8SM+HkPy7XO9Y2tWy3upJTGTUVDQ2dqE8QpxbqIM
 o3aADg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxcvah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:59:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2d93379001eso1279288eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503555; x=1778108355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TxU1Z3VAxw0yFKVs3Uca1CGZhb7bU6Pd3wWjvO2M7D8=;
 b=OzQ0yM4LQc19kjrEWWTKHc5TbclTPHaet4Q7r6q/PYmHK94Vo1usHWGzxL5wwLfNEL
 oKCTQuCN3kIJWmg7GqSaq9J4/s1XpdTg02u6V60rcuefKuOx8+haRI9dG3UXeWeuCziu
 hzYxwPikE/WpM3s88UzrOdKYT8pl5DbM0rvt2zeBu4BBplc1i/hD8AwkWjbrcNl6NGst
 dR3aVmL/b87XVGgT9jtPutc5HgGZX/P14Z6gqdax4VuBPtoUHjFKT3H8jVaSXNdrZQeo
 mDOssQGNX5oljDEA9CpUcsQBsSTnqSvYrsL7HQ0Fp1FVlFuric7ENtZgJt5qPjmSnKYS
 ywqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503555; x=1778108355;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TxU1Z3VAxw0yFKVs3Uca1CGZhb7bU6Pd3wWjvO2M7D8=;
 b=WeGs1qaZjvn6WBmABJeU8QLAEkiWpUJcI3tOk+O5oRRPKDmQVQQEzkBmxlvmgL0t78
 9JveElUoQu99dE229TXpIYY1bsT04U+vzQrh9rmXcdY+OBJSXeMvGjODnzXKv9NIPQ7s
 ztDUvLuxf/n+p6aAjqyzphQixdJdX1aSuM0wwjEaPJ3i78qac0mofboLtzIIXjcVxGze
 bsFAokOHQw0r+8UmHCunAEoLd//Q26kJ0/avD3HJ/j47K3x+GblKnwoL0FUWn5EgG/34
 dN7cSjMespR0o0k+gqLVlJLh0JkmGajyEUn9RktUeGfJfTQqJ4cEo7pNg0iahVRjIGJU
 KGPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/inrqD66CB64FVoD0VeiteTGufaqHZCw/Tpi2XbxLWnBHey8tCQNz5fIIDvHI4NSZaFD0oHkWKhWRE@nongnu.org
X-Gm-Message-State: AOJu0YxY6jvv9EFhU+lVmUOHGfmTSNzRrVb2Q9UyAT7hHbESAUHATRmP
 ERjB+LLNOjxP/2KOKC+3h/CqgKWE6IAMEsPG55YfOtX80txb7FZyyGhLCDSxQjYZYZ6bAH5bxrR
 s/2iy17wAyPeAYWyWDM6Eu+jT3TnxVoFlB1VV0Ets2a6Vg0kYRaW+amzxJVJ5qgyvXGQb
X-Gm-Gg: AeBDies2rNHgjPEg9WIXEH2teom2qs+CJshm5pzzuT35H8Ps8sm273sH2NeHruhXJqH
 33bB3t85jp3rudasI7wFOYu5LlwcJXsJ+UwmVF1X665O5+mwzs1D94mSt2pUDTJsyCtrEY1+klM
 g9bCHAfTMv73SQ90b9hbLU+wxIFQajfswToLyup1SKNSQO+XYjKETB1WHmHZslg2bgYV3Pw1oIm
 VgYMcV2LvMNx54aM1HsQhJhmAp174OP9Kz/qAZVVUlcPkKEKtj2kSTOLeAuL7QakVnglnWHGxHn
 oUAgRvJvzXpn+beEKo+UkpyLRt+ySJJsOomFiXkBSLz+WufYZ20CBioKyTfzUlFOR9VVg+rMaI1
 RyKkhRALinbs6PEbRhKqmWM/FJNHIpqh84Iko8Y8JWbdw6LA+eBKYm6ZEO5EsLGenk8Q58A6U9t
 dtHQEO5O8IBN9II+rDauWXM5rt
X-Received: by 2002:a05:7301:2c89:b0:2ed:e16:6b4b with SMTP id
 5a478bee46e88-2ed40363190mr111666eec.33.1777503555041; 
 Wed, 29 Apr 2026 15:59:15 -0700 (PDT)
X-Received: by 2002:a05:7301:2c89:b0:2ed:e16:6b4b with SMTP id
 5a478bee46e88-2ed40363190mr111653eec.33.1777503554519; 
 Wed, 29 Apr 2026 15:59:14 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed46afda3fsm289965eec.30.2026.04.29.15.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:59:14 -0700 (PDT)
Message-ID: <26f9e3b8-352a-4eba-a4f8-5a0bbc8e945c@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:59:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] bsd-user: Add FreeBSD ioctl type definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-7-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-7-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3bVgawa1pcjFaqcM1JtIbsruP4MMSZtU
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f28d44 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=igV55USxk0bV0TlUbZYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfXzoqw16se1aGh
 4i2JR0WSl5A2O0hC2EWCOvvz/wiMNBw0UIc2h7u8y3Tzyx1UzBVXZQGEAzIbkCeTRbw5ISaKkuw
 2yJHbaJBVdFPkojhD+L3c0U+LUWmOqnGcrAPvvtJxXzeNAloCHC7xq7KJgOPsRDOVh4mu29HS8e
 bWqJUoRMCtA4lpSyUuNFyFHM2nKZtVAmYMTn7ahVRXjSsJd1RwYvEicQtQqGg+XRYRT8jjmuZKa
 xzLM3oE7um/zUM2VggakDIIcpXMMaorntF9sfn7HbtlzoMcZvbtdbEtQ4rubEFy4B36Tgu1LtPe
 7w4ZlPANWaW2Gej2IFhj1P20UukgRU3Jj+ZRGcXwPtcIZGSEfmkEjRoesOrt+S6xF98iBG+HKaV
 yYYW9TRkj1MGhuzkQHTyPxO2NUQSJtXSrMd8k1lX/syMAJei6lcMlEFyysa/hMRq0D87lNfB86T
 5XyII/Eip7hGolh65PQ==
X-Proofpoint-ORIG-GUID: 3bVgawa1pcjFaqcM1JtIbsruP4MMSZtU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290231
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/29/2026 7:45 AM, Warner Losh wrote:
> From: "Stacey D. Son" <sson@freebsd.org>
> 
> Add os-ioctl-types.h with STRUCT macro definitions for ioctl type
> registration. This header uses multiple inclusion with different
> STRUCT macro definitions to generate both enums and type definitions.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-ioctl-types.h | 104 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

