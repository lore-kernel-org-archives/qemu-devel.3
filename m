Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397A0C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 15:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viaPY-0003EP-Pf; Wed, 21 Jan 2026 10:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viaPI-00031k-JL
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 10:46:14 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viaPC-0003DQ-Ny
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 10:46:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 812DC600AA;
 Wed, 21 Jan 2026 15:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F184C4CEF1;
 Wed, 21 Jan 2026 15:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769010360;
 bh=+Om1I8Qh73iaFr4puT+0UxX0bwvNiUNtnSFTJht76Us=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BlB0UTbmbX/ALr9HnC7x/Ui8r3gI1kyEjOvHLSwtaUm1zPRG0b8dr3lhFHrPhQRA3
 fqKrr0BS89iArRJqufirE2+KGmC7lKcF1LkwH9wr8pwYT1r1FWkPuB5y7zZvV1K00B
 A4e5ovbRZu8hA/mRqDFDObCFqPt8S5dBkoZgOB+FRbDdnjKR9CRDcDzRkjnKndXh5c
 /7Stpc74x4K58bH1leGP0gTHDxF89o3YhA7CfBCkFXpQWGHBmT6So7VaDy7fpDAHFz
 dYi8Q8ur0vLC9nPCBejjwgVFrJ1DBkFeksdRldvmNQwRUCGzxTKZZi93cYmzvKL9TK
 lvLh3CxnumsvA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1viaP8-00000003sfI-0t5r; Wed, 21 Jan 2026 16:45:58 +0100
Date: Wed, 21 Jan 2026 16:45:58 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Michael S Tsirkin <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-devel@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 02/13] scripts/qmp_helper: add missing CXL UEFI GUID
Message-ID: <aXDx_N3YRACBmC4I@foz.lan>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <f229d756fe76c34e6dfa48a98f1ee46f4325fc76.1768993993.git.mchehab+huawei@kernel.org>
 <20260121122604.00001609@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121122604.00001609@huawei.com>
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 21, 2026 at 12:26:04PM +0000, Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 12:25:10 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The UEFI 2.11 - N.2.14. CXL Component Events Section states that
> > XL events are described at CXL specification 3.2:
> CXL
> 
> >         8.2.10.2.1 Event Records
> > 
> > Add the GUIDs defined here to fuzzy logic error injection code.
> 
> +CC linux-cxl as more folk there who will be familiar with this
> stuff.
> 
> Some of these won't be seen on a host. The same event
> infrastructure is used for reporting on out of band interfaces
> and some in band ones, but not ones that will turn up on the
> mailboxes that firmware will be using to get info.

Good to know, but UEFI 2.11 still mentions all of them as
possible GUIDs:

    https://uefi.org/specs/UEFI/2.11/Apx_N_Common_Platform_Error_Record.html#cxl-component-events-section

So, the UEFI 2.11 doesn't explicitly state they won't de delivered
to OSPM. Quite contrary, they're listed as valid values for CPER,
even if, in practice, they won't.

This is just a small set of variables, that won't bring any major
impact on the code. So, I prefer to keep them in sync with the spec.
If they end removing the unused ones, we can update it in the future.

If you want, I can add a note at the next version with your
comments about them.

> 
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  scripts/qmp_helper.py | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> > index 249a8c7187d1..7e786c4adfd9 100755
> > --- a/scripts/qmp_helper.py
> > +++ b/scripts/qmp_helper.py
> > @@ -711,3 +711,28 @@ class cper_guid:
> >      CPER_CXL_PROT_ERR = guid(0x80B9EFB4, 0x52B5, 0x4DE3,
> >                               [0xA7, 0x77, 0x68, 0x78,
> >                                0x4B, 0x77, 0x10, 0x48])
> > +
> > +    CPER_CXL_EVT_GEN_MEDIA = guid(0xFBCD0A77, 0xC260, 0x417F,
> > +                                  [0x85, 0xA9, 0x08, 0x8B,
> > +                                   0x16, 0x21, 0xEB, 0xA6])
> > +    CPER_CXL_EVT_DRAM = guid(0x601DCBB3, 0x9C06, 0x4EAB,
> > +                             [0xB8, 0xAF, 0x4E, 0x9B,
> > +                              0xFB, 0x5C, 0x96, 0x24])
> > +    CPER_CXL_EVT_MEM_MODULE = guid(0xFE927475, 0xDD59, 0x4339,
> > +                                   [0xA5, 0x86, 0x79, 0xBA,
> > +                                    0xB1, 0x13, 0xBC, 0x74])
> > +    CPER_CXL_EVT_MEM_SPARING = guid(0xE71F3A40, 0x2D29, 0x4092,
> > +                                    [0x8A, 0x39, 0x4D, 0x1C,
> > +                                     0x96, 0x6C, 0x7C, 0x65])
> 
> The above are all fine I think.
> 
> From here on I think they will never come via a CPER record.
> 
> > +    CPER_CXL_EVT_PHY_SW = guid(0x77CF9271, 0x9C02, 0x470B,
> > +                               [0x9F, 0xE4, 0xBC, 0x7B,
> > +                                0x75, 0xF2, 0xDA, 0x97])
> 
> This is only going to surface over either out of band or switch CCI
> I'd be very surprised to see a firmware anywhere near these.
> More specifically they are only defined in the Fabric management
> section of the spec, which strongly hints we'd not expect host firmware
> to know anything about them. 
> The events reported may well span bits of the topology currently
> assigned to different hosts.
> 
> > +    CPER_CXL_EVT_VIRT_SW = guid(0x40D26425, 0x3396, 0x4C4D,
> > +                                [0xA5, 0xDA, 0x3D, 0x47,
> > +                                  0x2A, 0x63, 0xAF, 0x25])
> 
> Also a fabric management event.
> 
> > +    CPER_CXL_EVT_MLD_PORT = guid(0x8DC44363, 0x0C96, 0x4710,
> > +                                 [0xB7, 0xBF, 0x04, 0xBB,
> > +                                  0x99, 0x53, 0x4C, 0x3F])
> 
> Also a fabric management event.
> 
> > +    CPER_CXL_EVT_DYNA_CAP = guid(0xCA95AFA7, 0xF183, 0x4018,
> > +                                 [0x8C, 0x2F, 0x95, 0x26,
> > +                                  0x8E, 0x10, 0x1A, 0x2A])
> These are never routed to firmware. They are part of the OS only
> managed flows for dynamic capacity.
> They have their own event log on the hardware and for this particular
> set most relevant thing is in
> CXL 4.0 Table 8-235 Set Event Interrupt Policy Input Payload
> which controls whether a firmware interrupt or MSIX is used signal
> the Dynamic Capacity Event Log Interrupt Settings only allows
> for MSI/MSI-X, not FW interrupt (EFN VDM) like the other logs.
> 
> 
> Jonathan
> 
> 

-- 
Thanks,
Mauro

