Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF90ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snxKu-00014k-2V; Tue, 10 Sep 2024 05:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snxKs-00014C-83
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:38:58 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snxKq-0007Kh-AL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:38:57 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f025b94e07so44100451fa.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725961134; x=1726565934; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JVsUXo1EC0jj3FH2hzr6jMlbK9W9eHzOPJpvQ6LrQWw=;
 b=d1nhcDu8DcY10skTIC7CX5bJoQtNClz9wSMdgcLU88D7vtFZTsyuRDz3iQXQ5GqydS
 Xo3vwSLYVrYc5GDYW/3ooHeiHk1MIPKiRxPA6Et3wt5vSJ82gqqbYAe7EwkqYFh6hdf9
 rCjRpqNzdt3S21/Lb8Nvrfi/xmnZmvFCivIfzybOFbDsZsbhxDxJ+eYo+c3tUqHm67Og
 G7y2WPuE20Pdh9R4IeEcT3ehWutL5Lj7KvxzgT4bDBClxqHhYNwHrsapj1xMxVkpzOsr
 yd9sKmVx2foj22c048Xz+ibSWn2NDWr9vADUPl8O3W+cD8UahqnGiVM5Q5ippDWJXEWb
 wojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725961134; x=1726565934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JVsUXo1EC0jj3FH2hzr6jMlbK9W9eHzOPJpvQ6LrQWw=;
 b=JqGLtsyu8qBvAMi+oyg4cI9QOaWl4AeBFrZXDT3PFS+OlY3rO/gR5as1cYdJWoyZ8l
 4b+w5J+Of+BOR/vh4XJ60LEEKv4xtT9K53VkLMs/jAt+BU72Y5z9lTGg7z2/tUEuAdI4
 Dmet9cnv6VO+bOQG/PXH5Fr7ddZDkkVmRrL2pLN7bzCPSTq/5xiB9cpmz02hcDkSUYcT
 W0RTLhxRD7G6rtFW9UsBtZNkieZs1u4oUDrIIh1FrOVgFr4R1hD3iRUYFtmVdCvZImrh
 aU2XOwgyVWtnUFgNRDnJL47u7Vld1gcshzltDUbD2GdEepWnzdJK2mnEXiQ9b+c67NOC
 dkeQ==
X-Gm-Message-State: AOJu0YwI7wcvlVr81sjiWmAo4okO3NG8uAJKPI+9qFkGU8NdhumhW8Bu
 9f/BBBl9CQAgbQirB5IbhrC+l/t0+hfkuY60FkhMXcv9kuH6cWa+BDucQgXy2twDxQhdHv2C0+v
 +EyfPaQweR7fqySVUGpytCCIV7Q61O5xKFmkjrQ==
X-Google-Smtp-Source: AGHT+IEHDGEdDLw/q0sVgAu532b1ICxNkrkMLYqR/A+fKL/fHqBe1JwdYG9D8h0KqJmddaDo23b+wopELq6U/K2G76E=
X-Received: by 2002:a05:651c:b28:b0:2f7:663c:48d7 with SMTP id
 38308e7fff4ca-2f7663c4cc1mr35888471fa.39.1725961133754; Tue, 10 Sep 2024
 02:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240819144303.37852-1-peter.maydell@linaro.org>
 <20240910110344.10e4805e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240910110344.10e4805e@imammedo.users.ipa.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 10:38:42 +0100
Message-ID: <CAFEAcA_Rjiy1so28OVPpL=+++XuU+gSXhn-v_WHMcpc_wa_xMw@mail.gmail.com>
Subject: Re: [PATCH] docs/system/cpu-hotplug: Update example's
 socket-id/core-id
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Tue, 10 Sept 2024 at 10:03, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Mon, 19 Aug 2024 15:43:03 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > At some point the way we allocate socket-id and core-id to CPUs
> > by default changed; update the example of how to do CPU hotplug
> > and unplug so the example commands work again. The differences
> > in the sample input and output are:
> >  * the second CPU is now socket-id=0 core-id=1,
> >    not socket-id=1 core-id=0
> >  * the order of fields from the qmp_shell is different (it seems
> >    to now always be in alphabetical order)
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I noticed this while I was playing around with vcpu hotplug trying to
> > demonstrate a memory leak I want to fix...
> >
> >  docs/system/cpu-hotplug.rst | 54 ++++++++++++++++++-------------------
> >  1 file changed, 26 insertions(+), 28 deletions(-)
> >
> > diff --git a/docs/system/cpu-hotplug.rst b/docs/system/cpu-hotplug.rst
> > index 015ce2b6ec3..443ff226b90 100644
> > --- a/docs/system/cpu-hotplug.rst
> > +++ b/docs/system/cpu-hotplug.rst
> > @@ -33,23 +33,23 @@ vCPU hotplug
> >        {
> >            "return": [
> >                {
> > -                  "type": "IvyBridge-IBRS-x86_64-cpu",
> > -                  "vcpus-count": 1,
> >                    "props": {
> > -                      "socket-id": 1,
> > -                      "core-id": 0,
> > +                      "core-id": 1,
> > +                      "socket-id": 0,
> >                        "thread-id": 0
> > -                  }
> > +                  },
> > +                  "type": "IvyBridge-IBRS-x86_64-cpu",
> > +                  "vcpus-count": 1
> >                },
> >                {
> > +                  "props": {
> > +                      "core-id": 0,
> > +                      "socket-id": 0,
> > +                      "thread-id": 0
> > +                  },
> >                    "qom-path": "/machine/unattached/device[0]",
> >                    "type": "IvyBridge-IBRS-x86_64-cpu",
> > -                  "vcpus-count": 1,
> > -                  "props": {
> > -                      "socket-id": 0,
> > -                      "core-id": 0,
> > -                      "thread-id": 0
> > -                  }
> > +                  "vcpus-count": 1
> >                }
> >            ]
> >        }
> > @@ -58,18 +58,18 @@ vCPU hotplug
> >  (4) The ``query-hotpluggable-cpus`` command returns an object for CPUs
> >      that are present (containing a "qom-path" member) or which may be
> >      hot-plugged (no "qom-path" member).  From its output in step (3), we
> > -    can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0,
> > -    while hot-plugging a CPU into socket 1 requires passing the listed
> > +    can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0 core 0,
> > +    while hot-plugging a CPU into socket 0 core 1 requires passing the listed
> >      properties to QMP ``device_add``::
> >
>
> >        (QEMU) device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=1 core-id=0 thread-id=0
>
> >        {
> >            "execute": "device_add",
> >            "arguments": {
> > -              "socket-id": 1,
> > +              "core-id": 1,
> >                "driver": "IvyBridge-IBRS-x86_64-cpu",
> >                "id": "cpu-2",
> > -              "core-id": 0,
> > +              "socket-id": 0,
> >                "thread-id": 0
>
> after above changes device_add doesn't match comment nor 'execute' output

Oops, yes. The device_add line should be changed too
("socket-id=0 core-id=1 thread-id=0").

>
> >            }
> >        }
> > @@ -83,34 +83,32 @@ vCPU hotplug
> >
> >        (QEMU) query-cpus-fast
> >        {
> > -          "execute": "query-cpus-fast",
> >            "arguments": {}
> > +          "execute": "query-cpus-fast",
> >        }
> >        {
> >            "return": [
> >                {
> > -                  "qom-path": "/machine/unattached/device[0]",
> > -                  "target": "x86_64",
> > -                  "thread-id": 11534,
> >                    "cpu-index": 0,
> >                    "props": {
> > -                      "socket-id": 0,
> >                        "core-id": 0,
> > +                      "socket-id": 0,
> >                        "thread-id": 0
> >                    },
> > -                  "arch": "x86"
> > +                  "qom-path": "/machine/unattached/device[0]",
> > +                  "target": "x86_64",
> > +                  "thread-id": 28957
> >                },
> >                {
> > -                  "qom-path": "/machine/peripheral/cpu-2",
> > -                  "target": "x86_64",
> > -                  "thread-id": 12106,
> >                    "cpu-index": 1,
> >                    "props": {
> > -                      "socket-id": 1,
> > -                      "core-id": 0,
> > +                      "core-id": 1,
> > +                      "socket-id": 0,
> >                        "thread-id": 0
> >                    },
> > -                  "arch": "x86"
> > +                  "qom-path": "/machine/peripheral/cpu-2",
> > +                  "target": "x86_64",
> > +                  "thread-id": 29095
> >                }
>
> beside reordering, which seems fine, this hunk also introduces target change
> perhaps a separate patch for that?

What target change? It all says "target": "x86_64" both before
and after.

thanks
-- PMM

