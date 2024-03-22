Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391CEC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 20:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnlwz-0005dR-5Z; Fri, 22 Mar 2024 16:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1rnlwp-0005cB-Lo
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 16:57:08 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1rnlwf-0006VT-Q8
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 16:57:07 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c39177fea4so1663813b6e.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711141016; x=1711745816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:user-agent:message-id:date
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpBKS0Dv9U+l1jQi5957HwBueD43x2EP6cmhv5Pm5k8=;
 b=kNvLtQWC0wyh6en1o5raJK8aH2s7nSxPJXQkUiaXGO35Q2U/fEuUPdZcT1eS9eFx4+
 khdVqqZBTYzJ0d6/ECr/NY23VO5pcBeksFZvm2+TQElhhxKDLsaef/Fr7Z7Qw+wZRMOF
 B7z4mI9/HfLVDJhbOzRuSfNNEfWpgnRnzQKkCJJIhiVEVBTto8jrKsHxKh/RMKAWlI/i
 6/O/zPwkA6EiIJ4syv/vTQvnJLhREgQvnicgljaQWXmWaz2gRQnLygMRdnhnSDLDOx5M
 lSpuKNaNpkzwY+RjU58ApuRPRVgm2e2dnEKDve8qRBLnYx8c0SlZcYThpCFxfpEvzYoK
 maVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711141016; x=1711745816;
 h=content-transfer-encoding:mime-version:user-agent:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kpBKS0Dv9U+l1jQi5957HwBueD43x2EP6cmhv5Pm5k8=;
 b=NRtZM/vakO1E9Tp7Y3QlrfZcOezC1gxH9Dg45Ha3So+7tu6tqXU0bCqa4BtfMsp6Sj
 1SjXdWVHLIhrP93El7kBJGQU2u3xV212Q6JGLq+pXOIFYCTmfRfvTZgFV4IvzAHouUKZ
 xQrhe54qBsve2JKJdk37orcaYkgSjuJEqwHLhmdLV6qJmEM8b9WYjI84HWiz+bxculEs
 qqSAR/dqFk/+3apsJ3yA6yi93Ype+V5WzMP7fL703ipfdLlBxKThNZzzfV/pweuUCvt8
 QC5JJ7/2mAijW8H6mWOd50KygQDLU0WvFOZE/y4uKHOD7c9oaHVMQBxwCnCzKn8bcIxc
 Aufw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWWz2fxKATfI/2qN9CIO9Kio7xqw9Qjb09VvCkxEP+8DAhR1RnEWzGTduykGkjHHYQp+RIBZLpwH/ca4qimkKJyVRpss8=
X-Gm-Message-State: AOJu0YzNro9ydOep28LzhuH6jwGNzZmNtYKCbMsLqn0RYGpexXRbW0LS
 P83sAZFCR/nQjOt42tmRfBRm56RwOuosGKtGsZq4vCC/PsStd+Qe
X-Google-Smtp-Source: AGHT+IFoQJQmtWmu0FHGG4b+SreSX/qnVLgxSD1vhkBxDiagvD9+ddS3xAj5Th7xKoOekFvV5OBqMg==
X-Received: by 2002:a05:6808:2a61:b0:3c3:c0e2:d40c with SMTP id
 fu1-20020a0568082a6100b003c3c0e2d40cmr476005oib.41.1711141016550; 
 Fri, 22 Mar 2024 13:56:56 -0700 (PDT)
Received: from hurd (dsl-205-236-230-232.b2b2c.ca. [205.236.230.232])
 by smtp.gmail.com with ESMTPSA id
 gd14-20020a05622a5c0e00b0042f21fe66f7sm170985qtb.73.2024.03.22.13.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 13:56:56 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,  John Snow <jsnow@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] build: Re-introduce an 'info' target to build a Texinfo
 manual.
In-Reply-To: <ZfmAHbtfJNn-mrEN@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 Mar 2024 12:07:57 +0000")
References: <20240318030437.17503-1-maxim.cournoyer@gmail.com>
 <CAFEAcA9FefR6a48ZO5SgvjOGGYT3t4hxt9OqsybV2e-15HNzTQ@mail.gmail.com>
 <ZfmAHbtfJNn-mrEN@redhat.com>
Date: Fri, 22 Mar 2024 16:56:54 -0400
Message-ID: <877chukmsp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=maxim.cournoyer@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel,

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Mar 19, 2024 at 11:47:59AM +0000, Peter Maydell wrote:
>> On Mon, 18 Mar 2024 at 03:05, Maxim Cournoyer <maxim.cournoyer@gmail.com=
> wrote:
>> >
>> > This reinstates
>> > <https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09228.html>,
>> > which was committed at some point but reverted many years later in
>> > cleanups that followed the migration from Texinfo sources to the
>> > ReStructuredText (RST) format.  It's still nice to leave the option for
>> > users to easily generate a QEMU manual in the Texinfo format, taking
>> > advantage of the Sphinx texinfo backend.
>>=20
>> As far as I can tell, we never committed that patch, because
>> (as noted in the discussion there) we don't particularly want
>> to generate texinfo output (and also because it was missing a
>> signed-off-by line). So this isn't a regression: we've never
>> generated info docs since we switched away from texinfo to
>> rst as our source format.
>>=20
>> I don't think my position personally has changed on this one
>> since your previous patch submission. Other QEMU developers
>> are welcome to weigh in and disagree with me.
>
> I tend to agree with your point in that thread above. It is already
> a big enough burden for maintainers to ensure that the HTML output
> for their docs is rendered effectively. Adding an 'info' docs output
> increases that burden for negligible benefit. HTML is the most
> broadly consumable docs format, so it makes sense to focus our effort
> on that.

For me, the value in Texinfo is that it can be consistently be used from
both headless environment (pseudo-terminal) and in graphical
environments with more capable viewers (Emacs, Yelp, ...).  Its viewers
typically offer better search capabilities than man pages viewers or
most HTML browsers (e.g. jumping to topics via their index or node
names, or searching for a regexp in the whole document), and its on disk
small size means it can easily be shipped along the program itself,
ensuring the documentation stays in sync with the documented program.

Using GNU Guix for years, where Texinfo is used as the standard
documentation system and where its enabled in most packages that support
it, has allowed me to appreciate the qualities of Texinfo as a
documentation system that I don't find in either man or pages or HTML
documentation.

--=20
Thanks,
Maxim

