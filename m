Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1790EC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 15:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSI81-000490-Eu; Fri, 12 Jul 2024 11:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSI80-00048T-4R
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:24:08 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSI7y-0005w5-EL
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:24:07 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-595850e7e11so2683093a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720797844; x=1721402644; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vrsslXj3svCm3f3n6wzrsgoaLYrkL1il+caAw2x9IMc=;
 b=muGMde8593TbX8Q+xiipgtp1768AMSbNvhmAhBKQW5eUlIOyP7G+uriEko3HQq0skC
 AjTex7EgjQIPfjDTy4b4n3wkmTvFS1qsKPagwSnTqvDvGHxG/rxTGuCdF74kNe442H5Z
 nxENBiwQO0LRGpAplMaDk10rmXP/6zRJjHhbRQS/954NUzsFw2fEbTQcwBRz31a2kJfr
 /50BL/XxfH9TNyJzRp/XnAvn6J36M6KDvC8m57OWgrmQf5cc3g36wR8qBtO/9A1IS11/
 NdwI8XHA1kNRaBc5zBooes0NEsMyxqLYQLo8+x5FQdktQk6CGAdpU8KdNYPYOAfmvE4C
 ahsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720797844; x=1721402644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vrsslXj3svCm3f3n6wzrsgoaLYrkL1il+caAw2x9IMc=;
 b=rC3Wi3eF/hTiW+v0pwT6r3UQwpNvpykFdYQC6jkLKUAqiIazeA6UPeq50HkWkFq0tY
 zB4AinXN+ZS++4F0a0ya6yrs1acGDM8/6MY2IM0bbo48vy8OYkMMbEBhwz1MWhCNjWyN
 emKhxTCI1W+m51enxUJp+K706FCcSibWaD6z83m65nASDk8QtaDw3vGCE+xmNSFS/yEJ
 vNovNhijr6fSWiG+TnIqM6uYE23vsylN2cjJExkmRJ+XOUwxxvqz6R64JYEme7wEhsj3
 f2vJDomotn1kp2b5sjswDI7noK8RGsa/gcBXu8Sci9fk111qhfenKsF6Xvv5JnH3cl93
 zTHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSJ8yfMPRnjNL/LlE41q3JTwC6Io6ov83DZ2+K5aslK4PmnN+CR+ooOt+Lb64pBX6jvKMD/pIchCU+Nh66kZOpMsNwOq0=
X-Gm-Message-State: AOJu0Yx6NqpWvKDoGkjXKcaDDL++q0bkSjODPRfQ/oZ9ZUc2SKyihSFb
 DONm9CqciFgT3BUYbtlOr7w90BuvOrZA+wgOElX9DhDBpURdt0p4Crw9AaY8eq/YoibM5LKpMVO
 pZiRct6bkshNDqhZvc3N9tCCyTOn/eBW//1/xow==
X-Google-Smtp-Source: AGHT+IF+RbpEXHx9enMlZxZQk0NVo+G4a5LZg6BVBYkWi62nJ/ML6IrOhnJzlvTHjOtUstmy4lxymashXdBWh02v7Tg=
X-Received: by 2002:aa7:d1cd:0:b0:58f:4420:8126 with SMTP id
 4fb4d7f45d1cf-594ba59f937mr6998201a12.20.1720797844134; Fri, 12 Jul 2024
 08:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1720046570.git.mst@redhat.com>
 <5ab04420c3de11ae4a573b08b53584a2a0c5dd00.1720046570.git.mst@redhat.com>
 <CAFEAcA9Qvbz=S_-mEeeqgRdBXgxW+d3zrQxNZrcxg9S9G_UZQA@mail.gmail.com>
 <7xvllk2k3n4egbor4u32e6hmtgna6iedjpb3oxxpfk4qzpdcux@dwgysmq3ghx3>
In-Reply-To: <7xvllk2k3n4egbor4u32e6hmtgna6iedjpb3oxxpfk4qzpdcux@dwgysmq3ghx3>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2024 16:23:52 +0100
Message-ID: <CAFEAcA8OH=OsV4Qtf15mH5bXDaBAMZw2xCYz5hKMEVJsyUo9iQ@mail.gmail.com>
Subject: Re: [PULL v3 52/85] contrib/vhost-user-*: use QEMU bswap helper
 functions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 12 Jul 2024 at 16:18, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Jul 12, 2024 at 03:24:47PM GMT, Peter Maydell wrote:
> >On Wed, 3 Jul 2024 at 23:48, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>      #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
> >>      VubDev *vdev_blk = req->vdev_blk;
> >>      desc = buf;
> >> -    uint64_t range[2] = { le64toh(desc->sector) << 9,
> >> -                          le32toh(desc->num_sectors) << 9 };
> >> +    uint64_t range[2] = { le64_to_cpu(desc->sector) << 9,
> >> +                          le32_to_cpu(desc->num_sectors) << 9 };
> >
> >Hi; Coverity points out that this does a 32-bit shift, not a
> >64-bit one, so it could unintentionally chop the high bits off
> >if desc->num_sectors is big enough (CID 1549454).
> >We could fix this by making it
> >    (uint64_t)le32_to_cpu(desc->num_sectors) << 9
> >I think.
>
> Yep, I think so! I'll send a patch.
>
> >
> >(It looks like the issue was already there before, so
>
> Yes, it is pre-existing to this patch, introduced from the beginning
> with commit caa1ee4313 ("vhost-user-blk: add discard/write zeroes
> features support")
>
> >Coverity has just noticed it because of the code change here.)
>
> Ah, I thought it ran on all the code, not just the changes.

It does run on all the code, but if the code changes enough
that can cause it to close out the old issue on the old code
and create a new issue in the system for the new code (which I
then notice because I look at newly-found things to triage them).
So things like refactorings and moving code around can cause
issues to show up.

The other reason this might have shown up now is that they seem
to have added a new check type which flags up a lot of "possible
overflow" errors, so there's a huge pile of new issues for old
code that I'm gradually going through to see which are false
positives and which we should look at.

-- PMM

