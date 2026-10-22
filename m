Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AB606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AAaLrElr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CVWbwIP+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrL8-00037j-1Y; Thu, 22 Oct 2026 07:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJrL6-00034b-8O
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:52:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJrL4-0007qy-01
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:52:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M9xsxU346172
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IOSlQ3xl55TB6kwB6qoXC6+QT2JRmV9yTgT0SfzDbDs=; b=AAaLrElr5EnQS6xx
 pmdZAXci/1w6vHWT3QEpfCquFJ3b5ILX2jwbsjDaAvsI5HCrScbC0ehni7Y2YxtF
 8GILBlY4JKDSQQirMUoVYTCGc2uVv2D/qId+4FT+5kjJgMlHm3SyXFnYPg3w7D1n
 Swbq7E8kS2OayXwGSDsCu1LaSxyBnKVS/C6TQ7TNDaFSjGt3mFOQmpO4mt0C1/hN
 JBhINcOxmIvhCIA9dJZk1ZxgC6D4RtoadWH8JtK84LCjcYq0WIEhH/gAYhWqQUQu
 1RsN965GG8U/Pz5/iTSGXwgNkWPYmuDC7Eo0xnnuMWbebpANVfG+m46JDjPpxoTt
 dTd+1Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93davdm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:52:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5367e512db0so18508211cf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792669921; x=1793274721; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IOSlQ3xl55TB6kwB6qoXC6+QT2JRmV9yTgT0SfzDbDs=;
 b=CVWbwIP+jBajvvjpFlNaRJb1TAepv9FHZx2mQpsQrGGPRqlAd83UAlCXh1DehW+sMH
 3Deo4TpSAMbYW/+86NfCNylHWfC7GScVVb/xigU6YbcIzMZOkTVMlObnG/zzswQFXTFv
 14oHPX24QCnB2SVHzov65zpdjBMTQOOLYYaF0YktqTB98lX7MGBHWgwFwxyJcJ8q8awr
 3Dl+S75fzRqBFmv2fNOanQbDUjJJ4l17nS+ptzNVu60gX5UR6rWyQOYKHVA6dYreQiIR
 znwxWjkVdlKp2z0pH37TbRMvIzzDWbcno3bCOGxKVZGJiUnkvGNxcozqr5q6yrYX3ua/
 Y8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792669921; x=1793274721;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IOSlQ3xl55TB6kwB6qoXC6+QT2JRmV9yTgT0SfzDbDs=;
 b=uIneARHPxXHKVcLX/OH1mI3ags8/hS3Rzp47dwq6oa+MHtJI+d9+9g4CPuhAzIfxX0
 TnYq9bQz8EBB128ZoKG8qADhyVLebOjhH8Ou+BQz0x7i+fYear07S+rqEkaXRCv1w/ye
 aeg88PnJKD+3/EFWPAwTcIcNTnq6WlkmY4/gnPLsYmAf4h+JrykRB2hUv6WQSThQh+BI
 Hk9EKPgMHTxt13ZdbLc5s9WohKRy4w49ApvwiOGj9FhDdKNv2bBil8QcIuka8agJSulw
 kBQUByAbppePFTUHU31N9gE8d0HMo+rENTOG29GdHYHL5LtQeZbctM4/47vzp6hmv5xL
 kR8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzOgUnwOOwNLlNFF77i6mWFPb2CpV1/iWLVWUPuUhgHKQcBm4nPROO81U0ZquxpfnBH0zJ5F1VeCdo@nongnu.org
X-Gm-Message-State: AFq9FYIEBqo/9CTFT8ebwkN+GDl9uXoAg+kQwpnrNkhGzZWypxufdec2
 o0mwGrDHUWSf/WO1D8ry4r7dtn7krDxx+WF0PZxTc6DekwbYqeecgfjZ0bpx/ddB6clNcziO4Bu
 INMIngJlPiHJA8+/rgq6FtCqZfhepD4vzOr8TfYr0McPA/NviBtqgsoFsEg==
X-Gm-Gg: AYBFou1n+HWjLagfsY1CgfloqgVEj1s3aGXfWAJS9fpI9VSeRjw9faS2IZ5xjZObHDl
 QFCgJBQfUb4Uzrwgi+k/HqYbtIMl2iP8aD5nDAuuwITaPXmpGDtqoRBZjJY3Czfz91tTlbXL3Z5
 94mICwoafNnNlVm8QTK8pG7ZopjniVsau9VnaESapKN+hfiaR7qcwVnrdrdNfI6SZi8+3+rOUQa
 VOAm5xvpzEu2zD20DEjA+aJKRmzLvvniwrubwg7g/aZDBLfGKnXhJPSsId4rLdXhdIOXRoP82TO
 9pbzkMCzNhrM7eTDbBCsV5xJVvQwJOiRIldKixtCfUDaw3oOIGHiUOihV2fabuzHBoN0W0qcP1A
 Hu3Y9H4z/Gb6kVEzSzjWtvm9iD4oeAqNcXQ==
X-Received: by 2002:a05:620a:43a7:b0:939:b053:ce44 with SMTP id
 af79cd13be357-93f627227f4mr353051185a.22.1792669920890; 
 Thu, 22 Oct 2026 04:52:00 -0700 (PDT)
X-Received: by 2002:a05:620a:43a7:b0:939:b053:ce44 with SMTP id
 af79cd13be357-93f627227f4mr353048285a.22.1792669920397; 
 Thu, 22 Oct 2026 04:52:00 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a207b29276sm80990305e9.6.2026.10.22.04.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 04:51:59 -0700 (PDT)
Message-ID: <3e131c64-1c75-4405-be8b-c682aed2d6a2@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 13:51:58 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NyBTYWx0ZWRfXx9ixPOwCRH/Y
 krc5jmf40wDBafPENA5tBNKP/ubOsz6QMv0p+QubdhRiv++s2pzao1uuTx1H4oMgWWd+ZG3WV+m
 mtc9U0SYvB1tLN5WhrVuO5n7FqPmMgE=
X-Proofpoint-ORIG-GUID: y_KzCBjZVtMPmXiqKDNTbQYOn6e4dPA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NyBTYWx0ZWRfX256hV8Bgbj6p
 XVQzfUJO5Wu8MmuL54vdqQSJBd+JTink6obhtxblpNWG46XmIcfswtIIq+N6nPG8PfN5Mv7Z4UO
 aVHqqigVzUgCtV0+lzdZhYhFZx33L+/dc2JhjMJXv5Sr+KuLeWol7kMzcWBwKoGKduHls3sAKlD
 qm7LXWwnWrXvgRdV/ploc0lfjsIBdSQ5YrqH+yCRmBW7aX/09ZuPDwhRfF3MOCjqZ+TxJlprTo8
 iM1uqMSTm47HG+kQRMLRNiQYFw1BdBYwyKc/AnkftRX0DlN9U1fUDJPv87D7WUJf+zhCOfw4cql
 ZsmYIwjaueXc2jRjBbN2fmWLrWrVlDqwRPrnpAPBvZks6/TYSOPkgOGy5dwgwKizj1+UoykVWXF
 5MI7S2utEgzARqoLaNLo+HAJeG8gEN4BdExDNsLpegZShHz6zWZP4V+5vFRXuhWv2Sm/E99fYkE
 WoQr1CqO0JrwBSb13lw==
X-Proofpoint-GUID: y_KzCBjZVtMPmXiqKDNTbQYOn6e4dPA6
X-Authority-Analysis: v=2.4 cv=TIPQ2Fla c=1 sm=1 tr=0 ts=6ad9f8e1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=vPf2aQAtsfViqZfzQfkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220047
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/26 23:20, Pierrick Bouvier wrote:
> When linking multiple targets together, we usually have conflicts with helper
> names. So far, it was solved using ad-hoc renaming, but multiple people pointed it
> would be better to have a general mechanism for it, so here it is.
> 
> A previous series attempted that:
> https://lore.kernel.org/qemu-devel/20260930073935.712-1-luoyonggang@gmail.com/,
> but it was relying on (binary) symbol renaming, which is not a portable solution.
> Instead, this series approaches the problem from source code directly.
> It requires more change, but it's cleaner IMHO.
> 
> Series follows these steps:
> 
> First, we make sure all helpers and definition are using HELPER() macro. A lot
> of helpers were already defined this way, we just make sure it's exhaustive.
> After that we don't have any 'helper_' left on any target code. This is a big
> change touching the whole codebase, but it's a simple mechanical change. As long
> as it compiles and links, we know it's correct.

I started to do the same manually 3 weeks ago and gave up after
converting the 3rd target, thanks for covering all of them.

> Pierrick Bouvier (26):
>    target/alpha: define and call helpers using HELPER macro
>    target/arm: define and call helpers using HELPER macro
>    target/avr: define and call helpers using HELPER macro
>    target/hppa: define and call helpers using HELPER macro
>    target/i386: define and call helpers using HELPER macro
>    target/loongarch: define and call helpers using HELPER macro
>    target/m68k: define and call helpers using HELPER macro
>    target/microblaze: define and call helpers using HELPER macro
>    target/mips: define and call helpers using HELPER macro
>    target/or1k: define and call helpers using HELPER macro
>    target/ppc: define and call helpers using HELPER macro
>    target/riscv: define and call helpers using HELPER macro
>    target/rx: define and call helpers using HELPER macro
>    target/s390x: define and call helpers using HELPER macro
>    target/sh4: define and call helpers using HELPER macro
>    target/sparc: define and call helpers using HELPER macro

patches 1 to 17:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


