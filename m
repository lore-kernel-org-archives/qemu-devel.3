Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7549DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh20y-000253-FH; Tue, 07 Jul 2026 05:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh20w-00024Y-SX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:22:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh20u-00054d-5f
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:22:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678Ddas3076621
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jof1QCQ2Fm0HCQE+swJswZVmXIvSghenR431trUEzI0=; b=hidGnpJU8u8iL/uh
 LAnD3qo1xEN0FDZujQShbIFSiuGtUMb7kFEVFIhV0PfXFDhc3CS5eshOoBorLP5n
 3pvYMhYbpbD4YofhaGIc+9ZNMmqi7JfBkCenmCB7hMYcliasr/CYH/t5i9cdLv6o
 VV3IxYt5uKc29+YoYHLTv/p38jv3m2b3AnHoYutYLAiIBPn1C67nTc58VCHoejJ7
 o5hZJSH0U2zJEUqrUmXvexCiSiWsbEQG3QaH7sPgT3Tt1/B75VdtiO5xF9MeCqAE
 AiRRdFPjCp8901dPbl8eXhaxs25rA92XAEKdvm/kAuuDK6g7nfSHqG4l0v8XJkUl
 zDccjg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun0h3j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:22:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso5497881cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783416166; x=1784020966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jof1QCQ2Fm0HCQE+swJswZVmXIvSghenR431trUEzI0=;
 b=kWbZYFY2HHkPEDK67PbiCjxOci/pa+ZVTBQYbsv9+lO3BiUCBhR2MNshWLlK+jcLnv
 z6P1KpexOfd6pcKeYuOHoYj62zLHL7e0ta3AGqkFauWSu0+N4g1z9qCoxbmMUyKQJBMq
 B36FRJsL3oaGFczA4XTLPB/Y59d/Y9TfhJkuh2C3DDZ9roqwUZVUuCpNOGjiGgR+MsNt
 Xxb6kzntX51u886eux9VsdVN3F2bjLENZihVdn7rXAs/3VzFlsHVquOUItBtkvn7lk4S
 ngbsSYOS5DpHPXd0jjvGoC1qQXusHTRGlELLavDL/1/+/UdpuPctTfWgywavKjXTlOe/
 7jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783416166; x=1784020966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jof1QCQ2Fm0HCQE+swJswZVmXIvSghenR431trUEzI0=;
 b=s+BmmcJsn+SfziHkt9qXHUFca50M/sa4zQ/3XlA78su7zR7GNdL15XONLzM/OhPwf4
 vqNhH6RN0BqqiM/agbZljhuLiyC0igmd2Ove4fZf3JKicTYCWMiisSzWfM3UdknQQbhH
 KP0f0666MmFGjd09HQ2SQSFP+oza9GUnW/zu1n29zer5MIfXPjKDyELg+QZLMKVmYlId
 H7K8JTC4uKIF560IG/NLY0w3VgThaQH/8eEjKBD0od7YP5nA5w2/fD6Dae/hTO//dYuj
 DCHkD679zQ6Rl7m956pD5aYEtc72qc+VXEQmk3W8rjZvF8RkiO6TAfA3jlBdbKWZBPRb
 oEyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJCGUUb6JgcHZi1xb0SYiVbBGd4WSm4ppRF1TujY6EHn53HOwSU7Um5Ehowy0FL+xTdcp8Em5pigMm@nongnu.org
X-Gm-Message-State: AOJu0YyZLJIJaW4kbNDllZ+khm/cY5Q61NI2LSm9oOrXu9OWEslFgTTa
 3V1Zq5ImJOlicoejGF3yqcInY3ozKQKM+L8PQaLOU8AXkkNKzfPJ7tgPhSCBYf2azpCMFLeqgbp
 rrdOiu+6o5pX/tDH3lyrXK21fu+Riz32LHCjWvYoyVW6b4il+cOCZny+xuz8GscmEVQ==
X-Gm-Gg: AfdE7cn4y7TLn5WhlIgF4rR6rw+q4abxNwp9dGM8DsotyhL3CErBgIo+3/WSA8BS8N1
 wk3QhpHq5tJHob5cQG73RSDHLFDf9wlnUq159G7FpEU2SOw915nHCvHq2tvkBlbDZXWF8cIoydG
 eMlarX0TanAvOQdMXGW2yVcIUd2HDZbRbrRnYtSelOBD/yTdA8CGlxBHMiAUWmZ0mWoK6ITIoP0
 CINieFQQWZNuf7o8FXMwL/zm6mE74N0R9riuV3UVuU5YUc6h8P/Im3lpuAU1OSBYmEMnU5J1Odq
 agEzn3TbvkauL2l1IqC5HJnHcIJVA07gz6AHqpj4rMb1Zk/scrSIu35JPhn5sxo5hFp83CrKFmk
 zWHcZF25iGZwT7IZxbetNX2Mbn48aUnTuYgTO7HkC+rk0uZzs2PPNRz50sjx/9Q==
X-Received: by 2002:a05:622a:164f:b0:51c:f55:a1e0 with SMTP id
 d75a77b69052e-51c7a786274mr15661871cf.36.1783416165509; 
 Tue, 07 Jul 2026 02:22:45 -0700 (PDT)
X-Received: by 2002:a05:622a:164f:b0:51c:f55:a1e0 with SMTP id
 d75a77b69052e-51c7a786274mr15661731cf.36.1783416165130; 
 Tue, 07 Jul 2026 02:22:45 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad8563desm91278266b.24.2026.07.07.02.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:22:44 -0700 (PDT)
Message-ID: <b87a9989-b2f0-4d05-adc6-906f2fbe9fb7@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] hw/misc/aspeed_scu: Add separate reset handler for
 AST2700 SCUIO
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707060919.350637-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX54hvf/CJIVlp
 DVJUjRWI1qIVOREYM68NxaavFPr0K1duCU1UB+zVbCWTb9+J7YeeXbcNT0uxm2vyEYaYd14JOtY
 sMdiFePR6hTRNLpjhK1aeGUUjAsPnns=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX0uqNXAi7oo9x
 QcNPhGTScBF6Rssntcf8zIbnoJXPlIGpx6Jo4t/w56rUn3srVEhQQW3vcRLX3odCgp6JNJIoZGd
 +joUBdSF7aNppotdtNI5uY9nIeRUrTSmERwLR7LfqCSF+Yvaij0GIHoLwVp1mSYvRcWHhJwqkQa
 a7uB8C6r/V3nq8r22Gvck4P4sx6XNe7/U/UCQNYCfjq3xdyQ/XyfHcqI17Vv/uq666HCh3/v7NB
 eucoZlhccK9oZOFypmNQqRJZzpsRtHdMHMw08pK9+QSIOEK6UQNtyJjJBBZ6nbmhQgG6OAO+lsa
 daRIeVfKqlqK7B36rmRkKGNOImWL5U05bJGqa5HFIMOPwbmKGzowz90TuhpX3H2FMlURJSRr+vj
 STB/HXVXbhYGMa/fVxIxxLbeBgcAzVACd0kGB1RzrLXYyxfUkxICAnI8XRU8V5Gdeabg7imTaUq
 Xfo8fgSDlgBw3auurlw==
X-Proofpoint-GUID: lfGETAcg0ey8CRiz3kT9_OKsJbi53nnD
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4cc566 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-ORIG-GUID: lfGETAcg0ey8CRiz3kT9_OKsJbi53nnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 7/7/26 08:09, Jamin Lin wrote:
> Introduce a dedicated reset handler for SCUIO.
> 
> Previously, SCU and SCUIO shared the same reset handler. This no longer
> fits the AST2700 design, where SCU uses the Aspeed2700SCUState subclass
> and will handle coprocessor-related control in future changes.
> 
> Since these controls are defined in SCU (not SCUIO), SCU and SCUIO
> should not share the same reset logic.
> 
> This change gives SCUIO its own reset handler and prepares for upcoming
> SCU-specific functionality.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/misc/aspeed_scu.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

