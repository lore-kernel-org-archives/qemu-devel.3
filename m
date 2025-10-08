Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC519CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 13:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Tx3-0003el-6R; Wed, 08 Oct 2025 09:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1v6Tx0-0003d4-8a
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:11:26 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1v6Twt-0002s0-T8
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:11:24 -0400
Received: from movement by movementarian.org with local (Exim 4.97)
 (envelope-from <movement@movementarian.org>)
 id 1v6Twh-000000023r6-0DVQ; Wed, 08 Oct 2025 14:11:07 +0100
Date: Wed, 8 Oct 2025 14:11:07 +0100
From: John Levon <levon@movementarian.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Subject: Re: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
Message-ID: <aOZi6zvqp-mAH9Ke@movementarian.org>
References: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
 <20250924070254.1550014-2-zhenzhong.duan@intel.com>
 <01f0b0eb-b036-4823-8020-fd6962b26d9d@redhat.com>
 <aNxT1w0BbMH6pJ0J@movementarian.org>
 <d715d9dd-a613-4406-93c1-507d1470619f@redhat.com>
 <IA3PR11MB91364A76C06D76B0E6ADBEBD92E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <7256274c-ac20-4ef8-9841-48be7bfa2b91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7256274c-ac20-4ef8-9841-48be7bfa2b91@redhat.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On Wed, Oct 08, 2025 at 03:01:34PM +0200, Cédric Le Goater wrote:

> > > Should we introduce a VFIOContainerBase attribute/flag
> > > 'unmap_all_supported',
> > > set in the vioc->setup handler ?
> > 
> > Do you mean to check bcontainer->unmap_all_supported and do the split in vfio_listener_region_del()?
> > 
> > If only checking it in legacy container, putting it in VFIOLegacyContainer sounds better?
> 
> It depends if vfio-user needs it too.

vfio-user always supports this flag.

regards
john

