Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C977B606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PovsFuz9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kamAJRwh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFEe-0004sj-I1; Tue, 20 Oct 2026 15:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFEO-0004hg-86
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:10:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFEL-0006dC-IT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:10:39 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7kMC3499166
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ktxyaH7DNIkud1mcxP3wvB9yisQeqxyQelx7tbu0Y7w=; b=PovsFuz9PaFo5gRm
 bZb2vs0D9t/92GODieD4JZeZzGRpG1uLIvahUWZaPS2M69NH41sX6QLt2S6/bfNd
 r+mtKSGW96XPN46KDmjJYKh/XaO9a7XRYFghap2rFUL/OuYzevPcRVK9ys2vmARd
 xC+IhQjfGqT/rjrRs6XTk0xnLx869FqFwpwch4hiJK/03Je16jFm5H9FmDYRL6hd
 yNcohT+GzHkTgX4O8IQFJch5ebB03UH+WEj9CGyMC1nZpAy2U/2d/3X5WS+CQAbQ
 l/LdZjnCpgrHJQBVr4ywJzn0pplQNDwIT4caerMPfbo+m+p6IA/z8lJyXoBBNng6
 q/JIvQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabg7hq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:10:34 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-151ba226e1bso5687638c88.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523434; x=1793128234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ktxyaH7DNIkud1mcxP3wvB9yisQeqxyQelx7tbu0Y7w=;
 b=kamAJRwhYDSyeNZjjgED7zORJXVOYGWdv7AXeBoyQvEpZ1bpb7yznhbHBMlK2KbeDg
 bFiQUssfCRkTyIuzm5XONvwUZ43hy4w/+uiqvmCPGxz0vP0o35j5PkvOWevJyJXKHNw+
 b+merU1/A6XNCYk1a1ESAY8Odj0DSTjBuhwVao5PJqXEnir5A2Ybn0Zv5RU1vPbKyut3
 ddOB5otqzQT9FhsxFiNt2WSHc7Bh5zcRbcwGzTF+16chfH3zsc4ndd2uL6GaPWMV/8p1
 f20DKSgDN05koLT+sMikWxX/G9K7psYhAXwLJCBtslxrw0EllNg+V18rbBCZua1pcO6G
 ulWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523434; x=1793128234;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ktxyaH7DNIkud1mcxP3wvB9yisQeqxyQelx7tbu0Y7w=;
 b=14QVZ0RhbbzIAkq5KU/GgbpxKBW2VCpLnir02yMEeclsTtD1XMz/GK9q8EIlZ325fg
 T7r4iKVKo1qZENpRQE6FV7sF2jQ3Q0/NYBD3vxoYwASlvQkOT4ugsSK9ml7cUXbY9hsa
 fkO44ClQaZkOgDVVqifFAHtBOpTOYDK3ZmBzPtVQpYD6gE3Zt+xk+bLVyXIZ7Ca/dmBB
 r8d7R4stYoPZNQ4Zva9USF+jjhTyUurgjWTVh5dO3j/FXF3IC2wSm8Pst8fEisKNTMr9
 mCtjKoLT15yqkD6naHso5VC7oTRzFcx2L1enrDZVJBkd1txnllFuepAH7qIEmVDm9mzn
 Y8jw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz80z/BRCxmSazg4mC41JuIj4svHWitHL7nNn168xTC7KD9l3cmpQGVYd1rIvYiSpCNThytVgFvdZrn@nongnu.org
X-Gm-Message-State: AFq9FYLO9SQ2thDgfgr8JuWMjWVkAjaFUTOYozuqOHrx1wh2evnJoxUB
 wdFz5IIA7yPv4TxUzuxvW7eflByOa9LQa4okkCQBanmOo2AGnoLRvte9eGbBsZjpF1RiAiDFbri
 tQx8xdbW0jbHWDYzvLmWHIWl5TxTD6kGd4fSTQs4da4fR7aFeq6L5j8tbCxyJHMDFGg==
X-Gm-Gg: AYBFou1HIRakisAWrtBHCWYlFuvDUkA0MdlyOkmM1V94DdwFPhlTY9lu/NnztffFATm
 tBR5hAUW740TzlnUGokcUYvEfIHS+DsNRhWC5AJ4JneAz7phH3uTzVggQg9hlQ0M+/dIU1JQtVh
 +4a2vRzsmk+U3IhAGNiTrBl5Z0MFVFyxhgTRv0YEnq70Htr7D0g20vGsOfG09SnHp2vvG5UiyVV
 bNlewpBSZVJJhAMmVAn0z52f/3tHvRnuE0oMC/p9L/jKdoBGavH9IQ5/HGc7ga8bfONxwanQsGi
 AOtmocTMACgL5qOuU1XFCFI/n5LfDNYYwC81YResYuDu/xvLyl8QMESBymkB/w8A6fmXQLX02kT
 HUgN+MpsonOXeTkLiefwI4m4eCc10GvuImVBNnkThX5zL45E5elpEVendyQyZ5Mj1cfSfAA==
X-Received: by 2002:a05:701b:450f:10b0:185:33ab:4d55 with SMTP id
 a92af1059eb24-18533ab4e84mr15803624c88.29.1792523433983; 
 Tue, 20 Oct 2026 12:10:33 -0700 (PDT)
X-Received: by 2002:a05:701b:450f:10b0:185:33ab:4d55 with SMTP id
 a92af1059eb24-18533ab4e84mr15803583c88.29.1792523433225; 
 Tue, 20 Oct 2026 12:10:33 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d87ab1bsm602543c88.21.2026.10.20.12.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:10:32 -0700 (PDT)
Message-ID: <116ac62b-3bb8-4dc1-a136-4452a1c1946d@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:10:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/27] target/riscv: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-18-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-18-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX5RMnuKFmG0cG
 GLtIXlM0ze9IK7IBYgCvP688ksrVSjpUYsgK7inxd589me7GCHbGSqWzsMQMOHPH/FJ8yeOYP//
 zjEs7OYrwKR9x9SyAkaqbNQd38qniD8=
X-Proofpoint-ORIG-GUID: ePh2FUiR7WezSC5se87XH3-T2F8fQDaO
X-Proofpoint-GUID: ePh2FUiR7WezSC5se87XH3-T2F8fQDaO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX2T8tjkkFsx4m
 e9j8AgvqE/+uGtP984KIfc0PfsJJFqZVG0tnCBtH7/TzhGk5FNI3V9NbL4uHJ2GcdC7Cq6+SMH7
 ASSvn4rsLA1SPn6+NFm0ygm+Bmmpz7AUb69SIXl2LhpYFO3GmQO98mIj8e4M8/EkdtutFdIySwe
 Sb86UxRo6ZVKDQtMABLrQPyHX3+gAKCA4gRxqaLe9R6+ggSfCaHxa5WO0J6BjGm0Zf778+nH3pf
 YGESArzijR8+E6xkGfono9ZwDTRM3aLzFwMDPRBloCPahG7NKGe258S6NIC/6z9deP9SZDGRdPZ
 Mne4rh+Cjf5TlGcfXsJx++MeViSM+2YC1nlx3p6Hha6BOrFuUix0J+N14u2Jr0DkMiHq+tJWC8e
 ynG8qSB92ole3Ayc5m8eDFHOWhYVuUNsdBdNfSKHcJGKalWhgZQzdiiqPvR2qE6A5lV2hjzDM2M
 8tIvNPakJGiFVd2CYmw==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad7bcaa cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=tTG0r3Upy50XSGkOqccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
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

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> Factor riscv_excp_name() and riscv_intr_name() out of
> riscv_cpu_get_trap_name(). Register riscv_excp_name()
> as the CPUClass::exception_name() handler, so the common
> exception logging can resolve RISCV exception codes to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/riscv/cpu.h           |  1 +
>  target/riscv/cpu.c           | 29 ++++++++++++++++++-----------
>  target/riscv/tcg/op_helper.c |  2 +-
>  3 files changed, 20 insertions(+), 12 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

