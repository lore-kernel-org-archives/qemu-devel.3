Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37AECD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 17:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRCHt-0002V4-Sn; Sun, 24 May 2026 13:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRCHs-0002Uj-FA
 for qemu-devel@nongnu.org; Sun, 24 May 2026 13:06:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRCHq-0004UE-8P
 for qemu-devel@nongnu.org; Sun, 24 May 2026 13:06:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso45833995e9.0
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779642408; x=1780247208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o34QGNwP+05x1iRjGNlqyIJppK1GOlWgfS0F58eOXFc=;
 b=OXbbfLL9OK6ZUnLyZipyrFdA9/U9MADnPXwbO2XM7Xiw1QtkODjFZamN06vUQ/v5az
 9bdmcWDMszpEHLoNqNlhbH33B0sVo0k7OwnEjdvL+fOlTcayh1OlX5JwHyc7sN8jKVUV
 DnCeoWHMR5Dc7B9xytdINzzsesTZVNAMeJJpTqrIRiSBofZpz6uJh5zwCiw1yh8Svyn+
 HyKwZrN40ov2YD2guE4N2+DNeSAJP8xxxFxzDbywUXaxfuEjxpEMsM11wjYIAgVA2xgs
 mR+1TqqIJCxJG9iGgNeca4QiKNev5BWWhrDKn1GzVBV5smGHvU2KP7ylo1aR2hWD7kxZ
 5Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779642408; x=1780247208;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o34QGNwP+05x1iRjGNlqyIJppK1GOlWgfS0F58eOXFc=;
 b=sEh6l7M3d0Ha49TZ3N94lqPDNVhAgo7AIhsHCFbeRBWX5buY0PHhNcr779URJTu1/D
 bN2YPdL6jEizBsi/qTGJOYixDUwLfHIfn+FFN+Z32vEIHEiZBBHafwzDYMdcsvxqlSEU
 hyGw0H9Dg0pKSYo4LxG4Om7f2WUBjJBQYNYYU4ARQt/V4cJm+4+6PiFOP988ptPBFbHZ
 qDiYx2i0lvcw3tVvIRApO4MfA3pxnZ0klQb/Xf88Qq4570q3nTq28TR7LuQ6/eJVUYPd
 EUfXQK7fjufcLRfyv3cLXLJ6itpmOh+SpA87ISjBZtCR2SNIaBJ6pnm3BrUizUY0hqOX
 7kkQ==
X-Gm-Message-State: AOJu0Yz9UEu52ch46wHfKLlgUoa/w9aJbaqnUwQg/MYUhZCR4EZlj1Dx
 M+HXByMcLZlCJL7bMSL2sc3QaBRl8JJ4HME/ogRyhdl95Q1qkvateJChca5fzb2++7bQ+vv6jZL
 unS+z
X-Gm-Gg: Acq92OFrzpXydEstP5HkY+CMnQVc3B1KZxLf3/9YeBSXdtdsvIAiZVXP89CLa9VMUVU
 3gD4NByB7TC8OWzVUo7iW92Y8v3FrHiv21E8KdsRSWZ74EYqjmJTHrg88Vj2wPWAK1PseJdBYs5
 18i5r/wKCJ1mHeE1X44CMs5Ej8PN4z1sjBYtdsY4gvqsojqlw1ebqpQdtP7rmg60z+1iUtLWLC2
 kPniRxTUlkNCzXNP1FRiHkivbh5ylBe+OqKYkbFQxkvwM9ECvrWqAAc5jXvHtnCGh+BCFOzE9pp
 BCcecMAAmn16jgItbAfrQosd3g5KUkLpHN6dkqx0aHzCz643oJ5Flys5JbBcNwmPESoHUWXp+Wm
 4pWYSiE53hfXu/uXV5R+hubL2YAf0ulOk7TriK0mvsP6fWLGwxYAhOlj52r0RN24uUnYZF096V8
 uskUDfuWMKj4stN5m1hksCBqM=
X-Received: by 2002:a05:600c:c4a3:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-490426ceed2mr190622185e9.21.1779642408084; 
 Sun, 24 May 2026 10:06:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526c926sm320930505e9.1.2026.05.24.10.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 10:06:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D4255F7E4;
 Sun, 24 May 2026 18:06:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  stefanha@redhat.com
Subject: Re: on ai generated and code provenance
In-Reply-To: <20260524083329-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Sun, 24 May 2026 08:42:39 -0400")
References: <20260524083329-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Sun, 24 May 2026 18:06:46 +0100
Message-ID: <87v7ccd9eh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> So, I had to reject a perfectly reasonable patch:
> https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ion=
os.com/
> just because of a tool used to make it.
>
>
> 	How contributors could comply with DCO terms (b) or (c) for the output o=
f AI
> 	content generators commonly available today is unclear.  The QEMU projec=
t is
> 	not willing or able to accept the legal risks of non-compliance.

In the linked case the LLM is basically doing a glorified search and
replace. There seems to be no danger of accidentally regurgitating any
training data which is where the worry about inadvertent copyright
infringement comes from.

That said in my experience generally any code that does come out from
these tools tends to match the local code style and patterns pretty
well. As a general purpose boilerplate generator they are probably
better than a lot of people at this point.

There has been some case law now that says LLM output could be
un-copyrightable depending on how involved the user was in the iteration
of the code. I suspect there is still more to come.

>
>
> But, since this was written, Red Hat's Richard Fontana and Chris Wright
> published this piece:
> https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-na=
vigating-legal-issues
>
>
> Saying, in particular "
> 	We understand this concern, but the DCO has never
> 	been interpreted to require that every line of a contribution must be
> 	the personal creative expression of the contributor or another human
> 	developer.=20
> "
>
> I propose adopting linux's rules instead:
> https://docs.kernel.org/process/coding-assistants.html
>
> which boils down to attribution.

attribution and *ownership*. I think the key point of the policy is to
make the actual engineer signing the DCO the responsible one for
generating, testing and validating the code. It is strongly trying to
suggest that vibe-coded slop isn't wanted.

I still have concerns about the quality of the code and the
"understanding" these models have. They can generate very convincing
rationales for their decisions but they also are prone to being
over-verbose and over-complicating the solutions. They have a tendency
to chase down rabbit holes in the code and get lost while making wilder
and more invasive changes to try and get things working.

That said for personal scripts or random experiments the ability to
quickly get to a PoC is pretty great.

I think there is also scope for using LLMs for things that aren't
directly writing code:

  - code review
  - investigation
  - generating test cases
  - polishing documentation

and I wonder if we should spend some more time investigating the
performance and pitfalls of LLMs before we open the flood gates to the
code.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

