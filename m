Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E3AC35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 19:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tucOZ-0002tL-N6; Tue, 18 Mar 2025 15:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tucOP-0002rv-IJ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 15:14:25 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tucON-0000xc-Bq
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 15:14:24 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c0155af484so812134685a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742325262; x=1742930062; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/TqXrD8e5v9Cqvqu2y0JFsxZviA4FjWgvUUm/6Z+Up0=;
 b=RSa8U1lSbuSnzUu6v5XybjQoBMwjy6PVYho3MuQ4hNVNxSTJ0dnxDsc9TLherVWWGc
 ik75nBNC4Yhk1yZEu7zdUepxFBVYKvp9GvLZV5GPmhHs7pjpPGRwSv8BObIPXibQibi5
 LbYcNh5DZ2vFnK1kD28aDebU5OVGTlWA4uPFt+Opm3ShgOOvqJGEXKhZvYPToCbZ+4th
 WdII7kK87nSLKbe/EH9miM1RaPq+Jj/Maox1asQWBBoQKYnmnneTQHA63ydX7hyCuQtn
 VjHBRIbbouofGriceGPlrfEc5ftOpYGGGOUU97ZUcgkkuY0gBVr/DkP5wzReCYMjK7+7
 KLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742325262; x=1742930062;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/TqXrD8e5v9Cqvqu2y0JFsxZviA4FjWgvUUm/6Z+Up0=;
 b=Z0Ahr5DBR/8F1fakLM/94maM3d1CfruICQ5tERTgeSKPngGxxGAlqV+NsE+41sc6Ex
 EhJ2oTm1rluBLF0z3L9Z7Y7xIOBpOrkHkxC5A4/MYgZXvHoRoB+vwrVVZ4CgfCA5USFu
 4elM+qXJqNw4+ZjJOrJTMfQV2S0PD34Y/NQd8e3YqxEQlAIAtfQpIO0Yb+Rn0xZBbH6j
 fNXI+2+XRMxEwVQ9yMwxcjWM/Yz0jtFdBDl2dNnTuJNuw/6CN2RK+xQGEwt8JDMs60w2
 5mNDwDBZBIafXmAZR4fQspNZbmycVZXMh+jKaeN92qc+ymL3g5XYiW+2eV2Wg18zjr1Z
 RQkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6JShMoDb0f7vGRuMnlr2+O1WVGodT8JDAGkQGlXQWY18HQ9IqCzWlF8pw4J2hsfQN5bS8/sBNQX6h@nongnu.org
X-Gm-Message-State: AOJu0YycnGwkGGxNe858a5FsRF7BseS4fQF/ZDMVd/IVHTTx5D7gZbM3
 IZcuSxY028dQkp5r44Lw56lLyQcsHC+ewHtAvOHZkfkLyS00bIhM
X-Gm-Gg: ASbGnctw5Od1ORNad6fAoc1BEmUDniM4nxmNH+9P6kJgfq59VjuQl2ZNC0PaBM5SKyR
 n7NEfQFXYnpLuXnhKP6BOxeCwEMG/uv781GURAGW6SRqdwQ6LmH34IhBSQnn3AENO7a5U/sv5aP
 FiXy6oG9ZhqFJtTEazM6k1zr6dzcR0Jk18TfcDP1UDEWzLbLQ/7E3qtzwEe/NkmpMIZwbknxMNl
 nOLy4tk3bissK0F6o/pl0lvbySBuraBDYM8V2/V5V4spmUmmBphVgn6ruApG15h6WP0htIgs4h/
 hJC2suojqRppfx2aj1YhE80j2BHLaftuxnlDY4YtVlKcN2ZHLJCGZJe/EvmvK4M=
X-Google-Smtp-Source: AGHT+IHRO67hktgbwVHfZ1Bcsl+hCfG5FeF4L7EuOsX1YFST1pq8DyeYxD56+MzNxfYCEhC9wkXzEA==
X-Received: by 2002:a05:620a:29d0:b0:7c5:49e8:993b with SMTP id
 af79cd13be357-7c5a69a26c0mr77769785a.56.1742325262154; 
 Tue, 18 Mar 2025 12:14:22 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:6d71:de10:2e5e:506a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c4e8b9sm760637585a.2.2025.03.18.12.14.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Mar 2025 12:14:21 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Sid Manning'" <sidneym@quicinc.com>,
 "'Brian Cain'" <brian.cain@oss.qualcomm.com>, <qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 "'Matheus Bernardino \(QUIC\)'" <quic_mathbern@quicinc.com>, <ale@rev.ng>,
 <anjo@rev.ng>, "'Marco Liebel \(QUIC\)'" <quic_mliebel@quicinc.com>,
 <alex.bennee@linaro.org>,
 "'Mark Burton \(QUIC\)'" <quic_mburton@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-6-brian.cain@oss.qualcomm.com>
 <017101db9763$41ae4ca0$c50ae5e0$@gmail.com>
 <IA0PR02MB94862E1C5171AC300C64DA1CBEDE2@IA0PR02MB9486.namprd02.prod.outlook.com>
In-Reply-To: <IA0PR02MB94862E1C5171AC300C64DA1CBEDE2@IA0PR02MB9486.namprd02.prod.outlook.com>
Subject: RE: [PATCH 05/39] target/hexagon: Implement modify SSR
Date: Tue, 18 Mar 2025 14:14:21 -0500
Message-ID: <026201db9839$f4bb6040$de3220c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQH/in6LAfNOq9wCQ290DLLSFk3g
Content-Language: en-us
X-Antivirus: Norton (VPS 250318-4, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x731.google.com
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
> From: Sid Manning <sidneym@quicinc.com>
> Sent: Tuesday, March 18, 2025 1:34 PM
> To: ltaylorsimpson@gmail.com; 'Brian Cain'
> <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
> Cc: richard.henderson@linaro.org; philmd@linaro.org; Matheus =
Bernardino
> (QUIC) <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng; Marco
> Liebel (QUIC) <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; Mark
> Burton (QUIC) <quic_mburton@quicinc.com>; Brian Cain
> <bcain@quicinc.com>
> Subject: RE: [PATCH 05/39] target/hexagon: Implement modify SSR
>=20
>=20
>=20
> > -----Original Message-----
> > From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> > Sent: Monday, March 17, 2025 12:37 PM
> > To: 'Brian Cain' <brian.cain@oss.qualcomm.com>; qemu-
> devel@nongnu.org
> > Cc: richard.henderson@linaro.org; philmd@linaro.org; Matheus
> > Bernardino
> > (QUIC) <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng; Marco
> > Liebel (QUIC) <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; =
Mark
> > Burton (QUIC) <quic_mburton@quicinc.com>; Sid Manning
> > <sidneym@quicinc.com>; Brian Cain <bcain@quicinc.com>
> > Subject: RE: [PATCH 05/39] target/hexagon: Implement modify SSR
> >
> > > -----Original Message-----
> > > From: Brian Cain <brian.cain@oss.qualcomm.com>
> > > Sent: Friday, February 28, 2025 11:28 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> > > philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng;
> > anjo@rev.ng;
> > > quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> > > alex.bennee@linaro.org; quic_mburton@quicinc.com;
> > sidneym@quicinc.com;
> > > Brian Cain <bcain@quicinc.com>
> > > Subject: [PATCH 05/39] target/hexagon: Implement modify SSR
> > >
> > > From: Brian Cain <bcain@quicinc.com>
> > >
> > > The per-vCPU System Status Register controls many modal behaviors =
of
> > > the system architecture.  When the SSR is updated, we trigger the
> > > necessary effects for interrupts, privilege/MMU, and HVX context
> > mapping.
> > >
> > > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > > ---
> >
> > What does SSR_XE indicate?
> [Sid Manning]
> If SSR:XE isn't set this thread doesn't have the coproc enabled so =
discard
> additional checking.  Any coproc insn issued when ssr:xe is 0 will =
trigger a,
> "Illegal execution of coprocessor instruction." error.



> > > +    if (old_XA !=3D new_XA) {
> > > +        int old_unit =3D parse_context_idx(env, old_XA);
> > > +        int new_unit =3D parse_context_idx(env, new_XA);
> >
> > Check that old_unit !=3D new_unit.  Per the table above, different =
XA values
> > can point to the same unit.  For example, if cpu->hvx_contexts is 2, =
the
> XA=3D0
> > and XA=3D2 both point to context 0.
> >
> > > +
> > > +        /* Ownership exchange */
> > > +        memcpy(VRegs[old_unit], env->VRegs, sizeof(env->VRegs));
> > > +        memcpy(QRegs[old_unit], env->QRegs, sizeof(env->QRegs));
> > > +        memcpy(env->VRegs, VRegs[new_unit], sizeof(env->VRegs));
> > > +        memcpy(env->QRegs, QRegs[new_unit], sizeof(env->QRegs));
> >
> > What does the hardware do?  Does it clear the context, or is that =
the OS'es
> > job?
> Nothing would keep a single htid from taking hvx unit 0, doing some =
hvx-ops
> , swapping to hvx unit 1 doing some more hvx-ops and so on.   We are =
doing
> this because each thread has a private copy of the hvx register state. =
 Since
> HVX units and threads are independent if one thread changes its =
ownership
> from HVX context 0 to HVX context 1 we have to do this copy.  Instead =
of
> memcpy should create a new object that represents the HVX units =
available
> and change env->VRegs/QRegs to point to the one currently owned.
>=20
> Refactoring this will be an improvement.
>=20
>=20
> >
> > If the hardware leaves the context alone, the above should be
> > 1) Copy env->{VQ}Regs to old_unit
> > 2) Copy new_unit to env->{VQ}Regs
> >
> > Should you check SSR_EX before doing these copies?
> >
> > Do you need to do anything when SSR_EX changes?
>=20
> I think you mean SSR:XE before doing the copies.  I think we have to =
do the
> copy here regardless of ssr:xe since a thread could swap ownership, =
update
> ssr:xa, without explicitly having ssr:xe set.  Maybe the OS disables =
SSR:XE
> while changing hvx unit ownership?

Correct.  I meant SSR:XE.

Some refactoring is in order but need to understand the HW behavior more =
specifically.
- What will the HW do if more than one thread claims ownership of the =
same HVX context?
- What happens if a thread claims ownership without setting SSR:XE and =
then sets SSR:XE later?
- What about this example?
    1) Thread 0 claims context 1 and sets SSR:XE
    2) Thread 0 does some HVX computation
    3) Thread 0 is done with HVX for now so clears SSR:XE
    4) Thread 1 claims context 1 and sets SSR:XE, does some work, then =
clears SSR:XE
    5) Thread 0 wants to do more HVX, so it sets SSR:XE (still pointing =
to HVX context 1)

We should keep the copies for the contexts and local copies inside =
CPUHexagonState.  This makes TCG generation easier as well as having =
common code between system mode and linux-user mode.

Also, since check_overcommitted_hvx only prints a log message, add an =
early exit if LOG_GUEST_ERROR is off.

Thanks,
Taylor



