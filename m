Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D3FCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvb8-0001CO-UZ; Mon, 17 Nov 2025 04:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKvb6-0001C1-1z
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:32:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKvb4-0005Av-9Y
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:32:31 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so27265845e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763371948; x=1763976748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHLiE4m5Kzbx3xojOuk4FzUzwOfDCLTDyu46zeJDevI=;
 b=Y8pRTfEIAGYNgaK3mMhpZaGC1m3Z6kfaQH48L4y+xUYc6DmHO4gRV7sSg6BCyihBEz
 b3KnuJHBpK6l7gUYGvrnjcWPJ7x4J9VvPapLjLq7N89Jm6TKmQzy5qD1yXhyVrG75jXV
 dwBf+wiZAccTH+lDQyJW1rVTZwSfonpwEP0Ta/JiLcXlbTqq+1w4fS9YPbUwTb43koJ9
 zggGoDF6hNS08qQZYLJZDLc6mFgNHoklipVldNOethuxUAnsCYYgoGpoUW//lcsYpsJC
 cR81IMgL7gqQJIH80dDluyKeolS5ZxmB9CVKNvqwlkoA5YblIdfvS1Hs1GPrS+8wRwqz
 Wqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763371948; x=1763976748;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MHLiE4m5Kzbx3xojOuk4FzUzwOfDCLTDyu46zeJDevI=;
 b=uSzicSFy+MUYbx2Y2ZTNGwfU5zGSnodzYjc+B5TmG5DtTkiW04TILw8iuHbYDs/ykV
 k8SiLKp4utf54NzWow8SKFg9gr4VOfz39HPe3WXtdeXWYbzzo8btr4buGIyUW5XUoKDJ
 gtaekpS8wUn9h8JA1OwcfcU/rYujiyFZit1X79TXe3ytoEbhF9tFn95ikdb3Rz3rGWOs
 u6eCEOdqBSnDMf3Og8qll7h6orUUxqlFAbQvG+3jPpgzd2Ss1v5Cme5pgEE8EE9mtlFk
 Or41koliZVt/ib3c84SdwVOdKRiSblZ1njsuY+A1LuWfRP6NDIUrKXTjcWz/fT5T7H1F
 idMA==
X-Gm-Message-State: AOJu0YwkhF9/izUTX9xpqV9XqJecjsX0uYAKGRmau/GW49WpvKdbJ92C
 6gTZ87Q69y45ZfXjCjzwv1W0IyRphF1xyqXoFbr0/FgCm82S6P0it4GqG6F7hfrinwg=
X-Gm-Gg: ASbGnculxq9fnSTGL2Hf/Oe3CDS1cV/BP5aRGed32BmHZJ9XwZz3/nubk5zKjHLii6Q
 xCvYdbtSOL8wkyiF2WX2oOHQi2OumE5lZAGGSuPWQUahnRPPGACb9LeoWRqL+H7o99KGt5P7l9y
 PQ4x4r9wEqbwzxuh/WfjywrmQm/4rIWoaUs/XbDGOrmldFM30AW2DcHIS/rOSToCV+5CaShK1wB
 7r9rb7Xw+82xao/RoLD9bIcAvURRXbFK3z0fM2NhHz2URIHH73ORDssj5UvIOtcWC5E/JJvp2wQ
 581vAlCE/89+kVm/o8NkqZMlI9lNHVcHl5Hb5jrlEW8KiCJiCShG8mbvnrxCYWaioeR9iozIwru
 xUSZ/kj2Zia1ZvjYmpcAACZdQcGLC91jMQiqTWFbD/ZZ2fqOVcV+N11hJjAy3DKgNzNBa+sIKYG
 Nq9qaxiBbhb80=
X-Google-Smtp-Source: AGHT+IGtHNLnhvpuHx4c5gdJai5WboKu9W2aGQ74+sdLLijcu5jnWr/+dUZ2lvglMlIteRw/ZO+dZQ==
X-Received: by 2002:a05:600c:5598:b0:477:a71c:d200 with SMTP id
 5b1f17b1804b1-477a71cd913mr4892215e9.11.1763371948051; 
 Mon, 17 Nov 2025 01:32:28 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae16sm25375058f8f.3.2025.11.17.01.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 01:32:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 786105F804;
 Mon, 17 Nov 2025 09:32:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  David Hildenbrand <david@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  Peter Xu <peterx@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/8] virtio-gpu/next - misc fixes and MR handling
In-Reply-To: <b3d94838-8484-457e-ada4-8ed3c5b38f8a@tls.msk.ru> (Michael
 Tokarev's message of "Mon, 17 Nov 2025 11:47:29 +0300")
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
 <b3d94838-8484-457e-ada4-8ed3c5b38f8a@tls.msk.ru>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 17 Nov 2025 09:32:26 +0000
Message-ID: <874iqtm2c5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> Hi!
>
> 2 changes from this series has been applied to the master branch:
>
>  9f714c4b20 hw/display: add blob map/unmap trace events
>  0c6d6d79a5 ui/gtk-gl-area: Remove extra draw call in refresh
>
> but the rest weren't.  And it looks like some are worth to be
> considered at least.
>
> Alex, maybe you can refresh the series and re-send?
> We're entering feature freeze stage with 10.2..

There were problems with the other patches leading to leaks in
MemoryRegions. Akihiko has been looking at alternatives patches to
re-factor MemoryRegion handling and also investigating the sub-optimal
RCU behaviour that causes the test case (patch 8) to lock up on the
current master.

Longer term I wonder if there is a better backend we can use that avoids
the need for the complex blob/MemoryRegion dance we currently do between
threads?

>
> Thanks,
>
> /mjt
>
> On 10/14/25 14:12, Alex Benn=C3=A9e wrote:
>> I still have a number of patches that addressed a lock-up but were
>> never merged due to objections. However there is a bunch of discussion
>> around re-factoring the MemoryRegion code so I'm re-posting with an
>> additional functional test which demonstrates the lock-up is fixed.
>> Whatever the final solution for more cleanly handling the binding
>> between MemoryRegions and blobs it will at least need to pass the
>> test.
>> Blob memory issues aside I'll send a PR next week to merge the
>> per-head and ui/gtk-gl-area changes.
>> Discuss,
>> Alex.
>> Alex Benn=C3=A9e (4):
>>    system/memory: add memory_region_finalize tracepoint
>>    hw/display: add blob map/unmap trace events
>>    hw/display: re-arrange memory region tracking
>>    tests/functional: add GPU blob allocation test
>> Andrew Keesler (1):
>>    Support per-head resolutions with virtio-gpu
>> Dongwon Kim (1):
>>    ui/gtk-gl-area: Remove extra draw call in refresh
>> Manos Pitsidianakis (2):
>>    virtio-gpu: refactor async blob unmapping
>>    virtio-gpu: fix hang under TCG when unmapping blob
>>   qapi/virtio.json                          | 10 +++-
>>   include/system/memory.h                   |  1 +
>>   hw/display/virtio-gpu-base.c              | 10 ++++
>>   hw/display/virtio-gpu-virgl.c             | 62 +++++++++++--------
>>   system/memory.c                           |  5 ++
>>   ui/gtk-gl-area.c                          |  1 -
>>   hw/display/trace-events                   |  2 +
>>   system/trace-events                       |  1 +
>>   tests/functional/aarch64/meson.build      |  1 +
>>   tests/functional/aarch64/test_gpu_blob.py | 73 +++++++++++++++++++++++
>>   10 files changed, 138 insertions(+), 28 deletions(-)
>>   create mode 100755 tests/functional/aarch64/test_gpu_blob.py
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

