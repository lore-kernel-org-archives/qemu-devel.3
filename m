Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1AB606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nRXuEqT1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLPS-00050n-Uf; Fri, 06 Nov 2026 09:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLOz-0004xP-Mb
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:58:50 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLOw-0002r9-NE
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:58:49 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b31ca7e0bcso6016267b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 06:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793977125; cv=none;
 d=google.com; s=arc-20260327;
 b=jO6cowyPJllfonmoo2V46iRmHulKjcRdgXakMMwyygo4+fZ6DFD6rJhPIWNDdrOJdT
 plIdgsCDfM7iIScK643IC8J0PwVeoARyGZ/FHduQIgQmGvSrRT4LlSJAdJ8ohIw8kjx2
 8iryQtlwymcshUzDT15e+MdOR70m+sWjLDSrdTNVwWlPLgoCJKLjHPekTPjwVVJx38+w
 f1MCkneh0NWXC7BMfj1U3iB4YqwJp+FP1kXA1JP3J4zn21YR7zUNdaZAeFIcVoRoEO8W
 9OWrNwZHb16yw8Njdu+iujFJ3f5F4N/tiZ2KaQPkFSxHQI1hlJ0nUqFGxfTM4ku0MJAw
 bUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8rzL5WOAHf5tJvUXHGnIxH/5+aSPKVFyKEOoUlZNc7A=;
 fh=6sVwTXfwRdm3+GZVAvdj4hfvHYs6fQE3qqiyLNdgTLc=;
 b=XmAZS3lCZkbmoDle1+Tr7lVNkhEe3XgMrNosGyUWyNR9WAzYmK+nNTrs9Z6PPm/9RN
 EPIp2X5BcMwTzcBgY5T1c8fn5qYSZlAGrSslxGBPEpWbzg/yQHsPhSht/25I2d1tcjx0
 lnD1LEha8ub80KIvtOBSfX+Hs06WJOIEoBqn3po6aaU+yj+6f/iGzeCsDvOWEsi3iDcZ
 iyVSbMiLQnSqYerskOyoS6zff8X0hioMlzLH/DMoPFnP9pyw0iAHmQp2HL72WfN2OLT0
 rCU7SWs+TAqjB3xzsxc9PXsk+3rbxEWOkZJvOGyhBTP1GbhlotJD9D4Kd0IeRVQu/PYN
 BaTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793977125; x=1794581925; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8rzL5WOAHf5tJvUXHGnIxH/5+aSPKVFyKEOoUlZNc7A=;
 b=nRXuEqT1Y6LcSYNggFur/8AZKfSjJsFc0mzr/ZeIXap0kWABerr2aZPNnX7drxFDKV
 Fa/Uj7VNZY6zJJl4j7pAlnzLLMGXdLFnr96QQ/bjDeB5qkNx4VgtiwOyHIz4WDfxqfgD
 dJrwE5DIPEpqwdP2a6WH00RWzz1pzoF84uPqNw15mq8MgcdnnpdsRq9hQfa/hI3qWUhD
 x/ROgdO1y7DYUuY1F/AIdd8vssKU6cfrkQaVr7L8lQ5kzCAlJL8PPUoV8JVxmwMgqeOX
 LzgV9J2Pg/3RSqU7GJSVJ3W7pNpX9MppMb89Ez/OlBQcahrhXjXKjnbe+DMW/8FNKVri
 sCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793977125; x=1794581925;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8rzL5WOAHf5tJvUXHGnIxH/5+aSPKVFyKEOoUlZNc7A=;
 b=wPZuDKYOPHMI8KIhP5vqbkp8+g0xvuj7UlEBFHdgSyMn48dG7qo7lfHdDMXS7kA9yo
 HwdNw/NTZcOt+MpbJkzY6mbt5Sso0D1VIvN0G5KG7hxlMFSiC6/umzQcDWxQ9KQS7uLO
 4PFCdMI5zmS5mR+QJ+9Rw46llwkyRZ18l/ezoTepzwIuwKpQIQkw5g+bWetFv8V6phny
 De+rXU2yOr0nEfm08fmHgVxVsO59tIPTkRJP8vvNio4Gb2+Wb7m7bxkolVEwZ6BMjJgP
 XQYQGwsMYXPAbP3kVSpUZE2Qf9HVZ5vSM6nbPvyHr+5H06ScCPxI4Gv97OlSfLZIZal6
 lkaw==
X-Forwarded-Encrypted: i=1;
 AL+hErFZUfUPmWTOT1Lw19j/qUJ16jzSsfeXHKNYLeSv8M9LAjltJr1zjyMT0zq3OZ8ripgEo63SOtaHQuOP@nongnu.org
X-Gm-Message-State: APuU4Z9xKP3Ed5yqNY6XSCWVj0+1Kwz0lh+QZIjXA4+GUQG097nhtPQ7
 SSF6TrtzljGF0q2XaXxpkMv1+03xN5jLHvDEhcoE+QNo9n2DFz0oeoaJHfIVY0wmFNEjvWiBs6l
 dK7/h6kHlRuQZ13STLv6nl+bAW+kfVMHDaPhoyhRi3Q==
X-Gm-Gg: AYBFou2B/Z+/gq0p9tTBmg+sdRd5L04yA9nrqL+JmWfpYRZL2h1tS3AXIiv0BG7w4ZB
 JB0hXJvahtad1EKPlJIp/2xptOh/m7/o6rQT7Wv/VWBr4csoj2BGmCDQlpjZV9Ys3jX+wcP+ern
 9nXXFDWsjsGOZZUAKiDWOl8499QNLSfdf8CGPZr8cPyKssyurCMyuXiT3H9crg5Ohem1NRzCWGw
 FNSI3O2EaIlD8yvUp0l8O3KAyFHGfvktaGCFQgH5a16caM5//1+r/7Q6deHaxfz7wMk+EOGAWf7
 AIrQRfPek2C3ALGYX3k6XB3Ch+qogrBWUffSaz7zscoheNpq04mFx1zgM+v69PyQF5wBNNnl/wL
 kqqWsUvcovPD2vRBJTO2LeKS7R2rAIMpcetL53v6wlfrdbE6vQaBFpB/rUdyEGAvfjdHcSWs/0D
 A1M4VcE7cYhGvgLW4Rube8
X-Received: by 2002:a05:690c:e3e5:b0:8b3:141c:b6a1 with SMTP id
 00721157ae682-8b341907805mr17185307b3.9.1793977125314; Fri, 06 Nov 2026
 06:58:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023130023.539252-1-thuth@redhat.com>
 <au3pKF4zORf4_98U@redhat.com>
In-Reply-To: <au3pKF4zORf4_98U@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 14:58:33 +0000
X-Gm-Features: AclHuK-lgK9Cnno0BWfWWFIEezG4RTJIRJ1t9R7UmZKG_FE_e7z4ptbFhEI33PQ
Message-ID: <CAFEAcA8Ysc5R2N7HX=uMAUEHi34xzgjU7QP7bcndnbbZ_3rr0Q@mail.gmail.com>
Subject: Re: Acknowledgements for AI-assisted trivial bug reports (was:
 [PATCH] block/vhdx: Prevent out-of-bounds BAT accesses with) malicious vhdx
 files
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org, alex.bennee@linaro.org,
 pbonzini@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 14:50, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 23.10.2026 um 15:00 hat Thomas Huth geschrieben:
> > Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3762
> > Reported-by: Daniel Wade <danjwade95@gmail.com>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4470
> > Reported-by: Mayank Jangid (OpenSec)
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4487
> > Reported-by: Ken Hsu, Royce Lu, and Bo Qu of Palo Alto Networks
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4638
> > Reported-by: Thai Duong (Calif.io)
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4733
> > Reported-by: Xiang Chen
>
> So if I understand correctly, this issue is trivial enough that it was
> found by five people('s AI agents) independently, can be fixed in five
> lines of code, and not a single one of the reporters could be bothered
> to send an actual patch or at least attach one to their report?

To be fair here, I am pretty sure that if any of these reporters were
going to produce a patch it would be an AI generated one, and our
current policy says we decline those.

Plus in my experience the hard part is not the code change but
doing the work to figure out if that is actually the right way
to fix the problem, what the consequences are, what any relevant
specs say, and so on. All of which we'd have to do in code review
if the patch came from somebody who doesn't already have enough
community trust about their ability to have done that.

> All these reports seems to include two kilometers of AI output and
> somewhere in it they typically hide a section on suggested fixes, but
> always either in English or as a code snippet that you have to manually
> insert in the right place instead of a patch that can actually be
> applied.
>
> I wonder if we're setting the wrong incentives if we reward such
> laziness with Reported-by lines for each reporter. I'm inclined to drop
> all of them and only leave the Resolves lines in place.

I have tended to collapse them all down where there are duplicates
and only give a reported-by to the one that reported first.
I don't think we need Resolves: tags for 5 identical bug
reports either -- we should mark all but one duplicate (which you
can do in gitlab with "/duplicate #1234" which will auto close
and link to that other bug) and only have the Resolves tag for
the one remaining open bug.

-- PMM

