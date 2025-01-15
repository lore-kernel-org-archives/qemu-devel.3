Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A70C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 10:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY0Yq-0005Xe-HD; Wed, 15 Jan 2025 05:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tY0Yo-0005XF-Ji
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:23:42 -0500
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tY0Yl-0002qc-4X
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:23:42 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.2.137])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4YY2CB5x5Dz1XbH;
 Wed, 15 Jan 2025 10:23:34 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 15 Jan
 2025 11:23:34 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0040283adc8-b5e1-44b3-8f4a-37fb918afa0b,
 D782EAFCD2DF553E1060EFE110845FF2EEF9A11B) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Wed, 15 Jan 2025 11:23:33 +0100
From: Greg Kurz <groug@kaod.org>
To: <qemu-devel@nongnu.org>
CC: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] MAINTAINERS: Mark me as reviewer only for 9pfs
Message-ID: <20250115112333.072431fa@bahia>
In-Reply-To: <20250115100849.259612-1-groug@kaod.org>
References: <20250115100849.259612-1-groug@kaod.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 639447e2-06c4-421f-9652-4414596adca0
X-Ovh-Tracer-Id: 10134788012646046106
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudehkedgudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefgudefueeigeeviedujeeuieevhfeuiedvkeelkeetkeekkeegvdehheeuvdehgfenucffohhmrghinhepqhgvmhhurdhorhhgpdhgihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddvpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdpoffvtefjohhsthepmhhoheehvdgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=fI/SgAJRFkwPM94tlWMkI5wlkS5m8d514L2WeqTKy80=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1736936614; v=1;
 b=Kw8TBRjr0GFabHQCumXAL8f8nKR3v3HuvkV1KS/lTsrqgmMCPi9CvUW5cs2+y4FTZS7zVDVM
 7C3gGbCYYtg5aO+UDXoKJV2HCDlZcjlCb1b9SknsMl1cnwS3rBO/g6lXV6S9Z+hgw2V4aKQJxlN
 Fbx6oV2tzC8VDpKKWSKGB9Y3mmUWzOVTZfy/NUeymWc8tMAnIF9f8ktu+h28i6gWo60rBqJJ/e1
 yYOndzgB+/8tGWRIpeXtgA5V9eLQXRItL6JdF97enXBUxgD8g2apLB5UeQWC4yCcSOIujFHQfTS
 zTcT2WuZb5n58+/aXUghV94ajadefYFqtARx8dWIegolA==
Received-SPF: pass client-ip=188.165.45.220; envelope-from=groug@kaod.org;
 helo=5.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 15 Jan 2025 11:08:49 +0100
Greg Kurz <groug@kaod.org> wrote:

> I still review 9pfs changes from time to time but I'm definitely
> not able to do actual maintainer work. Drop my tree on the way
> as I'll obviously not use it anymore, and it has been left
> untouched since May 2020.
> 

I was looking at the wrong tree, it is Nov 2022 actually but
that doesn't change a thing ;-)

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b9d9a7cacbb..adc93ac0f4b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2248,8 +2248,8 @@ F: include/system/balloon.h
>  F: tests/qtest/virtio-balloon-test.c
>  
>  virtio-9p
> -M: Greg Kurz <groug@kaod.org>
>  M: Christian Schoenebeck <qemu_oss@crudebyte.com>
> +R: Greg Kurz <groug@kaod.org>
>  S: Maintained
>  W: https://wiki.qemu.org/Documentation/9p
>  F: hw/9pfs/
> @@ -2257,7 +2257,6 @@ X: hw/9pfs/xen-9p*
>  F: fsdev/
>  F: tests/qtest/virtio-9p-test.c
>  F: tests/qtest/libqos/virtio-9p*
> -T: git https://gitlab.com/gkurz/qemu.git 9p-next
>  T: git https://github.com/cschoenebeck/qemu.git 9p.next
>  
>  virtio-blk



-- 
Greg

