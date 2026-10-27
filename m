Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2C5606A332
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g9m6qEKx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLhoD-0001Fa-IY; Tue, 27 Oct 2026 10:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLhoC-0001FS-Jy
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:05:48 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLhoA-0002gr-SD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:05:48 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ab38a051aaso40742187b3.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793109945; cv=none;
 d=google.com; s=arc-20260327;
 b=LL/45mC/pR89Hs/RW24GM/Qj/SL5WHvCPs/YqtY5VEZwKXUgCa9HNY6f5+TFjM8VJu
 E7C9qEmJfA+bZkBkqsL6UvksdKwPXooUudfSKkCs/2zsuwETc1j6k0T4eiVM3fLm5NBO
 aWKt19dgYdmpN2b+GCzmi+ZZm9quMFEAUipqN8Zm84+02TXuBuwCwcordkcihLI9TsUc
 WYiR925l18QlT8uROob9xgbkFItVNWRQ2ACAfzWpQC/4uTorjPEvk8iW/1V1yhhn3UYO
 dhO+zG4GJwsU8gzD9N2MM01pKqvUP2Q+TR+axhZpJzny/HaqQzFkLuBydOslvg4wYLPp
 EtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mITCXU6OATDwdRda1rwU4D4E/SpXbOaHUNHZq+lbeQ8=;
 fh=UpN4yT9veIj8YnJItnKLyFDX0hc6Wk7Qg6wZp+lnz5Q=;
 b=YSgNfK6YPJhg3oIl7iOIcY1gv5RWo5eH2n9WsWEZw6K3FIUgUYuhEXovbdZ8d9r1px
 zu1CTc6WvjCZBjrPmUNyxze/cxqU/GqByfEMiF/hxNH6PTGMagofFEkmkK9MZzQx/3zG
 QXmdrETIQ8OWkzfeJWAUXhnJdq4/a/l0kFVa3O2mAKufRzAZsr6oupSXyMP5xtYptfTi
 lDEXCoLom/gvo1STA7zbPiwaaPNG2BSLhbelkglgjIsPb+LXd1eJjvvRnYbGr/GjYGrp
 k28u7znLKh6kKa1ast8G6/2S2VUxcPNN4kBH1EpNpDyFEVFETt4sGwvUjqgGAYGJcQfP
 ZjQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793109945; x=1793714745; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mITCXU6OATDwdRda1rwU4D4E/SpXbOaHUNHZq+lbeQ8=;
 b=g9m6qEKxR77tlFHjCMlX2XF/4SdVg26sys/WX+iRRwmX7JyuxVklbwSrABvqmTUQ6E
 C1ibgbid4tuGG6SHfN4BasiixxpcBRY/vnzhT649URq8UdQR5WiSntwLJ9GmMGGZGNjP
 1CeaJJSTFpUCwDL+/MpVZzUv9QC6VVIkBSD6XFMohiQ7MvGAFwhRhEQZsVCmKvQ7AZZH
 mMXAchzagsaKkz6pQ2YtdU23XX/Bh7RyRnLkyGuFCxZiV8auI9Zp6FY4ENYzEs96Ya7a
 y4FleMqW7jhyvx/nv3Mosm78kxHQqfukq0cQ2w1vRaH1sFRw1soJKezyr134DFARlQmA
 M0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109945; x=1793714745;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mITCXU6OATDwdRda1rwU4D4E/SpXbOaHUNHZq+lbeQ8=;
 b=VkatweRK5UgzDBMYJ5mXsSs/b0xNUweJNdthGgBKovoC94DoJ928dT/QQwRetiy9Cl
 xghQHbusizRBgexxGeYOHwGbRvjpiuqGCzcjiHA4pl2kuikr93WGghiTvDoZcaB6b1tj
 /zwDAaphvuCMFvP2oFS3LCb7UKs/0GEthJkVfm5g5ES2DNBUiestWc7IGccR8xQWe0Nt
 LgUrOSladvOMt8mkVUMTjg/yMAebuzv4hjv/plk5XPqtKYIGUZPZLMpSUt33KrUX8Gxh
 B79KhaAN9W6iJkBcpkAXb1U7DnfJjJB8CligfzwMeTVJR/4gr2r1vVk1nG/0IxJjbqtH
 5w4A==
X-Gm-Message-State: AFq9FYJyXvmFBsXbiR3LWeUAVqoJPDcyIhm3WHDmprsf1QreEE2GVUJm
 MlJNoNnZAw0g5t4igBNWd8LaE/U4xL4+4Kq2cnEHqb3JuZapNWhKKcgmQaZv3F/tJAUjdvdo47k
 UwtSsJiL5kkgfgbugYA5+dM2rUsBqpdhwnTEWfJfHcQ==
X-Gm-Gg: AYBFou1CGKuumtx85rh7AnYfYFhX+wVOw8Nkg0TsF8llKZE8LTKMAUXAF8cNLzQXdbL
 GcyvyIHT5XF6NsHTt5YxBI+xg7NzzOv9omfjtCyivHLR21MaKyBR/gBnzOXNJaPLQ5HpsTFZeUS
 BvVwKB/ANVFNVvP0dwTD5hGOKX6RJmkjNvzTV6FhfJpJrkJMjrDXTjK0yvB+5+B8nlTNu29orwM
 KtdW05jueJdxizuWXQULmPFf4W2aVNVlp49Zh1+xDpUMl7XVI2HZEu9PurLVXEUB2+dME/K6DWX
 19bPoPWTUReLMovJVGqNXdk0Vne/lcSt5WsAkDo81ScFR6RGi7o9MaKUaTi7YxYf5XP53Uiv7iG
 8GbSuGkRDO/8exLP+jildn+8E7Xu5Kp+56b97qHg3t+6gizMmjYwg5glTngNzkriSrlupD2clbH
 2iZ5hgum/Fsj647x3peSLF
X-Received: by 2002:a05:690c:60c4:b0:8b0:f0cb:80d9 with SMTP id
 00721157ae682-8b166bd6fb3mr62412367b3.29.1793109944815; Tue, 27 Oct 2026
 07:05:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013195606.152-1-luoyonggang@gmail.com>
 <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
 <CAE2XoE828e76zdCEkYVcbjRwhcsaSYZF1_UE4akeaoCTqCK3zg@mail.gmail.com>
 <baf81ba3-f29f-48f0-a9a2-6dc4f005d433@oss.qualcomm.com>
 <CAE2XoE9L8tuhU2nieJ8D=Cz9svS=W3oqAH+j30RGtZibjp1G=Q@mail.gmail.com>
 <bb979f8e-1372-4be4-814e-aa5dcb09942a@oss.qualcomm.com>
 <CAE2XoE-RcE24+9BNTSUD08QT1ECdbZm464YHiDQ4JJ4xpOE4Ww@mail.gmail.com>
In-Reply-To: <CAE2XoE-RcE24+9BNTSUD08QT1ECdbZm464YHiDQ4JJ4xpOE4Ww@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2026 14:05:33 +0000
X-Gm-Features: AclHuK9CY-_ipwz-3NQKya2rpC51hOk7qCreHJ2vZ5WOtgOf5yDgWjF0eSF73s8
Message-ID: <CAFEAcA_sSTSR-J2p1C-euCsOCr0dCvQ3RJU0fr5pDa5QPKjiig@mail.gmail.com>
Subject: Re: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
To: luoyonggang@gmail.com
Cc: qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 13:06, Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> On Wed, Oct 14, 2026 at 5:37=E2=80=AFAM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >
> > On 10/13/2026 2:30 PM, Yonggang Luo wrote:
> > > On Wed, Oct 14, 2026 at 5:07=E2=80=AFAM Pierrick Bouvier
> > > <pierrick.bouvier@oss.qualcomm.com> wrote:
> > >>
> > >> On 10/13/26 1:19 PM, Yonggang Luo wrote:
> > >>> On Wed, Oct 14, 2026 at 4:08=E2=80=AFAM Pierrick Bouvier
> > >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> > >>>>
> > >>>> On 10/13/2026 12:56 PM, Yonggang Luo wrote:
> > >>>>> This is for avoid "max-v8" qom name conflict in multi-target qemu
> > >>>>>
> > >>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > >>>>> ---
> > >>>>>   target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
> > >>>>>   1 file changed, 13 insertions(+), 4 deletions(-)
> > >>>>>
> > >>>>> diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max=
-v8.c
> > >>>>> index 65f851f2006..d7323ab431c 100644
> > >>>>> --- a/target/arm/tcg/cpu-max-v8.c
> > >>>>> +++ b/target/arm/tcg/cpu-max-v8.c
> > >>>>> @@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
> > >>>>>   #endif
> > >>>>>   }
> > >>>>>
> > >>>>> +static void max_v8_tcg_initfn(Object *obj)
> > >>>>> +{
> > >>>>> +    if (target_aarch64()) {
> > >>>>> +        aarch64_max_v8_tcg_initfn(obj);
> > >>>>> +    } else {
> > >>>>> +        aarch32_max_v8_tcg_initfn(obj);
> > >>>>> +    }
> > >>>>> +}
> > >>>>> +
> > >>>>>   static void cpu_max_v8_register_type(void)
> > >>>>>   {
> > >>>>> -    static const ARMCPUInfo max_v8[2] =3D {
> > >>>>> -        { .name =3D "max-v8", .initfn =3D aarch32_max_v8_tcg_ini=
tfn },
> > >>>>> -        { .name =3D "max-v8", .initfn =3D aarch64_max_v8_tcg_ini=
tfn },
> > >>>>> +    static const ARMCPUInfo max_v8 =3D {
> > >>>>> +        .name =3D "max-v8",
> > >>>>> +        .initfn =3D max_v8_tcg_initfn,
> > >>>>>       };
> > >>>>> -    arm_cpu_register(&max_v8[target_aarch64()]);
> > >>>>> +    arm_cpu_register(&max_v8);
> > >>>>>   }
> > >>>>>   type_init(cpu_max_v8_register_type)
> > >>>>
> > >>>> It works for the current need, but will require further changes fo=
r
> > >>>> heterogeneous emulation. A more versatile solution could be:
> > >>>>
> > >>>> arm_cpu_register(&aarch32_max_v8, target_arm);
> > >>>> arm_cpu_register(&aarch64_max_v8, target_aarch64);
> > >>>
> > >>> And another way to handle it is like x86. it's comes with two varia=
nt for
> > >>>
> > >>> #ifdef TARGET_X86_64
> > >>> #define TYPE_X86_CPU "x86_64-cpu"
> > >>> #else
> > >>> #define TYPE_X86_CPU "i386-cpu"
> > >>> #endif
> > >>>
> > >>> This also solves this issue, which looks more straightforward. no n=
eed
> > >>> .targets magic for CPU.
> > >>> Anyway, maybe the best way is to merge "x86_64-cpu" and "i386-cpu"
> > >>> into a single cpu type and
> > >>> add .targets magic? When I am trying to get x86 works, faced this i=
ssue
> > >>>
> > >>
> > >> This solves including i386 or x86_64, but not including both at the =
same
> > >> time. Same goes for arm vs aarch64.
> > >>
> > >> You can take a look at git history in target/arm, to see which kind =
of
> > >> changes we did to make arm and aarch64 targets linkable. You'll noti=
ce
> > >> most of the work was to remove (a lot of) #ifdef TARGET_X.
> > >
> > > See it
> > > SHA-1: ec7e5a90fea996f04ea24e81b680a87bc975354a
> > > * target/arm: Remove TYPE_AARCH64_CPU
> > >
> > > So I am just doing just the reverse direction, I am fixes x86_64 in a=
 way that
> > > register both "x86_64-cpu" "i386-cpu" variants, though this way seems
> > > more suitable
> > > for your heterogeneous emulation, but we need to register
> > > everything(CPUs) twice.
> >
> > We'll have to register this twice anyway for heterogeneous, I don't see
> > any other solution to have both accessible at the same time. That said,
> > we are not yet there, and current patch solves the actual problem of
> > having QOM types registered twice.
> >
> > I'll let Peter say what he thinks about this.
>
> Hi Peter, what's your suggest about this?

I don't really have a preference here as I haven't been following
the heterogenous work that closely. I'm happy to go with whatever
Pierrick / Philippe think makes sense.

-- PMM

