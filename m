Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B334606A332
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ErdCIeTe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sj8r0mqH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPOJa-0005Z6-1F; Fri, 06 Nov 2026 13:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPOJU-0005Yd-WF
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 13:05:21 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPOJT-0000P7-6Q
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 13:05:20 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6HtQbb489744
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 18:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tcMWvYme3+YGeK1YfM37cDjLBAz/jJM+qVu1QTX+mx4=; b=ErdCIeTeeNmhzTm/
 5PilaY+1HYHj/7DgIoodKC/O2qi6UB5cJCrVUtbG0Dr8Nfg+ZJX0PCSA2ecJeAja
 wUcYQvKymnEXDXBFdly6UV0LcGZNjaVwW7ojKbZ+316aEGvg50s9sVKNdPhsevcb
 xpG0i+6JZMfefcScUWcorNYbz2KHAqArGW6SRiBZgk7RIC+C+2rOfC+kr9h3Y1Jn
 xAwP0hePr76YKoWL+uO9b/wH5pCL1l/E7qcZP3Ia8utVll+6+2f24m/nndJUlc+k
 +wHjn4rx1BymvHH7gQm5oEP7ANgv0FpT6pJLlCvoDlW6UqMPP7HEbCO58IT8VPnL
 3wMKdg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa43qk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 18:05:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3700be873ebso684336eec.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793988316; x=1794593116; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tcMWvYme3+YGeK1YfM37cDjLBAz/jJM+qVu1QTX+mx4=;
 b=Sj8r0mqHQigGZ+aWdsBpftEXHCpNu8wzAmvDTK7w9b0tOTyqCAiiwHf79iCSyXZ3DO
 yL/6EeWy9x+BRHKxmU7spHudcG3Skj3dXkTCXChxLuzpbfLuiwQ4ltqU0ITQ8USdZYfP
 Nm79wnNDcoz73ZcUV85Y2dO/IBAoBr7re6jAJfA0bSO+cReAJZ6WtLCbH7H8Qzj85PGb
 aWuwLE5h/WRhXFQ9qSkOyfEaPxBYTtcGZjewGcS8gFG8bCNajCSYf4i6B2Llom2O66d4
 k1BE3CdhFJlShsHElvSF2EdZtkjs81oc5mF1ba/hn4wY6LCeilVyln3MF9mcuh+Nrv23
 zZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793988316; x=1794593116;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tcMWvYme3+YGeK1YfM37cDjLBAz/jJM+qVu1QTX+mx4=;
 b=eXtCDYVg5Y3r1gdCaA/HaZjw3i4B9BfeYHWyyd29wF6r8+uShVE49ixXtEU7zVwfvh
 v8+Y5KSe1juMjUmXYXtYNy3Fv54K/CjyUkImWyFq8Z55aLJ5ZJExb3WRgSBPryadtLs6
 Rs6WO7g0CmZlB8GIe8FjSq36oT9/fw3AREVZfalu5x7IR/TdH0VtfVJiBL64p69REDmo
 ZgNPb49Rv0WloavVjwoTI901CLS4u33bInhNXxSC3VJ00BkgnyQqY78zxFrABpJJLGP+
 /YH83irWVJeG6ISOZs/5dE+Z3Pt1TAHstscAY89IDNCe49ZH23bbEb3yd44SSaJHMAfQ
 BBPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFFtEFbbUihXvbXwNsEKGbpvsm0kS1q44SsPqH6SEOlJ1o5cho47t4cIuPEND3pj4ZBE4vuW/ycraQf@nongnu.org
X-Gm-Message-State: APuU4Z/XxEKGYWfu+rAic6Iem9StmQ9x82nw+ZQGB5Tam8iKSWIXX2UU
 NR/xeU/VccF0HorSIZC9iJXufdkv00LyBaUYsGRJ5HGNYOII0bVXx5738cLcRJdv8cTOvuP/wlL
 fC93c0cZPvBmDJmfE5/9WYjbxD+YaD/FkfF+QhIaFyrIT9omzokBGXpq8rg==
X-Gm-Gg: AYBFou2QA10VI2zEb2+lhXtue/fguVfJ0kEmZeFGZUTz9oys1yxWaCy6Ke05V4ZlUCV
 J5o2fdwL2K4KXO+YmICyhtN+jFmpnjg6BqNuNRuTBO+7a9Pv4fzSqOwE8wqolPGD8+iRa7P8FkX
 KapGkg8K49H6tVcUq97gWsB348xuRCz4228uYCf3wPxzj7dP4bBzj+QDknR58mRIDnM054nVcrg
 tKu/jlUCVhSn7XpXizwNCEx1PF3c5AlBoZD7AhA0PvIajLImdk0YFAEvaWJZ7Lu0auxuREX5EVP
 Ts0XOA1mMW/wdNhhfK7IpMzqZIlzGwMQPT90Hv1XnZZaGsKQlZqpZhEpUtCJpYkcrfSdWkoUOgG
 edEDd+DnrLWutvMmpKQnpnO/tdc9LyYF7DLxgDD5tFMJl2c1nuB2aeLWc8adf23tTTJ3t0LC8Vd
 9rqYU4oAC0JqdgmQ/+EW0f1mSpLq9qH+1FKb024mVWfw==
X-Received: by 2002:a05:7300:ea83:b0:36a:37:1404 with SMTP id
 5a478bee46e88-36f78ea36dfmr4322860eec.13.1793988315978; 
 Fri, 06 Nov 2026 10:05:15 -0800 (PST)
X-Received: by 2002:a05:7300:ea83:b0:36a:37:1404 with SMTP id
 5a478bee46e88-36f78ea36dfmr4322791eec.13.1793988315252; 
 Fri, 06 Nov 2026 10:05:15 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa651e6b1sm18554425eec.3.2026.11.06.10.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 10:05:13 -0800 (PST)
Message-ID: <1825f706-5013-4f0f-bf2f-4dc2413bc3f9@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 10:05:10 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Register accel-$cpu_type for all targets
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20261106023936.772-1-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261106023936.772-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfX9A2LuiEqfU82
 m9nocew2OKyjPIY1f1GJAD0f9azReWC6rmsuQF0x4U4/QljNX6DvLO2f5ybI7Kt/wZJMzYelOFe
 xt+Zmo8v8el4auYgee8m6T2JS+mVXj8JSc4o5KQhhQtUpFzMza/V8RyudQPPufwUDBS9BMoTrf7
 9MiYI1OAM3jBN56gZvhHlVIhpNG0119D0uhVhS3H5FTWnblziW06aSoJJURiqStDhx3Cd/w7eze
 JrHkLzFL2eMBFoOABPUgRxjRkcJsGsAWRjg/Wu0DO25pqexaSdh6v1KvraCsewqmwJ1GpjDNbRl
 DuNaCsFsnz7awoJkWW7xujADwdsoAbLFvO6zMKD0XfScYo1MPHQsp6lJZxU+312k6wCdaKfDTx2
 iqfsM29WJPhNy43wzcpN+6g43oQgZkqLt7aJcaQESDtdHTazycxHOfSpC+4zVsE4cDyRlxz+Wb/
 L7X+4HWoh8gAupb64Ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfXxfFS1gyVZ8J4
 kMVg2pR+/o2thUnXPPqe21qssj84uG/HTBn0cke6Oyx04fmPkxTgsrNDIFhg7N78vKQrMAtN/Ok
 J4xX+9XC/XPKkK+E1Riclxohi8d7IlM=
X-Proofpoint-ORIG-GUID: sjxiV6Ymh4CxBkk2jf9Nz2Eq1xXOFEeh
X-Authority-Analysis: v=2.4 cv=GpzXaU1C c=1 sm=1 tr=0 ts=6aee16dd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=5vwi3AZKjZg2J1XA_hsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: sjxiV6Ymh4CxBkk2jf9Nz2Eq1xXOFEeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 6:39 PM, Yonggang Luo wrote:
> A multi-target system binary links more than one target.
> accel_cpu_register_type() creates the abstract parent accel-$cpu_type for each
> target that has an AccelCPU subclass. ARM, i386, RISC-V, and PowerPC call it.
> Other targets have no such subclass, and machine init skips a missing class.
> 
> test-multi-target already instantiates every QOM type, so this series adds no
> parent check.
> 
> This is an alternative to gating accelerator CPU types with is_available. The
> RISC-V TCG and KVM gates are reverted here as redundant.
> 
> v4: https://lore.kernel.org/qemu-devel/20261105183310.1614-1-luoyonggang@gmail.com/
> 
> Changes v4 -> v5:
> 
> - Drop test_accel_cpu_parent(). test_qom_types_are_unique() already instantiates
>   every QOM type
> 
> Yonggang Luo (3):
>   accel: register CPU parent only for AccelCPU subclasses
>   Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv
>     targets"
>   Revert "target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
>     targets"
> 
>  accel/accel-common.c       | 6 ++----
>  include/accel/accel-cpu.h  | 2 ++
>  target/arm/cpu.c           | 2 ++
>  target/i386/cpu.c          | 2 ++
>  target/ppc/cpu_init.c      | 2 ++
>  target/riscv/cpu.c         | 8 ++++++++
>  target/riscv/kvm/kvm-cpu.c | 2 --
>  target/riscv/tcg/tcg-cpu.c | 1 -
>  8 files changed, 18 insertions(+), 7 deletions(-)
> 

Thanks Yonggang, I'll pull this as part of multi-target once the trunk
reopens.

Regards,
Pierrick

