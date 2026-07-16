Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D721C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQoe-0002uZ-64; Thu, 16 Jul 2026 14:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkQod-0002uJ-2w
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:28:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkQob-00052m-L6
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:28:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSw8V3172368
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MwhUFq55A7WhvSstjaHHFnQhX0Xa73fpd3KAK7cCa70=; b=MDWKWXX704lLOFhs
 lDPVDThnPx7TvBxTH378KhWYmTqFShjUF9gPFJALTofuAj0gn53vXDMcku/+QE4q
 5OZ1jY6rjy58/fp28q1xIbySknqTASGwSAiRyCU58ZHKqE4nbq0Bmc8kjdlNTjv6
 +wzQlKEdc03/iIEQlPc/eXVdWoRhNAUmv6zXNkrQ4syRL03mL1zvQHRHcxegmRi3
 qUP5duDFOYjwJ9du9qZjnQjQE0xzHxO2dIyrKxO67zNvYzW/fzKdkpw9ws805e2d
 kFHykBOmW2ozvf9aCq978ZZ3tjVv31xTfMokgNqkSnS+oOtawNjyS1/EvI0q10S8
 ngEQkw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv2e3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:28:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-520a00c7a03so5774871cf.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784226488; x=1784831288; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MwhUFq55A7WhvSstjaHHFnQhX0Xa73fpd3KAK7cCa70=;
 b=iuOdiq/dLw9sjo9pjDzaId0BakODBiNVRVxYYXTCEnx02MsalIICqYfQcS4+uDndgc
 agPv3Psd6egtyZNWcPkCBhrc/b2scSLTdnDZM1MSeFrxBdiZjH4YbK1cbrvatSZQc4tR
 2Qlk+d75tJHSC1pM/7VqByDZphysk1OhfAneeAZCQdEugoGqn1u8WoTSLzExxO9fyDsk
 WuWu8SMEgfJgD4afKYRYh1TjY3iFYrAgzHN5PQHnzuvbTD+uR4xZcbwqTJqn1bdnsLRE
 DCQYLN/PXL1M6MJjNmZm3xmK9xX3XJ4948HbSMzLhDV60Qp675wXYNcFl61mHkg4jBdb
 iPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784226488; x=1784831288;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MwhUFq55A7WhvSstjaHHFnQhX0Xa73fpd3KAK7cCa70=;
 b=QDVnGa5WnC4LGcM1P1mkJ+hkmj1e/gpIJ08JKBZdA4wGeUVRcG7VjnM5YCQxZDCAcB
 23M6ePfC5G5O433KgyH/+RrNwzJLQNVa8XK/pRjNvumfq8ODE1KRjXH3LFJYff5p5yjd
 vSyE593+DKbt93Wazvoc+NtoEW9dL5xYJRJ3NrHBhVdo3lp25+sVhJq3GlRpIsbv2RIm
 snI/GRpDrdc3j6XAmnjaryqsaIZvk9tAUt93mxHjqsPnzmWNTOJPKMxG2pHYpQ551I3w
 752uM3zvf/4UTDsHJ7xT5Tf20fAFSsXyVFzIF+QSuCOz+MV51oc9bzDYdkUAozCnyXog
 08NA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqT/QuZKtNogjMRoVBmb+anc96XY9YWsVvrpqgi/NkxHV7iL8+G2MUaI3JVBWIh4uJLVpCtZyjKfA9a@nongnu.org
X-Gm-Message-State: AOJu0Yz5Vd5nZdX5/PgQaCvTQdfwXa8CYCYGMqeA8E73q1mzsKTOXCQr
 hZV8xunBFZDPOe5pletfoiyEc7Pog+p8rzOEo2Ez2JJYmi28YqbBEH4scxFzaq+tLqMmm/dDTXa
 vEqcE9AK0Th4FZkG45AZ3uwT0SzijA478bLWDpAsr5Gi2PoHFdiPGVM5J6g==
X-Gm-Gg: AfdE7cnNStWncEfj8sqoovDg+rR5XMich93S5wU9vT08AcJ30PY88f428TxZpRaqHzj
 cfRf0WW7ZAAv4yXshTQzL6iMeHS0YM+90ZeFUrYjNXy7n3UCGGBnsDS9J8sYNaKszrQHbzvyEOv
 ig7/v/dewbIkvMiWL3KN+m+0/1tF8vzNAbS9XUWKRCKMEwqqnTBrPR1h9hBKPF98nRkpCZcTSE9
 vXvgNpcmlhxlOupqY0OsXBXixN2IYxvEqujLz6evs0CH8bvzrX82OTpbxisZ4GjMJYLZ4VP2oxN
 VxcX5Rz+7R3PAEzCGDxJbWhrc5cMCsnl9gkX+HaI4HmE5b1IVN++7KPHV1C7Y2/GaZwZZCw04KQ
 YitF7OLq2ejmcWmtyLomj0oTaZheWvXVt7lXuXQ==
X-Received: by 2002:a05:622a:12:b0:517:5bc1:e1f0 with SMTP id
 d75a77b69052e-51e4ecc843bmr90189621cf.0.1784226487555; 
 Thu, 16 Jul 2026 11:28:07 -0700 (PDT)
X-Received: by 2002:a05:622a:12:b0:517:5bc1:e1f0 with SMTP id
 d75a77b69052e-51e4ecc843bmr90189211cf.0.1784226487060; 
 Thu, 16 Jul 2026 11:28:07 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.123.183])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caace31a4sm165774411cf.12.2026.07.16.11.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 11:28:06 -0700 (PDT)
Message-ID: <a85ceb77-5a74-4495-bbda-c9ebe91e088c@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 15:28:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Correct cbo and lq disassembly
To: frederic.petrot@univ-grenoble-alpes.fr, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr
References: <20260716154615.1545145-1-frederic.petrot@univ-grenoble-alpes.fr>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716154615.1545145-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4OSBTYWx0ZWRfX2R2WKlx4/Opx
 ZfKZouyjkLUydqTS6Tzf6PIzHKkeDPV15LkqG8HzHEVbYd23SnxWIh0DYGFLD/nxgKfAFooFSCQ
 U+1OOjHTi22LIVk69TaQ6Z5Mjz5RBcYnUN1lljv9sL4mj3ZRdLmw+j7GQ+K+LiCtO+ZzPy+WURm
 WfkXhnwoafoQ2GhhKkF2Dlpwq8hJPlFsZTkY944MGWcbckufFbOBjrRmRDaVZMiEYtHvmGRRXSB
 oiJvIOtN5qiCw8LoNe9kQHkFpgOwR/N04bHSoAsgME0IdsITZDbmmdndre8BKeX2u0Dtfm0uz07
 l/eng6IS0HrPuiNCOg/tamCi6+kqYIfv+c/XRyKWY8iAinq/K7mUKq4De6OfCw/T8TAEFXLbhbS
 WcUJCCqrwv7c/am6aSaJn6DtM34ApVIAuuqAJo/Sensgd1JaEoF+o8S2modKL3u0TfgejKByz3w
 AZiETBzVTOItIIaWbvg==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a5922b8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=szoPuAicwqWYzOEwwuIrwA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KzJYEHemuV3m3EfXJ5oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: _h9X22P0osrQIodh0gbh9O5_hyWTgELK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4OSBTYWx0ZWRfX1v3IuQo2ZTqK
 Iyk0cKldbZaMmfDbFcqGLIVxidK9QEngj0wMHpw80Z9HPuZ2r2wlVEc71aueQ/MVD31FINZwa+i
 wEA4b9O3xN6nyaVmm/JZ0MZUdza1+Ks=
X-Proofpoint-ORIG-GUID: _h9X22P0osrQIodh0gbh9O5_hyWTgELK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 7/16/2026 12:46 PM, frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> The CBO instructions were, AFAIU, disassembled erroneously.
> In addition, lq (load-quad, a RV128 instruction) shares the same
> opcode space as the CBOs, which also led to incorrect dasm for that
> instruction (understandable since RV128 is an experimental feature).
> To avoid overlaps, we now require that lq is decoded only if
> rd is not 0, as CBO requires the field corresponding to rd to be zero,
> both in dasm and decodetree.
> 
> Change in v2:
> - Move the last v1 patch to the first place to correct the original
>    indentation that was making checkpatch unhappy before doing the
>    real work.
>    (Note that disas/riscv.c has overall many checkpatch issues, this
>    patch only solves the indentation one, but otherwise keeps the
>    same "style" as the rest of the file)
> 
> Daniel, I took the liberty to keep your "Reviewed-by" tag, as only
> patch order and indentation changed.

Yes sir.


All patches are fine for the code freeze IMO.  Thanks,

Daniel

> 
> Frédéric Pétrot (3):
>    disas/riscv.c: Correct indent for checkpatch
>    disas/riscv.c: Correct wrong shifts for cbo
>    disas/riscv.c: Correct disasm of lq
> 
>   disas/riscv.c              | 38 +++++++++++++++++++-------------------
>   target/riscv/insn32.decode |  2 ++
>   2 files changed, 21 insertions(+), 19 deletions(-)
> 


