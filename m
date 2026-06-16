Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67134CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZHYp-0002cJ-Ky; Mon, 15 Jun 2026 20:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHYj-0002ab-0b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:21:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHYh-00031j-Ja
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:21:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ0wSm1453777
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UNaHe60ECzKdgsJZyn+PSiEWCc7BzBIbuhvOVVSi3/U=; b=o4zd57x2bdYWjon2
 F2gtM+6cCvGK1AApgRJxh08ill7VpvRBJyUt2IOoJjNxnn5YNqlhD5he03M6w3wb
 pO3HnlzjqV9o71+6c2w9sbWK63cFYmpveVki9qkpzX0iaSHGt4Q4/tIavKtJpDaD
 fuMFBJgt4Pot8g/z/KaeJixRPO4FZBKgYn84EH40IHA4c1U2MtYQQ0AKyseBsnjX
 8hh9Xt41G4tOTP3jK6EjdUpytcTOtqgI22YQYFYf9vbW+2lPfB1VaROl5bf6ezAC
 Zg4cNJ1qmgpObh83DtUhBZo7T6Adil9pPlV0URlS3yvgxrm0loaAN4wHFV0Qlj67
 4+Dtxg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2cc9jb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:21:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157f1be083so678300985a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781569295; x=1782174095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UNaHe60ECzKdgsJZyn+PSiEWCc7BzBIbuhvOVVSi3/U=;
 b=eb1leI0BlMums5JWKAEBTPWr5XyBQWjpwl4uiV2e6/NNbi1yVTPdlZfWloFRQcImqs
 2wU876rnzkOafrJcIFTNCsbhLYHbOVW5kvY8ADIjSPR4OTB2VwvSbdwzBWLX+fUIx/Q7
 VDJxvzkwiU1Ki/s+fEReHw8Rg4udI7gXOIpq1WGtqKMr4KJgk33Xx3W3lvcMrU8nWhRL
 VWTVKp+WnR1251g+VSO+E+IQnYKL4PQ9Wayi5DWw7oh2whGlPfVUmYl2R7wrE0896WA2
 fXMdGdV783rYrjioFXv2PgSxOg3izoqey0k3lVG8FU+qnmeoQBKq71CEUwxdDfWF2TEJ
 6gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781569295; x=1782174095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UNaHe60ECzKdgsJZyn+PSiEWCc7BzBIbuhvOVVSi3/U=;
 b=rqribio9qlZDxWHcvyuYXMbdPL3uPQkRsabwRtVfst311h2EiP4e+aity5+/9zieoH
 D6mQw4YWXCwCMn2sV1DS5GCHktPUOW2wrbD7H8W0mQsxyk133CrNNozGhPfZjHXUI6Wr
 4AgsY82LTIc+/aBTEflf8zW2amATiU1gOuCSHrEgTLpRB35rAJrnDpqy4Ysf3HD2DRz9
 s2wt1Fu1+B1LqaSOvTY6ofG7IoucEvLTiUvK1eW4G13dKW3x8eQErwObOLT1akQevSSV
 Sf35ytP928Dxs+ftOwW2Cqw6pgNSjlhJD6OA1VONewmcokQ4SQKH5fMVUGm/jtVa4cYo
 ijYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SAh+rqInsDbuO7ajp151Jo1rmcuEHUaaBtSkoiKd7aLpptTqLjAobK6t0nGsnNSEpP94nIQWNsXOY@nongnu.org
X-Gm-Message-State: AOJu0YyizqF9z4kN7C/o+1hnLeiaF824RqAuWKqi9Rl/G6fpuT63SA3q
 sHobkovNYiYRkcuV5vFRBaNBcR8/fQlsrvVxnGi/Kmk71Mml4cjNE8L4FqaGKJYQsmE/MRPXhrN
 PJjeBd1+Ad/rCb+pCkOnl5xwcqislOzX5GkTOlsxz/JTKjoOWHsnIN68YiQ==
X-Gm-Gg: Acq92OGHFF2pFkKnq2H8tqOma00jl9gRB6rHJHngUutFgBKqVzVYabHb/nzd7TWmObV
 SZetcHH0WfubH5RXn7j0cqngtd3HaMVlNcCy6+cG+xJKIKBGaIAqeQi45poRCf3lpm0IjHkG3wZ
 uacatoIPnFIAZbY2AS8TOFp1J2p5+FN09pGs3irCYGiPQg5W6oNt4Hng5mgOgVmPQZ/Sv/vfxTS
 QEJNn/T6Cd6866/bqFXPaPTGDwBKTZfqSivIyxjilD81GrKG63AEpdxh2gXIpDpuXNTTrd8xunU
 YXI99uw8UWGJgdt92Dv69vQYGvIXrJ/W+52MQuDLkRFXzzcbaM5YHSy7lCHdT/sLx7LUBZtSEiJ
 lGGpibhD8PqvkZpmX3MQI/VqEd3FhdC3+cUMjZj5yCzboL7faxOod93vQWyfNPUPv8fJMONjZ
X-Received: by 2002:a05:620a:390d:b0:915:9f87:eaaa with SMTP id
 af79cd13be357-91c26b01eacmr314735285a.42.1781569295342; 
 Mon, 15 Jun 2026 17:21:35 -0700 (PDT)
X-Received: by 2002:a05:620a:390d:b0:915:9f87:eaaa with SMTP id
 af79cd13be357-91c26b01eacmr314729185a.42.1781569294851; 
 Mon, 15 Jun 2026 17:21:34 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c4240sm35758278f8f.27.2026.06.15.17.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 17:21:34 -0700 (PDT)
Message-ID: <97225a2d-6d85-4669-b3cf-1acedd43568a@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 02:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/26] plugins: remove qemu_plugin_id_t from
 qemu_plugin_vcpu_simple_cb_t
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615193526.2883349-7-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615193526.2883349-7-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX66JRSkwUsNo9
 QmKdeSIrBRDbZfGQFwCIxHSrtSmixhM0T+xccqJ78jgWq2FjFL3M0UgfYkz1DpFBtAQ/zUhFbU8
 gaJtNcY1PSdHJhUJxXI/D408LE8DBHl9Kxwo2ZryDk0QTvemc/f8AgolJdJzzVzH1yWeSeIVc/U
 aD8CLjKUsREYpnphlx/HQqvPtr5746wBKtHlZyByvaQ47Wu5qTKND7pjpk2euVQ8LBKaD01s/PO
 11sv86qtamP21HrmjRB8giKcPqZIQgu1f+NRe/uuYybf0loxJNSP44LEwUepA5IEBU150OVVue8
 fin41j/gvMqKHPKbza07izeU5c3thzxkQulLUlWAuYu9zsz1qz81bOXoLTvvXEF8oujqOb33xdt
 KGmVmyb4Js1b37oeXzme4EBLXt2+BAqYNCB4Sm2rsMldIvh611l37dPRL1BBz8SidNnpZt4hnaK
 bk/chwdnPIybGSPv1bQ==
X-Proofpoint-ORIG-GUID: tQNZhDw8e-WLw97TT2QB67A_8W44pSGn
X-Proofpoint-GUID: tQNZhDw8e-WLw97TT2QB67A_8W44pSGn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX/EvyYHl0HmI7
 YTqH0tLjvTrQUauxZAiYGU6BcKTw5aZhdVKLaQ0gk+DXIU9GhfCGbNP65VmqSKx1e8jT732CjlZ
 hesSF7dsgKOLcIzDure87zLoYtYl8DI=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a30970f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160001
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

On 15/6/26 21:35, Pierrick Bouvier wrote:
> Not used in all our plugins.
> Future commits will remove qemu_plugin_vcpu_simple_cb_t completely, and
> replace it with qemu_plugin_vcpu_udata_cb_t, so id information can be
> passed using userdata if needed.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   contrib/plugins/bbv.c         | 2 +-
>   contrib/plugins/execlog.c     | 2 +-
>   contrib/plugins/ips.c         | 4 ++--
>   contrib/plugins/uftrace.c     | 2 +-
>   include/plugins/qemu-plugin.h | 4 +---
>   plugins/core.c                | 6 ++----
>   tests/tcg/plugins/bb.c        | 2 +-
>   tests/tcg/plugins/insn.c      | 2 +-
>   tests/tcg/plugins/registers.c | 2 +-
>   9 files changed, 11 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

