Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24245C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsN1e-0003wY-3z; Wed, 12 Mar 2025 10:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tsN1c-0003w2-AE
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:25:36 -0400
Received: from 2.mo552.mail-out.ovh.net ([178.33.105.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tsN1W-00033E-2C
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:25:32 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.139.40])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4ZCXwP5fyTz1R8j;
 Wed, 12 Mar 2025 14:25:25 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 12 Mar
 2025 15:25:23 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0065e82f02d-aa6b-44ab-9cfb-2e160e9c6507,
 504EDC0C94310F6A3F54FBF2D573176B3056D9B9) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Wed, 12 Mar 2025 15:25:20 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 6/6] tests/9p: Test `Tsetattr` can truncate unlinked
 file
Message-ID: <20250312152520.25f3dd79@bahia>
In-Reply-To: <4178394.pcGFbxMBL1@silver>
References: <20250311172809.250913-1-groug@kaod.org>
 <20250311172809.250913-7-groug@kaod.org>
 <4178394.pcGFbxMBL1@silver>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 6a3d98c5-c400-498b-9578-541217bb76a6
X-Ovh-Tracer-Id: 11048737262515100067
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeekjedtveegkeeileffvdetvddvgedtudduiefghffhgfdvhfegjeetkeehfeeknecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdehpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehfrghrohhsrghssehsuhhsvgdruggvpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlvhhivhhivghrsehrvgguhhgrthdrtghomhdpoffvtefjohhsthepmhhoheehvdgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=isSXi/pCXsQEL0DsbV8tfaQgqqI8Pv/Stj6DIg9i7SA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1741789526; v=1;
 b=FZhSAkDLVrdT+Q7TcbiTDtXxXRYRXpAuVQe5Bv+zEMrYr0Z09VkvwAnUHJRj4024VQ+V5RAb
 kNcGOYS73cx+wIuvf2XjkWlXmEKmHKnMgZOPnJTlQmbhaSHAqTPx5iMGihY6nQuQf0CCFeR8Q2E
 sckh7jR9T3ZkuR4LKM3llx3A5cLAJL2eApSBaeZtMIILvhulA5PB8za6KmQrO5Cbz2Y1s/aSNQ0
 Hs8HSFxsG7xpFmLZwdNPrrCvXNtNDI/KYPbzm8bEfMq2bWHjrkprIqAGyCsGWDXWoWEVCQb4aQe
 j2HPMbuOhz1C0dOLpJGmDM8r+Agn8PRbSYrKemNvL6qrg==
Received-SPF: pass client-ip=178.33.105.233; envelope-from=groug@kaod.org;
 helo=2.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 12 Mar 2025 15:11:41 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Tuesday, March 11, 2025 6:28:09 PM CET Greg Kurz wrote:
> > Enhance the `use-after-unlink` test with a new check for the
> > case where the client wants to alter the size of an unlinked
> > file for which it still has an active fid.
> > 
> > Suggested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  tests/qtest/virtio-9p-test.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > index f515a9bb157b..20c0d744fa56 100644
> > --- a/tests/qtest/virtio-9p-test.c
> > +++ b/tests/qtest/virtio-9p-test.c
> > @@ -736,6 +736,14 @@ static void fs_use_after_unlink(void *obj, void *data,
> >          .data = buf
> >      }).count;
> >      g_assert_cmpint(count, ==, write_count);
> > +
> > +    /* truncate file to (arbitrarily chosen) size 2001 */
> > +    tsetattr({
> > +        .client = v9p, .fid = fid_file, .attr = (v9fs_attr) {
> > +            .valid = P9_SETATTR_SIZE,
> > +            .size = 2001
> > +        }
> > +     });
> >  }
> >  
> >  static void cleanup_9p_local_driver(void *data)
> > 
> 
> Ah, I just meant the code snippet as a starting point, like I would have also
> checked with a stat() call whether 9p server really did what it promised.
> 
> But OK, better some test coverage than nothing. :)
> 

FWIW the server returns ENOENT if it doesn't have the fix which causes
the check to fail. I was assuming this would be enough but I'm fine with
adding an extra check if you want.

> /Christian
> 
> 



-- 
Greg

