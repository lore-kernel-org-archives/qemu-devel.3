Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OXAr6dxR;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PUdof07B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTg2a-0003dV-0Q; Wed, 18 Nov 2026 08:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTg2X-0003bo-66
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 08:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTg2V-0000lI-8w
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 08:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795009768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2F2i0pfTzBOKTNGh3YzaikeGq+4G3I7FejB2iUQzwM=;
 b=OXAr6dxRoh6/3cR7a5wzuCn2K9iE8FT1gx+AEuWyjP/fzAow9PPoiKay+0cpTOWqF3UslD
 axceHwkRJxJULeK4OEJbT5lNyncLIKEUrVftdnYpYgn34VgFooKTGGup2nLIHuSDPuHPkX
 363jXhbac9JSL4bi0JCVybKBWK9tX3c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-YREsCkEdMiiwFdb_oqANew-1; Wed, 18 Nov 2026 08:49:27 -0500
X-MC-Unique: YREsCkEdMiiwFdb_oqANew-1
X-Mimecast-MFC-AGG-ID: YREsCkEdMiiwFdb_oqANew_1795009765
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c429d9d05f0so99616466b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795009765; x=1795614565; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y2F2i0pfTzBOKTNGh3YzaikeGq+4G3I7FejB2iUQzwM=;
 b=PUdof07B0oDiRIvGEuess/FmlNVtxbGRWB5LoOg5UUsN0h4WuHoPD3b9RMbsOyO0h9
 Rv54cv8sfBpirLDKIbuDohWc8X+6LmeUMu7iLb6SBg0uIT0+pikuLaxncDExLg5dBKXH
 5mjnqgO+5nvYxj6624FYSoMO+weHeVm+8hw4DkwhHGIaU6o2YRuT65sRctSZsTUo0J+R
 XNP+K4CtN++vn0iCJysQmH6SEElCpUAt6RWhMiGsZSD09KqoTXtHxF3g7hOeeVLF5SCJ
 rolkUyjkm06pqEHTskS5RMCW4/Ayimd3L/DUf5tsPpzcTkX8p57W/0ddYBFczQ8kNxH5
 /eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009765; x=1795614565;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y2F2i0pfTzBOKTNGh3YzaikeGq+4G3I7FejB2iUQzwM=;
 b=2Cno42GEfVA5Kh2InxmTdfTFVDz1CD2lJyMd4qxaldcoVRPMT8HsYPSHC1gzjbOqPQ
 03GO6M4+6pK/4HjUj2F/7TamMWKiethKtgfabYVl6GMhZ5HeiaTCJQLxP7H4XazTYjdq
 TWn6/rIbQlltHJ5fcgBuBTnS2YgLkkkXxJt9tSmf/VXNCSsOni77azHCcRUvCrICCYHq
 b1hrWHFG15ZqOvc4SeRHT2V5ezvokZhCf/U6dBkL1koMK07WFtQKI3mBG7Y+zKK/+XpD
 88eDvKtYYW4ujsv6gmQsjmYLb0W79C+8qJlxanT9jyZjfEivbi6fEeak/Ox3YRbCBLxQ
 KnXw==
X-Gm-Message-State: APuU4Z/UMvp1njqWN/TngLcWuQ8z+GV3u6GQq6kce2wlcNtVoeJEkmnq
 nS+J02NHgYr+2P8APdzg5AIwvkwQauK3LRUdChylFE5bviDAJ36pqBTu/l9FrbkZ7cabSrTqmnx
 FAYrA2xxRzSgoDcutNPR03XZJWrwM39EACxd7I5Lgx9LhqEPvvjHJQ63K
X-Gm-Gg: AYBFou1P2/Tes1+45i3fg/Qd/kIooawfH+Ft0Wc1l5JXQ2BQjxlm+8iDWwAAnI1W27j
 i+I+mSW5N7PyilBgx/4YgTEuS4hWdkqde/rEiduSdprZCNT2Ry0vUzqD84+z+5tAxWM75ZLayLl
 5Wc9sebbaFc7KjBZo6rA1wnS4Dfvw+wWYl7Q7eACSWo2XMbYFd6vmx5xxumWR8YfQ1u8HFJrbad
 t70XiyD+hm0pCcK0OAYn9MjwT1X1/PWrf29T3hpd3FXRJqgNzfw94iibcbhbG3TCi1pGNY+a0MR
 FM1jLNpNnQuY9hvycWaBtlPUsnFTVbm1Hu2D+FtOlR7X50+bVhuC7SZEU/1po3sgsYAALl25083
 PbxJa9TqryoWNHSmyS8Dq3KGZtRmigsyik4cMEW7RuqU=
X-Received: by 2002:a17:907:3e9b:b0:c40:f9ea:7387 with SMTP id
 a640c23a62f3a-c510dfd70d2mr202476166b.6.1795009765216; 
 Wed, 18 Nov 2026 05:49:25 -0800 (PST)
X-Received: by 2002:a17:907:3e9b:b0:c40:f9ea:7387 with SMTP id
 a640c23a62f3a-c510dfd70d2mr202472566b.6.1795009764567; 
 Wed, 18 Nov 2026 05:49:24 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c51233c2fb4sm657366b.27.2026.11.18.05.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:49:23 -0800 (PST)
Date: Wed, 18 Nov 2026 08:49:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 0/4] docs/devel, AGENTS.md: a completely new policy on
 AI-generated contributions
Message-ID: <20261118084905-mutt-send-email-mst@kernel.org>
References: <20261118104150.599535-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118104150.599535-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 11:41:46AM +0100, Paolo Bonzini wrote:
> In preparation for the next community call, here is another version of
> the new AI policy.  Discussion after v4 centered on two points, namely
> large contributions and cross-subsystem changes.  In order to facilitate
> reaching a consensus, I am splitting the part about larger contributions
> to a separate commit that can or cannot be included.
> 
> I will leave out from the cover letter the blurb on why reviewing the
> policy and the benefits/risks that it entails.  As before, the change
> seeks to ensure clarity on the part of contributors, and to have AI usage
> that helps us produce better code rather than flood us with dubious work.
> 
> Trying to split out large contributions made me realize how hard it is
> for such a policy to be balanced.  In my opinion, the version that
> does *not* allow large contributions makes the job harder for
> maintainers, because it does not provide a sanctioned way to grow
> a steady stream of small but useful contributions into something more
> structured.  I've tried to put my thoughts in the commit message of
> patch 4, which also covers cross-subsystem changes.
> 
> As before, the patches introduce agent instructions that help the
> contributor drive the design and understand the code produced by the LLM;
> the instructions are also split into "no large changes allowed" and
> "large changes allowed" parts.
> 
> I chose to move the Reviewed-by tags to the *last* patch, including the
> large contributions part, since that is effectively the version that was
> reviewed.
> 
> Paolo


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> v4->v5:
> - "AGENTS.md: add final instructions" already merged
> - fix rST syntax
> - section "No automated posting" in AGENTS.md revised and expanded;
>   same for the "official project agents" exception in the policy
> - "``AI-used-for`` must not be included unless some part of the patch
>   *content* was authored by the AI" added explicitly
> - disclosure required for all non-trivial, functional code changes,
>   even if only a small part of a larger patch
> - "docs/devel: allow larger contributions with pre-arrangement" split
> - minor wording changes, mostly to allow separating patch 4
> 
> Paolo Bonzini (4):
>   docs/devel: relax policy on AI-generated contributions
>   AGENTS.md: let agents know what the participation rules are
>   AGENTS.md: make the human part of the design process
>   docs/devel: allow larger contributions with pre-arrangement
> 
>  docs/devel/code-provenance.rst |  71 +----------
>  docs/devel/index-process.rst   |   1 +
>  docs/devel/llm-usage.rst       | 208 +++++++++++++++++++++++++++++++++
>  AGENTS.md                      | 138 +++++++++++++++++++---
>  scripts/checkpatch.pl          |   5 +-
>  5 files changed, 343 insertions(+), 80 deletions(-)
>  create mode 100644 docs/devel/llm-usage.rst
> 
> -- 
> 2.56.0


