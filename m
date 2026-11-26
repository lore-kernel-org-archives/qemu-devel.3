Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3B606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jolo3BUR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWeEC-0003oM-3K; Thu, 26 Nov 2026 13:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWeE4-0003lF-L9
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:29:45 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWeDt-0004qQ-Vc
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:29:44 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c516a192844so761801666b.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795717771; x=1796322571; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WCu8KksTYS8pKGkXjwXdgnAVxOvq264k6UZSZGw6Qvc=;
 b=jolo3BURjovJOkyh8ExuUW6sAM2JM56PqwB5V6AnbN1Rj9UtdPWAUGEOwyRxwuTOjR
 JqyMHhlHOB0SjnGt6T4p364c6ptsgnuItT847hen0tds4EXqw9rJlo2Zri4Ymes30shr
 0LhFsG+87Tx7SSBbxhLbV410UkCpuhG3hm+ODEFsuzGXSyU//NOc2yd1+ShozaOqcHUi
 NUyF5rgqBz7zIZTXjcG0Rqv/mUUMJl1W4W68x6qNWTzD9SDkdmVx4lXzBWghIUEK7kzU
 NEqS5/vcsL8ffkkOqdRYwuBbI7sFZew9r6AKbV/Q7h/oOHFC5tAg/Gb6mxL/Vvg1fbG3
 WGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795717771; x=1796322571;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WCu8KksTYS8pKGkXjwXdgnAVxOvq264k6UZSZGw6Qvc=;
 b=WdR0zhOZxaOu3dKCAE0/WJSTymqht7ZVs8aQ2BvwKUctNyWk5bdHxNMyAKT0fAkUiI
 S4wOJAvVcJZ1oz9AG1Asz9qvGEii7LRbHd1ZBx8pAuQAav7ke26dQXE2sIh86gLOsZSZ
 SpVVNNfMTjljpr7IiKgcWCNilVS8dgMmMMxIz/uzcgq5jRZV5JMsmV2VsKGLJbB1r7Eq
 x/CDbbcUsjB3IGzPwlv6O2Qewlyqrismm8xH1eGkBxrLOknqZaqbZcSrBevBwJrDQWZU
 QKFZQb6lXMdvl+Rq/qi4MI3+cQtNpO7DOSAZm5tngEAFO6XMLV1utLTE7ucq86QKLw9K
 idTA==
X-Gm-Message-State: APuU4Z9BMq3xJIgObiANfCjRGsv7AEIwwbBQN1It724sH6oairJUQc63
 Pyq90pitYwsJiEVhYOnMu0/F6xF352nqF+VetAoEozQ7zlmIr+S5JN74
X-Gm-Gg: AZFdTZcMitXKKBsTNPC1IKyrwG6SEjTcvn51Z+AzrArX+HM6j6twpoOV1zXxEE+Dwpq
 VJbes6D8c5/Evax8Fi2mkhTUzSoFgaw9hW1OlHe7bpKy30ClMxgw0In8UpDA+6rtyoA2a/XBrfP
 nHaP+zlWS6T3IS6yxhPJn8LVRsnqqNshxzAut/wA55Hi9ZNJHAlkTyuoSKy2FkGSH7ci2LEhfTh
 DQAkplIAc4Ods3ZVRksG8FY3ryrrXh7pNDl4/CgW+K30fUYKJZsk9CT4mTBLgcfaJ6Nwu5tdVWJ
 VFbSyhPcN138zfzPM21quqNaX6Vgwj6i+5uXyqmUHFQzKzd8u2FeRHKldoGWpGLoKHktkufc6L8
 sWnGlmVaFYljnU0BXngQ0zKIDiZP3FSGJ4YDL5yWZY7+ePLbgKOKv18Y8r5lYUubkPpvna9uEvy
 zKnqxfBoAtODRQczKMMj9fTzOhxZkVXL/v00/5cjmb5GUVJ2wztdlfAokMpfcYroh5NrL3Cdz3H
 hZMG5t6P5JT7aXJs4rtH9yT1FsVC6HsYLv0KwxL7E0F1iXWR5l17+AKrDmyXcx1J2nyNRgi2/y3
 E10xkPc4+VeIBmDyP9snsM0=
X-Received: by 2002:a17:907:da02:b0:c2d:c247:5400 with SMTP id
 a640c23a62f3a-c513a8493eemr1775117266b.27.1795717770670; 
 Thu, 26 Nov 2026 10:29:30 -0800 (PST)
Received: from tulp ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370fa8basm10262995a12.20.2026.11.26.10.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 10:29:30 -0800 (PST)
Date: Thu, 26 Nov 2026 19:28:47 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 01/10] iotests: use gsed when necessary
Message-ID: <awh6X1qydBEI49Zf@tulp>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
 <20261125191701.93931-2-bogorodskiy@gmail.com>
 <awf8atJJ3A_8caLc@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awf8atJJ3A_8caLc@redhat.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Daniel P. Berrangé wrote:

> On Wed, Nov 25, 2026 at 08:16:51PM +0100, Roman Bogorodskiy wrote:
> > Some iotests fail on FreeBSD because the tests call sed
> > directly, and BSD sed is not always compatible with GNU sed.
> > As common.rc already provides the gsed() wrapper, use it
> > instead if needed.
> > 
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > ---
> >  tests/qemu-iotests/115           | 2 +-
> >  tests/qemu-iotests/common.filter | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
> We use plain 'sed' across countless test files, and only call
> 'gsed' in one test file and common.filter. It feels like a
> loosing battle to keep fixing things to use gsed when they
> hit an incompatibility.
> 
> How about we rename the 'gsed()' wrapper function to simply
> 'sed()', and thus make GNU sed a mandatory dependency for
> all tests.

I'm personally fine with this approach, gsed is easy to install on
FreeBSD and it's a lightweight dependency. It could possibly cause some
inconvenience for people working on other OSes/platforms though.

On the other hand, changing sed to gsed once in a while is not too
cumbersome either.

> 
> > 
> > diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
> > index 5c8a12f85a..e3ff91de7a 100755
> > --- a/tests/qemu-iotests/115
> > +++ b/tests/qemu-iotests/115
> > @@ -78,7 +78,7 @@ _make_test_img -o "refcount_bits=64,cluster_size=512,preallocation=metadata" 256
> >  # qemu-img check for that purpose, too.
> >  
> >  $QEMU_IMG check "$TEST_IMG" | \
> > -    sed -e 's/^.* = \([0-9]\+\.[0-9]\+% allocated\).*\(clusters\)$/\1 \2/' \
> > +    gsed -e 's/^.* = \([0-9]\+\.[0-9]\+% allocated\).*\(clusters\)$/\1 \2/' \
> >          -e '/^Image end offset/d'
> >  
> >  # (Note that we cannot use _check_test_img because that function filters out the
> > diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> > index ce4213cb97..f7211a0a29 100644
> > --- a/tests/qemu-iotests/common.filter
> > +++ b/tests/qemu-iotests/common.filter
> > @@ -130,7 +130,7 @@ _filter_actual_image_size()
> >  # Filename filters for qemu-img create
> >  _filter_img_create_filenames()
> >  {
> > -    sed \
> > +    gsed \
> >          -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
> >          -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
> >          -e "s#$TEST_DIR#TEST_DIR#g" \
> > @@ -296,7 +296,7 @@ _filter_qemu_img_map()
> >          data_file_filter=(-e "s#$data_file_pattern#\\1#")
> >      fi
> >  
> > -    sed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
> > +    gsed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
> >          -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
> >          -e 's/Mapped to *//' \
> >          "${data_file_filter[@]}" \
> > @@ -310,7 +310,7 @@ _filter_nbd()
> >      # receive callbacks sometimes, making them unreliable.
> >      #
> >      # Filter out the TCP port number since this changes between runs.
> > -    sed -e '/nbd\/.*\.c:/d' \
> > +    gsed -e '/nbd\/.*\.c:/d' \
> >          -e 's#127\.0\.0\.1:[0-9]*#127.0.0.1:PORT#g' \
> >          -e 's#localhost:[0-9]*#localhost:PORT#g' \
> >          -e 's#host=127\.0\.0\.1,port=[0-9]*#host=127.0.0.1,port=PORT#g' \
> > -- 
> > 2.56.0
> > 
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> 

