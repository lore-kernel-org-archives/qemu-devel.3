Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E524BC5321D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 20:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shaxc-0007RG-3b; Fri, 23 Aug 2024 16:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shaxa-0007OH-2X
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 16:32:38 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shaxX-0002sh-49
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 16:32:37 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ef2c56da6cso21333411fa.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724445148; x=1725049948; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jJODn5eNQp27xQPSz5iTWPWuIV0svdrjaxsWjEA5l7w=;
 b=SfJsDiAPn9I1pfiQuz6fk7yioIW5PyPS7HqGcsWjDjaF20DOwvdP/0/k8R1Rwrfb0Z
 1X5Mi5pjWFnmCXZyyWyqijObWkg/k0IGn6mqCuqa4jryWJgW0P3NvQ6lRrnCMlQkwCoH
 sRwKX6OpQV6zrCq2iCg2ifiFOOs8UUXMV7db7CL/e5fTjmJe68TSmJVT+lj0NbaAfUr8
 Nwx6qCOrjwd9EW/q+p1pvkVE7kaZtPtahThE6ZLCgYJXPzjzuLSq0HJuXI6r8sKNDfoO
 OU1SMybDYjOz/niF2YhX+sEVMWzUIL+6bi8oqPG1iWkoOgRZzEpRo0SU3WWHyhIuZfnp
 h7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724445148; x=1725049948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jJODn5eNQp27xQPSz5iTWPWuIV0svdrjaxsWjEA5l7w=;
 b=wZPyynZZIvn5ccHJgWo1sd3saLZKI2tt281a4/Zx9ZDxQdeSh7g+Ojn1JS+OfZbAPt
 anXSF5PzFTALpn66u9q4YqTWmAsPP9K+qtABPaPjwUOjZNu2e4FfTViCUb7ofXgzwoZ9
 TPG3mQF9q+yjm3V7pCedcAdK+LZWBvh2waol1RFheGU6zMSknZS8pKYUAc8aetI74CiZ
 ZwDT8+GEAuuWdCsQIDE5Kk7Xu5s6hoA8hNYY9TyoNERFmrvE9kNx80/NG5tHvTlTNjfZ
 +yu22Be6v0+pu8MYxEN9o+p48w9RX+M8+8QzW+mbE+5SyjWLmkaXzoTXSO0BXVPTdFlE
 l+VA==
X-Gm-Message-State: AOJu0Yw8zFtWrEyouwtGJPnzk5vvN754m5jAoBJtQ6SVMzRn7z9pyjwQ
 k0mGEE97lUwbr/0aW30RuJG3Fl0wSC/0zEvF8gzGcm7a9WlDSdxpKBsm1ujxB3TsV+7/gBa3scZ
 T65lznupjxVyvJbQldB/mMTUmyaNnqsAWKkGsLA==
X-Google-Smtp-Source: AGHT+IEi8X5y2KtAUGTECBYn7csf5ybSxnOlz2PxF3xhXw0hRhkTXQW/mScF8TEv5H5ayoh+bSZstmCJ9x4S+knZjxA=
X-Received: by 2002:a2e:e0a:0:b0:2f1:a5bb:b5ae with SMTP id
 38308e7fff4ca-2f4f49049bamr20311061fa.15.1724445147026; Fri, 23 Aug 2024
 13:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-3-peter.maydell@linaro.org>
 <a2fcc299abf9cd81a3554244f1574cb9c7f63d70.camel@linux.ibm.com>
In-Reply-To: <a2fcc299abf9cd81a3554244f1574cb9c7f63d70.camel@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2024 21:32:16 +0100
Message-ID: <CAFEAcA_0M+F5OJi8QrD-F+_62ppGjct7xfgs7puZXF4cFTBQ=g@mail.gmail.com>
Subject: Re: [PATCH for-9.2 02/10] target/s390: Convert CPU to Resettable
 interface
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 23 Aug 2024 at 18:45, Nina Schoetterl-Glausch <nsg@linux.ibm.com> wrote:
>
> On Tue, 2024-08-13 at 17:52 +0100, Peter Maydell wrote:
> > Convert the s390 CPU to the Resettable interface.  This is slightly
> > more involved than the other CPU types were (see commits
> > 9130cade5fc22..d66e64dd006df) because S390 has its own set of
> > different kinds of reset with different behaviours that it needs to
> > trigger.
> >
> > We handle this by adding these reset types to the Resettable
> > ResetType enum.  Now instead of having an underlying implementation
> > of reset that is s390-specific and which might be called either
> > directly or via the DeviceClass::reset method, we can implement only
> > the Resettable hold phase method, and have the places that need to
> > trigger an s390-specific reset type do so by calling
> > resettable_reset().
> >
> > The other option would have been to smuggle in the s390 reset
> > type via, for instance, a field in the CPU state that we set
> > in s390_do_cpu_initial_reset() etc and then examined in the
> > reset method, but doing it this way seems cleaner.
> >
> > The motivation for this change is that this is the last caller
> > of the legacy device_class_set_parent_reset() function, and
> > removing that will let us clean up some glue code that we added
> > for the transition to three-phase reset.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Tested with 'make check' and 'make check-avocado' only. The
> > descriptions of the reset types are borrowed from the commit
> > message of f5ae2a4fd8d573cfeba; please check them as I haven't
> > got a clue what s390 does ;-)
> > ---
>
> With the already mentioned fix:
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Thanks for the review.

> >      switch (type) {
> > -    case S390_CPU_RESET_CLEAR:
> > +    default:
> > +        /* RESET_TYPE_COLD: power on or "clear" reset */
>
> I'd prefer
>         case RESET_TYPE_COLD:
>         case RESET_TYPE_SNAPSHOT_LOAD:
>
> and keeping the default unreachable assert.

The reset API (docs/devel/reset.rst) says:

# Devices which implement reset methods must treat any unknown ``ResetType``
# as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
# existing code we need to change if we add more types in future.

So making an unknown reset type behave like "cold" reset is deliberate.
Otherwise every time we added a new reset type to the system we'd
need to go through every device that had a switch on the reset type
to add a new case for it.

thanks
-- PMM

