Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3FACAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyaIC-0008Eg-FO; Tue, 16 Sep 2025 14:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyaI5-0008DS-Gm
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyaI1-0003io-Mv
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758046828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=293JgCySNIjXCRLHwd80u5lJNKbyKNZBn2UUV3LqwpY=;
 b=YfQoRKgGTo5aiDDvdzfa481yPK7z4fl9/FWXay4oIYYEewNp9AB7EaYe3kizCjBIPhsxB2
 AS2p1hREQoA55ro/IGGS750DbCSvKC92lpeIl14wuypqMZnLpO2P8ubAQ4fX083SGs6kxu
 gGg4+BAugZ/X/K7+4fAHCbFz6nfW9qU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-m07yw-4ZNoyg3TvuF2MOXw-1; Tue, 16 Sep 2025 14:20:27 -0400
X-MC-Unique: m07yw-4ZNoyg3TvuF2MOXw-1
X-Mimecast-MFC-AGG-ID: m07yw-4ZNoyg3TvuF2MOXw_1758046826
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-25bdf8126ceso100305815ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046825; x=1758651625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=293JgCySNIjXCRLHwd80u5lJNKbyKNZBn2UUV3LqwpY=;
 b=WblQwsbqZoaq3OERECHV+HantyYOEVZdTDaO+uTXUGaHPHgqNO5lihFhP660uODQRb
 4yjrNeocZrkfjfTOEmAjFgry2Iw46nveYalt1Q1RhFa77t5OA1H47EbClhIwjxhfWJhu
 wkbQ8zBx5EEGjHUKwB3ovabURfEJ5psuq3iKzZpFJokcpG86xRznDeuMeO4Vu5Z8H/MR
 j7PQ4dk0Y1ArXKoqvhjmuW1txyhFggfll3/F3b3/QxYuXKMr2FsR6xYIoc4RjUAswBpp
 4ORpSdD3Zyeh1/bpi1Bg3SOwLUazMMaIaitGshiK17e6EQ+dCVtlE/x6uH+tNlzH8sPO
 kaMw==
X-Gm-Message-State: AOJu0YwrvAEOT/nJkomUVFyZgp5nlBaruhReuw3pdHb7l1rrEUEZ2o02
 q86qSi/TAOjif52XeV70kBYWKnjgrcRHNvNiYad+5MV0VwmPJGEtivBesg0EOGQO/jP5Cgcbj85
 rgxiT47wKUD9M2CZbZ7Ja/UPVf2wEoywA+W4IkRnRuG2xVSjVu9ghV/q+qqQ8MQJCIY5EDkUQL/
 GVs4G7FXyRCHtXCC6gWfR2cGvGs5OnXbPn5BMkNE2VMQ==
X-Gm-Gg: ASbGncsT6g87ZhlXH720k+xxUSuqMTxwT4u0fDfT02vUptRdwTFvpnptp2m5wrtezau
 Rz+v+9J8f2rWD1XpN+EVGFARnt3GHuOuEqY38RQZLVYqSlm7/3yXFzbfMZ32FcChMFRqQHVNl2A
 cA3W/Upvu35LNFGTM4EmcYuSZ5j6RX8LjSEu555a2dOSBZ0j0OpXfZ
X-Received: by 2002:a17:903:1b08:b0:25c:9688:bdca with SMTP id
 d9443c01a7336-25d26e43a33mr221841875ad.50.1758046825399; 
 Tue, 16 Sep 2025 11:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvzfOWT7IBBRnckyQCf2xL4aCvfgRSrfJwpeAAA6M2QPWPaLjzrUbLSXJK2ZVfYifV4lQNpd7XHLr8Nmw8Zp4=
X-Received: by 2002:a17:903:1b08:b0:25c:9688:bdca with SMTP id
 d9443c01a7336-25d26e43a33mr221841705ad.50.1758046825005; Tue, 16 Sep 2025
 11:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250916162404.9195-1-jsnow@redhat.com>
In-Reply-To: <20250916162404.9195-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 Sep 2025 14:20:12 -0400
X-Gm-Features: AS18NWCA3BJ5D8ODPq5Nc95z3uWGtgzjFy6zkOR8hzu8Xb0lovG3BiC1yEv7gF4
Message-ID: <CAFn=p-ZgY=2XsBySA0KtZgoXfw0oLAg44cObC2KfyA3xfUUHqg@mail.gmail.com>
Subject: Re: [PULL 00/19] Python patches
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 16, 2025 at 12:24=E2=80=AFPM John Snow <jsnow@redhat.com> wrote=
:
>
> The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b=
5d:
>
>   Merge tag 'pull-request-2025-09-09' of https://gitlab.com/thuth/qemu in=
to staging (2025-09-11 12:41:01 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jsnow/qemu.git tags/python-pull-request
>
> for you to fetch changes up to 9a494d83538680651197651031375c2b6fa2490b:
>
>   iotests/check: always enable all python warnings (2025-09-15 14:36:02 -=
0400)
>
> ----------------------------------------------------------------
> Python Pull Request
>
> Python 3.14 support & synchronize with python-qemu-qmp repo
>
> ----------------------------------------------------------------
>
> Adam Dorsey (1):
>   python: backport 'feat: allow setting read buffer limit'
>
> Daniel P. Berrang=C3=A9 (5):
>   iotests: drop compat for old version context manager
>   python: ensure QEMUQtestProtocol closes its socket
>   iotests/147: ensure temporary sockets are closed before exiting
>   iotests/151: ensure subprocesses are cleaned up
>   iotests/check: always enable all python warnings
>
> John Snow (13):
>   python: backport 'Change error classes to have better repr methods'
>   python: backport 'EventListener: add __repr__ method'
>   python: backport 'kick event queue on legacy event_pull()'
>   python: backport 'protocol: adjust logging name when changing client
>     name'
>   python: backport 'drop Python3.6 workarounds'
>   python: backport 'Use @asynciocontextmanager'
>   python: backport 'qmp-shell: add common_parser()'
>   python: backport 'make require() preserve async-ness'
>   python: backport 'qmp-shell-wrap: handle missing binary gracefully'
>   python: backport 'qmp-tui: Do not crash if optional dependencies are
>     not met'
>   python: backport 'Remove deprecated get_event_loop calls'
>   python: backport 'avoid creating additional event loops per thread'
>   python: synchronize qemu.qmp documentation
>
>  python/qemu/machine/qtest.py     |   2 +
>  python/qemu/qmp/__init__.py      |   3 +-
>  python/qemu/qmp/error.py         |   7 +-
>  python/qemu/qmp/events.py        |  50 ++++++--
>  python/qemu/qmp/legacy.py        |  46 +++++---
>  python/qemu/qmp/message.py       |  22 ++--
>  python/qemu/qmp/models.py        |   8 +-
>  python/qemu/qmp/protocol.py      | 194 +++++++++++++++++++------------
>  python/qemu/qmp/qmp_client.py    | 155 +++++++++++++++++-------
>  python/qemu/qmp/qmp_shell.py     | 165 ++++++++++++++++++--------
>  python/qemu/qmp/qmp_tui.py       |  30 +++--
>  python/qemu/qmp/util.py          | 143 ++++++-----------------
>  python/tests/protocol.py         |  10 +-
>  tests/qemu-iotests/147           |   1 +
>  tests/qemu-iotests/151           |   5 +
>  tests/qemu-iotests/check         |   4 +
>  tests/qemu-iotests/testenv.py    |   7 +-
>  tests/qemu-iotests/testrunner.py |   9 +-
>  18 files changed, 532 insertions(+), 329 deletions(-)
>
> --
> 2.51.0
>
>

CC qemu-stable. For the stable pull, this subset of patches should be
sufficient:

jsnow@jsnow-thinkpadp16vgen1 ~/s/q/build (python)> stg series --description
+ python-backport-kick-event     # python: backport 'kick event queue
on legacy event_pull()'
+ python-backport-drop-python3.6 # python: backport 'drop Python3.6 workaro=
unds'
+ python-backport-use            # python: backport 'Use @asynciocontextman=
ager'
+ python-backport-remove         # python: backport 'Remove deprecated
get_event_loop calls'
+ python-backport-avoid-creating # python: backport 'avoid creating
additional event loops per thread'
+ iotests-drop-compat-for-old    # iotests: drop compat for old
version context manager
+ python-ensure                  # python: ensure QEMUQtestProtocol
closes its socket
+ iotests-147-ensure-temporary   # iotests/147: ensure temporary
sockets are closed before exiting
+ iotests-151-ensure             # iotests/151: ensure subprocesses
are cleaned up
> iotests-check-always-enable    # iotests/check: always enable all python =
warnings

i.e. patches 3, 5-6, 12-13, and 15-19. Tested locally in the python
tests dir (make check-dev && make check-tox && make check-minreqs) and
via normal build and test (../configure --enable-docs && make -j13 &&
make check)

Thanks,
--js.


