Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28374CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 17:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBG4o-0004xG-An; Tue, 21 Oct 2025 13:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBG4m-0004x8-9I
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:23:12 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBG4j-0002LQ-6b
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:23:12 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63e35e48a27so2601853d50.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761067387; x=1761672187; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hIBfe4Wnho7Byyf823qbIiyCVdxG61+caeMyboIh5DY=;
 b=b3VbTKsMGGoTZ7RudIex5apKdcMEB8HDz7uQVC5XzpgDRRhBrfjlRlDNqtduQvjRJP
 0cgLzkM1XxS38yygftMHootKYqTOp6HwW4sErArXV6G0yS+6EkEobC2djbFeHl4ukpCe
 vfy22RTz6bCp8q9h6uhESfQCaISQG8iXGxDFUg2xCkWz2BLVNHHS+Bucm6JbO9IYoSLn
 jLeJhJn+VESun+IZ/Cp2ztygQEC8/lV66ECMe75JUrfnWlxCtM8ei5CiRN/CYK3wHoHC
 mT20IEk7oZfCUHAEHhHC5MWkV022JqGw66Jw2kIT/Hi7btJt52QRwOZ9T6kTcsy/gpkm
 R/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761067387; x=1761672187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hIBfe4Wnho7Byyf823qbIiyCVdxG61+caeMyboIh5DY=;
 b=MeXA42mLTybk5KY9t65Ozc7v4R5huNX9BdORr6r6xjYJVew3K8Ayy0vHdJm/fdZ+ao
 8ZP6N0xnIWLUMA/SoSg1s22UT9tZCjrPqm+kQ8QVtfzAxOWE+2SK1/9fLIjZztsm6ctd
 YnrxCqRqF5LXwp64c+E/DgLm0AYlKqdGKJghbJGj2aDFmZLBJS6M96anNxBNie3GmlqH
 G/uruUA0yVOECPzSd3PLOYcDTpyzEV7bfH41EM3jHPGdVb2X3Ow6TglY1xSbUHYtCsT7
 Zvhshwr6GeBDHTRs8Mukzch8aOkuXrs0z+sMW690XxIuIgbn9zoCrZm/QRVRs/w62ndb
 1pgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqOr9HCsAYBxlLHSJNdy28/s905FuVxrLwr3xv/HjoVgi9eDGL5aVddD5jZX8QlLQfJC09FROKtbfq@nongnu.org
X-Gm-Message-State: AOJu0YwF39PIkVGlDbKaXrUD/s83GOe1+mmNARRRnRCbdj9UNlEu8Iyb
 7deAmYQr4gYw1KNrbI48qdVip9y2B7pC9mPO/XzdVMWOSeCfFdAk8C9uJouxNFJhzYFw2UbzX4r
 ndOBGRxkFy1ThTOejQLDsuJBUYrgj0kYKBXdd2y99tA==
X-Gm-Gg: ASbGnctacx6tvBWqIrTd1GfIAMJc9xiOymWpP0EQXTH0z5QdOo7Ml1i5/eVXmpK5+Qy
 EovSQKBpSSRcI2cbURN8N1CMHL4SsR8egS6LfxCh9LyH6JPf7SPvrN/jO7mzembG7RmoV1h629k
 l2j+VxxdTVM4AeKAIhljtfWcs1k1pSCdY+FiEM9Bmb1ByBoiT9zmvRmFJ3ZNnHiwYZy6XKJf/u0
 J08fCE/EM5r1NeMTeeMn85IUQVIkAt6JEx+DIbR76p3A8o+vZ8jddWN28o934P1iwhV5TJN
X-Google-Smtp-Source: AGHT+IFAg2YumcuySjrtvUyNbSj7QbdEdxEKe/E54v0oRTAWP52JZPz4gKVQhtXhxZT/tbuTYzOytjU9qmbScF8/i2I=
X-Received: by 2002:a05:690e:2505:10b0:63d:f608:4cb6 with SMTP id
 956f58d0204a3-63e1613e4c4mr12950510d50.23.1761067387367; Tue, 21 Oct 2025
 10:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-3-peterx@redhat.com>
 <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
 <aPex9SsQOup69DRI@x1.local>
 <CAFEAcA85DRf5918ea9N66+Z7M_vVGNy+-SdSx17E5MGOf_cbMA@mail.gmail.com>
 <aPe4yBqkPTiDiYXq@x1.local>
 <CAFEAcA8e7qKGm7vq-8TFC40VMfoGU_O5+U0rrKG+Z8M3fVdRfg@mail.gmail.com>
 <aPe9Z0IiEI6mzCdY@x1.local>
In-Reply-To: <aPe9Z0IiEI6mzCdY@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 18:22:55 +0100
X-Gm-Features: AS18NWC_vI-Q1FXMFZypmrjV0mO6ysNm7tRRKf-V8veof-YZ7Q6T9GGKj8FfwgU
Message-ID: <CAFEAcA_BAxh8BAYPAbPEp_P98gMUdZqZ=2XZHrmGQ+GyEViF_Q@mail.gmail.com>
Subject: Re: [PULL 02/45] migration: push Error **errp into
 vmstate_load_state()
To: Peter Xu <peterx@redhat.com>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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

On Tue, 21 Oct 2025 at 18:05, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 21, 2025 at 05:49:51PM +0100, Peter Maydell wrote:
> > I suppose so, but that seems like something in practice
> > we make a lot of use of. It's really handy to be able to
> > say "this is how you obtain the integer you wanted to put
> > in the migration stream" -- we do a fair amount of that
> > in target/arm/machine.c for instance. But those don't
> > need to return a failure, I suppose.
>
> That's exactly what pre_save() / post_load() should do, IMHO.
>
> Taking example of the arm's case here:
>
> static int put_fpscr(QEMUFile *f, void *opaque, size_t size,
>                      const VMStateField *field, JSONWriter *vmdesc)
> {
>     ARMCPU *cpu = opaque;
>     CPUARMState *env = &cpu->env;
>     uint32_t fpscr = vfp_fpcr_fpsr_needed(opaque) ? 0 : vfp_get_fpscr(env);
>
>     qemu_put_be32(f, fpscr);
>     return 0;
> }
>
> The .pre_save() should be exactly the logic that generalize whatever we
> have had in QEMU's structs into a pure uint32_t, put that into a temp
> u32. Then migration should be able to transfer that using whatever way it
> prefers.  When using qemufile API, it should use vmstate_info_uint32 so as
> to not open-code qemu_put_be32().

I think this is very ugly, because it means that the device state
struct ends up with a pile of extra fields whose only purpose
is to be temporarily used during migration. Having a function
which does the "figure out the value at the point where we want it"
is a much nicer API because it keeps the migration related
complication in the migration code, and keeps it out of the
data structures that all the rest of the code has to work with.

> Now, we have a major issue with qemufile and all the APIs that bound to it
> when we want to move the IO layers from qemufile to iochannels, exactly
> because we lack such abstraction layer, where we mixed up "this is how you
> obtain the integer" and "send this integer to the wire" operations in one
> API.

Yeah, this is unfortunate. But I don't think the solution is
to require a lot of extra device state struct fields to carry
temporary data for migration. It would be better to have an
API similar to the existing get/put functions but which
passes the data back to the caller instead of calling
qemu_put_be32() itself.

thanks
-- PMM

