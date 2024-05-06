Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4392AC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 03:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3pL5-0007cz-Up; Sun, 05 May 2024 23:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s3pL4-0007cA-BP
 for qemu-devel@nongnu.org; Sun, 05 May 2024 23:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s3pL2-00045y-2v
 for qemu-devel@nongnu.org; Sun, 05 May 2024 23:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714967306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSK62MJbU3FHTHsma8iEmMQD+HKDSbuD0OhWsE/hw6g=;
 b=H9C+uOqTwQiJor5QYrQLF3DIkmVSUKfQJwuN3+qMugcFtvY8aKrkkmDubvlQfxcyYK+6g7
 IGxOYpFHU+sME+7/9tdH8V1Mmyivit3ym5DSHEZVzLRRRUHHDYvPiBZ3P6OqdA/kUO4rDS
 anl597EhP+nZ5umV8i0BW4kFvJ1iVQc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-uUCOm00ROWKHqfE_0oJCmA-1; Sun, 05 May 2024 23:48:24 -0400
X-MC-Unique: uUCOm00ROWKHqfE_0oJCmA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5d8bff2b792so1816457a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 20:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714967303; x=1715572103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSK62MJbU3FHTHsma8iEmMQD+HKDSbuD0OhWsE/hw6g=;
 b=vdCADP2HbuJgKiE+zY4jG09CghJeAW355GXR15MozRbgv/URX4G1bvu2aN2xZGxecG
 AEUma+6RmEeAYqoTUbQ0A/ZVMqoZK5+DuB3ntMi9bLvk9IFYIX4IEQ1dwVDKnTXqXHGf
 bqOsxq60xAbXHNeVxMJBtl2G4YD5B2DNg1aFQRiknRhdhCLJ2R7DCqKY4x72xUPB0eF+
 sqTXoa5BlLHCa3t7m7J+zerT1lkwBnuhMRXVG2+i984gHNpXvtc2jw8Qq7k94m/+3fBD
 KXhexc87GfhkR60Z3YRDgOGDVM6SQCkaGFO4QynCYem5q6Rq9McnJ4zDLfSkEpn5u+EX
 ExQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6ZCUO7djZrFYCwmwgrtFxcN0xxs40fuGfuSJmv2z77I7IP3FeplqHC7utn76pZIGk3GeSqb8L4MK0uGc8rDNZ8cME9ug=
X-Gm-Message-State: AOJu0YwbzIYT/Qvkqiy0LG0rXhc1/bCrMa2Zaot/36JikqzASoe6UkkM
 h2tjsngiZ2/2YIhCY3hINEaWejoHDpQAu7jIqZxEokXySYdgbHUM+2Aehwk/DrwijszDaqUxe7U
 qbE/vQdLYWeNLOrFttOBdCMU6rBs5rerFJxDS20vW5BWW755Ei8olREHqwI8rFW0tk704bEC3I9
 cmKtJ6jDW1F74u75H5lG9j0ep/d50=
X-Received: by 2002:a05:6300:8a0d:b0:1ac:34cc:b323 with SMTP id
 jp13-20020a0563008a0d00b001ac34ccb323mr8804180pzc.33.1714967303132; 
 Sun, 05 May 2024 20:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXnClhD4pShFaQfAMeUeU+40pPyF/eC7uPp6x5JOFYW+IceIGj4C1hd5rGkTLsQvS0eF98Z1hgBkARsT5/pNU=
X-Received: by 2002:a05:6300:8a0d:b0:1ac:34cc:b323 with SMTP id
 jp13-20020a0563008a0d00b001ac34ccb323mr8804168pzc.33.1714967302773; Sun, 05
 May 2024 20:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240428-auto-v1-0-7b012216a120@daynix.com>
 <20240429030329-mutt-send-email-mst@kernel.org>
 <e7b29a10-addf-4fed-9092-73652cb16cce@daynix.com>
In-Reply-To: <e7b29a10-addf-4fed-9092-73652cb16cce@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 May 2024 11:48:11 +0800
Message-ID: <CACGkMEs9-afb2btypPqeLNTJA_vAhdTa5kqZxuCUPUBtQiELog@mail.gmail.com>
Subject: Re: [PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 20240428-rss-v10-0-73cbaa91aeb6@daynix.com, 
 Jonathon Jongsma <jjongsma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, May 1, 2024 at 3:20=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2024/04/29 16:05, Michael S. Tsirkin wrote:
> > On Sun, Apr 28, 2024 at 04:21:06PM +0900, Akihiko Odaki wrote:
> >> Based-on: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
> >> ("[PATCH v10 00/18] virtio-net RSS/hash report fixes and improvements"=
)
> >>
> >> Some features are not always available, and virtio-net used to disable
> >> them when not available even if the corresponding properties were
> >> explicitly set to "on".

I think we'd better fail the initialization in this case, otherwise it
might confuse libvirt.

Adding Jonathon for more comments.

> >>
> >> Convert feature properties to OnOffAuto so that the user can explicitl=
y
> >> tell QEMU to automatically select the value by setting them "auto".
> >> QEMU will give an error if they are set "on".
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >
> > Should we maybe bite the bullet allow "auto" for all binary/boolean
> > properties? Just ignore "auto" if no one cares ATM.
>
> It is not always obvious whether "auto" should be considered as "on" or
> "off" for existing boolean properties. The properties this patch deals
> with are to enable features so "auto" should be considered as "on" if
> possible. However, other properties may mean to disable features, and in
> such a case, "auto" should be considered as "off".
>
> It may still make sense to accept "auto" for all virtio-net feature bits
> for consistency. In particular, I left guest_rsc_ext property boolean
> since nobody cares "auto" for that feature, but this can be converted to
> OnOffAuto.
>

Thanks


