Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03081E8B363
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNBN-0002fk-L6; Tue, 03 Feb 2026 15:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnNBL-0002eM-Kl
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnNBK-0001os-0W
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770151169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/crHqpbetOcuuTBStzVgUPtEd+GUYHb0Q9+A3r+YMys=;
 b=V6a1CmicefhvBRbgFTzf944gxXol2jqj6tQhU2SMCQ2qbFgCjvJ9Gu7sreFwH5Iq6UNfBz
 lXpm8mShGo4Lro3VMZwSBcZvH/dbuBTOD5L24hKDGqEpot3h5J+Z2yTjVZX2YNzNyulZMU
 hIw/NJCle7iVQ7cNq2H/67UIKsdw8ZE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-8OsUCmQIM4is9SaQMT3m8A-1; Tue, 03 Feb 2026 15:39:28 -0500
X-MC-Unique: 8OsUCmQIM4is9SaQMT3m8A-1
X-Mimecast-MFC-AGG-ID: 8OsUCmQIM4is9SaQMT3m8A_1770151167
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435a2de6ec0so3799935f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770151167; x=1770755967; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/crHqpbetOcuuTBStzVgUPtEd+GUYHb0Q9+A3r+YMys=;
 b=rT/sxUrZplDJ5hEo/+sca0i3rfnxpEOoa/KmEelchNvme9+ruG8Sc6Fbnk6kgYL+A9
 xzjwwhjHPYJm4FEtHadFVeWOfcSdiMcKY+K3a82rTmk0xipxLY9ym2PoVWJNJ2TU6OUz
 2wM9F2LEA+W3YdJHjKRwanDcEzx5ltm4VJG1LTmNu+8Sz/EK1YEHzNZUAZ0Pg4jMtJTf
 mF21Y04sgmV9P1aYh9t3tblL01nL961kt2EJKY3ghfkATVaCvF9eDzu/UxC+PfYPwx+0
 D6afiI/xi/165XytBmpKWlWlJ9SSImIJ0ICEF8L55DhuX2OtogYEYzjqDX/iJxEIDk0b
 hN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770151167; x=1770755967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/crHqpbetOcuuTBStzVgUPtEd+GUYHb0Q9+A3r+YMys=;
 b=Ro3nEfpRYdGnTZiw2kDivMTrYD61DiqiWLVhzeqJl+KJ8pAJTmKyVorEoxVCdy/dob
 sR3rAtsaI8QgLytOTSw6o4R0/n4Qy1f+AxNrZplRxjPHqtLQexnfTsvBwuRUfcy4oIsm
 692iUzv9cgPCSKw7t+LFjR8JFFg8XRd4p0wiVuPx2uAFL2IUjF+QCP+yjrSM6RUzzbRC
 aXeDkbP1n0oTtV+COfJiztFmqNOxv+HTmoBrs8UWz+rHo4hWPvY/nvIP3TDSghk42mYB
 2UM65afGLf9h89a0N6Bj0HAM/bRofGvI2mDYBDJiNHXQpHgKJ9qc+8lVJVF9Xit71NWZ
 59Hg==
X-Gm-Message-State: AOJu0YywJqKMA+J/WuTBOes1hsK+emWgxl+eOVJGSSS/hpqjdIqxEG6v
 J66G5lWg1PlrvSvw42sp5zrO6Kfgn0RQXTgv5uV+ADne56zp+8e8+CUJdJ08f60l6l/bDEgQY+X
 zGTR9+0gEwW54jcg36753yKzRgctdZFu1YwObu5bHQ2tAcZQRZx1kAvQ5
X-Gm-Gg: AZuq6aJGrgl05st2fw50SSkoau1xgkahksbYeHG81rNR9WeH1HjeI2Y0iAbAncIb0LL
 awnwRAoFrVnt51qARdIJPhqUKceTiX1+1ibDTLBQWBIZYwYwbWrvofk51n1g0Kr6KmxndFdDaoS
 Z5+9shqRoxNhr7CoZ6JyuFJJK3cyi3puKfnIze6UxxBcAMtnr+k+4imBdr0WUGkFuGZHMoK8CQL
 xQoNwqTH/gp6f292tuX2BiJd2cqWlMiYYSgWCdiHOVbF9grdRLMNT0ietNTeaMhEVykOxSnoFh8
 rxSi/mgWoRvCu/s3IeAXsQSfr2VB+4bhZuTBfVaHvD+3sdpkPl0MOVgEZ0NTPr1HwHBUK0QGh1c
 ZQHkmFlG1n/IHhWU2kvAKMte0ABgbEUIzRQ==
X-Received: by 2002:a05:6000:4301:b0:435:9b3d:d969 with SMTP id
 ffacd0b85a97d-43617e405c9mr883412f8f.21.1770151166408; 
 Tue, 03 Feb 2026 12:39:26 -0800 (PST)
X-Received: by 2002:a05:6000:4301:b0:435:9b3d:d969 with SMTP id
 ffacd0b85a97d-43617e405c9mr883371f8f.21.1770151165779; 
 Tue, 03 Feb 2026 12:39:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e25683sm1324489f8f.6.2026.02.03.12.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:39:25 -0800 (PST)
Date: Tue, 3 Feb 2026 15:39:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 Ravi Shankar <venkataravis@micron.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 0/7] hw/cxl: Support Back-Invalidate (+ PCIe Flit
 mode)
Message-ID: <20260203153759-mutt-send-email-mst@kernel.org>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 09, 2026 at 02:45:04PM +0000, Jonathan Cameron wrote:
> Lightly reworked version of Davidlohr's v4.
> https://lore.kernel.org/qemu-devel/20251103195209.1319917-1-dave@stgolabs.net/
> 
> Whilst I have several other series posted for merge this applies fine
> to upstream, so no dependencies.
> Davidlohr, please check I didn't mess anthing up and perhaps give tags
> for the 3 new patches.

applying this on top does seem to conflict.
let me get rest merged then this can be rebased.

> v5 changes:
> - Rebase much earlier in the CXL queue as Davidlohr had it beind some stuff
>   I was carrying that is not ready for upstream just yet.
> - Update the CFMWS flags directly as the patch doing restriction control needs
>   some more thought.
> - Bios tables test data updates.
> - Don't provide flit mode control for gen_pcie_root_port as we don't need it
>   for the rest of the series which is all about CXL.
> 
> The following allows support for component basic back invalidation discovery
> and config, by exposing the BI routing table and decoder registers. Instead
> of going the type2[0] route, this series proposes adding support for type3
> hdm-db, which allows a more direct way of supporting BI in qemu.
> 
> As BI is a dependent on the larger flits introduced in PCIe (and CXL 3.0)
> add support for enabling that for CXL components. Negotiation is handled
> via an equivalent of what we do for link speed.
> 
> Davidlohr Bueso (3):
>   hw/pcie: Support enabling flit mode
>   hw/cxl: Support type3 HDM-DB
>   hw/cxl: Remove register special_ops->read()
> 
> Ira Weiny (1):
>   hw/cxl: Refactor component register initialization
> 
> Jonathan Cameron (3):
>   tests/bios-tables-test: Excluded CEDT.cxl for BI restriction
>     relaxation.
>   hw/cxl: Update CXL Fixed Memory Window ACPI description to include
>     Back Invalidate support.
>   tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS
> 
>  docs/system/devices/cxl.rst               |  23 +++
>  include/hw/cxl/cxl_component.h            |  87 +++++++--
>  include/hw/cxl/cxl_device.h               |   4 +
>  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
>  include/hw/pci/pcie.h                     |   2 +-
>  include/hw/pci/pcie_port.h                |   1 +
>  hw/acpi/cxl.c                             |   2 +-
>  hw/cxl/cxl-component-utils.c              | 211 ++++++++++++++++------
>  hw/mem/cxl_type3.c                        |  15 +-
>  hw/pci-bridge/cxl_downstream.c            |  10 +-
>  hw/pci-bridge/cxl_root_port.c             |  11 +-
>  hw/pci-bridge/cxl_upstream.c              |  18 +-
>  hw/pci-bridge/pci_expander_bridge.c       |   2 +-
>  hw/pci/pcie.c                             |  23 ++-
>  tests/data/acpi/x86/q35/CEDT.cxl          | Bin 184 -> 184 bytes
>  15 files changed, 313 insertions(+), 97 deletions(-)
> 
> -- 
> 2.48.1


