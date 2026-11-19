Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A72606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MMmU9Erd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TFa3l+G4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTyk2-0005oL-LR; Thu, 19 Nov 2026 04:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjZ-0005a3-IU
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjX-0006LH-UK
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795081630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=/4NNHdvMQK7yoouSK20dfSw25ove7WCfhGq9Tequbvo=;
 b=MMmU9ErdW2NgDdwtdVUn+JdKW2s5/FvK1BgWJJsoro18YcHIgegcbTvle9G3ijYAfUoIvq
 M09iTRbgWtRFmCCuRrDvxZvGKgLvNym2C2uNUk0Bo7zfwO+5TFdsCI+SNXt+c48Wn2JN5/
 g5qWSvebOdwk0HagxokbDKPD79LfDas=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-mtGtN1j3NzSZlb85oqo3Rw-1; Thu, 19 Nov 2026 04:47:07 -0500
X-MC-Unique: mtGtN1j3NzSZlb85oqo3Rw-1
X-Mimecast-MFC-AGG-ID: mtGtN1j3NzSZlb85oqo3Rw_1795081626
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4925ef75fc4so1521745f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795081626; x=1795686426; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/4NNHdvMQK7yoouSK20dfSw25ove7WCfhGq9Tequbvo=;
 b=TFa3l+G4N0ND7hTHQwg8pKPUydWSs06p/NzJxmn227fv8vblTJ3Ph8xjXyHnkFl1jv
 m55e+s5qfLoY15VOs53xzirZtsJ0xAGBCO7tX/4hdCT4eYDoBsXuKApgB6HKfPK/97go
 8u6BTGB1I/Fkw8efxH3lAXvTlnA2os/ydCECxv6vVnH1QADqUbDQLZmLklUBe6867u+n
 pyK6W/cCIdoHMiOAZeE83Irx4KtF1WdUA49OE42pSDmNd7ogKANhlVPQ+xNFV6O2FVML
 Ws9lpunwRZO4DfPjhoUF3uEAmdO3L5Hqvt/ndshGAxDdj10Fw8WxHxhI9XRcJX1l9aI/
 NzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795081626; x=1795686426;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/4NNHdvMQK7yoouSK20dfSw25ove7WCfhGq9Tequbvo=;
 b=f4SmZkk0YDs8U22s+Kq32pIIkXjmRrHlgk4AveO6+hzCrBtXoBao79VOh3J/CazqEl
 Mlfq0nUxCzzqa5Icu3KTpE6INvtDKTT8ZL+Yu3MUyk+ynPs6ADxfvgHkn22CzBBFnvZz
 JbnBl/XXBdKGYu8yQZaOI0XoZMGaBmmW7VNqHKiYl9oIUb//BqXeiLCh3FTQfBm1hmXn
 40evbv9XX10C9mLJ5Ex/6IW6rERrF2VeCvdW73/q8QUw0V++wVKxAJXX3yjoh2wg/lyq
 bJUtPgj+1RzFBon/pzOPBhuqzZ3ISi8ePFAJGxUA9JCxqLdgYeA4PzauPBF5nWCF6KaM
 iCRA==
X-Gm-Message-State: APuU4Z+iwtxwhdQ6pz7pYvTUmxOaGsLaMPvhyrg7W/x1hyel/aFhMHZG
 a8uLGhmfUdTSUe0hOfPSd5RKgTv+UssCxd8koMj9NHrAbr3a98Ktzf/sxc/Lb7YifMmctdcT52V
 U94jpx5/gOaCIS3dTJkouo+CreE82TeKl1aTspXggdb87bBrkjXIW+bGhhI8UUkXgA171jRVHUN
 UBBT47OGDo02E6mENHzWi0Ug43vh3PF1D8fA==
X-Gm-Gg: AYBFou2KC87ZQZyLcPRp/vgl8t+yfbbnPBeVxCLFy3TDtfoLTGV+Ae7FZquSI8Nrcvp
 cVB7KzuosotymfAkw9MudNukhNUMcXRe+KYh2hqPAPaHK2kDFmy0Jdzhre7/CFF6u2dh58Xo0qn
 /aVTT1c7ih331WFYIQ//dBZu+WqAZdT29y2Az0/ANQDESeSJSKA2/MT1GZXpgSbSB4FaXNmBlSv
 5ZucWvdy0NOFYhWX0ky4pHfNcyuaha0fqj4NtCjFiR01epb83Hc+2WB3NY75R+wnV9KU7r1U1CG
 hthoA8lV9CAq5skanWXdqm6F51pdT3Ode63+x3aCpCP8+59OZE2OW4o3YAYMUSrifUk31cOG/A2
 rlTtnhAV5g3DD2hpv/3jwYmlzi7lzIe2ZAuFj7gGEvd8=
X-Received: by 2002:a05:600c:46ca:b0:4bb:65ed:b55c with SMTP id
 5b1f17b1804b1-4bb7da3a66amr99680515e9.33.1795081626194; 
 Thu, 19 Nov 2026 01:47:06 -0800 (PST)
X-Received: by 2002:a05:600c:46ca:b0:4bb:65ed:b55c with SMTP id
 5b1f17b1804b1-4bb7da3a66amr99679835e9.33.1795081625389; 
 Thu, 19 Nov 2026 01:47:05 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853c9170sm24577405e9.14.2026.11.19.01.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 01:47:04 -0800 (PST)
Date: Thu, 19 Nov 2026 04:47:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/8] pc,virtio: fixes
Message-ID: <cover.1795081539.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-28.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 29760efaf96bbe5928f8111881eddbf5ac06439e:

  Update version for v11.2.0-rc0 release (2026-11-10 14:47:54 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 902c849979ce2be367dc0a643310d6b45b76bcd4:

  hw/virtio/virtio-crypto: Drain in-flight operations before unrealizing (CVE-2026-50625) (2026-11-19 02:57:57 -0500)

----------------------------------------------------------------
pc,virtio: fixes

A collection of small fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexandr Moshkov (1):
      vhost-user-fs: fix virtqueue array leak on realize failure

Eric Auger (1):
      hw/virtio/virtio-iommu: Fix IOVA address lookup

Li RongQing (1):
      virtio: Reset free_head on shadow virtqueue start

Peter Maydell (1):
      hw/i386/amd_iommu: Mask address when calculating large PTE page size

Simon Lucido (1):
      libvhost-user: return the backend mapping address for SET_MEM_TABLE

Stefano Garzarella (1):
      backends/vhost-user: fix memory leak when vhost_dev_init() fails

Thomas Huth (1):
      hw/virtio/virtio-crypto: Drain in-flight operations before unrealizing (CVE-2026-50625)

Zhenzhong Duan (1):
      intel_iommu: Keep PASID cache consistent with PT fast path

 hw/i386/amd_iommu.h                       |  3 +-
 include/system/cryptodev.h                |  9 +++++
 backends/cryptodev.c                      | 19 ++++++++++
 backends/vhost-user.c                     |  6 ++-
 hw/i386/intel_iommu.c                     | 62 +++++++++++++++++--------------
 hw/virtio/vhost-shadow-virtqueue.c        |  1 +
 hw/virtio/vhost-user-fs.c                 | 10 +++--
 hw/virtio/virtio-crypto.c                 |  2 +
 hw/virtio/virtio-iommu.c                  |  2 +-
 subprojects/libvhost-user/libvhost-user.c |  1 +
 hw/i386/trace-events                      |  3 +-
 11 files changed, 81 insertions(+), 37 deletions(-)


