Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA85C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfup-0007kM-Kr; Mon, 10 Mar 2025 12:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.milosevic@9elements.com>)
 id 1trfum-0007jz-RS
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:23:41 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <david.milosevic@9elements.com>)
 id 1trfui-0001wG-SU
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:23:39 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223959039f4so88874505ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1741623812; x=1742228612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hTbOaGZrrF4NiuEL8VQfK3c6ke2rWoltj4cL0ScM9Wc=;
 b=U2sWwJMivvlHOzT1WtoufcNeZBVfNPYubH5sWS4M4fNZF5hh9kIeXjXDIgrK10O3vB
 fEKv7ekpdBHF/hNdRfwyZlsDZA1ymjWL/vVlhXpYZrloJdgSYv37r1+uCgvjbxh5jJ45
 sifToNTn4ZLYDc+dRCQefuJ0wIwU+/Z1QZ/P5/aoTXJ7o1w/pmumiR/8pxrfVo579YgM
 A9iuF2Mwl5nHKjgCn2LHwYicMB/5PfKdN+Y07ShDTp5Dx4VWTN9wEE4BTd1QIA9NT1xh
 NvhoYtX55qCcuFXeVlKnNf2uaVOya7Sgo/JqWMt0j9L17JPth+j4UJxQOBu+BWHMKOUe
 HsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741623812; x=1742228612;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hTbOaGZrrF4NiuEL8VQfK3c6ke2rWoltj4cL0ScM9Wc=;
 b=CiAQma71q64vUkq8qmDcp0GhmgyKcz58dfMAX8aUYevBYddYaKNZbjL8Vbn661M3t2
 2LNJ76z/06V+QjKkJCxoutxLBz5kOHoJL+7QeXR8BazH/9474N6St7ueO/ROVTEgyzUy
 iKlik6YKmgDeOYKI9/DZUWKUb0EPM4R+YSjzlQB8em8wk9kJFo5Q9z7LHlCwvWWj6nRd
 n8lKjvPaPlezQKDV+PaVUTA/1gCAdv6jhhwvajZXCT84AE+9b4FaacSnW2ae5aiBqYIs
 qTGC2kM7pF5bJ1bbXlrzgvLpLfVAJmsKfkes3F00EIgcBRoCaBLp+1xqPqa8oYidC3WA
 YCZA==
X-Gm-Message-State: AOJu0YxsdTNumVfWsRqjdU60S41XeGfguYv3ZTsw2LcxtcFIdKxTEqKC
 IeaMS7i1o2JoRAPMd8QSiXLQuIsnYtfc//Nhs8eGwoY1NtgeNXi9DlAQmCDQdohlBRSlBNwHhAe
 jxiznON/RqVtXdftfYazmWD52EbCQgA3/ARli1kZXSzhBplW7r0n/eQ==
X-Gm-Gg: ASbGnctomRCeItIdod7nR/Cce0Zum3a8d1P+TtXg+R4S2eIktGCYihxb3YYdcA4ApM9
 j85vqsT5RWDggGOZ33txVov5voQGnmGktwUD7EvfKrk+B4lEshkBMmaQ3Fb6nlKid6BKLN+5gvH
 OE2CVhObXigPXyQIOTnSVao3w/d51DojezQ+ixw8KW8rHwM3N22QbYfpq5QU+ZXv+ebrAExw==
X-Google-Smtp-Source: AGHT+IHWlh0oXnPD4mSllzeuJA4pXl0oSaqI0QuU54S3k0U2eQ4NvXpnFuZKowHrusYu/44/dULG+6bRYyiJBdB+4CM=
X-Received: by 2002:a05:6a20:7483:b0:1ee:d317:48e9 with SMTP id
 adf61e73a8af0-1f544ad8152mr26227068637.6.1741623812283; Mon, 10 Mar 2025
 09:23:32 -0700 (PDT)
MIME-Version: 1.0
From: David Milosevic <david.milosevic@9elements.com>
Date: Mon, 10 Mar 2025 17:23:21 +0100
X-Gm-Features: AQ5f1JqrIHKwihG5RF8uCuxPla-D1NqPMMLVWTM4hSBV46j4RrdJ1NY6yiAkL_c
Message-ID: <CAFUY6-d5GZSrDzD0vUEF6P4YnstMjx=G3Q77iFGLt3eBUf5WUA@mail.gmail.com>
Subject: [RFC] Proposal for a QEMU video subsystem for cameras and webcams
To: qemu-devel@nongnu.org
Cc: Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 pizhenwei@bytedance.com
Content-Type: multipart/alternative; boundary="000000000000a9fa94062fff64dc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=david.milosevic@9elements.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000a9fa94062fff64dc
Content-Type: text/plain; charset="UTF-8"

Dear QEMU Developers,

I would like to propose the development of a video subsystem in QEMU, with
the initial
implementation focusing on UVC video device emulation and support for
multiple
backends, including V4L2, GStreamer, and libcamera.

This work is already in progress at 9elements, and we would like to
upstream it.

== Motivation

Currently, USB pass-through is the only way to make video devices available
to guests, which

    - excludes non-USB cameras (e.g., MIPI)
    - performs poorly with high-resolution cameras
    - does not work with USB 3.0 video devices (Issue #1613)

== Proposal

We aim to introduce a video subsystem in QEMU that allows for the
implementation of various
video devices, similar to how QEMU handles audio. The first device
implementation will be
UVC (USB Video Class) device emulation, with support for multiple backends.
Future extensions
could include virtio-video or other PCI-based video devices.

Supported backends:

    - Video4Linux (V4L2)
    - GStreamer
    - libcamera

== Example: V4L2 Backend

Once implemented, a typical QEMU command line for using a V4L2 backend
would look like this

    ./build/qemu-system-x86_64 \
        -device qemu-xhci \
        -videodev v4l2,id=cam0,device=/dev/video0 \
        -device usb-video,videodev=cam0

This sets up a UVC emulated device in the guest, using /dev/video0 from the
host via the V4L2 backend.

== Next Steps

We welcome feedback on design considerations and integration approaches.
Let us know
if there are existing discussions or preferred directions for this work.

Best regards,

David Milosevic
Firmware Developer
9elements

--000000000000a9fa94062fff64dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear QEMU Developers,<br><br>I would like to propose =
the development of a video subsystem in QEMU, with the initial<br>implement=
ation focusing on UVC video device emulation and support for multiple<br>ba=
ckends, including V4L2, GStreamer, and libcamera.<br><br>This work is alrea=
dy in progress at 9elements, and we would like to upstream it.<br><br>=3D=
=3D Motivation<br><br>Currently, USB pass-through is the only way to make v=
ideo devices available to guests, which<br><br>=C2=A0 =C2=A0 - excludes non=
-USB cameras (e.g., MIPI)<br>=C2=A0 =C2=A0 - performs poorly with high-reso=
lution cameras<br>=C2=A0 =C2=A0 - does not work with USB 3.0 video devices =
(Issue #1613)<br><br>=3D=3D Proposal<br><br>We aim to introduce a video sub=
system in QEMU that allows for the implementation of various<br>video devic=
es, similar to how QEMU handles audio. The first device implementation will=
 be<br>UVC (USB Video Class) device emulation, with support for multiple ba=
ckends. Future extensions<br>could include virtio-video or other PCI-based =
video devices.<br><br>Supported backends:<br><br>=C2=A0 =C2=A0 - Video4Linu=
x (V4L2)<br>=C2=A0 =C2=A0 - GStreamer<br>=C2=A0 =C2=A0 - libcamera<br><br>=
=3D=3D Example: V4L2 Backend<br><br>Once implemented, a typical QEMU comman=
d line for using a V4L2 backend would look like this<br><br>=C2=A0 =C2=A0 .=
/build/qemu-system-x86_64 \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 -device qemu-xhc=
i \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 -videodev v4l2,id=3Dcam0,device=3D/dev/v=
ideo0 \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 -device usb-video,videodev=3Dcam0<br=
><br>This sets up a UVC emulated device in the guest, using /dev/video0 fro=
m the<br>host via the V4L2 backend.<br><br>=3D=3D Next Steps<br><br>We welc=
ome feedback on design considerations and integration approaches. Let us kn=
ow<br>if there are existing discussions or preferred directions for this wo=
rk.<br><br>Best regards,<br><br>David Milosevic<br>Firmware Developer<br>9e=
lements</div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"g=
mail_signature"><div dir=3D"ltr"><div style=3D"color:rgb(34,34,34);font-fam=
ily:Helvetica;background-color:rgb(255,255,255);line-height:11px">
</div></div></div></div>

--000000000000a9fa94062fff64dc--

