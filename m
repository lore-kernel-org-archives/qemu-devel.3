Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEBDEB3641
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 00:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxDC9-0006nj-CS; Mon, 02 Mar 2026 19:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vxDC6-0006mL-Un
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 19:00:59 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vxDC4-0007Fg-BO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 19:00:58 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622Iuoac1187020
 for <qemu-devel@nongnu.org>; Tue, 3 Mar 2026 00:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EXM+H/bF/gKQWMSsAEYM6N1wR9orXlh40uOHx3WoGyw=; b=WIpRxXCQsqaGJcxm
 UPeY3NF7fML2WmdjkotId4+X9B3sHFdi1sH2XPqz0D0E/fT9yKMX6p0SlwT0T4t5
 NkvuqjYcdyxRuItleWibjjOrAH/NZSHlUjCIzEGyLycB087lkW7dIiUcTDk0yBLN
 kRj74YdOZQfj7+VAH3mrn1pktIqAOIEdtnnbPkqVAkD8GkSYOlV22jTEm+i5v+Tp
 u2kG7MPZLNq80jBZopywSI7657siMu/bcN2K1mtq9I6ynR8LR4CMc/HDH41lT2fx
 Oia+f8nBTXrlTwP1zG2HjieLaevwAGVgkva809Zv6FAtSolTcexUz36vsLppWvMW
 kgPKpQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cng96gtav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 00:00:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2be1b95033cso7218310eec.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 16:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772496052; x=1773100852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EXM+H/bF/gKQWMSsAEYM6N1wR9orXlh40uOHx3WoGyw=;
 b=Xo0Mg1agvCDfPHEV18jcR0zS4tgkspLYn4XDhLyDeHzgDQmL6rtEjXUgN8H+tlEq68
 4qkHHGgkFaFCoJgBPLtKF6PYW2IUIsynl4VcbBtWONodbv8tzaM/vNAxxgb5LgKv+78c
 /lRVJ8jdaNZS7yA0g2+bG7/UCd3wjF4UY2aXmIwgBHCXQdP+ytBYPjhUcCACcTWSMeO1
 9Vdcf9SiJFampjRYNVKTvpq8uUFj6IX4mJ4xOkwuOYTeaXkJAv+tm1NrENkb+f9nr2R3
 nWMCK1iSBsb3hZzLYgJzOIVXjrWxXYrgw547MnZFP8i/P3lxU3gODkgn7yFjWRN9NzH/
 uVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496052; x=1773100852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EXM+H/bF/gKQWMSsAEYM6N1wR9orXlh40uOHx3WoGyw=;
 b=RjeT2MnREy6irvIYlIzA6C8jzGqwH6xitl2HL79YCVolmotelc32jsonYwiSmRYj3O
 bScEe3rgyBgXkIEJdObXv4JIR0fHyKb7mqfeGOGnbvF/zrEn7CibarZLGYtcclq2Ncl8
 0Gxpr27H6UrQhnJWh8h9HdTcPyYfXJFkP+LLHOXu+Bm5mC/mzSkuUSdXCZBFo2N+aPjl
 wSP2u6PcjTNh6wtlnxf1Cov+NyrkSqW6JZupgaT+DlnyMQ2lxoslc1wH7hchgvZow15b
 ERCBW3PQUYaXEouchGGJyNM6vr4GBIIO0Ym8s5TLV2mhjXdbrssD0KehzPfuFWnIEcK3
 9xIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW504f3+v9sTq6D9RIEthFWmKwzICLisdxsqVqZfUz7+9AZbPEcgA9Um0dLEagBaRY83Y3b2qtJcISu@nongnu.org
X-Gm-Message-State: AOJu0YyvHe3y7KuvVULIus4jQHo3p4gP49aigXtD/14BmRTq00O0fDUT
 Eg+h91akeoGaj8e+k3hqNOmB+sjHPWB79aCFxl8NjkZqHRvXqMd7BWB9pihLh5w6qvuhxPK2jJP
 +U+CBluFpb5v3LjU+2/El3kllwj4e0zgYfOd99YE4RPSI//KjStH9GTBPkg==
X-Gm-Gg: ATEYQzyeTAGJJyMh88ktOhNabXs0NojV8Uy0Z8rttN12zmtBsUqmLnjy+Q67Xv/ZUAr
 AteqM1554266M7//r8KLC+lyVeJ8/VIp+QFKLowZkogeHKqeTMjFEWPWU+hkLrLTcpkOh77C9qu
 sXaIkx4eHx6t8QiSvZ8nOsYxJXWmrynTjyPyN8yFKpLT6llAGl38jK94wfjMMkQY2Qfw0WfMuTh
 ArfwlqD40bL5IJfMMvD+2IllnqePTr73of/BlRXkwTPVGwmnjyMkuWqkzXNpjuz3aJr+2WTYu72
 BCFqQ4YqxBpCKtM8HwKAR2Dmc2SuNhEycvVqHHtBR1jN32Uax+Cbbu132RiA653E7NDw/J1RSQk
 ZsEsmdk+IcZwm+9t6i8l55wOVcDliCU/R0xNF0e0smtBsVFp6aqVuCe9tZqU56pePy6aTTe+o42
 0H
X-Received: by 2002:a05:693c:620f:b0:2bd:f002:b326 with SMTP id
 5a478bee46e88-2bdf002c6b0mr3545051eec.28.1772496050773; 
 Mon, 02 Mar 2026 16:00:50 -0800 (PST)
X-Received: by 2002:a05:693c:620f:b0:2bd:f002:b326 with SMTP id
 5a478bee46e88-2bdf002c6b0mr3544994eec.28.1772496048821; 
 Mon, 02 Mar 2026 16:00:48 -0800 (PST)
Received: from [10.110.0.81] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdfed770dfsm6291983eec.19.2026.03.02.16.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 16:00:48 -0800 (PST)
Message-ID: <dadeb207-4ab6-48e0-86f2-04fb2e7758b1@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 16:00:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] hw/i3c/mock-i3c-target: Simplify GETMRL byte
 extraction logic
To: Jamin Lin <jamin_lin@aspeedtech.com>, "clg@kaod.org" <clg@kaod.org>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>
References: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
 <20260302032626.1974743-5-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <20260302032626.1974743-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Co6ys34D c=1 sm=1 tr=0 ts=69a624b5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=gyPcqEC5Xe3DmluL9QUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-GUID: VO7hxAV_GnktIw_hue5vMgO8dqSpuptx
X-Proofpoint-ORIG-GUID: VO7hxAV_GnktIw_hue5vMgO8dqSpuptx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE3NCBTYWx0ZWRfXzA/I6Mootp67
 0MFYaCVpxK1253GCX8KEPajI/lluiSlId6YKd1ZmnpZy6sfBva8EQ3VN6rt00z3oyMckuRMGIF6
 IyReiWrCes9b9ibxtWh++B9YqZbf4Q3CjduIW/5mp+QLdq88lMEdFP8bNeJNUR7po9CR58bmGU+
 p+2jDs+Iz4773ngBfA90R3MNSwpAoZw9DaOL1A2LCXKn4ke5qDJ8hkg7Rz4PRgyUMq+pmru06qg
 VG+hNOp6uDLWtvymUcTZPw3Wfrgj1deY+Wqsc62BjgRwje5yuySqe6h7P07NsGYRDkXhY96Butk
 PaHk2YrrjwcEYhIUbzVkm4eGfq++S5PZy9R0IBPt1N/M4ueEWc2Hn3iw52xcRktEoEIXWgcZ8+U
 5aRbOiRIjE5zck6ZxSXKr0y9NQrvbzhMlj2ZjigIoCgcdRNx1kA5ItdksPQe4f0Y+5syRmdn2Jx
 9RsHGclRRzaA0WZq0iQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020174
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/1/2026 7:26 PM, Jamin Lin wrote:
> The GETMRL handling logic extracted MSB/LSB bytes from
> s->cfg.buf_size using a mask-and-shift expression:
> 
>   (buf_size & (0xff00 >> (offset * 8))) >>
>   (8 - (offset * 8))
> 
> While functionally correct, the expression is difficult to read
> and obscures the intent, which is simply to return a 16-bit value
> in MSB-first order.
> 
> Replace the mask/shift formula with explicit MSB/LSB extraction:
> 
>   offset == 0 -> buf_size >> 8
>   offset == 1 -> buf_size & 0xff
> 
> This makes the code clearer and easier to review without altering
> behavior or data ordering.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/i3c/mock-i3c-target.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c
> index 5c913ee49b..845c173427 100644
> --- a/hw/i3c/mock-i3c-target.c
> +++ b/hw/i3c/mock-i3c-target.c
> @@ -145,9 +145,12 @@ static int mock_i3c_target_handle_ccc_read(I3CTarget *i3c, uint8_t *data,
>              if (s->ccc_byte_offset >= 2) {
>                  break;
>              }
> -            data[s->ccc_byte_offset] = (s->cfg.buf_size &
> -                                        (0xff00 >> (s->ccc_byte_offset * 8))) >>
> -                                        (8 - (s->ccc_byte_offset * 8));
> +            if (s->ccc_byte_offset == 0) {
> +                data[s->ccc_byte_offset] = (uint8_t)(s->cfg.buf_size >> 8);
> +            } else {
> +                data[s->ccc_byte_offset] = (uint8_t)s->cfg.buf_size;
> +            }
> +
>              s->ccc_byte_offset++;
>              *num_read = num_to_read;
>          }

Looks way more readable

Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>


Thanks
Jithu

