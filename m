Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A1EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 09:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd5Fk-0001r1-Ad; Sun, 11 Aug 2024 05:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sd5Fi-0001pg-D3; Sun, 11 Aug 2024 05:52:42 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sd5Fg-0006iK-BB; Sun, 11 Aug 2024 05:52:42 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-26875acdf72so2245698fac.0; 
 Sun, 11 Aug 2024 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723369958; x=1723974758; darn=nongnu.org;
 h=content-disposition:content-transfer-encoding:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KqW+uQzq1hNCouXXGRUXaHAnlS+KjZCB8oi/OKQVk4=;
 b=GanVpYwx7YQTqrx7qLecTd+Z+1yIDDkr3vQ9pbH1P2mV98OaSgbqfl9a8iNu74bqsC
 xQotPc+W1TtznsoyPNUsFq9vmUs7nlFwLw4N8OY+rbX7caTmBkjqNVNz8jhOGTkG0Ef4
 0lJUc66TE6+2R6iNkUfRbZ2gDeKLLDEpebvyYApD1wJH4cnXCTsr3MjmsvNQKeTx7ICX
 Y09J1iZS94VS46hPr4IpZg1qPskcyvSkQXpM7bLFT3iKSaZJ8qOxND61rn8Yml/nze+I
 zu7qA+NOBB7FKNDi0fJadgRGhAQJgBy3VxI9N5KrMDdv17F4O2GgE/qrrPBON0Ljq06Z
 rgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723369958; x=1723974758;
 h=content-disposition:content-transfer-encoding:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1KqW+uQzq1hNCouXXGRUXaHAnlS+KjZCB8oi/OKQVk4=;
 b=PMITUC4LCxEa3EvmREjj7TA3tkPaRp9715DhGPgCGNOf2oGWiXa64Wp5LzdiRZZGuH
 AQ/j1/7dxkt/ptNkwUPYKHTeun/KKaw17lBahylbwdIv6cNZ3rEI4Yzf3yD7wZbTsT7j
 iNA0z0dE+R3AQyPCunf+V7TDKiCuPS39A8iC7Sc865ab3u/kStlQjpkDBGDl6pdTMu8J
 /D9LJVlsdEMdRpjlpDU8HfB6uL+DbUsXWsiaG3BPummcSGliYHoAr33NT3mAMBrkBVSQ
 W70m7y70557SXCHWgIVU5VVQO8pNWPFvT/eZgXVyH0dp6v/EJ0EEBBsAh1ENooT6vDU0
 EZQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW261MXnfKgshmLqRLZFdAeqqbgrlqrAFaCpwTZiACpV04BIDxD7TTwGTOioRD+kdzD6RKunKtPt3QL@nongnu.org,
 AJvYcCXB7AYa35/5K+5+kl91kmsg9Mt3pvY0H4YOBLP/Z+sApyxHaJXz4DYsvyrRlZqk9K2ouMxRbb4c+utjNII=@nongnu.org
X-Gm-Message-State: AOJu0Yw40SFQbKynYBs/tXJqF0rpKkud7leUroMl3vAXrQkAUElHMpi6
 Mf7e9URgQOQuw+syg4RQSNoRi4h1qJP3aESJOq5gMz0FZGOkDnRk
X-Google-Smtp-Source: AGHT+IEuMdQl9YE8y6SIse64HM7fVpV+mh+e7lAiPPmu0q0z5BPg3y0P+ThEva9dcYCYSdgh8TJNmA==
X-Received: by 2002:a05:6870:d8d2:b0:260:e678:b660 with SMTP id
 586e51a60fabf-26c63043149mr6499009fac.51.1723369957585; 
 Sun, 11 Aug 2024 02:52:37 -0700 (PDT)
Received: from amjad-pc ([192.228.221.130]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c3dbea1f84sm2352119a12.82.2024.08.11.02.52.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Aug 2024 02:52:37 -0700 (PDT)
Date: Sun, 11 Aug 2024 17:52:33 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "=?utf-8?Q?qemu-devel=40nongnu.org?=" <qemu-devel@nongnu.org>, Hanna
 Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?Q?open_list=3Avvfat?= <qemu-block@nongnu.org>, qemu-stable
 <qemu-stable@nongnu.org>
Message-ID: <840B31DB-19FC-44B1-A94B-7CFC19C14A32@getmailspring.com>
In-Reply-To: <44aaeed5-95d3-46dc-b04c-ae4cfab5b029@tls.msk.ru>
References: <44aaeed5-95d3-46dc-b04c-ae4cfab5b029@tls.msk.ru>
Subject: Re: [PATCH v5 0/5] vvfat: Fix write bugs for large files and
 add iotests
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-oa1-x32.google.com
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



On Aug 11 2024, at 3:51 pm, Michael Tokarev <mjt@tls.msk.ru> wrote:

> 12.06.2024 15:43, Amjad Alsharafi wrote:
>> These patches fix some bugs found when modifying files in vvfat.
>> First, there was a bug when writing to the cluster 2 or above of a
>> file, it
>> will copy the cluster before it instead, so, when writing to
>> cluster=2, the
>> content of cluster=1 will be copied into disk instead in its place.
>> 
>> Another issue was modifying the clusters of a file and adding new
>> clusters, this showed 2 issues:
>> - If the new cluster is not immediately after the last cluster, it will
>> cause issues when reading from this file in the future.
>> - Generally, the usage of info.file.offset was incorrect, and the
>> system would crash on abort() when the file is modified and a new
>> cluster was added.
>> 
>> Also, added some iotests for vvfat, covering the this fix and also
>> general behavior such as reading, writing, and creating files on the filesystem.
>> Including tests for reading/writing the first cluster which
>> would pass even before this patch.
> ...
>> Amjad Alsharafi (5):
>>    vvfat: Fix bug in writing to middle of file
>>    vvfat: Fix usage of `info.file.offset`
>>    vvfat: Fix wrong checks for cluster mappings invariant
>>    vvfat: Fix reading files with non-continuous clusters
>>    iotests: Add `vvfat` tests
> 
> Actually, maybe the whole series is a good candidate for -stable, not
> just the
> first fix.  What do you think?
> 
> Thanks,
> 
> /mjt

Hello Michael,

This actually has been reviewed and approved (last version was v6 here: https://patchew.org/QEMU/cover.1721470238.git.amjadsharafi10@gmail.com/)

It has been merged into upstream here: https://gitlab.com/qemu-project/qemu/-/commit/6d00c6f982562222adbd0613966285792125abe5

Or do you perhaps mean something else by `-stable`?

Thanks,
Amjad

> 
> -- 
> GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
> New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD
> 3D98 ECDF 2C8E
> Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C
> E0A0 8044 65C5
> Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt
> 
> 

