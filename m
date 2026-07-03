Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B31C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfbNr-0005yl-DV; Fri, 03 Jul 2026 06:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbNn-0005yL-U1
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:44:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbNm-0006lG-Er
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:44:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636h0dx3144241
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 10:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EoptIEfXdRo5LJJfWXdH2s7nSRvlNiYy8UXZroeRxGs=; b=DtMH3R0fu+EYWG+4
 vQoJ9WmKfxQni8jkxWbl7+J44FS/4Va3+tenGq8c7/6SSf8QUtCnrbMn3jpR9jd6
 HKeRWO6Y6zGrr02WLBP5q4MoEZjWr8Tgx/VWaELW16/EM9/lNctSDR93GAcOMGUc
 jl5CPLHqm6irWy+6kJyjZNU51oguwr6g/NYw5xJlA9qwugLkTOL3gm+MFpVv7hEX
 kGEEZUCHIZfBrsn/3lIt4m3QA/dm3STN/zj75IKpGFvFiNMFcYIahLW510j4t8xS
 RtSRwyzwWoUAFx7XX3bNcptKzWWteZi/ZhqQ5GXiZiFOq05l5PdEHNCw6lX007iS
 JCCwUw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682brvau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 10:44:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ac0a54110so47883485a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783075468; x=1783680268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EoptIEfXdRo5LJJfWXdH2s7nSRvlNiYy8UXZroeRxGs=;
 b=DEZLP5QKrF1Rf8n4tCA0nuWXWsEVKK+UjqJrGFshDLiL0QiHcDEa6IJhSNQeAlztu9
 8vHJLzathcSCCwzc6ZwFpa276pYpoReYnPqOYxrB943ucI4drCs5/HpHmkRJgBsK/avJ
 wpWftciLAm/rBhSFVA5OS+rCm19IVO8Bz1sHP+eDDb1WzaxoQcoJTsrC8F7gFasQivm1
 bmQZSSgLc2d5xIWTASz3Mt+VZndcnR0qfXZaon0URLp0xQYjhSJp8gGvotAlmCFS4bwf
 W3shXdc1cSUy20xThui5kAXUEkOoZ7Oc1kzgPDiFodp3YBU9Wdx1xViV/+1mkVjbNdXn
 cjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783075468; x=1783680268;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EoptIEfXdRo5LJJfWXdH2s7nSRvlNiYy8UXZroeRxGs=;
 b=UUXo4zsQIshdPpWIxnhelXrkb3QlXLh/UJYqb7kVer9/vXECqOUcbz3fNaGYQjj0yN
 GBfsvFRJfu0m1wyPH3rbDA19hWreta3yvs/v8lGDRUwiRD/GuQqmfyl/iKAt1BSeGssk
 QHqF7JC9TI3sGRL1ZRoQtG63hCIARm0wZeoMri4wAl0UsUqw6b2MgN7JF4wKYh3pGWMA
 NEyyk8WA6A/D5a4PQAmIw1sPABviEsZj6YaNMguVrXEjKAk2hiS+b5kWpbMNICReZ+fA
 QOwPbmCJRmJUjFuMhOAlEcUT3pOE05Y3dYT5KgUguNtSYXNoUzJE8w0PzoBsdtDFxr2F
 rJhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NUhGa8Y9qUEFz2K3tlqnN/Usza6TlHaNZvrlfYhjZjklgH4L/Qx77c6dy/Zc+WwrW4qystbgjlgym@nongnu.org
X-Gm-Message-State: AOJu0YxOGKa2psaGqIzfWBffrgHtsTC3PpSoXuEKEB2N5tFOGURJpca/
 UfcjR3ux0eUXQHwdJmmETLGv7Tiw22KFp+oKlwIdT6ct56j0s6NsT255knYPm0QIW00DYp2rKaf
 k/5IhLCEoN44Hb7DII9EJyjfflQyaR6Snn+AKCFTPoSrJ4zEKNQKO1Kr7+w==
X-Gm-Gg: AfdE7cnJSRONV9Ncg3jLfYm6+8tEzgJ1EfEgQCI4+8UZq7Mt8gYuhxuoHQmvvCe20Zf
 Uf475fLDn+4wc7tsPxI7QbAkiy6d6UZJobSgtvWhvXV0jMmI9XG/bulypHa9ElqmRfqpj874BJf
 iEvDiW8Aa9+no1fiHzJsNToFtVUcSLkjc+SMKFx2voeT4kC7VZoDIjqHa1SHFjC5/eV438+J70C
 eQlgcLBe0iK6LKIU01Af73h6LmZgKOlUoi1aucCEfRq/m8cUO+FYVc5iGdqQCGdF3/0Fp5x0pBL
 Ubwi5RvwDHSGQG6m6D8z8V7l624TKNNfCo2ve7sTfDwsUQ8pM8q3vhXTtvzUK/YY0wxNyXwFsmv
 yjAuRrmfx7Fqe/tYizaYPW9nYAmNtRmUdD2P4buDpnowTDfzrCKsxFgz3PTyseQ==
X-Received: by 2002:a05:620a:4016:b0:915:8f76:7ffa with SMTP id
 af79cd13be357-92e782c6315mr1194923985a.45.1783075467790; 
 Fri, 03 Jul 2026 03:44:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4016:b0:915:8f76:7ffa with SMTP id
 af79cd13be357-92e782c6315mr1194919685a.45.1783075467262; 
 Fri, 03 Jul 2026 03:44:27 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477ddf0f433sm20334083f8f.32.2026.07.03.03.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 03:44:26 -0700 (PDT)
Message-ID: <374abf50-4593-4888-bb9c-2ef731b6d7a8@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 12:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/24] target/riscv: move pmu.h to tcg subdir
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-7-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702135128.1188021-7-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwNCBTYWx0ZWRfXxIUQtTxvrWRH
 6P6Em8+uTOOG+gn73HncMf01GK/F7i0riB1acZgNtV0eVMjAx95cikr4z83OrGMmwNrKEKyoS0G
 lRQ+lxG8Sci6jx1dHL8eeObLBs8AyWXgZxXm8fe65PYK2NqABLNGjWPefOIzMfYcArQIqcUg0Hx
 A8bo9llKeOe0UrOrBZJcQRoEm5XQcENNO3/9TJupmXpI7Kel8DV9pHPft+dpqTJBQdO/C/+5ywo
 ECcABX8x/BLDGfgmRCBYiGhFt+zzZfSLt/9i6duJ32u6NP5Oh0+pJgoqX4tBeJXul3UhaevNZm4
 aRizqPM4Tr41oosf3uEkzK+tErT7V0d57CJx540XI1rOIJQlQNDsyeWJIsZ5wkgA6f42Wf7DIyq
 r8OWfzliylrkJlkoix1njR9x5o/bfOK3cwgFEtCLYMpiBaY0LebPXLn9rSuPlTW6m1VVuNpwO8X
 zD/UM6njcBb/JbNOYmg==
X-Proofpoint-ORIG-GUID: bh791WSfdMixCA7DrhN9P34yGxueXIwC
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a47928c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwNCBTYWx0ZWRfXwWs/Ha0ptX5L
 c4REhg6gRDs1qTC2unU1mPUzbFWqsZ5knWgIahPXxZFRG3PFgo2Xb6TDp3Tee4u6a6P2fLXHkKK
 ClUcecgCphi8K1DFnAH/3uqI5J1dE24=
X-Proofpoint-GUID: bh791WSfdMixCA7DrhN9P34yGxueXIwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030104
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/7/26 15:51, Daniel Henrique Barboza wrote:
> riscv_pmu_generate_fdt_node() can be moved to fdt_common.c since it has
> no PMU TCG internals.
> 
> With this change we can remove pmu.h from 'virt.c', which is now
> becoming a tcg header since we're moving it to the tcg subdir.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/riscv/fdt-common.c         | 52 +++++++++++++++++++++++++++++++++++
>   hw/riscv/tt_atlantis.c        |  1 -
>   hw/riscv/virt.c               |  1 -
>   include/hw/riscv/fdt-common.h |  1 +
>   target/riscv/tcg/pmu.c        | 52 -----------------------------------
>   target/riscv/{ => tcg}/pmu.h  |  1 -
>   6 files changed, 53 insertions(+), 55 deletions(-)
>   rename target/riscv/{ => tcg}/pmu.h (95%)

Preferrably before patch #2 "target/riscv: move TCG only files to tcg
subdir" if not too much trouble:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


