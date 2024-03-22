Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA53C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 20:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnlLD-0006tj-7i; Fri, 22 Mar 2024 16:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1rnlLB-0006tX-67
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 16:18:13 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1rnlL6-0005Yr-LH
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 16:18:12 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-69185f093f5so19391546d6.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711138687; x=1711743487; darn=nongnu.org;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x1z5oT2CNjnIGEByGO1g5aqDC9b+j3Jqg+xE+Fuo2XY=;
 b=kSrQDK4Bdz9Xb+EFeB78wzVcK7Ya7w9roWULEkGEUUKII6nsTSM93Bi1l25QnBiodX
 chPJMhOTwKSTVpEDsdNy7a6yOeD7GT5pg4Ms0gt2CDO4YnrXflGx0nyTf2UzX4lWv7KK
 Kf1reYHq1diEQdkdaH/xgX/quN5ZJJ/0HCnTNbP60l4sxg/8j89lhTkor6Pj8HocFU0i
 7OG9jHVa+CkEqczITCnqupzDYwv+RcXfv59Os25tKl7YXr5FXUdl1R1TcVhiqbQNJx2W
 0OW7I2Mp5gmYUXqN8GogbsQ/TCNfcG6snL5FSo44yFkFUguoXhL7LDXijgREcLl90zya
 fYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711138687; x=1711743487;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1z5oT2CNjnIGEByGO1g5aqDC9b+j3Jqg+xE+Fuo2XY=;
 b=N/P8K/8rmFBh8e5+ItuByLIsp5S+AsARfOfuvpu+nsx+SYiDPNRQZOHAO20uWkHp1J
 JEeUihBXYvuDxG3vUuUIiVCmqzXHGz2wjQhRlFi+3BXQt0KHnE88jX7TW1SFSr2k6loU
 dpGmoa0beSWRGiaDhGOILMRCqGLQN+C2hp4cPXbBWMdhkbrRqfbs3/lXGeI1Jk83mjz9
 g1f6Znp3HS69xfNN/pyETOmxXyhPTS+Po6TTPkne4YfuDTFOCrNwue5njxGgVEBDyxTB
 9C4PusGJXlckL0HOpq5VhO9yjXOJ7RVYeeRgMM7PiNpW7t/FnMH/waqljtAOo/pQ3qjL
 EIVw==
X-Gm-Message-State: AOJu0YyIfGb9uMQQAy9cmcEKH8y/gu+1mCNs9W5JNgaBOtQV66nHX/rx
 1seKHLaLpQ54RlxThtDUkCGbkxufvO2YjQEoRcG2R3/JczDsBh6/lAIjQy8V6Yc=
X-Google-Smtp-Source: AGHT+IFQORnqkrQa3E7c9g15q1FPeV5GtezgW7ofQ3rYjrvB+ZWRUgjf8QSkY2WWWf1Mpzzw6XHpQw==
X-Received: by 2002:a05:6214:da6:b0:696:719e:a0eb with SMTP id
 h6-20020a0562140da600b00696719ea0ebmr550991qvh.11.1711138687269; 
 Fri, 22 Mar 2024 13:18:07 -0700 (PDT)
Received: from hurd (dsl-205-236-230-232.b2b2c.ca. [205.236.230.232])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a056214040400b006914cd7a8b1sm1399172qvx.48.2024.03.22.13.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 13:18:06 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  John Snow
 <jsnow@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] build: Re-introduce an 'info' target to build a Texinfo
 manual.
In-Reply-To: <CAFEAcA9FefR6a48ZO5SgvjOGGYT3t4hxt9OqsybV2e-15HNzTQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 19 Mar 2024 11:47:59 +0000")
References: <20240318030437.17503-1-maxim.cournoyer@gmail.com>
 <CAFEAcA9FefR6a48ZO5SgvjOGGYT3t4hxt9OqsybV2e-15HNzTQ@mail.gmail.com>
Date: Fri, 22 Mar 2024 16:18:05 -0400
Message-ID: <87bk76kole.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=maxim.cournoyer@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Peter,

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 18 Mar 2024 at 03:05, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
>>
>> This reinstates
>> <https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09228.html>,
>> which was committed at some point but reverted many years later in
>> cleanups that followed the migration from Texinfo sources to the
>> ReStructuredText (RST) format.  It's still nice to leave the option for
>> users to easily generate a QEMU manual in the Texinfo format, taking
>> advantage of the Sphinx texinfo backend.
>
> As far as I can tell, we never committed that patch, because
> (as noted in the discussion there) we don't particularly want
> to generate texinfo output (and also because it was missing a
> signed-off-by line). So this isn't a regression: we've never
> generated info docs since we switched away from texinfo to
> rst as our source format.

I see.  For the record, very similar changes were contributed and
successfully merged into the Linux [0] and U-Boot [1] projects.  No
problems appear to have been caused by these in more than 2 years time.

[0]  https://lwn.net/ml/linux-doc/20221116190210.28407-1-maxim.cournoyer@gmail.com/
     merged with commit 1f050e904d

[1]  https://lists.denx.de/pipermail/u-boot/2022-December/502355.html
     merged with commit 7fa4c27a2e

> I don't think my position personally has changed on this one
> since your previous patch submission. Other QEMU developers
> are welcome to weigh in and disagree with me.

My position is also unchanged re-reading the past thread; that the
maintenance burden would mostly be on the Sphinx project rather than
QEMU.  The info target doesn't even need to be tested by upstream; my
opinion is that there's value in making it easily available for
downstream users such as GNU Guix to use.  The target is not built
unless 'texinfo' is available in the environment, so your CI can
continue not producing it, if this is preferred.

Of course, GNU Guix can continue to maintain it as a custom patch
applied to QEMU, but I think it'd be nicer if it lived in the QEMU tree,
potentially benefiting others.

> (If we do enable this we might want to see whether we need to
> set texinfo_documents in conf.py or if the defaults are OK.)

The defaults appear to be fine.  The output file is 'qemu.info', and
'qemu' is a fine name for an Info manual.

-- 
Thanks,
Maxim

