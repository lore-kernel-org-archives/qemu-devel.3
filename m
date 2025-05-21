Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6C7C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 10:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHh35-0005Ta-Hl; Wed, 21 May 2025 06:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uHh33-0005TM-Pp; Wed, 21 May 2025 06:51:45 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uHh31-0001C7-Ah; Wed, 21 May 2025 06:51:44 -0400
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2320d2a7852so32791635ad.3; 
 Wed, 21 May 2025 03:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747824701; x=1748429501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7u3vq12xPqLYJQwIRDmY+7+d2kzYw2mYVkVHCOH6CFk=;
 b=flTS2gsOjklhLKMJ0Rm7Gj7tJ0UE+J1Bj5vN3RsfdBvh+RHnXykjFze7exULXc0s24
 dmtJqwM80BzdpD689o6Vwu6oyGNwU2XrVzXQDLy6BLnciV87H3w1DjJDMUWUchXe85SZ
 +eS49G+n8oM/lXNn1psK5ZxD4XUD2ge/ut1WIbKXvPykUUB/vRkjFC7zI/MQNu6g3Nd6
 2Rl949jv1DpOh/DRe001K2QizRitLJctKgGzAWoWndTHXKLec7RFH25RnvgAsYT7VYW2
 5YQUjYZ2YMxYSqSFaaznBB2eSWog1rBv5seFvaiOqA7S4DTiqAJMI+L8+o2H9jPn2DYW
 v3qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUElojpG1Jvhgu6U7LZJjDNJiSxkmuaJrslnxuwZ2ad6R47MSUleFyNkt+tdgT+zWcKsK+nFafZOl6@nongnu.org,
 AJvYcCWW0glywAnbLc+4U26ANXKvwYfaifr+R6O9NDXscpjcXLnP9Th2kiaM2/nFHVZ2wMZV/3vv68HZhTp1@nongnu.org
X-Gm-Message-State: AOJu0Ywn27ofgQXdi/RtfVRgTduEbTwKJWO5LwtbjcekYcgEWIMP1qdk
 b+O4PWvtTy/meV1Y1NGAq6Btox9D+GblV2fErCa7xWxEy9nxBJb18qEq5cE4tdm6383rdnDe/yh
 F6DrkYi6zvKMU014ogtw4hJ2OXJ8HJEfCVA==
X-Gm-Gg: ASbGncvQ7p//W59OikhVpGVGNSxrhsHuHhC2jmzrBnRc2wM9d04Y9X0sw4XPpIHBA7Y
 0N0H8nKjb3JiL9DSYAZURR58VyljOUtBE6y40VJDFAcB12LHdRiSjZGoLfHprsR6/LO8RRhT/um
 wmqY7uxyFByH91C6XvtZMfJlnHxrnTiBNi0Zav96kjOA==
X-Google-Smtp-Source: AGHT+IGxE+tmWeNjk45cirtDv18oIYWB7/f3Gw+xHBb8NjxEscy1c51ljT7jiJgztVLADsWDBKqcRpZgsrNFImDLimg=
X-Received: by 2002:a17:902:e808:b0:22f:c19c:810c with SMTP id
 d9443c01a7336-231de3bad0dmr229376635ad.51.1747824701488; Wed, 21 May 2025
 03:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
 <aCysct2L8Bosqy0N@intel.com>
 <abe683f2-e679-4579-b68a-38a11d41e00b@gnu.org> <aC2R4BOR2tsYgEFI@intel.com>
 <CAHFMJ7vsgPtfkpBkjvh_-NqKszEDj5UpWThU3rPjN9N4X5s0tA@mail.gmail.com>
 <CAAjaMXb01Y3qoH56j4GsfJLQMRkA067mHjiWS86cr95akh4ckg@mail.gmail.com>
In-Reply-To: <CAAjaMXb01Y3qoH56j4GsfJLQMRkA067mHjiWS86cr95akh4ckg@mail.gmail.com>
From: Paolo Bonzini <bonzini@gnu.org>
Date: Wed, 21 May 2025 12:51:30 +0200
X-Gm-Features: AX0GCFuf4rW2M-iP9zuSVgao0rp8moxHJ08ytRDBjQIeVKNsV7GUngVqlT3Tu5s
Message-ID: <CAHFMJ7v9a+85OtFCoW4bKYXACGQ_yqR8rKxRbNS9jjELMONdbg@mail.gmail.com>
Subject: Re: Rust in QEMU update, April 2025
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000076438c0635a32664"
Received-SPF: pass client-ip=209.85.214.173;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-pl1-f173.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000076438c0635a32664
Content-Type: text/plain; charset="UTF-8"

Il mer 21 mag 2025, 11:35 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> vm-memory is a very rigid API unfortunately. It's excellent for
> rust-vmm purposes. I presume it's possible to figure out a clever
> solution to satisfy both rust-vmm and QEMU use needs but I'm not sure
> it's worth it. It's really hard to retrofit other projects into
> vm-memory if they don't use rust-vmm crates API design and it might
> make both rust-vmm code and QEMU code more complex. QEMU would depend
> on rust-vmm architectural decisions and vice-versa. The thing I'm
> fearing most is needing to refactor memory APIs in QEMU in the future
> and turn the vm-memory dependency into technical debt.


I agree that changing the memory API for the sake of Rust code is a bad
idea.

That said, I have some hope. vm-memory's GuestAddressSpace was designed for
cloud-hypervisor but with QEMU in mind and I was really happy about it. Of
course it's easy to screw up and miss details elsewhere (like the
difference between FlatRange * and MemoryRegionSection, and consequently
the type of the GuestMemory iterator); I am not even sure what QEMU code
for IOMMUs looked like in 2018. But it might be salvageable if the rust-vmm
guys accept a couple of small API breaks.

Perhaps it's more sensible to not use external dependencies to wrap
> over our APIs but we can surely design our Rust bindings inspired by
> them.
>

It would be nice to have crates like linux-loader or vm-virtio available.
But even then, even if we can fork the basic vm-memory traits, we can get
by with it as long as those handy crates still compile. :)

Paolo

>

--00000000000076438c0635a32664
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 21 mag 2025, 11:35 Manos =
Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org">manos.p=
itsidianakis@linaro.org</a>&gt; ha scritto:</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
vm-memory is a very rigid API unfortunately. It&#39;s excellent for<br>
rust-vmm purposes. I presume it&#39;s possible to figure out a clever<br>
solution to satisfy both rust-vmm and QEMU use needs but I&#39;m not sure<b=
r>
it&#39;s worth it. It&#39;s really hard to retrofit other projects into<br>
vm-memory if they don&#39;t use rust-vmm crates API design and it might<br>
make both rust-vmm code and QEMU code more complex. QEMU would depend<br>
on rust-vmm architectural decisions and vice-versa. The thing I&#39;m<br>
fearing most is needing to refactor memory APIs in QEMU in the future<br>
and turn the vm-memory dependency into technical debt.</blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">I agree that changing the=
 memory API for the sake of Rust code is a bad idea.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">That said, I have some hope. vm-memory&#39;s G=
uestAddressSpace was designed for cloud-hypervisor but with QEMU in mind an=
d I was really happy about it. Of course it&#39;s easy to screw up and miss=
 details elsewhere (like the difference between FlatRange * and MemoryRegio=
nSection, and consequently the type of the GuestMemory iterator); I am not =
even sure what QEMU code for IOMMUs looked like in 2018. But it might be sa=
lvageable if the rust-vmm guys accept a couple of small API breaks.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">Perhaps it&#39;s more sens=
ible to not use external dependencies to wrap<br>
over our APIs but we can surely design our Rust bindings inspired by<br>
them.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">It would be nice to have crates like linux-loader or vm-virtio availab=
le. But even then, even if we can fork the basic vm-memory traits, we can g=
et by with it as long as those handy crates still compile. :)</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000076438c0635a32664--

