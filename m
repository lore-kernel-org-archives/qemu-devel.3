Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8763AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaWi-00041r-9Q; Fri, 03 Jul 2026 05:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfaWg-00040R-Fx
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:49:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfaWf-0002Hn-0n
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:49:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rZDQ3136094
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 09:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LGN3HMB39YqYi6H7y+f8l31qIF4MTB4SKVc9Ex8b5Ks=; b=EkXzLtBgX6hRE3Da
 sHTtoxx1EKgA+Ose5EF7Urhr3+d1OSnvBJKiN3OXmxxUWC1T2x9ue0A2ZBpKWljt
 NkPEMI0IxATTMeog2g6OvqYduU5uNvvawVwHH1La04CzPJaGYS5qBKJHK7Zlg9Ej
 uL3WmcPlTUzvcNlZsH2iPM7orETxOK1XztEaxehNevgnfa6UQNYQ7xzp7eTQrGzJ
 rgDOS57zbIhUTcd1wsSOKhA7Pgh3LNugkth0UjR12FVarUxkQnzMsCvg42Z419gp
 zlSmlKv+VP7kh9KIPWBRrPJ0gcIFLLxV8achxt6JuwvVL8rVmbDqPYuXXD7/sgfk
 FX/5Nw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b59pvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:49:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d30035dso3224581cf.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783072174; x=1783676974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LGN3HMB39YqYi6H7y+f8l31qIF4MTB4SKVc9Ex8b5Ks=;
 b=FWBIRmrjQU0e0CFJHLqAHlOaKnSX9Jg/qy6tJHTcl7lB8x5Lfo+8bfl176ABNL4JNb
 vnQaQ68cSwbkOhGiddeoJliIdTD3vVeZf61uHLuqfNwx/fdZ/ofsMtlLiu+dkQcu7v27
 voYC8AEI3Mb/StYq8Ex9xPbsQCpZEc4N0AXKVmJpQqVAze1QtirGd9XsYW+nQh59WU9Q
 CZNOvna+Qqyu9+0M3FPhbcDPI5jWHaD1IY9+FQ0oWebdNaGGhONsy8Y2wGIlqxi1jBVq
 teT4xQ1EuOf5CWefoyiE5hcRwGP5+vA2sdoUyxGkiLLVif6tG95ZbO46qkTuZJo0hBpg
 uu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783072174; x=1783676974;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LGN3HMB39YqYi6H7y+f8l31qIF4MTB4SKVc9Ex8b5Ks=;
 b=mzS0WhvYb2YQ/1Q5yRMmPw+YpviJR8TuwKoZpnQW7d5H75r1HDcIU7jb7VxIgpEHgB
 XaDeniWQMq/hGU2xHw9HrnKT7aOa3/F9OFSX4ZHMbiJu4SAaR/AXBJ9nN7OhKqCehnFx
 JZ3ug7e+LcE5tA2ZBRKiaXnjosYf7IONkAjokPXQb177IHGxC7l2yyO7qh6Gh4qDO5jl
 0/pnjCr2jsSLmjppsaR5as4QZwNT7V4lNQxGeNL3/uIajhFY4PXGMAVwUTpLP9VDYwVa
 eGUE427BjgV2x3qymae6Lj7iT1xjXaotrEUOLZH0JcvNJMyOWnzwa9SOwGTIAswKXM3g
 0RGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ebotwMEJJ7X8UZMmvFFIweYROK5v2QN8hJMmklwOgm30BjBqVmVMB65/LO5wuw9hvf2U1hXfqUzKV@nongnu.org
X-Gm-Message-State: AOJu0YxYIyhJxFUu6Zptu/PmU9OUPoKPk3NFz3KXyRc4bHpDi+H3LJRk
 x6T174Gp/s2g/7IZsfawB89w5bVT3EQ35wVayVtdw/g9XpvsEOCkys9x/MRmsHq0uVlv0IvOUEV
 1MRBRm4cwZVqYTg3zDbNfe46uyDAz+Yop+Dw99REG8x/zDgrSfDWivoq1Jg==
X-Gm-Gg: AfdE7cnrR/JLZMoalOATfcBGEitgAQZuynjW0TnoLlqlhbItWcvWqodwrQTjTikb5zn
 j0EcMYPfwfZoZTQZ7YgXV56CskRAH9n+cgnyI3/EsCoGpojla3lTsfneTrJFpgOHk7d5yhZhPkd
 l0l7ZKwgC/Azf2Ydh6fd2wc1GX8eLpyGufXd1a1qH/81NXTqPx/Bw/sGzGi6c/lSZ2v15QeqN0f
 l0vz7wIe7Yr+Zt0Mw4VnjaGmxD3ny0F1XgIfza8r6pfAoxfgaCREJWlYr0sPGekP+fqQvSJMuW9
 60M/YjNa/vAG3viqGSPC8MYXl6mjl9g4JlLmcgWFMrIn6UJau3T6JD3SJWRjowCK+GVcVt28QN2
 sN9YfC8CXDd67ZhkiaKWvzQCdMyfsOl/NTbmtHuiAXQCO
X-Received: by 2002:ac8:5707:0:b0:519:fca2:346a with SMTP id
 d75a77b69052e-51c26a61506mr115838241cf.23.1783072174239; 
 Fri, 03 Jul 2026 02:49:34 -0700 (PDT)
X-Received: by 2002:ac8:5707:0:b0:519:fca2:346a with SMTP id
 d75a77b69052e-51c26a61506mr115838071cf.23.1783072173854; 
 Fri, 03 Jul 2026 02:49:33 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46aecc908sm52985116d6.0.2026.07.03.02.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 02:49:33 -0700 (PDT)
Message-ID: <7cdefb21-7cd7-47a9-b242-de39f3b024c7@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 06:49:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/24] target/riscv: move valid_vm_* satp arrays to
 cpu.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-13-daniel.barboza@oss.qualcomm.com>
 <d4a4c873-0c7f-4de3-98f7-882f74bfe151@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d4a4c873-0c7f-4de3-98f7-882f74bfe151@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5NCBTYWx0ZWRfX5NXc4eNNcdR4
 i6hWnZ3RtHPCJ1XXyBorD/mDn3KZmoLxpJIPyBldxyh4lOL0fh8flv+lSlpG8e2w9vEz1cLFDPk
 ekFjN476TfEehbh6ik9oUZrfe0oTFPs=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a4785af cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=h4OL2NWzkvS0Eyh6BHUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: ZgIr41jwm25UaUf0xQ4tGEi0Yo4Dua0o
X-Proofpoint-GUID: ZgIr41jwm25UaUf0xQ4tGEi0Yo4Dua0o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5NCBTYWx0ZWRfXznQa1xYkc5T0
 xj0suF0Mozu5SJmOPsWj98RjjKOQvngnfFxe/OXc6AtoNGPY8NHqfQvL2DaDrmEcbKoR2SI72Mz
 LV1r2Aw+I1Tc0qEQVKAFAwnKvOPVja4UVNf3P16VAV+2Md1nTopwvI0wKpPlJnPms5mympL7GIb
 DZ/qlHC8Lc8pV0/GOtC0CDrY8MkS2DEyLA8VSOFMjV65SdtjYMBPS9WN4eeQxLtI/SD4QfRuXze
 VYn5IvCTQryI97ApMQZuM6quYKymB7w9xTKVHjl3GYxA9WvcsUeACvaND8Z2e1dbkn923iMkHTa
 yR8qL+BeYzzbokQKx+By0+mv8APQSYr/pDpY9yGB1KBtm1Hd59GIm24hnk1vVEodst0hTTrbivH
 og8PLHzHDu5gxdwqReq6FwcdQ8gwGzLHCGw9l7Mn9izC3vrrFKWzDOgaKDm40OEJQSYX/pKj3tC
 ayTqWo6uFcykQZhi31A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030094
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



On 7/3/2026 12:10 AM, Philippe Mathieu-Daudé wrote:
> On 2/7/26 15:51, Daniel Henrique Barboza wrote:
>> These arrays are used internally in tcg/csr.c and in cpu.c in the satp
>> options logic, which is common for both KVM and TCG.
>>
>> Move it to cpu.c to allow KVM to keep using it in --disable-tcg builds.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/cpu.c     | 13 +++++++++++++
>>   target/riscv/cpu.h     |  2 --
>>   target/riscv/tcg/csr.c | 12 ------------
>>   target/riscv/tcg/csr.h |  3 +++
>>   4 files changed, 16 insertions(+), 14 deletions(-)
> 
> Preferrably before patch #2 "target/riscv: move TCG only files to tcg
> subdir" if not too much trouble:

Done.  I'll send a v4 with the change.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Thx!

> 


