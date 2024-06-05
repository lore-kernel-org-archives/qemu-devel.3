Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C51BC25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEegC-0002kJ-No; Tue, 04 Jun 2024 20:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sEegB-0002k4-OE; Tue, 04 Jun 2024 20:39:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sEegA-0007C6-68; Tue, 04 Jun 2024 20:39:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f61f775738so44265615ad.2; 
 Tue, 04 Jun 2024 17:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717547940; x=1718152740; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cXxlWoJCx33kyM7kFqa0i/9FBNvLUHEwPFWM2kz6UiU=;
 b=FS6vFy01AozsA0AfzzuuDU9vNHgiWzpXQ5K1ojGvbx/0CDVadxptXUijdCMNBpVTlx
 HBto5X0mhuKjr8UhvHaEBEqCnE+ukoEipB4/LdxdnkKeDrAgV51wd13Bey0yiIbb/XCk
 BHkDmh+WJdBJ9DDcz1KE0kq1T/XUwZXrZOlQDfbndwGCnLxiNutDFJvRvhuhyvKN+sMN
 9eSsxwp/8KWn4776hM8PnrmER1nmphdbCFcXpjNE7NF2A6LUeKsGpL7vFvhZ/Us8pJ2g
 NwjB1btrikQl8MH8jaVZUSE8TVDG84HBNOaOmAWMtBuUR8byVZLnzIOLd9gZH6rH5c9/
 w8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717547940; x=1718152740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXxlWoJCx33kyM7kFqa0i/9FBNvLUHEwPFWM2kz6UiU=;
 b=RhBQi3YZKp1amj6/ZFzBC+4xcjt7OAY+BRrpM1Tbfgu7yTkgOadggVFAj9fx98zIvX
 9GKdsF1ckTNNhQT8ilB2y8UEWPgen9J+lq5ysZBrdsAxWJN4alpvUod1HnbWPIGhQtD8
 +1GzCWED+99AYw+0WIwGgO4nUhs5c6bG5nmVGvAbPc0rvkUqfNaR4jNLdTVzDzPhq5nL
 PP6Xy1LCslqkvCdbzJzNqgFivKDXvnTMYQEO/blLyawhlgO3UQL0/UDZXnyJa0mfq2Gv
 jiNfe3Ebme6K3242WRjpZqvyazeG3A02iGSxrnsI/810iXMIW3EKqFII5nY+Po36bqjL
 keLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCoZykoyobDbd1jPtBgyFKm5VLdwr2d+kSgFzEg1/E9wjXlD0wXxFsagGlkabqf3Kg/MbTxESJn7ImtbYVZyvRWD59kXA=
X-Gm-Message-State: AOJu0Yx981Sx+rMpsVvW+biJbUJwA+1czFlBIoXB4VGPiZFUqMqvmV8+
 ykqr3nHGDqaf45VtPdkFQHfLQsn6q+gcxC25xzUPwaCIBR8bNXAK
X-Google-Smtp-Source: AGHT+IFEg52hUz4nF5Nus8mOIEVWNa3G5za6K5u3QaWDj4luiy+HnkTbhYHX6UspIaERI90INAIevg==
X-Received: by 2002:a17:903:283:b0:1f6:8157:b52f with SMTP id
 d9443c01a7336-1f6a5905e51mr14661155ad.8.1717547939670; 
 Tue, 04 Jun 2024 17:38:59 -0700 (PDT)
Received: from amjad-pc ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323dd731sm91562845ad.144.2024.06.04.17.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 17:38:59 -0700 (PDT)
Date: Wed, 5 Jun 2024 08:38:55 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 0/6] vvfat: Fix write bugs for large files and add
 iotests
Message-ID: <Zl-zn4I-4yj0MLdp@amjad-pc>
References: <cover.1716717181.git.amjadsharafi10@gmail.com>
 <ZloHabJMkRY-paOL@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZloHabJMkRY-paOL@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 31, 2024 at 07:22:49PM +0200, Kevin Wolf wrote:
> Am 26.05.2024 um 11:56 hat Amjad Alsharafi geschrieben:
> > These patches fix some bugs found when modifying files in vvfat.
> > First, there was a bug when writing to the cluster 2 or above of a file, it
> > will copy the cluster before it instead, so, when writing to cluster=2, the
> > content of cluster=1 will be copied into disk instead in its place.
> > 
> > Another issue was modifying the clusters of a file and adding new
> > clusters, this showed 2 issues:
> > - If the new cluster is not immediately after the last cluster, it will
> > cause issues when reading from this file in the future.
> > - Generally, the usage of info.file.offset was incorrect, and the
> > system would crash on abort() when the file is modified and a new
> > cluster was added.
> > 
> > Also, added some iotests for vvfat, covering the this fix and also
> > general behavior such as reading, writing, and creating files on the filesystem.
> > Including tests for reading/writing the first cluster which
> > would pass even before this patch.
> 
> I was wondering how to reproduce the bugs that patches 2 and 3 fix. So I
> tried to run your iotests case, and while it does catch the bug that
> patch 1 fixes, it passes even without the other two fixes.
> 
> Is this expected? If so, can we add more tests that trigger the problems
> the other two patches address?
> 
> Kevin
> 

Thanks for checking, so this bug happens when you have mapping for file,
and the clusters are not contiguous.

For example, a file with clusters `12, 13, 15`, here when trying to
read from cluster 15, it will get the offset in the file by using 
the formula `cluster_size * (15-12)` (`12` is the first cluster).

This is of course is not correct, and will result in error reading the
file from outside the range.

The reason it wasn't clear when you tested it, is that since I'm
modifying `large2.txt`, and its the last file in the disk, when trying
to allocate new clusters, coincidentally, the new clusters are allocated
after the last cluster of that same file, so the issue wasn't triggered.

I'll modify the test to use the other file, so that we can trigger the
issue.

I'll also modify the other suggestions you had in the other patches and
submit a new version.

Amjad


