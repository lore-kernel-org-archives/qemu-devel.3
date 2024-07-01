Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570B7C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOHMA-00005W-JR; Mon, 01 Jul 2024 09:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sOHM7-0008WO-Pn; Mon, 01 Jul 2024 09:46:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sOHM2-00062O-3c; Mon, 01 Jul 2024 09:46:07 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f9ffd24262so15896135ad.0; 
 Mon, 01 Jul 2024 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719841560; x=1720446360; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W9RoklQ2LvgZlpXGHlOhboN8eHo16K+jSTSigx85xjU=;
 b=dHEk3nUByDKYrhJjsRiXHLJW/4oQU/WxJcbV+n7q3aOF/sm2LxoniXDBbws3C+tSOD
 pNvlMho3HDu80F/HIAq5446exHPh6EJ+mAZk3Dek7S8eGtloiFkOA1BGOt6j7laArxo0
 yVW2dKInFcpkoQW7jxee3x0ranWUu5QVU0Zbl2XXMlA3QTTZjjGACfuPGtD8vkCCjhvD
 Dbsgzs0Ma5YgFEzHUAQHkLgaUSkwprthi01sV4C7OrX8H0YjCeVLbxFEnH5mo9NVkLpX
 LoE9WePwSJ5qGXH1DUEfMfW6d95AE/fmvzaar/MaMvG/e/j4sEbz8fHMKVNsWG6+EPiM
 o/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719841560; x=1720446360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9RoklQ2LvgZlpXGHlOhboN8eHo16K+jSTSigx85xjU=;
 b=nVbyWEpdCfXbRJwzOVAC0UW9Y5uXztB537LGQgVERa9mKs7PI5rnUNsskf1bSVZf0o
 Q1PhDulSo8Rq7isDg+Q6g7VGNv2sJdW7u5FI8aRklnWVG+gPecT+C9RAONHBpN70cTOb
 BDABZ3QH+qlE6b+tf44whoxovWyrQ3vs9BVV8GlwjFz777hQgvBz8nd+Z64yEB6nP2v6
 I0xnS6T3Qe2lWz5Fg2m6vsyD/iYAgIIv/fnFAuk2NEsCAOpXQ7fZmC7FCkSulRf4YUw/
 8WhJ7JeMiBLZ4LViLPpkchkwT/xR4iuWBgS18IjRJSA8EepExuvXudAkEwwaQZHoTKD+
 I73A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKM475yfZxDNsAPuVqT+uPjef9Qoxq+MTHvYQwjnLpYVW7e5UHgU05EZy3WqCq+7iE/Ba3GZDaZmP3VULFaYuwo9FWZ5TQkCHVIWIaIa4c1dITtUE78pwAlHJ6Ug==
X-Gm-Message-State: AOJu0Yzj3QdBPleAD87JJ8ByLE7RN6FWJkQK0vC9OcurvqoJ+RvmIfr2
 qAp25FceKbWDjwknXtMyIsDlLog67+TzPyr4wSChRp4lequQ2+typvFwNIvI
X-Google-Smtp-Source: AGHT+IEWzJQyX5YDyds/azuP3OkENnTfd3D48bHanlsASBgqekK/TGNFfehuksmx/qz38MRdWpg5kA==
X-Received: by 2002:a17:902:e943:b0:1f9:e94c:f52c with SMTP id
 d9443c01a7336-1fadbca1c43mr32422855ad.35.1719841559581; 
 Mon, 01 Jul 2024 06:45:59 -0700 (PDT)
Received: from amjad-pc ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535d58sm64655375ad.125.2024.07.01.06.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 06:45:59 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:45:55 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 0/5] vvfat: Fix write bugs for large files and add
 iotests
Message-ID: <ZoKzE1lG8Qy_I1TC@amjad-pc>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718195956.git.amjadsharafi10@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Can I get review for this patch?

Thanks,

Best regards,
Amjad

On Wed, Jun 12, 2024 at 08:43:21PM +0800, Amjad Alsharafi wrote:
> These patches fix some bugs found when modifying files in vvfat.
> First, there was a bug when writing to the cluster 2 or above of a file, it
> will copy the cluster before it instead, so, when writing to cluster=2, the
> content of cluster=1 will be copied into disk instead in its place.
> 
> Another issue was modifying the clusters of a file and adding new
> clusters, this showed 2 issues:
> - If the new cluster is not immediately after the last cluster, it will
> cause issues when reading from this file in the future.
> - Generally, the usage of info.file.offset was incorrect, and the
> system would crash on abort() when the file is modified and a new
> cluster was added.
> 
> Also, added some iotests for vvfat, covering the this fix and also
> general behavior such as reading, writing, and creating files on the filesystem.
> Including tests for reading/writing the first cluster which
> would pass even before this patch.
> 
> v5:
>   - Fix a bug in reading non-contiguous clusters in vvfat for more than 2 mappings.
>   - Added a test for adding more clusters where they are non-contiguous and
>     result in 3 mappings (for the above fix).
>   - Split PATCH 2/4 into 2 patches and a better fix for the `abort` issue (now in PATCH 3/5).
>   - Other fixes and improvements in `fat16.py` module used for iotests.
> 
> v4:
>   Applied some suggestions from Kevin Wolf <kwolf@redhat.com>:
>   - Fixed code formatting by following the coding style in `scripts/checkpatch.pl`
>   - Reduced changes related to `iotests` by setting `vvfat` format as non-generic.
>   - Added another test to cover the fix done in `PATCH 2/4` and `PATCH 3/4` for 
>     handling reading/writing files with non-continuous clusters.
> 
> v3:
>   Added test for creating new files in vvfat.
> 
> v2:
>   Added iotests for `vvfat` driver along with a simple `fat16` module to run the tests.
> 
> v1:
>   https://patchew.org/QEMU/20240327201231.31046-1-amjadsharafi10@gmail.com/
>   Fix the issue of writing to the middle of the file in vvfat
> 
> Amjad Alsharafi (5):
>   vvfat: Fix bug in writing to middle of file
>   vvfat: Fix usage of `info.file.offset`
>   vvfat: Fix wrong checks for cluster mappings invariant
>   vvfat: Fix reading files with non-continuous clusters
>   iotests: Add `vvfat` tests
> 
>  block/vvfat.c                      |  47 +-
>  tests/qemu-iotests/check           |   2 +-
>  tests/qemu-iotests/fat16.py        | 673 +++++++++++++++++++++++++++++
>  tests/qemu-iotests/testenv.py      |   2 +-
>  tests/qemu-iotests/tests/vvfat     | 457 ++++++++++++++++++++
>  tests/qemu-iotests/tests/vvfat.out |   5 +
>  6 files changed, 1164 insertions(+), 22 deletions(-)
>  create mode 100644 tests/qemu-iotests/fat16.py
>  create mode 100755 tests/qemu-iotests/tests/vvfat
>  create mode 100755 tests/qemu-iotests/tests/vvfat.out
> 
> -- 
> 2.45.1
> 

