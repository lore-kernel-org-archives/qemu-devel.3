Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF7AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 17:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwmhr-0001wS-Fs; Tue, 16 Apr 2024 13:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rwmhp-0001vs-Uv
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 13:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rwmhn-0007Tp-PM
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 13:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713288889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4VUD7XgCvQwaV/ndPxwS9eP/gGb9+3wYXeAM9/M6+sw=;
 b=f4F+MiYRPPbuxVoIwb4nDks/GwB6gT7jhl3DEEd6yN29Aa/KQAGMT6kVkCapqw/IPn0Jkj
 HugorCdRgaPg3+bbJq/BjjlhaH5jY7nXbnW9d9w6tJFGs8Z7c3xTE4Ti6ZhA5Vu5ItUyfw
 IHg0RlGVaHXEu9TnZBu3DuUvenn+cG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-23amIaS8MTK0TfxLBv0Muw-1; Tue, 16 Apr 2024 13:34:47 -0400
X-MC-Unique: 23amIaS8MTK0TfxLBv0Muw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C23F80D626;
 Tue, 16 Apr 2024 17:34:47 +0000 (UTC)
Received: from [10.22.17.216] (unknown [10.22.17.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 424E51C06668;
 Tue, 16 Apr 2024 17:34:46 +0000 (UTC)
Message-ID: <5b8db53e-e073-4159-9f77-f9856ffce94e@redhat.com>
Date: Tue, 16 Apr 2024 13:34:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-8.2.3 00/87] Patch Round-up for stable 8.2.3, freeze on
 2024-04-20
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
From: Cole Robinson <crobinso@redhat.com>
Content-Language: en-US
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crobinso@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/10/24 3:21 AM, Michael Tokarev wrote:
> The following patches are queued for QEMU stable v8.2.3:
> 
>   https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2
> 
> Patch freeze is 2024-04-20, and the release is planned for 2024-04-22:
> 
>   https://wiki.qemu.org/Planning/8.2
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.
> 
> The changes which are staging for inclusion, with the original commit hash
> from master branch, are given below the bottom line.
> 
> Thanks!
> 
> /mjt
> 

We have a couple patches in f40 that are bug fixes, avoids a crash on
invalid maxcpus for ppc64 guests. First is a prep patch. bug details in
patch 2

commit 2df5c1f5b014126595a26c6797089d284a3b211c
Author: Harsh Prateek Bora <harshpb@linux.ibm.com>
Date:   Wed Jan 24 10:30:55 2024 +1000

    ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer IRQ range for CPU IPIs.

commit c4f91d7b7be76c47015521ab0109c6e998a369b0
Author: Harsh Prateek Bora <harshpb@linux.ibm.com>
Date:   Wed Jan 24 10:30:55 2024 +1000

    ppc/spapr: Initialize max_cpus limit to SPAPR_IRQ_NR_IPIS.


Thanks,
Cole


