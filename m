Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCDB606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iND+RA3G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTftH-00015c-8w; Wed, 18 Nov 2026 08:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTftA-00015B-4Q
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 08:39:53 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTft7-0006eb-VN
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 08:39:51 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-67da62357acso1253587d50.0
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 05:39:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795009188; cv=none;
 d=google.com; s=arc-20260327;
 b=aZJmk5Dz6GWB7DxEkZ8FaebFZVEBzfzWk6AI7qQIxKVeWK+IUaUaqqCj/2Sq1Fvcxi
 oehMaCgu3+0D+afLf8qcjsCNEjeBtUTT4ozM/jrNaBFvBnkOx0ot7kQONzHGxdbX3tgA
 gdlvoHRV1Z4GqCHDqlHVlFOGzpj/Nsn8N9tBmPVDKq1YlqAbpnY1+OfvGSVTIbRJB3d2
 LqI5BsylDo9oihSfTGDARfNCtOBjKIOKlsrvU73qogyw66rngJxKbDc1QWrQPyQQIisP
 GZX+xjUx6VL0fImcd92+dpYKoHP9hyWwLPTBsw6pHhRf5itZawr2fMASlToQz4fzTbXv
 OZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HJsRux+mEwnX9dvBMAuE1oJpmEDFJkfloWkR6CW9ztM=;
 fh=JYGwuqguaSdPek5G7rPw3Y/CGHv5PxmTzr+JZI7v3MQ=;
 b=q+oUsMiYSykDZcoDMUMG+Hj9FQkghNHGg0P9XDgRcocfqm0dqkma/AjRnGpdecW2Pm
 UfeL9/O55C0AhQyCWEQMWOpOz06hAL1h8+UrCXR5uWUHMSKS3bOJPOfkDuFlSZeDCJPI
 AJnHykpdpndx/H4tINoxFj1pbhT7uTvM3NAdBfOu6WAnqP1EPu6HSkRfdRIxRDCOG9xB
 El36OtrHL4PebVzdTOEkGBE+BcxccGMDuV+5DW3m7Y2EikTXSBrZW193EEm8WpboWuhX
 cqFSWY/iaYBwXYU1VZOwSyYJhv/M+bICgkgXe7J0Xrr44IHfaXjdoPcFr4yP5ruFlYfz
 iTbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795009188; x=1795613988; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HJsRux+mEwnX9dvBMAuE1oJpmEDFJkfloWkR6CW9ztM=;
 b=iND+RA3GCOLmusMGCnEvWCu2YEXZP7VVaQgX+iF+MvrvdFL0kokyWBnVIMlCAijl+u
 6gRZp7loDgJWUAZaFtS3cvqK46ZtegTZxn8Uyv5fwVjvDOmr5C5GdTXQlqVFXd0faZyu
 CTYTuY+bmTQ0ePGbIGmmeC0fNo8fHZe/AB7NF8q0fYcliliFSmNJrO+FwXwyZGMQ1dYM
 slyC48ZrVHFeVk4XzS5fWy1qCyG+HWGehpfjL8l3UEt9xR240s9PIz+nULVbyFHzquL+
 CDNca0jSNAU/Qey6qYS4KhAyotTv0C+suXCeDsZrlM/5f8S69CJamtoW0w375wardTam
 1dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009188; x=1795613988;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HJsRux+mEwnX9dvBMAuE1oJpmEDFJkfloWkR6CW9ztM=;
 b=TXH43RfifddBL1riDYi8LcK0KGqxcx5/O0wDusF5ktmNjebPrqVgS6s2bABlI9s2l1
 fwdOx5w0A9DEu2fMD1H6vz3IXXR7/+DPrrCw/pjff5elGhT9tYFpyLPolt6swS42WQhW
 QdxehQyLb8FxKYYnRrWR7wD4bN+ycld3Cac26SQAmavzfPhUutPch+tiYPYyxQ3ZywIW
 pte/1STjbyEHhz2QtYXswuLTA0gq3brLxT7fYLzI1E9xUrERT/9Yx926N0H06Ig3piCA
 3KcJAaH9qxx0ysTfhkWUQGEXF1UsEgI7U/ChpZbOsU8scKESOhKdKA7mGrTA94p62Sbw
 EA4g==
X-Forwarded-Encrypted: i=1;
 AL+hErGb5SkykAJEpASXmU12Pi/DMhzILTnC8Kwbvwip1V4iazTApeq1gFqCMYU22Wbef4pPqVQOQAYnsVrY@nongnu.org
X-Gm-Message-State: APuU4Z8fgFpXCo4q5Ci92rtvBosanDt7jy6v89laI2OEDUj+qvUdoiFn
 7HBWozuIJLnEl4aGREkMJsIYkIuPllJ0yCqTsqTDsdyWGbAGFyV56bNJAIFg/DNM9ByvEtKxQp6
 kyDITFw49OnfTDy4/MK5XbyVhKGGeGP+4gIC0sAJmIA==
X-Gm-Gg: AZFdTZfxeFkbW1IK3OCyL3cK2b1uCeVWtDbw/5cZ4v0j/+byOpz/pcE0ZSYKi+5kKwI
 8abTzn+1HRXnTfaUS9gKk13c3b52slKnLeFxHazYHlb9VewJB1AI2aHO7xNNhkk7Nl0FDMVq27t
 /HIhT8jv1LgriuPftf7FU2Aib8/4bzFUb1vUY2l177MRns80legIZ0lB/ja4aA8pD2b+UcUiRR0
 /aM1S17+NGVjT0KyBicZBGiWky9TBGH1UB6Nqx++Nl++kxDGWUAPHl2KF22euUYgEwyCadh+189
 KRryt7fkSRTxBYTmET/a3ff/GKqVWtschQKI8o04WY7UGrdOgtDFCddPxt5v+aMmx+n+lQ5KJjE
 mckZn0UGq3DauITm4/T6y4pCiH2yAzF9XltMtUj0vA/XJ5l2BYBgYkmirN1W3fntB2G9hWNhGuL
 jHkjuem4fsSt1Q3rBFU47o
X-Received: by 2002:a05:690e:bca:b0:67c:1dca:80f with SMTP id
 956f58d0204a3-67dd4549813mr1053341d50.54.1795009187839; Wed, 18 Nov 2026
 05:39:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260918095718.33745-1-guobin@linux.alibaba.com>
 <CAFEAcA_wtZP7BvxMfamQG8XV5U0Q96Y1=Q5PL_mCEatfdrywPA@mail.gmail.com>
 <TYCP286MB1393A2F623C0081276E0563EBC7B2@TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB1393A2F623C0081276E0563EBC7B2@TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Nov 2026 13:39:32 +0000
X-Gm-Features: AclHuK9Ts0GNy4n3F2PUr-kqxYsrfnnCP5K47r6Vg8sdJy9RGfAsGXfG_c1kCqc
Message-ID: <CAFEAcA-fWQy3afLRzCPjX2GQMDydx2w6eKbrmBBic8nOuwsDKA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/canokey: validate endpoint number in
 canokey_handle_data
To: Hongren Zheng <i@zenithal.me>
Cc: Bin Guo <guobin@linux.alibaba.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Canokeys . org" <contact@canokeys.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 at 22:19, Hongren Zheng <i@zenithal.me> wrote:
>
> > On Fri, 18 Sept 2026 at 10:58, Bin Guo <guobin@linux.alibaba.com> wrote:
> > > canokey_handle_data() takes the endpoint number from the USB packet
> > > (p->ep->nr, guest-selectable 1..15) and uses it to index the fixed-size
> > > ep_out[] / ep_out_size[] arrays of CanoKeyState, which hold only
> > > CANOKEY_EP_NUM = 3 entries.  A forged bulk-OUT transfer on any endpoint
> > > number >= 3 therefore reads a bogus length from past ep_out_size[] and
> > > writes guest data through a wild pointer read from past ep_out[].
> > >
> > > Validate p->ep->nr against CANOKEY_EP_NUM and return USB_RET_STALL for
> > > invalid endpoints, before any array access.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4481
> > > Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> >
> > Probably worth Cc: qemu-stable@nongnu.org
> >
> > > --
> >
> > Did you have trouble getting the canokey code to build? I've
> > been playing around with it, and the canokey-qemu library
> > appears to have a busted pkgconfig file, such that meson
> > can't find the include path for it and the #include in QEMU fails.
> > I guess if you installed it to the system include it would work.
> >
> > NB: given that the canokey-qemu library is Apache licensed
> > and QEMU is GPL-2, the whole canokey support in QEMU seems
> > of very niche utility, because you can't actually distribute
> > a QEMU binary that you build with it AIUI. And distros
> > generally don't ship the canokey-qemu library anyway I think.
> >
> > So is it actually useful to anybody, or should we just deprecate it?

> Thanks for the email. The fix looks good to me.
>
> Reviewed-by: Hongren Zheng <i@zenithal.me>
>
> Regarding the build, indeed it requires modifying PKG_CONFIG_PATH
> for meson to find it for custom build, and this behavior is documented in [1].
> If it is a system package, it should be fine.

Setting PKG_CONFIG_PATH is not sufficient. The problem is that
the pkg-config is:

prefix=/home/pm215/src/canokey-install
libdir=lib
includedir=include

Name: libcanokey-qemu
Description: CanoKey lib for QEMU
Version: 1
Libs: -L${libdir} -lcanokey-qemu
Cflags: -I${includedir}

but it doesn't actually put ${prefix} into the libdir or
includedir variables. So meson put "-Iinclude" into CFLAGS,
which can't find the include file. I think it ought to say

libdir=${prefix}/lib
includedir=${prefix}/include

> For downstream usage, NixOS used it for CI testing of their
> systemd-cryptoenroll for ensuring successful booting after upgrading [2].
> There are efforts to push it for other distros [3]. I acknowledge that it
> is niche, but I think there are still users.
>
> [1] https://www.qemu.org/docs/master/system/devices/canokey.html
> [2] https://mynixos.com/nixpkgs/package/canokey-qemu
> [3] https://github.com/canokeys/canokey-qemu/issues/6

But what about the license conflict? I don't see distros
being likely to want to enable building something that
isn't redistributable, and especially something that's
documented as "testing purposes only, no warranty on
the security".

thanks
-- PMM

