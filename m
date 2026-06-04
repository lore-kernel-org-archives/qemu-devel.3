Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303DBCD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7sw-0002vU-Fq; Thu, 04 Jun 2026 09:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV7sX-0002sR-2E
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:13:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV7sT-0002q9-Gc
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:12:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654BJrDO944517
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 13:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ClrfzG18tjGX9BTTsCbz7rr9UqFvHZgD1hiTNHzaeR8=; b=OBPe71mNrP2MAhne
 DkSwUta6qtHN9CkJ/z7wbIUu7djen3C5dPdpeH4kNXl57nifwn6erumZdqvOVj2x
 +AT5nmVNje9I+lTcXsYmG+s//3mjrROJwMXcFwIThQniTCBv9b9JVME7AJwEtCl9
 ifOtqW8sfNnMkqZVaXTJaI7/Xqg68iPBI760d0XwshMpR/kw+CilHe5bfN3+6j+B
 3DH89k+LUphzQf4cIkUbmYoeOK3I7BeX1Sm5I2deyI6zOb8/SXecajLfHQL39t3S
 gdzKnvMRLTK2MkNBdRwGU5yuXGus7KzCQKKREO7DFP7yq7LB1gnYG30bpIzbIlfF
 teUGVQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek8d50ex2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 13:12:50 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-59ec77e0184so546792e0c.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780578769; x=1781183569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ClrfzG18tjGX9BTTsCbz7rr9UqFvHZgD1hiTNHzaeR8=;
 b=EcIDEUfSpEhCzFDNV1gSg19UYKTpp79ztXK+QiiSKm9dKiudVbprsV2Ni+jGcxNyVI
 9QhMMhoIfVJyjT5h2B6E1EMfuPnArY5u3cBpd70V31hh78+sRYXsHAeAQeAPcT40MgoX
 tbCTfnyyMKk8gjBXQwohVS3v3AJR2WnDChsRefJoSwNEFovNnf5jCI4rxl++HdUYT6OV
 pz0EGGjkZV1t7qPY29tAD93jUEJVphfmubrBUSw3/b7dBwzb4/D/tc7wQy0XHRYQ1Yia
 iH4N2M7B53QYW1plkwoQb+bUro0BwdBp9JNoR5gosv8KXMrqHfqJa9mss51i9vkkEhW6
 T5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780578769; x=1781183569;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ClrfzG18tjGX9BTTsCbz7rr9UqFvHZgD1hiTNHzaeR8=;
 b=QlPWATi78EVRCZfTEjtbl0eT3P9Pc4dmiKMgTSRMHw5htE76tknpk9TIn0QncUIIKE
 wwtDM5epiT4SRvHFmaaYej3FZdT0MCOrsefdohwSZUFXGxd+rKJkuoDi12fENYRXAbos
 ZlXgoGM4H5rqQnC6jO6dhAbAh68a0rFBGCvmpS/r/v5pqRMhXqoX5zFxamr5AaamtM1I
 CSNYiR7FJJAYVIRndJmOPZWT8zDYI6SOiAWzqn9EUSWhjwtHs8nP8HE9cfbI/gTJS2hl
 ANQadKxAZZPoA+OWqpRPISeBHWSsrxkrHBNDT+85WMBayXR+bEQEDDE5aM81Qogt1j9H
 EioQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QWHenU9+PzBFVith7GA2nBXjpDISDy6Xf9sQdNzCyzPQYSYccRKRozbkQNhZ4phkImoe5+yRpc1D0@nongnu.org
X-Gm-Message-State: AOJu0Yx1Y5q1fMSbTeak89TmeUeQEjV75uGoMFdESO923+BHMYctuDHu
 i7VbBcEf3tDmErfCnnauJxTu/CaQjO6KxnnTowrhAALWaGYiDhzivypmii3t+SvSyeEqj+CxpNd
 wr3ZKChzQEIkj5rOhThoqGhyxVdq5+dUIwxw1WUDevYzsIzAxdro1/o50UQ==
X-Gm-Gg: Acq92OFmlicJnXztF8AF7maJCtAXQ2zGE9S1PRb/kTta6k4lb1v5WCO99k/XGEuuK2G
 dPIAkNA243WoABXDlaIFwmVV0nqCLwNkG6iMC1w+3O519i1rqj9H7H6H2MMrIliNgORoylYYw/8
 Z3wuIMCp+2n0KgbYb8ckfRUhEt81g4NxLFYzk/yv4hHVG2NK21LGbBvt/yPsm/Bz8y0ute7lWqj
 omX882iZ3G2a/1dKwzn4LFvpO1ot/U/cppSnbISmQFUJKl0nwn8Qtp8mvfute3M+RsR3D5B7x8r
 XiqllyPXXA3gZK2q/NM1xkvSEwoZsUm9wECi7qWoWg09YHs2X2cFxiU9a64Mh2ZSOoU4CoN9R+F
 +KuN+luNLxY07eYiei6ARh/tNuCfImDkR5gcmfnMD47VNqaclf1cPayyZlCwc7vYgmRUn
X-Received: by 2002:a05:6122:d84:b0:56e:f071:d4ef with SMTP id
 71dfb90a1353d-5a6e62bf36emr3821733e0c.8.1780578769476; 
 Thu, 04 Jun 2026 06:12:49 -0700 (PDT)
X-Received: by 2002:a05:6122:d84:b0:56e:f071:d4ef with SMTP id
 71dfb90a1353d-5a6e62bf36emr3821671e0c.8.1780578768816; 
 Thu, 04 Jun 2026 06:12:48 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d65080a2sm4925711e0c.2.2026.06.04.06.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 06:12:48 -0700 (PDT)
Message-ID: <f1bae642-ae45-431b-8859-d0e2cf626689@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 10:12:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/25] target/riscv/debug: Sdtrig fixes and TT Ascalon
 support
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5XaoCpUczJmRdHvs3iSw8vfD3pOJnwdT
X-Authority-Analysis: v=2.4 cv=IZG3n2qa c=1 sm=1 tr=0 ts=6a2179d2 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aYNg_NpMI4ci0G1CuhMA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyOSBTYWx0ZWRfX78BjciIQF00K
 sYrma3VdcQ/15+DkLbGD22fbs787/vaCa1GRfXqSKot/z3VFUqii6hw+KA9LJkW1H/pkmT9xMJV
 nNzjAP8lFcbdmWQN1QYqLnz8/ciSHs/dHSeQyfde43nVb7bM15O9BQz+thLT4L03b35Llaer41A
 d/EXZHeHcftgUrVzNsOFEg6UgoN4mO6anOuigunjODPiYZjPxancRoEXlOZFNfQ5OzSTEkXi1DT
 GtW524CyTu+tCFE/IOMDna+hQ0efJz5ey6lhsqmpdn9EuPelHvd0zolC7/64gUx333JRI6P0MQL
 k2TdKTR/bATXMxqEh92aFwCDYa1Rzei0tUBiVvBOSQ+05Dr7x2a0u8v6S7ZOCJnLEAA0K389Th8
 t2oSsOGxKc5FIX9D85YyBBPJs2OCt6leeKogquwsm67Ny8AEU3gngu5bUC1MT+PgGX7x+r8musl
 +ZvoGY/ZFRRlkybWknw==
X-Proofpoint-GUID: 5XaoCpUczJmRdHvs3iSw8vfD3pOJnwdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Salutations,


Sorry for the late review.  Just got informed in another thread that this
was sent back in January and I missed it.

I believe patches 1-18 and 25 can be sent in a separated "debug related fixes"
series.  They seem nice to have regardless of the other patches.

Patches 19-24 start to touch into a more sensible area that we're discussing in
other threads, most notably this one:

("[PATCH v3 0/1] target/riscv: deprecate 'debug' CPU property and Debug 0.13")
https://lore.kernel.org/qemu-devel/20260528131214.2251075-1-daniel.barboza@oss.qualcomm.com/


The lore behind that change is that we want to support Debug 1.0 extensions, in
particular sdext, because that is a requirement for the Server Reference Board.
But 'debug' is based on spec 0.13, and unfortunately these 2 versions can't play
ball, so my initial reaction was to move away for 0.13.

 From what I can see in this series there is a desire to keep the existing debug
0.13 code base around, and that's fine.  I also believe that despite the
incompatibility the 0.13 code base can be re-used for the 1.0 sdtrig as well,
with the appropriate "if-then-else" to split between the behaviors we want, so
it's feasible to do both.

IIUC what we seem to be missing in patches 19-24 is a separated flag, i.e. a
new extension flag, for the 1.0 sdtrig.  So we would end up with 'debug' being
an alias for 'sdtrig 0.13' and a new 'sdtrig' flag that implements debug 1.0.

Chao can then base his 'sdext' work on top of the new sdtrig flag, and then
we can upstream the riscv-server-ref board.  At least this is how I'm seeing
all this pieces playing out ....


Cheers,
Daniel




On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> Hi,
> 
> Sorry for the big series. The Ascalon CPU implements Sdtrig with 2
> different types of mcontrol6 trigger and the icount trigger, so in
> the course of testing and bringing up OpenSBI and Linux support for
> this, I've accumulated quite a lot.
> 
> My new year resolution is to start being better upstream contributor,
> it's taken me a while with changing jobs and architectures. So I don't
> expect others to drop everything to review this! Joel has been
> prodding me, and noted there is some other Sdtrig work going on
> with the v1.0 support patches.
> 
> I think the debug v1.0 patches are somewhat orthogonal to this series,
> but both are addressing aspects of a common problem of Sdtrig
> implementation specifics. I wonder if these should be reconciled or
> left separate. Sdtrig v1.00/v0.13 configuration is a single boolean
> which is feasible as a CPU property. Whereas the entire space of
> Sdtrig implementation seems like too much to make configurable in that
> way.
> 
> Any thoughts would be welcome.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (25):
>    target/riscv/debug: Check only mcontrol triggers for break/watchpoint
>      matching
>    target/riscv/debug: Handle changing trigger types
>    target/riscv/debug: Implement permissive type unavailable trigger
>    target/riscv/debug: Fix icount trigger privilege check
>    target/riscv/debug: Update itrigger_enabled after changing privilege
>    target/riscv/debug: Implement get_trigger_action for icount type
>      trigger
>    target/riscv/debug: Fix migration post_load icount_enabled() test
>    target/riscv/debug: Fix icount privilege matching icount_enabled()
>      test
>    target/riscv/debug: Implement icount trigger textra matching
>    target/riscv/debug: Maintain itrigger_enabled in
>      helper_itrigger_match()
>    target/riscv/debug: Fix breakpoint matching action
>    target/riscv/debug: Put mcontrol load/store match address into tval
>    target/riscv/debug: Remove breakpoints on reset
>    target/riscv/debug: Move debug CPU post_load details into debug.c
>    target/riscv/debug: Insert breakpoints after migration
>    target/riscv/debug: Remove itrigger icount-enabled mode
>    target/riscv/debug: Advertise icount trigger type in tinfo
>    target/riscv/debug: Reset trigger type to unavailable
>    target/riscv/debug: Add new debug state format
>    target/riscv/debug: Migrate mcontext using new sdtrig vmstate
>    target/riscv/debug: Implementation specific Sdtrig configuration
>    target/riscv/debug: Support heterogeneous trigger types
>    target/riscv/debug: Support heterogeneous mcontrol access types
>    target/riscv/debug: Emulate TT Ascalon Sdtrig
>    target/riscv/debug: Fix minor comment typos
> 
>   target/riscv/cpu.c         |  65 ++++-
>   target/riscv/cpu.h         |  41 ++-
>   target/riscv/cpu_helper.c  |  10 +-
>   target/riscv/csr.c         |   7 +-
>   target/riscv/debug.c       | 571 ++++++++++++++++++++-----------------
>   target/riscv/debug.h       |  19 +-
>   target/riscv/machine.c     |  96 ++++++-
>   target/riscv/tcg/tcg-cpu.c |   5 +-
>   8 files changed, 510 insertions(+), 304 deletions(-)
> 


