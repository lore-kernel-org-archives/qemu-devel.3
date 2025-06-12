Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E060C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 10:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPfKI-00007m-CX; Thu, 12 Jun 2025 06:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1uPfKD-00005z-CJ
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 06:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1uPfJs-0007wj-ES
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 06:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749724562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5JtIEjkmv9Lug4mLY5HB53y41fVbGtvJ9WO+Y3G5Tw=;
 b=eDIB9alzHrhKkbMMP5reOymDm3T7vhZAcKU4IvKI8ZXuFN1dXvCd8K4cdwSQobEfXvmOKa
 xjx6Wqns4bc5AGE6ps4Ih1KmlIW5+is8gk8HlW3ADnYxQDweHbj5n5SmugIwytM4ju3N4L
 DJv9oEd1JRVcQuongLNxpdOrfB5kYZ4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-yr-Y13L5PCKne5hHClkf5g-1; Thu, 12 Jun 2025 06:36:00 -0400
X-MC-Unique: yr-Y13L5PCKne5hHClkf5g-1
X-Mimecast-MFC-AGG-ID: yr-Y13L5PCKne5hHClkf5g_1749724559
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-32add2506abso4199661fa.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 03:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749724559; x=1750329359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5JtIEjkmv9Lug4mLY5HB53y41fVbGtvJ9WO+Y3G5Tw=;
 b=Xf2h3nnAk1X/XnHtFvQ9RZbQMWCrg0TY9fxv1C6j4GB6o9gUPr4Fb8e+oemjZFSdtA
 dlwLws/4TwCuR/rDsirhYffobN6A9OXlo7L5iDBtyrEO/asuQyA4/osQG5OsPPnnQcb2
 8j+TkdSe5nwKxrWLwt4t90P+nPyCscX0F2B3Dejb2XB42Rkm/U16IwbbbuFMvgmTnpDC
 7z6DQSMKRzH+glPcmCzWLv7KdQj5+SQqLcrGCcbvCinBqwReVUdKdW0NUY8UGuFKYBal
 QfWjD/+rtEopZxer+qvVmUjWyPc+Lt1OZHLPRt5+XnMu4pV1+5473UKP7oMuDtxtCiV7
 q1Sg==
X-Gm-Message-State: AOJu0YxpRqUfmPNT3dcjJZ/SBBxi44VBbuj50ineny9HIKQ3OMr3OUku
 LrmJxdaCRQLCG7B3Zkwx6ds+WtzFrJPozhJ3wE1O9sjPL4kSayX092zXb/PEb+m/8dWSFmRxKa7
 AMGyJdL01MYxs4NktDgsNNmw3oJBt/0+S9U7eqNN63SWewBwuCAJkaatjDAil7uNztcHF0zGNNa
 2ypR9/nqfdqAlyWfvO3/uuHqgBUl5DarI=
X-Gm-Gg: ASbGncuioRSlqfN8zzAUvjDT5Bs9grhmXqHoI4xelzm7SMRNtYsUq0Obv/b7CIIWfkl
 u0Hsq1Y7hUEbFzummFSBEoEfqv+QKMUy9NQ13i31wWq6+NHVPpG0vuZd2eRWXWmZnbc1h1A1Uo3
 VbKkA=
X-Received: by 2002:a2e:a7c1:0:b0:32a:7666:80d4 with SMTP id
 38308e7fff4ca-32b306f724dmr8419141fa.23.1749724558689; 
 Thu, 12 Jun 2025 03:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ1Brd50CC9vOc23ah8SRFfvqaFsC0RP0nGwGrmBNbdU+OfM9AbKxuPGzXz4ybur6bfLBeC67NA+8RYpdRByI=
X-Received: by 2002:a2e:a7c1:0:b0:32a:7666:80d4 with SMTP id
 38308e7fff4ca-32b306f724dmr8419061fa.23.1749724558212; Thu, 12 Jun 2025
 03:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250609161855.6603-1-peterx@redhat.com>
 <CAMXpfWtGPUDGtn40tkZYNMhntp48BbMRHnZqQkrBKokyMyEXyQ@mail.gmail.com>
 <aEl_RESZhLS56pv2@x1.local>
In-Reply-To: <aEl_RESZhLS56pv2@x1.local>
From: Mario Casquero <mcasquer@redhat.com>
Date: Thu, 12 Jun 2025 12:35:46 +0200
X-Gm-Features: AX0GCFthwxpBImjokCk3P9O4tj245sU1UTGzfd3Fcfa1_a0K9OMXrqkOlQH1Tr0
Message-ID: <CAMXpfWuAkKoVJFvD_YFLzTpUZ_a-25jK_y1y-EA_Sk+LUC0B6A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] migration: Some enhancements and cleanups for
 10.1
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Peter,

Thanks for pointing this out! I retested it with the series you
mentioned and everything works fine.

Booted up 2 VMs as usual, one in source and one in destination with
-incoming defer. Set the postcopy-blocktime and postcopy-ram
capabilities and query them to verify that they are enabled.

(qemu) migrate_set_capability postcopy-ram on
(qemu) migrate_set_capability postcopy-blocktime on
(qemu) info migrate_capabilities

...
postcopy-ram: on
...
postcopy-blocktime: on
...

Do migration with postcopy, this time check the full info migrate in source=
.
(qemu) info migrate  -a
Status: postcopy-active
Time (ms): total=3D6522, setup=3D33, down=3D16
RAM info:
  Throughput (Mbps): 949.60
  Sizes: pagesize=3D4 KiB, total=3D16 GiB
  Transfers: transferred=3D703 MiB, remain=3D5.4 GiB
    Channels: precopy=3D111 MiB, multifd=3D0 B, postcopy=3D592 MiB
    Page Types: normal=3D178447, zero=3D508031
  Page Rates (pps): transfer=3D167581
  Others: dirty_syncs=3D2, postcopy_req=3D1652
Globals:
  store-global-state: on
  only-migratable: off
  send-configuration: on
  send-section-footer: on
  send-switchover-start: on
  clear-bitmap-shift: 18

Once migration is completed compare the differences in destination
about the postcopy blocktime.

(qemu) info migrate -a
Status: completed
Globals:
...
Postcopy Blocktime (ms): 712
Postcopy vCPU Blocktime (ms):
 [1633, 1635, 1710, 2097, 2595, 1993, 1958, 1214]

With all the series applied and same VM:

(qemu) info migrate -a
Status: completed
Globals:
...
Postcopy Blocktime (ms): 134
Postcopy vCPU Blocktime (ms):
 [1310, 1064, 1112, 1400, 1334, 756, 1216, 1420]
Postcopy Latency (us): 16075
Postcopy non-vCPU Latencies (us): 14743
Postcopy vCPU Latencies (us):
 [24730, 25350, 27125, 25930, 23825, 29110, 22960, 26304]

Indeed the Postcopy Blocktime has been reduced a lot :)

Thanks,
Mario

On Wed, Jun 11, 2025 at 3:06=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jun 11, 2025 at 08:15:55AM +0200, Mario Casquero wrote:
> > This series has been successfully tested. The information displayed
> > from the HMP info migrate command is more user-friendly, with the
> > possibility of displaying the globals with info migrate -a.
> > (qemu) info migrate -a
> > Status: active
> > Sockets: [
> > tcp::::8888
> > ]
> > Globals:
> >   store-global-state: on
> >   only-migratable: off
> >   send-configuration: on
> >   send-section-footer: on
> >   send-switchover-start: on
> >   clear-bitmap-shift: 18
> >
> > Tested-by: Mario Casquero <mcasquer@redhat.com>
>
> Hey, Mario,
>
> Thanks for doing this!
>
> This is a specific HMP dump test on recv side, just to mention the major
> change will be on the src side, so feel free to try that too.  That's wha=
t
> patch 1 does.
>
> Patch 2 changed recv side report for blocktime, but in your case you didn=
't
> enable it, to cover tests on patch 2, you can enable postcopy-blocktime
> feature and kickoff a postcopy migration.
>
> And just to mention, the real meat in this series is actually the last
> patch. :) If you want to test that, you'd likely want to apply another of
> my series:
>
> https://lore.kernel.org/r/20250609191259.9053-1-peterx@redhat.com
>
> Then invoke postcopy test with some loads, then check the blocktime repor=
ts
> again.  The other series added latency tracking to blocktime.  With that
> extra series applied, you should be able to observe average page fault
> latency reduction after the last patch, aka, the meat.
>
> Note that this is not a request to have you test everything!  Just to
> mention the bits from test perspective, so just take it as FYI.  I
> appreciate your help already to test on the recv side!
>
> Thanks,
>
> --
> Peter Xu
>


