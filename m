Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8C3C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 21:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wflYi-0005Gk-N2; Fri, 03 Jul 2026 17:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wflYd-0005GR-Qh
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 17:36:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wflYb-0001iO-QP
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 17:36:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KQ3t1890914
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 21:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zHASMPi0fJL7mRA7YSzLYg8FBeNZpN0PO0q5kvMR6Q0=; b=I5XyVjIO5v++rVSD
 L6V5zRxZoAa5vKmvjfBfnwUfbiZROkSLYP+FkCiUYLlSbR2aEU9x5y0RPdjqIudA
 MDWwGW0xUFmxlTFz0aufw/bSjV/TZcxOK3jlSM3L/HjmvQtGAkx9RyO5TR5XGpGk
 HgAx5FQ9z0st9DYLuPJBuF90Uu+hysfr5IpromRwptMuVjaWK+F3pdMQlmQgjgNF
 jrEd9RUFIIBuzCye0IiD4TJVn0ldHcNcsT+f12llxVhJ3Bwe0iOchlMN7LkNiuco
 GasS1IVC075RQPruV/LxgmyDDWIbdBgTQJ9Dj1r3BkCZRxzISzxbK6oo3dF/aq0e
 zeXDXQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j034mj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 21:36:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e55721a8cso86687485a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783114579; x=1783719379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zHASMPi0fJL7mRA7YSzLYg8FBeNZpN0PO0q5kvMR6Q0=;
 b=PioPDxgUpWkcTKfAuKb0J2lrbsD+DybnrkCJG2i4sFNYMqTrMm6pLc5rT0rXWzTHqb
 z+Ix0nhWiP1NtY/cxr8yvnTETJp4kxCHxN7B1O/iIXNecYqCfYMk43u0UFV014I1Zm+k
 rHWgJwou75j91NqNnkG+TN/bgaoVV5lT+CEx1ycrwxLwv5Tb3LSeMwyPFbX1cLdp3qfi
 Thu751056bD/9UPDR+lQcVms4RJ03hvj4Zx0Yp9XGdw37TD3PMpr19oXQQCsiT8/B9CV
 hJGUyokn/HL2irFNC2HcYI3ahPt2FOO/9F5FYYhGsM8/KdNFPMe+IOScOVcUyt9vWTT5
 XlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783114579; x=1783719379;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zHASMPi0fJL7mRA7YSzLYg8FBeNZpN0PO0q5kvMR6Q0=;
 b=NkxmSJi/3VSOuU0EjeWo1VRV1zgqzggLVn4gDThGCkoAHXsAi6RuTrHQ7MOrq7o7X/
 FtwLVBF5LRDwxx3tqDlZzbXhZg0mTTOnmZrMilhWJKDEvjOa5X3WjkW6XwTHIXpzwekC
 /4NIA/YVoCqhRvqji8ggCZunOEFDkRuGf6wPF8ngXTGgk96qlwoEdp0dq6UE4Utfnk7L
 pT9PxNj6T07BMWSg3ivKviOAAsB/07wQqvRHuxyFs+6cIsQlgcXANnNUc7hXDScxluQv
 C8ORYd5Q1BxtwcA8kiX2sWr6+b/4RY7Q8nwix/zTV6rqyKdepcqxcseWW1BiUAjNARev
 3flw==
X-Forwarded-Encrypted: i=1;
 AFNElJ99d20iBVskJaeFPYVy9BX56z2BSoQbmF/rqclLsi82iFuAF9lYzcWDbQhLUzwbn8UHAzFgD6Arx1Tq@nongnu.org
X-Gm-Message-State: AOJu0YwrbcPdd1Em+mUFkcaoFkDBEYXRsU/yPX1tp9AHXpFL2DFdUwbs
 wQb7qYonQuJ+YiJuNTqUljXJ7SqUJpXM3U9Z7FLNfY6XxTfR8/z+hb9QUwY9dJtXUMXP/KHULcF
 acpximCW2NpCF9YIdQTHwG8sWsGkzxmTUDDDe/BXgWi8kRSn3IU5MOKsNcw==
X-Gm-Gg: AfdE7cnMmP1VcPM6jGPIFQXhBBvI0fzTP/4CD47SCP6pjm/n+1pAWlzVGBoBq69rRgT
 V7pzTI7RhCycQCAVhDwZnd3e/NELBUjvHGUh3bbAONRBzPvW/uy6PO52BLbZ98XPxlpw5ecWwW9
 ZksEEq/AjiFMS6yYeXdiyFqVQGv1gamHLqIjgv8HgZcA9dL4a/R/i+HuxQ2P5oV7u5LYe38aswV
 JC5+1d18RetJ+i5KiPRUJ0GmJPXqNyj9ltnXBpVQaIeri41PIXSGEqpoeXrpcJ8vHIFHELnIUlx
 oDAR0FQtFOhPpbbsevEtsbBNDVnfKg9jXuihsPcm7agMMSNFSnFAD6MqSRfLUOxmuYZq92FzZwr
 ZttAmH0p8Z4Uj2VfIQO6aOh0arSQKnpM4jNBAlOh9SEax
X-Received: by 2002:a05:620a:4405:b0:92e:520a:ffab with SMTP id
 af79cd13be357-92e9a43a4c6mr157166885a.38.1783114578646; 
 Fri, 03 Jul 2026 14:36:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4405:b0:92e:520a:ffab with SMTP id
 af79cd13be357-92e9a43a4c6mr157162585a.38.1783114578062; 
 Fri, 03 Jul 2026 14:36:18 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90b804c1sm255606985a.5.2026.07.03.14.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 14:36:17 -0700 (PDT)
Message-ID: <ab8cd5ab-97bc-4c62-8225-6fd9d00e82da@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 18:36:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/25] target/riscv/debug: Sdtrig fixes and TT Ascalon
 support
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KpPSU3btB9yB1mpkH223YAzREXbKN6c2
X-Proofpoint-ORIG-GUID: KpPSU3btB9yB1mpkH223YAzREXbKN6c2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIxOCBTYWx0ZWRfX/1Dm7VGd9wKQ
 dxgVMN8w3bS8TLQR9yz+LEmOhDFBcMw4g9dO7we2TzCuKMUwolONcl78BeJp0YKdVShFVcDSAAK
 L/K9KHzcYmGEYRMYu4jjTTUhsvMpJrc=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a482b53 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TcOfpqZN13KGYs-Xar8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIxOCBTYWx0ZWRfX+gp+XE4Db+RI
 O4+imyju2eJYd0ZiLk5boKlOnzuSH2pvJO9iCXyjYP5kxoYJ1YXF9OFjn7KQaQTJdkMxzQQLkzX
 lQY9wlBGyjCo+INUZmMzk1K7H8eMOj4orrSPejyz0CVlDHcdXbZw3tLGljB9/zD3zt5wPUDOyQV
 VIsdzf8N6bvfF2odSkiWPqA+tuS5wala7qro4rVL6LnBZ4kRWioWkjq8FlP1IxhK5rTfZ3BELTB
 j/1l/i5yRXhCs0PyReqdPoOuYdfykqnBmvNP9lpaf+RlZX4TTxR8/sgHf23oJsdbs7T7GNsRbEG
 dTznI1Gk14kAUt6mfDoFFcIhQg4OJ36X4RktZnNWX6NcW2K+wYnikMoPlNiZRsXKRvIpxii84QU
 WhBJuxm6GtiKuUrxQusxlZ/zsnSl5wE2IiK/WK8m+33TgxKH1uH+19CfwwfVtIRTd7Y0QWRXj0J
 7ZKPjH6/bzLdIt7gEtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030218
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Greetings,


My current understanding is that this series is an official dependency of
the riscv-server-ref board, currently on v8:

[PATCH v8 0/7] hw/riscv: Server Platform Reference Board

Because we decided that we want to keep 0.13 and 1.0 instead of deprecating
debug 1.0 (see [1]).

We missed the 11.1 boat with this work and with riscv-server-ref.  No big
deal TBH since the server-ref board can use improvements before upstreaming.
But I would like to not miss the 11.2 train in the end of the year.

Nick, I already reviewed a bunch of patches that seems to be fixes that we
can use right away.  If you're ok with it I'll pick them all and re-send in
your behalf, rebased and with acks.  My hope is that this will reduce
the amount of work needed for the rest of the 0.13/1.0 debug code and
we can get that sorted it out.  Then Chao can use the new 1.0 infrastructure
for his 'sdext' patches, and then we can lend the riscv-server-ref board on
top of it all.

Let me know if that works for you.  Chao, not sure if you were aware of this
series so feel free to comment.


[1] https://lore.kernel.org/qemu-devel/383936e5-fcdf-488b-8f77-17fdee41243e@oss.qualcomm.com/


Thanks,

Daniel

On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> Hi,
> 
> Sorry for the big series. The Ascalon CPU implements Sdtrig with 2
> different types of mcontrol6 trigger and the icount trigger, so in
> the course of testing and bringing up OpenSBI and Linux support for
> this, I've accumulated quite a lot.
> 
> My new year resolution is to start being better upstream contributor,
> it's taken me a while with changing jobs and architectures. So I don't
> expect others to drop everything to review this! Joel has been
> prodding me, and noted there is some other Sdtrig work going on
> with the v1.0 support patches.
> 
> I think the debug v1.0 patches are somewhat orthogonal to this series,
> but both are addressing aspects of a common problem of Sdtrig
> implementation specifics. I wonder if these should be reconciled or
> left separate. Sdtrig v1.00/v0.13 configuration is a single boolean
> which is feasible as a CPU property. Whereas the entire space of
> Sdtrig implementation seems like too much to make configurable in that
> way.
> 
> Any thoughts would be welcome.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (25):
>    target/riscv/debug: Check only mcontrol triggers for break/watchpoint
>      matching
>    target/riscv/debug: Handle changing trigger types
>    target/riscv/debug: Implement permissive type unavailable trigger
>    target/riscv/debug: Fix icount trigger privilege check
>    target/riscv/debug: Update itrigger_enabled after changing privilege
>    target/riscv/debug: Implement get_trigger_action for icount type
>      trigger
>    target/riscv/debug: Fix migration post_load icount_enabled() test
>    target/riscv/debug: Fix icount privilege matching icount_enabled()
>      test
>    target/riscv/debug: Implement icount trigger textra matching
>    target/riscv/debug: Maintain itrigger_enabled in
>      helper_itrigger_match()
>    target/riscv/debug: Fix breakpoint matching action
>    target/riscv/debug: Put mcontrol load/store match address into tval
>    target/riscv/debug: Remove breakpoints on reset
>    target/riscv/debug: Move debug CPU post_load details into debug.c
>    target/riscv/debug: Insert breakpoints after migration
>    target/riscv/debug: Remove itrigger icount-enabled mode
>    target/riscv/debug: Advertise icount trigger type in tinfo
>    target/riscv/debug: Reset trigger type to unavailable
>    target/riscv/debug: Add new debug state format
>    target/riscv/debug: Migrate mcontext using new sdtrig vmstate
>    target/riscv/debug: Implementation specific Sdtrig configuration
>    target/riscv/debug: Support heterogeneous trigger types
>    target/riscv/debug: Support heterogeneous mcontrol access types
>    target/riscv/debug: Emulate TT Ascalon Sdtrig
>    target/riscv/debug: Fix minor comment typos
> 
>   target/riscv/cpu.c         |  65 ++++-
>   target/riscv/cpu.h         |  41 ++-
>   target/riscv/cpu_helper.c  |  10 +-
>   target/riscv/csr.c         |   7 +-
>   target/riscv/debug.c       | 571 ++++++++++++++++++++-----------------
>   target/riscv/debug.h       |  19 +-
>   target/riscv/machine.c     |  96 ++++++-
>   target/riscv/tcg/tcg-cpu.c |   5 +-
>   8 files changed, 510 insertions(+), 304 deletions(-)
> 


