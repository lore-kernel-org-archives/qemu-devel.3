Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7FFCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCOtL-0000OY-TW; Thu, 01 Oct 2026 18:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOtH-0000Mk-8H
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:04:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOtF-00026H-FN
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:04:34 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsPVG2267761
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9VDv496lnuGB35Es+Ee+OP4oh+1bsftr5grRpHrT4v4=; b=b5QtKzzEsiU8cEMs
 rGwY0ZCaMv4fWnBwUPc+YRXVLPrI36YfnabKnwsdfdVAMQ6KIntHi4krTr0aIPep
 2CwrKlt9/1R5n2xuXDUmMWch7RcRg4yvRZVC3qT9jVLbzN07PMA3btej3eIGfB3n
 hLVio5gLPKMHzyteGxntts8k3qzg08qdGXWhvROwQTYpCrVhEOSB0AvO2AKpVfwu
 /rYc9CP9VFHZdAKiTpbuYIUa7s6Yn5/jossFQtMYooM2oJ/qi8hGd4oXlWEvkOF7
 HhFSaJV8lDaTBTnLnd9g4KBSsba8wvH1iZPTKUrxZz8jDVnjmkIE9NBP53BmVJO+
 +YRteQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1rvqa3w1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:04:31 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1438492fb40so4951347c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892271; x=1791497071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9VDv496lnuGB35Es+Ee+OP4oh+1bsftr5grRpHrT4v4=;
 b=PSm9xQNm+g0EldbdT0M9b39gy8QnH0lqtXGXKSlYzAxC9YW5RDkYsrrHyh9CgSZuEj
 GCesQcCnxNMYBJP5/TRUIAyaUEG89MOP+0fpvkKoAG3zfCDQzUVY1sMl1rQ1Ips+Db6A
 dafS6cdWQtbB+J5KUh9ftOpaXM+L9QbsM0kNk0ZHC3K8mkZffZ4eUvJaR3q/yDmnzNcI
 tYLnDYukuXweA/hqXC77nEvVVfj17EUsMWewKwfNGCPldmy+pWXIDnGBP9EESV+aCqIy
 M+K7K3ugPekAEQ++L2Y9TWTwk2YyhE/af3KTHv3/frsiGy0SGvcEu3ViPbMtdtRkPKP4
 oJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892271; x=1791497071;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9VDv496lnuGB35Es+Ee+OP4oh+1bsftr5grRpHrT4v4=;
 b=0FWvMjYPI12dwu9cF827DF+qVdY0xUuE5j0MtTA3bnozS6WF8e92cFjAW0sk3kzoKc
 vnrWijzQVWVwXYzdWakrbeaSB2CS+ecOfjt0bLl7K4Fv5f+L2vnIKUs4xnj5ZrRQA6c4
 OdH8ofXfTN0LuChDemWUXuwHQur3Ah/lg/E31RCnoy4rsYfPZ7O/3lPfDRX0Mx+Wu+r2
 I4e9Iyv/NNQYHvOtFMm8PN+kA9B8GwUlK2kV7eaHk3kn1CZap+WbAYJWULe5v8HbZCXh
 7fMiHBG4PHSmKdy+qz21/bcgRxv8Q6HC+CSHncEvTF+wFcSnUx4S2iUz5PrO5Ne5DT+N
 2egA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7tkV0Bmn9Hxi7PSSlw8DFGNJiuq+FJHTglhwhrtIIqdIRkOa8Sy8MSa5p+Ptn8usn8EPeC8BlG+ZI@nongnu.org
X-Gm-Message-State: AFuF++kWvV9Z+Cvsc8jy9nCtKJK4lQoObBKf5/0oPmRDIYhH6zQmuwa4
 bEEubxm5DjB1AVIh8MyMi5aahuV9aY9DbNLGUUAMVHussFU8j4peNobPUeFlW5ZkMkIlaSGCJnZ
 AgzydgqtPhG4M0TD7ogN7xDui1bJsG6cscOXKRlzGUa5IrogR1P0nGfl69w==
X-Gm-Gg: AYBFou0QP3SkhHCDCD0Fv3cFKWwPHR2ob8zHaEU1KwRdK3EXg0OVVQ5V/M6vY53AL1F
 FywQNG2teLZRXVs9aEDb7meE+TWPBXWGR1wf6T79IaRAhctdZwS5gXzAzWFRw2QqWgocB9Q3p1e
 TS4i76TJygHDORB1OJmcROMemJcOgkuHSeO5IJsedQs09pm0ar+d8opuPxfKVRz5XbtKhb6YLcc
 UC4yR8DIwXI0VSDvhKjWgEkmIpInro8IhxcLfHZhZP7WKuyMALUQBavH3Nhvd8E5sp3QH/RiZZS
 nT1CzPetV8PGQOMApyoF0AvTTSZ4x+17LxBvvva7jRfcg9EH1j4qZxgMvv60BTlWWxAUxCanJkf
 4OcDK/oQXEQgZcLj/+YWbF12s/5MfZwL7hY6wrAnr+bq9olSfAwZS2NZtRYVTsB4u1VIkvA==
X-Received: by 2002:a05:701b:4209:10b0:143:3617:c595 with SMTP id
 a92af1059eb24-14f590c9c32mr615754c88.1.1790892270689; 
 Thu, 01 Oct 2026 15:04:30 -0700 (PDT)
X-Received: by 2002:a05:701b:4209:10b0:143:3617:c595 with SMTP id
 a92af1059eb24-14f590c9c32mr615721c88.1.1790892270038; 
 Thu, 01 Oct 2026 15:04:30 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f46ab87bcsm1191980c88.9.2026.10.01.15.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:04:29 -0700 (PDT)
Message-ID: <60d3bf47-404b-4733-935c-9cee2830bdba@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:04:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] target/riscv: Widen CSR ops to 64-bit and compile
 once for system-mode
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-5-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-5-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX9RxlOBsfDGEA
 /T/tzBaT7FDaO0ICp2HbGa8BbOz9sTVEy7Bxx2P0TRtwyyfyaBl2k51BHYqs1yWCnnEl9LAKdeG
 I2bk+xiRFANr3q5fdVN61ksAoJB5EPKDeSK/3vwPVhci++1LhPD6VHaor6RkZqiuleWm5cAZWrv
 +zdcoBHo7K6XgzX7/QuSzBjD8jY8bOgdnk6BhLayqBvNWOKEOLD/VvlqtczHVT4mjBh1BBcUtI6
 QuXDVMHqlZHUHKNm4GeNXNPc426WNDV0NZW7eK+faqvI5EfOSQo5UFrktteU3irHQYZNG0DFmrr
 udvcTccUyO85UxF96L8mZ1ftrM2W/gm7ziPIPropEKFwk8oTawNI1vBaYuUM7DFldhr71cnn/DV
 YCJuH0lmve2GcIOFyCvqX0qHR3nMi+J+fFGrVhDKJyU9thEDua+vutdqhurHfCt3Hnhe41nqfuc
 g5KAnSaLt4XdG51RMUA==
X-Authority-Analysis: v=2.4 cv=JIauIMKb c=1 sm=1 tr=0 ts=6abed8ef cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=o3JLzeGjXNQsDHrD6qoA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: iHiIALKk2sbQ-VPczT1SGqJahf0U_XGG
X-Proofpoint-ORIG-GUID: iHiIALKk2sbQ-VPczT1SGqJahf0U_XGG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX9owD4qK2D+/U
 vzxWh1o9LG1KWrKd0RkK9rzOorVcgMgbYVA1hiCIO1cMkcwc8Ek/9a32PTVJktl6U5Qk1+lGLJz
 QR5mEy5YeEdFO6b2Wl6HKgWqqm6aXVI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/1/2026 8:59 AM, Anton Johansson via qemu development wrote:
> Mostly mechanical change of target_ulong to uint64_t, motivated by the
> fact that csr.c compiled with a 64-bit target_ulong already can handle
> rv32 CPUs just fine.  If there's any discrepancy between rv32 on
> qemu-riscv32 and rv32 on qemu-riscv64 I've failed to take into account
> please do let me know.
> 
> Aside from minor formatting fixes, masks are sometimes replaced with
> ~0ULL, such as for write_vsstatus()
> 
> -    uint64_t mask = (target_ulong)-1;
> +    uint64_t mask = ~0ULL;
> 
> this assumes that the behaviour for rv32 on qemu-riscv64 is correct.
> 
> Functions in other files containing CSR relevant behaviour are
> also updated.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/tcg/csr.h       |  35 +-
>  target/riscv/tcg/debug.h     |  11 +-
>  target/riscv/cpu.c           |  11 +-
>  target/riscv/gdbstub.c       |   2 +-
>  target/riscv/monitor.c       |   5 +-
>  target/riscv/tcg/csr.c       | 736 +++++++++++++++++++++----------------------
>  target/riscv/tcg/debug.c     |  10 +-
>  target/riscv/tcg/mips_csr.c  |  12 +-
>  target/riscv/tcg/op_helper.c |   6 +-
>  target/riscv/tcg/pmp.c       |  14 +-
>  target/riscv/tcg/pmu.c       |   4 +-
>  target/riscv/tcg/th_csr.c    |   6 +-
>  target/riscv/tcg/meson.build |  13 +-
>  13 files changed, 434 insertions(+), 431 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

