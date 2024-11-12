Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89564D32D9A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 12:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAq4Z-0006TP-3i; Tue, 12 Nov 2024 07:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tAq4X-0006T8-3X
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:32:41 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tAq4V-0007ew-IF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:32:40 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-718186b5c4eso2602230a34.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 04:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731414756; x=1732019556; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LHlWNfRdHCp3hgJ3wrSXRZI3nFdQIqvtC6PokKgfh58=;
 b=GB31gKiVbtLKE6c2p1FE5aj1/CEmKTStX/OzTKE+lGdPCAMKMs2vbfjYJUAQOZA2Am
 2GAM0NQN5JdJcx1u4i0shXC8Gqk3JkRi4JgskOE2jDpxQUzzzWNyD+m0VckOdZUJAl53
 go3DelKxf0hkZtLM9SzQ7IZtEPxAyU9wtaFOgv9BBQ/QLLudd41gKDwVulmW0VQFMZWs
 9zFd/Ft2ad4kBK1JeS4L2hUZmdVK3wLgOyDk7HzQbSJcrdl90AvnzBXYOQ9qVYuEjI5j
 VwYgs5OqFMVhqVUpmVeCEIPNCI3xq2pGquh4K+GgJYe5fL/5Jn6UykesrI3XDpsLeleY
 arbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731414756; x=1732019556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LHlWNfRdHCp3hgJ3wrSXRZI3nFdQIqvtC6PokKgfh58=;
 b=NzgSulj43G8W46RidLukmHJB3GRA0UJxjT3nAGOL5Ndqvp7728zdmB3KZ+rppEjr5T
 gfLyQDxcyLniVcIC+FUILquiZtxrj+YxaTLu/X+oZFCnBZwIQyLWIVh2vsuNieQpq5sK
 8iEu8mFnZL1raitO8UxxhLKq82wsA6qB7AEJgjMDXCz2gX/gBr5G8P8o2MIV8k/0yaOa
 YaPn0mdI0eHZGcKfm4Ndvmu71nrty2rnenKQyLfL9lg+Xhd5ccMlYEBd2fC3xISmORxt
 lE2e1FNFxkzYS+RZroLbFx58jacAk12LjL24WYq+vpASToYYTlCwlfDiPEGWg8ljoYJJ
 UhSw==
X-Gm-Message-State: AOJu0YygT82Q0lK1RGnxaGks0M0jKmYsWWDiog1irAlX6Yd7ckNlDnL9
 OMUgtj9HTP58rbWCZuPhLxpbTN0VMhhCSXTEII1MqkxKvD1rSeqDypsCSPbEgo6togqHZtg7ON4
 caGwAStRz1KHlZZYZ1hq18clVR5s=
X-Google-Smtp-Source: AGHT+IHAmqiKbSa2jgyPQveqAka+9jJzmi2EwT9o+WvTtust0YCT5YGlCRPbJlp+6by5OOvdfcIj7axjDo2afvDgcl0=
X-Received: by 2002:a05:6359:2185:b0:1c3:15c3:739 with SMTP id
 e5c5f4694b2df-1c641ec4474mr620061055d.11.1731414756094; Tue, 12 Nov 2024
 04:32:36 -0800 (PST)
MIME-Version: 1.0
References: <20241109123208.24281-1-dorjoychy111@gmail.com>
 <44fbe3d8-509c-47ad-b764-5c8016980bfe@amazon.com>
In-Reply-To: <44fbe3d8-509c-47ad-b764-5c8016980bfe@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 12 Nov 2024 18:32:22 +0600
Message-ID: <CAFfO_h5LHsgng5itQTEO30SUT_jn02Pdi-0uYvyZCgRPJfcueA@mail.gmail.com>
Subject: Re: [PATCH] device/virtio-nsm: Support string data for extendPCR
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007efbb10626b6691a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ot1-x32c.google.com
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

--0000000000007efbb10626b6691a
Content-Type: text/plain; charset="UTF-8"

Hey Alex,


On Tue, Nov 12, 2024, 6:14 PM Alexander Graf <graf@amazon.com> wrote:

> Hey Dorjoy,
>
> Thanks a lot for the patch! Would you mind to send to the ML so it can
> go through the normal review + apply cycle? :)
>
> Same comment for the other patches.
>


I don't understand. I sent them to the mailing list too, no? I see the cc's
on the patches.

Regards,
Dorjoy

>

--0000000000007efbb10626b6691a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hey Alex,<div dir=3D"auto"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 12, 2024=
, 6:14 PM Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com">graf@amazon=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hey Dorjoy,<br>
<br>
Thanks a lot for the patch! Would you mind to send to the ML so it can <br>
go through the normal review + apply cycle? :)<br>
<br>
Same comment for the other patches.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">I don&#39;t =
understand. I sent them to the mailing list too, no? I see the cc&#39;s on =
the patches.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,</d=
iv><div dir=3D"auto">Dorjoy</div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"></blockquote></div></div></div>

--0000000000007efbb10626b6691a--

