Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3873ACA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZT2-000169-Ke; Tue, 29 Sep 2026 11:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBZSj-00015D-Tl
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:09:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBZSh-0005sB-5l
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:09:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqq7I350695
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 15:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 moocI9VTXpBxcu2t/jSPPRstrE/Cls/u13QN2JVpoI8=; b=HT6fuh8pnO2x3v20
 ei4Qiz/Ove6QjEI3P7r1lv91Z7fjaKbO2yl7t/+imRNTPxXGKqvGVlbk7V4lBgxb
 XmagVvE3vCuN8xIdXjK8IUk04EOQpSoCQHJWaTG8D97WTTGKFUKCfOHrPFpCNXI7
 nTpxdN4WGAUnmXFxktheuRyemoESQhomZkFbmyOgCPr99Pf87jnDhEANHaXOkx9o
 2Atiix5TsLTBock9oxIncgpqtiBH8vxio/xYo0NqWwoMxLpJVjLo7tFqEJOcGb/K
 8Ix8Vnwfkam2ANc26KPrHBf+QckXwKrZc9RYCgtzuFyTraaMeuqTnr8cPHc4C137
 hzXpFQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkkh4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 15:09:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5e9c2ec1so184565885a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790694580; x=1791299380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=moocI9VTXpBxcu2t/jSPPRstrE/Cls/u13QN2JVpoI8=;
 b=JbXS8eof/3GyqRLPNb793sALT2siSaldIhY6Ko5y1iWU4KL3FTmDYCbI7Ci1lxrqRc
 y3p1ohqWq1eXbZ8mv8P6XCqUiQDAJ8wS5P4dYCrWJItL3HXzkrH631uu5tGFgFEFaO7w
 EuY2DAGlsNe0I3FV0nX9OnEk5pJ0FApM+QLB+3vUXDGvW/GOwhkpuCJtam3wuQLEd8uK
 Rz2edwaZaXF15TS91UvbHlPEfZJSRN99gZDYmb7C8EOqU95zwFtiwoDQn7507bj8dPmC
 vTGqwmM6wCH66CqujmJLWbT+UBtZ5nCxtr0sUKhAvBI9ZHcFktA03eeyIYkd45bGhs5z
 KrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694580; x=1791299380;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=moocI9VTXpBxcu2t/jSPPRstrE/Cls/u13QN2JVpoI8=;
 b=rBKKzoNdTiuz86Wayb0AVqZlVFUd6VP3MIhsQ7gmrFri7RYCq/oug3EWWT5+l3MtLr
 NaK30wWgydmZHPu/duzBQQQMofNRX/p2AJviEbJO3jtQF91xJ7aP3aBsu2JBNyD43KuM
 AwL53669mgNCplV2nRicYzUFsd6GyBAaOapdr8PMwr3RhYzKn5Rjnh4NfCbur7mepw3W
 dOdElsMYFXOk0wRbZO+HLBHXxbvI6mkODYcNHrHFvWrTRIoJd1Rd96mL03l+MCzZHG8O
 R97Vi3oFTYsQKwrvnfU8I/qpVWotg2Udr4K+P/CRmzaDYP0x+kxBDvDLOhtrVV5I4OTz
 PmIA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHDnIcyTwYHuMlyUHLHd2DhPJLb34NNzqEbE7di6ngYC1JsvKGo+xytrFmMvqYDAUElwpzUmZQLUT0@nongnu.org
X-Gm-Message-State: AFuF++kPmzL+IoOb/e0hhugVm6cJvzl0mJydEubNvm7sLdJa/Ctga+RA
 Af8ocf1cJblLBrE4Qn69/s+YvBQtgZI24b0HgGH7HUxNnTV18WyFIkGzZfRn7Ga5DFatKRlKSZg
 BPR0Yys2RGmrm6q+phKeGYdq0Qn432mvrMubZraZxO0Tz8mf0mhM8MSkUJg==
X-Gm-Gg: AYBFou1Xv3MFrZiwj/vhwo01dbhMQQ1t2QqveFzHc5paagE91TQCzju6gmbNGjmEXQY
 8o5lFgu8hEU3hCooC0x5f52xXmAKfnCMqH5YKYoTrJk92wQw1dRc6BohbDCf21qPBTA4Fn1zeFE
 53jIbF580W208JPS+NkHVIPEx16GjVQOOCfqRcupaGlAJxjB8VGUKg1X34gYtYVEuWAQxmIaoWW
 ObNfmwv+yRtOBMBVW3B4mgLHGIgLrkUiSrrmgkAWZ49Hn7gn/4er2W9PsbMn/PD+jSw5FiqihPz
 QiulychCqyatdyl133DC+RfK73ehSOvWzTclWhRUwcaNUwZTegST53piTXymLifvTkWe0kvpF15
 0KQT3gaNKpZ5iW9dJLnmWsT6jWo1G6EtQQQ==
X-Received: by 2002:a05:620a:6407:b0:93a:ea:b00e with SMTP id
 af79cd13be357-93c8bf7ccf4mr505792685a.30.1790694580345; 
 Tue, 29 Sep 2026 08:09:40 -0700 (PDT)
X-Received: by 2002:a05:620a:6407:b0:93a:ea:b00e with SMTP id
 af79cd13be357-93c8bf7ccf4mr505782785a.30.1790694579628; 
 Tue, 29 Sep 2026 08:09:39 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50a3c49sm4793136f8f.34.2026.09.29.08.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 08:09:38 -0700 (PDT)
Message-ID: <365d64a9-416c-46fd-b9af-4023b112a164@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 17:09:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/25] named CPU models for Arm64 on KVM
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, eric.auger@redhat.com
Cc: cohuck@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org, 
 maz@kernel.org, oliver.upton@linux.dev, berrange@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, gshan@redhat.com,
 skolothumtho@nvidia.com, sebott@redhat.com, armbru@redhat.com,
 philmd@linaro.org, yangjinqian1@huawei.com, shaju.abraham@nutanix.com,
 mark.caveayland@nutanix.com, ping@khushitshah.com,
 sandesh.patel@nutanix.com, Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921123249.1708067-1-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX/dSxUfF1Dsln
 VBHp6qPZ8GfJP3E3g85IB0z3NSkig+m2+7wcUZ5CQm87rg9H17I5wEIKjkc62gk1DSfC+CoKBZl
 eb8YTaVHPrOZwt/5vHi0ml5J/R95LzsAY+p47jZTZPk2C2xijGWIWu/bGBcIOqvEceDyJfghs8b
 H3FEUXLsTcVD6/brrAFxxB1R6k2iWCjZ+0iR+HtO033lBdpnqCaG+CLnxsHtaK8d0PeXJD6sZEZ
 L/Vi74hudEDP/+qTeWPa+BNnWkygv5Ig7yz60uMxM82rSaT//fhmhVWPxLVlZqKyKpOHRt0Gef3
 t6zB7WRpz5/r1bc5Nfa7/ajUeH876JAMLgVaMJNsRwv/rkiE0QnkwTHJw4DgnFlLjf7Utobg1za
 7fXkZPxyFcFA3j4qNxbb8MpKJVPBhUGDWutOPb9NbCNcKBsLEa+m+q4iojH3APCaRKSkF3GmrHn
 JppAhKxDOYoF1Z0YQ2g==
X-Proofpoint-GUID: 8Y8MANONhFyfLoKxxUnZ82lI_SJvTIL7
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abbd4b5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=4azYNZDdmMagUpTqU9wA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 8Y8MANONhFyfLoKxxUnZ82lI_SJvTIL7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX2zEP4d32b+SQ
 R+3f4Xg+B7sY6rwpo+BSk7ttx5cQKPJ6gsk25g7hB/TVMX7It5NNpqojmIoWD7KbmR68/N7CuIS
 0PdbQ7LZ84xn4oN6NZ6sC4MQFhn+UO8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290060
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

On 21/9/26 14:32, Khushit Shah wrote:
> Hi All,
> 
> Here is v4 of the RFC for named CPU models on Arm64/KVM.
> 
> Background:
> =============================================================
> Currently QEMU only supports -cpu host/max for KVM on Arm64. This blocks
> live migration of VMs between hosts that differ in CPU features.
> 
> This RFC proposes hierarchical named models for Arm64 under KVM. A named
> model is a strict contract of the CPU features exposed to the guest, so
> the same model resolves to the same guest-visible ID registers on any
> capable host. Models can be customized further by overriding individual
> ID-register fields (e.g. SYSREG_ID_AA64ISAR0_EL1_SHA1=0).
> 
> On top of the models, this series adds the QMP introspection support on
> Arm that the management layer already depends on for x86:
> `query-cpu-definitions` lists the models a host can run and reports
> blockers for the ones it cannot, `query-cpu-model-expansion` resolves a
> model to its full set of properties, and the new `query-cpu-props-info`
> reports the values the host supports for each property. The aim is feature
> parity with x86 so existing tooling can consume Arm named models with
> little change.
> 
> TL;DR examples:
> =============================================================
>    # Boot a named model
>    qemu-system-aarch64 -cpu grace-v1 -machine virt,accel=kvm ...
> 
>    # Named model with ID-register field override
>    qemu-system-aarch64 -cpu grace-v1,SYSREG_ID_AA64ISAR0_EL1_SHA1=0 ...
> 
>    # -cpu host with ID-register field override
>    qemu-system-aarch64 -cpu host,SYSREG_ID_AA64ISAR0_EL1_AES=1 ...
> 
>    # query-cpu-model-expansion
>          "model": {
>              "name": "graviton4-v1",
>              "props": {
>                  "SYSREG_ID_AA64ISAR0_EL1_AES": 2,
>                  "SYSREG_ID_AA64ISAR0_EL1_SHA1": 1,
>                  "SYSREG_ID_AA64ISAR0_EL1_SHA2": 2,
>                  "SYSREG_ID_AA64ISAR1_EL1_APA": 3,
>                  "SYSREG_ID_AA64PFR0_EL1_SVE": 1,
>                  "sve": true,
>                  "sve128": true,
>                  ...
>              }
>          }

> Khushit Shah (25):
>    target/arm: expose SYSREG_ props for REVIDR_EL1 and AIDR_EL1
>    target/arm: expose all non-res ID reg fields as properties
>    target/arm: move SYSREG_ prop infra to cpu64.c
>    target/arm/kvm: enable writable implementation ID registers
>    target/arm/kvm: read all ID registers from KVM
>    target/arm/kvm: handle special ID registers when reading from KVM
>    target/arm/kvm: process ID register writeback per field
>    target/arm/kvm: handle writeback for special ID register fields

While the first part of this series do KVM specific calls to get
usable ID registers, the rest doesn't seem KVM specific. IOW, what
would restrict named CPU models to be used with HVF or WHPX? IIUC
as long as we can validate the CPU features with the host we are
good. If so, some handlers should be moved to the accelerator layer;
but of couse this can be done later.

>    target/arm: introduce named CPU model infrastructure
>    target/arm: fix SVE and PAuth finalize for named CPU models
>    target/arm: disable PMU support for named CPU models
>    target/arm: add arm-v9.0-a-v1 named CPU model
>    target/arm: add neoverse-v2-v1 named CPU model
>    target/arm: add neoverse-v2-v2 named CPU model
>    target/arm: add graviton4-v1 named CPU model
>    target/arm: add grace-v1 named CPU model
>    target/arm: fail named CPU models on unknown non-zero feature ID regs
>    target/arm: add cpu-models-stub.c
>    target/arm/qmp: allow named CPU models on cpu-model-expansion
>    target/arm/kvm: compute host-supported values for ID register fields
>    target/arm: report 0 as supported for ID fields gated by vCPU init
>      flags
>    target/arm/kvm: add kvm_arm_get_host_isar helper
>    qmp: add query-cpu-props-info command
>    target/arm/qmp: implement query-cpu-props-info for KVM
>    target/arm/qmp: hook blockers in query-cpu-definitions


