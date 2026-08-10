Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8A7C5AD5A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtG9y-0002w6-0K; Sun, 09 Aug 2026 22:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtG9t-0002vX-Mo
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:54:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtG9s-0004Sk-3e
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:54:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679L7T7F3729753
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 suiS8bifuUcVzwQvQASgLGT2oZcGYAS9MWbTZ41EJRg=; b=Zu2BC1NPny+IFhkW
 5Dv1P2aX/bYLnYKvl5UCu5Dz87r96G6FYa32mW7XID5GIDdGnTbWmVRnvWMicWiM
 o0/Ra+EX8rdwpCJQDd/p5JJvPOUAkJdUdH8iQk2yjQ+/Q4RAuiiCwtP9laL37KYt
 JJvRrfJ4SvKmCItEGV6DE9bGEfkLy2w4gxZTD4vVd21Lu1qafCfXbeeT4SGVyCih
 dw6F0CRv77Y0mq0NPliO8sf1mdq9OqgK2K2T7a6kJGPUXlo7UKDX6d9va7wMGLMK
 P2YUmou3VlSRp2GTD5vsRWlVdpUm72KMqwX5OkGsIw/v54uL1TatYwPdSDefITz8
 D7AkmA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwush45ta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:54:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a23afcbso16567771cf.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786330474; x=1786935274; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=suiS8bifuUcVzwQvQASgLGT2oZcGYAS9MWbTZ41EJRg=;
 b=FszaI+ZHmtHogLEVABgI+KnQw1HUtw+OR3pK9CdcggU5OXMZPmHdMDzuH/C5qRQpkT
 6RH7lWoQ+2V+8RMDqsYNR4rpAL/7ZIDIUHOyNE78IciaBvW06ALLuNfe7LEbdRH6tdCE
 zVpviWjonI1YoMmEWQg+vPRS4/m7wK2zTB1rO10U8igHIkhBXZaTWkyZN68kq1Slu19g
 +zIQffgciidZQ8GFXEiOTCBtV6Iz7RFm9+dzyD9VOV/Ts6hSHEovNBni5GOPbrEUvzyg
 qwzm0tqLwFMc8uLUrYSMT+k5AgLv1czzuV5mKs1N6bB7hGAuvJt90RWI5S6wniIfs0kR
 ZGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330474; x=1786935274;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=suiS8bifuUcVzwQvQASgLGT2oZcGYAS9MWbTZ41EJRg=;
 b=QWi42wKhMxisxVGN7CSlFBm6ZfJddfXPvoOmYjUVZYonethpxeSWOLE6CwkBQn2mHd
 wDbhGOYE8wezuT80KilNIsiybAhBUnKugxpc/GiduWR5VvQOk53IgzNI1cdbmDDSLuiV
 QENBQMvlagbrbqHzuj3QecUmKxySMV4vPWLNElJ17NQHq5KL/IxVWFeRJkzDSOsByVSt
 WO81vM2RqgZP1BH0Q1O0rMPKW7LzgCX6XhgeNhBqMBDSIpF2XjMfEsdlNLAQpwrIFWET
 kthfG3/D6wFHmCRbB1vSVgxVrTpOWYj4ZpPlqtpNYVk3f/G8hxdxsXJpRMwsxeYYkoJf
 I3Lg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlsRynYN+yZ96OraXDCNgNbQd08Ooku9v0c3AHr4Gy8Kde0lS9Firo4BCnDbMVY8YFG7GOZdwUt2zR@nongnu.org
X-Gm-Message-State: AOJu0Yz1zO/TbpjysZGCQwEuxOmGaKinR/cJ3M3B78Q35vuu0/Qa288J
 vq1cky6KmHoDGpD90zPhJxzFzIkUTJcgO6pXjm8+HJnAHpZu3qvgZ34/LyVIUuOyssVwnoD63fw
 dwx87WqaFe342LQ+ppwVD4khUb/MLCTJsug0PhGa8I3Ja6ae9CLeXLyKUZQ==
X-Gm-Gg: AR+sD10m5wTGyZM+SZGbpr+AJzNZpR+qwy/ilLaFghhFKdhoTvOMU0/Sobyf0rVLDqG
 rRJzTXz0GgefPIEzcN/HzJz0tuSIEMZlJFBhGh88DcuCmB/NrgGPkUaqb5awTe4vCsl31U5tPAK
 vTaoLbf9BH6L18YvAJet+aKUkro/dgBX9CePe2m/QaRyS6xdvBwvYygTipwHiRoJkmoJALd1qcx
 +Pl22IetAPVIBEGCCtvmWDkU4diVNuWV/83W0kKVN213fYJZ4udP+Qb3j79g/VNW4iM0Pl6DVYO
 7pGdUViXAh1vljcmsIJ9yAXpK1RW8L8R0KKcnkTdqamjAhfNVSpvpYhKbmeuBwPncP68RRwXsnH
 xeS/cTS8H22mA9b0O78SVpkhHogzpdCvATc4=
X-Received: by 2002:ac8:5d86:0:b0:51b:f217:539f with SMTP id
 d75a77b69052e-52d18e6eac3mr202720521cf.17.1786330474381; 
 Sun, 09 Aug 2026 19:54:34 -0700 (PDT)
X-Received: by 2002:ac8:5d86:0:b0:51b:f217:539f with SMTP id
 d75a77b69052e-52d18e6eac3mr202720231cf.17.1786330473956; 
 Sun, 09 Aug 2026 19:54:33 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c69c8ffsm197430355e9.2.2026.08.09.19.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:54:32 -0700 (PDT)
Message-ID: <00c35d87-6d4c-4a49-be3b-533bd38068e9@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:54:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/56] disas/riscv: Reduce rv_insn to uint32_t
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809223545.730664-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WPbyIE-Ihngrcnw_PncM0GWHkdn3eLTy
X-Authority-Analysis: v=2.4 cv=GvpyPE1C c=1 sm=1 tr=0 ts=6a793d6a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WPbyIE-Ihngrcnw_PncM0GWHkdn3eLTy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfX3GARowPychff
 sowUFSWMCRvjHQe+nGk/xsIA45qXcEdDVXF89tFnUV9nEZIklvodMEjm4F5XALE6RvcT+AQHNjv
 WuSYimm0j9YXmYvseerj2/wShJYN946WWRVT0VdNRIaXXX38SBuvpWCCykGqvgOmiRIvceLeVhn
 Goj/Rmnr5LVKMVLWe9NoiYOa2iwrljQ4aKzsH0kbcgyc+hCKA29B/XjfsJjCIZEEtKn5JlHzpYx
 jX3xUE6xGxk0G4AXsCUrJFyTjUA+nw+qxgQygCeuTu86H5rlemNY575UKrWtxaYPrdwkN/5hh/o
 nlgK71cEr5k1OlCvCxCw/EToXEmmLSeUnqlgbJkOOc7txoUjzn8I6MTyXhFiUbU1EthZk3V3491
 DwO9UFmVy0bT/mQM7CaykyIsQKRm0GehIK1dliPdfPApyJOUnfJUP/BsFhBqI8oeWDrOJrpDkLi
 ozDe255t6YkycThgDVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfX+fQUbrsfqQdP
 GPQvHPB9fDJcei1a0VOWoKqwhDPmNSDpFuGARAhlcvJwwR2FdXCzlsXd/9IE/Rr5pFrbcRWFTFC
 oVZlhyNf9ABwWGfFR2wJn/WMfTlDi7s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100023
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

On 10/8/26 00:34, Richard Henderson wrote:
> Since 758dce9c98a, the only possible values for
> instruction length are 2 and 4.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/riscv.h |  2 +-
>   disas/riscv.c | 12 +++---------
>   2 files changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

