Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1528BCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMmm-0006II-Cf; Tue, 19 May 2026 11:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wPMml-0006I4-J4; Tue, 19 May 2026 11:55:11 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wPMmk-0000x1-0M; Tue, 19 May 2026 11:55:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0671B403E5;
 Tue, 19 May 2026 15:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9ACC2BCB3;
 Tue, 19 May 2026 15:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779206106;
 bh=GoQHfXCdVckpEKCsWIlgd1r0xNEIfDDkcSrE9XNDw5M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RyGum5yd6t0ZDO4FeOx+kpikZbTaMedwtREcKUU18VTmMy7VbbU2AyfnLlpENYNXE
 W8SpReyMFC8jYEIoCUSXdYy6M7VXxqaSTJ8HvhH2iR3FwaQXJ7+mRAA6RCD8tr3stu
 LH67hqsC9eBIMDTDpJgvB1Jgzfn7M+yhO7G4wzJV7rEEhCEjTG6ggL1Dqx7iRJGA8l
 uLXSPaWRBn6WRz5tu9E0UsVi8mwAwW3xPUSIcmM6nID+Lk4fcYddxydMfsclykFiCh
 WPrjFgk3fDbNC/zChOEA0TY1THriXcJRj2RlgR4HkpbIotWp6ZIYu6PE4rwcdimSUW
 WomeFD8OHiENQ==
Message-ID: <0a298463-0f63-4a04-b3d9-cbca2a47dbf3@kernel.org>
Date: Tue, 19 May 2026 17:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] qcow2: add configurations for zoned format
 extension
To: Stefan Hajnoczi <stefanha@redhat.com>, Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 hare@suse.de, Hanna Reitz <hreitz@redhat.com>
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-3-faithilikerun@gmail.com>
 <20260514194906.GC1535937@fedora>
 <CAAAx-8K+12SGZqzpLGsxjsr6iGAHwQu-TUXe6Z6rtZA27OpjrQ@mail.gmail.com>
 <20260519154911.GB119642@fedora>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260519154911.GB119642@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=dlemoal@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2026/05/19 17:49, Stefan Hajnoczi wrote:
> Damien: Do real zoned block devices guarantee that the updated write
> pointer is persisted only after appended data has written been
> persisted?

Yes, they do. Write data first, then persist the write pointer.
Note that when there is data (write) caching, the write pointer can show the
data as "written", but in that case, a power loss will result in returning to
the last position of written data. Persistence of the write pointer happens
always after the data is persisted on media. qcow2 image should be the same.



-- 
Damien Le Moal
Western Digital Research

