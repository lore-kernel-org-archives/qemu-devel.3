Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9E2EEE26C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 11:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp4lY-0004Q6-7S; Fri, 13 Sep 2024 07:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp4lT-0004PV-Hd
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 07:47:03 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp4lR-0005tj-Pa
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 07:47:03 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so2338265a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 04:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726228020; x=1726832820; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5tduwmqf1GGVJMXg9C25PdIRt1XxKK0PLXx2Oe5PyYI=;
 b=JUyXiaxd/stcuYjJMq1zk7zYpgrjfE4yz+DSRfOC5UPcbpKpc+2JSPe3fG8qgDOs9a
 3P3KQnZyolz56uBA7Co0/vf9S0Iw7P2HVI2fbbXz4DQQfpqMFHf9cIPe6wbIMGWu7+xB
 gR1biKRnMZeagCMEOiCoyVj8E0bMWoaoaX7HM1QAiiJnaRHIl/TACf8vMg6RauKqReC1
 97aE8ZSENoV3YyoMhcKzH1wn9kkZ4M+IPd2HcAASEX8iK5oQtczpdbQdeyvaGMFGEqxc
 IyMVurXWc2P0/yUuBeHH06PtKnNLCYEAjdt7wYuWwZO3NHObPnBlUGJ1uclm5HQjkZcM
 1sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726228020; x=1726832820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5tduwmqf1GGVJMXg9C25PdIRt1XxKK0PLXx2Oe5PyYI=;
 b=WVbap8cKesePwYTxySogl4FbzrJ00EkZzlfCoN6+TLjaWcxfta4AETwMAt7dWR8PnT
 O8FdmFY+z00vxhjrL1kmSetbezR07oGs9BmSuG/IZgtYwa3C20kJiZXHpOWuxnTiE+Np
 nR5wsPDeEUYUfjg/8kMoVkImj2quSSa1Lz0ZsuMQWG9hfRTSukadRLIg/B1itVLbdWKk
 q7vs7QfZrAFukp5L3MfP2S2MZEDUXZJwN17Pz+lzk+q6yrjozylgOaHGrxIc89H7EL8Y
 sjlWGRuB5yyLL53yFLDcJSkdKh9xgItX91ZIw5Sz4BGbHHgx50r1pmLOBdarUiC8irKQ
 X75Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdzuF8stEBj4nKUm6X+k7p66QMy6EmLPFBv+fcILij5DEPvnZDmpYkZr74mV2f78sU8OjC622NWkRZ@nongnu.org
X-Gm-Message-State: AOJu0Yx4++bIN9jRZZP9anIplqOHQHwq+T7umLqig7dg2+ksBpLqijyN
 UL9n4RX3k7YKESEFRJGL/+yULVPYu5AwVtjbzF/mb4LBTbH3xeQeVtLKUH170EPW3qXS6C8cQNw
 qQlVX13wpSwpC/3jyoROwzHiYGSgrSGygUpQ4Ww==
X-Google-Smtp-Source: AGHT+IHT1jUFSe5v3nFsM38HRpb8XS1Tmcwy8dGlMedYv6tLxg9eUOku22lmQVBQKEHHU7kKcW3GsHQCGuwvpmKhUJc=
X-Received: by 2002:a05:6402:4406:b0:5c3:d8fd:9a49 with SMTP id
 4fb4d7f45d1cf-5c413e12224mr3653606a12.10.1726228019384; Fri, 13 Sep 2024
 04:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240905210328.25393-1-farosas@suse.de>
 <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
 <Ztq5068xW640qeuD@redhat.com>
 <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
 <87r09wlu87.fsf@suse.de> <87r09nzxaq.fsf@pond.sub.org>
 <CAFEAcA9nHvrm1K=WFQROLDuY-g9F2zk4C0CFk4bqZKc1d5hUFg@mail.gmail.com>
 <878qvvzt8u.fsf@pond.sub.org>
In-Reply-To: <878qvvzt8u.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 12:46:47 +0100
Message-ID: <CAFEAcA8qvtspX5_aiepUy+61R2Kj+q3bgPJM=N29RtjjqjPH1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] qtest: Log verbosity changes
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 13 Sept 2024 at 12:29, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Specifically, if you don't disable the error-exit when qtest
> > is in use, then the generic qom-test tests which say "can we
> > at least instantiate every machine?" will fail, because they
> > assume that "qemu-system-foo -machine bar -accel qtest" will
> > at least start.
> >
> > It doesn't really seem feasible to me to have qom-test
> > know about every machine's specific requirements for
> > how to pass a guest image.
>
> Yes.
>
> > The other approach would be to standardize on "every machine
> > type should happily start up with no warnings even if there
> > is no guest code specified by the user and it would simply
> > execute zeroes". We already do this for quite a lot of
> > boards, including some major ones, so we're certainly not
> > consistent about trying to diagnose user errors in this area.
>
> Fatal error unless qtest is bad, because we take a different path.
>
> Silently executing zero can be hard for users to diagnose.
>
> Possible compromise: warn unless qtest?

That runs into the "tests that pass and do what they're
supposed to do shouldn't provoke warnings" unofficial
guideline... Some of these qtest_enabled() checks are
exactly to suppress a warning.

-- PMM

