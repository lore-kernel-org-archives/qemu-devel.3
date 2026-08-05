Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9991C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrgTy-0003Uo-Q7; Wed, 05 Aug 2026 14:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgTr-0003SF-Jr
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:36:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgTp-0000tR-9E
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:36:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HS6Lk3888539
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 18:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5E6SEJqat8P5HlEeauanx/rR2wYOwxNp1YTFE4Deahk=; b=Vtd5VuJzThB3bJVA
 Gb4NAETwhI1m8JqS+WK0x2svgardMi8Clph27/2RqiX2VrbNqtChG83SF7gzSPVj
 wdrsa4OOs8F7VGU1VI9ji+SfHOjKsN96paJPul3Yi4QNDrIC4aoY90bfpPW+ZMj5
 eD4i/vWLJMXN06kfhaiUnRs3PWm8VDj+v0FEhFKqjDR3A0DarkPrboUTz23vxHhj
 4Y/zMESToNiDKlc1DH9IMS5PLJESHsIzgkD6eliSSNwozB90/O0HPzioO6ntZJUi
 vq4l4/sbkOfaj8F2vKbIQ0DyTWFWlQLbuipm1xuBgwxe6xcnhIeWSBNVXQKFDX/3
 jT+05g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5sjdp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 18:36:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930a098ea19so137957385a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785954998; x=1786559798; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5E6SEJqat8P5HlEeauanx/rR2wYOwxNp1YTFE4Deahk=;
 b=Mm0wGwEwChqN0+DccAsX36dZL31wqGk0Q0V39ahvuKZIhkQea5WM0I0hwj2q2yp+2k
 qX6MQOkzB5fr6l64oIMs3x+p2BQN1rZAUdw/zuBUy63D7o3+2noBL4E2lPx4/FS5NNZd
 B6UFpsQuow9XBcceFnhVtUQ42mNehVqi/z+ra7R83ZFnqXMvgDRchbKMYFy5b2f/vQym
 ASx+3jV+I/j4+ecf0KxcO0tICPmuNP9qL3qhe8QY/1Vf61K+5nH4ha94rm1WfPh1vWGu
 XbtU5Xo7UyXOXIbzphixXbs0IHev+gVMT34xut9fCKvj8h03aujd46v0GsyMoFDWP8se
 /b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785954998; x=1786559798;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5E6SEJqat8P5HlEeauanx/rR2wYOwxNp1YTFE4Deahk=;
 b=GRyR8OuA111w8rp3NzD+lscPiUeNORg+EwqOj8kGqYZZj5hj6FLoj9ZDHe+eWvosb/
 3NhGffOv469wCCftrLDN1IbKZeNamqnMFDOHfSJDNvHZ5ujsrsIJbtoCxhLQVjt5NM4V
 zDkNbulIErz8Ki8ny/3viL0OzE1lZ+j8ZXG3KRE+hWTe/IQr24sgFc7l2pM25mx1WFMk
 OAmeHFspGcMFrkAL+jntUk6rj2QrvsxL+Vgi7EKxFPRhZTB5kM0mfMbA/1biGbhKbtNd
 AAGXQjoFKykNbYViZogX1cdzyvyJnNxCsWk0I53vjfDcI2Q2GSU8vT+Ib39SRN+s0muD
 5YcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqG6NY2ZRX7G98vAPNDspbexDk4D2Fxwi/Atha1ry4mw6CtQUsCH848jW6wn6DVK2Nv+a/xvaqubgLv@nongnu.org
X-Gm-Message-State: AOJu0Yx6YJP2IFkf9QnR5oYicG7lOieAZu5NikEkc8GWOnHrjADdoH1D
 i6RD13KyRz0vcnZLfHbBZvYMggmYzTQF1Bx+bgJzK2Loj60dEZ5WBZ9G32uROEjFpyyMqVnaL7c
 XbJvy4iwDgtuZl/NELNniToldqn4ScrHPgVIQ1kHpoCmvm2mR6W9rLRNK4A==
X-Gm-Gg: AR+sD13S8ODRhIed7vExUla+ZQUh+FNCd+/xOeRSW9JO8W7jsZvE7We4vNUpAoFiXsV
 jVlgHb46569y48phHcDIYaHoIl8zZy9u5mhMYQR+3+/jXQXagwLZXybyZBicLfX7GTBLxwvuG2J
 hosSkuK3yeN1mRKysRLN1lPtEgJsohwAnCXDxHTHrCZskwodsNCupcYPrZ0Qp5BTDR11R5chiEe
 uebT6AjcGvUmMKmCxQ6CzEzNOlm0Bq2mkFxdhoGfBTlqLF+0qUhi0YViprMgvuffjcJPbIA0dDz
 s3Hr7TAw8yIfE0KHm80+XC9A7MDkMNmMdTibh3eL5thia1fztwbZTh0mbP5TpKPZDIJrx3uMtgm
 YKRSxyA8fHm+jQhglUrUUJaa9sVLijRDC1Wrq
X-Received: by 2002:a05:620a:148f:b0:932:dd83:c54 with SMTP id
 af79cd13be357-936492d8bafmr718174685a.42.1785954997850; 
 Wed, 05 Aug 2026 11:36:37 -0700 (PDT)
X-Received: by 2002:a05:620a:148f:b0:932:dd83:c54 with SMTP id
 af79cd13be357-936492d8bafmr718167985a.42.1785954997142; 
 Wed, 05 Aug 2026 11:36:37 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a58d356sm210879385a.41.2026.08.05.11.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 11:36:36 -0700 (PDT)
Message-ID: <946b40dd-a2b9-4d10-97f0-8dad261e0570@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 15:36:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] target/riscv: Add support for RISC-V P
To: Chao Liu <chao.liu.zevorn@gmail.com>, Molly Chen <xiaoou@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <amnHq8A14gOpHcg0@ChaodeMacBook-Pro.local>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <amnHq8A14gOpHcg0@ChaodeMacBook-Pro.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Xea5Co55 c=1 sm=1 tr=0 ts=6a7382b6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=HIoIN3QyAAAA:8 a=69wJf7TsAAAA:8 a=zl2dgruvT0JfJdoN-sEA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=MbFZXBXkOCLWhBDvYpC8:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: DkoVZ4Mh5q1jzE5hSlzO_RIuI23MPCfZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1MyBTYWx0ZWRfX8HL33jQLHbPe
 Mub+k7fI5zo3ueaOhR4uNtMRQGXW9KHeCaNZ6HPY7NbA0D7Ui3Bdvb0mZNvw9IdgXRnJfVbmL+C
 4Yse5Djg2Urj7EeLhLsv06z1Ti0yNKikRhiYH1JyloPNjvzaEMqzZho/MPc2Ql3xVwPPbeJ6M38
 GHQUc8K/3vXaUJEKYMZZ4mpysJDzYrc7kA8/tDUOhLlpxpx5A2F/z5FhtQvOyvOI+Eu8CjdAsQL
 dKvVRCuKXE6GBKmp6LyPGbZ4y8xdRccZRoSUbcHCpyVAEbHiODYIlcRf0eVrKWqXWJ9z1BshYpv
 dvSo6bxXx+wsHo0e4xrzFu6qJ0SFil2lLZUPadrbS4ssH0oLvuNlmu6MIre0IoQuWLYZkvz2tTB
 7Rxm/G/CXM/WKygERXVPF7k8T2W/uUFh6UIxbVtYn5Z1DRyBcSx0QTTa4ZdZjfiDyhSjk5BR3Va
 33ut7EdHTNaB3DIWngA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1MyBTYWx0ZWRfX3MZ/vQ1uOo7s
 /BxRsSWNt6yY+Bnd2eNylPBHpbZgTSSz3t3HQPlJMEbNxkunVUVmhadVHy4e7Olu/rdekmdB9Lv
 C+/wSVyKMRG9NVd0TEGUTw1Bs/L5PWQ=
X-Proofpoint-ORIG-GUID: DkoVZ4Mh5q1jzE5hSlzO_RIuI23MPCfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050153
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



On 7/29/2026 6:32 AM, Chao Liu wrote:
> On Fri, Jul 17, 2026 at 10:06:53AM +0800, Molly Chen wrote:
>> This series adds support for the RISC-V Packed SIMD (P) extension.
>>
>> The P extension defines packed-SIMD fixed-point operations intended
>> for DSP-style workloads such as multimedia and signal processing.
>> These instructions operate on packed subword elements within
>> general-purpose registers (GPRs).
>>
>> The implementation follows the current development draft of the
>> specification (v0.20):
>>
>>    https://github.com/riscv/riscv-p-spec/
>>    or
>>    https://www.jhauser.us/RISCV/ext-P/
>>
>> Compared with v1, this version reduces implementation boilerplate by
>> defining and reusing helper macros for common patterns in
>> trans_rvp.c.inc and psimd_helper.c. It also consolidates the P
>> extension prerequisite validation in riscv_cpu_validate_p().
>>
>> The Zbkb dependency has been removed to align the implementation with
>> the current specification. This version also implements the
>> specification-defined control of vxsat, which was missing from v1.
>>
>> All instructions have been functionally tested using the following
>> test suite:
>>
>>    https://github.com/mollybuild/qemu-riscv-test-uart
>>
>> The implementation focuses on functional correctness and ISA
>> coverage. Performance optimizations were not considered at this
>> stage.
>>
>> Feedback on the implementation details would be highly appreciated.
>>
>> Tested with:
>>
>>    - ninja -C build test
>>    - make -C build check-qtest-riscv32
>>    - make -C build check-qtest-riscv64
>>    - Functional tests for all P extension instructions using
>>      qemu-riscv-test-uart
>>
>> No regressions or test failures were observed.
>>
>> ---
>> Changes in v2:
>>
>>    - Refactored trans_rvp.c.inc and psimd_helper.c by defining and
>>      reusing helper macros for common implementation patterns, reducing
>>      boilerplate and overall code size.
>>    - Moved the P extension prerequisite checks into
>>      riscv_cpu_validate_p().
>>    - Removed the Zbkb dependency to align with the current
>>      specification.
>>    - Added the specification-defined vxsat control mechanism, which was
>>      missing from v1.
>>
> This patch set is a significant improvement over v1. I think there are still
> a few common issues we can address together:

v2 is a huge improvement indeed.  v1 had 11k lines, v2 cut those by half due to
the smart use of helpers.

> 
> 1. The line break characters '\' in the helper macros we defined need to be space-aligned.
> 2. Every patch is currently missing a commit body.
> 
> I think these changes are quite necessary.

Yeah, having a commit message allows us to make fewer guesses when reviewing code.
E.g. the usage of __int128t__ macros and the choice of some rounding formulas.  We
can make review  assumptions and hope all is fine, but it's not ideal.

And, as Chao mentioned in his other reply, having test cases will be helpful to
assert that everything being added here is sane.  In particular with the amount
of lines we're adding here.


Cheers,
Daniel

> 
> Thanks,
> Chao
>> v1:
>>    https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html
>>
>> Molly Chen (18):
>>    target/riscv: Add packed SIMD extension state
>>    target/riscv: Add packed SIMD helper framework
>>    target/riscv: Add packed SIMD arithmetic instructions
>>    target/riscv: Add packed SIMD averaging and rounding instructions
>>    target/riscv: Add packed SIMD absolute, difference, compare and mask
>>      instructions
>>    target/riscv: Add packed SIMD shift instructions
>>    target/riscv: Add packed SIMD exchange instructions
>>    target/riscv: Add packed SIMD horizontal reduction instructions
>>    target/riscv: Add packed SIMD pack, merge and count-leading
>>      instructions
>>    target/riscv: Add packed SIMD multiplication instructions
>>    target/riscv: Add packed SIMD multiply-accumulate instructions
>>    target/riscv: Add packed SIMD Q-format multiplication instructions
>>    target/riscv: Add packed SIMD Q-format MAC instructions
>>    target/riscv: Add packed SIMD two-way MAC instructions
>>    target/riscv: Add packed SIMD four-way MAC instructions
>>    target/riscv: Add packed SIMD load-replicate instructions
>>    target/riscv: Add packed SIMD RV32 only instructions
>>    target/riscv: Remove Zbkb dependency from P extension to align with
>>      the spec
>>
>>   target/riscv/cpu.c                          |    5 +-
>>   target/riscv/cpu.h                          |    8 +
>>   target/riscv/cpu_bits.h                     |    2 +
>>   target/riscv/helper.h                       |  529 ++++
>>   target/riscv/insn32.decode                  |  829 +++++
>>   target/riscv/machine.c                      |   19 +
>>   target/riscv/tcg/csr.c                      |   39 +-
>>   target/riscv/tcg/insn_trans/trans_rvb.c.inc |    4 +-
>>   target/riscv/tcg/insn_trans/trans_rvp.c.inc | 1389 ++++++++
>>   target/riscv/tcg/meson.build                |    3 +-
>>   target/riscv/tcg/psimd_helper.c             | 3165 +++++++++++++++++++
>>   target/riscv/tcg/tcg-cpu.c                  |   46 +
>>   target/riscv/tcg/translate.c                |    6 +
>>   13 files changed, 6038 insertions(+), 6 deletions(-)
>>   create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
>>   create mode 100644 target/riscv/tcg/psimd_helper.c
>>
>>
>> base-commit: 8fb307591625731060d399aca42373c02c7cb040
>> -- 
>> 2.34.1
>>


