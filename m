Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C565C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlvIy-0007iJ-GI; Mon, 20 Jul 2026 17:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlvIw-0007hg-Hm
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:13:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlvIv-0002VU-2n
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:13:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTh0W3663800
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 21:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z/wjbTXJWg5kCimzr7LvdhiwA8IjxWiwLkGnrkBh9ko=; b=UfWdqQJVCUOKKWCv
 YR/JlqxkAebWwdx5Tg9qw70zF76x8H+RjAH0ndlwDtqL8wn+oeSz4t2qTyAWTwRa
 COPbAZpSptZ8JnhS4S2P/oc7UkgPgtBhNrdZTbIHEB/+TUHs0HWJsK9KhHF/ZaV1
 b/+7O69Iosbxj5tSbF3XMfP3k8SDoVyPsA3kM3AQsCSePSUiEybQ9t0YkIqX8a1B
 aviw0+V5cNWnEf81JYRfmz0KKXndvP7uXjooPzWsJQ5TXDqDIueoJPaux+97snkX
 gr6hiia0JgwpYs8AwC9z3hafEqLvMOOWPrUKk/xd2fS7dJ2FrR+ef6WmkR1S63yv
 UFXgMw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqff14nr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 21:13:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a23afcbso90187321cf.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784582015; x=1785186815; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z/wjbTXJWg5kCimzr7LvdhiwA8IjxWiwLkGnrkBh9ko=;
 b=RL84zxjkCW1Nyet+YMJnLHruOkXvsb9SZhfeFihitGnbr/8IXzIKFbk7ALH8Xn4ZyZ
 nSOhtw9Zrrqxhby/o3rDA5GCvAfMWLe+C9ngO1UiGszdWOH6r2qHbvwXJf/sfEpqL2Po
 9FKIf3Kndnh+ty1+ukUN3GzGel3Be6s4vB+iCa4uKUQBfZxiKREREg3nz3/7Kd0y+uej
 C4UP9drJwlnNVT1e8ijOf8QQFnjx2pqAxgCvDt9gVEJI0mKUGxXzQ8yC54++JVH351rz
 s7q2iXtDubeM15GOFj0GTL6WQOFYhTctcK7MzpCpT9947w/+wzJGls9yvotqKXeS58hf
 2ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784582015; x=1785186815;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z/wjbTXJWg5kCimzr7LvdhiwA8IjxWiwLkGnrkBh9ko=;
 b=abgyaZr7KuGPjHhloA+2fbBXbY4LBlPXtyldgAH1TTslNIEhVY6dMKZL5+Ta3euc8l
 4EayPlokJDmYc3qa2CTUJIR6Imc38k14l3BUzlPd0EaKF7ZpIcpzMa04MiFFi+jn+NJb
 8TmBN+9ZLyrrYC+qO5Ml63Dqp+Zw2wW5eyvByvxf4vpbC4h+NexZK4MI5/Ghs3gSwf8J
 lgIrcxmO8YWZ6HT0eMnhd7VgWYt9UKWLZaW0LxWJFFrDujQcQbJanj8tgBwOxVoM0ND2
 tCVHtUc0su+pOImPt9AiQNG+KSdla4GgmtE1NfjqK3tk2FXFeYtkNFQ5+r0t1ORY2yVH
 dNDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RorUBpgfyh/1rnDa92BQj8BwZrOg+mKMA9DCmrS/T3fn4xPHEhyt7PRChtJZB4Ad1/QLf7kYMi/V8x/@nongnu.org
X-Gm-Message-State: AOJu0Yxf4nQsSLvqo4IidlCcB3OkVfl1x83qAY4yH6MZkxTEgLEE2Szv
 XAFDyWcvzLzct0JI/fCw/X0SDAdpfaSmhgCX7EAmyqe9YHPrjNK3C4HNdJbkD4lgMyR1aqs7Neb
 heKm9+F7DSQVkvecutabSF2FIrc6G0lVh7KJXyUCT133ZSxD66GWmTQOeKQ==
X-Gm-Gg: AfdE7cmL9zG7Mq/ydEf+JRJGE/2mMNNkA5+BEvrPcMttGRHYKWr0Y6QBbO7JypKN056
 /CXZ30Ka7A+Kbi0cxQQFPeIztW22cIIiSWLJK3gSob80V4JjiT/62GlB4n5WeR2IouMinfpqSCO
 ry/JZL+QS2qAzjz992BGnJviZOsUHuw5YFAeZLmtp+x2fJyTdCi/xMCeQ1tKIrMsfusyBo1VHyH
 SRpg4YNFG7j6WsLIb7/O65LZvQdK+R99osS72/vuQSAx8oPpRd73aRKVxHWbhM2qr3QjygNtC4M
 tzHm8HRthQWmrv0NGl8tTQ52sbiZTCD6hUyxYJHbwsJXhjOSesxk6G8v1WZdpt2PhfqNvwBidzG
 tkl7J1DyZiXqhU3m8r1U2QWSJ3WpPbTlpZ+yxrOoh8KtC/sesa+E=
X-Received: by 2002:a05:622a:4d9a:b0:516:cee1:4727 with SMTP id
 d75a77b69052e-5213c10a2a2mr147822171cf.14.1784582015297; 
 Mon, 20 Jul 2026 14:13:35 -0700 (PDT)
X-Received: by 2002:a05:622a:4d9a:b0:516:cee1:4727 with SMTP id
 d75a77b69052e-5213c10a2a2mr147822031cf.14.1784582014875; 
 Mon, 20 Jul 2026 14:13:34 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954aa1a231sm186032045e9.1.2026.07.20.14.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 14:13:33 -0700 (PDT)
Message-ID: <ba171fa9-32d1-4e4b-bc57-c4bbb10875b5@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 23:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1? 0/4] hw/display/vmware_vga: raise resolution
 ceiling, advertise modern capability bits
Content-Language: en-US
To: Matthew Jackson <matthew@pq.io>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: kraxel@redhat.com
References: <20260719152318.69481-1-matthew@pq.io>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260719152318.69481-1-matthew@pq.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIzMCBTYWx0ZWRfXwvL/yHAjzL0f
 XGkxvf/I85cIG0X1q3cXhiGRshVdN2SWFLJ+6zxvb1QO3io+5zVGbhD2r9Ct4wI0FkEoSWs8gFI
 liLQWLarb8/ofgJmkrBLukoBxASfsa4=
X-Proofpoint-GUID: pJ_Rj6bh38Ut5nbErtCXZd1p7Clyhe7u
X-Authority-Analysis: v=2.4 cv=FJErAeos c=1 sm=1 tr=0 ts=6a5e8f7f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=lY6Vmi25UdJ5663uGBMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIzMCBTYWx0ZWRfXyDrzWfm54C/I
 sYwpt/jWeR+Gl1LpUpXkR8zKLvDN80gNCb3bhCDekY43kw4rVrij/J4OYM3IGCZ6e1aai7VEqbf
 RNvq1L9+1hSWSqwvPj7XhFAKWJJO9MOc/gWgG7YN74CAlBatc1bSXN0ldQXZ1tKBMoC8D2HrPmf
 GOtv70IgaUk3dZL4aR7otYlzxIs4VenIOoH/FUTMHI5cerkNr2B/bCOCHoCm84UhFfsefKYdAlF
 GeFPmopqzzZt9CGClYY/WYAv1sYJK2nXcsyIkWWLsOEgX7eWnf7W5riYKDohF7J+/Rcl+zSVnt1
 UDC4TgYeUn05vGcB7GNmYX1eLBE9LtOhfHj1tw9mxLzjzApDsqN9d/cclcvJY/l79qlk5wWJDwW
 sI4puqfhGRxqOOI/SKmMSV7rFKfMMfmNs0i4d76czqsOjUp/ALgZ0ROWmbz/QHLM/qQgo9CnR5w
 CkhiD2aAmfDVrQiOWTw==
X-Proofpoint-ORIG-GUID: pJ_Rj6bh38Ut5nbErtCXZd1p7Clyhe7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200230
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

Cc'ing the maintainer:

$ ./scripts/get_maintainer.pl -f hw/display/vmware_vga.c
Dmitry Fleytman <dmitry.fleytman@gmail.com> (maintainer:VMware)
qemu-devel@nongnu.org (open list:All patches CC here)

On 19/7/26 17:23, Matthew Jackson wrote:
> The QEMU `vmware_vga` device reports `SVGA_CAP_NONE` when the
> guest reads `SVGA_REG_CAPABILITIES`, and caps mode validation
> at 2368x1770. This was historically safe because the device
> implements almost none of the modern VMware SVGA II feature
> set, but the machinery for five capability bits is in fact
> already present - the device just never told the guest about
> them.
> 
> This four-patch series fixes that. Each patch touches a
> single feature and is independently revertible.
> 
> | Patch | Subject |
> |-------|---------|
> | 1/4   | `hw/display/vmware_vga: raise resolution ceiling to 5K (5120x2880)` |
> | 2/4   | `hw/display/vmware_vga: advertise PITCHLOCK capability` |
> | 3/4   | `hw/display/vmware_vga: advertise EXTENDED_FIFO capability` |
> | 4/4   | `hw/display/vmware_vga: advertise 8BIT_EMULATION, ALPHA_BLEND and ALPHA_CURSOR` |
> 
> ## Motivation
> 
> Modern VMware SVGA II guest drivers (Linux vmwgfx, macOS
> 10.13+, Windows 10+) refuse to take optional fast paths when
> the corresponding capability bits are not advertised. The
> effect on macOS 15 guests in particular is:
> 
>    * Cursor is monochrome and flickers (ALPHA_CURSOR missing).
>    * Scanout pitch does not align to guest framebuffer on
>      non-power-of-two widths (PITCHLOCK missing).
> 
> Matthew Jackson (4):
>    hw/display/vmware_vga: raise resolution ceiling to 5K
>    hw/display/vmware_vga: add PITCHLOCK capability
>    hw/display/vmware_vga: add EXTENDED_FIFO capability
>    hw/display/vmware_vga: add alpha-blend + alpha-cursor capability bits
> 


