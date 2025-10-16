Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE13CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 07:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9IO5-0007W6-7O; Thu, 16 Oct 2025 03:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1v9IO2-0007VV-OE
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 03:26:59 -0400
Received: from mail.8bytes.org ([85.214.250.239])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1v9INv-0003Jz-OH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 03:26:58 -0400
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id BBA7C583C8;
 Thu, 16 Oct 2025 09:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1760599607;
 bh=oPHASgBJdp2YQpxgFo3iZagWHBBvcIXbuFbVs8R5f3s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qzzCVLi9hnOj5twx11gfP7Yen2bBmZUxFGO80DGM61vcnIafkyy3f9asAcyRwHSj/
 OL23uwDoUdtpodzP+YBUfeprxRv0pu8J+8Co3niiRUf8RGGcBRt1K1DMZKmXtTfR4i
 ZDUj2wSQ3yLYwvzzHCPdPnhEa5sy3RtwqzGBFJ7SOW9o10qCK4Fx0eez9s7PiHmW8k
 hqTVntkRenO2/JTzytep5QkpIONfwAgQLdJICHpIvqZj2A6W/4MZjPLlbUqLrVAXUQ
 1/mwY0dXm8b9RKgg/kwvU72nv+DbJuLI2GKVJ5XvoWmbE/6LPSKB2Mdktn5frhP8TY
 vNlH5UNpbEJlA==
Date: Thu, 16 Oct 2025 09:26:46 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: coconut-svsm@lists.linux.dev, qemu-devel@nongnu.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>
Subject: Re: SVSM device assignment: device tree support
Message-ID: <ybpr7ctlwxzadwzhzmgxkycwcvnisloujq6wuvirdnokfnae2b@2wtitjynh325>
References: <CANo9s6kqgmSa4w-DkSRDqRw9gw0dBEmaM4yenczA+1uh6ZL9Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANo9s6kqgmSa4w-DkSRDqRw9gw0dBEmaM4yenczA+1uh6ZL9Pw@mail.gmail.com>
Received-SPF: pass client-ip=85.214.250.239; envelope-from=joro@8bytes.org;
 helo=mail.8bytes.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hey Luigi,

On Thu, Oct 09, 2025 at 03:20:08PM +0200, Luigi Leonardi wrote:
> -machine [..] svsm-bus=bus1
> -device virtio-blk-device,drive=svsm_storage,id=dev1
> -object svsm-devices,id=bus1,devices=dev1,dev2,dev3

As discussed in the meeting yesterday, here is my current in-progress
development branch for planes. It contains the Machine and QDEV properties to
assign planes to devices.

The commits you likely need:

97a524149cc1 qdev: Add plane property
dc9cfd1e2e81 hw/core/machine: Add device-plane property

Let me know if those work for you, and feel free to ignore the rest in this
branch.

Thanks,

	Joerg

