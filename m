Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887A7606A331
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PLXMMLVR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTG3w-0003C8-6T; Tue, 17 Nov 2026 05:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTG3t-0003BN-Oq
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:05:13 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTG3s-0008Fo-9r
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:05:13 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67c0ffaae1dso682303d50.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 02:05:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794909911; cv=none;
 d=google.com; s=arc-20260327;
 b=ALROFxVZj+0N22QZjNAAMzzyQawLnLdvuOxZlNfcgGLEDq9J6KotBNd4Dd2Kg/rxoa
 t5qZWqxGZMetbipDlpXE0MRVb9gdmBAAc2dr7H7igCgVv81WlutuN5MRikat4Tzpr+na
 prVihSveSHtSFCXzsy0Q+dWdlTRM1+yac3x9aZshVt3UrkAhEpxaLeay/8kw2l5jiH+o
 0riok+KM+JmmoIbR1EcEyocO5ev6tOdEG4AaeCkx9MaUQ0kxaz8YfmwCZwStvVwnixXb
 8YktGvGqqR0rIhH6d4S2ABkn1oZd2qmx3Re3YbnHwgP7tOfEN29FZotwRR92EWrRSFS/
 WnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4hSojr5hwe1sssNavQHnJE8xYm4fn9A1D/pMDi7py64=;
 fh=MoNiFPxJ8Lkm8oo79evFMzGz7xJXfY1Pn+NwpFSSvOI=;
 b=agpYxSx4ZhFFi1rdBHU5GeaSMZh7eqPdQXrfSjtVMBGLSQ3YtZkWNAXcsUfmWTjRcs
 5tAhozf+YhKx6mZlvrM8tVUJUy8PVDV7PWFJ5UGqSJnRnNjv/3F2M8AmTyFyASN9vUzB
 AbCJUHaaw87PMPTXBc27djQAJoEzyeX4IHUAm8d6VrPWsythTNqZLtfO02yxXUmTIuMz
 csqWCoRo6mjgcmqiCFnAuV96l4ohmmQnKJZ+mgX1OP4lBBi5WXX9yrfYiV5j1ICQnESt
 03BaAnDy7CTAl6Z9hj8daGqFVSXxU4DMP09gCaCUkosQPrOFrHERzmBkUZUbDuEWj+oq
 xD7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794909911; x=1795514711; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4hSojr5hwe1sssNavQHnJE8xYm4fn9A1D/pMDi7py64=;
 b=PLXMMLVRJdT/MHkXly66oxa83k67QYopD4z4Uu5ObeZ8NS6/NwFlkmTeG9Nu7/sb7Z
 iaegalE7P8rjK4xl595hzqClchp8OBv68/SGSvWx3KzOuQNufAwwW/YqSVR67jdvkjN/
 QiK0phLwNrraZJtw2DXFsgDCtF48YQQSDG6ZDbIsV1rjTg0C+iXoIUeRIKLw1KmzX4vm
 4BlGBIAbTyIxbp/TDgPNGYZ82bVWlcdW79pq/d+6csxX8pg/cpWvPAr3+4uCcSXxMv8F
 7/3ApDyTl+WbgjFq+8tW6a2xeTDC2HF2sdoHcp9JRvWjr5JV83HWIplPBH78/wfFCjQB
 fZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794909911; x=1795514711;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4hSojr5hwe1sssNavQHnJE8xYm4fn9A1D/pMDi7py64=;
 b=GK1oG+Ef8WEtqgg659WzkANLTpIe2FENj77sYfRoJoymD2N+EI5Xp1IpYfAmgVVu4o
 hPX+pf0o0ZSz8wUJ53d+RuV+uEZrVGAoEmuk+mX/uXPVsfUr2Y231hmP0QVeWCckxWQ0
 79vWO63i3zI34QyMwv/KzAXzznOrNaAJ453u1RRRDCUkQoOhCF28kafUYkh2Lsz/HU+H
 y6b82UcNwMRlH0dGoUCshCJ6edLJf2F/FErDn8QzEwV5J6Su7ogDUXGwbeHy28us03yx
 J5CPKzUw6+nbOB+CHl2TcNv0MOX8/tcPaP/bUdt2DbsBCo7VqNkggYVj0IiYDvyGFvBi
 NhEg==
X-Forwarded-Encrypted: i=1;
 AL+hErEHbrnL5S6au30f0s0O8hamCG5vL5EklRUdLN1R75nvQDIWc6iMYC8wpXiaL3TqVKjjUQK38tgyBm0I@nongnu.org
X-Gm-Message-State: APuU4Z+uodew4yyXWTHGRxAGl3baE3oVeYjMz8mToGMPxoA53rBk1NkN
 WfPYJRaH6OJoBaHY2kYQfXa32Jrdk0tyFuADqbXA7RGHiXqnz42/dP7QYLz9SaxvEFDu7hZmsGP
 RzLafda6KInJDgpIQK15UTUBRSpCoZvpBghNoyS0o2w==
X-Gm-Gg: AZFdTZc8cej2hbipE7xnE7tNFHlA14dsEorcWwWRD36Xler4eJyTiteLeE6hMTi2iXS
 17Hhsgrs4iK3fRZewXNKelut7+ncyYaacx7U4c2kPbTySeGqdt8EoEzDA7h3XVcuZBjpAN7xKFF
 oewJpfL3X5Ilk++vCb5Qk3WkraRyimA4vW4ElC196nZzmYyQ2LVV8tFAlUWNuRpRPnJgqN2Gk0n
 jUxxemiyG9joLYIgKa19PjC6ydc/i4ap9b8Fi4Q9xMnky+/CKoNDhqp1F2PrWhuiXol6QQTCkQV
 ZcCACWjFExawlSWuMrnzdpf3NytdI7sdM97Pgp2pNSQBQiV9GWxx+N6nhnU29ahnaNhuVL3G6N+
 odFTXwh6tOQIE78tyWh0DWYn/4wk7m1K3pjZt+rvNk+zfNg9eyzWpVRBQjBkquMZe5oVeh1Omsw
 DNHoSzLVkCiE1O6sSrSDHOeQ==
X-Received: by 2002:a05:690e:144a:b0:67d:c305:ca19 with SMTP id
 956f58d0204a3-67dc76abcebmr1451446d50.2.1794909910956; Tue, 17 Nov 2026
 02:05:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
 <20261109-eth-v2-2-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
 <aef0393a-cf09-43ce-ae6d-ef5aa0b30317@tls.msk.ru>
In-Reply-To: <aef0393a-cf09-43ce-ae6d-ef5aa0b30317@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 10:04:58 +0000
X-Gm-Features: AclHuK8sdUqI1T9PBEvowDYxmsjCsLfRWCj97yPSaRa9OLrJ9bnjg4QhxI6wJzM
Message-ID: <CAFEAcA-2u=H_d867SNK-Ym7=RrwiPB8vyS=MHsZM+1qOwZ_NFQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] net/eth.c: Check for undersized L2 headers in
 eth_get_protocols()
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>, 
 QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 17 Nov 2026 at 05:50, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 11/9/26 08:23, Akihiko Odaki wrote:
> > We already have some header bounds checks. Add a missing check for
> > L2 headers.
>
> Hi!
>
> This patch hasn't been Cc'ed to qemu-stable - I think it deserves to be there too,
> is it not? :)
>
>  From this patchset, only this and 07/14 "net/eth.c: Move the Routing Header Hdr Ext Len check"
> are not marked for-stable.

Yes, I think it's probably better to take the whole set than only
parts of it. Sorry for missing that some patches weren't cc'd to stable.

thanks
-- PMM

