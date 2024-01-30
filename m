Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF0EC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUkqw-0008EU-Jn; Tue, 30 Jan 2024 04:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUkqu-0008E5-Rp
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:56:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUkqg-0001lM-PX
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:56:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so45340735e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 01:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706608569; x=1707213369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+ldE/gpFsWWyr3lRM7CqeH87onTNiu7fYfacV2M2yR0=;
 b=MxvitVhN5PR4t0ABUYuq+shxpqRoGn+FZ2MnqvJDJi0WYqtMlPKOYB+y7IEVr09Jr4
 7ioQizwYC6iRzFu8ys6jbYP3QmoVd9kp5GUbW7Vqkyzg1OBpUp4Gv35CGtT7grS334O8
 WoMy2EXTcql2kGgEXlBNwZxZ5I/MUdal3uFEVBcVGxjOxHgsHmjFvIwfxXSHMsjZMfLK
 RqpuwkKQTOCowsuGFkm1VrVCK6X2FeOyuqm3pd2xaJ6HReUaQCaSgFGYA8wB1qJRDNEr
 wqjKal3uXR5tf80Pdg30Q7FyI6VEtECcLpl99t0o098goyk7FbRDTVM1rPD36DFOlczu
 VXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706608569; x=1707213369;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ldE/gpFsWWyr3lRM7CqeH87onTNiu7fYfacV2M2yR0=;
 b=YLz8wLM436m9J+/MAqx6cKFkT3I28pX560AeS2aCELwILqBMaj23LxBB9NvU82IZb9
 KJNsTFi+YXXXAKR2bc+B6CuZpojvsG85ozvHBIOo/fPTIXIDHc5S5tkRz63Eln/uvVeR
 c2pOu1sZtOXhfIafbjAmyUeAqEVUprhnajqo4aTNJQ8/dspZG0IEc2NiOBltt72ljejP
 ylvC/kwn5BkeT9xVG6T9vTdDylj5UlMHFF/CzRyi78nlgbi22abTL54VdyXTO4shrs9q
 4bo1D7AnWaC9I9gLCkcbTaqGbUawDxTUPfNsEsEKQFBAIjDhNUff/k8wayRp/n6i2D7R
 0/dA==
X-Gm-Message-State: AOJu0YxBbRrZzAmQp/TMO3MovWpYtOw/9lIBBux2MqAHOy91FxRMECJC
 ztvJKhIbq7n5NWABJC9BLbaCtNeOHCuumXss4BZ3keW5aoGNUk8DHvJGhtDgmWE=
X-Google-Smtp-Source: AGHT+IHWj6E/ZelTFIQ63ZxNEqipY80afNOmIT7/Usw3qO/DzTOHF3Sh/woOVrCQPrcaORGHRR1fJA==
X-Received: by 2002:a05:600c:420a:b0:40e:d30b:6129 with SMTP id
 x10-20020a05600c420a00b0040ed30b6129mr6514772wmh.13.1706608568649; 
 Tue, 30 Jan 2024 01:56:08 -0800 (PST)
Received: from meli.delivery (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 bv25-20020a0560001f1900b0033aec64ba7dsm5541401wrb.78.2024.01.30.01.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 01:56:08 -0800 (PST)
Date: Tue, 30 Jan 2024 11:54:51 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v1] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
User-Agent: meli 0.8.5-rc.3
References: <20240130075615.181040-1-manos.pitsidianakis@linaro.org>
 <ZbivaYQ1rC6AgHbU@redhat.com>
 <CAAjaMXaxqEGDY3RwSPns-Rr67-RV-9CL35XkKMyEhrryYAqsfQ@mail.gmail.com>
 <ZbjFmQNrq3zVb5l6@redhat.com>
In-Reply-To: <ZbjFmQNrq3zVb5l6@redhat.com>
Message-ID: <82jli.0uwnyp8y89dd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024 11:47, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Tue, Jan 30, 2024 at 10:51:58AM +0200, Manos Pitsidianakis wrote:
>> On Tue, 30 Jan 2024 at 10:12, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> >
>> > On Tue, Jan 30, 2024 at 09:56:15AM +0200, Manos Pitsidianakis wrote:
>> > > Check if a file argument is a cover letter patch produced by
>> > > git-format-patch --cover-letter; It is initialized with subject suffix "
>> > > *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
>> > > exist, warn the user.
>> > >
>> > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> > > ---
>> > >  scripts/checkpatch.pl | 14 ++++++++++++++
>> > >  1 file changed, 14 insertions(+)
>> > >
>> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> > > index 7026895074..34f12c9848 100755
>> > > --- a/scripts/checkpatch.pl
>> > > +++ b/scripts/checkpatch.pl
>> > > @@ -1650,6 +1650,20 @@ sub process {
>> > >                       $non_utf8_charset = 1;
>> > >               }
>> > >
>> > > +# Check if this is a cover letter patch produced by git-format-patch
>> > > +# --cover-letter; It is initialized with subject suffix
>> > > +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
>> > > +             if ($in_header_lines &&
>> > > +                 $rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>> > > +        WARN("Patch appears to be a cover letter with uninitialized subject" .
>> > > +             " '*** SUBJECT HERE ***'\n$hereline\n");
>> > > +             }
>> > > +
>> > > +             if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
>> > > +        WARN("Patch appears to be a cover letter with leftover placeholder " .
>> > > +             "text '*** BLURB HERE ***'\n$hereline\n");
>> > > +             }
>> >
>> > Indentation here is totally off
>> 
>> It only seems that way because the pre-existing lines use tabs, while
>> I used spaces, according to the QEMU Coding style:
>
>It is more important to be consistent within a single function.
>
>Regardless of that though, the indent is still broken because the body
>of the 'if' condition is indented /less/ than the 'if' condition itself.

Well not really, that's because my editor replaced the tabs when quoting 
your e-mail.

Anyway, I will respin a v2 with just tabs for indentation right away.


Thanks!




>With regards,
>Daniel
>-- 
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
>

