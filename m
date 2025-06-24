Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F74C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 00:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTriR-00041u-5J; Mon, 23 Jun 2025 20:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uTriP-00041X-Oq
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 20:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uTriN-0001Wf-Gd
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 20:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750725641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8DaITRQMgokLAIEn+ttnua62MEt5STDpxRTt8b7wLg=;
 b=ZUc+iVVVnzisl2yZGVKQQnpilHVJT1sQqLGoOEQEoZIah6+TeVOgVCn0ao7C33llLmQGNl
 a6owpBoXsj5gJyjSBtxDp6WmTn5kE95Ee+pJ6Kt+fAhM+KHbIa5s4pQgxdpHrNuzGkXFpI
 7doG8cemCA3YIo83C8tR4YrsUj11K1k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-UNPLatYvOEW6iW6KLwSVlw-1; Mon, 23 Jun 2025 20:40:39 -0400
X-MC-Unique: UNPLatYvOEW6iW6KLwSVlw-1
X-Mimecast-MFC-AGG-ID: UNPLatYvOEW6iW6KLwSVlw_1750725638
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-311a6b43ed7so4010358a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 17:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750725638; x=1751330438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O8DaITRQMgokLAIEn+ttnua62MEt5STDpxRTt8b7wLg=;
 b=mT11nWIyp+g7tBY1pVjJsCaKV8F8Os7KdjHqNTAptv5HLrrjbHelPakAd7zInLJypl
 ybzlmSlRPMC3dCRAY2CXvEDVLw6qQvunbtKm3xF00cbmSZYvdtAiWjZ70A5/IHHW2yKF
 MEAp0OcW/tCp1f8bD2cytTpIBE0BFYYCHVkz2Fr9NCC32wj+elaxMVnRBuD+CYAnqzOb
 3ZhtIyb65xwTIgeifFqzOY1wXGKRp7itIOxeTXn/SzmPlYe8T06caUqmq0o+xf4Km7HM
 jvIcnQtcPKohuREO9BWYM+nTi0MVVulTIfLwQXPSzdCXssOiGTfZvbUAAnoP1DyVvOZD
 SfXQ==
X-Gm-Message-State: AOJu0Yzy1783ZdO63amtDWH70EhweZdjtwlX2XqoUBHMouacgLqb4PL3
 90MoR/5fd3tCzsOAiaMSk/U8fvulU//5jHKxSAfyqq0AzUWTKSnyNAiPYUCWJZXNkBoAE0KWNbY
 NCqlCIl79YYnIniODtznqniUTlJ2OxIr70IA3+8OHUy8iTmeMYh0govYiBwhhIr6t7phFpgpJkn
 y/rK6WbreiLg2v2OAiUHjzBwvf9tEZAEM=
X-Gm-Gg: ASbGncsS1OdZK69vFVgaNDEyg2NbzKPEIHDbNxCm2uIXcLNhaQSf4pq0MnL4RBTvFJo
 zfA+MZm7A5qhAOY1RC60ijXSsFN82cQCfoqU75YRiDScLAHyLdDANDb+x0a27a8GEbuz4J1GM4Q
 KEzey4
X-Received: by 2002:a17:90b:4a83:b0:311:af8c:51cd with SMTP id
 98e67ed59e1d1-3159d8c80eemr28502012a91.18.1750725638430; 
 Mon, 23 Jun 2025 17:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx4toXAiEDtEogQjP4GauIpyVLa71cV8T7K7iATU880EWbtl1LEYgow8DBwUhP3M0HP5HWLf8hMr7Mi7BFaSY=
X-Received: by 2002:a17:90b:4a83:b0:311:af8c:51cd with SMTP id
 98e67ed59e1d1-3159d8c80eemr28501970a91.18.1750725637971; Mon, 23 Jun 2025
 17:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250618083930.451313-1-lvivier@redhat.com>
 <CACGkMEv1r+-MUpoPZ2Va-b-dkjB2prHYhtZEtUB7-s1CZCBFdA@mail.gmail.com>
 <b1a9b090-e8f2-4e80-943a-001db1229707@redhat.com>
In-Reply-To: <b1a9b090-e8f2-4e80-943a-001db1229707@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Jun 2025 08:40:26 +0800
X-Gm-Features: AX0GCFvTrbxkQjsvnNMrgJk4TVkisKBu0t0nGYnTA-ET5wTE3SKL91zS568rQQA
Message-ID: <CACGkMEutttY=+4GuMZxe5jigx4x_NVNqccqJvL2swYtP=B11dw@mail.gmail.com>
Subject: Re: [PATCH 0/8] net: Add passt netdev backend
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Mon, Jun 23, 2025 at 4:10=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> On 23/06/2025 10:03, Jason Wang wrote:
> > On Wed, Jun 18, 2025 at 4:39=E2=80=AFPM Laurent Vivier <lvivier@redhat.=
com> wrote:
> >>
> >> This series introduces support for passt as a new network backend for
> >> QEMU.
> >>
> >> passt is a modern, unprivileged, user-mode networking solution that
> >> provides guest connectivity by launching an external helper process. T=
his
> >> series adds the core backend and integrates it with vhost-user for
> >> high-performance, accelerated networking.
> >>
> >> The series is structured to first improve the general networking code
> >> before adding the new feature. The first patch extracts from the strea=
m
> >> backend the functions that will be reused in the passt backend. The
> >> following patches are a preparatory refactoring to decouple the generi=
c
> >> vhost layer from specific backend implementations (tap, vhost-user, et=
c.).
> >> This is achieved by replacing hardcoded type checks with a callback-ba=
sed
> >> system in NetClientInfo, making the vhost infrastructure more modular =
and
> >> extensible.
> >>
> >> With the refactoring in place, subsequent patches introduce the passt
> >> backend itself, reusing the generic stream handling logic. The final
> >> patch adds vhost-user support to passt, which plugs cleanly into the
> >> newly refactored vhost layer.
> >>
> >> Some benchmarks:
> >>
> >>   Reference '-net user':
> >>
> >>    -net user,hostfwd=3Dtcp::10001-:10001
> >>
> >>      iperf3 -c localhost -p 10001  -t 60 -4
> >>
> >>      [ ID] Interval           Transfer     Bitrate         Retr
> >>      [  5]   0.00-60.00  sec  14.2 GBytes  2.03 Gbits/sec    1        =
    sender
> >>      [  5]   0.00-60.00  sec  14.2 GBytes  2.03 Gbits/sec             =
     receiver
> >>
> >>   New backend '-netdev passt'
> >>
> >>    -netdev passt,vhost-user=3Doff,tcp-ports=3D10001
> >>
> >>      iperf3 -c localhost -p 10001  -t 60 -4
> >>
> >>      [ ID] Interval           Transfer     Bitrate         Retr
> >>      [  5]   0.00-60.00  sec  27.1 GBytes  3.88 Gbits/sec    0        =
    sender
> >>      [  5]   0.00-60.03  sec  27.1 GBytes  3.88 Gbits/sec             =
     receiver
> >>
> >>    -netdev passt,vhost-user=3Don,tcp-ports=3D10001
> >>
> >>      iperf3 -c localhost -p 10001  -t 60 -4
> >>
> >>      [ ID] Interval           Transfer     Bitrate         Retr
> >>      [  5]   0.00-60.00  sec   224 GBytes  32.1 Gbits/sec    4        =
    sender
> >>      [  5]   0.00-60.05  sec   224 GBytes  32.0 Gbits/sec             =
     receiver
> >
> > Do we have latency numbers of even PPS?
>
> Could you propose tools and tests I can run to have these numbers?

For latency, we can use netperf -t TCP_RR.
For PPS, we can use pktgen, kernel source has samples under
samples/pktgen, pktgen_sample03_burst_single_flow.sh could be a good
script, please make sure burst is used in the test to stress the
virtio-net as much as possible.

Thanks


>
> Thanks,
> Laurent
>


