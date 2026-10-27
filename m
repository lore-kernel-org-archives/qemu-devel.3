Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86941606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fIKw3zKJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lg5EWUYU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLljL-0002HV-PE; Tue, 27 Oct 2026 14:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlhb-00083w-ID
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:15:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlhZ-0003ZI-52
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:15:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RGxseL1284554
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LqKYtnd0ZIP4xqMbyo+75Nf4Byv38icX7jpqb1QIqYM=; b=fIKw3zKJZJEt6zDV
 YmWZzflRZLVrspRRU18X6NAkDBHaRd4afUastbG1tVURY2xbR4T++PCVSbjpVrGr
 rGSrxa5oC3OsKfWnVJo48QTg+7wsQUvOddHK3G8byVhuz8VLyX+Rw3RkgURu7aET
 adI5YuPJic26rVl/kRqMm5Pop+vWRiNJTpfbte6hP30jAHp0uZrjp5tBSQ5ICR1r
 ITRcgVK46dIbN2YAZUJPJTIxSVLIbY1oqpOpYna8bRsVyrwsT++Xsg0vQkqGz/ST
 stPNUiJOP0O1ecAjxSBl34on3tAa0Qf/SYPPEHx1siSYr6s+X22GlwLH6alVgXbe
 ap2IDQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy710kcn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:15:11 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so97042c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793124911; x=1793729711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LqKYtnd0ZIP4xqMbyo+75Nf4Byv38icX7jpqb1QIqYM=;
 b=Lg5EWUYU8Ro/a70/GNweTSIuEtoeGEvsXZyf+VS0M6eJQOy41deGB/6CeFysgv8xTE
 O2InDWW+t4uXrGKFYLhxs7sm0op+hf0ZnUBGayCRMBGZ3+66UkqOqHdqGiN5PlgprU36
 OUoBlYLLFDOL14+wZgQgToyrgUvmt2L+uld68Y01SKVbGJ2PZTWDOeOm2gMG1WchYRBg
 bs+nU+K5XXSgQIyCPKDmw+dqO0ChYFhaBdfOfkUtLsok0MnmcU5xHvqRQ+DahZL4rNyf
 rodPWoup03Km1mVGHGE7VvtDOZ4jqw/Qx6XhueKxGwLwHR82grm8L+TxSxpY4ZICoIsy
 2apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793124911; x=1793729711;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LqKYtnd0ZIP4xqMbyo+75Nf4Byv38icX7jpqb1QIqYM=;
 b=DRzAYmyqDhd2ejbjM2LggRTpbjid9wqtQgnnLpsMYRsh9S1MgNpmU3XxsnTdLsOX+H
 f/gL5X2/iI8b113sV90QlYVP4g8ZY9SgFpn0uaASnGMZQLz98qQeNzcwbi6fDWG8224f
 cXz5HbyH1x2uqktGtaGt0ZyrejZBiItXS2PJvWhdDDxYz3THwUaUXAEsN2ph6uMJmrI8
 BvRScJ2+PjwItNJSXRM24dZyvzHP+qGtwN/xuuMPAURjZHvwzlf0NFJw9uKAai3qy6dH
 6fEWsjBVZTODzzRgQQRHh7kaBeJIPf9OfCbSykQTZR8/NFuxvwJdDCOtum+itkh+IdCa
 DGGg==
X-Gm-Message-State: AFq9FYJMzT0q4RoDew/pKse1KNYVO7HPU2sqyRx0SFW3MHDARLCA9d1h
 XYM5s03a2TCfSHjLPYz8wPpCuXWIrP2UIXTeSkFud70SmLUyhMznaVU2KBoBr01KmTT6Y5CcOcS
 qVtvZuREtpy3ci+f9WHXxYFWi61wFPFjSlSNo5g6zSZxTLprKQIKbFg6ew+nRvdjOGw==
X-Gm-Gg: AYBFou1+DYLhRZzscIo3RAAOOB1+P1xAhV6WKqYp9PiIzIzIKkrddC9U7QFTW0WouR0
 Q9znUVQFfD1PfbRTTFGprKue7KVjV309k2pDi+wsybwTNmcEDIe3onT/JKzDguRwWxqWLcNux9v
 Uv0UdaCObw/D6WglELe56JNA8XARgntFxOD9vsNEbmWzSXvNpAfIjd36DCPif6RCwEanch4conT
 ghowcB7e2zPs3Bc+qTuld9pFEN2bBN4qwrTrtBuBFCt2l9CY8W7sEW+YRuUMtNqE0ePLCDW03Jl
 jrFAFL2RkKjZ8/oRz7OItCiSzkPjKWhh8MVhYFFc76R0UA6/YdlVih5deOqwKx9uh0g315be0Ix
 1yxW0+YSk7wIBgdqGdUh7xwMFvQCQGOsDZWSm3NgrAdRauRDU8Pv6nnWZ1cmeiplbK4VtSeEjeg
 omtYNqnnmlzO++LPiZ1Ta+nDtDICFSFKTBonuGG2wTeAI=
X-Received: by 2002:a05:701b:451c:20b0:192:74cf:1db2 with SMTP id
 a92af1059eb24-1a6cc069b80mr49575c88.11.1793124910335; 
 Tue, 27 Oct 2026 11:15:10 -0700 (PDT)
X-Received: by 2002:a05:701b:451c:20b0:192:74cf:1db2 with SMTP id
 a92af1059eb24-1a6cc069b80mr49514c88.11.1793124909425; 
 Tue, 27 Oct 2026 11:15:09 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm41199611c88.6.2026.10.27.11.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 11:15:08 -0700 (PDT)
Message-ID: <f90756b9-8485-4f28-b91c-85f4735f6a5c@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 10:15:08 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] multi-target: add riscv64-softmmu
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX2bhf5revbBGv
 ypb7bc8CwgyVXak1Vzh9M0cmm6OEu/uD8/FaS4ESLOfwM4e9n1wdwOcaCT6262ipjaC/yH6xa4S
 ilmnVLfv3g6qwK5lodBelblegr7+1aN2dIrKFB1poAui5FsaBZK+z41Gqh7MMqZVsMOH5V0ZmkQ
 ygcJ/o0613QSiT4/faOejk1VzKBmU1vLK/T8mVHxAptUBG1FNeLy9Gn0X5notXGYAYoLd8mn/68
 rksJcj5WP4IFuxDv3MJP/ECtlxV+Cc3jc1jMajCAJ7TrJ09bB6CGbY8rJs+0iMa52yuj4gDXmx4
 7vLHfGG0NB6fz2yCn48cV3Fs6FsCmFGzN4IDCzG8Jz/66rN+goSFlBdYH9+5wNwtJkRjtdJQ8d1
 /gI4/Ivc0c3NoFI2OzMxSsjQwHbiMoyoL3womL8en8CiHxk52RcsiMbJDKYFp+wcRI/IZiignFK
 l404KLjb8Ct4P/LbU0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX/x9fZW/OLsag
 QI/EJbVocOkL6nEmiKeEFZ2fmjBzBm7HMjnoG+mQQxg8631ZZLfBydJQxzpDcVU1mL4FnzpjeZi
 O8E0SchmvUzKI8W8R0JRqck2+MsO0J8=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae0ea2f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=DmRPq2u6FE5jJqSKgdsA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: -FFJgLCNjOBdMf7XuK6zyFJbyrt7stfy
X-Proofpoint-ORIG-GUID: -FFJgLCNjOBdMf7XuK6zyFJbyrt7stfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270072
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 10:16 PM, Pierrick Bouvier wrote:
> This series adds this target to set of multi-target.
> Changes are straightforward: functions and helpers renaming, and one type
> restriction for this target only.
> 
> Based-on: 20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com
> "multi-target: prefix helpers with target prefix"
> 
> v3
> --
> 
> - rebase on master
> - dropped the patch renaming helpers. Now based on:
>   20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com
>   "multi-target: prefix helpers with target prefix"
> - fixed issue on riscv host where kvm cpu type had no parent type in
>   multi-target test.
> 
> v2
> --
> 
> - make virt machine only available for riscv targets
> - enhance multi-target test to detect duplicated types between all targets (we
>   missed the virt machine since we were always picking the first target avail)
> - add an additional commit with the rest of softmmu commented for future work
> 
> Pierrick Bouvier (9):
>   target-info: add target_base_riscv
>   hw/riscv/virt: make machine available for riscv targets only
>   test/unit/multi-target: check QOM types can be initialized with any
>     target
>   hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this file
>   target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
>   target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv targets
>   target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv targets
>   meson.build: add riscv64-softmmu to multi-target
>   meson.build: list all remaining softmmu targets as comments
> 
>  hw/riscv/virt-acpi-build.c     |  2 +-
>  hw/riscv/virt.c                | 14 ++++++++------
>  include/hw/riscv/virt.h        |  3 +--
>  include/qemu/target-info.h     |  7 +++++++
>  meson.build                    | 18 ++++++++++++++++++
>  target-info.c                  | 11 +++++++++++
>  target/riscv/kvm/kvm-cpu.c     |  2 ++
>  target/riscv/tcg/tcg-cpu.c     |  1 +
>  tests/unit/test-multi-target.c | 34 ++++++++++++++++++++++++++--------
>  9 files changed, 75 insertions(+), 17 deletions(-)
> 

This was merged into master (2c0584588c9fedc2a8abc087c01a498ce80997d0).

Regards,
Pierrick

