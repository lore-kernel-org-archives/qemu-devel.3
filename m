Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FCAFD88C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05FS-0002LQ-Tm; Tue, 10 Mar 2026 18:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w05FR-0002Kt-Om
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:08:17 -0400
Received: from v5227.v57ae4e16.euw1.send.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w05FP-0001YH-Dh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:08:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1773180492; x=1773187692; 
 h=Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: From: From:
 In-Reply-To: References: MIME-Version: Sender: Sender; 
 bh=avZ/Ls6XknKuJWYH4UHX7PDYSMMtFXrS3kEC+iL4oFw=;
 b=OrJoWD5nNbyiIMnGXLd3TbyIs8kLmKxHzoW9LHctqZfDHeOuubU1Xjcs09/aizeOgYKs5aYEElOF1ajCEEbMXUTfvV+RxMyU9fiV7qe18cSLjYpvK/LU3JSyhxO2jkXFwQTNX644W/cBeAlGaalQW1Yc9CsVhL1kSveOB/MBYQH10nSeMbQfLZShYTskZ0kio2e51z1meUs3y7im7v9BQspca1p6n9W4OqSFW3Jrax3HR2VaDMX/6RIbGWhHZ8FQAWMSMDVxeDKPIgoh8IuyWRkDqC1kISfq6Z6oYvVbCEmueh3uWyj0plv5KCCDYEf3MAV7lWGIC8tBila/KjnJJQ==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177]) by
 712eb054bc9015b0ebda65af28a98072b50f328f288845fcd2556865c8031c9b with SMTP id
 69b0964c6842c2d0d4e61960 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 10 Mar 2026 22:08:12 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-797ab169454so138284017b3.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUkaKECVFwje/g+5G31BKcLZ0PMfSmH6sxqGr4pcWwwt/RQFGG3TgcdiH1g/l0EqC9yJWzN5PF592ff@nongnu.org
X-Gm-Message-State: AOJu0YzTysJZ+/tOXJb7P3qmKoidZWmsFhEj4IFs8LteYvIUo9BgSl5k
 HIn7+PcxzqA/f2hJAGPtV1Q8Guq1PQYGZL3N6RFBS6uN48NzPFMBJh7D3drSVBdG4drqDJZXl5C
 HWe27sJ8fH2jJJWykXWkPt2IZgZp7fZE=
X-Received: by 2002:a05:690c:6e81:b0:796:c34b:9b01 with SMTP id
 00721157ae682-79917feebc7mr2875187b3.55.1773180491748; Tue, 10 Mar 2026
 15:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260308160040.354186-2-alessandro@0x65c.net>
 <87jyvjamzb.fsf@pond.sub.org>
In-Reply-To: <87jyvjamzb.fsf@pond.sub.org>
From: Alessandro Ratti <alessandro@0x65c.net>
Date: Tue, 10 Mar 2026 23:08:00 +0100
X-Gmail-Original-Message-ID: <CAKiXHKfWWGYp4HeTpVH-OegVXi0wCcsBedpoC+7BTjreLCLH6w@mail.gmail.com>
X-Gm-Features: AaiRm52Dt8b5nzL0__s3RdBCOqrdg1xaQJLUYN1WASybWzp1C1Wkz2L4INBtwhE
Message-ID: <CAKiXHKfWWGYp4HeTpVH-OegVXi0wCcsBedpoC+7BTjreLCLH6w@mail.gmail.com>
Subject: Re: [PATCH] qdev: Consolidate qdev_get_human_name() into
 qdev_get_printable_name()
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

On Tue, 10 Mar 2026 at 13:27, Markus Armbruster <armbru@redhat.com> wrote:
>
> Alessandro Ratti <alessandro@0x65c.net> writes:
>
> > Hello,
> >
> > This patch consolidates qdev_get_human_name() and qdev_get_printable_name()
> > into a single function, as suggested by Peter Maydell here [1]
> >
> > This patch is based on Peter's recent series and should be applied after [2]:
> > - "hw/qdev: Document qdev_get_dev_path()"
> > - "hw: Make qdev_get_printable_name() consistently return freeable string"
>
> Use
>
>   Based-on: <20260307155046.3940197-1-peter.maydell@linaro.org>
>

Will do.

> so that tools like patchew can apply patches without human intervention.
>
> > Thank you for your time and consideration.
> >
> > Best regards
> > Alessandro
> >
> > [1]: https://lore.kernel.org/qemu-devel/aNLIHOwcGB47qbUY@redhat.com/T/#m89da9b4e30b7c84713ca4b6c323514c72897e649
> > [2]: https://lore.kernel.org/qemu-devel/20260307155046.3940197-1-peter.maydell@linaro.org/T/#m962127cb58192e0b2095039cb2fb79145f2a7388
> >
> > ---
>
> git-am uses part above the --- line as commit message.  That's clearly
> not what you intended.

Right, lesson learned. I'll move the introduction below the --- line in the
future.

>
> To fix it, put your introduction ...
>
>
> > Remove qdev_get_human_name() and use qdev_get_printable_name() for all
> > device identification in error messages.
>
> I think qdev_get_human_name() is the nicer name of the two.  Matter of
> taste.

Fair enough, but since Peter's series already establishes
qdev_get_printable_name(), I kept that one.

>
> > Both functions now behave similarly, with qdev_get_printable_name()
>
> Both functions?  You remove one!

Poor wording on my part, sorry. Will fix.

>
> > preferring bus-specific paths (e.g., PCI addresses) when available
> > before falling back to QOM canonical paths. This provides better
> > context in error messages while maintaining the same level of detail.
> >
> > Error messages will now show device identifiers in this priority:
> > 1. User-specified device IDs (e.g., -device virtio-blk,id=foo)
> > 2. Bus-specific identifiers (e.g., PCI addresses like 0000:00:04.0)
> > 3. QOM canonical paths as a last resort
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> > ---
>
> ... here instead.  Or simply use a cover letter.
>
> >  hw/block/block.c       |  5 ++---
> >  hw/core/qdev.c         | 19 ++++++++-----------
> >  include/hw/core/qdev.h | 13 -------------
> >  3 files changed, 10 insertions(+), 27 deletions(-)
> >
> > diff --git a/hw/block/block.c b/hw/block/block.c
> > index f187fa025d..84e5298e2f 100644
> > --- a/hw/block/block.c
> > +++ b/hw/block/block.c
> > @@ -65,7 +65,6 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
> >  {
> >      int64_t blk_len;
> >      int ret;
> > -    g_autofree char *dev_id = NULL;
> >
> >      if (cpr_is_incoming()) {
> >          return true;
> > @@ -78,7 +77,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
> >          return false;
> >      }
> >      if (blk_len != size) {
> > -        dev_id = qdev_get_human_name(dev);
> > +        g_autofree const char *dev_id = qdev_get_printable_name(dev);
> >          error_setg(errp, "%s device '%s' requires %" HWADDR_PRIu
> >                     " bytes, %s block backend provides %" PRIu64 " bytes",
> >                     object_get_typename(OBJECT(dev)), dev_id, size,
>
> I believe this plugs a memory leak.  Separate patch, please, with
>
>   Fixes: 954b33daee83 (hw/block/block.c: improve confusing blk_check_size_and_read_all() error)
>

As Peter noted, the original dev_id is already g_autofree, so there's
no leak here - just narrowing the variable scope.

> > @@ -95,7 +94,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
> >      assert(size <= BDRV_REQUEST_MAX_BYTES);
> >      ret = blk_pread_nonzeroes(blk, size, buf);
> >      if (ret < 0) {
> > -        dev_id = qdev_get_human_name(dev);
> > +        g_autofree const char *dev_id = qdev_get_printable_name(dev);
> >          error_setg_errno(errp, -ret, "can't read %s block backend"
> >                           " for %s device '%s'",
> >                           blk_name(blk), object_get_typename(OBJECT(dev)),
>
> Likewise.

Ditto.

>
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index e48616b2c6..9ee98a0c39 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -434,10 +434,15 @@ const char *qdev_get_printable_name(DeviceState *vdev)
>    const char *qdev_get_printable_name(DeviceState *vdev)
>
> Nitpick: @vdev is an unusual identifier.  Please use @dev like the code
> nearby.

Ack.

>
>    {
>        /*
>         * Return device ID if explicity set
>         * (e.g. -device virtio-blk-pci,id=foo)
>         * This allows users to correlate errors with their custom device
>         * names.
>         */
>
> I doubt this comment is worth its keep.

Agreed, I'll drop it.

>
>        if (vdev->id) {
>            return g_strdup(vdev->id);
>        }
>        /*
>         * Fall back to the canonical QOM device path (eg. ID for PCI
>         * devices).
>
> This comment is mostly nonsense: there's no such thing as a "canonical
> QOM device path".  There's a canonical QOM path (the path from root to
> object in the QOM composition tree), but qdev_get_dev_path() doesn't
> return it.
>
>         * This ensures the device is still uniquely and meaningfully
>         * identified.
>         */
>        const char *path = qdev_get_dev_path(vdev);
>        if (path) {
>            return path;
>
> This returns a "name" in a bus-specific format if the device is plugged
> into a bus that provides the get_dev_path() method.  Many buses do.
>

You're right, I'll fix the comments to describe what qdev_get_dev_path()
returns based on your explanation.

> For instance, the PCI bus's method is pcibus_get_dev_path().  It appears
> to return a path of the form
>
>     Domain:00:Slot.Function:Slot.Function....:Slot.Function.
>
> which is commonly just a PCI address.
>
> Intepreting the value can be difficult: we have some twenty
> .get_dev_path() methods, and each of them can format however it wants.
> I need to guess the format to make sense of the value.
>
> Could we do something like "<bus> device <dev-path>"?  E.g.
>
>     PCI device 0000:00:00.0
>

That's a nice idea. I think it deserves its own series though, since it
would involve changes to the bus get_dev_path() methods or to how
qdev_get_printable_name() formats the result.
I'll follow up on that separately.

> >      }
> >
> >      /*
> > -     * Final fallback: if all else fails, return a placeholder string.
> > -     * This ensures the error message always contains a valid string.
> > +     * Final fallback: return the canonical QOM path.
> > +     * While verbose (e.g., /machine/peripheral-anon/device[0]), this
> > +     * provides accurate device identification when neither a user-specified
> > +     * ID nor a bus-specific path is available. Only falls back to
> > +     * <unknown device> in the extremely rare case where even the QOM
> > +     * path is unavailable.
>
> This case isn't "extremely rare", it should never happen.

Understood.

> object_get_canonical_path(vdev) can only return null when @dev qom_path
> can only be null when @vdev is not part of the QOM composition tree.
>
> >       */
> > -    return g_strdup("<unknown device>");
> > +    char *qom_path = object_get_canonical_path(OBJECT(vdev));
> > +    return qom_path ? qom_path : g_strdup("<unknown device>");
>
> qom_path should never be null, and I wouldn't bother with a fallback.

Ack, I'll drop the fallback.

> This is not a demand.  If you want a fallback, consider something like
>
>     g_strdup_printf("bad device %p").
>
> This patch does two things: improve qdev_get_printable_name(), and
> replace qdev_get_human_name().  Please split it.
>

Ack, I'll split it into two patches in v2.

Thanks for the thorough review, I'll send a v2 addressing all of the above.

Best regards,
Alessandro

