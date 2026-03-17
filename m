Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C7DFF6E85
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 21:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2c87-0002VN-6K; Tue, 17 Mar 2026 17:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w2c84-0002VC-2d
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 17:39:08 -0400
Received: from v5227.v57ae4e16.euw1.send.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w2c7z-0000UH-Nt
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 17:39:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1773783541; x=1773790741; 
 h=Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: From: From:
 In-Reply-To: References: MIME-Version: Sender: Sender; 
 bh=pA9U/DPF21Hr1w4LA1Qf+OhVncGb0EjlfjSe0p9yE+Q=;
 b=nu+n52tdluPydCb2jNcKHjD6956mrfX4zK/soa89JWjoif/Hnb5kzQ2VOOEZOZjlUN9aiLeX3T8+xYdNdQsI8AZbyDkkc8SZMpFHc9ZUSQIuugHvaBWLS4KcPgRaPEIcPjdNdAdgXKMsAEXqZ438NQDeMzYpXeqx1c41jZeL8TSYysoHmsWu3jfVkbOJmAydYsb4BhRKSBnDqhp1e2Jdbetrh280KzHOTyzfVMFv1c3k3TXpkM/OMwG64JWGe5lcmA3oeHdGAPY900qLR1ABIWisQ2R7ULqsMRn+VWXYvM1/5uXB0tKca7b/UBEO5v+S8A/TySHdGwpOBv1IMrpORg==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48]) by
 bb6df76e045d1614a115f79712fad37ee8940e4519668a6f318e51ee93f3009c with SMTP id
 69b9c9f5fe3b980d54d1bf6b (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 17 Mar 2026 21:39:01 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-64ae222d87dso5788273d50.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 14:39:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVNCF67R8+7BpCoFt43M3EN11Qj6IkPQI/xAj6MUepQVRQqMCMtxY6as2O8ZoqvEWrf+rHoJCS5VFhc@nongnu.org
X-Gm-Message-State: AOJu0YzQZLv1hLUb443NPtFivhlZKQ8wjHmEOuvNdOfxSSRJfUtKnFx5
 TK+y4GixPgGzONWwwBypLJx2pUDMFm7pKIOCNRW1JKeKMdeWYX0k6kbvTTEFO5C/GBeNGwjBu0z
 /NtYxfZaH+Huf9uK+ukxC4w9Bw0kScW8=
X-Received: by 2002:a53:ecd6:0:b0:64c:c1b6:7150 with SMTP id
 956f58d0204a3-64e91587399mr1076855d50.46.1773783540513; Tue, 17 Mar 2026
 14:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260311215003.664815-1-alessandro@0x65c.net>
 <20260311215003.664815-3-alessandro@0x65c.net>
 <87h5qflyqe.fsf@pond.sub.org>
In-Reply-To: <87h5qflyqe.fsf@pond.sub.org>
From: Alessandro Ratti <alessandro@0x65c.net>
Date: Tue, 17 Mar 2026 22:38:48 +0100
X-Gmail-Original-Message-ID: <CAKiXHKd15rFWk3qM+f_X2JXr29u1ygTumCcGrm9iDLEtwALQNQ@mail.gmail.com>
X-Gm-Features: AaiRm52tG7kXzNLIdOFEZHgo_Fjr3Kdf9KAs8F2lAuQ2rCUv1McpQDokyo8lscM
Message-ID: <CAKiXHKd15rFWk3qM+f_X2JXr29u1ygTumCcGrm9iDLEtwALQNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/qdev: Remove qdev_get_human_name()
To: Markus Armbruster <armbru@redhat.com>
Cc: Alessandro Ratti <alessandro@0x65c.net>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, 
 berrange@redhat.com, mst@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=161.38.204.227;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=v5227.v57ae4e16.euw1.send.eu.mailgun.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 17 Mar 2026 at 08:08, Markus Armbruster <armbru@redhat.com> wrote:
>
> Alessandro Ratti <alessandro@0x65c.net> writes:
>
> > Remove qdev_get_human_name() and switch its two callers in
> > hw/block/block.c to qdev_get_printable_name().
> >
> > qdev_get_printable_name() subsumes qdev_get_human_name(): both
> > return the device ID when set and fall back to the canonical QOM
> > path, but qdev_get_printable_name() also tries the bus-specific
> > device path first, providing more informative output.
> >
> > Narrow the scope of dev_id in blk_check_size_and_read_all() to the
> > blocks where it is actually used.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
>
> This replaces two ways to describe a device to the user by one.  Good.
>
> One half of the uses is unchanged.  Good.
>
> The other half can now show a bus-specific device path instead of the
> canonical QOM path.  This path can be difficult to interpret: we have
> some twenty .get_dev_path() methods, and each of them can format however
> it wants.  I need to guess the format to make sense of the value.  I'm
> inclined to call this a regression.
>
> To address this, please insert another patch before this one that
> changes
>
>         device <dev-path>
>
>   to
>
>         <bus> device <dev-path>
>
> This removes the guesswork, and actually satisfies the claim "more
> informative output".
>

Will do. I've prototyped this using object_get_typename() on
dev->parent_bus to get the bus type.

A complication: a few buses (virtio-pci-bus, ufs-bus) delegate
get_dev_path() to their parent unchanged, so the path format doesn't
match the immediate bus type. I detect delegation by comparing the
child's path to the parent bus's path, and format as
"<child-bus> on <parent-bus> device <path>".

Tested with i440fx + virtio-blk + UFS + USB + SCSI:

  PCI device 0000:00:04.0
  virtio-pci-bus on PCI device 0000:00:04.0
  ufs-bus on PCI device 0000:00:04.0
  SCSI device 0000:00:04.0/0:0:0
  usb-bus device 0000:00:03.0/1

And with Q35:

  PCIE device 0000:00:04.0
  virtio-pci-bus on PCIE device 0000:00:04.0
  ufs-bus on PCIE device 0000:00:04.0
  SCSI device 0000:00:04.0/0:0:0
  usb-bus device 0000:00:03.0/1

If my understanding is correct, VMBus delegates to sysbus which has
no get_dev_path(), so it falls through to the QOM path.

Note: object_get_typename() gives "PCI" on i440fx and "PCIE" on Q35
for the same address format. Not sure if that's confusing enough to
warrant normalizing.

> qdev_get_human_name() is a better name than qdev_get_printable_name().
> Please consider renaming the function so we keep the better name.
>

Ack, will rename.

If my proposal to add "<bus> device" prefix sounds solid,
I'll send a v3 with the series restructured as:

  1. Replace "<unknown device>" with canonical QOM path, clean up comments
  2. Add "<bus> device" prefix to bus-specific paths
  3. Consolidate into qdev_get_human_name()

Thanks for your time and consideration.

Best regards,
Alessandro

