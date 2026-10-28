Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7227606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oUF2x3UH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kBBeWuxz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAVX-0000Qw-KH; Wed, 28 Oct 2026 16:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAVI-0000Ci-7d
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:44:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAVG-0004pg-E5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:44:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPDnY2969643
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H30jKjBRM7gy8o/efCu8A8zgI+LtqMkoothIwaCeVs8=; b=oUF2x3UH/pfMqbR/
 jCMrYw0nJyx81bW2wFXJgsieOIfhdwsb48e3D4ZEctxExPP7IeirLjbZaoFZmnUx
 j0fMaTFeeFrHxzFPv/nDbPaGW/64HrX7CSMzK2asRV2/NsJx7hmWu8oKmMbTUQxw
 yqkvXAR+UcxencOWvYwZwIAKsdd2+NlR6lwJVt2VH2x1C5Ckog4gGhaEvdW41POc
 B0gUaJOiCxwdxzfjYnL/AvdLpmpS6jNLU0VffdeE5JBmmSVaSARwXXHEK2wFJhk1
 pG9JnJujqymPgutJrXmCeZa4gzK72bzKIcG6yBV7BiL9c3NzU/I1kaqAxK0uOUd2
 FxKiSA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehse6w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:44:06 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a190c53a3so123255eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220246; x=1793825046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H30jKjBRM7gy8o/efCu8A8zgI+LtqMkoothIwaCeVs8=;
 b=kBBeWuxzZLIbYn9nmDR/DhvJdcuKSXt3f7KuzYMBmBqFTPKOAbCEfUeMvtvtDD41nb
 E+hw7/jxTYetFd0T9KSHDY9zGsFbS4hJpMxd77nv9iSxQJxZb36zRlT29tPr58j0AO1w
 qWlcWDv4oIGag+vORyDvVP6jk4cGIo46JmlBLFJVpyi0LITmBsF8plkw3sfp8lYJOL7M
 YRnr7wqE/p19tWIMoyZ1RriFN3cLCqF8AnqT9aKXdLxaCHtz+xKL2ClBH63QtdvtFC9J
 EmVOz11trDuCkHloeh8ZcCNpJdox2xHsl/EIwKaJDkvURXDldfNEywVJN/awN2cPIXeq
 3YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220246; x=1793825046;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H30jKjBRM7gy8o/efCu8A8zgI+LtqMkoothIwaCeVs8=;
 b=DaL8KAuO3UXzckxoa+ilgq+2gQbhomsDqUoHszI0terS7GXYICAc5rGGIobgFRfs1l
 0XfeQs/DGxnGIBUzkKlwgO+yECueu55a8WK/F6tiaBf1ZGbiYAyWkqOeb4FMiPGM25OI
 dU5+cZ1tkbT6jNPDHHoOKrX5djS0KCq08aQWXOb82HMFOcXa/stvgjhnMJbjAr7uGNWX
 g+sOpl3nTsFbFwDgaRZQmB16Gn9nLjK0AZ/jndLZjbHU4aPHf0Ki8xIge9JhEw9UXUzU
 l9m5pUIKFoehmR2NvYL/1b5cvYoCJyVnlqqafl2NdABKxRP9nAIdJSu2sL3xe1nftMLN
 BaPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR5MIvashQFzdvgU0Vkd7cySFcY1M0TxwBaoQ0zSWbfmOnVG5K2sh/brAVOg/IlgGHeOtI+ByitaPO@nongnu.org
X-Gm-Message-State: AFq9FYLtVt5PgS5a8INLXsDfzHAWSCSeszvUl1TnzcKZd81Wy9dS9xzf
 BpXuEDC9cC6ZYQkBlupTIe5ac4M3jwt2EkGO+VTbtHUTQObsazIEnK320rfpPNhVLVZ+3yuW23n
 7tlW71bm/1vjifBqCNf8WevCK+FxOPB+FjATnAKBROIOvx/l5R2Yl1a+Pnw==
X-Gm-Gg: AYBFou2j7CNJzV3zK2PGgm/VNYJXW5Azn7qqAPECLvl1cgfSuUtY9f8m5MivwwO1Mrz
 Okny6g/tvD/pyEnYGup4viZQfSx2tWW6KmKEv1Zx4gS9Aty1/AgQ5LqZQNYwVxZc7nZoe9LaanE
 s7AO/hsXFF4W45NTOl1obSyEE/Y0X2f+4d+JWcgNLLDG9dPW5AlxkyxawGuwB7iP30DeGstqM6E
 a5h3Btad/sYKTb0Pqz41SDkxAGk9VBG8DvqlOFKD1PAZeUyyZhanNcGrhUdx2+4cp9/SG8AXKqW
 vegKnaGdWVO51p7Lb0WuiHlrV/7jg8nc/Cr36YUp2gCJWibCUG6Sr1RYvwYSHsjg5hBM78D2MM9
 XyExQ20QtfLs+08nshuhbICTfxmr5x36l0lHsacDN9nOQ3qv6dKIMUE2NEwgQJQqiS8azcYcosf
 sY5lanQnPLTuo9z8FSoBR7w6UBp9gk7XCrCUtX4EFBEak=
X-Received: by 2002:a05:7300:7aa7:b0:359:fb64:11d7 with SMTP id
 5a478bee46e88-36a2fe8578amr791442eec.11.1793220245873; 
 Wed, 28 Oct 2026 13:44:05 -0700 (PDT)
X-Received: by 2002:a05:7300:7aa7:b0:359:fb64:11d7 with SMTP id
 5a478bee46e88-36a2fe8578amr791423eec.11.1793220245376; 
 Wed, 28 Oct 2026 13:44:05 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a237bddb7sm8605010eec.3.2026.10.28.13.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:44:04 -0700 (PDT)
Message-ID: <930af256-05e7-4b6f-b79f-85e457464454@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:44:04 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] target/mips: Expose R5900 registers to gdb
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-9-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192538.31600-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8kn5MGrdOCt-vE5mdHNhHvGPIcRr-gkA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX5N1vRiM+3YEJ
 whKLeanYTB4Q+1mSCwTVtMqGTvw2nYBfZsGxjr3XrjjGH6isjJkxi+JqcMkcm+ynIxJRnYSFxjO
 Pi6/vaXJXFzxueJ9avXQ9nV0NNh0rar3H6hv3wY2sKaZtzzA2rcmg1ju/fpxIV1UIm/N0yAI0Qz
 cUiF5X/O4azdygAhoZBtZBpccPM90owqiVwVNwvaEbJXp8AKXrRpIbCzmK5g+aHW7SqEKAS2ang
 aMJ2hzmqQnl8wMDUxuZ0De6anL0cqQ5AH7giR4Vrk8LkPvHpRy6naAvs0yrfgK0c5FAOhGfIaug
 PA06FFpgeavJ7XVCRJwDFfGKxA8RyFaed/tRLXAxcHap+oh2WNy+zuK3gUBU6K/TZloy4ZIq5ON
 ACXBLK+WB3eqWzRNCb+Q2Q+MXnLtbAXDRNLB9IwywKkrg4IwXCjLe35ktbCIJGW22V7ND5GuP3h
 qZWafFOxLfvsSGxCMnw==
X-Proofpoint-GUID: 8kn5MGrdOCt-vE5mdHNhHvGPIcRr-gkA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX5iLNXp9xHWrl
 JCpz0EUCDn9QlF/zO/Ns+Znoxal/Q7nthJf1TkQTb3bANX88t9YZ+lnUxv7T8gkwnkqvRymGoyE
 /Rf2J3QA9FZZsdDbkylzZ3yJU5T+3zQ=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae25e96 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Ixn1CAxRAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Egesq4HJ73iWzWIfRVYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=_0vDLAJOulx5KDpLVjVP:22 a=cvBusfyB2V15izCimMoJ:22
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

On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
> GDB has no knowledge of the R5900 LO1/HI1 registers and of the
> upper halves of its 128-bit GPRs. Add a org.qemu.gdb.mips.r5900
> feature with lo1, hi1 and r0_hi..r31_hi, transferred as 64-bit.
> 
> Unfortunately we need to gate on TARGET_MIPS64 because the
> gpr_hi[] upper halves are only declared there.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  configs/targets/mips64-softmmu.mak   |  2 +-
>  configs/targets/mips64el-softmmu.mak |  2 +-
>  target/mips/gdbstub.c                | 46 +++++++++++++++++++++++++++
>  gdbstub/gdb-xml/mips64-r5900.xml     | 47 ++++++++++++++++++++++++++++
>  4 files changed, 95 insertions(+), 2 deletions(-)
>  create mode 100644 gdbstub/gdb-xml/mips64-r5900.xml
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

