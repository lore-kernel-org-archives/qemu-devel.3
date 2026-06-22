Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFD5CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblrs-0000b6-MU; Mon, 22 Jun 2026 17:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblrr-0000aq-6x
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:07:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblrn-0002iD-FI
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:07:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJauxF2205261
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GpKGCrMRzeYPWqDUIE+qCkrV9/ROixK392W0ijbejjE=; b=jGmmfMf09N97/9t5
 Ww1gaBzL7vo3L4N6lDDS8xP7g955j+Sus6+R16ptwbZnisHFdZ23JMJiNLGAvJhA
 p1j7NrbRU+h3+jnYokHDSxEl/paqP9lYGWTvYlLXTuX7uWcb9OY1NuBnblKbLYS6
 0Tpba4QA104xTobWtpZQvgxcPDIFN7eWmNg0LCsJGAkhp2z3jLQO7uRgADu+dIrw
 I2Rejv2ryrYhelMDB5ZNPA6OW776d2jf2GeYMyB0S7I3I2tU4DJ5noE5CQ7mC1vL
 rVTH69JOyh8CxtFk9Fxd7QzRwjb9dUsGVceh+ugkTctL9hCsaoqfe4vWezkVcV/E
 +imjlA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmse67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:07:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91579011fd1so715914985a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782162457; x=1782767257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GpKGCrMRzeYPWqDUIE+qCkrV9/ROixK392W0ijbejjE=;
 b=HpN9HBWGapnUQl50VOSkaEHFCikBABBuqnBw1loim8SDMGEV3LmOZuKOv2laLxJ9IN
 EChxanQW/NxaWJDgfZ8RpvlFJmagKpYL3r2aMZoLSl8C2hqPmwD6FzPyr6WUzxIG4tXJ
 BLmvOVc3DXqx40d4ftyDROCzR83A4A37Lg1PP1S/FUd9zUs422onBwiYkT9wseIUgWh9
 SgyLzPj8Q0zshbkA9YzXH0pgZIKA0gbQjY7dCwV+V0MikQWmVOuyIxNOnbC48FB3ckaa
 Y+/fmrC41i2gynY9XG9RnmqQ+C4oza6S94QfQmGxhlqguQjlm9gw/HL6d0VzT38vN1o8
 dwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782162457; x=1782767257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GpKGCrMRzeYPWqDUIE+qCkrV9/ROixK392W0ijbejjE=;
 b=id4zvOny6nNqkFdS1p3z0tyV33qaIqJA7D09QDqo5+HZdcq5DGrL2ArHGVKKj8KH0o
 j2MowRLIMfj9N7k+i1KXdaKqHS2zXslCZTMAe750JBdk/bHDvVmd14hnuJZkf6WxjuXv
 5OiMm7Pk4m73PHs+btTsXFx9+5kjnxK8t5r9pXx53YDkprFaEIPQ2csXB7lZ/HFWViPv
 wS8WWrWs41AXdkmkwWz/+Q0j4IBTy3PUS+b6mRX2iPCW/9/p0I7V01fjsQJR3hZCpG5C
 awDGbqpj6nfRqWVo+00JEpTqxawBThgQkR9uti7PqbJRZ+v/6amUKWdaFQVazH0/sP7b
 AsHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sZd/+910MzhKCxBhbRjf2lJbHYja0LPKJx4OrfEWgZcjOtJoG9at3OXz8zksDcLKBxdwEcwVi8/ml@nongnu.org
X-Gm-Message-State: AOJu0YwxVT7gLgpd8T/FyUtjuRo00oE4pXNdsmnoG2zrZXgzNUQ8yRkX
 0K0JJDjFiWZD0B0KxyYXXkDsv9MFMOw90Jvc0aeQs3Fm0wRiBBFYeHPV+X9ZO7zy5fDvp4aN6Ja
 7swkHo6q+X/apgcst4uBLPz4MdSjAMQ9upPxHwlYE4VeORl4l6mKW3F+qUg==
X-Gm-Gg: AfdE7cmylmZXTALR0DtAi005DaqKLd0a04+iKT6L5MP2u+PV3gLwk12RT5VK24QPPyT
 7LmbxAfaervVXV262/o3CunKJFoaWC5Mfrl3OIdNgOFwBIDAB+PAwLogkUK3dkErpOkyF4/xs4g
 VmYJ5wmcG1BhAr1Ye23nxy4KyEkM5czSY8oiojgtvHZkiniWui8c9vEe9gohILEK8N99d3veFfb
 QLU0RVacDlFvWeSCt30cK78ouo2QOTanN0d1HBaRivHpeKMeW3NqL0T6fwbLBFOt0oG9mglvlL6
 X6bf8XTrX9Jx2e4yZHXUduvBSkMVIGyUGkSqxkfIuvbBhSc4CKxBgzPolGvYyn8KIFU3dU035/w
 a2KL6ZExjhisLySZB4Wul3FPtv/AeR0EuFOpVM5PLsm2FdLAFnbPydxtC8nK9DQ==
X-Received: by 2002:a05:620a:d8e:b0:915:a111:86ae with SMTP id
 af79cd13be357-9209119a689mr2750220485a.35.1782162456741; 
 Mon, 22 Jun 2026 14:07:36 -0700 (PDT)
X-Received: by 2002:a05:620a:d8e:b0:915:a111:86ae with SMTP id
 af79cd13be357-9209119a689mr2750214685a.35.1782162456326; 
 Mon, 22 Jun 2026 14:07:36 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788547sm30907727f8f.18.2026.06.22.14.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:07:35 -0700 (PDT)
Message-ID: <ba5ce5c8-8493-48cc-90b6-fe304212393a@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 23:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/24] target/riscv: move some irq helpers to cpu.c
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-14-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-14-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNCBTYWx0ZWRfX+pb2rCRW/h3Y
 qp1tEUw8pcEhqA2mSFmjgZlLB5S40W8UP6sK93snkhvsfF9lMtcQpqANEfB6hmPRjAHn4iaKfxN
 wGPevYiJL6bzXSaBV+Sz4+glBZrbJGQ=
X-Proofpoint-GUID: ZuatKAiAvrtP2lKed9AAK9uSuw1cxKfI
X-Proofpoint-ORIG-GUID: ZuatKAiAvrtP2lKed9AAK9uSuw1cxKfI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNCBTYWx0ZWRfX6wUrf9vD1G+R
 hlADTei1PA48bGrZPItTqMbx1KGVOrBMj+wqASfHD7wyiLydmyWFx0kr2qWQQ1szOcUxFPpw08Z
 Aaa87eKaN1SkOLUA5i9fGyIZ8q1uatMUp5MenrmThNBysvAD/K3fdRAfjCenAoDhwl83UEDoQ/W
 l7UCirPWUHb/9TLj6Dn3Azrrs1u9+JII5jMxPSQNYlv7sf86/5E9WZJ+Ku2P+Tpy4JVC34Bthjy
 x8OJNtzCEWSLBhDvVStqoTAIS/6jPuJporhD5NOM7UhO7IUbzPh2O3iN2QYLZwgeQ8E8Wnaii86
 ztJvjppzcOIelni00VGMaH73SOGR52YmiKey4sWo+ZAQxrt8kpsFnTnJ35avQr+Z6EfCOLaoxCN
 x7xRX/EdTSYa22DGWgKPOGbPOpmbQzH2Wzq1fT7t0NJNhK3Zg0mJPg2Q9B1h3/FwQ4G5xeey97O
 Gk5ARQFDQHudf5IC+fg==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a39a419 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=31tgaIbxqbOXDk-74rYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220204
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> riscv_cpu_has_work() uses a handful of irq pending functions from
> cpu_helper.c.  There is a very high possibility that KVM doesn't need
> the current implermentation of has_work(), but the common accel code
> needs an implementation of this callback (see cpu_exec_class_post_init)
> otherwise the KVM driver won't initialize.

Indeed I also noticed that recently elsewhere.

> Move the relevant irq helpers to cpu.c to allow KVM to keep using the
> current has_work implementation, allowing --disable-tcg to work.  We'll
> circle it back to evaluate a proper KVM implementation for it in a later
> date.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c            | 187 ++++++++++++++++++++++++++++++++++
>   target/riscv/cpu.h            |   5 +
>   target/riscv/tcg/cpu_helper.c | 187 ----------------------------------
>   3 files changed, 192 insertions(+), 187 deletions(-)

