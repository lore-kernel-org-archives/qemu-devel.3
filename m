Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C250606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K4ieTQwl;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rujFy4A5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUO3d-0000qF-Ns; Fri, 20 Nov 2026 07:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3b-0000oz-9Q
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3Z-0004ku-4B
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795178970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aXGWNT0Ui94VenZfPMnzJk8edzOpaNdOc7vd8X29dhk=;
 b=K4ieTQwl7vaH8JnkQ6XRED4jbprxsuASpuFPsv01FJjj6DeJw9Ag0S8bDQ1lzAjYwYJejP
 hfyIyDAQWV2cLfeKWH9OqlQTMuIFd/3Er2oXTwCPV3pG5T6rEFulfl0dZXy6TxW/4h8ZsN
 OpzWAh/wYPvKBDGRngKKFWehF4BzxkY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-tjIvCU7kNPiDd3uQs4UmoA-1; Fri, 20 Nov 2026 12:49:27 +0000
X-MC-Unique: tjIvCU7kNPiDd3uQs4UmoA-1
X-Mimecast-MFC-AGG-ID: tjIvCU7kNPiDd3uQs4UmoA_1795178966
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5363fa3d3e4so16923891cf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 04:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795178966; x=1795783766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aXGWNT0Ui94VenZfPMnzJk8edzOpaNdOc7vd8X29dhk=;
 b=rujFy4A5sYBn3i5lSQDqLBwyYJfhNopQw96OvA2s6CMLacLXnSt485+m0sSOaGDHlK
 7wS73TIKnZ0M7+n+RpwEo4CNeu8F8UsMK828jCKsMMpsjozz4aYqPi6oonejHe4OnQWv
 TpGvVUcTGu8E2w3qy5D1dLqazlTEx9swzF0fjx60f7kbcnu+a5dhf/VzR1Dd0M/pkA3h
 FVuNFwl7RIcuVJroNDJIsvPPwDSU6gaj8ywmIxeN2ndK3ZNoxnBQy4TeomtQZwjKjANf
 4YSe0nC+CdcuafQWyWavq87c1kfiMK1rZdy6CUxTENyYHNmIBPUpo+wKmbh1mn7l7q8L
 rhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795178966; x=1795783766;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aXGWNT0Ui94VenZfPMnzJk8edzOpaNdOc7vd8X29dhk=;
 b=d6pFkiHDcf0WLpPG7uOIDJsv4wVDFMYRFL2p/xiSRSPLf9NYy9DwAVWGs0W2+Ke9Rz
 GT6y9He02lCydwKtl7Ve1NSUXzc3RUVsx7zQcAUl1sfwHyJt+zYivEzUvkYPfard100L
 1rCq4xjH0VKTlmZyTYMZ8HuzTT3B7gimulEeDRPpndoGSOpO2Mp3XURY24I0dNiB7sXm
 VPhA0BTM+Xt4qpkUtlJvqmBaxM56fVesP++ZxzLjjk1F6PYrG76OWEqAnVRO4BRL/xxZ
 MTb+MGAePQhDSmTpYqadxI3ITqb7LhInA6BaOecD1qtodSWPIX1jjRrPBGLMoCNH7mqH
 sV+g==
X-Gm-Message-State: APuU4Z/BymZqfG2y3ApMbQP7QvPEfBiDcqGar0E19zdyG7uoUcMm5oAq
 I8mB/CgPnsMBe03y/XAJN+ZdprWqjdN5HF+uIUueOXc8hb1LofGz+mGkxtvFkAeswh+3MB3mojN
 61M82Zsa0h/AfLwFJjp0r0QAyxUmUK73wWItwYKIOpwEVydsxRi2kPBj/oTxElzXD4cyZhg/GNw
 wAO1zA8ID1hjnFKcJgiEJh00uAVP7YnBSPcFieyw==
X-Gm-Gg: AYBFou0qgj5S5BrPMqtx6Z8xlPj35R3Ro6p8nHJJWsHaMNDnBDwoRRqR1E1jJu3QNl7
 wPeKGMjQrXiIZnbcEUcVjn011tdCYHI6ZncuOjPWMxzNac/V1MDKK1xnkLtCDcIaNocIJYt9j3h
 0ViN/Yup3zQKh2Hh3voCsidmUX4YLngSAX+0ckvKpknxdmjFOstjAJWhPVkvm/oamEh2W5ETMvr
 zS0LZBnPc5udUFRpQ0iaG4VkYkI/OuJYU21120ouRf974fMrWjfqPiEd4ztlcvgC+KaLdT45m6H
 lmWNpF9LKtN7DsdGL2ZOU9LgzteWq8ol++0JNNivbcsldumML591N4IDpi/UnmqRQFx7SlqnFbb
 Kh+Gx72IYlumRLKaqrNDJRRv+Ja5QPJWTqOasWpjzNuN2
X-Received: by 2002:a05:622a:2586:b0:55c:6d3d:b688 with SMTP id
 d75a77b69052e-55d767ae63dmr51572961cf.0.1795178965982; 
 Fri, 20 Nov 2026 04:49:25 -0800 (PST)
X-Received: by 2002:a05:622a:2586:b0:55c:6d3d:b688 with SMTP id
 d75a77b69052e-55d767ae63dmr51572471cf.0.1795178965363; 
 Fri, 20 Nov 2026 04:49:25 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882e2d1sm21546751cf.14.2026.11.20.04.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:49:24 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH for-12.0 0/6] migration: Remove VMSTATE_VALIDATE() and
 VMS_MUST_EXIST
Date: Fri, 20 Nov 2026 07:49:17 -0500
Message-ID: <20261120124923.1656220-1-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CI: https://gitlab.com/peterx/qemu/-/pipelines/3091862038

This is for QEMU 12.0 material only.  I could have marked this RFC, but I
found that I want / see this more than "request for comments", so I send it
as formal patches.

To PeterM: I know you may still have some concern on dropping VALIDATE, but
until now I still think this should be the right thing to do.  Let's move
the discussion here and we can continue discussions here.

===8<===

Peter Maydell reported an unwanted assertion on source QEMU due to a failed
check in VMSTATE_VALIDATE():

https://lore.kernel.org/r/20261119165546.3050013-1-peter.maydell@linaro.org

I decided to look at this in a slightly broader range, because I always
thought hijacking field_exists() is very error prone and hard to follow,
and VMSTATE_VALIDATE() is the only user of it (VMS_MUST_EXIST).  Meanwhile
it is the only VMSTATE_*() macro that does not carry a real entity of data
stream, so it's not really a FIELD, but some checker we added adhoc inline
into the VMSD fields.  It might be confusing to anyone new reading VMSD
code, including myself when reading it first time.

Instead of updating the source behavior, let's directly wipe that code out.
I think it's not making a lot of sense doing device state check in save(),
because those sanity check should be done in emulation code, not after
seding all RAM, which is extremely awkward.  post_load() OTOH still makes
some sense to sanity check fields, so I moved all VALIDATE there.

Any comment welcomed, thanks.

Peter Xu (6):
  pcie/aer: Remove the usage of VMSTATE_VALIDATE()
  hw/gpio/zaurus: Move VMSTATE_VALIDATE() check into post_load_errp()
  hpet: Move VMSTATE_VALIDATE() check into post_load
  arm/machine: Move all VMSTATE_VALIDATE() usages into post_load
  rust: Replace vmstate_validate with post_load
  migration: Drop VMSTATE_VALIDATE() and VMS_MUST_EXIST

 include/migration/vmstate.h       | 11 -----
 hw/gpio/zaurus.c                  | 29 ++++++------
 hw/pci/pcie_aer.c                 | 40 ++++++++++++++--
 hw/timer/hpet.c                   | 18 ++++----
 migration/savevm.c                |  5 --
 migration/vmstate.c               | 12 -----
 target/arm/machine.c              | 45 ++++++++++++++++--
 rust/hw/timer/hpet/src/device.rs  |  9 ++--
 rust/migration/src/prelude.rs     |  1 -
 rust/migration/src/vmstate.rs     | 17 -------
 rust/tests/tests/vmstate_tests.rs | 77 -------------------------------
 11 files changed, 106 insertions(+), 158 deletions(-)

-- 
2.56.0


