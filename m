Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C87606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oE/U4i8d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKClA-0005fJ-4R; Fri, 23 Oct 2026 06:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCl8-0005ev-LX
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:44:26 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCl7-0007cu-4e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:44:26 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so776385d50.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 03:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792752263; cv=none;
 d=google.com; s=arc-20260327;
 b=KQw3kXmsGtykeVw/IYGWAFqJcZYriHDHC3yAkKyjPn7ab+qoEzbE7Ibq7lTexm3Cck
 K108q43FPJu9HraWBGDPUTA/2E9ECmk/po3jx2qPyQPxaXinE5tRwQEtRfJEFvfp8/JY
 22dQTan1kmHG9uJKs/fFkNxfggiNeysUlm+lboD1hv6chWXPCdTwOSyCxhaa6ZcRByKa
 kEdREPrxDM8EEPQ6MH3iZ0/5UQxNumXetBbe5eJ31sDHWKGjuvdo+JGZKIa8mKt5IcNX
 BG8nBJbQbq/Ox32zVbbx6f8gRRyBf2FysZlAto5LEJ+ApHHsRvDJkUOthLahd9EHJMuJ
 OTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YwDynXbubrsnB//QPwihYT13q3bWFIVb5k1PLlq0B6g=;
 fh=xttyUwx8A+4xzwpDZGqr9mN9MI8Gfom1DxmyOSKfwWo=;
 b=O8SskHYfFSoVG1WEejCVd1RZNd/F+lPvXKZHUSt56Q0EJQuIeiOtMXJKqf6H3RL7Rl
 KD8xLHJ7BvuUAawkSLJYMrlz3Xn1iWU+0ojUlKol/NTNE/jOeesLtiZe6Issla1Q6Jfp
 xl+JdP0RlNEo+w/PnLK1sF55lhwEONGxqB50Jd5tm7zHRlF1sTmiELjFin5KTvpWfgNL
 iVMIM531j2h3K+SQRY9EwfLXoZDB+U1CsUyYHj9P4Y0URbrLHrq0Yk4aTrh3UIbFUyUY
 W892X9dOcRaLMOXg031RALsWryCzff1gCmPQkr1yuKyEBjLfc4rpBqbj320+P8DeL/ST
 xiRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792752263; x=1793357063; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YwDynXbubrsnB//QPwihYT13q3bWFIVb5k1PLlq0B6g=;
 b=oE/U4i8dtQQn1k6Mq0wf5j+8gbdjrrvFfqySdACq+Pb6xZTKXJPHPmEqrZUD1D6IGn
 EfjGdw2Yh3/DuCZPTaVggVcLpG+D8/GtYs30RUwdY3J/A7ORiDMROOGFtbQ8js1vCjyV
 QOkLEtvuYeKJdgwxVsuulnMH5gQ/dAfkcKTdesAzhZKMy1zYI//qtORWFtcJjx4qiHSN
 3zIUPQlBRBwNOuh8Bg8IPfvikzkdUWktpL61NfQYA8UHzeZekLOBUXMwz2XaaV7acMq5
 H7jM9i87DaRhucD39uoZTo1DVm4Q7P60FulJecLcCDoBe3MxJ4pq7mCx3SpI+4xinCp8
 nAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792752263; x=1793357063;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YwDynXbubrsnB//QPwihYT13q3bWFIVb5k1PLlq0B6g=;
 b=rBcDqbrWqAm0PvPzC4mdfLVm7VsqQVgYD0IVaMcH3bJpwwEX8hui2Wg9jFS8pt7TVO
 HHLNHvV23hQ2oo12WZZIHTchB8+5o5cOIocnFI41h1hNsnJd/hgvhq4SwrZwQh14+yFr
 vP1ZVmFwjmJyL6txPZPASbTQyakjBTOtb0euBSrtd/2OytFAwQqq0WTmcdh1WNe9eYVn
 X48P1DBgd6rMbMwgPXbw8YCZnhh1VF5K9MQszdz92PFZ7uXw2ggChrQHMNGKhi9zg7XJ
 1hsLa+47g0r6uGde6uQezt+LA0kQ/l/hZTN2w0rbbGMvxu3GpfL0EMoqcCGFWsGvhBRu
 aOAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDNQXon2KbnJje7J+jcy1/ig75lzcTyHtkEKLEbZ4N99Wn0QUV1MKy1aghEzp71xtb/iYtCG9uM3Qd@nongnu.org
X-Gm-Message-State: AFq9FYLt+qYO4GblYRvXpY2hPm/YZiB85h3dxJsRK7Pq69j8qSIovH+2
 6oQbbVJ1+nk/5ZveMKwMhLIpjchX+ZbRFANEPB0GFuBbV+CLG4zfRoQh3RaacSvbBCkRQws4ZPm
 K00cNgXugNoj48cPnxckz35Sqzbo4KBq/0yDxjahY+A==
X-Gm-Gg: AYBFou0Idbqj3PdgD5A5eN6GOCtH5CZl9k1lHeOAOAoNhRG9+atvHmRt4qYnu6x/2+R
 gArV51kuuh5/OoHy4Z4yBdJ8HE3MbYhc1wj8l/sv+5sqI+NjKLZhPOvKdeYc5vRPq5eR8h90ByT
 luD9J08MC4VXmOn70A9ylbRuSehZPaCx+5+85pI7JjBds/mjO97ywSVRSj666IeU6fH900sSjzZ
 +NCTzRF1HsqbGLXOls0QsmvCMBpj0js0WAraEk6uJhQ4SX+uDRKQ7stf0oWxlRrw+rRYSM+DgVa
 L7EDRwB4Rplh7VVczOqr+K6nJDXw/NwWLgToC9xut8osLzzgrKRIcFPvQK4wvx0n7+Qdp7yNwhy
 YSXunhhPgVjoV204B+/n6Km/g9U4EfCchaJ6HOl87ptOZCUjG8d6wSqb4eYpO8P1uxU8JclUcKt
 8kWHAa5WVrCL2Mkt0g7eyy
X-Received: by 2002:a05:690c:e1c3:20b0:8ab:36df:344e with SMTP id
 00721157ae682-8b157e92a1fmr9571877b3.91.1792752263250; Fri, 23 Oct 2026
 03:44:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
In-Reply-To: <ats0_RfeVugAofN9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 11:44:10 +0100
X-Gm-Features: AclHuK99xxm49yWp2_LuxHlHPJZvJ_IPR3TIQ_GVCWJ0f042pif4HqmJxnc9yEY
Message-ID: <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc,
 but not memory-backend-epc
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 11:21, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Oct 22, 2026 at 02:58:16PM +0200, Markus Armbruster wrote:
> > My build of qemu-system-x86_64 has device sgx-epc:
> >
> >  --> {"execute": "qom-list-types", "arguments": {"implements": "sgx-epc=
"}}
> >  <-- {"return": [{"name": "sgx-epc", "parent": "device"}]}
> >
> > The device as a link property to a memory-backend-epc:
> >
> >  --> {"execute": "qom-list-properties", "arguments": {"typename": "sgx-=
epc"}}
> >  <-- {"return": [...
> >                  {"name": "memdev", "type": "link<memory-backend-epc>"}=
,
> >                  ...]}
> >
> > However, type memory-backend-epc does not exist:

> There is some rather dubious code that conditionally registers
> the type
>
> static void register_types(void)
> {
>     int fd =3D qemu_open_old("/dev/sgx_vepc", O_RDWR);
>     if (fd >=3D 0) {
>         close(fd);
>
>         type_register_static(&sgx_epc_backed_info);
>     }
> }
>
>
> Normal practice is for types to be unconditionally registered.  Do we
> have any examples outside of this SGX case where we conditionally
> register types ?   Should we change this to follow normal practice ?

TYPE_MEMORY_BACKEND_MEMFD does the same. I did a quick grep for
"calls to type_register not indented by exactly 4 spaces" and
I think the other cases are "misindented" or "data-driven
type registration" rather than trying to do things conditionally
(but I didn't actually look at all of them, instead making
guesses based on variable names, so maybe there's one or two
more I missed).

I guess maybe this is trying to work around the fact that the
memory backend API doesn't give a backend any place to say
"this is never going to work" early, because instance_init isn't
allowed to fail, these objects aren't TYPE_DEVICE so they
don't have "realize", and so the only other option is
"fail every alloc call" ?

thanks
-- PMM

