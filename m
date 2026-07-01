Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9876BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevbn-0002qi-RB; Wed, 01 Jul 2026 10:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wevbk-0002qF-Ur
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:08:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wevbj-0002YY-6A
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:08:08 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661AGDx0793713
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 14:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rFiIzrK1bmKT3FgjZ2FoUrQPK8y0UL4wulpyfTy2WxM=; b=EqQ+/kMrwrVWMAAc
 jS382Q9SXaMW9sjPtPCBpcHQMz5kz8QM4GmVeUsjFKd5d8PEfonha8Qs+WUmSQTm
 B6cGKR8WzvEZ5tfvp6OrPQKjobwzNWYSR0LYA6l3TKaHkn7CoSj+UuVJQRNT8HXM
 Ww63DK+ECZW5uBbSWbM3PnPxUGPqb06NcN2ALBRcpYmCtALsu42pdhinJxncmx+j
 FYthQ7Fl2XmTwzM5lNtoYf6oDQQy7GkbcniIGdL2S+Ag1MojylIOuX2/YF01hWzP
 v/9QC/o+/nCDVvT8WtQQ34uoUMTF7n13bvwiyGXsCvdwro8AxDckZTF9WmgE8ghn
 CaUOuQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510agydq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 14:08:04 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-737cd7b76ceso151678137.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782914884; x=1783519684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rFiIzrK1bmKT3FgjZ2FoUrQPK8y0UL4wulpyfTy2WxM=;
 b=VFVXV4R5Jol7qhYlIsRe9F4WCgOKf4jy+kWCzuFPskSn2YKbLTNwD16HJfZvA2PPSs
 +hSMbmudnQZM5sSL7tO9AtFI6SvvDHAj9NmeBXILem8+MJVyimiA2OPKA32X/tuPB27+
 DFrkyjvXiMGmFrO+wkfmFIqnZrD+nalzLqxTYH02KSuHWZQhfx92Bzcsy0Kqx4p7yLvW
 iVpDgQjeHYEjnHKDrxc1FHNQWXOfoNx/Q4irdyLqv9mZtnjxR8HPOYevx7qzlJ1zbWQW
 9jv7QVWZD20Axt8chZLNOka6bEcUnTrhNt8rP6mPE2JN7o4PKLqdR259mtDoU2OsjN74
 Cs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782914884; x=1783519684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rFiIzrK1bmKT3FgjZ2FoUrQPK8y0UL4wulpyfTy2WxM=;
 b=c4lbrPM7e+eD1mBJARrrqJ7OWGneY+uBrhG4LxU8k+GpWbrIWROpzY0qqITIiDWo7e
 q3GBn9qsKKi/Dhl8kMwHNs35ApImllq1caWAHNfHq9Tj9v1vRYn1+qI1rBcdhL+Reloo
 sT5TupP8wF4xjcN6ghRp8SO10gOLfFNr6KWBXicmScRh8VD4HTnq8hNObgOWsF+zGtIS
 Z7Wxl/XAnT9aSqbToRaegt1NfnVWzYVn+Grd+2L7ccuvv5utMTrwls+ZFudJ3dYZOiIA
 N8Um5D3TSxjr3CcqqQF6QVKnZV2g5xY3RWRxkpJS5gCgKL/TlKZRUyH0SfoMFg+XMnS2
 0Hsg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqpp50TBDXF//AQOJzNkyynIk7O3mVyIVfv2k2P34FECIgTAEi3gXcqp+gwpWnh6nWvqDPCkNTJy20C@nongnu.org
X-Gm-Message-State: AOJu0YyLre9HlpMh+UjVI2QJ6adj1XFLqVnNAQI1kFbehrvDfftA+c7V
 X+M1PIYBX7O4KQZ4uTTzio0d/xgeohHOK44XTocOKX/e2LhKF4cxaMECfH6rxgOJid842045b9S
 VzAModWjbErn+W5h0RPSgVs/1efCitHJ2/8VKdPO32DIIAY2Rl3j3/6GRjQ==
X-Gm-Gg: AfdE7cm5IgDEdMVghzsfzGluOT9kemz2tdfM7qA4yDBnJE+xYju2FajFTr17z+xb7Y2
 YoXZAnnqbyOEKszLsEbwnOmtf0uULh0WOouJzNQ8DvRRo4rY14n28KNS5B6EfazRnnFd/YVgbfr
 rj8jxnK2P19MEcl6IKpnNU7CxOoN3hdj5QWa5Dg97vqGjJukQRqMkj7GVtFMBAAW903BgZ71MRO
 9GhorIglpXOyTD0hkKlDZ/KF5An+1zhHVCaVOI+tGIrfqtt5zbtnPZU7fL2LHXBNzAEknUZUn5p
 Ecuc/xrWplsvR1vSUQS03LRaSEhIpZ2HkT22eG9albT6kayK5H/qHEU0C9zIapQHOxeV8VyAJz6
 wy6xCwRvSpXF6y+wekm0NocKI7bmvZPpcJqMDwBusOQcA+R2bRd2Z2ZSo+dzRta+HuoU=
X-Received: by 2002:a05:6102:3e0b:b0:738:bf0f:d0c7 with SMTP id
 ada2fe7eead31-73daa01ae10mr715933137.25.1782914883996; 
 Wed, 01 Jul 2026 07:08:03 -0700 (PDT)
X-Received: by 2002:a05:6102:3e0b:b0:738:bf0f:d0c7 with SMTP id
 ada2fe7eead31-73daa01ae10mr715851137.25.1782914883387; 
 Wed, 01 Jul 2026 07:08:03 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c128917536csm281608166b.56.2026.07.01.07.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 07:08:02 -0700 (PDT)
Message-ID: <8c5eb29b-57df-46cf-8678-36182e052afe@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 16:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/34] target/arm: Update contiguous first-fault and
 no-fault loads
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
 <20200511133405.5275-22-peter.maydell@linaro.org>
 <e9cdc625-7ded-4678-965a-a98f18150ade@oss.qualcomm.com>
 <58d000af-4213-4600-83ec-e418ac8682b8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <58d000af-4213-4600-83ec-e418ac8682b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b2qc5fKXPkjo8DpEyg6Erd1DbQf2L2RQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0OCBTYWx0ZWRfX3Hv2W7ucXIA0
 Gqd9iwa7MntCtXxY1WIHVP4QDGYSSGKN0qSJJGLJVXk3NOVDd65Oi+RuDqHYDLBDXga3yoovQOm
 Mz099jrIMOgdMnJ4triGc7wgNoLoyc5gsL2QsX/r5xjivq2aTP6ZiXD8s6PHiKxw1Y97KxKXfIe
 ngQIg/4z1bnGh4uQxNO+g0gqZQrbUSY5txYKwQ/MfXp0XNyvf/0LUfbKIwGLGp2/XXeZEmgKuGT
 eeix9kdJ3VyllAWFDD/QR0VMJLqC9kKvx/BCA4WnDq7nQbCcbb0nO+mbhA1A+wLxbyZkhu4mmpa
 c3AXPXpKhJ1sPf8jT0QtVm+LCZh/CwwChWhlSCbduwwd/2I6dTycgDR1f0/yIK4vLgTuJqagbOc
 y+piG8H1MitFibtkPqe0qU1q5Pzx/K6V8/6L03JUv356AXx9H4VT96AfkSGTdXZ/6/Ifau+J61Q
 dkmRQy9DEm4etAjyK/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0OCBTYWx0ZWRfX/nzGmWumptr2
 lxAJ/eAsYfQqnUjABIdfIk3TlCvrXHaey3kFTN3jzmaX4lG7XFK71rURWXYrADodZuXzo95ITZ4
 05GngoKJqEnYEinN9vr18R2mZiISV6s=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a451f44 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Jid1Q9jbKs2eGPar2nUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: b2qc5fKXPkjo8DpEyg6Erd1DbQf2L2RQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010148
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

On 1/7/26 15:11, Richard Henderson wrote:
> On 7/1/26 00:37, Philippe Mathieu-Daudé wrote:
>> (this is commit c647673ce4d72a8789703c62a7f3cbc732cb1ea8)
> ...
>>> +    /* Probe the page(s). */
>>> +    if (!sve_cont_ldst_pages(&info, fault, env, addr, MMU_DATA_LOAD, 
>>> retaddr)) {
>>> +        /* Fault on first element. */
>>> +        tcg_debug_assert(fault == FAULT_NO);
>>> +        memset(vd, 0, reg_max);
>>> +        goto do_fault;
>>> +    }
>>> +
>>> +    mem_off = info.mem_off_first[0];
>>> +    flags = info.page[0].flags;
>>> +
>>> +    if (fault == FAULT_FIRST) {
>>> +        /*
>>> +         * Special handling of the first active element,
>>> +         * if it crosses a page boundary or is MMIO.
>>> +         */
>>> +        bool is_split = mem_off == info.mem_off_split;
>>> +        /* TODO: MTE check. */
>>> +        if (unlikely(flags != 0) || unlikely(is_split)) {
>>> +            /*
>>> +             * Use the slow path for cross-page handling.
>>> +             * Might trap for MMIO or watchpoints.
>>> +             */
>>> +            tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
>>> +
>>> +            /* After any fault, zero the other elements. */
>>>               swap_memzero(vd, reg_off);
>>> -            return;
>>> +            reg_off += 1 << esz;
>>> +            mem_off += 1 << msz;
>>> +            swap_memzero(vd + reg_off, reg_max - reg_off);
>>> +
>>> +            if (is_split) {
>>> +                goto second_page;
>>> +            }
>>> +        } else {
>>> +            memset(vd, 0, reg_max);
>>> +        }
>>> +    } else {
>>> +        memset(vd, 0, reg_max);
>>> +        if (unlikely(mem_off == info.mem_off_split)) {
>>
>> Is this code reachable on user emulation? The changes are
>> quite complex, previously code was guarded with CONFIG_USER_ONLY.
> 
> Yes, if you mean this line specifically.  This merely requires an 
> unaligned vector load that crosses pages.

Sorry for not being clear enough, I meant the TLB_MMIO & TLB_WATCHPOINT
checks just after:

+            /* The first active element crosses a page boundary. */
+            flags |= info.page[1].flags;
+            if (unlikely(flags & TLB_MMIO)) {
+                /* Some page is MMIO, see below. */
+                goto do_fault;
+            }
+            if (unlikely(flags & TLB_WATCHPOINT) &&
+                (cpu_watchpoint_address_matches
+                 (env_cpu(env), addr + mem_off, 1 << msz)
+                 & BP_MEM_READ)) {
+                /* Watchpoint hit, see below. */
+                goto do_fault;
+            }
+            /* TODO: MTE check. */
+            /*
+             * Use the slow path for cross-page handling.
+             * This is RAM, without a watchpoint, and will not trap.
+             */
+            tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
+            goto second_page;
           }
       }

