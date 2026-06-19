Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB24CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZ7x-0002pz-Q2; Fri, 19 Jun 2026 09:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1waZ7s-0002pn-Es
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:19:16 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1waZ7q-00087N-28
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:19:16 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-39979f72d0cso12899261fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781875150; cv=none;
 d=google.com; s=arc-20240605;
 b=XKhsWlhSraGQDOig2rUTNBA+fUOsIPgQBQSk+dsFQ9lPl78HeuZqRgtn0J4/Dye3Py
 zmx8KzFlNYehW2bXlMdqW/1iVjWPPXNzqcClAqz/cZldGkDI4Gf9TWz6pZahSpTgs1kb
 J9VnIFrYNPcqiCDRDWqX/SBIQD6nQV8HHmHLPUezsqrCGrAOM+FIahN+eKrpEnC0EzSc
 W45S7UDfshPUdBtO9mr/ZKs+wc47SofTeb5w0t3CSxALcV7h56Ohl+sgVoY9iJmes42C
 uvfllH7ZgSxIPBEgv1bHRlKVE7/v6K9NeiECMEN/zZQQ4RrWfgi4XHbsZO1nv7AZC4PY
 7g2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SGq5ektxfzaJJ3vZOZsMpCoN4JL9N6AeV+x3SMposis=;
 fh=hdicUOo1cQKWOHfhHRl7e6IKx8bblLEJ4G6BuLw0pco=;
 b=bAmwbrmJsow+ADM7/0NnFoFaiCEW0xXKIGBtMnWvMA7VlNA7MsWH8RPQhOflFKNxkD
 ti3hVJyrec/av/OcGHUUWAd1mKZ+EuLp9NNUYDd458XAaZPaIeqHluL3ODYtlFRpEG4s
 lYr896l6HPqiXg4froM/SU98Fh53pcRBGyhothVym+30yPa+YAfLAOyk+owuFr0N8qdM
 M3P0xdfzM2pRUvk+5Akp7tXVabQyM+DvSQJDd0j5SDixPsRYhOIejJlXXItUYLSY+4am
 f64slWs5i1Iv9jFX6Waaho0rLK1NHUtxjncnq6D5y1qFx6Po54zu0hdrwbDeOnvvTPmf
 qNGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781875150; x=1782479950; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SGq5ektxfzaJJ3vZOZsMpCoN4JL9N6AeV+x3SMposis=;
 b=sHZlR8ffkGnPPTSDhM2tQDqCm948fIr1teRvm3dsyDVyDom3ptjc4DPHkFr1NcoVXJ
 KOuXHJcfFVgNzv2LCVQ2kE3A70zi1gyl7CmFYThL8EKLLDc++jggaP3/HAhzy1XzBMfL
 F5yeO17tv+svFXABj8Einw5f8fbsSvB0Jbgisy0UKl9Mgu0qCZjuyzcrsW9/YuRptKWT
 OUsA2w8cZ0VWjKJiPKNs5TSEad07WWgSmKG52YzxPbcSmK+rArjD/XlMHAqTEPyqU861
 l7AroK4z6GLrGcLrrcBg1pjqxTAknVaPwQ7VuXMHkjzm3s2We6EXbvssKjctnEeufh4k
 kfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781875150; x=1782479950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGq5ektxfzaJJ3vZOZsMpCoN4JL9N6AeV+x3SMposis=;
 b=HXM6B5ze6IEm8da1cB3Zv56PNF34rQ7UVecDPnyMpISdxOOaCJOBpQTZIomyoguhJ7
 9gyCW9zt1TztDW8gwqQQ+6Ma2Y6db6CyMiAZEhNnt/db5uHV6swj/koXqO+ZkbNGGfMG
 P+X30fqugJHKchYtoGINz7KQkEK/aqaMYW/4LaSKHeeSuVFC6ywqJIK6w850lUSUx6zm
 tdwLHplAvlkd+BH19eIjpeZAP0MztJzrGnDrya0mwUnBH5vbDfTbN+r3SHFsB3MrJMaE
 HuFarWyB+fyk7gTGsdjdGPjOo4B5/IsymhptvmqsEucbaKgcce8ngR38hzDYPs0PBqHg
 QW+g==
X-Gm-Message-State: AOJu0YzGWrb7ZOw6gEDmvF7Vcatj+R5YWCafCmbwCK6Xm+ns7gQvYsOt
 ImsABzedfqC2n1HEmkj8/xeCDgveueGb3q6q8oHyZqTy/qdGGHTBe+q1ruWt1XrXqniEAf2IMYJ
 CYaWIMrbSlEv+HokbiGHHUd1ECk/uqAMszYlo
X-Gm-Gg: AfdE7clJtyMne0IAOs/wTBoB89ODOunvyfNvKfoLCWWmV9/q2jVxpr5Wo9YRDTWwRUT
 kCmncoDUocyDTVvjng2SRiXRoUg3tNPYxDkAt0EULStq1SvPqZWrQ90zVpVz73mQMPayfxOu+zt
 EONNej69Jyk3YPO0CMOAV7ePB+HRcyTWEseo+BF4RsuSSvUJOBR/lVSSdQ4h/9CfMgWxqcgUb5k
 esmLUMxzRAxgm7Gs1X/umuTWtwqRS4gkU+j4kfgxykgrAmmI9DNfAP3dPVMjfL4I9FyOIkQ7anc
 ICGHiacIqje7WJaBOJLVngnBhR8ca/zKMGIJe0i4QfUzeojdEaSiZ0D+h3ay
X-Received: by 2002:a05:651c:25c3:20b0:396:ae32:860 with SMTP id
 38308e7fff4ca-3998a2992e8mr8803091fa.16.1781875149918; Fri, 19 Jun 2026
 06:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
In-Reply-To: <20260618032010.88755-1-aadeshveer07@gmail.com>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Fri, 19 Jun 2026 18:48:57 +0530
X-Gm-Features: AVVi8CetxCFiUbO3qHIY0Y77qZ711Zj9W3z8tOoID8XWBNLQbI2MuvJJPSGBFic
Message-ID: <CA++cPvLSxOLmLDpq4AwYndT1jvu6j17YQLxUexLX1MkxMtCznw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] migration: fast snapshot load
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com, 
 lvivier@redhat.com, ayoub@saferwall.com
Content-Type: multipart/mixed; boundary="000000000000586bae06549b235e"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000586bae06549b235e
Content-Type: multipart/alternative; boundary="000000000000586bac06549b235c"

--000000000000586bac06549b235c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

Adding this small patch on top to enable blocktime support. I will include
it directly when I repost the v2 RFC.
Running cold cache tests most faults lie in the [64 us - 128 us] range(most
likely pages loaded from disk) and a secondary mean is around [4 us - 8
us](likely for directly served zero pages).
Per CPU blocktime is a fraction of a second and offers a visible ergonomic
improvement over precopy migration for snapshot loads, which previously
required a few seconds to load the guest.

Test context:
- Guest: Fedora 44 (4 core, 16 GB RAM)
- Host: Fedora 43
- Host CPU: Intel ultra9 185H(22 cores)
- Host RAM: 32 GB DDR5x
- Host Drive: Gen 4 NVMe SSD
- Acceleration: KVM enabled

Cold Cache Output:
  Postcopy Blocktime (ms): 0
  Postcopy vCPU Blocktime (ms):
  [128, 117, 111, 97]
  Postcopy Latency (ns): 153571
  Postcopy non-vCPU Latencies (ns): 149885
  Postcopy vCPU Latencies (ns):
  [234229, 225562, 195604, 209678]
  Postcopy Latency Distribution:
    [     1 us -     2 us ]:         25
    [     2 us -     4 us ]:        370
    [     4 us -     8 us ]:       3938
    [     8 us -    16 us ]:       3599
    [    16 us -    32 us ]:        520
    [    32 us -    64 us ]:        192
    [    64 us -   128 us ]:      18643
    [   128 us -   256 us ]:       6199
    [   256 us -   512 us ]:       2768
    [   512 us -     1 ms ]:       1096
    [     1 ms -     2 ms ]:        486
    [     2 ms -     4 ms ]:         78
    [     4 ms -     8 ms ]:          5
    [     8 ms -    16 ms ]:          0
    [    16 ms -    32 ms ]:          0
    [    32 ms -    65 ms ]:          0
    [    65 ms -   131 ms ]:          0
    [   131 ms -   262 ms ]:          0
    [   262 ms -   524 ms ]:          0
    [   524 ms -    1 sec ]:          0
    [    1 sec -    2 sec ]:          0
    [    2 sec -    4 sec ]:          0
    [    4 sec -    8 sec ]:          0
    [    8 sec -   16 sec ]:          0

Thank you,
Aadeshveer

On Thu, Jun 18, 2026 at 8:50=E2=80=AFAM Aadeshveer Singh <aadeshveer07@gmai=
l.com>
wrote:

> This RFC implements a "fast snapshot load" mechanism to significantly
> reduce the perceived resume time of a VM from a snapshot file.
>
> Currently, resuming a VM from a snapshot file requires loading all RAM
> pages into the QEMU instance before execution begins. This extension
> allows the user to run the VM nearly instantly by loading only the
> required device states up front and loading RAM pages lazily, by
> trapping access to pages that have not yet been loaded.
>
> Using the Linux userfaultfd syscall, a fault thread catches all page
> faults caused by the guest and loads in the pages required to keep
> the VM running. Concurrently, an eager background thread iteratively
> loads all remaining pages into RAM so the guest does not have to
> depend on the fault thread indefinitely.
>
> Much of code is reused from postcopy for fault handling and precopy
> for reading mapped ram file. Implementation revolves around two
> threads named the fault thread and eager load thread. Fault thread as
> name suggests catches page faults by the guest and serves them using
> userfaultfd. Postcopy fault thread is reused but instead of requesting
> source for a page it loads the page directly by reading form file. In
> order to remove the dependency of guest on fault thread indefinitely
> the eager load thread loads in the entire RAM sequentially, and after
> iterating through the entire RAM signals fault thread to exit and
> calls cleanup.
>
> In order to prevent the case of a page being loaded twice(in the
> case when eager load thread is loading it and fault thread also
> tries to serve fault on same page) a bitmap called pending_bmap is
> used to track pages which are pending and not being loaded by any
> thread. Atomic operations on this bitmap allows coordination between
> threads to prevent any unwanted behaviours
>
> This patch was tested using a Debian 13 bare minimum system and Fedora
> 44 KDE, snapshots for both are loaded successfully with no error.
>
> Next Steps:
> - Add testing framework, in qtest and unit tests
> - Add support for postcopy-blocktime
> - Update documentation
>
> Future direction:
> - Add support for hugepages
> - Add support for multifd
> - Add support for vhost-user
>
> Aadeshveer Singh (5):
>   migration: add RAM Block fields and helpers for fast snapshot load
>   migration: add support for fault thread to load pages from disk
>   migration: add eager load thread for fast snapshot load
>   migration: write up code to run fast snapshot load in
>     qemu_loadvm_state
>   migration/tests: remove capability conflict test
>     postcopy-ram+mapped-ram
>
>  include/system/ramblock.h          |   8 ++
>  migration/migration.c              |  10 +-
>  migration/migration.h              |   5 +
>  migration/options.c                |  11 +-
>  migration/options.h                |   1 +
>  migration/postcopy-ram.c           | 167 ++++++++++++++++++++++++++---
>  migration/postcopy-ram.h           |   2 +
>  migration/qemu-file.c              |  10 +-
>  migration/ram.c                    |  61 +++++++++--
>  migration/savevm.c                 |  52 ++++++++-
>  migration/savevm.h                 |   2 +
>  migration/trace-events             |   2 +
>  tests/qtest/migration/misc-tests.c |  52 ---------
>  13 files changed, 283 insertions(+), 100 deletions(-)
>
> --
> 2.54.0
>
>

--000000000000586bac06549b235c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Everyone,<br><br>Adding this small patch on top to=
 enable blocktime support. I will include it directly when I repost the v2 =
RFC.<br></div><div>Running cold cache tests most faults lie in the [64 us -=
 128 us] range(most likely pages loaded from disk) and a secondary mean is =
around [4 us - 8 us](likely for directly served zero pages).</div><div>Per =
CPU blocktime is a fraction of a second and offers a visible ergonomic impr=
ovement over precopy migration for snapshot loads, which previously require=
d a few seconds to load the guest.<br><br></div><div>Test context:<br></div=
><div>- Guest: Fedora 44 (4 core, 16 GB RAM)<br></div><div>- Host: Fedora 4=
3<br>- Host CPU: Intel ultra9 185H(22 cores)<br>- Host RAM: 32 GB DDR5x</di=
v><div>- Host Drive: Gen 4 NVMe SSD<br></div><div>- Acceleration: KVM enabl=
ed</div><div><br>Cold Cache Output:</div>=C2=A0 Postcopy Blocktime (ms): 0<=
br>=C2=A0 Postcopy vCPU Blocktime (ms):<br>=C2=A0 [128, 117, 111, 97]<br>=
=C2=A0 Postcopy Latency (ns): 153571<br>=C2=A0 Postcopy non-vCPU Latencies =
(ns): 149885<br>=C2=A0 Postcopy vCPU Latencies (ns):<br>=C2=A0 [234229, 225=
562, 195604, 209678]<br>=C2=A0 Postcopy Latency Distribution:<br>=C2=A0 =C2=
=A0 [ =C2=A0 =C2=A0 1 us - =C2=A0 =C2=A0 2 us ]: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 25<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A0 2 us - =C2=A0 =C2=A0 4 us ]: =C2=A0=
 =C2=A0 =C2=A0 =C2=A0370<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A0 4 us - =C2=A0 =C2=
=A0 8 us ]: =C2=A0 =C2=A0 =C2=A0 3938<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A0 8 us=
 - =C2=A0 =C2=A016 us ]: =C2=A0 =C2=A0 =C2=A0 3599<br>=C2=A0 =C2=A0 [ =C2=
=A0 =C2=A016 us - =C2=A0 =C2=A032 us ]: =C2=A0 =C2=A0 =C2=A0 =C2=A0520<br>=
=C2=A0 =C2=A0 [ =C2=A0 =C2=A032 us - =C2=A0 =C2=A064 us ]: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0192<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A064 us - =C2=A0 128 us ]: =
=C2=A0 =C2=A0 =C2=A018643<br>=C2=A0 =C2=A0 [ =C2=A0 128 us - =C2=A0 256 us =
]: =C2=A0 =C2=A0 =C2=A0 6199<br>=C2=A0 =C2=A0 [ =C2=A0 256 us - =C2=A0 512 =
us ]: =C2=A0 =C2=A0 =C2=A0 2768<br>=C2=A0 =C2=A0 [ =C2=A0 512 us - =C2=A0 =
=C2=A0 1 ms ]: =C2=A0 =C2=A0 =C2=A0 1096<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A0 1=
 ms - =C2=A0 =C2=A0 2 ms ]: =C2=A0 =C2=A0 =C2=A0 =C2=A0486<br>=C2=A0 =C2=A0=
 [ =C2=A0 =C2=A0 2 ms - =C2=A0 =C2=A0 4 ms ]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 7=
8<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A0 4 ms - =C2=A0 =C2=A0 8 ms ]: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A05<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A0 8 ms - =C2=A0 =
=C2=A016 ms ]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>=C2=A0 =C2=A0 [ =C2=
=A0 =C2=A016 ms - =C2=A0 =C2=A032 ms ]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=
<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A032 ms - =C2=A0 =C2=A065 ms ]: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A065 ms - =C2=A0 13=
1 ms ]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>=C2=A0 =C2=A0 [ =C2=A0 131 m=
s - =C2=A0 262 ms ]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>=C2=A0 =C2=A0 [=
 =C2=A0 262 ms - =C2=A0 524 ms ]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>=
=C2=A0 =C2=A0 [ =C2=A0 524 ms - =C2=A0 =C2=A01 sec ]: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A01 sec - =C2=A0 =C2=A02 sec ]=
: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A02 sec=
 - =C2=A0 =C2=A04 sec ]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>=C2=A0 =C2=
=A0 [ =C2=A0 =C2=A04 sec - =C2=A0 =C2=A08 sec ]: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00<br>=C2=A0 =C2=A0 [ =C2=A0 =C2=A08 sec - =C2=A0 16 sec ]: =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00<div><br>Thank you,<br>Aadeshveer</div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Jun 18, 2026 at 8:50=E2=80=AFAM Aadeshveer Singh &l=
t;<a href=3D"mailto:aadeshveer07@gmail.com">aadeshveer07@gmail.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This RFC =
implements a &quot;fast snapshot load&quot; mechanism to significantly<br>
reduce the perceived resume time of a VM from a snapshot file.<br>
<br>
Currently, resuming a VM from a snapshot file requires loading all RAM<br>
pages into the QEMU instance before execution begins. This extension<br>
allows the user to run the VM nearly instantly by loading only the<br>
required device states up front and loading RAM pages lazily, by<br>
trapping access to pages that have not yet been loaded.<br>
<br>
Using the Linux userfaultfd syscall, a fault thread catches all page<br>
faults caused by the guest and loads in the pages required to keep<br>
the VM running. Concurrently, an eager background thread iteratively<br>
loads all remaining pages into RAM so the guest does not have to<br>
depend on the fault thread indefinitely.<br>
<br>
Much of code is reused from postcopy for fault handling and precopy<br>
for reading mapped ram file. Implementation revolves around two<br>
threads named the fault thread and eager load thread. Fault thread as<br>
name suggests catches page faults by the guest and serves them using<br>
userfaultfd. Postcopy fault thread is reused but instead of requesting<br>
source for a page it loads the page directly by reading form file. In<br>
order to remove the dependency of guest on fault thread indefinitely<br>
the eager load thread loads in the entire RAM sequentially, and after<br>
iterating through the entire RAM signals fault thread to exit and<br>
calls cleanup.<br>
<br>
In order to prevent the case of a page being loaded twice(in the<br>
case when eager load thread is loading it and fault thread also<br>
tries to serve fault on same page) a bitmap called pending_bmap is<br>
used to track pages which are pending and not being loaded by any<br>
thread. Atomic operations on this bitmap allows coordination between<br>
threads to prevent any unwanted behaviours<br>
<br>
This patch was tested using a Debian 13 bare minimum system and Fedora<br>
44 KDE, snapshots for both are loaded successfully with no error.<br>
<br>
Next Steps:<br>
- Add testing framework, in qtest and unit tests<br>
- Add support for postcopy-blocktime<br>
- Update documentation<br>
<br>
Future direction:<br>
- Add support for hugepages<br>
- Add support for multifd<br>
- Add support for vhost-user<br>
<br>
Aadeshveer Singh (5):<br>
=C2=A0 migration: add RAM Block fields and helpers for fast snapshot load<b=
r>
=C2=A0 migration: add support for fault thread to load pages from disk<br>
=C2=A0 migration: add eager load thread for fast snapshot load<br>
=C2=A0 migration: write up code to run fast snapshot load in<br>
=C2=A0 =C2=A0 qemu_loadvm_state<br>
=C2=A0 migration/tests: remove capability conflict test<br>
=C2=A0 =C2=A0 postcopy-ram+mapped-ram<br>
<br>
=C2=A0include/system/ramblock.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A08 ++<br>
=C2=A0migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 10 +-<br>
=C2=A0migration/migration.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A05 +<br>
=C2=A0migration/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 11 +-<br>
=C2=A0migration/options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0migration/postcopy-ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 16=
7 ++++++++++++++++++++++++++---<br>
=C2=A0migration/postcopy-ram.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A02 +<br>
=C2=A0migration/qemu-file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 10 +-<br>
=C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 61 +++++++++--<br>
=C2=A0migration/savevm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 52 ++++++++-<br>
=C2=A0migration/savevm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0migration/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +<br>
=C2=A0tests/qtest/migration/misc-tests.c |=C2=A0 52 ---------<br>
=C2=A013 files changed, 283 insertions(+), 100 deletions(-)<br>
<br>
-- <br>
2.54.0<br>
<br>
</blockquote></div>

--000000000000586bac06549b235c--

--000000000000586bae06549b235e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-migration-postcopy-blocktime-support-for-fast-snapsh.patch"
Content-Disposition: attachment; 
	filename="0001-migration-postcopy-blocktime-support-for-fast-snapsh.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mqkxk8kd0>
X-Attachment-Id: f_mqkxk8kd0

RnJvbSA3MGFiMjk0OWVmOTk5NjhjMmZjMTZlNmEwZDk4NjBhOTkzNTE0MzY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBYWRlc2h2ZWVyIFNpbmdoIDxhYWRlc2h2ZWVyMDdAZ21haWwu
Y29tPgpEYXRlOiBGcmksIDE5IEp1biAyMDI2IDE4OjEyOjM2ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gbWlncmF0aW9uOiBwb3N0Y29weS1ibG9ja3RpbWUgc3VwcG9ydCBmb3IgZmFzdCBzbmFwc2hv
dCBsb2FkCgpBZGQgcG9zdGNvcHktYmxvY2t0aW1lIHN1cHBvcnQgdG8gZmFzdCBzbmFwc2hvdCBs
b2FkIGJ5IGNhbGxpbmcKbWFya19wb3N0Y29weV9ibG9ja3RpbWVfYmVnaW4oKSwgb24gYWxsIHBh
Z2UgZmF1bHRzIGludGVyY2VwdGVkIGJ5IGZhdWx0CnRocmVhZC4KClRoZXJlIGlzIG5vIG5lZWQg
dG8gY2FsbCBtYXJrX3Bvc3Rjb3B5X2Jsb2NrdGltZV9lbmQoKSwgYXMKcG9zdGNvcHlfbWFwcGVk
X3JhbV9sb2FkX3BhZ2UoKSBjYWxscyBwb3N0Y29weV9wbGFjZV9wYWdlKCkgYW5kCnBvc3Rjb3B5
X3BsYWNlX3BhZ2VfemVybygpIHdoaWNoIGNhbGwgdGhlIGVuZCBtYXJraW5nIGludGVybmFsbHku
CgpTaWduZWQtb2ZmLWJ5OiBBYWRlc2h2ZWVyIFNpbmdoIDxhYWRlc2h2ZWVyMDdAZ21haWwuY29t
PgotLS0KIG1pZ3JhdGlvbi9wb3N0Y29weS1yYW0uYyB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3Bvc3Rjb3B5LXJhbS5j
IGIvbWlncmF0aW9uL3Bvc3Rjb3B5LXJhbS5jCmluZGV4IDBlZTI5NGEzODEuLjJmNDY5OGZiZWQg
MTAwNjQ0Ci0tLSBhL21pZ3JhdGlvbi9wb3N0Y29weS1yYW0uYworKysgYi9taWdyYXRpb24vcG9z
dGNvcHktcmFtLmMKQEAgLTE0MzYsNiArMTQzNiwxMiBAQCBzdGF0aWMgdm9pZCAqcG9zdGNvcHlf
cmFtX2ZhdWx0X3RocmVhZCh2b2lkICpvcGFxdWUpCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBtc2cuYXJnLnBhZ2VmYXVsdC5mZWF0LnB0aWQpOwogCiAg
ICAgICAgICAgICBpZiAobWlncmF0ZV9mYXN0X3NuYXBzaG90X2xvYWQoKSkgeworICAgICAgICAg
ICAgICAgIFdJVEhfUUVNVV9MT0NLX0dVQVJEKCZtaXMtPnBhZ2VfcmVxdWVzdF9tdXRleCkKKyAg
ICAgICAgICAgICAgICB7CisgICAgICAgICAgICAgICAgICAgIG1hcmtfcG9zdGNvcHlfYmxvY2t0
aW1lX2JlZ2luKG1zZy5hcmcucGFnZWZhdWx0LmFkZHJlc3MsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZy5hcmcucGFnZWZhdWx0LmZlYXQucHRp
ZCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmIp
OworICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICBpZiAocG9zdGNvcHlfbWFwcGVk
X3JhbV9sb2FkX3BhZ2UoCiAgICAgICAgICAgICAgICAgICAgICAgICBtaXMsIHJiLCByYl9vZmZz
ZXQsIG1zZy5hcmcucGFnZWZhdWx0LmFkZHJlc3MsIDEpKSB7CiAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOwotLSAKMi41NC4wCgo=
--000000000000586bae06549b235e--

