Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36FCC5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtSLN-0006DD-RS; Mon, 10 Aug 2026 11:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtSLJ-00069X-Q0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:55:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtSLH-0000Pa-Im
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:55:13 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AFWO5h2091160
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dgQdHp6YjHSCAIGPr0kW6Iii7LIMsIERNq4PlYQ6VxI=; b=hfxpClxn3EJoentL
 EnWkktC4dDxl1kcBi2TtFaifhCipEySG7sVoD0Mp9mgsia7rgAAAT6bpJZ2eidKN
 ytmNxX5IrXq8Ig5hrWPmryNurbBWMYaXzJEyHMgOE2Yo+wD7rqFaRAfrMTUoOqXH
 ia33fpYjd6w1DIkqiHBgGD2Op5/cRlPyJWW+bCZC4NXZQQkIiXOeasMyC1sUpWTd
 3bFJnWNNdaszfQrGWS8FDLD0Zn3aPWOk/iabqYEOdUE9Tw9HqKgzVQJsBJAxwWgu
 WgFfvH1EG06psVHOJWbwMaiQoEDw4YVQ2OWU+tLjB2veBpDIyb86Q+9ZJvdZGSZV
 WepDUQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fybh59s18-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:55:05 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cab041eced3so3522109a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786377305; x=1786982105; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dgQdHp6YjHSCAIGPr0kW6Iii7LIMsIERNq4PlYQ6VxI=;
 b=LkSd0e0QzNfy1AniJKJbLHYyiJPckpxRNUGRLVDg/gHReptX7R+1JI4FCzNSyva1Qb
 nIvtloFW0VXMotiVEingK4oqGJJ46QISsXeZiRTyiNjrjF7aL3UKWsg5h/jFwy+Xrvwq
 xeL9nURozorLGSozzSiOsFHzNLENf1QYRDHKxpKaWgw3DHwbNZ+A0CVas0dx8FFAHa0q
 +X+IdcUok7mK/KqmSHy0AmzieaJbWYD8J0Kle7nRAI/yRSjWbqBvMtRnGcqeFL8BKktp
 vARGKESwQZRrsia3gnN8+wzvOURLYxTtnUHT9ko7IM3lqhnjh5xulQCxqaVgc+w9qCQN
 OZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786377305; x=1786982105;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dgQdHp6YjHSCAIGPr0kW6Iii7LIMsIERNq4PlYQ6VxI=;
 b=Srr7COJZD0AnAZSLd53nBAwnlTQ2hSLEcTU1X+293XFP7YON+HFaMO9ytsuy5zeLic
 /4JJ7Ro31gg8nqp/05Ogj4gFnB8Ivyztq8GVnAxunobgiV8GcgqL672KRcdsZ8SBt+Vj
 MbWYORpwNbgZNRoxBVrtTVt9St8abRZI2TvPcwlhfdIKCl+F+Ng4NssTI81mi45obSk8
 EknPCkklTDzbjrjGRkQox94g5N94CdVDgHZQTAyLSTahZrbWJLREQTDr4tXqKdJRcXDf
 C747eQXLazYp3PFieWqAUiBFHFXbbnI70BYZoaIxBIhLFapL4ZB2pde/4RG3PGAPwuNV
 DnZw==
X-Gm-Message-State: AOJu0YwBSFBdHMi6pGdZOSLNQuHGgiBsS6qMgnmybM+bb91LPgWo9xjz
 R3yKxW2cBKpSz3tPnCUTLqKMBKuYf3A9OsfxxSIGj/TWVkq+yMeh7yGTe3aS7JBy6izaVX5TY74
 FUiK4w1YUMsP2qw2AOv0/pucYyB/aDo2xu0k4xiBInl8vcw3a9CQsjgCICA==
X-Gm-Gg: AR+sD12RqRm4vL2lXE3YZ2rauKVzs9zXhDc+7CRHjSIIwEEcka9WP65pVEO0yysBonk
 vim0shqarRfT0tgdfzkyVmOgu7EQUP1CTBSL0ImvGD53nxELXtLuiC2bnwZsDY7gdOvRd++cxTy
 LQdmZOZL1WZZXdkeDNMB4nLAYocpPY24yvrA6se+QX75tjTqEdzRWBLa0AfxUW8eZZ4DoFYv8Mx
 44Hu1+iE+ckk9+ux14DQdD12gRsSQmB35W23YMakOrcx948ypNAedQngOHi2cNLbMsynhyqAB3W
 yfSAzAyRTVPNKN5BfdAt7R1iep2SdG69wYREYWpjEY6YCHXzALGIZuk2t/b6v7zoA2sV2dgUHHH
 5nqjhLFoCBkSaiay9iPQXDt4/a/ksPSImljuvs8QhxSbm+24OV1usTVmO4Ezq7FzoeDey
X-Received: by 2002:a05:6a21:482:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3cc1a1fca65mr4020037637.13.1786377304782; 
 Mon, 10 Aug 2026 08:55:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:482:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3cc1a1fca65mr4019964637.13.1786377304302; 
 Mon, 10 Aug 2026 08:55:04 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a706fsm43095891eec.8.2026.08.10.08.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 08:55:03 -0700 (PDT)
Message-ID: <e4f25ac5-2817-456e-9ea7-f03ff8f625f3@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 08:55:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <CAFEAcA_h7t7hF=i0xSh1DLq9Dmy-VL+fBa09R5RS6BOTFXLj=g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA_h7t7hF=i0xSh1DLq9Dmy-VL+fBa09R5RS6BOTFXLj=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a79f459 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=tWXS6pJfiyHjNtKKHzEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: Tn65BNsDzElZWnE80DwGnt81W537byvc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNiBTYWx0ZWRfXx3TKUt6rD+WA
 5VCxicQW9PuL9MCYmT4FymVge14xSAXdUdIhSVrok2LIfU/E0LAQtKTk/4AUn7eembw4EeqHWc3
 1IBW2q3jm+IZW0919O+KAILbZ7gOlxY=
X-Proofpoint-GUID: Tn65BNsDzElZWnE80DwGnt81W537byvc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNiBTYWx0ZWRfXx61MlKtzdaAr
 kddDIpm0uoV3dCzxMVbR5iktbqACsOw2Mkv1+VbQQ9AvtsIB0wHrbIfp3RZz9XvHqbzBTtgdfJY
 rxJ1u+t6OzWOj5rFnhTGTVfWJI4mk3xonnDOLeVc9NKY0SbKi77kxdbEZaPvoo6NzRX4XmTskdt
 EvPix6sh/H8PxM4h93dd854cD4oEmz3b0rUNbqYOhBZXNvdfi97v0kvry5mAa/cx2FuoVqCm5NY
 wBSoiE0Oh4hZ6GAumFpkC/UvizZgT60gjbAYTCbwhGGYMchCwlyQ4nSszpD8FHk17DEMBDjy7x/
 FAJqEQey7ubQKq7uVtKGgQsaqudqpdtp2FFV0w6xI+WWHLZxkb1GZPXhjqykD2L3IhAKHXMEb+Q
 RenA6NRregx4jSUnTM6L2URtZbOK7PcIJmVMBazRLQufUsO2ap/OJEtFdpacY1cGQBmZWJFdIAu
 VbM30USu+Rh0LppIFOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100136
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/10/2026 8:46 AM, Peter Maydell wrote:
> On Fri, 24 Jul 2026 at 01:09, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> Now that we can link a single-binary with at least two targets (arm, aarch64),
>> we want to make sure that we expose the same set of machines (later devices and
>> cpus) than target binaries. For that, we implemented a static filtering based on
>> target interfaces that each machine will implement to declare which targets have
>> this machine.
>>
>> However, we discovered that this static filtering is not enough. Indeed, some
>> machines and devices do not depend only on target, and their presence can depend
>> on Kconfig or host/target combination. Thus, our static approach can't work, and
>> we need something more flexible.
> 
> Do you have some specific examples of where the static filtering isn't
> sufficient? I can certainly believe that we have some at the moment,
> but I'm curious about how much of that is "just by accident because
> ifdefs were the easy thing to do" versus when the filtering makes
> sense for avoiding showing the user things that won't work.
> 
> -- PMM

As you can see in the series, machines nitro and x-remote are concerned
(they depend on host/guest combination - summarized by a target config
entry). There are additional devices I found also (igpd bus, plus nitro
devices), but I wanted to validate approach on machines first.
I didn't observe any cpu (yet) that needs this extra flexibility.
This is only for arm/aarch64 combination, I expect we'll have other
cases as we add new archs in single-binary.

Also, there is a benefit to register *all* types and filter them
afterward: we can identify conflicting QOM types with any combination,
and not only depending on which targets gets enabled.
Finally, this approach is much less verbose than adding an if (cond) {}
on every type_register_static location.

Do you have an alternative suggestion that would retain all those
benefits, but would be better in your option?

Thanks,
Pierrick

