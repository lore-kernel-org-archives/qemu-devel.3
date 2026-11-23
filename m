Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077E606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bmcBBl7R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTu2-0003v2-5p; Mon, 23 Nov 2026 08:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVTtx-0003rX-Lr
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:16:09 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVTtu-00040t-Qe
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:16:09 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-679a2b5fe87so3040528d50.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:16:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795439764; cv=none;
 d=google.com; s=arc-20260327;
 b=BqRpYgfNAveW5GcQEZZZBIsvzr6+0wKr+NLUsiBInCBdze3R9Uw7cXChGsNCW8RzHj
 nW9no7CbNP5VEUS8inE+ANhYdvkSN+RVgyK02ZYEK2Xs79x1jpog2s9op8ZJLOeBzqsu
 M2OxPLHXtezuYtKQxPG12GGAW8xTBqlqiiykTFSlHKZNuCM6LDPQvMe7D6EpUSWhXgwz
 DwKXH18Q9BstCgORPQmgMBMu3rWhZcAO05XhwWKzT55Jlw/7GbyS0yayYnfNjwuT8eim
 TY9e2vEB5MmYIphsG00m8UvBQwUARfNreCPLlyzJ8fjrV8w30DDcJMB7msVEZGqwts3j
 7Gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L43OXU6mO+epKo6tJONydYsUT/d3OSbnv5ZMOpUIy0E=;
 fh=87w2ZXzcKlwYaqKr4L303vmIUxAkl6c0V+1BYZ5wPSc=;
 b=kXPrEM37FlokR8mzoeQNCLTFUWONaF8ZbAANaTfTG6sfozTi4Iw0DuU5ElTdLzOrIp
 dpKdpV1Qv/+nLo3d+QwPOHcuZA/9Y4caU52eqR3jM6pljaX45UQoD3QB3TQWdVrUrbP7
 mEkin4+ERnU6sff9Epg4oNlEw6gNtXAtvWEicwKrZFxjNOYy4y6AosKMX0NeNx/x5ihS
 PLQ2cj+PhR4SRBySU/WIMbhKPkwnqaMqFXh+sPVC2ZSxpQLsbzKIbaOk1fATryb1Xv2/
 rDuc63bybkV8C6YWTRoU5/HAUQelP2RPiT3arJZvA1XWuGx+HY1TtuO33Mr4vgGwnJ3U
 7kYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795439764; x=1796044564; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L43OXU6mO+epKo6tJONydYsUT/d3OSbnv5ZMOpUIy0E=;
 b=bmcBBl7RtKV1oO6v7qgAazU4rnOcz4BmvamDMayUNaAlXbWd1X0BGYBd/a/bTU3mjx
 8r7Ax//A6JyUa3bTKGlWTP8aIHf9JEUSIgh7A52JcyNMjjsMjRtqzKpvl6j0o8G2O4u4
 U4MErRaPKcdrEAvbTsY8+ewX/NF2X80f95yaW/Zp3jLbI66zdpbq7pAHQe64TR2opKKk
 /fPWpGUCSDlq4O9Tjx74dwSW+SrvxufkuJjpNPVEhkqiufTi2W2jHUywleJkMe67nYmJ
 TZEOLTV0HD7hg0LJVXbuxftfizQNLjWLQdCqUuB2kdJnzUqsQHe5K7eBojuu8BNywCB5
 A8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795439764; x=1796044564;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L43OXU6mO+epKo6tJONydYsUT/d3OSbnv5ZMOpUIy0E=;
 b=2eXG6Ammg+DnssVG8UB2NTgjyFTiIN1AdSrUtC3rxdLiwHRCn2Ba+VqYXbl4GE+Iag
 bj+08q2PsqLHyOVCVpKSXjZsM7hPyflETi4WSxYcwPgEM8n4EficNvzAr0J/991QJ8kg
 +8+/Wqu0P83PBgqrUbZiaBr8tpz8xhQM3yJnNGRgLw5gWETPSXvVaxe5r86rbNhH2jYY
 nWsuK+D13fMpQ4weL+1CdQAQJaEMFqbCglxF+jRBPeao5wxIz0lKXsDMYg2FtrWj9QdJ
 oMaDFcdpu3aKpC+13am+tSNDmEb1VcnRrEzkftVqe/50rjLSwqrrjM6kBaEMSJsTwNie
 j+Iw==
X-Forwarded-Encrypted: i=1;
 AL+hErGi+vs7xsetW2+g618nN/wsPdoWXCqQKNByVGvrnWWacttwbRFh/Mm7UCWxSlmFZAbdm8//ZYdACqVy@nongnu.org
X-Gm-Message-State: APuU4Z9dHM1zhUPWKvLlVLK76S2PoGxRbOeOAt/WPuK8OBg29LD+Jm6L
 1hSBeqMvUu4327cA5/3/EOdb+SQKrWf5bx8yRFaxwSmLACt0w9z/hxQxSUS6f0yxgxBuI4GcJcc
 0eS+jeOuqImjO/fn6JfOd2lN1chtfy5/9PmNn5ZsWWw==
X-Gm-Gg: AZFdTZcBi3Ry/AErwIk0gfteAGhXcsGjQRlgt+KhYNk9/kmuZOxiZs9fXukQLV1nkvk
 ovmc2J+uL35HYEz7S0m43R3JGxTd3m9cboLhis2OFLTJzcbgezNih7I485gxNAGJD30snqVGU8w
 FCk0+3v+p+rqe1B6NA5Azkwm9TpGY+1HfBmIpmXAN1zc6J/WJ0KlKD6+ZELJ65XI5Dreds5G1F0
 llme/4ZCpOBKqkuiJafO70lZ5XchHjHvGCczsaqHHl+lBth+zLVec2jowlmKXaX8JkdZAFBiB0w
 b0RbFgAlOdPThJUnjvV7XWWJh52R7G12bhCV8ADsZph8b5xpD/VeoRHgH3c8hwmBVm7UYAOTuLC
 x0V5E2Q4kRQpM2PFXgwdwtO8ivK5uXd3rR3VuXwdvIbLJPLAp5fjosVIq3zG2REqOS65APG7rNF
 X/JPf0vlom8sF2NUHswpDsVRtyrw0mHz0s48YiMJrPKA==
X-Received: by 2002:a05:690e:43d3:b0:67c:28fa:29bd with SMTP id
 956f58d0204a3-67df42d04femr2084658d50.13.1795439764127; Mon, 23 Nov 2026
 05:16:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165546.3050013-1-peter.maydell@linaro.org>
 <CAFEAcA91WC+x80j3Lh4wyOgzU=tdu8AQqAcDaXtpghw6wUm72g@mail.gmail.com>
In-Reply-To: <CAFEAcA91WC+x80j3Lh4wyOgzU=tdu8AQqAcDaXtpghw6wUm72g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 13:15:52 +0000
X-Gm-Features: Aa3M54oyR_fnaP7bcOFVdd2g7NHu8G_Udw5VNpJDEihfNhjiG4X97NPKQewNauk
Message-ID: <CAFEAcA--T+yq6_ZHNFQTbvgDKGN7fGnk0sMiJrtzzJ9P97ae4Q@mail.gmail.com>
Subject: Re: [PATCH for-11.2] target/arm: Handle "PMU disabled" in migration
 validate functions
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 12:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 19 Nov 2026 at 16:55, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
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
>
> Just noticed that this should read "only if there is at least one
> region".

Also this is
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4905

-- PMM

