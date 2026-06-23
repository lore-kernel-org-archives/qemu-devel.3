Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F38CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwTw-0000rn-Uz; Tue, 23 Jun 2026 04:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwTu-0000r5-Mv
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:27:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwTs-0008Oc-Pd
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:27:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N7kmvU3228416
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G4i09EF2TLT0F1h9qznqtyVTHK3uGMpJiTsH1WY03kw=; b=RkFo6U54jc4izb63
 /yzJVorwUiYk5+DyUQvlLxOkX5UhXV6lI5WUIrrIZByZUjy4YqrORewGZj81UcFK
 uBr/c6uM22Azr5cqK4wNNSYjku336GI/59PPc7TSuXWGMt1tpUpbJ/uN1T0avaZ4
 BLC44JAeb5xAl+9jOdoWkkYJQtZXRAocCZ5SX5QOZ/TDXDramg8rvzmecaOfg/t2
 i3uUaWCOJIJ2aslGa7ulntrST1Aq25wfG+ZRBrR1mTkKwfMEq7vmixaBelhvC26o
 NV8onXcVJiMSpkHu2d3DtNQTg/cc/HNH3e0iV3pk+wjtA4Pj87W2nHBkcU1xKiTl
 EdHOhw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29g54y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:27:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157f453a27so839585485a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782203257; x=1782808057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G4i09EF2TLT0F1h9qznqtyVTHK3uGMpJiTsH1WY03kw=;
 b=N541uPJ851949Y/RZcBF6FygxxjdFI5qfJHP+1lZUBwrW2A/8xcnzB1LL3GDU1WsP+
 A7Lhd49ItgGw99mDQZP+5HhCc4JhodX+7bAiloiEEdSI7EmDWPtsxVMNqKDTiaQR478J
 bWWENvUZf8dMCJBEvjBjyqXTGN1AoU3Mr245aGnYtGbzGnTDOoCnWBAzKvZEvSGkYkks
 A0QswxuYL6GXwwJrPH4KWfgMPOMrGMEkcP6Zg+f7W0QvxCsptfDeKB94d4dfK9AdwLoo
 Y/32VeBtLePihUuz90lFqx4HB7gvfCgDLrU2IUmNGDfeUH2dRwF53j33mPMEHoOuyFI2
 S44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782203257; x=1782808057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G4i09EF2TLT0F1h9qznqtyVTHK3uGMpJiTsH1WY03kw=;
 b=LF03wLjN2Lr3zyLXBjLdeUqswAVBlNLRZzKTPUt6L3o2CpXa6Fs1PcFTOuUMcz4r6Y
 Ixr8t6o1dx5cX5VAOUfm3hC8DGhd1BM+Ghi3JT5do/zvq8LuW8ycS39N1nTSKYzZ1I2B
 PDd7fQxjcbj3StlrzoFqWdF6iDA4p7/abQaZSIPHl85TGQoDolnOdg9MYxkVr5y5l6p1
 WV3RMbAsbIUIs2E0ce6XXgO2ys+ts8unZaiHOR12MiKEcRjDR4ngRS8y7aus+LeWCz1i
 1gXy6BP7CmETveKLto/pJM8U7NIrkxIkWHJDcoO8agaw4VdPbrPCmAFHjQJUHX7XEZkP
 lwFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pbx6DOYyRV0gES5iVVaBeHhm8dLRTyReF9rrHSesUonhjZNK0XwHyxPOMzhYasFZygca3tdR9wUuJ@nongnu.org
X-Gm-Message-State: AOJu0YyyANgowrnwxcTuL89BzvftjGSsniagfut6m0XrsEvXmn5am6Fl
 rOWlFd2hsBnMv1q8DLdD9kYM4RjpcI5NzoqouWeM+klJejZQLM0kUIzOANXeCFb4gZ57BYqC9X2
 UY8qtgjWaKW4loN5nA1ApoIlnsw+1QWdLjCSAD2dycHnZHv1XbAwxqCGOEg==
X-Gm-Gg: AfdE7clrnw7zOBhQpTbNmSz2IcD7blNdY3wYzexopUAXjFU2h1uZ9Mbi7qpo+jn3Ocq
 27gGP1OHeZ6ELw6whRtJwv5uo9x4EMkpCW0AeZgolODdYScVjHPHb948BH+oYIa2iJdM5IQGUHg
 azYEtuo0CpVCCBpzidVlbu4qBDftpC6bLzr9Vqws6I5GRs3gHoQIeu+BrwiNJK7Wu7CzdpNHQ4w
 KrEwVoDNE1YAKvt0ln2C0Tvg7o7OawRfLtMMbdwJR1NPLZ5GRU5hj8LX2HNxFqC0/DBSRwxCPUs
 lzH+DNLDJhFhNVVLe5DETxYT9cVoGN9zFOo3gTaXZHS0vpvufZ/M4smQ8wiMABrUEuCf9rNPz/x
 N8lR/ub+X0dzLTXQaFZw1Rj56ykjLGRuL4JpBJdnW5S3wyPT5zr2CI2MOHybNCg==
X-Received: by 2002:a05:620a:444b:b0:91e:e613:9c5f with SMTP id
 af79cd13be357-9264771b20amr336193085a.26.1782203256904; 
 Tue, 23 Jun 2026 01:27:36 -0700 (PDT)
X-Received: by 2002:a05:620a:444b:b0:91e:e613:9c5f with SMTP id
 af79cd13be357-9264771b20amr336188985a.26.1782203256292; 
 Tue, 23 Jun 2026 01:27:36 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249238900sm263405635e9.4.2026.06.23.01.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 01:27:35 -0700 (PDT)
Message-ID: <4e00be29-25b4-479b-ad6f-b79beed78dd1@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/hvf: manually sync ID_AA64ISAR0_EL1 on vCPU
 init
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 "Jason L. Wright'" <wrigjl@proton.me>
Cc: agraf@csgraf.de, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 zenghui.yu@linux.dev, richard.henderson@linaro.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
 <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
 <20260607182221.4357-1-wrigjl@proton.me>
 <CAFEAcA-xEaA2LM=17Q1pKOF6L=rHhaDimXeSmLe=BtDqeaBeFA@mail.gmail.com>
 <aibmIdorcTobj2yo@Jasons-MacBook-Pro.local>
 <CAFEAcA85HahxFXoDVW_xBZEtG2SUd_3PseYLrpUXE6P_Hb_5mA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA85HahxFXoDVW_xBZEtG2SUd_3PseYLrpUXE6P_Hb_5mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3a4379 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bDdhxBF-3-ZmLf7kk0gA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: ruHWWREW8lQgnuPTeQmXEzJGQm_F3Nt3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA2NyBTYWx0ZWRfXxImVgGIu65lH
 lJ4JJDC+2WGe4UYbhBy5JZO+Z6ibCu17XYRZ/TRQQcWfHyzVR0T1VJZDOjHjn55tY+vxFX/BmZG
 0Id+PflO+ZmC00XWIVlC6C3HrT+IK1M=
X-Proofpoint-ORIG-GUID: ruHWWREW8lQgnuPTeQmXEzJGQm_F3Nt3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA2NyBTYWx0ZWRfX03Nyn4EbQsWl
 QHmULfT2hlFeQyPpE5PFk6fQBOnka3WM7bsKe9C5bfqqSNsge39YsPoWNXRoIdjZfFLpJi3+GD8
 C6ZOIwMPc3QC1jDIab8BwKPFg9gzxVRj3CVi0PJzXHtzPlk4XFJrPyoc4NBdmz+TW8sQUNcyO8F
 BdpUSQ8ebv1CiuaI30pcsc0RdJl3c/1gTpsMd7drloHqQul/yA9kvZzYbBaGOz1M6IpGd7qVjEK
 P+oBaTAgFa1JDh5nYwcgLyuOv8C5W9ZZVOaijaEE9rgPJwUJ3GWxw6i567IJtWCfHGTta0zNcLu
 z96bYFOb6TNwnRfXsxLlz7oAR9aKPgYbyqlVNFvnoCy8WipJWjgHkvsqeUA08S5wS5FFOmai0Hs
 7tIPeRTsaIAkIwAOUfzqrhbzn3+cFRXYRdh3Nk2tHhhNYGM80HTreIOh8dxMmniJ4zFyXsYA2Y2
 +w9EZoAm82tzMLQm0NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hi,

On 8/6/26 18:05, Peter Maydell wrote:
> On Mon, 8 Jun 2026 at 16:56, Jason L. Wright' <wrigjl@proton.me> wrote:
>>
>> On Mon, Jun 08, 2026 at 02:07:03PM +0100, Peter Maydell wrote:
>>> On Sun, 7 Jun 2026 at 19:22, Jason Wright <wrigjl@proton.me> wrote:
>>>>
>>>> Commit 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
>>>> gave ID_AA64ISAR0_EL1 a readfn so the RNDR field can reflect SCR_EL3.TRNDR
>>>> at read time, and marked the cpreg ARM_CP_NO_RAW in the system-emulation
>>>> path.  HVF then trips its hvf_arch_init_vcpu() assertion that no ID
>>>> register in hvf_sreg_list[] is NO_RAW, aborting on boot on Apple Silicon:
>>>>
>>>>    Assertion failed: (!(ri->type & ARM_CP_NO_RAW)),
>>>>    function hvf_arch_init_vcpu, file hvf.c, line 1442.
>>>>
>>>> Reproduce with:
>>>>
>>>>    qemu-system-aarch64 -M virt,accel=hvf -cpu host \
>>>>                        -nographic -display none -bios /dev/null
>>>>
>>>> Mirror the existing treatment of ID_AA64PFR0_EL1: move
>>>> HV_SYS_REG_ID_AA64ISAR0_EL1 into the SYNC_NO_RAW_REGS block in
>>>> sysreg.c.inc so the assert loop skips it, and push QEMU's view of the
>>>> register to the vCPU at init time.  HVF does not expose EL3, so
>>>> SCR_EL3.TRNDR is never set and the readfn is functionally static there.
>>>>
>>>> Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
>>>> Fixes: 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
>>>> Signed-off-by: Jason Wright <wrigjl@proton.me>
>>>> ---
>>>>   target/arm/hvf/hvf.c        | 4 ++++
>>>>   target/arm/hvf/sysreg.c.inc | 2 +-
>>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>>>> index d88cbe7c82..afa1120c8a 100644
>>>> --- a/target/arm/hvf/hvf.c
>>>> +++ b/target/arm/hvf/hvf.c
>>>> @@ -1485,6 +1485,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>>>>       ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
>>>>       assert_hvf_ok(ret);
>>>>
>>>> +    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64ISAR0_EL1,
>>>> +                              GET_IDREG(&arm_cpu->isar, ID_AA64ISAR0));
>>>> +    assert_hvf_ok(ret);
>>>> +
>>>
>>> For ID_AA64PFR0_EL1, we do "read the value from hvf, update it,
>>> write it back", and we do not either read or write the isar.idregs[]
>>> entry for it.
>>>
>>> For ID_AA64MMFR0_EL1, we read the hvf value into the isar.idregs[]
>>> array entry, update it there, and write it back to hvf.
>>>
>>> For ID_AA64ISAR0_EL1, we write whatever is in the isar.idregs[]
>>> array entry into hvf.
>>>
>>> Why do we do three different things for these three registers ?
>>>
>> I think it's each call doing the minimum work required for that
>> register.
>>
>> MIDR_EL1 / MPIDR_EL1 are QEMU-defined identity values; HVF has
>> nothing useful to contribute, so we just write.
> 
> These don't have isar.idregs[] entries either, so it makes sense
> that they're not quite the same.
> 
>> ID_AA64PFR0_EL1 needs HVF's value as the base (host feature set)
>> and then ORs in the GIC sysreg-iface bit, which depends on
>> env->gicv3state runtime overlay, hence the get/modify/set.
> 
> But why do we not update isar.idregs[] to match ?
> 
>> ID_AA64MMFR0_EL1 also needs HVF's value as the base, and the
>> modification (clamping PARANGE to the configured IPA size)
>> consults isar.idregs[], so we read into idregs[] before clamping
>> and then write back.
> 
> But why does the modification consult isar.idregs[] rather than
> taking a value that it's passed in as an argument ?
> 
>> ID_AA64ISAR0_EL1 in this patch has no runtime overlay on the HVF
>> path: SCR_EL3.TRNDR is permanently 0 since HVF does not expose
>> EL3, so the readfn is a constant equal to
>> isar.idregs[ID_AA64ISAR0_EL1_IDX], which was already seeded from
>> the host during realize.
> 
> But if the values in isar.idregs[] are seeded from HVF during
> realize, why do we not trust the isar.idregs[] value when we're
> handling ID_AA64PFR0_EL1?
> 
>> The three methods track different requirements, so I matched
>> the closest existing pattern for ID_AA64ISAR0_EL1 and left
>> the others alone.
> 
> It seems to me that you've added a third thing that's different
> from either of the ways that we handle existing ID registers
> with an isar.idregs[] field.
> 
> I think we need to figure out:

Should we revert the commit until this is figured out?

> 
> (1) can we trust that the isar.idregs[] values at this point
> are the ones that hvf uses? If so we don't need to re-read
> the hvf values. If we can't trust them we should consistently
> read the hvf values.
> 
> (2) do we need to update the isar.idregs[] values when we
> modify the values to write back to hvf? If so, we should
> do it consistently for all these regs. If not, we should
> not update any of them.
> 
> Currently ID_AA64PFR0_EL1 neither trusts isar.idregs[] nor
> updates it; ID_AA64MMFR0_EL1 does not trust isar.idregs[]
> but does update it; and ID_AA64ISAR0_EL1 trusts isar.idregs[]
> and has no need to update it.
> 
> thanks
> -- PMM
> 


