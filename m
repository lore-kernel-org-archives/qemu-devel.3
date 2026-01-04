Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276E1C2A06C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 10:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcKy7-0001Mg-DR; Sun, 04 Jan 2026 05:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vcKy4-0001Lx-Ll
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 05:04:13 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vcKy2-0002r9-L8
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 05:04:12 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b73161849e1so2529241466b.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 02:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767521049; x=1768125849; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIOgTLTlArMoYG4W37E7sIEkKdpilICBovaYe6SFdaY=;
 b=GjsheZDucaH2IJqGEU+36rQE1lbdfOfTBF6xCw39a6Wqy4UTm2oh1zqUjyV3fwLZgl
 nKV7ksO7OcH4z960coiOe5aow5odGAYj12iMz3/rUELxWhRXKtGRu/isgC2VyOjY+NhL
 cnTdD1c0SvYcxLMQE0uvfB7fpbLkYa78YPSkECs6f+8IwISOvpoCJMax7/ZwQczVJQ4r
 PcJOERih+lqodHMrJs9q9JKIvR3pxn3fTEZM9PMPRmpho3CfDEeNeGP6+NGud+QtcIzN
 wjRw32ltpheW4EP9CPjsHmhMhSZmwmw9neKr0aEYDOaRNbk8mkWSGnPFNZc29rlBrInO
 FwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767521049; x=1768125849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FIOgTLTlArMoYG4W37E7sIEkKdpilICBovaYe6SFdaY=;
 b=ibZOphxJCQ6EVH2ESNQciFC1nCq+Lr5HfaW3+w4TwE9vHRFkz6kdlsOwL6P9P0CbmX
 jHdK5KsGBEUbcV36PHH/WdSznzfp4sXOvUHHcs3Vuvd/NodhlkuXnsAKo03e+tNiQlHV
 dtk/7p+8NcqPZ7PZxIIYxVGmPIiY792fQuDHhweYOPfkNauPvv/lazvFkk9l3Sd+uqBt
 agVYSrIjETRc9nXLKah2DWMsY0cGiu5FlLEU0UlKPR006Vj07jOdWQg/TmDVyx/Cl/5a
 u4v9gINPTAOlnSSa8BMpdWZW9hlsrBng5OPiQLFXQeU4XInlI3giRUcyR6hKK4YoF5h1
 CklQ==
X-Gm-Message-State: AOJu0YwXuaPBMP5ZkdSJCq9YgFIyMnyYM/iSSv7bqIDmMefZ3Ji8zFQZ
 HRKBSUSdshiemBGPPjgHwmMIST/EjeNsN6fp5mvOPR8k1ZgRDzf/7V27FYDzdZpf5AB9HSz8X8F
 m24rXfdXhPGa3Uu6xr3nGgpjXhI4tQUWIUr4yXnbigw==
X-Gm-Gg: AY/fxX7bzTSugZExq5u7NVzJS2ZF2aFoyWty+EzgnvkOaM972HsmWbZN807byhR+/AN
 I7U7Vr5YBE630TyGQPq96TX9xRAbwZ37/F4Pu7QyJbflARy0HDqj1HALezsw7k9oiMugDhotnqS
 JT7k4pdhtHHtYfnRQxqjtXv1JRxreCT+6i33qsh43nTLx4e2ENh96FS4+oIhWa81ukyO2ghglYx
 9xbGFI36vS6RwANmDIWSgZxWHlgN8J5EXWHL1y2NVlt8pzBYBM80Gf5wkxt9PVHOUL6RWc+Uwij
 V/ATnRmDPHoZfrIN049S7JRCrf+5k2Dt8wkZLA==
X-Google-Smtp-Source: AGHT+IFbk5rzeop8ibbBX+o/oiC1AAEDqUaUhiWN9q/6HdZ7GSNhdZz8SgryszHoR1bexv5GU8clxmOFG06BAB2g7Lw=
X-Received: by 2002:a17:907:268c:b0:b79:e4db:2e9 with SMTP id
 a640c23a62f3a-b80371f8c2emr4873364166b.60.1767521048752; Sun, 04 Jan 2026
 02:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-8-pierrick.bouvier@linaro.org>
 <t8ahil.2ih2pjydhjsas@linaro.org>
 <c17de286-f432-426b-b181-06cd7a8edc55@linaro.org>
In-Reply-To: <c17de286-f432-426b-b181-06cd7a8edc55@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sun, 4 Jan 2026 12:03:41 +0200
X-Gm-Features: AQt7F2oPiUwxwpXLcqxnvK2D72TOLX5NxScatqAujogeY_42OgmfuIoxl6LaQzk
Message-ID: <CAAjaMXZAs8DpyE5FanhwTq_EBi80vT=mc+axOHUhQbqm_EKJCg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] meson: fix supported compiler arguments in other
 languages than C
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Gustavo Bueno Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud_=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang_=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Sat, Jan 3, 2026 at 10:39=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 1/3/26 4:54 AM, Manos Pitsidianakis wrote:
> > On Fri, 02 Jan 2026 23:47, Pierrick Bouvier <pierrick.bouvier@linaro.or=
g> wrote:
> >> qemu_common_flags are only checked for c compiler, even though they
> >> are applied to c++ and objc. This is a problem when C compiler is gcc,
> >> and C++ compiler is clang, creating a possible mismatch.
> >>
> >> One concrete example is option -fzero-call-used-regs=3Dused-gpr with
> >> ubuntu2204 container, which is supported by gcc, but not by clang, thu=
s
> >> leading to a failure when compiling a C++ TCG plugin.
> >>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> ---
> >> meson.build | 17 +++++++++--------
> >> 1 file changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/meson.build b/meson.build
> >> index a8fd8e88225..256cc0cdb21 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -709,10 +709,7 @@ if cc.compiles('extern struct { void (*cb)(void);=
 } s; void f(void) { s.cb(); }'
> >>      hardening_flags +=3D '-fzero-call-used-regs=3Dused-gpr'
> >> endif
> >>
> >> -qemu_common_flags +=3D cc.get_supported_arguments(hardening_flags)
> >> -
> >> -add_global_arguments(qemu_common_flags, native: false, language: all_=
languages)
> >> -add_global_link_arguments(qemu_ldflags, native: false, language: all_=
languages)
> >> +qemu_common_flags +=3D hardening_flags
> >>
> >> # Collect warning flags we want to set, sorted alphabetically
> >> warn_flags =3D [
> >> @@ -771,15 +768,19 @@ if 'cpp' in all_languages
> >>    qemu_cxxflags =3D ['-D__STDC_LIMIT_MACROS', '-D__STDC_CONSTANT_MACR=
OS', '-D__STDC_FORMAT_MACROS'] + qemu_cflags
> >> endif
> >>
> >> -add_project_arguments(qemu_cflags, native: false, language: 'c')
> >> -add_project_arguments(cc.get_supported_arguments(warn_flags), native:=
 false, language: 'c')
> >> +add_project_arguments(cc.get_supported_arguments(qemu_common_flags + =
qemu_cflags + warn_flags),
> >> +                      native: false, language: 'c')
> >> +add_global_link_arguments(qemu_ldflags, native: false, language: all_=
languages)
> >> +
> >> if 'cpp' in all_languages
> >> -  add_project_arguments(qemu_cxxflags, native: false, language: 'cpp'=
)
> >> +  add_project_arguments(cxx.get_supported_arguments(qemu_common_flags=
 + qemu_cxxflags),
> >> +                        native: false, language: 'cpp')
> >
> > This is a subtle behavior change (qemu_cxxflags wasn't filtered through
> > cxx.get_supported_arguments previously). Do we care about this?
> >
>
> Sames goes for qemu_c_flags that we now filter also and we applied
> directly before. The goal is to have the same code layout in meson.build
> between the three languages for code clarity.
> My argument for this and qemu_cxxflags is that it should be equivalent,
> and if it's not, it should have been raised previously with an
> unsupported argument warning at compile time anyway.
>
> By curiousity, looking at meson source, has_argument is implemented by
> compiling a file with the given flag, which is equivalent to what we do
> manually. It has different implementations per language: grep
> has_multi_arguments.
>
> Thanks,
> Pierrick

Good enough for me

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

