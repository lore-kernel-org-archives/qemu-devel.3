Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134460A2602
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XgXKZtx4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3jo-0002k2-K3; Wed, 28 Oct 2026 09:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xM3jf-0002h8-Nd
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:30:35 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xM3jd-000764-Az
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:30:35 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b10ac6ab7bso8147987b3.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793194231; cv=none;
 d=google.com; s=arc-20260327;
 b=RErvvf8enK21oCwmu5DYEDwTuFx5ZJ/fHu7c8UekUSBvOFeFYJLVL7zwbvUzqpH2jy
 kQIwr98xrWTCPQCf6S1EPQE+0jXGJyIY5KxFo/w0kyqmV/dEWIpxRutWG7h4GyeW/d5s
 Sxzk/HZPLreLLx5/ppJ0Q6dsMSFv+g7M+dsJ65w4N/BlXvOgZzIA7uHCwX7i4k4QefgY
 gws1l5J8ZWbfvXpQW/2IuK74HyObd4tfaalNaPmER1CDH6THYZ9gSjr827ysrscGIYVO
 9/02x/pouZtOojMkb0Voc9h7qmqu4NNpEu2e/QuvnOFm3iKwLa3afQh0rIn9dqKJCa1/
 TraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JG7fWrsQcGlWAZCRdOPzbm5SVFbGQj9zRpQSsOTwW4g=;
 fh=WtfYBioCERIpilaIlgQ8CdUwqaZjijWidHTN6miTi2I=;
 b=F8616E1oRF3i/+foUXwIDwPZyvYS/os65LoSLQH+cC2ZOz+OaARRkmAH3b1t7oRO+W
 3jCQguxN89fPaHleS1rk+aF5s+xAZ3JvGtYmHGS1fQZFUbZOkQwfneYL2KdIUeF117TW
 YEGn+TtnOarmzl7yKxTmAAnvibEI0svzRtwVWWUPLi8/LkFfX51VjVrJbuRKkZXMSjc+
 PE8cos3nAUuV9GheECnLCx4J4NN+yCNSGDMIJArK2eardixwpjP1f+B6rRmBJcJB2jqm
 ETO9XGcxmR+9+m2JxMx4/B/+z/Tw2SRkIo6qCRgCJDcDp+Z1GRnrfgZwnqGa9uiLi4lk
 CSHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793194231; x=1793799031; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JG7fWrsQcGlWAZCRdOPzbm5SVFbGQj9zRpQSsOTwW4g=;
 b=XgXKZtx4fKKY1i+MgTBoKqxnzROT34XPfCBuGbCiA+xDFjUIhPouKsImKdMqPAXNvH
 iPB7FFF9nfSCb3H8kZAEofz+5yKTiK06y4mTrvbuIC9GJ38QGXTLjLGfwIHm9IGWiSKB
 NxRm1L+FbEX1PH/Hf0YnIiGux9l6W5nbaVPt7yI72nMB0RD3BcDrwtjm8DQRUYCDCp3w
 wkKgnPf0q+o9zYuUAb3nVzp/tNts4kd1o9u5TqxAfZCmv/ncO4aMuvwTsA1Ip+1z4nhn
 20lYhh/e0DykpmiWWFmbYaIIJwvRUzD/X3zJThHUlrlGGMFEMSxINMDawQ1qiVUmW+9R
 XnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194231; x=1793799031;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JG7fWrsQcGlWAZCRdOPzbm5SVFbGQj9zRpQSsOTwW4g=;
 b=w9hDq+T6nXe45ca1j3egw0SldFCO0i1v/DIld+9ZEvinhp99va01+Mm6tu5ylTZcMk
 0XAYq4/VXm1ektgQlXphWmYuYXzxs41BIP7Rsm0vQ7VQ5W35nh24baducJtYJDvKAV5t
 PjLUQ8ygzQXSpmtK1+yzzSXEW5jr14XjdBSyy6XYPT4LwrD2KM8fDHC4CI184zXX+yeU
 Wa0KBpSmFBu+viyDWPhPttO426ja3qb+ZCxLnlEUHL1HB6RtXSe9Lxr4JMg+rsvRAtKg
 B3XXmZHgIUIS82/AoARskTWFZFWJQfr8qb9ocxI1gBB6TWBOFiM1OXDzC3vXYxsPJgzG
 rU8A==
X-Gm-Message-State: AFq9FYLgEr4b+fnYKeZsZ9DvECl7XhqW7nPPvCOhG8vOfoZqgojEVNXp
 LcBWUVL5L3BEemZJOrMIRr5KHUNqGbVMjHQ7QDG+mhZxUTGdEBfG9Ci/sHvFDLg2BudUBbfu11t
 5OB5Tp7n0+TueKtJX2VoKrLKXlU6bdOle+DUAOC8/8w==
X-Gm-Gg: AYBFou1qlkpcX7+rap98rO/OYO9mXsKKScjWx7GMHEg1mKjMg3jZIDOELqeXZUxJr55
 5m8xqGaWe5S0yJ4GRKWcCh3hJi4vwDpyyfv+c2QOhRw3SDjU4198tYVykEHEJLCN31Ae1NbKzrv
 JDkerFfbA2K4mIVzar2OnNMUunuNUmcAcfwXSQRI5LAoIL5ETOeM9sHOJaap+NUf7h5YKfpP5ht
 jvv45MyBdRHWbY8zrGy9UuvaqlX1gpdn0JKOuttymQwlsweCo5kZ2C8iXhHG9Vnca/M0NLI5eeM
 ukkqJZqyT8JTBCv9zUqxoq01QCD4QjsPu5ogGJ4z6MM7469D90ASjABbWoCa9EBWnr1ywtJCLjT
 2PkFVDJ0N1R+BBf8U1CkbdCjXksWmkfgJ5jc0VtFF8DC0qTYHf81wOv9w72arZ8aNTuTOCbjgZf
 2eo8kVBKtC9dk17lr4CZQG
X-Received: by 2002:a05:690c:92:b0:8b1:8aba:afe5 with SMTP id
 00721157ae682-8b1b5c90bffmr15017687b3.28.1793194230973; Wed, 28 Oct 2026
 06:30:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260721131457.3062767-1-farosas@suse.de>
 <CAFEAcA9GDRQoqEXAt5-Mnm7jTPvpkZ6EPPvxiL7h_mFZOMuW6w@mail.gmail.com>
 <87ik2njjqn.fsf@suse.de>
In-Reply-To: <87ik2njjqn.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2026 13:30:18 +0000
X-Gm-Features: AclHuK_kBYe9fwHQGukSw2enyU7g0eSP18HbU1S9kLIhczcJgLROaZtq3dYiQpU
Message-ID: <CAFEAcA8vq-zFsou=A4H+XDZ-zsWKJK3-RzASs6aV_s9efFyQyw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Add security considerations for migration
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 27 Oct 2026 at 14:33, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 21 Jul 2026 at 14:15, Fabiano Rosas <farosas@suse.de> wrote:
> >> +* **migration/snapshots**. Migration failures and snapshot load
> >> +  failures are considered part of normal operation as long as the
> >> +  source virtual machine and savevm file, respectively, are still
> >> +  functional. Aborting the QEMU process at the migration/snapshot
> >> +  destination is similarly not considered a security issue. The
> >> +  migration stream is assumed to be secure as long as the design
> >> +  principles described in the Architecture section are held, in
> >> +  which case plain manipulation of the stream is not considered as
> >> +  an attack vector.
> >
> > Reading this (which is now in our docs), it seems unclear to me
> > about whether it intends to say that any and all bugs that can
> > be triggered only by manipulating the migration stream are outside
> > the security scope, or only some of them.
> >
>
> All of them, but we're talking specifically about feeding bad data into
> QEMU from the host level.
>
> > It says "plain manipulation of the stream is not considered as
> > an attack vector", which suggests "everything is out of scope".
>
> By "plain manipulation", we mean that if someone loads a compromised
> loadvm image or if they have access to the infrastructure and proceed to
> inject bytes into the migration stream that is considered out of the
> scope of what we considered a security issue. The premise is that
> migration is a special process that requires a secure network and the
> usage of encryption. If you migrate in plain text over the internet,
> that's on you.
>
> The other scenario, this one in scope, would be an attack that starts on
> the guest operating system and trips the migration code to cause an
> effect. This would be an indirect stream manipulation, if we want to
> call it that.

Thanks. I think we could maybe make the text clearer. Here's my
suggestion, that splits out the cases into a set of bullet points:

* **migration/snapshots**. The user must deploy QEMU following the
  design principles described in the Architecture section to ensure
  that the migration stream is secure. Plain manipulation of the stream
  is not considered to be an attack vector. This means that:
  * Migration failures and snapshot load failures are part of normal
    operation; these are not bugs as long as the source virtual machine
    or savevm file are still functional
  * Aborts, crashes or misbehaviour of the destination QEMU due to
    an externally manipulated migration stream are bugs, but not
    security issues
  * A crash of the destination QEMU that can be triggered by a guest
    manipulating a device on the source QEMU before a migration may
    be a security issue, if it meets the other criteria we document
    for security issues

How does that sound?

I think we should also:

 * add a subsection to the "Sensitive configurations" part of this
   document at the bottom, that makes it clear that the user needs
   to be careful about the migration stream and loadvm files
   (to parallel the one that says "it's your job to lock down
   monitor access")
 * update the part at the to of the document that includes in
   its list of untrusted entities "Network protocols (e.g. NBD,
   live migration)" as this suggests the opposite of what the
   later text says. I guess just delete "live migration" ?

We also have 15 or so existing bugs that are labelled "confidential"
but which are "crafted migration stream can exploit the destination
QEMU". Unless you object I'll mark all those as non-confidential
non-security issues.

thanks
-- PMM

