Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F20606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KCZ0J1iE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkXr-0007bu-K7; Fri, 30 Oct 2026 07:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMkXn-0007az-Os
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:13:11 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMkXl-00020m-OA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:13:11 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b0a921ee46so4729417b3.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793358788; cv=none;
 d=google.com; s=arc-20260327;
 b=GRu83aoh+SSqi6yG7DOxdjGwJsEvDRSFPxgMNWP9Zxp3lOmamu09T8qDB/zOYueEpm
 p5a9QiP0IWToe52UYeBLez2xw7ktRaTtOMDQCRj/3JT1L/1q3sG2MXfhHm9iuf0Mb6T2
 9/Gh9Mnb5/Bk187dvEQZk1fw7RtCNTdopEcdGDpENPnQ9Oi6BoaQh73cs4gAHn+K6C0C
 ip2FbPfxDIrRlbn2qsNxaovlqIU33C/j0m+KC6tZ9ySsQSgmXS6XuIVx5ZC7DEPDOSdM
 J9FzgRRA3I/pC4gpgUKxDo/ojWcTYFfQZEhaI9cpkQFUiCU7neX2sCaYXwCjVRnUTMjW
 JhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5LUWZT5k5KvOS94ligsCtD+U9+DDcG+IL6eyG0y0saE=;
 fh=mSQ2SGCvAeOoR5NRpcBFMP9XsvBvRSbybj32rgJxZHs=;
 b=V2i8uv2MV22RGGOoilgvLBCYqkE+V8WZeuPGHIq0+hQMs5FCg5gNm/QIYft3+twhBd
 DF7pCKDfjwJSFLGyYAsYXk+lq4PJfUycET8vMlT4weMdHi3v6OBJDgYF6JAabTgQ5AVs
 GclGTMex5ABKffgbnJZ9CIUL02jycuckf7bQ52etVx74l3R+TVC+7GVEl33eTjJGnQ4G
 JaqUf8y3tniOsynFXb0esCIG4VkjaRgNQLViW37EUo1fueyTA+sMQRiM2l9Mgqt0kxUG
 hBndCUOEeCZvWuj85+fVjLK29NsRZd8QyXbpaE+tFXwlwhjAUjxrzeHhzsXGVF74VmsM
 zwiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793358788; x=1793963588; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5LUWZT5k5KvOS94ligsCtD+U9+DDcG+IL6eyG0y0saE=;
 b=KCZ0J1iEBmI8J5U6EdjfsvTCeKYjYKMqbztHR6fmahYWSDbfk7V/m+UXiO5TDW3cjB
 v/j6f3cKu2fJ9PypEpP2mzaraqvQe7HDKabCHoJv57/bl+1J0gysIid+bzK5RgKPjAoG
 LQivShEZB77UQGiEuJfYTl4RpYocmqcaoTKtqeNexC5JW+MLG+86LEGUQ47gtHcu10QM
 PBViE69S+DQMAaj6SItPJ2oJrjSSexYCiNnS57QXp6Q59KvepYo6G5k9s4g1yevcxdVs
 wFfoU01+RRuFoXO3SPxCBsnt4BelVxHk8FzFaBROM7WRIcf0BjPqWYifyaSZd8SIHPwK
 ouLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793358788; x=1793963588;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5LUWZT5k5KvOS94ligsCtD+U9+DDcG+IL6eyG0y0saE=;
 b=eb7qF4MWaCEDiJ94/bsDYGTQvfqLrKu+EJ2erR0dM05BIGUIwoX8sPjznGyvG31XNt
 L+JhjanZBM+Kn5igrXQ0ZpKdlza1DJDrLvDV6tMnMv1sDarviAhtrA9PdsSjApJMMICm
 tSajOPLzdFuOm7HQOY6WyPb486padgaEijQwjD2w4utEafbIILuSHp42EWPkh7LSCvfE
 56qtTJI7/we7/bj/DKPMvXRZzi+azjMYbQ6vUBWwA7E1ARB1xpNjlDtNxTpLI+ZYO96T
 JSward2ag8ri0DotrRwL0ixMy9pnnRetPMwlwVnRNS/NnBKCKk3EeeQZ4AHqzf6vRKyP
 ih3w==
X-Gm-Message-State: AFq9FYLfgPKYA5fMWs7MFoMo9nObNzt8q9XaWXhU/G0uxTVQapvv7E1Y
 RNGhaKX7z7RUTH++19d0HheHyaom+PiZejv/7CaIQ0+Seek/ju6cHg9Q5mwh+vnD3QSIq/M8nTF
 23abFCOUxcs2H/eUWvL6Lq26QbndzJN9y8QVIZlAkBw==
X-Gm-Gg: AYBFou2ATI/PUeYBsd70KX77UozARXqxsKzhVuhldtAjKg9qtPtGiUH62lxjzasrK5t
 I3MlCnEBszKRa7pC6Ho+/Cz+JdGFskHc4g8kyCg+Y/IlnYl+Tn0ekmRjdDuAONDIiTkgKy5O6zH
 WCwmP7AuiSH1okaCcCk4hP/iQFaHM+DjtNEi3JloSd5r+RMzwCUy9LU6QF/fj2jMLiGK/pfxDT2
 eHbjoD6vNLRkexAvlSqf9UOdihhVVkNk2sbEe0x9a3JknYmDukOgaCp3wcFYnWTNXokOLq35nd1
 P32AOpX34rds4XUQ9bd1kJiA2GzM2I8yHxqYhVBDryFTydD5BGKuaJMZlAbLouaUPHAgV7FEumB
 q080kMM6UKAo6RxwPi0mmEPASRc5WPIU8xjX/YCcKINiHJmfJoy+pQEEbjmSkaHI6bUShOyDxfm
 WOWw81ZTXIQWnTKU78x99EPg==
X-Received: by 2002:a05:690c:e1d9:10b0:8b0:f0cc:db0e with SMTP id
 00721157ae682-8b2b676ba6fmr7498147b3.78.1793358788267; Fri, 30 Oct 2026
 04:13:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-10-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-10-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2026 11:12:55 +0000
X-Gm-Features: AclHuK8tWRtaAMh4OSG81o0Myk5Bd8TN4g8UgRz9NIr2z73xVEtamgvTgzkRr-c
Message-ID: <CAFEAcA8GwF=EdaqvO7OBNZY1ku8LWNH5giveZYXSVnmk9JWfng@mail.gmail.com>
Subject: Re: [PATCH 09/28] hw/net: mark e1000, e1000e, IGB, rtl8139 & sPAPR
 VLAN as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 11 Sept 2026 at 15:42, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> Historically most NICs are only interesting for non-virtualization
> use cases and have not been written with malicious guests in mind.
>
> As a general rule either virtio-net or xen-net should be used in
> all virtualized guests requiring a security boundary.
>
> There are a handful of exceptions resulting from historical usage
> in the x86 world, to support virtualized guests lacking virtio
> support.
>
> Thus the rtl8139, e1000, e1000e & IGB NICs are declared to provide
> a security boundary.

You've said in several bugs (e.g.
https://gitlab.com/qemu-project/qemu/-/work_items/3872 )
that igb wasn't covered by the virtualization use case.

I don't care either way, but I wanted to check since I've been
marking igb bugs as non-confidential when triaging on the
basis of that...

thanks
-- PMM

