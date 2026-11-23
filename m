Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83148606A339
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gWHJFI2b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUEn-0002D7-VJ; Mon, 23 Nov 2026 08:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVUEl-0002AC-SM
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:37:39 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVUEj-0001Lo-Uh
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:37:39 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67921b515a7so3370363d50.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:37:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795441056; cv=none;
 d=google.com; s=arc-20260327;
 b=Uu83m7zlJm9U46Npwt6cklDEzY7tk5KgWIvhFDWGziTnyDxic5lVWD9t+OrnglWEot
 sEDRZ+4Js/LqBBvvW4h7n74TfFQ05uU3GCZa4AEsmRGl4mkt/xUmxoALCJLKM3KVeB2z
 GhDWpYeeC0DEMKvSK6CIqiHi3zW0rmCSCAmz2ZBd1eJ0rH/oX04kbNy4iBP18VK+ePg+
 VPYTOKnjcBVKVSNdJPmZpg8ejytBE6ryV0zpGwLPC0Z6ImokrV44eIyjDwYyrxF/6mxu
 TRHxtgW+oO73o7GwDveXWATeSrPKffJ2zzg2M5+p80lPOrXfkhP95pvYQ3LMsaMmBuaZ
 I/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4KR7T+DaZA9hkDETt2lUk/f5nZKGhFOgN8UqDfQ1AZI=;
 fh=B1nVdZnJxaMTMpK80f+XKedIUSFHs8aQPN0adri8zVk=;
 b=qOa+73nabFEgVtcAaxtP8XoIgBRwa/fFRj5O2RNCP5xnI7NpmDbO9nj3utXmNIX4zM
 hbnhGtbIc+/vCB4PHX2AwRrFe2iktFQl4QTc+mwtDVcLBpCxrOpFX5Mjz0XolbVC2EZK
 rNdm6fmEjY3qXbAlpJy0XIPNFa/KV/ekaQ9JKJBH5bX1VyH0liQ52S+K1Uhh/X31l5kD
 ar22GCr7UfXrw5zkwFQ9StHhxKMF6X6iE1SrrCy1a3w/5k3SmPfoXtYxpjPCCK61MYob
 6dsDRd9oOgshY/jwlA96AbaMcQIHBM4OZfYc0YkXLhFkiTUe0foTlEIvzFcifeyPP8nI
 tqMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795441056; x=1796045856; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4KR7T+DaZA9hkDETt2lUk/f5nZKGhFOgN8UqDfQ1AZI=;
 b=gWHJFI2bVYmavAjfIuJWHCveez+7DTSWARUr7JnL7o1vivjsBBZbeuq6vhoyDKEhx2
 5HnSVwxaVbo3Mw0teVU+saJPJprLk8/Nf971F+EDYsN6TVn0p1c6Bx0G+QH4KkO2oE8G
 bBLQeutlSs0kQ1rTcP191gHvMtBODxreo2xWy3eGRHNsTCHVgCWviyI6QT06dGWarjTs
 6nSvHbIMegHyQD4o/NZoTuOjgFybMJEOthyP+V8wvUzdUgPd9WteX/fsP51ApRJ7cbfu
 fQxyyMHpdMNxBXfwkWFFEpRPtXBebUyeou4/lrs6ESeBVbqo8AVit1rV4+l+yI0qQyrG
 jIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795441056; x=1796045856;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4KR7T+DaZA9hkDETt2lUk/f5nZKGhFOgN8UqDfQ1AZI=;
 b=DjNee4ETUqBGn6NIfzW9uNbTmc6Jc+6GJDdGdP5EWiPY/BXNopL9aoZiu561WjmlAB
 AwWxxaBL2qR5C+LNVLNghP5veKXEx2/4wlMTZmHatBSLr8dOeqnbf++FjOy0hsNzPL2k
 eVlmUn8osJbUVR8Ry0tYaMwuwbgDK+o9GWCrvw0Tj3KAcrp/5XeBLC+eOAVVigGhOim5
 WtfCyoUuK0v93DeE38yMyLLTuu9F+u19uhb6DcMIS0KzuMGXYXx2EatzuHznZq9e/ttW
 eN5FVlyjD1N3USDu3xFsyDm0kgN3yBpm3wQqphX2M2N/Xj2beO+7+jmbI1r8Ro+5wGiE
 51Sw==
X-Forwarded-Encrypted: i=1;
 AL+hErF4wMYGvL6ceC3FYVxrRTP+aJLpPlOmEdBzLsLActJEB2IMNRr0DOitoNgou134kKiukTfRXqAFHF5k@nongnu.org
X-Gm-Message-State: APuU4Z82yA80cDoJxR6snUub54WphBvGN+bonPMnAFbzTbm3bL0Vn+6D
 2VWH2Ayvaiwhj6dbTDqJNEslmi3ExuxJ8oaZF+2LGR4woKeS8cZZvt5wCtk2IvAd4q+7xDFwM+G
 r1bAN2jjhRdW5b3lWiIXfUQdLW+VS7Ic6z089yLP03Q==
X-Gm-Gg: AZFdTZc1bB3VLhwRIaIQhru3HUBFRb8xQXUBTcFq0JJZUdjiwPvAlwNs6QvrJrXwr97
 v1fdatRmiyuHeFgYnKzVBvCe19q1ZCmuP40xD7Yd6oGavw9OUSt4e+t1V4XKOBavwJFCCJzVuII
 rNnJJ9wF1v9M2/pGzYp7vMllCVzjq6g8QdvsC0Nee92TLKtTiXJugMCCrwEfAZ+s7xluDPiX66z
 YWOhhW8SG+liKpzdYomn5/54sIID2KATxYTHB0gwBUt528feHLoaTwAhDqVLbQzjtDlDSAUz6TS
 VWGs5p0/ZvbJpUmokdNLZMLOyOj48t0Z3HO5yuB8nyXKcGUoBItVX73gNq+xAWSo5X0uXgg3G+9
 F9O/jE8RjCeWq8KlVdkJar3xUdWYdnQ4thCwbtlrn4aWWySgSRjZk82epYZaHV/UfsTIeE1PE6X
 sK03AzfGSVFvzQUPIoypzj
X-Received: by 2002:a05:690e:1c1a:b0:67d:bc6d:a4f0 with SMTP id
 956f58d0204a3-67df43cf2a4mr4898537d50.23.1795441056388; Mon, 23 Nov 2026
 05:37:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165546.3050013-1-peter.maydell@linaro.org>
 <awQ-vnYjY8BEAdFi@linaro.org>
In-Reply-To: <awQ-vnYjY8BEAdFi@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 13:37:24 +0000
X-Gm-Features: Aa3M54ozPfJrsImcufVrU5GEVI-9eKkCGo-EwixlTJzMf1AzRtj23n8cjYPXAFQ
Message-ID: <CAFEAcA-j1tady8pueaLqrWEj5La74qsaU6hmGoergbxM1cfq2g@mail.gmail.com>
Subject: Re: [PATCH for-11.2] target/arm: Handle "PMU disabled" in migration
 validate functions
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 23 Nov 2026 at 13:25, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>
> On Thu, Nov 19, 2026 at 04:55:46PM +0000, Peter Maydell wrote:
> > In various test functions for VMSTATE_VALIDATE() fields, we check
> > whether the migrated region number register is within bounds (i.e.
> > less than the total number of configured regions).  These tests fail
> > spuriously if there are zero configured regions, because then "x <
> > cpu->pmsav7_dregion" is always false.
> >
> > When we allowed v6M CPUs to have PMSAv7 in commit 157f6c69edd06, this
> > exposed a bug, because we now have a CPU which has PMSAv7 according
> > to the pmsav7_needed() function but which is configured with 0 PMSA
> > regions: the Cortex-M0.
> >
> > We could fix this by having pmsav7_needed() return false if there
> > are 0 regions; however, the cpu/m-security vmstate struct does
> > migration of the secure equivalents of these fields, and we also do
> > a VMSTATE_VALIDATE that checks against the number of MPU regions
> > there. Making those fields be migrated only if there is more than
> > one region would be awkward (we'd need to pull them out into their
> > own vmstate struct), and it's unnecessary -- migrating something
> > that's all zeroes and not used isn't a problem.
> >
> > So instead we relax the checks to handle the "no configured regions"
> > case, insisting then that the rnr field in the CPU state (which
> > should never be used) is zero.
> >
> > Similarly, we adjust the check in sau_rnr_vmstate_validate against
> > sau_sregion; this one is currently theoretical as all our CPUs which
> > implement the Security Extension have at least one SAU region, but
> > architecturally it is permitted to implemnt no SAU regions.
> >
> > Fixes: 157f6c69edd06 ("target/arm: extend PMSAv7 support to v6-M CPUs")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/arm/machine.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/arm/machine.c b/target/arm/machine.c
> > index c3aef3f3301..d624425c0dd 100644
> > --- a/target/arm/machine.c
> > +++ b/target/arm/machine.c
> > @@ -593,7 +593,8 @@ static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_id)
> >  {
> >      ARMCPU *cpu = opaque;
> >
> > -    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion;
> > +    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion ||
> > +        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_NS] == 0);
> >  }
> >
> >  static const VMStateDescription vmstate_pmsav7 = {
> > @@ -693,14 +694,16 @@ static bool s_rnr_vmstate_validate(void *opaque, int version_id)
> >  {
> >      ARMCPU *cpu = opaque;
> >
> > -    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion;
> > +    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion ||
> > +        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_NS] == 0);
> >  }
> >
> >  static bool sau_rnr_vmstate_validate(void *opaque, int version_id)
> >  {
> >      ARMCPU *cpu = opaque;
> >
> > -    return cpu->env.sau.rnr < cpu->sau_sregion;
> > +    return cpu->env.sau.rnr < cpu->sau_sregion ||
> > +        (cpu->sau_sregion == 0 && cpu->env.sau.rnr == 0);
> >  }
> >
> >  static bool m_security_needed(void *opaque)
> > --
> > 2.43.0
> >
> >
>
> The logic makes sense; it would be nice to have a comment in there explaining
> that RNR==0 indicates an unused value rather than a genuine region numbered
> 0, but I'm OK with this being applied as is.

Yeah, that's reasonable. Something like:

/*
 * field is migrated even when MPU not present: in that case number
 * of regions is 0 and the field is RAZ/WI and also 0
 */

?

thanks
-- PMM

