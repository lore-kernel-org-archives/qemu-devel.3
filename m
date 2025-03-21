Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDE8C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvW5A-00042t-74; Fri, 21 Mar 2025 02:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tvW56-00042R-UL
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tvW54-0005Tn-Fp
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742539327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QAn5WoWuptktZJIVEbzo3Jad/09e7cyhc5XBo5L9c+w=;
 b=UN7nIrdIzJcksQi6gYjsgrgnIxTgjFM512KdhPw++R2tWhKGgPusa3t4fM3fX6X6oWncGQ
 oZ7CgmMK9lrCMo2ZjiMIwBgsCl9fb0J/ClSX2+mewjhAEzblRanicZ7qqNyTOaBRuJm+b8
 O0FnJM3hsM6QKKwFAU/PDEkBmWjUu8o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-293S6RzcMZeYaDSbC_ZI_w-1; Fri, 21 Mar 2025 02:42:05 -0400
X-MC-Unique: 293S6RzcMZeYaDSbC_ZI_w-1
X-Mimecast-MFC-AGG-ID: 293S6RzcMZeYaDSbC_ZI_w_1742539325
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c54a6b0c70so166600185a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 23:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742539325; x=1743144125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QAn5WoWuptktZJIVEbzo3Jad/09e7cyhc5XBo5L9c+w=;
 b=n6hSg6kTEcP+bF+xIa0kWRFc1cvovff1qRZYflAatt7ZZgRMceR8qlJRqout60fqbg
 s4L0pHACZTrDzdf8vgz84B56vWftfJSwJzpE8aR2HBdUkYmRIbnwlJPTkzZ0MqgBy8Ot
 +PQicVqIxWiC0u5q3Ic51KMxf9LXPC8PY2JN1J++sAk/vtjito4rQeyGg2bDAweZH0G4
 O+sqEpnpIwG6PdzR0UdLTG/1XwSRARBqqE7ghPLAG0ZimVGDoRxqSbU+dcH1WOZHGOr6
 oVT2ZBRGjMbqBnDuVU1QNIu2rCFLfPVMb5RyRsYrOg3EkY6R9cXk5XG/l8xC942kuJ//
 yXew==
X-Gm-Message-State: AOJu0YyYQDpD0yESO4+4WsOktSJoUveUJK4AQmJw3Q9G/Qe1s6f1CMkS
 ZKevpt8hSeVNa8wSkewSz/ybFyFGDbyUYHtNRHhOHMyBm3TI8EGjZFAP6u14Nki3mZatVy0rwTk
 qASacnlW/zoovoby6+fojTgRnYT8Hs9ufWPbutZZPMUTFmeIFusROva2C5E7PBAwrY7Ma8XLuw6
 4EL4b40aud1h8x0xpmpCwOL7+8xdI=
X-Gm-Gg: ASbGnct2tXDrJecXdE6ExILxdspoHsZkcykC7JoOXeRDXwj+rgKrs1hHOHZpIvA2Qsy
 BLWUOkISQ8sEABXMyuzp6HgYPipDTKJADX30Zp48bzHwLhObTB6kNSrMh+8gdO/chgJQkD6Iide
 WGYBYjOxtFfzZsHKxFs9iuarJLhMIbBQ==
X-Received: by 2002:a05:620a:25d2:b0:7c5:4a8e:b71 with SMTP id
 af79cd13be357-7c5ba23f47amr345545285a.47.1742539324857; 
 Thu, 20 Mar 2025 23:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxkLoCr6y8GuZqtdfeTwTa4PwfwYnfla+yFJpXDkp4v530+E0LCwlFfwas3lAxhMGD9S+b7Lcs8qqBSrk6gjc=
X-Received: by 2002:a05:620a:25d2:b0:7c5:4a8e:b71 with SMTP id
 af79cd13be357-7c5ba23f47amr345543985a.47.1742539324577; Thu, 20 Mar 2025
 23:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1742527956.git.yong.huang@smartx.com>
In-Reply-To: <cover.1742527956.git.yong.huang@smartx.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 21 Mar 2025 10:41:52 +0400
X-Gm-Features: AQ5f1JoruoIHPDV5gTzvy2-xL2qhBi1ZKluJriCnhJP_dud1eC31rTOxhisq8Pw
Message-ID: <CAMxuvaxorJD=Vnyuh6-3Ezdt0_6o_py8XhJuo3Dwfxu+zEWJWA@mail.gmail.com>
Subject: Re: [RFC 0/3] Support live migration for qemu-vdagent chardev
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, dengpc12@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Fri, Mar 21, 2025 at 7:40=E2=80=AFAM <yong.huang@smartx.com> wrote:
>
> From: Hyman Huang <yong.huang@smartx.com>
>
> Our goal is to migrate VMs that are configured with qemu-vdagent-typed
> chardev while allowing the agent to continue working without having
> to restart the service in guest.
>

I sent a more complete series last week: "[PATCH for-10.1 00/10]
Support vdagent migration"
https://patchew.org/QEMU/20250311155932.1472092-1-marcandre.lureau@redhat.c=
om/



> Let's justify which fields should be taken into account for struct
> VDAgentChardev.
>
> struct VDAgentChardev {
>     Chardev parent;
>
>     /* config */
>     bool mouse;
>     bool clipboard;
>
>     /* guest vdagent */
>     uint32_t caps;
>     VDIChunkHeader chunk;
>     uint32_t chunksize;
>     uint8_t *msgbuf;
>     uint32_t msgsize;
>     uint8_t *xbuf;
>     uint32_t xoff, xsize;
>     Buffer outbuf;
>
>     /* mouse */
>     DeviceState mouse_dev;
>     uint32_t mouse_x;
>     uint32_t mouse_y;
>     uint32_t mouse_btn;
>     uint32_t mouse_display;
>     QemuInputHandlerState *mouse_hs;
>
>     /* clipboard */
>     QemuClipboardPeer cbpeer;
>     uint32_t last_serial[QEMU_CLIPBOARD_SELECTION__COUNT];
>     uint32_t cbpending[QEMU_CLIPBOARD_SELECTION__COUNT];
> };
>
> parent:
> No dynamic information is generated. skip migrating.
>
> mouse, clipboard:
> The mouse and clipboard should be set up identically on both sides.
> Skip migrating.
>
> caps:
> Store the negotiated caps between the client and the guest.
> Should migrate.
>
> chunk, ... outbuf:
> The spice agent protocol's message transportation between the client
> and the guest is implemented using all of these fields, however the
> message loss can be tolerated by guests because the issue may occur
> in the real world as well.
> Could skip migrating.

It's part of the host/guest state, data will be lost and it's likely
the communication will break if it's not migrated.

>
> mouse_dev, ... mouse_hs:
> The mouse state can be reset after a live migration since the agent
> working inside the guest does not heavily depend on them.
> Could skip migrating

same

> cbpeer:
> Since the cbpeer would lose the data it references to if the qemu
> clipboard data was not migrated, this field can also be initialized
> after live migration.
> Could skip migrating
>

We should migrate the clipboard content too, to avoid having to
request it again, or have a noticeable effect.

> last_serial, cbpending:
> It is necessary for the agent to function after live migration.
> Should migrate.
>
> For the last_serial, saving & loading its value to make ensure the
> client receives the most recent clipboard data from the guest after
> live migration.
>
> For the cbpending, saving & loading its value aims to inform the
> guest that the clipboard has been released and is now empty in
> case that the guest acts strangely while supposing that the
> requested data can be properly retrieved.
>
> To summarize, all we need to do is migrate the caps, last_serial
> and cbpendings fields of the struct VDAgentChardev,
>
> Please review, thanks
>
> Yong
>
> Hyman Huang (3):
>   vdagent: Wrap vdagent_register_to_qemu_clipboard function
>   vdagent: Set up mouse and clipboard after live migration
>   vdagent: Drop blocker to support migration
>
>  ui/trace-events |   1 +
>  ui/vdagent.c    | 102 +++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 85 insertions(+), 18 deletions(-)
>
> --
> 2.27.0
>


