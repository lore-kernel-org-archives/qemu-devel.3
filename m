Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37730C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 16:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xArOT-00038m-0B; Sun, 27 Sep 2026 12:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xArOM-000389-KA
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 12:06:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xArOJ-00050b-Qw
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 12:06:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R5XpgS1979297
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 16:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 STka7TvZ3SFCtm1cvQf3w/kR1WUAaBnj0hlnNXXJZkU=; b=jOsxDaayTKMoQsxY
 44JWugiDE6hd1LgQ8iw9EoV/ylXtWYHVM8qWn1bEQeN4pEuhMuQ6IH1Ag9HGGpFI
 ejPkh96SNi1lUzEumi3X+WU6klXbG9IuFzFhsQlVbLYv0otzxfAsIdeYatAyZn2R
 q+N1uL5ZMutzwmxcAOr1szUPMXT1ZxaEhmyRmOKuxMl/L2wlLFqAKF9WoNz4RPK1
 Ghso22pXJtFwQaoq/ABYlF0Yb29e4vDXR70EsLrk8pfU7cvlDh6uHrJ1ui7TG4VZ
 +l0HPcQDXnD/JLnk28CaBTcfdDhIjanA45FtP24psTn6QI32GL7hq6V4XBt1rMFZ
 bBigzQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx693bas6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 16:06:13 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7b731e00834so190101137.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790525172; x=1791129972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=STka7TvZ3SFCtm1cvQf3w/kR1WUAaBnj0hlnNXXJZkU=;
 b=MiGSg9z13jDi0Z1kLrmukDDFJxfcOgJa9zB+8h222RQbHq7HJASi+X8uGwDB6E9xSM
 mCOR5M02EzYVGS+4PaJ+qrUYApQtG5uXzkr0gl2H1Ox58Qwki2aCP9aGWP1sw7ev2ypE
 kKXTVUyJIxXL5bG4IBdJOpu+P+8szq+hg8QDmgLxnHnHz6BRvOn8a8M2PWR7fnm1g+Z1
 gmGSHg3ghELIEUScMK6MHzS5l+Fzqvbpdt5LyClI0+90Uj/zAtTSVuHAjZdAEKoZFIHM
 iBB6LXxfRYA2XgVQS4+1FBBvKKFKDiIEfuIQcLpEDmJaCApqgUVcx8wmhTi+T12fgMrV
 9etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790525172; x=1791129972;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=STka7TvZ3SFCtm1cvQf3w/kR1WUAaBnj0hlnNXXJZkU=;
 b=QHQ3LuEl5g1SbEOYI/vtGOqxkDSY8Yb0lsCPEojVZqfdMMVDTg18xP5dvfssdH+ofn
 5LkpqyUC0VOTcaLhtQvN6EhCPvjzaRUr52OBlDhXNt4UqHsnk+E9+DjvnVDC3kxNvXJB
 j7MrK1VpIGHsbuf7aoQPB7uv5USn5HpqA8CE1eYlYoIVZS+QPlNvycw7FZEnBBbkFJX0
 TZ5HWHi/SrhjYlp5+SpcBwn2dfUWcdPkBQkNIObWGLWXCLPoobEkmJwVpfHEU2jFib0N
 rU13OFkin9Z3PD2LQsnqnPXvcdXg5yZOt0m4G/rUGJp3GQx/q4sXbwBMuK/GcERg6d8F
 o/SA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzATH2gTkZvBfVPcjKzlNQDKVr8spQWBLSGWIcEPN9Ir37HWN+1C+puN58D8p7yQqFxiBJzcvDHPvz5@nongnu.org
X-Gm-Message-State: AFq9FYLNDBEmstLbLUWkXB3b8I/3/l3smo99dninzqprtBwpjANut9Te
 ZidIpjiQw5JObUkShxrLOCUyIQUtGjPf6mGflqpKTvUylcM0XdKuWQIHqrEM/74ZK07iv5QOQMO
 XUA7Yv+xPaorEYc6pY7qHNZ+JfOKXZ7W3Gc/YbOmyGb8sS8TMmzw7pO+0KQ==
X-Gm-Gg: AYBFou0XrzWzwUNenQAx9wSs09T0NlCSHiCbaeenzrIhTKwaQmXd+p7nY8eL7MpLiFB
 x7mCDcjTe5jZTTXtWFiRZyGm666wwPsl99nNSrYmiwR564bdnp2viT4C9oI7ivkPGVVr0TK+r10
 W7aFJUlvA8CxeSxNvzZDooy7NsBdAsDmSAikZaI1Ah/sckFqdo8fQrOEpGWqs7PmLCW9gmyrGzL
 okpatBwZaJa5OoWawVi+rk/4F4hPLfS/OcfDsTe/9ovgwsdUurVAMJE5f1/T8rfMz0Ly8CknbXW
 o0t0DA5/RLLHxlR/um0bj/oX5CNDIFP/QMWUbOsslO4dVEfY7HQV+npW9oO5nbnquN5c4dwPZRU
 iYUZNFQOfSySu2zur8Dk60LeMiV4PAxzQMA==
X-Received: by 2002:a05:6102:148f:b0:7b5:b51:63ca with SMTP id
 ada2fe7eead31-7b50b516fe7mr457645137.32.1790525172095; 
 Sun, 27 Sep 2026 09:06:12 -0700 (PDT)
X-Received: by 2002:a05:6102:148f:b0:7b5:b51:63ca with SMTP id
 ada2fe7eead31-7b50b516fe7mr457641137.32.1790525171635; 
 Sun, 27 Sep 2026 09:06:11 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a744fb5sm19415139f8f.33.2026.09.27.09.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 09:06:10 -0700 (PDT)
Message-ID: <816d8db4-ef58-4eab-be12-6d239300ffe4@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 18:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] treewide: uniquify colliding helper symbols
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <17746591750@163.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260926110818.1912-1-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260926110818.1912-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2NCBTYWx0ZWRfXyKghuygx4MVI
 NV5jaBJCwlJnyC1J/oMJ5XWc/mDaIXgvUuydB5tbnQJsnrBHYmJaApaxNM93r8nGS75w4/qL75m
 lWBVi2BmckXH39u02GSMDC7TaQVWuvs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2NCBTYWx0ZWRfX8BkxufKhyXLB
 doPEiFni/p8IReskr+HB5B9C0pvL8yDoOpxnQcpMMl/vhbqZjbYAyH8GNfM5XHEBhQH72Ff38AL
 IKROsVDqQYELKO7+IG/6e6lx7ifemJ5tLQGkq2XFM0tv/3qdwJ1RoX69NvVRLpYauvMjdCWJnaX
 nlvgr/YXv3TO/gaPWpcKtSnw26p4oJS8nfrmjLh7GAFNNr5btBLYTpkHLPkQ2w725i3KsFB+9x6
 o+kkyf0lg9WjmERVPG7hnE+p2aXEpcDUJ3xeTvh1F058ppCfnQiaPLJ8LDFOXpaeXJdjlSRUIbh
 a1ywCqBSkp2XTEZ3JLkf2Wa3VmR9DGvMQx9tlmYsmyHdEpRdQzi8q+xdAwGWkfYOanwYyFtDF9T
 6M3tpM42Go/9gF7vHgqo+zm0GFshChrdYnG0X+fbsNPNQZcSCBdVe5RJl9KM9aQiJFrNBI+4yuY
 RH2lMH91aCJEBvqZAAQ==
X-Proofpoint-GUID: a5L3Vn5dKnafUVveTgpFrJTC26KpW3It
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6ab93ef5 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=JQRrnVlyEpPTD-euPisA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: a5L3Vn5dKnafUVveTgpFrJTC26KpW3It
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270064
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

Hi Yonggang,

On 26/9/26 13:08, Yonggang Luo wrote:
> A combined qemu-system binary cannot export the same C symbol from two targets.
> This series prefixes TCG helpers and virt ACPI setup functions that still use a
> short name another target already exports.
> 
> - Prefix leftover i386 TCG raise_exception to i386_raise_exception. Rename the C
>    raise_exception family globals to i386_raise_exception*, and keep the short
>    names as static inline wrappers in helper-tcg.h. Wrappers still call
>    raise_interrupt2.
> - Prefix helper_wait on RX, Hexagon, and MIPS. Hexagon also takes the resume PC
>    as vaddr.
> - Prefix ARM raise_exception to arm_raise_exception and keep the short name as a
>    static inline wrapper.
> - Prefix virt_acpi_setup and virt_is_acpi_enabled on ARM, RISC-V, and LoongArch
>    virt. Leave the ARM trace event virt_acpi_setup unchanged. Leave RISC-V
>    file-local virt_acpi_build* names unchanged.
> - Rename RISC-V TCG crc32, crc32c, and wfi to riscv_crc32, riscv_crc32c, and
>    riscv_wfi. ARM already exports helper_crc32, helper_crc32c, and helper_wfi.

This was our first quick-and-dirty approach to link a proof-of-concept
binary, but doesn't scale.

Our idea is to modify the macro expanded by the various DEF_HELPER_x()
(helper-gen.h.inc, helper-info.c.inc and helper-proto.h.inc in
include/exec/) to prepend the target name to the function name with
the glue() macro. Core TCG helpers (i.e. when TARGET_NAME is not
defined) would use "core" or "common" prefix.

Since you are motivated and keen in getting that binary linked, are
you interested to look at this?

Regards,

Phil.

