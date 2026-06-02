Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8B7CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULXu-0003MR-N8; Tue, 02 Jun 2026 05:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1wULXt-0003MD-2Y
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:36:25 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1wULXr-0007rh-NR
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:36:24 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 447726001A;
 Tue,  2 Jun 2026 09:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E031F0089A;
 Tue,  2 Jun 2026 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780392981;
 bh=BKXoqnTdMm4EiNwLWWKFioYNkFHuQBTPFqGzXZoQJfc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cuMrCWwywlrf8M7xpIPEL9cNgx2cjvTNJmT5o+FtYXmfVt9/VE2zKgbeCdFb3jq0u
 8jTgQx1NZbzqmWLz9dtJN+ljeq5E2ciFsuh6gFKWzaT/Cx1XuAKNhCzIBH7RQ3T6rF
 +vAiSTU6AZfzloWnU1aZMlQpVNvXasq4zTBw3zjkVwlkXWkInreNovc0rTEj5Ch5N2
 wLYwq5DZyNzbpKtPOfIRZEsU/Qn0FMpPJnPhhuUXkIK9ciOGZcG8fsMVu0vXdPPCu7
 FdEwzQ8icOC0letKpoqpN3aqm5fFINbXkhxzX5hA7sc8IwPO9VwkoozXNc+7VdHwhw
 N1xWj9mEAWajw==
Message-ID: <39411489-1473-44ad-ad56-392aa27990ab@kernel.org>
Date: Tue, 2 Jun 2026 11:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] hw/mem: add spm-memory device for Specific Purpose
 Memory
To: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 imammedo@redhat.com, gourry@gourry.net
Cc: Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=david@kernel.org; helo=tor.source.kernel.org
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

On 6/2/26 10:44, fanhuang wrote:
> This series adds a TYPE_MEMORY_DEVICE subclass `spm-memory` 

Very nitty: but spm already includes "memory". And I think most things on the
cmdline use "mem" as abbreviation.

"sp-mem" ? or simply "spm" ? Thoughts?

-- 
Cheers,

David


