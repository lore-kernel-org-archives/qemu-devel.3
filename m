Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KWsAbMz4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HX1tPmyh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX59Q-0004vP-Mc; Fri, 27 Nov 2026 18:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX59P-0004ul-8F
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 18:14:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX59M-0005JU-EG
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 18:14:43 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJRAw42668727
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 23:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R0Xrjws/Ewu4r9LyZmt0hM/NdrsSYZzx+U5jD1pfqXs=; b=KWsAbMz4LOeII31t
 oOAc0QY0zJdmi0+QL7zalDuNQmKTkhNEjta8TfbHkD97QJz2DTRM5eWcb3+xx99e
 hlRT0jBQCZ2l8mPpCKAhJIeYX2hFawNI2Pj/6htpPWKVo0NPu4BWZ9DAQ3mzojbF
 rgm+HPC4nIwmAerFySdNW2hsE0SElVFm8CCLf0zPN8nN8sfUPbWNDVnxhqvwtcWh
 PvcmVrzC1286Q5u2nWL9PJcSGYamiynORCFzwuW9fs2nJOv6+AwDIcCaX0iIYbfZ
 diGHJAoORvKiXCq+nCOc9yC+bzZwKHDRPdofZn1dKhAIDdzdWpmYaseKFhZXJ+mB
 YLiB3Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g1jgdd7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 23:14:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386a0f79047so9200376eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 15:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795821277; x=1796426077; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R0Xrjws/Ewu4r9LyZmt0hM/NdrsSYZzx+U5jD1pfqXs=;
 b=HX1tPmyhOVzOC9aZudlCD7O7dFmPqrIM+f8SU7PAKhVQWdofYqOZz7eYCwmBAc/eCm
 7PKBe8WUtZjpZnLrUET01KZiTEPIX1mibFUXGMYOExltGSOtduCChb5FwjMCUKjgvBNe
 Wa1yBhmP4Q1XNiMHzn+VMFbgAm939dnLVcfu0sW6F/CPjsJ6/vUYFHdSFYCYQy0y+oET
 uSEZ3pbl8xRRf4ucXsRcloQ1QrC0nYPuhI0uEEik/cSGPOYAtsbD2sFK9qU+Hcc7RtB2
 4dj7vvcXaRd/4f2Yhe2zDlS+2F6jAtiS9ocHxtTIIFjH3KtgCmbL5e8UVtNlBNoVhDoE
 9wqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795821277; x=1796426077;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R0Xrjws/Ewu4r9LyZmt0hM/NdrsSYZzx+U5jD1pfqXs=;
 b=L/9pNkC5xq1wBPhBWJQSnnRMVDvUeS0Zymi7jheOfc5mZSY4XTuyLMevmsWythyYhd
 XkiQp/yo20BKNR0fMqmhYiFdqYKg9UxR7SUA6Zn7efjPQqqLGdVB/QJsBc83cxIsYkFw
 Nt2zfvcfNTjGxClq0yRc/6K5as5YWjxN0nsta2pl72Lbwv4/y65Cez0Ffnp1YcoSp3ue
 LfgqZWiSDaHIkYUESvLcbhtQ/J3/33z8X1GmicQNGAXFFCbFfVdjgaXxri9u1aoWvYBk
 6bGELI/J/zaAzvDnruRKt9l3MoahkLMvNZw/Tvxd2Gyu3bZwpf9r56Mtey9v3D8HwLGY
 Jjrw==
X-Gm-Message-State: APuU4Z88wpH+mJ+csgHKHbM/A6wTtwlrPP57kM3CNFuGOeP1X4zqIygf
 FE2JWe0CwqTmdA+JUtFxPjb5prrhOYzMTovryK6MXhia+3VBo0MwWhhCtrrguTsE8tc7Vr1r53U
 4E+f6tCc+Xwe1saZtNp//VZVOYzv6sbmav3sxrlizrlVKRWLmzHlDoxaeQA==
X-Gm-Gg: AZFdTZfiW6ECa4L9wZ1UcC/PPvksLUsFdN+QJZHZqORcalgVbOEnobgnkHZ9xy8sV+6
 CW8YdTm5O44WFwRLQ4WcfTTih5J2KD5iKIq4G8Dp52yZYaQ82YqLqMuUpSzw+lSgpPpR7cYtteR
 qhypaWW3VddcPiS/fmk/NBbxhZBGp38ma1X/oX7S8HCVSDl5Np0MKbc1QVKPnMIypAICnpYrGs8
 LIru6bRcADeig/xTarlKMlGbpE8S/20memhDZkwXVBF3z4+o5hdy9EgU9ac0s5qU+8Xkv+oMoBF
 339zMIhLYWaOK1DMzNhbN387mJVPUqTrUUEWOv8r2gnOQUblFSxtMIRrtOb3OHYLtTYzn99EbDg
 58wVSwoFvZTkhWuV41zRUhNPEg+/rkNKwLmAp4EbpKITi4vY5+zAHij7OMErK17Z5saDRccsBw7
 Xki+RquKAVu+dQG5ftjLB8YaOySgDsvf1glglNKMT8zDwpUBRJ+XFN
X-Received: by 2002:a05:7301:6908:b0:381:1926:dba3 with SMTP id
 5a478bee46e88-3856983c0ccmr21535831eec.0.1795821276938; 
 Fri, 27 Nov 2026 15:14:36 -0800 (PST)
X-Received: by 2002:a05:7301:6908:b0:381:1926:dba3 with SMTP id
 5a478bee46e88-3856983c0ccmr21535821eec.0.1795821276338; 
 Fri, 27 Nov 2026 15:14:36 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3866f299d0bsm65961101eec.19.2026.11.27.15.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 15:14:35 -0800 (PST)
Message-ID: <9ae733fc-cd24-4563-8b57-7151b4ca05a5@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 17:14:34 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 v2 5/5] target/hexagon: dump vector and sys regs
 in cores
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Ani Sinha <anisinha@redhat.com>
References: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
 <20261127203209.42752-6-brian.cain@oss.qualcomm.com>
 <92CF59D1-37E4-4F89-AB96-B332F2DBD64A@unpredictable.fr>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <92CF59D1-37E4-4F89-AB96-B332F2DBD64A@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA5MiBTYWx0ZWRfX2YoMqoIz/w9+
 u2Ezl2+oGPfyMc9D0fLM+/2NR8c2sMNhW9featcdZjxqpwFkZVfwOymKyH2x2iuVUnvVw7V3QxB
 4WgQq9drifr+PZnoP9pVtHq1MkEgdnjRVJBY8obLmygryw29aq1xpBHNMnD7MePJluEcredgEaO
 rLeHQ3LHNs9a77N9IBHfc6Vkndl3A/3BPYj6J/ZQxx0LK7cE0mAan8qOiD7D9uLGHgycHGr8UG3
 GmvHK9R1s53EIwS+teqCTY8ZhxONBJURava0+VKuGs1iTracFBG4eZ+vDiHNRbWjvwSpHqYkZX/
 RQwiku95ogeQ3cb0+gM0JJ7VbN0G3lT17vFWk8OEUTo/Zpw55Y1a3xDr+k5aXFAaQSP8Mzb4LAb
 PAuEZD6UFzxDCHFr3MuHraqvQCYh97RXOUAa41tS/WayTJdludyxugwFL5hl5ru05FTVuHaSsJe
 7pNXdMap2CUDnXdUq4g==
X-Proofpoint-ORIG-GUID: RQtlGwQ-WaSSYY1nVuLYy-6oRZc9_vW_
X-Authority-Analysis: v=2.4 cv=QpzLTlyd c=1 sm=1 tr=0 ts=6b0a0ede cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2AZ_Vc9j-U1xpaiV62oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: RQtlGwQ-WaSSYY1nVuLYy-6oRZc9_vW_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA5MiBTYWx0ZWRfX9A0WQg648Xhq
 EltAR3sVqThZyO6i/Udos+qfX75LEtzSFqJz1q8iVGaAl+pn7pj8PmYDGQz/rQ1qDU1B5fnWeBo
 +Sxnyzn2OiaagzILAJwPLQGEYxtkaS0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/27/2026 4:15 PM, Mohamed Mediouni wrote:
>
>> On 27. Nov 2026, at 21:32, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>>
>> Add the HVX/HLX and system states to the core file as notes.
>
>> HMX has no architectural state that software can read directly,
>> so it is omitted.
> Hi,
>
> That bit doesn’t look like a great idea.
>
> I mean it does have 3 sets of registers including the accumulate registers, and
> not having those be part of the debug dump is a bit special.

We can add those but existing debuggers wouldn't support them natively.

Though we did add some other items not yet supported by lldb, so this 
would just be more.

Ok - I will add HMX accumulator, convert, bias regs.

> Ideally, the core file ought to be a snapshot that could be (presumably) resumed
> from, and this would be the opposite of that.
>
>> The global registers and the TLB are the same for every thread.  They are
>> repeated in each thread's notes so that a thread's notes are
>> self-contained.
>>
>> Reviewed-by: Helge Deller <deller@gmx.de>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>> linux-user/hexagon/target_elf.h |   1 +
>> target/hexagon/core-dump.h      |  16 +++
>> target/hexagon/cpu.h            |   2 +-
>> linux-user/hexagon/elfload.c    |  10 ++
>> target/hexagon/arch_dump.c      |  23 ++-
>> target/hexagon/core_notes.c     | 243 ++++++++++++++++++++++++++++++++
>> target/hexagon/cpu.c            |   4 +-
>> target/hexagon/meson.build      |   1 +
>> 8 files changed, 294 insertions(+), 6 deletions(-)
>> create mode 100644 target/hexagon/core_notes.c
>>
>> diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
>> index daaec521a76..73d4c1e815f 100644
>> --- a/linux-user/hexagon/target_elf.h
>> +++ b/linux-user/hexagon/target_elf.h
>> @@ -26,6 +26,7 @@
>> #include "target/hexagon/core-dump.h"
>>
>> #define HAVE_ELF_CORE_DUMP      1
>> +#define HAVE_ELF_CORE_EXTRA_NOTES 1
>> #define elf_core_eflags(info)   ((info)->elf_flags)
>>
>> typedef HexagonUserRegs target_elf_gregset_t;
>> diff --git a/target/hexagon/core-dump.h b/target/hexagon/core-dump.h
>> index a14b495d04d..b0f7bf38d5d 100644
>> --- a/target/hexagon/core-dump.h
>> +++ b/target/hexagon/core-dump.h
>> @@ -34,6 +34,22 @@ typedef struct target_elf_gregset_t {
>>
>> QEMU_BUILD_BUG_ON(sizeof(HexagonUserRegs) != 48 * sizeof(uint32_t));
>>
>> +#define HEXAGON_CORE_NOTE_OWNER "QEMU"
>> +#define HEXAGON_CORE_NOTE_VERSION 1
>> +
>> +enum {
>> +    HEXAGON_NT_CTRL = 0x100,
>> +    HEXAGON_NT_HVX = 0x101,
>> +    HEXAGON_NT_HLX = 0x102,
>> +    HEXAGON_NT_SYSREGS = 0x103,
>> +    HEXAGON_NT_THREAD = 0x104,
>> +    HEXAGON_NT_TLB = 0x105,
>> +};
>> +
>> +size_t hexagon_core_notes_size(const CPUHexagonState *env);
>> +
>> +void hexagon_core_fill_notes(void *buf, const CPUHexagonState *env);
>> +
>> static inline void hexagon_core_copy_regs(HexagonUserRegs *regs,
>>                                            const CPUHexagonState *env)
>> {
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>> index 5739254f1f6..074e46d2a96 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -283,7 +283,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
>>   * not stopped.
>>   */
>> bool hexagon_thread_is_enabled(const CPUHexagonState *thread_env);
>> -uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
>> +uint32_t hexagon_greg_read(const CPUHexagonState *env, uint32_t reg);
>> void hexagon_greg_write(CPUHexagonState *env, uint32_t reg, uint32_t val);
>> void hexagon_cpu_soft_reset(CPUHexagonState *env);
>> #endif
>> diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
>> index dac8260b302..46232bae5d7 100644
>> --- a/linux-user/hexagon/elfload.c
>> +++ b/linux-user/hexagon/elfload.c
>> @@ -11,6 +11,16 @@ void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUHexagonState *env)
>>      hexagon_core_copy_regs(regs, env);
>> }
>>
>> +size_t elf_core_extra_notes_size(const CPUHexagonState *env)
>> +{
>> +    return hexagon_core_notes_size(env);
>> +}
>> +
>> +void elf_core_fill_extra_notes(void *buf, const CPUHexagonState *env)
>> +{
>> +    hexagon_core_fill_notes(buf, env);
>> +}
>> +
>> abi_ulong get_elf_hwcap(CPUState *cs)
>> {
>>      HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(cs);
>> diff --git a/target/hexagon/arch_dump.c b/target/hexagon/arch_dump.c
>> index c1b2892e2ad..50911503cd9 100644
>> --- a/target/hexagon/arch_dump.c
>> +++ b/target/hexagon/arch_dump.c
>> @@ -38,18 +38,29 @@ typedef struct HexagonElfNote {
>> int hexagon_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>>                                   int cpuid, DumpState *s)
>> {
>> +    CPUHexagonState *env = cpu_env(cs);
>>      HexagonElfNote note = { 0 };
>>      HexagonUserRegs regs;
>> +    g_autofree void *extra = NULL;
>> +    size_t extra_size = hexagon_core_notes_size(env);
>> +    int ret;
>>
>>      note.header.n_namesz = cpu_to_dump32(s, sizeof("CORE"));
>>      note.header.n_descsz = cpu_to_dump32(s, sizeof(note.prstatus));
>>      note.header.n_type = cpu_to_dump32(s, NT_PRSTATUS);
>>      memcpy(note.name, "CORE", sizeof("CORE"));
>>      note.prstatus.pr_pid = cpu_to_dump32(s, cpuid);
>> -    hexagon_core_copy_regs(&regs, cpu_env(cs));
>> +    hexagon_core_copy_regs(&regs, env);
>>      memcpy(&note.prstatus.pr_reg, &regs, sizeof(regs));
>>
>> -    return f(&note, sizeof(note), s);
>> +    ret = f(&note, sizeof(note), s);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    extra = g_malloc(extra_size);
>> +    hexagon_core_fill_notes(extra, env);
>> +    return f(extra, extra_size, s);
>> }
>>
>> void hexagon_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>> @@ -67,7 +78,13 @@ void hexagon_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>> size_t hexagon_get_note_size(const CPUState *cs, int class, int machine,
>>                               int nr_cpus)
>> {
>> -    return sizeof(HexagonElfNote) * nr_cpus;
>> +    CPUState *cpu;
>> +    size_t size = 0;
>> +
>> +    CPU_FOREACH(cpu) {
>> +        size += sizeof(HexagonElfNote) + hexagon_core_notes_size(cpu_env(cpu));
>> +    }
>> +    return size;
>> }
>>
>> static bool hexagon_mapping_overlaps(const MemoryMappingList *list,
>> diff --git a/target/hexagon/core_notes.c b/target/hexagon/core_notes.c
>> new file mode 100644
>> index 00000000000..848c2ed1ebe
>> --- /dev/null
>> +++ b/target/hexagon/core_notes.c
>> @@ -0,0 +1,243 @@
>> +/*
>> + * Hexagon ELF core dump notes owned by "QEMU".
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cpu.h"
>> +#include "hw/hexagon/hexagon_hlx.h"
>> +#include "mmvec/mmvec_qfloat.h"
>> +#ifndef CONFIG_USER_ONLY
>> +#include "hw/hexagon/hexagon_globalreg.h"
>> +#include "hw/hexagon/hexagon_tlb.h"
>> +#include "cpu_helper.h"
>> +#endif
>> +#include "core-dump.h"
>> +
>> +typedef struct NoteCursor {
>> +    uint8_t *buf;   /* NULL to only measure */
>> +    size_t len;
>> +} NoteCursor;
>> +
>> +typedef void (*NoteFill)(NoteCursor *c, const CPUHexagonState *env);
>> +
>> +static void put_bytes(NoteCursor *c, const void *data, size_t size)
>> +{
>> +    if (c->buf) {
>> +        memcpy(c->buf + c->len, data, size);
>> +    }
>> +    c->len += size;
>> +}
>> +
>> +static void put_zeros(NoteCursor *c, size_t size)
>> +{
>> +    if (c->buf) {
>> +        memset(c->buf + c->len, 0, size);
>> +    }
>> +    c->len += size;
>> +}
>> +
>> +static void put_u32(NoteCursor *c, uint32_t val)
>> +{
>> +    uint32_t le = cpu_to_le32(val);
>> +
>> +    put_bytes(c, &le, sizeof(le));
>> +}
>> +
>> +static void put_u64(NoteCursor *c, uint64_t val)
>> +{
>> +    uint64_t le = cpu_to_le64(val);
>> +
>> +    put_bytes(c, &le, sizeof(le));
>> +}
>> +
>> +static void put_note(NoteCursor *c, uint32_t type, NoteFill fill,
>> +                     const CPUHexagonState *env)
>> +{
>> +    NoteCursor desc = { };
>> +
>> +    fill(&desc, env);
>> +
>> +    put_u32(c, sizeof(HEXAGON_CORE_NOTE_OWNER));
>> +    put_u32(c, desc.len);
>> +    put_u32(c, type);
>> +    put_bytes(c, HEXAGON_CORE_NOTE_OWNER, sizeof(HEXAGON_CORE_NOTE_OWNER));
>> +    put_zeros(c, ROUND_UP(sizeof(HEXAGON_CORE_NOTE_OWNER), 4) -
>> +                 sizeof(HEXAGON_CORE_NOTE_OWNER));
>> +    fill(c, env);
>> +    put_zeros(c, ROUND_UP(desc.len, 4) - desc.len);
>> +}
>> +
>> +/*
>> + * Layout: version, FRAMELIMIT, FRAMEKEY, VFRAMELIMIT, VSP.
>> + */
>> +static void fill_ctrl(NoteCursor *c, const CPUHexagonState *env)
>> +{
>> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
>> +    put_u32(c, env->gpr[HEX_REG_FRAMELIMIT]);
>> +    put_u32(c, env->gpr[HEX_REG_FRAMEKEY]);
>> +    put_u32(c, env->gpr[HEX_REG_VFRAMELIMIT]);
>> +    put_u32(c, env->gpr[HEX_REG_VSP]);
>> +}
>> +
>> +static const HexagonHVXContext *note_hvx_ctx(const CPUHexagonState *env)
>> +{
>> +#ifdef CONFIG_USER_ONLY
>> +    return &env->hvx_ctx;
>> +#else
>> +    return env->hvx;
>> +#endif
>> +}
>> +
>> +/*
>> + * Layout: version, vlen (the size of a vector register in bytes), nvregs,
>> + * nqregs and ext, then the nvregs vector registers, then the nqregs predicate
>> + * registers of vlen / 8 bytes each.  If ext is 1, which it is where qfloat
>> + * has extension bits, V79 and later, the vlen / 4 bytes of extension bits of
>> + * each vector register follow.
>> + */
>> +static void fill_hvx(NoteCursor *c, const CPUHexagonState *env)
>> +{
>> +    const HexagonHVXContext *hvx = note_hvx_ctx(env);
>> +
>> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
>> +    put_u32(c, sizeof_field(MMVector, ub));
>> +    put_u32(c, NUM_VREGS);
>> +    put_u32(c, NUM_QREGS);
>> +    put_u32(c, qfloat_is_extended(env));
>> +
>> +    for (int i = 0; i < NUM_VREGS; i++) {
>> +        for (int j = 0; j < ARRAY_SIZE(hvx->VRegs[i].ud); j++) {
>> +            put_u64(c, hvx->VRegs[i].ud[j]);
>> +        }
>> +    }
>> +    for (int i = 0; i < NUM_QREGS; i++) {
>> +        for (int j = 0; j < ARRAY_SIZE(hvx->QRegs[i].ud); j++) {
>> +            put_u64(c, hvx->QRegs[i].ud[j]);
>> +        }
>> +    }
>> +    if (qfloat_is_extended(env)) {
>> +        for (int i = 0; i < NUM_VREGS; i++) {
>> +            put_bytes(c, hvx->VRegs[i].ext, sizeof(hvx->VRegs[i].ext));
>> +        }
>> +    }
>> +}
>> +
>> +/*
>> + * Layout: version, vlen (the size of an HLX register in bytes), nlregs and
>> + * zero, then the nlregs registers.
>> + */
>> +static void fill_hlx(NoteCursor *c, const CPUHexagonState *env)
>> +{
>> +    const HexagonHLXContext *hlx = env->hlx_ctx;
>> +
>> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
>> +    put_u32(c, HLX_VEC_SIZE_BYTES);
>> +    put_u32(c, NUM_LREGS);
>> +    put_u32(c, 0);
>> +
>> +    for (int i = 0; i < NUM_LREGS; i++) {
>> +        for (int j = 0; j < ARRAY_SIZE(hlx->LRegs[i].ud); j++) {
>> +            put_u64(c, hlx->LRegs[i].ud[j]);
>> +        }
>> +    }
>> +}
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +/*
>> + * Layout: version, nsregs, ngregs and zero, then the nsregs system registers
>> + * by register number, with the thread's own ones below HEX_SREG_GLB_START
>> + * and the global ones from there on, then the ngregs guest registers.
>> + */
>> +static void fill_sysregs(NoteCursor *c, const CPUHexagonState *env)
>> +{
>> +    const HexagonCPU *cpu = env_archcpu(env);
>> +
>> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
>> +    put_u32(c, NUM_SREGS);
>> +    put_u32(c, NUM_GREGS);
>> +    put_u32(c, 0);
>> +
>> +    for (int i = 0; i < NUM_SREGS; i++) {
>> +        if (i < HEX_SREG_GLB_START) {
>> +            put_u32(c, env->t_sreg[i]);
>> +        } else {
>> +            put_u32(c, cpu->globalregs ?
>> +                    hexagon_globalreg_read(cpu->globalregs, i,
>> +                                           env->threadId) : 0);
>> +        }
>> +    }
>> +    for (int i = 0; i < NUM_GREGS; i++) {
>> +        put_u32(c, hexagon_greg_read(env, i));
>> +    }
>> +}
>> +
>> +/*
>> + * Layout: version, the thread number, the CPU mode (HEX_CPU_MODE_*), the TLB
>> + * lock state and count, and the K0 lock state and count.
>> + */
>> +static void fill_thread(NoteCursor *c, const CPUHexagonState *env)
>> +{
>> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
>> +    put_u32(c, env->threadId);
>> +    put_u32(c, get_cpu_mode(env));
>> +    put_u32(c, env->tlb_lock_state);
>> +    put_u32(c, env->tlb_lock_count);
>> +    put_u32(c, env->k0_lock_state);
>> +    put_u32(c, env->k0_lock_count);
>> +}
>> +
>> +/*
>> + * Layout: version, the number of entries and two zeroes, then the entries as
>> + * the 64-bit values that tlbw takes.
>> + */
>> +static void fill_tlb(NoteCursor *c, const CPUHexagonState *env)
>> +{
>> +    HexagonTLBState *tlb = env_archcpu(env)->tlb;
>> +    uint32_t num_entries = hexagon_tlb_get_num_entries(tlb);
>> +
>> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
>> +    put_u32(c, num_entries);
>> +    put_u32(c, 0);
>> +    put_u32(c, 0);
>> +
>> +    for (uint32_t i = 0; i < num_entries; i++) {
>> +        put_u64(c, hexagon_tlb_read(tlb, i));
>> +    }
>> +}
>> +#endif
>> +
>> +static void put_all_notes(NoteCursor *c, const CPUHexagonState *env)
>> +{
>> +    const HexagonCPU *cpu = env_archcpu(env);
>> +
>> +    put_note(c, HEXAGON_NT_CTRL, fill_ctrl, env);
>> +    if (note_hvx_ctx(env) && cpu->cfg.hex_def->hex_version >= HEX_VER_V60) {
>> +        put_note(c, HEXAGON_NT_HVX, fill_hvx, env);
>> +    }
>> +    if (env->hlx_ctx && cpu->cfg.hex_def->hex_version >= HEX_VER_V85) {
>> +        put_note(c, HEXAGON_NT_HLX, fill_hlx, env);
>> +    }
>> +#ifndef CONFIG_USER_ONLY
>> +    put_note(c, HEXAGON_NT_SYSREGS, fill_sysregs, env);
>> +    put_note(c, HEXAGON_NT_THREAD, fill_thread, env);
>> +    put_note(c, HEXAGON_NT_TLB, fill_tlb, env);
>> +#endif
>> +}
>> +
>> +size_t hexagon_core_notes_size(const CPUHexagonState *env)
>> +{
>> +    NoteCursor c = { };
>> +
>> +    put_all_notes(&c, env);
>> +    return c.len;
>> +}
>> +
>> +void hexagon_core_fill_notes(void *buf, const CPUHexagonState *env)
>> +{
>> +    NoteCursor c = { .buf = buf };
>> +
>> +    put_all_notes(&c, env);
>> +}
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index 5f7f22fa2ea..a9e3f93c3c9 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -990,11 +990,11 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
>> }
>>
>> #ifndef CONFIG_USER_ONLY
>> -uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg)
>> +uint32_t hexagon_greg_read(const CPUHexagonState *env, uint32_t reg)
>> {
>>      uint32_t ssr = env->t_sreg[HEX_SREG_SSR];
>>      int ssr_ce = GET_SSR_FIELD(SSR_CE, ssr);
>> -    HexagonCPU *cpu = env_archcpu(env);
>> +    const HexagonCPU *cpu = env_archcpu(env);
>>
>>      if (reg <= HEX_GREG_G3) {
>>          return env->greg[reg];
>> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
>> index b9b2a2d9740..23fa3f65fdb 100644
>> --- a/target/hexagon/meson.build
>> +++ b/target/hexagon/meson.build
>> @@ -292,6 +292,7 @@ hexagon_softmmu_ss = ss.source_set()
>>
>> hexagon_ss.add(files(
>>      'cpu.c',
>> +    'core_notes.c',
>>      'translate.c',
>>      'op_helper.c',
>>      'gdbstub.c',
>> -- 
>> 2.34.1
>>

