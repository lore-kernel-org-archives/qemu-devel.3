Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714B8C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtRg8-0005q5-K5; Mon, 10 Aug 2026 11:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtRfz-0005pE-UJ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtRfy-0001oS-H7
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786374749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wZX4HDp0ggGodc0JFtR6vubC9P2aeg637EvufH5Dr2o=;
 b=WRp+PcgPxhtKu1cntH7umWbDBR66+uOfIeC5q/zLAOFxqG1pCaBPGLkoOcXha9t1ryqMe9
 nAwzdtRLPCvtR2NqD8X8AAOzpaqC2jVHmCLfMM8dUCAFkkxbybilgJUSClVssqgocABDdN
 wkG7tUd8+dAxrZ0djSK+3fIRcv6CY8I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-wGsOHSiUMdOypD5938BMXw-1; Mon, 10 Aug 2026 11:12:25 -0400
X-MC-Unique: wGsOHSiUMdOypD5938BMXw-1
X-Mimecast-MFC-AGG-ID: wGsOHSiUMdOypD5938BMXw_1786374744
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955fd77c18so13115485e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786374744; x=1786979544; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wZX4HDp0ggGodc0JFtR6vubC9P2aeg637EvufH5Dr2o=;
 b=Hrhrf89/AQct1yDnImd4EWbWD+rqotUnSYUOhYTrCcQSbaA+CbyeAx+/WHNlSgtkra
 9R9EjU19rw8WCPOHXoNgCPef7uxhD4f2mr/KxqqwbdCsODY4QthDvp0Dtgr+QGvToP0l
 QLTuaeZe++5AFa/qF28rg3dk+5cdk/hJLer7g9svHQxJGGwhapP6zSxmqEs5kL68qqzs
 j7/alB38crgzPtPoL7utrJsnt15XzO9AD5ilQfcYSerMTvZmqPPSQNaPdALj1n3IE0jG
 5LSW5cDJ7fm2b+8DAcr2IBpD/Z/t5fLUCHNLVYjpK6D0ML57B3UPfMUTj0IQ1LZL2sWB
 lNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786374744; x=1786979544;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wZX4HDp0ggGodc0JFtR6vubC9P2aeg637EvufH5Dr2o=;
 b=Hdwg5/bRah6gIouAWj3ct2XCk6mjE+smkHUXVDo2rMcrZ+HVTDLGCQkQsVN80qjlgU
 qJpKg9AspBoiz+beNM6qG9l2e1S55SweCodYInFIjy3iuwtTW7KjXDiF/X/gJA574eGc
 qxOCbm+tlqHv9Yhpe0YUnK62VvcmogedpJlOw253Y6p7LPYTiD7AX0sMkH8G/ktWvJ4g
 S7neoyKFytc/hx8XOpFvPIiQnaN1CMyqVMiUwMZZPYGz9U5WySmiC/Ta8eblJr7C7kwK
 pbGYj/jAylKr9876LQ7rvnju62w28wW2MmXpZgfz4KYvD8QgmlWQAImNFiwmd0Mp+kRt
 jofA==
X-Gm-Message-State: AOJu0Yz6JYkV+lsMdEffOMBSdbLVflws7U3qoLaaavLD7eP1mjLG8EY0
 a4E1mDOAZS6mEnd/U+ORDdmFAwkJkFUzas8Ms2vO9m9tvO2r9gmSVqhRdwoMo9loCCkK1fJqNet
 mdhFnlyAJo723DVfpeqjMPdv8zW9xvxynk5/W1guahvlBXElvxcaD/HAx
X-Gm-Gg: AR+sD10zAmiIU96zDRQjiOBeh8dzHQ9y/xxe6+G9o2F11QbifOnl5LXhGquXlHg1hWH
 2kEpRDs+dWJk30Q4NZSF2NGVrfSoR+TxYDDiUPaFNPxArNYvzdZXU+dJ6OlDB/0OD+UxtzY3OqJ
 QiHv5J4TBbeH6GIa6SICj9nQJMptxuG+mREdU+5MRfY2Piyhzm3YLyQEtgmh1HdYut4sATate8h
 a8luXm9seHeu61SgfEGNSwTnuNAW84U79lZB2XgHyDlIVkLbqXtFOMMqMYqNMvKBEcgNCHy8CnW
 +vd6hT8ljkZYfFQuQtDhzMKgkwOlTJvDZkkz8e1vez/Bp/5wTKAqHyCr
X-Received: by 2002:a05:600c:474a:b0:496:c361:fb96 with SMTP id
 5b1f17b1804b1-4994e6db5aemr520705305e9.0.1786374743941; 
 Mon, 10 Aug 2026 08:12:23 -0700 (PDT)
X-Received: by 2002:a05:600c:474a:b0:496:c361:fb96 with SMTP id
 5b1f17b1804b1-4994e6db5aemr520704665e9.0.1786374743593; 
 Mon, 10 Aug 2026 08:12:23 -0700 (PDT)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995420bd1csm442323145e9.3.2026.08.10.08.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:12:22 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:12:20 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 pbonzini@redhat.com, philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 06/11] migration: add RAMBlock field and helper for
 fast snapshot load
Message-ID: <annqQ6WqANY1MH1G@fedora>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-7-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-7-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026-08-01 08:06, Aadeshveer Singh wrote:
> Add pending_bmap field per RAMBlock which is a Bitmap to store
> internal state of which pages have been read by some thread to ensure
> coordination between fault thread and eager load thread.
> 
> Modify parse_ramblock_mapped_ram(), to not load the actual RAMBlocks
> data in postcopy case as that will be loaded by fault thread and eager
> thread after the VM starts running.
> 
> Change ram_load() to use new function ram_should_load_postcopy_pages()
> to decide how to load/read RAM.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  include/system/ramblock.h |  6 ++++
>  migration/ram.c           | 59 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 59 insertions(+), 6 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


