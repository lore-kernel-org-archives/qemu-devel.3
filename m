Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8213BCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhZo-0000c8-3D; Mon, 22 Jun 2026 12:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbhZm-0000bQ-8T
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:32:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbhZk-0000vw-9l
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:32:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFY4Yt1406592
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nRu4ta2kbnBOzeWFGWpWS2lhAoFs/peHy0ujPNwM6Ro=; b=oddR2rxmY33SVvt/
 GbMJqvw50Uv45XmDqzLHcS45b0w72VM7LzTSpGi77pykEEvNVTjlRffPQx0mGGb5
 BENkByWM8Viheta6iVMUuU0NvDE+UmOfitnxCwHuCoVtz4iseSwwMUciN0NrHzZW
 AdBBiG7kzD9KplgGgOf6q3G8BB1KAFl2pEJ/SloL81KC+yooRarUV8qNKUwtehUM
 hOPU7q6BYXPTZbe0gHFBXrvT/55+AwGfVOPFjx84abIW96FVGYssI7jnB//kZDd/
 ZnKDrzCRBSi2zXuMfgYDAm/dXRlLckSJRUx6djEv2+rwaAt+Q7VZqKaD7D375lTu
 sSCJbg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye8qr1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:32:41 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6751c50552dso3024917137.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782145961; x=1782750761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nRu4ta2kbnBOzeWFGWpWS2lhAoFs/peHy0ujPNwM6Ro=;
 b=JNgcj1xBsH9xZPLyrJWM2rGMHQ7qhjlJxwnaQ90VjT5xibzNp7IuPhZbXlqA5Pz7ap
 4iK9PBsp7u7WfI/OT3fml1wCDU4Z/BjtiKg7mwI4g7lcjIRP7iP60DjVGoco18ZuC1UG
 /JQDOSmes1PjbNE4FUFAOxapZAczeg+9rXVuHHqfG+/U2qaOFkgdf11oAWVu2GEDK/nS
 hqCnzC5LTEr+MHTryrVdsKYRQNwHoxypeaqZRW+dtZm0utp1NPPScpnZPCKpfZBbuLfJ
 O7pRcdVLejmdkJHIH/YDIchaoEv57vD5a9j4GET6D//eMg+ouCVHDqgSqmRHefT9zYSX
 O5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782145961; x=1782750761;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nRu4ta2kbnBOzeWFGWpWS2lhAoFs/peHy0ujPNwM6Ro=;
 b=U+1DDQoLKKxtGWNuwUC6XNbPdsoDry69Yr9NuxGJ2U0Z+8r43RQokmF9MRs0sK7wJi
 zw5KGG5NbmpLVAWYltNGmXevCtxotRdGsIokwy2uIiQ0tk8m4cyuKPndDQLBSf6Z5Fo+
 0LnpGMf13ORcfvciS5wAfyQuXtN1sXM2mcWQWkIAdDSnn3uaP61R/a3MEyoSNeApDGgc
 vSJ8/v9rPgR+2O60Rz2sc55tqS9eDMZoiaIdzg39rKs12WVIR0hnqzLhkA1FoI3uTMle
 6Uq//BVQSPDSt6hhGRZtgwIdhZFp5uYBf8RmXurHZM/i7oUUQutE/2OHa0uXAuLCSVD0
 /0aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2tOniNtD4e9tqJ0hwoY80GRkfVgLZOIlGEgKkPZuASE36ggRsPaoUssQiIpJSv56ztnUXQ6E3Tv9X@nongnu.org
X-Gm-Message-State: AOJu0Yx1GgE+GNwGHCQddhK0+uzRM65cSXWgGIqUXyWMOPP0MdyGESFe
 MZ5bYwMhS/c/l7AS9qt20XIhhJWwf4SP9BY1zRiKvESIFKWGXaBhubs2K6sefLxlTOMF+PWUyzT
 uwLHJp+yQ3j1QltzWgej5Q/HmgwnyXFNwtKxNaPmP3bA03fSlLI2XMc4+0A==
X-Gm-Gg: AfdE7ck6iqbJMs0JsSof9O5bKtoy4awvlYoIq1bmS3sP0B+TPIeZyFZHuhou2T0FAPM
 LR/n7HRcFr6iODigOkcnpOKbBXEXroGobDQZs70+udyDEv2/7x7r9PTf1+moDcDxyxy34qgpHh2
 6ixG4dpXhvU5JHdvoj84QCxJCXnUgMP3XAMO4dUbP9xqBexxXsEhMSLsacF3R+Fvp488pdSJmQ6
 iHk4/NWnpyJWtue1yYbQtS6OQ/EFkCg08CCY2QZvqnGHw0STPVLzD02SKe3uYRSvJ9i7GpesnPN
 X7ZV7A0cMTeBHye0vErq4bwG0MnnXWsItFjEAKcxIzbGzMjGeawgaxOdCwHB/ZvPDRs+cipHeJG
 qSxOPm4OIlVDCEyjKzCYWgvAXh5x+7zgJpkZp3E3bQ1Ag
X-Received: by 2002:a05:6102:568d:b0:650:a5d1:ee1d with SMTP id
 ada2fe7eead31-72b65088a76mr6166902137.10.1782145960686; 
 Mon, 22 Jun 2026 09:32:40 -0700 (PDT)
X-Received: by 2002:a05:6102:568d:b0:650:a5d1:ee1d with SMTP id
 ada2fe7eead31-72b65088a76mr6166835137.10.1782145960182; 
 Mon, 22 Jun 2026 09:32:40 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51a9c533sm1457481cf.14.2026.06.22.09.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 09:32:39 -0700 (PDT)
Message-ID: <b69f982f-0af5-40af-b26c-2ac8e541db32@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 13:32:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] target/riscv: Fix no-TCG build
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, alex.bennee@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com
References: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bnmI8rmb6BIOst_oEUm4IvhZuDstNGQw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2MSBTYWx0ZWRfXwPNk4Y+fDq58
 NctksXkVlAFVSyZCyC3ONh5MyWxTJa0D75kg0jG0YrJl5C0Tr8a1CeQeXKLjqpWw7W857Rf2yID
 EfxRxU3bfnwpUwToTD4ma9UJK1PDNBw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2MSBTYWx0ZWRfX2aA2uBL4UMOw
 dgpz+DYPSZbpFzmYPruHjwoZ0aCKcvinmG4+WuS1ruRLRMjnox0wD+6brTE5CHM247/rs5Yxiqy
 FNWg5R4evCWIuBUeaJklWAHNzu+CBhDe2DekJmTgyypfHbsj9HLnfRQdnhXnvOHmGYwLpFFK8Jd
 TU+pGTiczcDr/+z6grj8lpNIhZbDL/td5P+wpPzC7FH36fBy+3ZNlsEyJD2tO8BDNkG2h/zIu7c
 MSvIpYs0jaCsawcpp1JqAkjGfxIG0bRY/iUon5clZPkIwoucRBRFl6KEFtJY2LmpuT4+OSUAgao
 qVGUZfHkxSLEgMxQpwxbed/kC6R1JxzfaxbYjewoBsSyGLKIjkjBEbUWgritQk/XMvkC99raSzl
 bKtjG64u+AglQDK0Iv3b/z2ZFDGVJnYQw7+iVrPOYjNFrUqgEt1lCky8VE8OkcbJLPAAfc1H4OM
 HIkZSUDqCGU6zxLDLdg==
X-Proofpoint-GUID: bnmI8rmb6BIOst_oEUm4IvhZuDstNGQw
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a3963a9 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=hZQ7wMXsWLzBu-v2IBsA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220161
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

Hi Zephyr,


Sorry to take this long to take a look at this work.  I did it last Thursday.
The overall idea is correct: we need to remove TCG exclusive bits out of the
way of the KVM build.  Our current code layout is awful for it though, and
this is the root cause that needs addressing.

We have too much stuff at the target/riscv dir which is supposed to be code
that is accel agnostic, and unfortunately this led you to wrong conclusions.
For example, in patch 1, where you're moving validation code to from tcg-cpu.c
a cpu-validate.c common file.  KVM doesn't care about any of that - KVM
validation is done at init time by the kernel module. It doesn't care about
riscv_cpu_validate_set_extensions() and any of that.

For the record we had a series in 2023 that tried to fix --disable-tcg:

https://lore.kernel.org/qemu-devel/20230711121453.59138-1-philmd@linaro.org/

but at that time we had other stuff going in parallel and the series eventually
stopped applying and that was that.  Which is a shame because that series was
closer to what we need, but I won't ask Phil to re-send that again because it's
a rather unpleasant rebase.


Unfortunately I don't see a sane way forward aside from doing the grunt and
gruesome work first, i.e. putting TCG specific files in the TCG dir, like x86
and loongarch is doing, then go through each problem that --disable-tcg points
out, fix it, and do that over and over until we have a working build.  And
there's a high chance that we might break some unintended stuff in the KVM
driver regardless.


I'll send such a series later today.  I ended up using 2 patches from your
series (patch 1 from v2 and patch 6 from v3).  Hopefully we'll be able to
put this --disable-tcg business to rest.


Thanks,
Daniel


On 6/2/2026 6:17 AM, Zephyr Li wrote:
> This series fixes the riscv64-softmmu --disable-tcg build by keeping
> TCG-only code out of no-TCG builds while preserving common RISC-V CPU
> helpers for non-TCG configurations.
> 
> Compared with v2, this version replaces the no-TCG stub for
> riscv_cpu_validate_set_extensions() with a common cpu-validate.c split.
> The validator is used by common CSR code and should not live in TCG-only
> code.
> 
> Changes in v3:
> - Replace the no-TCG stub with a new cpu-validate.c common source file.
> - Move common RISC-V extension validation and user-option tracking out of
>    target/riscv/tcg/tcg-cpu.c.
> - Move fflags and exception helpers out of TCG-only helper files.
> - Reject x-misa-w outside TCG.
> - Build RISC-V TCG-only sources only when CONFIG_TCG is enabled.
> - Add GitLab CI coverage for riscv64 KVM-only --disable-tcg builds.
> 
> Testing:
> - ../configure --target-list=riscv64-softmmu --enable-kvm --disable-tcg \
>        --enable-debug
>    ninja
> 
> - ../configure --target-list=riscv64-softmmu,riscv64-linux-user \
>        --enable-debug
>    ninja
> 
> - In the no-TCG build:
>    qemu-system-riscv64 -M virt,accel=qtest -cpu rv64,x-misa-w=true \
>        -nographic -S
>    reports "x-misa-w requires TCG".
> 
> - In the TCG build:
>    qemu-system-riscv64 -M virt -accel tcg -cpu rv64,x-misa-w=true \
>        -nographic -S
>    starts without reporting "x-misa-w requires TCG".
> 
> Zephyr Li (6):
>    target/riscv: move extension validation out of TCG-only code
>    target/riscv: move fflags helpers to common code
>    target/riscv: move riscv_raise_exception() out of op_helper.c
>    target/riscv: reject x-misa-w outside TCG
>    target/riscv: build TCG-only sources only with TCG
>    gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job
> 
>   .gitlab-ci.d/crossbuilds.yml |   8 +
>   target/riscv/cpu-validate.c  | 630 ++++++++++++++++++++++++++++++++++
>   target/riscv/cpu.c           |  13 +-
>   target/riscv/cpu.h           |   7 -
>   target/riscv/cpu_helper.c    |  53 +++
>   target/riscv/csr.c           |  12 +-
>   target/riscv/debug.c         |   1 +
>   target/riscv/fpu_helper.c    |  27 --
>   target/riscv/internals.h     |  26 ++
>   target/riscv/meson.build     |  10 +-
>   target/riscv/op_helper.c     |  15 -
>   target/riscv/tcg/tcg-cpu.c   | 637 ++---------------------------------
>   target/riscv/tcg/tcg-cpu.h   |   1 -
>   target/riscv/zce_helper.c    |   1 +
>   14 files changed, 769 insertions(+), 672 deletions(-)
>   create mode 100644 target/riscv/cpu-validate.c
> 
> 
> base-commit: 5611a9268dae7b7ff99d478ed134052a9fc7e9f7


