Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36647C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 08:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3B7D-0005yU-QZ; Sat, 04 May 2024 04:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B79-0005xr-Vc; Sat, 04 May 2024 04:51:28 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B77-0002hA-Ew; Sat, 04 May 2024 04:51:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f3e3d789cdso409122b3a.1; 
 Sat, 04 May 2024 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714812683; x=1715417483; darn=nongnu.org;
 h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=26pnMCgu4qoatbtMv9SM+aKaRgsIEE1uMCqO/RQlYtA=;
 b=DM9+lRjgbUocT0X1GpD9uzqZMAfQl9Zg6JG9PZkARXLY2/OZ1IN2V7lfup36RosTP6
 pgMxwn5rhiAgcXoXO9pznRKZuv16kDFU0rDnAuGFLKAw/V9pI67VYQcPZbyuvVDhNGk5
 VeTCp0hXZu+gNfShtbZFli0qfSrP1KrLZKMkxQr++3zLLj8nf3OOnAOWVpazsWoLTaif
 Vrb3hg9R2Z/ZHNyT6wiAt3cKclzAW/K1h+0NvOKVH6WuyRCKl5a968aY92iHtimLlUd8
 lDiCWOw6eNLYe1JvbX4r9SMJzB+xN0HH9mfEmUIxWpkq5gT8rWabCiM4tmNlyEwK4Q4o
 I5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714812683; x=1715417483;
 h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=26pnMCgu4qoatbtMv9SM+aKaRgsIEE1uMCqO/RQlYtA=;
 b=tp1mju1IjfjdF8Sxs00Eri7JcJveMo7av722XAB7g+1wNQ4Xqf8x72NzLt0x5kzIsC
 oy1KtoDhkSPflD8ha/ZZ9ywoKgNJNDrOzTm3FvBuJYmTpJn50rmK0/K5AUrPJGxOykOO
 4OR0i89G9nOVvCvftoIzqY1EHMk/jV+OZxS0fcVK79K0cp+P+O0EZ2GlgSHBSXY8mlQY
 9vAmbme5po1fu5/lUUrF5wEjNGE/mgEMzEmlNTNQ6sd8eBQlAPGvkyqlXWYo6ZTGaM6n
 6d5OpX48gbKD0QAMB2uNBeHCZmMXyeq6VsCodK11gm8FtrHtvya/QqT9ndD/9kylC+fn
 u5Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUznmInHp9Lcu+489Y5qvWumuAjxr40l2UoBOfrW+AWpWTXWZoZL81lAFhKxX7+9TTd3Y0ubl2F7d3RKTQUObtRJmAH7N4=
X-Gm-Message-State: AOJu0Yx7CrWool4Jm1YjjKJ2g9E+yvwrRUdjn4NGDUW0UaG8MGuVs9u3
 gihfe05jL7Oq6ZnBO3gvPKFON8tBWW7uvnkmNchDUvjhqhu4BjuBDsc+PCm8
X-Google-Smtp-Source: AGHT+IE1u4OTv8GtVQ+Lsu3o8pctJSfwbZMJtKl1iLbKZeXNBJTFxMchpDODZIv5xYvtoLGWDF1GEg==
X-Received: by 2002:a05:6a00:2411:b0:6ea:b818:f499 with SMTP id
 z17-20020a056a00241100b006eab818f499mr6015379pfh.19.1714812682655; 
 Sat, 04 May 2024 01:51:22 -0700 (PDT)
Received: from amjad-pc ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 fr25-20020a056a00811900b006ecda086db2sm4266032pfb.110.2024.05.04.01.51.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 04 May 2024 01:51:22 -0700 (PDT)
Date: Sat, 4 May 2024 16:51:19 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: "=?utf-8?Q?qemu-devel=40nongnu.org?=" <qemu-devel@nongnu.org>
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?Q?open_list=3Avvfat?= <qemu-block@nongnu.org>
Message-ID: <17ACC95C-375F-47FD-9633-B66BE0C8EDB9@getmailspring.com>
In-Reply-To: <cover.1714811679.git.amjadsharafi10@gmail.com>
References: <cover.1714811679.git.amjadsharafi10@gmail.com>
Subject: Re: [PATCH v2 0/5] vvfat: Fix write bugs for large files and
 add iotests
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="6635f707_a58bbde_3fa7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--6635f707_a58bbde_3fa7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Explaination of the patch list:

These patches fix some bugs found when modifying files in vvfat.
First, there was a bug when writing to the cluster 2 or above of a file, it
will copy the cluster before it instead, so, when writing to cluster=2, the
content of cluster=1 will be copied into disk instead in its place.

Another issue was modifying the clusters of a file and adding new
clusters, this showed 2 issues:
- If the new cluster is not immediately after the last cluster, it will
cause issues when reading from this file in the future.
- Generally, the usage of info.file.offset was incorrect, and the
system would crash on abort() when the file is modified and a new
cluster was added.

Also, added some iotests for vvfat , covering the this fix and also
general behavior such as reading and writing to the first cluster which
would pass even before this patch.

On May 4 2024, at 4:44 pm, Amjad Alsharafi <amjadsharafi10@gmail.com> wrote:
> v2:
> Added iotests for `vvfat` driver along with a simple `fat16` module to run the tests.
>
> v1:
> https://patchew.org/QEMU/20240327201231.31046-1-amjadsharafi10@gmail.com/
> Fix the issue of writing to the middle of the file in vvfat
>
> Amjad Alsharafi (5):
> vvfat: Fix bug in writing to middle of file
> vvfat: Fix usage of `info.file.offset`
> vvfat: Fix reading files with non-continuous clusters
> iotests: Add `vvfat` tests
> iotests: Filter out `vvfat` fmt from failing tests
>
> .gitlab-ci.d/buildtest.yml | 1 +
> block/vvfat.c | 32 +-
> tests/qemu-iotests/001 | 1 +
> tests/qemu-iotests/002 | 1 +
> tests/qemu-iotests/003 | 1 +
> tests/qemu-iotests/005 | 1 +
> tests/qemu-iotests/008 | 1 +
> tests/qemu-iotests/009 | 1 +
> tests/qemu-iotests/010 | 1 +
> tests/qemu-iotests/011 | 1 +
> tests/qemu-iotests/012 | 1 +
> tests/qemu-iotests/021 | 1 +
> tests/qemu-iotests/032 | 1 +
> tests/qemu-iotests/033 | 1 +
> tests/qemu-iotests/052 | 1 +
> tests/qemu-iotests/094 | 1 +
> tests/qemu-iotests/120 | 2 +-
> tests/qemu-iotests/140 | 1 +
> tests/qemu-iotests/145 | 1 +
> tests/qemu-iotests/157 | 1 +
> tests/qemu-iotests/159 | 2 +-
> tests/qemu-iotests/170 | 2 +-
> tests/qemu-iotests/192 | 1 +
> tests/qemu-iotests/197 | 2 +-
> tests/qemu-iotests/208 | 2 +-
> tests/qemu-iotests/215 | 2 +-
> tests/qemu-iotests/236 | 2 +-
> tests/qemu-iotests/251 | 1 +
> tests/qemu-iotests/307 | 2 +-
> tests/qemu-iotests/308 | 2 +-
> tests/qemu-iotests/check | 2 +-
> tests/qemu-iotests/fat16.py | 507 ++++++++++++++++++
> tests/qemu-iotests/meson.build | 3 +-
> .../tests/export-incoming-iothread | 2 +-
> tests/qemu-iotests/tests/fuse-allow-other | 1 +
> .../tests/mirror-ready-cancel-error | 2 +-
> tests/qemu-iotests/tests/regression-vhdx-log | 1 +
> tests/qemu-iotests/tests/vvfat | 400 ++++++++++++++
> tests/qemu-iotests/tests/vvfat.out | 5 +
> 39 files changed, 967 insertions(+), 26 deletions(-)
> create mode 100644 tests/qemu-iotests/fat16.py
> create mode 100755 tests/qemu-iotests/tests/vvfat
> create mode 100755 tests/qemu-iotests/tests/vvfat.out
>
> --
> 2.44.0
>


--6635f707_a58bbde_3fa7
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Explaination of the patch list<span data-emoji-typing=3D=22true=22>:=
</span></div><br><div><span data-emoji-typing=3D=22true=22>These patches =
fix some bugs found when modifying files in vvfat.</span></div><br><div><=
span data-emoji-typing=3D=22true=22>=46irst, there was a bug when writing=
 to the cluster 2</span>&nbsp;or above <span data-emoji-typing=3D=22true=22=
>of a file, it</span></div><div><span data-emoji-typing=3D=22true=22>will=
 copy the cluster before it instead</span>, so, when writing to cluster=3D=
2, the</div><div>content of cluster=3D1 will be copied into disk instead =
in its place.</div><br><div><span data-emoji-typing=3D=22true=22>Another =
issue was modifying the clusters of a file and adding new</span></div><di=
v><span data-emoji-typing=3D=22true=22>clusters, this showed 2 issues:</s=
pan></div><div><span data-emoji-typing=3D=22true=22>- If the new cluster =
is not immediately after the last cluster, it will</span></div><div><span=
 data-emoji-typing=3D=22true=22>&nbsp; cause issues when reading from thi=
s file in the future.</span></div><div><span data-emoji-typing=3D=22true=22=
>- Generally, the usage of info.file.offset was incorrect, and the</span>=
</div><div><span data-emoji-typing=3D=22true=22>&nbsp; system would crash=
 on abort() when the file is modified and a new</span></div><div><span da=
ta-emoji-typing=3D=22true=22>&nbsp; cluster was added.</span></div><br><d=
iv>Also, added some iotests for <strong>vvfat</strong>&nbsp;, covering th=
e this fix and also</div><div>general behavior such as reading and writin=
g to the first cluster which</div><div>would pass even before this patch.=
</div><br><br><div class=3D=22gmail=5Fquote=5Fattribution=22>On May 4 202=
4, at 4:44 pm, Amjad Alsharafi &lt;amjadsharafi10=40gmail.com&gt; wrote:<=
/div><blockquote><div><div>v2:</div><div>Added iotests for =60vvfat=60 dr=
iver along with a simple =60fat16=60 module to run the tests.</div><br><d=
iv>v1:</div><div>https://patchew.org/QEMU/20240327201231.31046-1-amjadsha=
rafi10=40gmail.com/</div><div>=46ix the issue of writing to the middle of=
 the file in vvfat</div><br><div>Amjad Alsharafi (5):</div><div>vvfat: =46=
ix bug in writing to middle of file</div><div>vvfat: =46ix usage of =60in=
fo.file.offset=60</div><div>vvfat: =46ix reading files with non-continuou=
s clusters</div><div>iotests: Add =60vvfat=60 tests</div><div>iotests: =46=
ilter out =60vvfat=60 fmt from failing tests</div><br><div>.gitlab-ci.d/b=
uildtest.yml =7C 1 +</div><div>block/vvfat.c =7C 32 +-</div><div>tests/qe=
mu-iotests/001 =7C 1 +</div><div>tests/qemu-iotests/002 =7C 1 +</div><div=
>tests/qemu-iotests/003 =7C 1 +</div><div>tests/qemu-iotests/005 =7C 1 +<=
/div><div>tests/qemu-iotests/008 =7C 1 +</div><div>tests/qemu-iotests/009=
 =7C 1 +</div><div>tests/qemu-iotests/010 =7C 1 +</div><div>tests/qemu-io=
tests/011 =7C 1 +</div><div>tests/qemu-iotests/012 =7C 1 +</div><div>test=
s/qemu-iotests/021 =7C 1 +</div><div>tests/qemu-iotests/032 =7C 1 +</div>=
<div>tests/qemu-iotests/033 =7C 1 +</div><div>tests/qemu-iotests/052 =7C =
1 +</div><div>tests/qemu-iotests/094 =7C 1 +</div><div>tests/qemu-iotests=
/120 =7C 2 +-</div><div>tests/qemu-iotests/140 =7C 1 +</div><div>tests/qe=
mu-iotests/145 =7C 1 +</div><div>tests/qemu-iotests/157 =7C 1 +</div><div=
>tests/qemu-iotests/159 =7C 2 +-</div><div>tests/qemu-iotests/170 =7C 2 +=
-</div><div>tests/qemu-iotests/192 =7C 1 +</div><div>tests/qemu-iotests/1=
97 =7C 2 +-</div><div>tests/qemu-iotests/208 =7C 2 +-</div><div>tests/qem=
u-iotests/215 =7C 2 +-</div><div>tests/qemu-iotests/236 =7C 2 +-</div><di=
v>tests/qemu-iotests/251 =7C 1 +</div><div>tests/qemu-iotests/307 =7C 2 +=
-</div><div>tests/qemu-iotests/308 =7C 2 +-</div><div>tests/qemu-iotests/=
check =7C 2 +-</div><div>tests/qemu-iotests/fat16.py =7C 507 ++++++++++++=
++++++</div><div>tests/qemu-iotests/meson.build =7C 3 +-</div><div>.../te=
sts/export-incoming-iothread =7C 2 +-</div><div>tests/qemu-iotests/tests/=
fuse-allow-other =7C 1 +</div><div>.../tests/mirror-ready-cancel-error =7C=
 2 +-</div><div>tests/qemu-iotests/tests/regression-vhdx-log =7C 1 +</div=
><div>tests/qemu-iotests/tests/vvfat =7C 400 ++++++++++++++</div><div>tes=
ts/qemu-iotests/tests/vvfat.out =7C 5 +</div><div>39 files changed, 967 i=
nsertions(+), 26 deletions(-)</div><div>create mode 100644 tests/qemu-iot=
ests/fat16.py</div><div>create mode 100755 tests/qemu-iotests/tests/vvfat=
</div><div>create mode 100755 tests/qemu-iotests/tests/vvfat.out</div><br=
><div>--</div><div>2.44.0</div></div></blockquote>
--6635f707_a58bbde_3fa7--


