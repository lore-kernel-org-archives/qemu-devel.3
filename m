Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8D60A6F6A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRQ6LRo1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQ4Y-0001hn-Q7; Fri, 20 Nov 2026 09:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xUQ4V-0001gV-39; Fri, 20 Nov 2026 09:58:39 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xUQ4S-00018j-MR; Fri, 20 Nov 2026 09:58:37 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA31660F33;
 Fri, 20 Nov 2026 14:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73821F000D3;
 Fri, 20 Nov 2026 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186712;
 bh=zDIF/ZcqoMcZWkJd7MOeBdNQ7mEKz0kwiIr5vVGXBH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GRQ6LRo1/tWtBznURkNDM2G8MtKJLJhNxjH4rt0yvkaeu91Wg6CKBYcizQh01Uhzw
 tvIf5arYfrP1ss4VgexRo+/afVyFGjCc0c84MtdBPtVUouKbCOOHqrHi9X0UxoTe2I
 FHtJzD1AL5jpTtP1sDyXevXwjZEAoNIFiW1q6SvmthO1hVvUhp5c+Go5EgkGj+fgaX
 UITMjV7oim7f2xpjZQOvevTewThwlSxM48+fjjf031PhX1NO/K8Id7OCPhUDmIJ7XA
 7A2hpVvRrU9RI8I3JmEKzJ/IUOqb1na3C7vmbRjVLXuUwv0x86wgF3RaSmLTUbQFpF
 kI1bviHXNAqJw==
Date: Fri, 20 Nov 2026 15:58:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v17 0/9] Add full zoned storage emulation to the qcow2
 driver
Message-ID: <awBgEvaATwrbgIc6@ryzen>
References: <20261112114918.1269168-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112114918.1269168-1-cassel@kernel.org>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:49:09PM +0100, Niklas Cassel wrote:
> This patch series adds a new extension - zoned format - to the
> qcow2 driver, allowing full zoned storage emulation on a qcow2
> image file. A user can attach such an image to a guest and have
> it appear as a host-managed zoned block device.
> 
> The zoned format is opt-in through a new qcow2 header extension
> that pins the zone geometry. Behind the extension is a dedicated
> zoned metadata region that stores one 8-byte write pointer (WP)
> per zone. The extension is gated by an incompatible bit, so an
> older qcow2 implementation cannot accidentally open the image.

[...]


Hi Kevin, Hanna, Stefan,


It would be great to get some guidance on what is needed to get this
series accepted. It is now at v17. Is there anything I can do to help
get it merged?

Almost all of the new code is only used by images created with the new
zoned feature, so the risk for existing users should be very low.

The only changes in code that every qcow2 image goes through are:

- Writes now go through qcow2_co_pwv_part(), but outside the zoned
  branches the code is the same as the old qcow2_co_pwritev_part().

- The additions to qcow2_refresh_limits(), qcow2_inactivate() and
  qcow2_do_close() only have an effect when the image has zoned
  metadata.

- qcow2_cache_set_dependency() now returns early when the dependency is
  already set, which avoids a redundant flush, without changing the
  write ordering. I could move this to a separate patch if you prefer.

Apart from one more entry in the feature name table of newly written
images, images that don't use the new zoned feature are unaffected.


Thanks,
Niklas

