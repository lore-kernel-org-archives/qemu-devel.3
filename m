Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B15606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rjNRZfWk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1LV-0005bf-7y; Wed, 28 Oct 2026 06:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xM1LT-0005bI-56
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:57:27 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xM1LR-0008Eo-A8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:57:26 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c4682977f9aso93686366b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793185043; x=1793789843; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1dWlegDEiiiEUbtE4wj/AwFxRr0xKtgLCA0YHRg9uPQ=;
 b=rjNRZfWkwvzFGkmRCQSemgp8jakp3bD2qYGCMWKbcHktHMrCgqeedmK+j3s9xSkS5U
 1fwIgSPNoIkSYF9hdXqPjhXHxv8YejblgFo1pVXaLnlJkp1QuR9UGjdDYuQj4DhbcQLl
 FwNNm+UI9Jw5kDvRG7+u6hn352IZ4apQM8tTCHOWErstUWZxjAXMwsMoyn6hFM/saRrk
 acX+DZrb3bhTD/uX400AsDKP43q1g/+HS2QliGRN0xuQEZMX6bmJWjuQf9uCQ6jce4z8
 84HGy3LWa9EV0DmSxmbAYFuJ7qbkUTTaspdcNf4PzkFpkWFvFCpP7oOYsBTyuLXlpOoG
 L2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793185043; x=1793789843;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1dWlegDEiiiEUbtE4wj/AwFxRr0xKtgLCA0YHRg9uPQ=;
 b=w2wzP2da0MDDdqiY59BZ9DjWa2ft0b/Djw9g5hPaWt/1NVRVe0MD1Jz77TA5BKEQtB
 xQ/LZHzEcOhW4He8/8SOKeQJj3IX13LIKltU9pEOfhmRMM+OQEiNFcC3owbw9kOF1HUz
 8nfEaSd2fUB49x8IhpPiRvcthVlk8NOtXhbB+SvtpKSWsos9fSYyDj4bk+PQASYMjgs9
 1CLC8COU6aRjwGI0OwqMyveHlhvHTymSp007hBLjkrves1SHn/obdj/oQYdi162O9hBw
 1GnN2StEDKMbkuml5AASw7cLV8BZX+Wkaw3YX9B9kSe6fG0A3Ic0RnjvRdHgjVegmDHA
 uVDg==
X-Gm-Message-State: AFq9FYLfTP9/fZ+Dt4Y6Sip94SkjcFEseYg5jygvuMnsckDc1TweX1h6
 ByJ8QbE3kl5JYI4Jy0sXM1y/2AnfeClwBLvLU6grIaO0H/opediz3wFz
X-Gm-Gg: AYBFou1IHX+QYL5SoPrxcouUUBa6iuwC6Zw1eVfIN+05+OBRFJFe/jD6SzcjZ4GX5/Q
 HYzkPMjul8dhyk1kndu0V/W39nnZWiE+w0YV3g8sevgZt8JWjWmZqrXyWlCYY0Y0gd+/G/V68+m
 rKD4iSg/fdx+OaUDx8xH15mo9Yygv/vByvSLVz2p96pUpUSpQtb8cgVQAQCQcWxm99gQfQq3ve3
 GhYDZo6QG1RpWeES1kg5vsnO40+DLdbbU+QQykVk/lCrV5WkotAzpu/YqlT2CDAjNHWK5Q7exJA
 NbuO8iCep5Rxdg+7IQ/mMfIKxdpWXe5qf/Zt6C5/btWhLirS1X2P+T9pnX6lcEJzGnY8T6kxreP
 +WBAzFfG+usl/xyGpJzWGN1TPr232WyI8NNoDvqV9kQ6nGhhqzP3aetRVJTeDR7ljkxGdH2v4/k
 PRF4RxoXyM4NDnH6Wiaknphszm6BvpSIWh3bSjpsXJh8zerPCATm+ecUubFeaAT4JF4PyCIV+Kf
 rbBdb6z3S5xPSdr6YstJTiBX37C2aqFRwPV0KjQ/Etiwuo6KQlmvZiiFIy/WDxPrqMkhaRY/2Vf
 QliInBys3u+lIZvPztJP6a/BEYqEvw1VegjqycbOUrPQZ4m2QcEMCtDr6Hvv77kBIr/UynrsbIX
 ct0XpIt9LLYoFt229AMRcoMswUtIMSBFVVsZ8gt9yQxEGCTA=
X-Received: by 2002:a17:907:d8e:b0:c26:1648:a076 with SMTP id
 a640c23a62f3a-c49bdfb622amr161094066b.49.1793185042404; 
 Wed, 28 Oct 2026 03:57:22 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd649f69sm584437166b.43.2026.10.28.03.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 03:57:21 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:56:33 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2] qga: do not run hwclock(8) on non-Linux POSIX OSes
Message-ID: <auHU4RuV_XTSV0Vn@tulp>
References: <20261015142342.50436-1-bogorodskiy@gmail.com>
 <CAPMcbCpMtRgkWkEPj5xns7xMVCzDOjBcwp8m944q+tTtEPj1Tg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCpMtRgkWkEPj5xns7xMVCzDOjBcwp8m944q+tTtEPj1Tg@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Kostiantyn Kostiuk wrote:

> On Thu, Oct 15, 2026 at 5:24 PM Roman Bogorodskiy <bogorodskiy@gmail.com>
> wrote:
> 
> > Currently, qmp_guest_set_time() sets system time using
> > the settimeofday(2) system call and then runs the hwclock(8)
> > util to set hardware time.
> >
> > hwclock(8) is Linux only, so current implementation
> > always fails while trying to run it on non-Linux POSIX OSes,
> > such as BSDs (FreeBSD, OpenBSD, NetBSD) and illumos.
> >
> > Update the code not to run it on non-Linux. The settimeofday(2)
> > call sets both system and hardware time on these systems.
> > For example, on FreeBSD settimeofday() calls settime()
> > which calls resettodr() [1] which updates RTC clock [2].
> > It is similar on OpenBSD and NetBSD, though implementations
> > differ a bit.
> >
> > Additional detail: on FreeBSD RTC clock setting can be
> > disabled with the `machdep.disable_rtc_set` sysctl.
> > As we cannot do anything about it, do not handle that
> > case separately.
> >
> > Non-Linux POSIX OSes do not provide a common utility
> > equivalent to hwclock -s, so report an unsupported operation
> > when no time is supplied.
> >
> > 1: https://cgit.freebsd.org/src/tree/sys/kern/kern_time.c
> > 2: https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc.c
> >
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > ---
> > Changes since v1:
> >
> > Replace "#if defined(CONFIG_BSD)" condition with
> > "#if !defined(CONFIG_LINUX)" as hwclock(8) is Linux only.
> >
> >  qga/commands-posix.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 837e285b6d..ffd1744b74 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64_t
> > time_ns, Error **errp)
> >          }
> >      }
> >
> > +#if !defined(CONFIG_LINUX)
> > +    /*
> > +     * BSDs (FreeBSD, OpenBSD, NetBSD) and illumos do not have the
> > +     * hwclock(8) tool. These systems update hardware clock when
> > +     * settimeofday() sets system time, so no additional actions
> > +     * are needed. Setting system time from RTC is not supported.
> > +     */
> > +    if (!has_time) {
> > +        error_setg(errp, "Setting system time from RTC is not supported");
> > +    }
> > +
> > +    return;
> > +#endif
> > +
> >
> 
> As only Linux (not POSIX) and Windows support this function
> lets move qmp_guest_set_time to commands-linux and update QAPI with
> 'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }

Hi Kostiantyn,

Sorry if my commit message does not explain the situation clearly enough.

BSDs and illumos do support "guest-set-time" with "time" specified.
On these systems, calling settimeofday() is enough for that, it sets
both system time and hardware clock, so lack of the hwclock(8) does not
prevent it from working as intended.

Only "guest-set-time" without the "time" argument (i.e. setting system time
from the hardware clock) is not supported indeed, which we indicate with
an error message.

Therefore I think keeping qmp_guest_set_time() in commands-posix.c and
keeping the proposed conditional behavior is appropriate.

> 
> Best Regards,
> Kostiantyn Kostiuk.

