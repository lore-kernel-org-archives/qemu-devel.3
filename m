Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DC8CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDq49-0005DZ-Uc; Mon, 05 Oct 2026 17:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDq48-00058D-8C
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:17:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDq46-0000cT-JP
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:17:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KN7FP3925840
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xzQUYDPYt0Oy0AwSMRQ07TrpM117NJ/91ePQgqEhKxA=; b=U+aGRRRpawKefDrh
 k2wbcpEtJpqRIuWfHu5KoLm2jOZyj6f8+MhX40ywbE4paj4UaP+wzsLjTXqeBbUg
 WFZjEENRrL8vcy7t8QIzlOz4dGembQg0ewHpqzf0cOCsAp8/V0W6BrMez2C6V6MA
 eW/2G4JqnOsn3me2nQ/teXO7TD+ghnuAU7GAPSI4YoF/mOISbcn9x3foNh6xdb7K
 fMCwJeIlBLjjEJmC5LpyjwFMN1QGZx2EuL2JM2WwPKqdc70QI45A1PfeJE9vljJT
 HYnn8LAPEKhdWtBA9iESHzUB3UW/no6USEmcYstObxeuXChKp+Hdyq1jjdMI0JM9
 rnysZQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49u42fwc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:17:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34ef0362d95so4138318eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791235060; x=1791839860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xzQUYDPYt0Oy0AwSMRQ07TrpM117NJ/91ePQgqEhKxA=;
 b=jDd8knMKSMsGj5/nbEULrbDCGxv59OlxcjeaMpKtOYx9vmG2HobX3EChTkXX5BM+M2
 irBF6fOkZ0+VQ8gVeyvIOvhHGCFW3NiqGATr+7OjMCquyIr3NTOJLaXvUpckxpJmLUwA
 JclLiLrsEzICxT7ft46hVMmu2gEI2OAnf5Pjx7hyWj0Th3o7BjCGIHtTlZVmsvzcQhxW
 lp2FK8iYjJiewLKpjuZcqWkgf5co4TR4kG3qFat/1MJ566UYiSkzVf45DmiygFpwrzxt
 /FPboBYQ5W273Y/x7P9+iaWXfdgheMOrVw7bslEBzjdId3DQvYgPfgtwscdE2HAn6KKR
 SFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791235060; x=1791839860;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xzQUYDPYt0Oy0AwSMRQ07TrpM117NJ/91ePQgqEhKxA=;
 b=gdHwsGDomQ0L6pWuSrQO3xK/U19wBHulcxyyF+loRfZNNI1e8urrTSpdvXdzSM8WyL
 20kmGsTc39rqc0XNLRgMPNr1tfiZZIWS9/sTpsgOGxmkEBSED1tyNVO+LHFtS6tcQklb
 Qk5e319EMEGPNPtzFvT9gErWZkn6rQZlqCRlljPvlUL8FGcUxzh5dAk/j7N0eeISfI8x
 0Jy9scCyuZ4hbAAw/9CaHb6DA/iBmCYj8mHlNbOsADgN22U9cHqsYW7GWwCVrQd6T4eo
 2wVcQwa9/9s5Z+bkJpnuOxdY9gnPBlapqYzWmhb7pn2pArfvNsusuAf95WP/osba49Vs
 nFFg==
X-Gm-Message-State: AFuF++nzzlkcK/sI4/LZ8J0dMYB8/AF1LeqVsVFGIJd14fneL5C2ThtX
 TFmnlrlc8S2uqPa8yO39gvA3BQte1pLOr/25UFQaArAlaf5+1PbT3FxowPBAACeobqSxaQH8faV
 QWAI+F32fBgpYGPONHi6njNn7WL4ZyQFGv6A3YerdUgZoZxKl553vOkOHP9c5quMiSg==
X-Gm-Gg: AYBFou0Sjvc/uKGLjXS4m+vSJCLC7yYHojjoc+hBOZnMbCVEOJ4oyr+NW3MB854urjX
 9MwFQNe1DVe+Tq/bu6+s7vJfL7M3DMmr3DSFn096s1c3YmsD4aX+PySiXJRb0XiEyjSy/CuiImm
 ZjGJ9XJHHLMXgWL+2Ay9kFA5JzICfIEGltwauCcL5MDPIwMavUjikVI4de7m67yntbe+L/j2H7h
 f8L7wHqBHxWjSuNSEsFQO3gfwVseiEFPApd060If/jk07CNNq45+y55K3iOilHIlxoazUilc9B4
 pAYsuZEEYdxH07Y1CBUWZABfcV+AJWGSPaCyFxDtCs4ev1oPSk50WeYnyDtbESO+Ss6Jd6lpYTL
 FzaN1vDHmMOavwgTd5Wwph0xGFxZhcgSE2IaQn23HdLxogu6BwxthTeZU7NRsEo8riruTvQ==
X-Received: by 2002:a05:693c:8201:b0:33e:c164:b5d7 with SMTP id
 5a478bee46e88-351111c4b20mr8921057eec.3.1791235059893; 
 Mon, 05 Oct 2026 14:17:39 -0700 (PDT)
X-Received: by 2002:a05:693c:8201:b0:33e:c164:b5d7 with SMTP id
 5a478bee46e88-351111c4b20mr8921030eec.3.1791235059034; 
 Mon, 05 Oct 2026 14:17:39 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351468b2920sm999357eec.4.2026.10.05.14.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 14:17:38 -0700 (PDT)
Message-ID: <13fe9395-2ed0-41ff-89c3-336f1cc72170@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 14:17:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix register handle encoding to reserve NULL as
 invalid
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 y zhou <yzhou.dev@outlook.com>, qemu-stable@nongnu.org
References: <20261005181817.403766-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261005181817.403766-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cCWW2atz6HIR-pLcss_gyPG3DXXNIfl7
X-Proofpoint-GUID: cCWW2atz6HIR-pLcss_gyPG3DXXNIfl7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4MyBTYWx0ZWRfXwf9gWcuky1Yx
 omUFFIUuKSvN+Ohjx0H5+3E2+/63kkK5OTJR2AiVhvDQFx6EdBj4cfamwXFpUuhiyx8UrZIUMvS
 jPS8TrEu4BccHVSyGb4K2WWdX1b97CM=
X-Authority-Analysis: v=2.4 cv=LuEHWXdc c=1 sm=1 tr=0 ts=6ac413f4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=UqCG9HQmAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dGsWvjqBAAAA:8
 a=69wJf7TsAAAA:8 a=Xwn8AR_0QGYS6JtUd3AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22 a=EwAE0RQWx3bH85eTCWcH:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4MyBTYWx0ZWRfX8FnJTTA9SNp0
 ub3bMNj6H+JPjYPqVcAtoX2LszEfzgXhcZVWD28Rnc9M9GZnSpqLuHq9UkzFghEaJmjk4p6cPNb
 LhsgsGFgdkfkBIpDczZm7A0H1kNRSuJgkoDmBKEqEzbTj0Qwpi5/aYocdPc4seCaKmvGjYQEXzT
 RM23v6U98FjGWL5hdcTpbrFpoDCBw/vpXOwQlypc5oqmo6Y+AHRJh0qSxprM3KxiGxbUZhCUIcI
 irfEIZTnFhm+Ghyy+AO1XyUNyBDHpOebZHMslk8ZH01EECNvehNyZXfd+8fcx3hlF1xk3KcEdpf
 qwpvKRSlhU/D3YbTHnUIGX8YZhK5KWLqkxRJOVjqvQbn0ASztYYPBA51w2cD/ZpGjjKPhW8PqIh
 KbNOgMulicbXO0E9kKmJWfVU/QUK7jJjDAZ0g1f3UcAvgKs5bxY7pfDF67m6zQyVYI1bhM1VMeL
 xX2VyW/6K2YBy8exL7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050083
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

On 10/5/2026 11:18 AM, Pierrick Bouvier wrote:
> From: y zhou <yzhou.dev@outlook.com>
> 
> The opaque register handles returned by qemu_plugin_get_registers()
> are currently encoded as:
> 
>     handle = (gdb_reg << 1) | read_only_bit
> 
> For the first core register of every target -- gdb_reg 0, not
> read-only -- this encodes to GINT_TO_POINTER(0), i.e. NULL. That is
> x86_64 "rax", aarch64 "x0" and ppc "r0", among others.
> 
> A NULL handle is indistinguishable from an invalid one, so any plugin
> that defensively checks its handles silently loses access to the
> first core register (where the Linux syscall number lives on x86_64,
> for example). Passing NULL to qemu_plugin_write_register() instead of
> being rejected silently writes register 0.
> 
> Restore the invariant that NULL is never a valid handle by keeping an
> offset on the gdb register number, as was already done before the
> read-only property was packed into the handle (see v10.0.0, where
> handles were encoded as GINT_TO_POINTER(gdb_reg + 1)):
> 
>     handle = ((gdb_reg + 1) << 1) | read_only_bit
> 
> Also assert in tests/tcg/plugins/registers.c that every descriptor
> carries a non-NULL handle: the current test passes the handles
> straight to read/write without checking them, and a handle encoding
> that maps a valid register to NULL goes unnoticed for that reason.
> 
> Found while writing a system-mode syscall tracing plugin, which could
> read neither the syscall number on x86_64 nor the first argument on
> aarch64 (both handles came back NULL). Auditing every
> GINT_TO_POINTER/GPOINTER_TO_INT site in the tree shows this is the
> only place where a valid entity encodes to NULL.
> 
> Fixes: 55327b85ce32c ("plugins: prohibit writing to read-only registers")
> Signed-off-by: y zhou <yzhou.dev@outlook.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Cc: Alexandre Iooss <erdnaxe@crans.org>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  plugins/api.c                 | 7 ++++---
>  tests/tcg/plugins/registers.c | 8 ++++++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

