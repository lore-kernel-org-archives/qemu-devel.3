Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0E4C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlFz-0006gu-6Z; Tue, 30 Jan 2024 05:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUlFx-0006gK-T8
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:22:17 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUlFv-0005v6-B5
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:22:17 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40ef6bbb61fso16467565e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706610133; x=1707214933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kIafumXK1cXSV78KiLyZvbw4P/pMFo6LAFAlZGmXJb8=;
 b=lf11AU+gg5XdTFA8WCS7OQKcyCWFrX59EBjJdFiPfCuAv/8cKPnrfE3+M6XEf+X4aj
 DJBgsiBf+ymrJL7hyB9MkImnY7GYHMV59V6zRClU0x5OF4HcNkbmyKwDljUJ1J2pbsxj
 3ZLs1wjWLBjOUJk9nLW6dLYw3QLNVh23uBGJA6WpozVIv9VF1vkfDgCQI0f0qZNqs+um
 0oveWjrD0A4i4+3zBXQ/fm9JVWDLFsFBSjGJS6AZgPX9gZcHhpMQb4thd7pw4c8ZFQOK
 FX25elctGIOO44BPkg7uE3ExOGEriaf7W6xWRgo1h3uILcM8pEy65TV/obI8+1KGg5BT
 2m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706610133; x=1707214933;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kIafumXK1cXSV78KiLyZvbw4P/pMFo6LAFAlZGmXJb8=;
 b=w2YBQXNECkk0PQba2zCrkpaAJo/SSgQuvQnqrNI6788G2KVgrgP++1OiIraHjDWJf9
 ZYrtVnUiNgr5KLlHlWJG7DmqRAIPOTHrRZMh5eeS6w8+uWPQCeDk/gHqP+ve1VdBto1d
 cZk3dX9KQirN07TLfDnFC1cTebKauqtPNoOspYGnxkR4Sj2IguhD9zeHLy5uUNqdjLFg
 Q3imvO6Vtz2kIpnF3nDMKP12Y+i2o7oFnq8IbPHhHlLNZz4er85L2ieF27un9w8Yi3GM
 V+EGkeYxkF4w8ej/q58JZgm1jF70J/g/L473clD7eDxWtoyAgc6ytkA2oQ/aWQBiVEhu
 KaYg==
X-Gm-Message-State: AOJu0YxcaunFt7AL1LSXoewwzgVLUFLRJ2o+rOU8i9a/IvoDCskMUqql
 hlkC8NlrBQ+TyC/c1SXGXU9TqLXtFUuEos8C97tp92p+3evhI4/NX06kEpF8ynw=
X-Google-Smtp-Source: AGHT+IGm4pwVoBlt6sPmsLJzKE6acjc3YMElBUpO65tNY78+64Iqj1I4mQU5+FXcJBXBcNsG1I97ww==
X-Received: by 2002:a05:600c:502b:b0:40e:f9d4:2b03 with SMTP id
 n43-20020a05600c502b00b0040ef9d42b03mr3237053wmr.12.1706610133344; 
 Tue, 30 Jan 2024 02:22:13 -0800 (PST)
Received: from meli.delivery (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 g7-20020a05600c4ec700b0040e5945307esm12705075wmq.40.2024.01.30.02.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:22:13 -0800 (PST)
Date: Tue, 30 Jan 2024 12:17:18 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v1] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
User-Agent: meli 0.8.5-rc.3
References: <20240130075615.181040-1-manos.pitsidianakis@linaro.org>
 <ZbivaYQ1rC6AgHbU@redhat.com>
 <CAAjaMXaxqEGDY3RwSPns-Rr67-RV-9CL35XkKMyEhrryYAqsfQ@mail.gmail.com>
 <ZbjFmQNrq3zVb5l6@redhat.com> <82jli.0uwnyp8y89dd@linaro.org>
 <ZbjInI4T-tJCebIw@redhat.com>
In-Reply-To: <ZbjInI4T-tJCebIw@redhat.com>
Message-ID: <82ksy.fm0dt4we1re8@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024 11:59, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Tue, Jan 30, 2024 at 11:54:51AM +0200, Manos Pitsidianakis wrote:
>> On Tue, 30 Jan 2024 11:47, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>> > On Tue, Jan 30, 2024 at 10:51:58AM +0200, Manos Pitsidianakis wrote:
>> > > On Tue, 30 Jan 2024 at 10:12, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> > > >
>> > > > On Tue, Jan 30, 2024 at 09:56:15AM +0200, Manos Pitsidianakis wrote:
>> > > > > Check if a file argument is a cover letter patch produced by
>> > > > > git-format-patch --cover-letter; It is initialized with subject suffix "
>> > > > > *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
>> > > > > exist, warn the user.
>> > > > >
>> > > > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> > > > > ---
>> > > > >  scripts/checkpatch.pl | 14 ++++++++++++++
>> > > > >  1 file changed, 14 insertions(+)
>> > > > >
>> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> > > > > index 7026895074..34f12c9848 100755
>> > > > > --- a/scripts/checkpatch.pl
>> > > > > +++ b/scripts/checkpatch.pl
>> > > > > @@ -1650,6 +1650,20 @@ sub process {
>> > > > >                       $non_utf8_charset = 1;
>> > > > >               }
>> > > > >
>> > > > > +# Check if this is a cover letter patch produced by git-format-patch
>> > > > > +# --cover-letter; It is initialized with subject suffix
>> > > > > +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
>> > > > > +             if ($in_header_lines &&
>> > > > > +                 $rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>> > > > > +        WARN("Patch appears to be a cover letter with uninitialized subject" .
>> > > > > +             " '*** SUBJECT HERE ***'\n$hereline\n");
>> > > > > +             }
>> > > > > +
>> > > > > +             if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
>> > > > > +        WARN("Patch appears to be a cover letter with leftover placeholder " .
>> > > > > +             "text '*** BLURB HERE ***'\n$hereline\n");
>> > > > > +             }
>> > > >
>> > > > Indentation here is totally off
>> > > 
>> > > It only seems that way because the pre-existing lines use tabs, while
>> > > I used spaces, according to the QEMU Coding style:
>> > 
>> > It is more important to be consistent within a single function.
>> > 
>> > Regardless of that though, the indent is still broken because the body
>> > of the 'if' condition is indented /less/ than the 'if' condition itself.
>> 
>> Well not really, that's because my editor replaced the tabs when quoting
>> your e-mail.
>
>The under-indentation of the WARN statement has nothing to do with
>reply quoting, it is visible in the initial patch you submitted:
>
>  https://lists.nongnu.org/archive/html/qemu-devel/2024-01/msg06216.html

The html in that link has expanded tabs to 8 spaces :) And QEMU coding 
style says an indentation level is 4 spaces.

This is one of the reasons tabs should not be used for indentation at 
all. It shows up different in different contexts.

Anyway, it's not very important in any case. Besides, I have superseded 
this patch with a v2.

Thanks,
Manos

