Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BC8C021B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpctI-0000c1-C0; Tue, 04 Mar 2025 19:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpct7-0000bM-4i
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:45:29 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpct5-0005IQ-4V
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:45:28 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-474faf23fbeso19387181cf.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741135526; x=1741740326; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qRcmkWgm7tdxqssTsGaC7f1QgJqfUqVZwLzSVzJ9PvY=;
 b=kSAvI6C9QShY0GqKwqjavcDm8KPjAoOoyh+KY+j2w86CKytjDYPOOcu4ZnXXgE2vqg
 sP3UDuHBtvvmzRIIiKQ2fnEz9sR46THVB5eJMwdlZgkm9SfOdhkrMV9UQ6fA5txhMcbk
 m0v1RW7FwAq1dF1PQ8AHwt1zRvHRO6wPXWwJNlupLnpfS2pbt3FirBKM8BIjyD9ttR9I
 CsPBJNz42dEnvxq1jyczAB0Y14Js8CRbv1DnzhVkJzYAA0G+v8dGqB5Y8Xr2E6vqGy5z
 AfyDJfihreapj4PAJ4gAPHbDsw1ExGr5uG0JK8NcnaZGkhJ1KlsTHRhafQlCEJGcseVx
 IdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135526; x=1741740326;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qRcmkWgm7tdxqssTsGaC7f1QgJqfUqVZwLzSVzJ9PvY=;
 b=W+cDWvMNHuV/3FAtPyau5uHU/erReNtuiYFbqxhHAhMPNC/8RqqzccmtXS9XTrxTom
 ZVapALLVIv5WfMrETUPYPMtY/+cx9mPEO/y0xgl4cp7eAMB1VvG5xoonyamxo+NEXGwc
 0eqCHFykstFUf5xgvIR6rmIMo3DSHyIPHaMWc/MpE5LGpZbGvr6pW7vj1oTnvw7LM/Cy
 7YB5WF+po4b8kRO4df03EMJaqo9/2kE2d26BOcGw1fLUZt4fSvzN4vSZaNUM7hJt3H+z
 vk5CjqKRiQ2cfZ5Td/4X9C+I5rMiiUbpN0JTEzXPpWT3C0HyWTQeIo8okkvX7UW2YWqQ
 VpuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwJpo8t1nEinUSz+Rij537oJUgHEFg4QCPgjTh0icPhvgSMM5FRiHKbfDBAhlMAP6CEj4aBFqWiTM3@nongnu.org
X-Gm-Message-State: AOJu0YxFIeJqt+XNswwfgN/h5gKePlkAnynehgd6EUhF2T69gvFjFkWg
 6JTuL7xKhXyQge4Gpl+wuu1IxfFmNkwf3RJUbDg6mcV6t8MLAyuf
X-Gm-Gg: ASbGncvEw7dpr2TnDhUlOqNOu0Ku1NrM9DIjiIQRJ3YhonfRQt/Pre1S3Y5D7h/87Z0
 +5k28zVkwQZfzqmiAzv6kuXRaCn7+0i3R2WQhU3R+58q06tqxii9uS+ArolYyDMrqWoCJTbNfMl
 ElswdqwcVHSQctieVYz7ixkhpz+friCrTWie3omR/5JKpYKPaja6/VJdfEAwmxTfOPHeJN/K7k1
 n8Lll/gUGox+GxbaGsdWlKY1giP5FFXRATwDyXfigwHmo0el2BKE2l/htAGF60nVRjAEi4/xApt
 tyufmD4tsY+FW+GNrCdvrHkPPsyhmL3z0J22Ey6DTAnjGzVKWug6N/LkfjxPUaTeutaJGtmmRQC
 J/SKNIXI=
X-Google-Smtp-Source: AGHT+IE0ZVB5f9n8knGTUnvCf6Y/T9OFvlhjp9hObXuPlzEu/P1WIqqPJodD3fEXnLDH3JmZx9CEZw==
X-Received: by 2002:ac8:5dc8:0:b0:472:5f9:1f71 with SMTP id
 d75a77b69052e-4750b24861dmr18739341cf.2.1741135525740; 
 Tue, 04 Mar 2025 16:45:25 -0800 (PST)
Received: from DESKTOPUU50BPD (syn-174-097-131-055.res.spectrum.com.
 [174.97.131.55]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47472431036sm80983191cf.80.2025.03.04.16.45.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Mar 2025 16:45:24 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@linaro.org>,
 <richard.henderson@linaro.org>,
 "'Brian Cain'" <brian.cain@oss.qualcomm.com>, <qemu-devel@nongnu.org>
Cc: <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-35-brian.cain@oss.qualcomm.com>
 <3329ec67-3bf3-425d-b15c-ba77cd8bcd30@oss.qualcomm.com>
 <014701db8d5a$8a1ad930$9e508b90$@gmail.com>
 <d18103eb-b07e-4017-8c27-6bc8f5585360@linaro.org>
 <016101db8d62$5644ea30$02cebe90$@gmail.com>
 <a9a4ca6e-8908-4360-a44d-c688bb51b134@linaro.org>
In-Reply-To: <a9a4ca6e-8908-4360-a44d-c688bb51b134@linaro.org>
Subject: RE: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
Date: Tue, 4 Mar 2025 18:45:22 -0600
Message-ID: <016701db8d67$e1a3fc10$a4ebf430$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQLrtTt/AcPvtVgCvPo6dgIOVP6gAZ8llVwB3K3HiLKGbe5g
X-Antivirus: Norton (VPS 250304-10, 3/4/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Sent: Tuesday, March 4, 2025 6:19 PM
> To: ltaylorsimpson@gmail.com; richard.henderson@linaro.org; 'Brian =
Cain'
> <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
> Cc: quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; alex.bennee@linaro.org;
> quic_mburton@quicinc.com; sidneym@quicinc.com; 'Brian Cain'
> <bcain@quicinc.com>
> Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
>=20
> On 5/3/25 01:05, ltaylorsimpson@gmail.com wrote:
> >
> >
> >> -----Original Message-----
> >> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Sent: Tuesday, March 4, 2025 5:58 PM
> >> To: richard.henderson@linaro.org; ltaylorsimpson@gmail.com; 'Brian =
Cain'
> >> <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
> >> Cc: quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> >> quic_mliebel@quicinc.com; alex.bennee@linaro.org;
> >> quic_mburton@quicinc.com; sidneym@quicinc.com; 'Brian Cain'
> >> <bcain@quicinc.com>
> >> Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
> >>
> >> Hi Taylor,
> >>
> >> On 5/3/25 00:09, ltaylorsimpson@gmail.com wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
> >>>> Sent: Monday, March 3, 2025 10:24 AM
> >>>> To: qemu-devel@nongnu.org
> >>>> Cc: richard.henderson@linaro.org; philmd@linaro.org;
> >>>> quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> >>>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> >>>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> >>>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> >>>> Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
> >>>>
> >>>>
> >>>> On 2/28/2025 11:28 PM, Brian Cain wrote:
> >>>>> From: Brian Cain <bcain@quicinc.com>
> >>>>>
> >>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >>>>> ---
> >>>>>     target/hexagon/sys_macros.h |   8 +--
> >>>>>     target/hexagon/op_helper.c  | 104
> >>>> ++++++++++++++++++++++++++++++++++++
> >>>>>     2 files changed, 108 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/target/hexagon/sys_macros.h
> >>>>> b/target/hexagon/sys_macros.h index 3c4c3c7aa5..e5dc1ce0ab
> 100644
> >>>>> --- a/target/hexagon/sys_macros.h
> >>>>> +++ b/target/hexagon/sys_macros.h
> >>>>> @@ -143,11 +143,11 @@
> >>>>>     #define fDCINVIDX(REG)
> >>>>>     #define fDCINVA(REG) do { REG =3D REG; } while (0) /* =
Nothing to
> >>>>> do in qemu */
> >>>>>
> >>>>> -#define fSET_TLB_LOCK()       g_assert_not_reached()
> >>>>> -#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
> >>>>> +#define fSET_TLB_LOCK()       hex_tlb_lock(env);
> >>>>> +#define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
> >>>>>
> >>>>> -#define fSET_K0_LOCK()        g_assert_not_reached()
> >>>>> -#define fCLEAR_K0_LOCK()      g_assert_not_reached()
> >>>>> +#define fSET_K0_LOCK()        hex_k0_lock(env);
> >>>>> +#define fCLEAR_K0_LOCK()      hex_k0_unlock(env);
> >>>>>
> >>>>>     #define fTLB_IDXMASK(INDEX) \
> >>>>>         ((INDEX) & (fPOW2_ROUNDUP(fCAST4u(env_archcpu(env)-
> >>>>> num_tlbs)) -
> >>>>> 1)) diff --git a/target/hexagon/op_helper.c
> >>>>> b/target/hexagon/op_helper.c index 702c3dd3c6..f3b14fbf58 100644
> >>>>> --- a/target/hexagon/op_helper.c
> >>>>> +++ b/target/hexagon/op_helper.c
> >>>>> @@ -1184,6 +1184,110 @@ void
> HELPER(modify_ssr)(CPUHexagonState
> >>>> *env, uint32_t new, uint32_t old)
> >>>>>         BQL_LOCK_GUARD();
> >>>>>         hexagon_modify_ssr(env, new, old);
> >>>>>     }
> >>>>> +
> >>>>> +static void hex_k0_lock(CPUHexagonState *env) {
> >>>>> +    BQL_LOCK_GUARD();
> >>>>> +    g_assert((env->k0_lock_count =3D=3D 0) || =
(env->k0_lock_count =3D=3D
> >>>>> +1));
> >>>>> +
> >>>>> +    uint32_t syscfg =3D arch_get_system_reg(env, =
HEX_SREG_SYSCFG);
> >>>
> >>> Minor nit - registers should be target_ulong type.
> >>
> >> Since Hexagon is only implemented using 32-bit registers, is it =
worth
> >> using target_ulong? (I'm trying to foresee heterogeneous =
emulation).
> >>
> >> Richard, any thought on this (whether a target implementing only 32
> >> *or* 64 bits should use target_[u]long).
> >
> > It's just a hedge against the future in case Qualcomm ever builds a =
64-bit
> Hexagon.
>=20
> If there are plan for such future, then this is fine.
> We are worried by maintenance burden, see for microblaze:
> https://lore.kernel.org/qemu-devel/ad364fce-f73d-4dde-b890-
> 0ea86d9c4674@linaro.org/

As I said "minor nit".  I did a search through the code and the =
registers are declared in cpu.h as target_ulong but arch_get_system_reg =
is defined to return uint32_t.  The users of this function have a mix of =
uint32_t and target_ulong.

From a quick read of the thread you pointed out, the problem for =
microblaze is changing the TARGET_LONG_BITS from 64 to 32.  Hexagon =
wouldn't have this problem.

I'm not aware of any plans for a 64-bit Hexagon, so I'll leave it to =
Brian to decide if he thinks the change is worthwhile.

Taylor






