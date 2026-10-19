Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4FD606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dmSoelSj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ETAox9xE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqgE-0002VU-2Y; Mon, 19 Oct 2026 12:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIqgB-0002VK-SO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:57:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIqgA-0005ms-4m
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:57:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFP75Q3592227
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 16:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O4bSZNg7RSjYbicIOXlrYv3aogvpWM0j7fwqLoSFEjE=; b=dmSoelSjPv8k2hAH
 IbxBFRXmd3zmvBsb7m+3sZKxRLd7PHKaXRvFMtIoZtHax1qtHQEVnnUbuf+c0lZ4
 RJSAARQIm/ws9JmJNNuosOyP27pfSsQdTUhc6Mq394GtLbdcktFnGkR3rd3DTt3k
 s8hFbQofJjJtSVanYrJRa7E8FJysh5LrG86jqjqC9HGeHfxN+K8U6IV4mywdAMzj
 Ztoqx0HS0f5hXNv+rPIOCV5ZaeiLAFVYDtfBhpzDTa79l0XBu6R3F/KKLlci/Dh5
 TXyxBFPOZ3F7iyyUojkM14nn+zrbAbA1qo5tuXFcAeketdC4XsdpkIwaRrOV+6ab
 R02PAg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn22hg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 16:57:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35a04491c56so2685889eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792429059; x=1793033859; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O4bSZNg7RSjYbicIOXlrYv3aogvpWM0j7fwqLoSFEjE=;
 b=ETAox9xEh8I+v/SU74emXTiMT2ZcqqYAIiwibM//jMHRNEFRgQIj3b1+6FunAIqIZB
 79iQfwjLzVxv7EE9aWJqcIxXhaLb3Myu01Qa+/CpDd1XJu+JcJJT2k6DUsQSZ2LXkG8V
 HdREsf50oumsp6PznN8UqZUbp1OpZDgSmuzHhoEq1WcRG/bHtyviD/JHwiBQAa5n0l7S
 cIQ/3WWX2zqTdJJr6NqTbhfX/daoRou/IOguRAe7+7WhoYvrmMqVUCs46DqtVXFRbQSQ
 pp+Bu7Mkl/1rccwbHoscAIqDar+IY2kGVEnHFf0t5sbvqIoKeiPIlXhZd1qu4YyctM9h
 vcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429059; x=1793033859;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O4bSZNg7RSjYbicIOXlrYv3aogvpWM0j7fwqLoSFEjE=;
 b=kWpwFMEWd+kQbYKtWmR4nBVsAPtu6B2Lm+tewZRs6w8x2AJ/oNB6V2wKut+IU1UEdT
 me1ytyZrfjZl1eTmkvHm6pBQvkh5doj3mXO+3NS+JsHtyCJGAdTwQ9j/P+T+vTk8gpLc
 YdyU4fNrQrfp7/G+YLLpzyJbCOTq/qAD3H8Z8qp0qnWq4Qcvd+X1FvDa92gwX/Zt0jFQ
 G9vcMI0/vhMb8t2w+YBg8EfXq1yhRfdAyn+7j8BrfkVV1eMVc+HdwbprmiEH7EwEg+0a
 z5DReTiocrw1v3PEHmiE+uEcB6Js5G/y68pV0Ay9LdFq/URxkm0+scaTcG/9T30yWxwM
 INXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPjz6qMtJAvWz8jD1mtmsjBWEilBbX0plQa1loheT8A1pzpJ6ws0Sv8lJ69iwHLlrd9rzPFKbkINQs@nongnu.org
X-Gm-Message-State: AFq9FYJNbWrXzPnJ2zTMQd76AaYZGPvvRLzDxtu6BdyXJO+6Q4PhMk3W
 L1vIocj4jfj+hzgcltFz84blOu+h4NFcHBXhfyEwqxk6zEJV8QVO6j1LbDC+9xXXhl6B8TwyOBZ
 1EjMZNVihGwno8cM43e0w3dTYd0GiFYCDLC5ZbJq2yjtWe1m4lnqdhPQ0kA==
X-Gm-Gg: AYBFou1k4kqj+pw0WakTiFcW1jikURFLjV950ACGiIvAUTCEoukSMCxXyRxBHZLWC9Y
 SQ9XU546j5dGgBkKpw3zD0tCOxaGrpgf/7hboccEunOLhuB1abe17yGBpvEtUumlq46z8uuLkAR
 Y7oAPYt2t3KyzBkSfH+f2u9eXqJTK8PE/uGWpLqG/Np/6YiJz4cK9AmH9yXAgpKJY7w1+mSKtwZ
 OY5GBUroLJVByinEJi4SZdWRU/YIys/LowqdfSJVzpjsWbhM/ijdydp+Vfkiw9TteCG4WtdUvw1
 srPibVO+RJjKm2T7RvDG+V25jqj5q073ScylI9uty8bbPgD2ySaaNf2NRTzmu4Qow0mZKFxwkMU
 EQTGILXI21hGAyMWQbgEICFd+f3bZ6X0UnIaX+A/J4To4YZgQmhv3VctAxO3vA7SzjsUTdQ==
X-Received: by 2002:a05:7300:ce84:b0:362:2e2f:c261 with SMTP id
 5a478bee46e88-3622e2fec49mr8229950eec.27.1792429059167; 
 Mon, 19 Oct 2026 09:57:39 -0700 (PDT)
X-Received: by 2002:a05:7300:ce84:b0:362:2e2f:c261 with SMTP id
 5a478bee46e88-3622e2fec49mr8229926eec.27.1792429058458; 
 Mon, 19 Oct 2026 09:57:38 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081bafa7asm32895713eec.14.2026.10.19.09.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 09:57:37 -0700 (PDT)
Message-ID: <7c78ebb2-37dd-4267-858c-210c3d02e93b@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 09:57:35 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/riscv: prefix helpers conflicting with
 other arch
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016232304.1215119-7-pierrick.bouvier@oss.qualcomm.com>
 <911a9b004bdb22aca49bfe7ded9c58817dbc8591.camel@wdc.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <911a9b004bdb22aca49bfe7ded9c58817dbc8591.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NyBTYWx0ZWRfXwT8+rRfPM/Wv
 k0dfedR1maOHpRfZtdUHbTXvfOoV0G7t1Pr9ji1mEeH8MC3KsqqlJH9rpQox6X/J5tN56bnW1Dr
 DsntnRIDEwKJSKoxZt8+QQVZ2WexCM0=
X-Proofpoint-GUID: rFXr8PEtR3YQTJJuzSLKOXgNI5_xARTt
X-Proofpoint-ORIG-GUID: rFXr8PEtR3YQTJJuzSLKOXgNI5_xARTt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NyBTYWx0ZWRfX4P/DkSdI9z7g
 0o/qlx280Sh4dnX8XS8LPJbRYcqcnwl1cp4zWjxvjIl6F5qqTI5XNqiyohVYdgfR19QKWAr+UOQ
 nJEvGeLW+YLLumbR/3j9YljXeZ2xsFFVufffOlQrbs8qb7FRE4hvQCMahDBackXAZ3jRx0V8eaW
 MZcQXRTP+N563h0+ntQYtpNl9EEjmBUXb1Qm/1Pr4MjwTDR5z8LVLOvPRk4BtnTMogzTzrczb/V
 tNQeEgNr4g9EpOzdt++kw5FPKGJ9rxLt0Y2R06KwwJSCFjCKymdbsHpi5ZHyxtkxmpumGVTXkV+
 7Q4Bmt6P4PT7zAANFTSOd+zYXg3Vg5SAvocLmVYpCHuu0+JXapUcd8V0J7FWOyo8Um+iBHDP+QR
 DiEXRdWfmML2eOvmRjD5nURvtAchc1p1o7JQvhYjVoH043uErGl0zRuyPbt5828dfOtL80bJL+p
 t6Om6XNonezYjs/uVQg==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad64c04 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=kVIeODeziGGk03vKVN8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190067
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/2026 7:26 PM, Alistair Francis wrote:
> On Fri, 2026-10-16 at 16:23 -0700, Pierrick Bouvier wrote:
>> List of helpers:
>> - fadd_s
>> - fsub_s
>> - fdiv_s
>> - fsqrt_s
>> - fadd_d
>> - fsub_d
>> - fdiv_d
>> - fsqrt_d
>> - crc32
>> - crc32c
>> - raise_exception
>> - wfi
> 
> Why not just prefix all helpers?
> 
> Alistair
>

This has been discussed here:
https://lore.kernel.org/qemu-devel/20260930073935.712-5-luoyonggang@gmail.com/

Richard seems ok with it, and I'm waiting for Yonggang to respin it.
Meanwhile, I just used a basic "rename" approach, that we can easily
revert. Given that we are guided by compiler/linker errors, it's a very
low effort to change/revert with a zero percent chance of introducing
any problem.

If that's too invasive for you, I can also pursue this effort and add
the tcg helper patch directly as part of this series.
 Regards,
Pierrick

