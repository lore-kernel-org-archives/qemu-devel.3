Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A63C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uCA-00075d-47; Mon, 31 Aug 2026 01:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uC1-000757-FL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:04:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uBz-0006aL-D3
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:04:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52NE43678670
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oswsUP+CRX6kLq8yTyjleMpGuJ+YfB26j6ccOi34I+Q=; b=PnILdNOltJ6bGyu6
 HmNePXgPp6ZFDE+wKlBCG9/aeLir/qECFV6Lid7m7moEQrX40SUabppUrdXnF0Qn
 pUKE4/QuYbaLr1KbI1zU8X34puyUqMgkLN89DyEdpk82uNr36J4GqUokbCrZ39Hw
 NmV6FVP573X/Q5WF3Tq0aHNpR7plwuEA+lD7/dHjhwgHDuFJc7W98cZrMv4y8ECR
 rrW40axPuVgmDDHls9jkzRmLd/Jbsh0ssztpCFztkQHrhXFyQXWVvITIPRpXeCTy
 tEvo/jpThA1sczRBYT//eGoFAQPe7tQJDsT7rgXlXtW1Q5mdCfBhuRq76d8+l9zg
 0Ww/6g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h0w62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:04:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939187562a1so743176085a.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788152659; x=1788757459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oswsUP+CRX6kLq8yTyjleMpGuJ+YfB26j6ccOi34I+Q=;
 b=cKl2ZqVcfssRoOUCRoNPiUfvylYzKX36jSVE962eDun4qSXvEaNCex8Fl7DWdy3IEQ
 jp7Ng0R4LGXkNlpZh5rWHAktt8+feK3uWOujN18r+Xray/hbdVC34EMrTWaPLrRjv20b
 fqUKKLZF2cYvUJH4FmfwxxSWM9YyZb9vYZ6I91uBbOvQR6ffEdSf8SAbDbHEYCvK2NUT
 w0H6BUR4dUk+6ksw8JSTs2MjJXQsmWUHd3/6reQn5M5/JFvbT8sgRfKas7C7p8Yfodyn
 g+yXgKujgLyAdF2122Ap7uCGL1kXjhPppC8G/VhxKXwLFfUCWUKog4rxzsA9Bl2SJAnL
 k43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788152659; x=1788757459;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oswsUP+CRX6kLq8yTyjleMpGuJ+YfB26j6ccOi34I+Q=;
 b=rrtRdzdiC20RYzEONAMZAw1TRK6MgnKDuFTIjizZ5HzW9pzg9WYv7DfXmeazt5s8H6
 rUwx7s4eKOjdxJqjXKciGRDZkSdOeuN7AKDz+aUTTCveZVAgCNEjFyemKwPirh3jHpMa
 JtfLI5SD7VUiP4mEu1dmrrn1/YbLIapGfujTc3iI6WbZsfZcAT6I76QojKEaZIltcqKK
 tk6lN14JHSlRgZzsnR3fi6bQ9DM+oseZ9DuBvuS/kImwDgBa39SHC2QUqK02yTPKTaDT
 3EtYWVpO/QMt0knVApImkmO8LJCL8/yE8VgmjaMxFHY9D+r0ETT5QyticULGIX01zKSw
 2G/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrgAP1qe4SM/or+z4gjp73V4eUyyB3hbQ4yB828RRtyQjF9+siYsGoO6LbJDHAD0F0zRcxDbeqRQ8l@nongnu.org
X-Gm-Message-State: AFuF++nSEbhxJBdmzgLfsuxU9Bk6SmNIO4Ldhj5vdJf+Det13mw0hzi5
 LlKiNYuhR8XiQd6HsyXI81jEFNVjKtZ242sRkpjh7Y2nKG+LA1GsmvfVZrk+6aLTLZenABJM0pG
 JQFA5fs9NThQkpcey5xe2bRFH0wcegkm5QZEvTfyHCT0LLWTFqwv99oqxJg==
X-Gm-Gg: AR+sD10HboH/F5b5qwWZRjeBbMxI9WFKBderCyHQCOQj3nriJGVWe/lT2sIeBLuV8Q2
 l2hQy2gUTJaR/UvJIU7Af+ivsFO2g6fjRa8RSsDsMUjRRjnWtvPMCTWwiJ9a5H/2njI5Ijcag/H
 oPa9mCOynw2Bwpxqrnhvg8xfV3Phn3oZPbGVKADYb0+X3qFAZ55CZZSb2z51P1MMbKYpQGGGMto
 iaVechvu/PvNhT/YwWnd5I9bZLj6UDaxYf2P6jbs33p+o7ppl50M7LS6Tcpl0GP72IRa1LwCUC8
 ob9TkVULmWflnc96Iq6/gQYypPTUP4FUjE/Mu8IffuXVdYn55pOfhY0uJx+M5QGXwkL9Jsr8LB7
 AHEvtPrn+gLOW7rjPKQ7n5dMIvgfc+77bWg==
X-Received: by 2002:a05:620a:46a2:b0:930:f129:1a45 with SMTP id
 af79cd13be357-93913923d59mr2423388785a.30.1788152659474; 
 Sun, 30 Aug 2026 22:04:19 -0700 (PDT)
X-Received: by 2002:a05:620a:46a2:b0:930:f129:1a45 with SMTP id
 af79cd13be357-93913923d59mr2423383585a.30.1788152659004; 
 Sun, 30 Aug 2026 22:04:19 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4942298fsm352574695e9.1.2026.08.30.22.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 22:04:18 -0700 (PDT)
Message-ID: <65d5d8d2-d63e-4bbf-afb0-d65ddcb85a50@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 07:04:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] hw/intc/riscv_aplic: Take a MemoryRegion for the
 created device
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-5-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831021500.82565-5-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a950b54 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=c8oAG7Qat8bFSpU1qJEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfXy777oPKdI3Bx
 3tNjN4sUq34hR12IrzIRbxoOWEZf9KHLjBGmz6fCExhWGAlfrtCaZNT4eUVWOFPhrcOLUp0MbdI
 cU53EZhDfHN92MoyBKKeSlCEfsMRU96wktmY5g9wD8hW8kzTR2eYfWHdE6LCGOwpd/XDTeHOKwL
 gFYKnXTQEgjMbrlSNB/LONi2EE9HSUHiXQ11oSMcjRSZD5zsHX7m1AJblQaXZDIxlmTbX8ysBbq
 95TSyH+IRHnLk7Onv+r90L/3QOeImKDQnDL0WK4gLO7cBBQkH+C4I7mZsVG7ovLScRtghUT/eVk
 okZhDpWCiZmeW+Y1ul7lTcJ44acS+ocMyNhlZovku54kiHLO1salfnXy2//nT3DtdfmxzKHxAHE
 yZXZx/epl6Fq8kw2IXTZjl2Ag8dts7euyi3kJQEJC3NaT7qU4+ICTZPLVDx/D0/aWthAaRlK1hL
 1kEzWMeHS9QU2dx24/g==
X-Proofpoint-ORIG-GUID: OuYOvZH9JUuxyzxg8q382yBIu3hNlcqR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX++TEbuQ6sCwR
 LsmP0xafRYaUg1ufDhUtfu4D3QBKHmbIJrChthsWCJgr064StoZnd0o6mWL+RF31oWDc/aB6eR1
 jxkcHwQlAE8FEXSPlHwMp3VDWqwKrlQ=
X-Proofpoint-GUID: OuYOvZH9JUuxyzxg8q382yBIu3hNlcqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310041
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

On 31/8/26 04:14, Joel Stanley wrote:
> riscv_aplic_create() maps the device it creates into system_memory,
> which prevents its use by SoCs that map devices into their own memory
> container.
> 
> Add a MemoryRegion parameter and map the device into it instead of
> calling sysbus_mmio_map(). The mapping still only happens when the
> APLIC is emulated. All callers pass system_memory, so there is no
> change in behaviour.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/intc/riscv_aplic.h | 2 +-
>   hw/intc/riscv_aplic.c         | 5 +++--
>   hw/riscv/aia.c                | 6 ++++--
>   hw/riscv/cps.c                | 6 ++++--
>   hw/riscv/xiangshan_kmh.c      | 6 ++++--
>   5 files changed, 16 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

