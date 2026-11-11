Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E80606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TzbImpf0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c8XUqqn+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR5bx-0005Il-FG; Wed, 11 Nov 2026 05:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR5bk-0005Ha-6E
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:31:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR5bi-0001sT-Ln
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:31:11 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KJ0k1386372
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 10:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PTa/Wj6HNlsl/nmOa+sVKnuyot8IaIJcCJ3AwH92Hk4=; b=TzbImpf0+NribJYm
 E1YBkRxDE8P56OmFsnonDP3dacP+uZzIVcy2wOCl0VMfqIyFLTQ2QDuSf3REph4C
 dpl3y5+GWoLfz5+Dl+LQXqvNo9cFSrcTHDnwwIbUKBXLBXr0sPRryvRN8pVX1+OE
 SqI6HNiig/kWVkQuvrIqURlZyiPF0w0iSCTj/4HwG6iTicLdVJToA4aDjJremCqa
 G7OoLkN5yiJ/HFq8SJmEHNLsuJ7xuUkMjMY2vRrXuFZ5HOPMY9VShBBC97xs+k6e
 mi7WBFY/ihsiTIHN1IeQRB+zMLOskhFvhD8s5vKf7QRTlbPoTDi7YkLe2MQ3MIzV
 3RMKbA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnma4ft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 10:31:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2c0e6653so561741085a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 02:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794393067; x=1794997867; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PTa/Wj6HNlsl/nmOa+sVKnuyot8IaIJcCJ3AwH92Hk4=;
 b=c8XUqqn+DHYjV3KAoSUDwQGJ5yHgJFFJLmdJLkSasJAh8jKWirheIqae/EfRoiRaOC
 vJHg6dzOZ+S7eGJE82xxaQJXKow9E0G6EQLk5sPdqiselgxGUCBetZpzD7oK1ela0XzW
 F+A94OQ3zzdpaabwfU3ZTx/3d+Eo69VZl+2yojz9EdJuyld8Kfc5BhsaE3bectLuVtjl
 Gq8qOupHvf1CQDJtN7r6r4OWhozWg1fLOi3bFpPssyoAFvogc1jXrvVPnJ6VxMNmd/uv
 QnxBO5i9w4z4smotClDoDluKwAsXYVGHoZRwqdXOBTAFk38mCK+ApCP/5GbbPS1cikQB
 r/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794393067; x=1794997867;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PTa/Wj6HNlsl/nmOa+sVKnuyot8IaIJcCJ3AwH92Hk4=;
 b=M4gPrqyz/DNOMkQw81rim921h+GrTQEIocoW0CeqsZx/CbO1Wt9OWDOHgQeIAiIcEe
 jmcUzWY59ZGcZYvlf55UXyf+ElTMBs6CsqlgVwZ6W+AZaLafHnVfMDDiEUaU9DTpcPUc
 UXCo+DSV6O2oRxjSJB6guCjlKVZtNp8Lqn2WTTit1qSlXDbtndw6N3hijcRBdXFYgMWi
 2ivlIbYgIUGSjuQnNhrkhNNyPayhh1zUE2PT8CWbh455k9pI3vLW3qj/mAck6Xz08pBQ
 TbJKBsTLL3PwFZ+oGEkPbn145I4jVZNC8xDGkiXMgMPOYnPHOyr9jpPO4VZk/fPBAnW2
 sQNw==
X-Forwarded-Encrypted: i=1;
 AL+hErFIgrJlsxnMHwao3j4AzLNiGfHvfkkG2av7hC50OriZf1n4is0aZOpu47Sn3iUy2+FaIpcVSo20CJX7@nongnu.org
X-Gm-Message-State: APuU4Z+ZMUhwij2Fp6wJlmSKw9f+wTFJhRV/EvxVGWZkOF2BFnma+919
 7JS6Z3eJCKeVj55gYc6AYfq8H+yNBPJ/d+sK8ucO2fIRVJXdXinLY4z1qyj03aug2hCntRqZz6z
 SOWr1Vp5yDIsJQLcWcZvoiwBJWVnR/M24nQRkgNG1ZK4MVxilWdTw7cFXsg==
X-Gm-Gg: AYBFou2P9jxYJ5ecKW53a/I/OnsmBljoHLGYwf4GP6S2PumYMs7aFdVdC8Gq9pYAe2T
 zVBJyFWfu5Ekynr3/+Q21Kaq0IzQv4/sOB4mg9fLUQ60kOhz7SWmBV9ztk2CmiQ7ZoOciGybAbU
 FgNDdOLbxilUMYOmhU9P6MMGw85f2v0bBW22J+nJQ+MuxKugvGRYem3eWJfaNuuqaBjpTvjZxe0
 JZveSj+sh2owpjzzeAXW+c1NlKi5iSeTgIFIECQPMa/jKFH0RyWSwjOHlfbOkVEa9nYZGfPekYI
 2FSpObqn6kdubWWNBWkhJSpMqOTkOT7J/wH2FXPHcZcr+8bbsncEamt8+Ndf6R2VxDhNj8Q07Qj
 b6qC4esHaGvIJaAtM3DTEeoEmw7/1BOJKUU1ar6vhyADznToeN/f+/In0WEr24sWNhBJQtgjOw9
 AtVXXAAih7Kw==
X-Received: by 2002:a05:620a:3710:b0:93c:8e3f:3036 with SMTP id
 af79cd13be357-947afcd62cfmr312908785a.4.1794393066411; 
 Wed, 11 Nov 2026 02:31:06 -0800 (PST)
X-Received: by 2002:a05:620a:3710:b0:93c:8e3f:3036 with SMTP id
 af79cd13be357-947afcd62cfmr312903785a.4.1794393065792; 
 Wed, 11 Nov 2026 02:31:05 -0800 (PST)
Received: from [192.168.68.105] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e61c333sm449898485a.3.2026.11.11.02.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 02:31:04 -0800 (PST)
Message-ID: <bd789f92-c5ab-486c-9235-74d09497b020@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 07:31:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2] hw/riscv/server_platform_ref: Fix mtimer
 frequency
To: Sunil V L <sunilvl@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261111101609.1183263-1-sunilvl@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111101609.1183263-1-sunilvl@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nmsw1WZT_mnqZcideLystsXQ9XhFWyMV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0MSBTYWx0ZWRfXzlpXWL9rx524
 2PD87hgp2FNqeosjrEOxcGaqyg4Rno9k13uTZO44eYyKM0hySl3igjDiGmnpchdZ5jQryPsWNw+
 BnrMVnCjiBR5Lj28fZw6jcK0ExV/aEg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0MSBTYWx0ZWRfX3iN5tgSsW5Kx
 Ri7n6/yKWV8xBlhWZFoAwoirGLS2Mya9vNnzyH4M0qC9oOhni9+xcKAvLk7d5NfUHFG+0tBhcz5
 a0k2xDFTErDUPlVYX6uk/198XIwCAA4IfknHpAkALRPAIYBC5I6AFWCm/Kx7xdKhHh/5FvMfLlE
 nab2IQW51cJnhatEyQhSyWklf1uLO8HnDXJwB4mm0woVs1amwUTIUruueZP+mwpBa5wouD2wIlf
 MDJCUYugPT+SsZh2F6tX839usl+MP96kNyUpWTnrODACbxRDz3QyMe7pCz9aau5T7AxJJbHfDF3
 uTEFwI4Q3IQPxJb+/NLmK9wNoOXA12KC3ck/X7wvbld8Gtytk5uiHPUgvQi4qGfpJuiMwqTLA9q
 IG0Hv8FArsS8PO1Fb7IBW6ItHAJq5IuDuW2U5qHMPQcLHCJkThraawlhBsP2PnxjE764/0caX5A
 l1pHU+BAt0eGvxdNc2w==
X-Proofpoint-GUID: nmsw1WZT_mnqZcideLystsXQ9XhFWyMV
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af443eb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=TjprVoOyLZnDu5hoBU4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110041
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/2026 7:16 AM, Sunil V L wrote:
> The RISC-V server reference platform requires a 1 GHz timer frequency.
> Although the timer frequency is advertised as 1 GHz in the device tree,
> the mtimer device is still created with a 10 MHz frequency. This mismatch
> causes the OS to boot very slowly.
> 
> Use the correct 1 GHz frequency when creating the mtimer device.
> 
> Fixes: c2fa4320803b ("hw/riscv: server platform reference machine")
> Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


I believe this is suitable for a freeze PR.  Thanks,

Daniel

>   hw/riscv/server_platform_ref.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> index 5f485b1c79cb..fec967f708c2 100644
> --- a/hw/riscv/server_platform_ref.c
> +++ b/hw/riscv/server_platform_ref.c
> @@ -556,7 +556,7 @@ static void rvserver_ref_machine_init(MachineState *machine)
>                   base_hartid, hart_count,
>                   RISCV_ACLINT_DEFAULT_MTIMECMP,
>                   RISCV_ACLINT_DEFAULT_MTIME,
> -                RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> +                RVSERVER_ACLINT_TIMEBASE_FREQ, true);
>   
>           /* Per-socket interrupt controller */
>           s->irqchip[i] = riscv_create_aia(system_memory, true, s->aia_guests,


