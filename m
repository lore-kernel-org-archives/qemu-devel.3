Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6D5C87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 14:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uivr0-0001if-7W; Mon, 04 Aug 2025 10:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uiuu0-0006JN-Be
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uiuty-0002aK-L2
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754312812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8qOVKdP0WU7nbDCOR5hFiZKMm3eL5U/oVK0sPEPhBdQ=;
 b=WhINHp58L6B0ENjLXLkulhyXWpYr/GS1vuM67VAgHtyiVN1DW/a/ub0G1nC/u1CPvl/3yi
 vfON94kISV2ZCqSMbEV+zZiqBzX21kkugjg9LON/Hy4Am7sGJhpSLo5LRZ6LeBTEybHNbM
 r8xq/qIhaDYcMTHjWMQsRH/MPpX0a18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-3BiHxxZkONGBjBcou9sUYw-1; Mon, 04 Aug 2025 09:06:50 -0400
X-MC-Unique: 3BiHxxZkONGBjBcou9sUYw-1
X-Mimecast-MFC-AGG-ID: 3BiHxxZkONGBjBcou9sUYw_1754312810
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-459de0d5fb1so3778745e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754312810; x=1754917610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8qOVKdP0WU7nbDCOR5hFiZKMm3eL5U/oVK0sPEPhBdQ=;
 b=i2NmUFcsFiuq5D9ik28Qv2BFSsxRc7vlHkV5+37fPf17Flojp6gxLHQySbLTg53BTb
 sw2yKmMK/WIXSNh8ZbVlBcqWXE69MAJ2m98UcgCVJlfVUruxSCjnCIVl/KWled+eyzPt
 zG/aUzvWHd+0jYFrhRftlpZVjZwS2OkdEa9eAHCWH4tO2TqCJCmCS7apst5LNT7aQaow
 y6sV84O/jPCB3hEIQBVj7LbcQ3Xzg5pxGtuYF3gs4APQcSTwM/aD4FQjJALoDegmFbQ3
 Y2vL7rV+rYPTa/SK0epsq7uSoTtDHKmHoK+VTpBFU2l5eKWOHL8cwLbPr2+t1xY9XIZK
 PKsw==
X-Gm-Message-State: AOJu0Yy17+C25a0wov9LvhsoG2Wfx91teiPx5MD0CdxmXZHLVahM5nPL
 cIATrDVy0Ve2xvZgLNWL0b4fM6hV2O9JY4Hs2jdt4cn/Djwgzjj+m7wlC8TBzOMSZhStctzh7qP
 M3xuJnyot+kdG25BHU4jQxDC6/sIvh0RabUSqBlYHbFPzp9x8WE619qyjMJ9RW/cmWKby1mzhup
 Evab4mMSWICu+K+liqGchmuOSYBwNy/Kg=
X-Gm-Gg: ASbGncteQrYMixk3btJVkoqSxSNGYr/RQvdbDdVgE35kI3dmdEyvteoCJ7Qke8F/wbf
 2HAR2WxoR1rO+9nAYzHzNi1X/XX4lqbQyhXqo++gYlTMl0rymATiwSACc4XOM4YQPvZ1EFiuUJx
 9DDhgwAX91b8X616Zf62ql
X-Received: by 2002:a05:600c:3b08:b0:459:dde3:1a56 with SMTP id
 5b1f17b1804b1-459dde31ea1mr13015495e9.28.1754312809529; 
 Mon, 04 Aug 2025 06:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7or/ul/1HirebCTMOerrXJwuQ0ZXrhhjELH+9/xSox7yTU+ZWuNhpMvYnmT8gClAj43NK+dJShPA26mCozwI=
X-Received: by 2002:a05:600c:3b08:b0:459:dde3:1a56 with SMTP id
 5b1f17b1804b1-459dde31ea1mr13015145e9.28.1754312809062; Mon, 04 Aug 2025
 06:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1754060086.git.mkletzan@redhat.com>
 <ad68bd5bdf4148770e3750fca4f14d0ae794538d.1754060086.git.mkletzan@redhat.com>
 <CABgObfYBVF3aCOBtX-eQcm4M-WNAHxbMcjsUKiY3rLkinGe1qA@mail.gmail.com>
 <aJB1oeH2eTIeeJne@wheatley.k8r.cz>
 <CABgObfaivWp1v55KHjBK1Ba8fDgo3Lr+wF5HkHrvOz62Z_gLoQ@mail.gmail.com>
 <aJChxtjDENrCEk3x@wheatley.k8r.cz>
In-Reply-To: <aJChxtjDENrCEk3x@wheatley.k8r.cz>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 4 Aug 2025 15:06:36 +0200
X-Gm-Features: Ac12FXzUl5Fdc4Brn2zspuzViFv-HQT9E__ubvbe1V4TWeryOUcLn7j5M7ERzu0
Message-ID: <CABgObfYQmpXukS051YAq9NRPGvVWgarp8TTtz2mty988PO=w_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add antoher variant for impl_vmstate_struct!
 macro
To: Martin Kletzander <mkletzan@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cf335c063b89c7fc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000cf335c063b89c7fc
Content-Type: text/plain; charset="UTF-8"

Il lun 4 ago 2025, 14:04 Martin Kletzander <mkletzan@redhat.com> ha scritto:

> But that's nowhere to be found, including git log --walk-reflog and
> manually searching various history trees.  And I doubted that you
> rewrote the history of the rust-next branch


Yes, rust-next has its history rewritten.

By the way the bug was probably related to some compiler changes, because I
am almost certain it worked a couple months ago.

Paolo

--000000000000cf335c063b89c7fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 4 ago 2025, 14:04 Martin =
Kletzander &lt;<a href=3D"mailto:mkletzan@redhat.com">mkletzan@redhat.com</=
a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">But that&#39;s nowhere to be found, including git log --walk-reflog and<=
br>
manually searching various history trees.=C2=A0 And I doubted that you<br>
rewrote the history of the rust-next branch</blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Yes, rust-next has its history rewri=
tten.</div><div dir=3D"auto"><br></div><div dir=3D"auto">By the way the bug=
 was probably related to some compiler changes, because I am almost certain=
 it worked a couple months ago.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div></div>

--000000000000cf335c063b89c7fc--


