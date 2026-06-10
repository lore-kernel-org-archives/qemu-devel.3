Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DADCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXErF-0003SB-6k; Wed, 10 Jun 2026 05:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXErA-0003JO-T8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:04:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXEr8-0005x1-IA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:04:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A7hrjj3151709
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SAR+SwSQoWE8LstUStkzEY/jIA+Do7OqW+66xAuE7PY=; b=UGgewKC2PsfxJ1CW
 M/PabrVW3Thm4gdaGtu88/BUedAhi1F+KFbQLbBOuW1PER/JbVRA9qZLhyO0forB
 +2yjR5v1Kdgm+cr9Q8A+njh+WkQeVJbNXYwAU5NeA9PRgvGok90wNiAqWguKz5mp
 Vf/iXCSierPQNS98I/cpplA/qzJiq99Mspj4pzCSNLk+f68cf0jWnK95jCWXXgQo
 PyFkOH87AuJN1EDTz249dFpF9DwKVwL36/dlNIVWF3RHIteRyDM4o6H38T3QX0AH
 3k6zK/xl17o4bZpdq02aKlU8i1+qyBjqAv+3sqQfS84VcKvHo5j1AqtqLK/zJcFv
 iAt9Tg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnesna6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:04:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51772325a64so88094921cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781082251; x=1781687051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SAR+SwSQoWE8LstUStkzEY/jIA+Do7OqW+66xAuE7PY=;
 b=Bgrj1L8Pxz48aA/t0oLkWArkGXRxQ0QlcDcZeOsscAos08wpLYCvA+oAw0yrmME3o5
 va4m2GyClGFrurXP5jWyzDpEkRRrWNAOkn0+Bo2ME7isrj/B8N+XsoPpXToHbNXxeVlP
 GZy6ajNPfWg+tzExs05WKjq4XvoyODDWXAeLRO2exVjfV2u2/ELXSEqP33liGd1PozZO
 NkkPTJJXgc+Lq1sGYxk3QovEwKNFVv+vV13ZxxFFCC/71dLUgfVY259xHTcXZrh0SNrF
 m7MKqAVPeU/nITyuBKvD5/62YGcCQx5f31CbOtANVuU3GU30w9/gG4EPd+cLtaM+97Pm
 /Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781082251; x=1781687051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SAR+SwSQoWE8LstUStkzEY/jIA+Do7OqW+66xAuE7PY=;
 b=d5Ks8BOyknz0PhthohB+xmLNFqYa4n6GEGkiRVajkde/Oj/fjkOq73hQRPdcntQG3z
 wXoubuu17i3+zPFUFEmdNaC3xr7xjpcH19ZrxeVJJVrTXQ8uV1vn0DUiNMp8ilyLv4jQ
 wrffFtS0qnFql8+YK6ecNrmkMRQrYDxRPZB+bFR47WG+Q4iTVhJzMTJw+mZZfrLV2gfa
 5cH1Rcb6NG5U2BWTBIclhpzoP0IVngu22+G5dTF9+0lKfr8TN92NILxAOyssM63is9aV
 Tibg2VcWFm6MWKvpy84KSGwOJuoJB/q3WkZatEG9dLGZnZoqpa7pNJ/B7EFXWGnNZYSl
 DK2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HYKA3OWtPU5YTn9ZQ5Kmj0JpOBnc7YppEcZUFMd86S0TQ1XBx9r+WcCoWOxXixZWmzUzsRUtW5vO2@nongnu.org
X-Gm-Message-State: AOJu0YxopJwN0ITZFZxlBR0alIjQe4uQ69a2/RsKwu9EB6xKOj4pnT3r
 XKiObjKs1SK/ai3ko43RN68L2377ZyaOvRZcYB/uaw63LwmlmljLfBY3xTGV4dkGWi1OcxMJb9V
 3luY4kUodM1jOUiQ/OwfyalEo0XrMg2Ri4ogVpsRuI6miZe7qgWioJMr+rw==
X-Gm-Gg: Acq92OHvslH/IymO1VkBDNpLndOnExpo6dyQH0X/rNE/q82uuYacKLj9bm/BEh4y39h
 76cCFTFEXsZawtBQCH9RsSnFiNBCfyRox1xU+mfVIdsftGQvnVvFX1uSWCDWfRTUB3VVEo3A2s2
 DjQVdYmkd+VUNvjlpU2qp+gmtAiX7ukViNOg0kHzAzGJoY/9nBgMx1E+uqDExO2F1VK6CtVME2u
 hlBSJ1DnnGFypXnMWdSFc+ZAyC0om8RsvhNCHfpM74BV58ggyCh7GOB9eqnC6zv4dCNMVlVizMi
 Znr4nlDKfOO5mv/DiQKQ/E6NJNV0GgyB5ViPjnpc+2wpxVhMYieE9ofm50kPc5ChTiFVkeY+w6s
 kUb9GUqMLiJvVHwGfePfVzdd552sOtJfkJuAdvB3zZmLoNfWIPjE4+fouO7BNN+yzq0kyAYwUkw
 ==
X-Received: by 2002:a05:622a:4e94:b0:516:585d:d1c8 with SMTP id
 d75a77b69052e-51795be1037mr319372221cf.33.1781082251416; 
 Wed, 10 Jun 2026 02:04:11 -0700 (PDT)
X-Received: by 2002:a05:622a:4e94:b0:516:585d:d1c8 with SMTP id
 d75a77b69052e-51795be1037mr319371781cf.33.1781082250927; 
 Wed, 10 Jun 2026 02:04:10 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf8ce503f84sm260652766b.5.2026.06.10.02.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 02:04:10 -0700 (PDT)
Message-ID: <6db02c91-83fb-4021-91ec-72e6b56afeb3@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: add 'trigger-count' debug property
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260609213905.1126795-1-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609213905.1126795-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uFPjOizJ_s1TVYB9NitYB3cBpm5r-VKQ
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a29288c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=CdBnIkB1nSb6GziZJysA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: uFPjOizJ_s1TVYB9NitYB3cBpm5r-VKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NSBTYWx0ZWRfXyeUW6gyx//u4
 jP2YEir0YNRYWFFoMhh0inWWjCemhkOPj7nk2iPKHu11azItml2o8jqA2PFkj3meUS40Z74j43W
 p7bJqMemh2xON6CQ5fEjhUUyVHs80JQ+Ed/xVeahyleqQ5jmktprIVlOwthIyFIpn0ZTyUtI6w+
 5Lmd0yjmuZpb1Y4zRsx7eazgP2MIZoePqgyWYsPs3qfFx6jRMlZXA3iaqgn6beqcU/+gXchf4/a
 Zx29XLT0A8iv5xvkSEACKjwO6yBf6jwmyIimL8emBk7NLLUQ4BFrnif2wV7+Z2RBvUrUfn1/ykj
 1FnJQIHi2xTHGigyMXNIJdYoqXZJ8AHB2U7rPa/Lv/tcMRVkPjV3bbSfY3PvZOGADtMl2plZ1aR
 mTOeQg+KKakPdmfoh0M7ozEUIIJO3PThaGYXQUJbFkynZVHU5VzX8buva6CxJB50OLGhDTz1i1n
 Fcrlt1ZOKpwUuFnQ3Iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Daniel,

On 9/6/26 23:39, Daniel Henrique Barboza wrote:
> All CPUs have the same amount of triggers: 2 triggers per hart, set via
> RV_MAX_TRIGGERS.  This is not enough anymore: we'll have at least one
> future CPU that will demand more triggers per hart when implementing the
> RISC-V Server Ref Platform, requiring at least 11 triggers per hart.
> 
> Parametrize the trigger amount using a new 'trigger_count' env property.
> The default amount is kept at 2.  Set the new maximum to an educated
> guess of 128 triggers per hart (which is less than 2^XLEN theoretical
> maximum by the spec).  All relevant callers (csr.c and debug.c) will now
> use env->trigger_count instead of RV_MAX_TRIGGERS.
> 
> We're also adding two ways of setting the property:
> 
> - a '.trigger_count' CPU definition flag, allowing CPUs to set a custom
>    amount inside the CPU def in DEFINE_RISCV_CPU();
> - a new 'trigger-count' user property.  The user property has a higher
>    priority than an existing '.trigger_count' CPU def setting.
> 
> Assuming a hypotetical case where a CPU 'X' is defined with
> '.trigger_count = 8':
> 
> - -cpu X,trigger-count=30 => trigger_count set to 30
> - -cpu X (...)            => trigger_count set to 8
> 
> For a CPU that doesn't set '.trigger_count':
> 
> - -cpu rv64,trigger-count=30 => trigger_count set to 30
> - -cpu rv64 (...)            => trigger_count set to 2
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c         | 11 +++++++++++
>   target/riscv/cpu.h         | 23 ++++++++++++++++++++++-
>   target/riscv/csr.c         |  2 +-
>   target/riscv/debug.c       | 16 ++++++++--------
>   target/riscv/machine.c     |  4 ++--
>   target/riscv/tcg/tcg-cpu.c |  7 +++++++
>   6 files changed, 51 insertions(+), 12 deletions(-)


> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 6e70b145a5..a667c06b17 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -240,8 +240,8 @@ static int debug_post_load(void *opaque, int version_id)
>   
>   static const VMStateDescription vmstate_debug = {
>       .name = "cpu/debug",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> +    .version_id = 4,
> +    .minimum_version_id = 4,

Since you bump the migration version, we can also change the array size
to only serialize the number of trigger used:

@@ -246,9 +246,9 @@ static const VMStateDescription vmstate_debug = {
      .post_load = debug_post_load,
      .fields = (const VMStateField[]) {
          VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
-        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, env.trigger_count),
+        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, env.trigger_count),
+        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, env.trigger_count),
          VMSTATE_END_OF_LIST()
      }
  };

Orthogonal, we'd need to replace these target_ulong at some point
(likely bumping the version number again).

