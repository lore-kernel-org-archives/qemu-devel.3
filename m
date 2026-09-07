Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CA2C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZBH-0004az-7i; Mon, 07 Sep 2026 09:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3ZBB-0004NA-W6
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3ZB9-0006VU-8p
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687An43j3181030
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 13:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RqixD4N0z/3b0DiXXrUuQajWU8nOL0jAJX2FEo7z3Y8=; b=oAv4N/tKdWwh1KBR
 PfoV5HKWQt3IPsoe5Pj5pTtF8uu2F3TNxQbJOGUu1f8gMjlFULTEwnhlMNUctAVY
 xuUdp1gfmaUdNO619HXLb19VmTTCm4pH7UWpgBkneV7+ovg9G7qajz1DcLK20uFQ
 WHDWuBNw2Fc9Ilg7p+LxIAFGPo0a7UPLiNP8QLL4dMW5pQhUzD2YPZ/VMVfFSXVO
 5uMwvKSKhIvRJpHX3NNeviieK4yhuPz0t2RgpgU94r9fPfRZoAWtl5B4WVOEatJ/
 KCJZcWTsb+rMkbTf0F5xSAwvgBerV/GANomSdx1VoDwOeHb+pK9jaVTDVLX6Ex2P
 qOMBDw==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsw213fc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 13:14:28 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66f7fdefb16so4616836d50.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786868; x=1789391668; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RqixD4N0z/3b0DiXXrUuQajWU8nOL0jAJX2FEo7z3Y8=;
 b=CGdja9NBqXgmxPsfJPr271JXVpJUgAYSx7PwzOC6EiAqssMDckmmUYz8G1xnD9YTUZ
 j8HCqG9CA4SpKSDNroXr8bJd+bctMfENVvGReXXJ3j1zf8xHD0QwNk5WHM93ldVRoWvt
 nvRl8xZ9U637KM37p38z4tKFsDZG/2bSzcYRiBfi0n1IiTq5vEjgsyRggXOgOvA2cnoE
 znog6Aqzb/I6Mj0eN2D8chTQGU6K7mVU8PKrFbYP8w6daK7fcfGO8an79nZKQ1OzXirY
 hxp6lnfrE7EcfFKngYCeHL64tyr09aL/PNP1BNwo6Bnzqo1oc7Lvc9HoK5mlnA3yg/cy
 Q2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786868; x=1789391668;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RqixD4N0z/3b0DiXXrUuQajWU8nOL0jAJX2FEo7z3Y8=;
 b=RbvgOTx6i0vdhnXNHXY6IiRBTJwXNX++sJnwK6EJcK/8kzhnMlmGwWh/Wd7CXdfobf
 d7/+xYP3fWggqCJireHLNKTcndD6LeYoWTJGubIgS3juNSgUpSAonAsZVvva2Hp8DmjL
 hBTkj9p6dBkCI09W22mXvGcspQ5ktiz1HpmyVKExCKYSa91zZ1ROyvxoyH59iLjPMjBk
 hz0uBvvofMjCBPImKJMPbTR3+hwQSDsNTDc0POolSk58uu0CGC89dFzSL8q6cIgo7xCI
 zsidHtLsqUTNcnK8GbNVUPOnlAycs0R/owHLMhvpWDJOt1m9a/NjawaDsd3D1fJeqOoJ
 Dwug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoYaY5YKv1jHbM04bFwSmje+9LZ9Cqi7XkfYvu0mpr8efdY/hO7pGX/ve+FVg3kS+2z1tLMV0FzOWx@nongnu.org
X-Gm-Message-State: AFuF++mr/ffcZ7ed96Lb1FCk70MtSM+WzQtoqypJMArH0LmTEQQZ6SYN
 i/F2ch4AL94JZg3R6ruLTO3BQ8y89WHiIOVz9RZryRMTjYxteSMEXwy7yFwk+ZfzUJtXui3Q0P+
 dEVWp5BLwmN4C9eKt9NrHtnmge8CpB1WQYZEJ8hw0cPIH9/dOJpilkGADtg==
X-Gm-Gg: AYBFou1i27TEcnnYynPIeeGUuSePVbTgZWwbUnoTQMkOzggYl04dauKCxsi+6EGJiHR
 7ET75skU2aTUXoq6pyMX4jzTigsqKccdkZ8TE5SVyuaJX3JP4S7b4h7BG7jc8nsIYz4RPCvm13O
 hy2Qoe0Cpz5NyRdfnlr/Nl2S96mBX1Fm4EefpZRo9xije3TfM416bcGpDEGO/T99X71G1ctKcIO
 /eWW0Dx6Hr7E0pjV7zN5zaG+bxpXJysy5IRCnElBHjXur9nBXiyr+GQEngu4Xvncaf882G7dzya
 EyeVE5C5T+JDQGhevVlRp6Sv+qmmqvCQ4wV8Fft4r4fHKXZuRGCLwnFkb+CNUsFQ9diTwZgUQCM
 LGT4RKR7phmB5d8mHSUWrI51yldxgPqdJVsk=
X-Received: by 2002:a05:690e:4142:b0:66d:1a61:5c6 with SMTP id
 956f58d0204a3-66fc1b959dfmr5477102d50.29.1788786867768; 
 Mon, 07 Sep 2026 06:14:27 -0700 (PDT)
X-Received: by 2002:a05:690e:4142:b0:66d:1a61:5c6 with SMTP id
 956f58d0204a3-66fc1b959dfmr5477074d50.29.1788786867028; 
 Mon, 07 Sep 2026 06:14:27 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-871439c54e4sm71639827b3.6.2026.09.07.06.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 06:14:26 -0700 (PDT)
Message-ID: <165fb72b-3cf2-4693-88e4-f9d36c5c498d@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 10:14:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target: riscv: support TLB page flush for
 sfence.vma
To: Trevor Gamblin <tgamblin@baylibre.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _hmKkzdvYm1CAA9Mk__3YcfwDz4WNutn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0NiBTYWx0ZWRfXy64L6JGV739I
 hfBE0mY0uz/NzefFW2Lw3NwaLqyBxaO8J35w+ZWUBB6jdqasNxGXvvZYU7tMurMM2HxS7aBoKl7
 vUdmxT5sZUH+Rmz50NXdWaot+swG3Yo=
X-Authority-Analysis: v=2.4 cv=eKwjSnp1 c=1 sm=1 tr=0 ts=6a9eb8b4 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=y3tPqhoVAAAA:8 a=iGHA9ds3AAAA:8 a=B6KMzFptAAAA:20 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=69wJf7TsAAAA:8 a=_O3DOGVWAAAA:8 a=JF9118EUAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8 a=FRSEYCzRAAAA:8
 a=SS0N6QsqKKa_8Qt3vWMA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
 a=xB3BzkE1M_ohbp1J8EAO:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=xVlTc564ipvMDusKsbsT:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0NiBTYWx0ZWRfX6EAhx9dswror
 6tyRYIBjHDQvm4iQp3CCEHkar24nRsoehpLax6+lNTJ6ioVvpSoxMyCKT0Px5hrKS1gjjKvEzQ+
 lysgCICfuYRvSNOWLvG4rFZzw8RUYhJNo6T1tyjqyjBeOv/XeJqzKsb3iIDFGJEUy0WZk3+rshV
 Thktc9nmiXRgdDJKrMWtAuz2NaM8lZxGoqXmXmAmW/pWcpdUQ1DJ/NsA6xVDJ0yXX6rnSyKJuP+
 REuYqcHIwm3zWIWge4IU6bqmEwud6OurE4MyHJEoGp9ZZ7ayJc/4xYBYcrAgG+ntFiPtRJgXPn5
 /vw0dmwiIP3OddRsRtLI1zoC7wYwZ5MFhjSqyFo/L5YR4r88ByzJHOWv7bR0ERYfq/A8S8TggtW
 ug07Wd01q0RiBVdEzeITQTnZtZrpd9GqDUVgs4N/uDZlPuY1A0R85J358/gAB+72mgwJwOuMRC3
 zu4JzbBkJ3oddGZImcQ==
X-Proofpoint-GUID: _hmKkzdvYm1CAA9Mk__3YcfwDz4WNutn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070146
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Richard,


This tlb_flush change is giving a +20% performance boost in riscv64-tuxrun.  From
this:

23/23 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64-tuxrun  OK   92.71s   4 subtests passed

To this:

23/23 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64-tuxrun  OK   73.45s   4 subtests passed

Other tests weren't that affected - I take it has to do with the amount of
sfence.vma being issued.  They look fine in my own testing with an emulated
Ubuntu host as well.

This is all fantastic but I wonder if we're missing something.  If you could
please take a look at these 2 patches and see if we're handling the tlb flushes
according that would be terrific.


Thanks,
Daniel







On 9/4/2026 3:43 PM, Trevor Gamblin wrote:
> Introduce a new function, check_sfence_vma(), to handle
> privilege/hypervisor checks currently performed in helper_tlb_flush(),
> and make use of it in that function. Then, add helper_tlb_flush_page()
> for flushing only a single TLB page, using check_sfence_vma() inside it
> similarly to helper_tlb_flush(). Finally, rework the trans_sfence_vma()
> function to use helper_tlb_flush_page() when rs1 != 0.
> 
> The second patch also includes the fix for a regression in the
> 'test_tuxrun.TuxRunRiscV64Test.test_riscv64_maxcpu' test encountered
> with the draft version of this series, which hanged indefinitely until
> killed when the patches were applied. This was fixed by making sure to
> use get_address() to canonicalize the address being passed to
> helper_tlb_flush_page().
> 
> make-check and make-functional were both run with the patches applied on
> master, and no regressions for riscv64 were observed (beyond the one
> mentioned as fixed above).
> 
> Daniel Barboza helped me with initial triage, direction, and cleaning up
> this series for submission - thanks again!
> 
> Some background context: as part of the RISE Project[1] mission to
> improve the RISC-V software ecosystem, the Yocto Project[2] is receiving
> assistance with triaging bugs and enhancing RISC-V support in the core
> layer. The 'qemuriscv32' and 'qemuriscv64' targets were enabled as part
> of the Yocto's CI system, known as the Autobuilder[3] in 2025, and since
> that time various intermittent failures have been observed on the
> 'ptest' ('package test', where a package's test suites are bundled into
> an image and then booted to do basic runtime compatibility testing)
> case, 'qemuriscv64-ptest'. These almost always manifest as timeouts in
> the guest, usually around heavier and/or more complex test cases, and
> they additionally seem to occur only under heavy host system (x86_64)
> load.
> 
> Comparing to other major architectures like x86_64 and arm64, the
> riscv64 guests are always emulated in TCG mode, since the Yocto
> Autobuilder cluster does not (yet) have native riscv64 hosts to dedicate
> for runtime testing with kvm support. While this is likely a major
> factor in why qemuriscv64 runs fail at higher rates than other
> architectures, it was noted after compiling the triage data[4] that
> local comparisons of the same ptest images running on TCG-mode qemuarm64
> and qemuriscv64 showed the latter taking significantly longer to
> complete (using some of the test suites which have been observed failing
> as examples), even with no other meaningful system load on the host. In
> particular, the coreutils case showed over 70% longer runtime for
> qemuriscv64 compared to qemuarm64 (~1000s vs ~580s).
> 
> Fully investigating the source of this discrepancy was a long process.
> For Yocto builds, native QEMU binaries are built from source as part of
> the overall image build, so the first place to look was in QEMU's
> configuration and boot options. Other suggestions included trying to
> disable TCG plugins or alter the QEMU and guest package configs (Yocto's
> QEMU is RVA23S64 profile by default, while the runtime packages are
> built for riscv64gc). However, these changes either produced no
> meaningful effect or actually increased runtime. The next step was to
> investigate the QEMU source, which is what ultimately led to this patch
> series. It turns out that these changes significantly improve the
> reference runtime test case for coreutils in Yocto, although it is still
> somewhat slower than in qemuarm64. It remains to be seen whether these
> changes to the QEMU source eliminate the intermittent issues in Yocto's
> testing, but it is a meaningful improvement which opens the door to
> further optimizations for RISC-V.
> 
> As an example, compare the before and after results on a local run of
> core-image-ptest-coreutils for qemuriscv64:
> 
> |============================================================================
> |Testsuite summary for GNU coreutils 9.11
> |============================================================================
> |# TOTAL: 733
> |# PASS:  561
> |# SKIP:  172
> |# XFAIL: 0
> |# FAIL:  0
> |# XPASS: 0
> |# ERROR: 0
> |============================================================================
> |make[1]: Leaving directory '/usr/lib/coreutils/ptest'
> |DURATION: 1049
> |END: /usr/lib/coreutils/ptest
> |2026-08-31T17:23
> |STOP: ptest-runner
> |TOTAL: 1 FAIL: 0
> 
> versus:
> 
> |============================================================================
> |Testsuite summary for GNU coreutils 9.11
> |============================================================================
> |# TOTAL: 733
> |# PASS:  561
> |# SKIP:  172
> |# XFAIL: 0
> |# FAIL:  0
> |# XPASS: 0
> |# ERROR: 0
> |============================================================================
> |make[1]: Leaving directory '/usr/lib/coreutils/ptest'
> |DURATION: 646
> |END: /usr/lib/coreutils/ptest
> |2026-08-31T16:10
> |STOP: ptest-runner
> |TOTAL: 1 FAIL: 0
> |root@qemuriscv64:~#
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> 
> [1]: https://riseproject.dev/
> [2]: https://www.yoctoproject.org/
> [3]: https://autobuilder.yoctoproject.org/valkyrie/
> [4]: https://docs.google.com/document/d/1HUk-RvMDdW2EKV-qE1VNfZBycPscQUsayEZ5AgJ85C8
> 
> ---
> Changes in v2:
> - Renamed sfence_vma_allowed() to check_sfence_vma()
> - Squashed patches 2 and 3 together
> - Reworked check_sfence_vma() and helpers using it to be consistent with
>    rest of codebase (e.g. no unnecessary returns)
> - Adjusted cover letter to match check_sfence_vma() naming
> - Link to v1: https://lore.kernel.org/qemu-devel/20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com
> 
> To: qemu-devel@nongnu.org
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Chao Liu <chao.liu@processmission.com>
> Cc: qemu-riscv@nongnu.org
> 
> ---
> Trevor Gamblin (2):
>        target/riscv: extract check_sfence_vma() from helper_tlb_flush()
>        target/riscv: add helper_tlb_flush_page(), use for sfence.vma with vaddr operand
> 
>   target/riscv/helper.h                              |  1 +
>   target/riscv/tcg/insn_trans/trans_privileged.c.inc |  6 +++++-
>   target/riscv/tcg/op_helper.c                       | 22 ++++++++++++++++------
>   3 files changed, 22 insertions(+), 7 deletions(-)
> ---
> base-commit: c513597761d6fc06690b5b7cf10dfb7ab05815d0
> change-id: 20260831-riscv_tlb_page_flush-11a83fe9e7b1
> 
> Best regards,
> --
> Trevor Gamblin <tgamblin@baylibre.com>
> 


