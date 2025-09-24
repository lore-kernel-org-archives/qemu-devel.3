Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243A2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lqz-0000n2-6i; Wed, 24 Sep 2025 05:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v1Lqw-0000bi-08
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:31:58 -0400
Received: from m204-227.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v1Lqr-0005K3-F3
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:31:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1758706304; x=1758713504; 
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From:
 Sender: Sender; 
 bh=9OWBILG/MEb85AU5rnQ0gq6gxxt8z8W8K79L15U28D0=;
 b=ZgnhAqsqL3oKwglDdP2Vld6vwKwseCqD7/gX+S90DZTENEsTNFBwX8/lFFXRvOOn+0/ov+/9a/jVtf8xsyT9lFK296q+HWyXogyEeNVbDJNU67IR1/yhP+UxmxwdsjYqq9smlJTakHfMM12uM92RPzGsd+YLJuDldZbzYBDZvmsm8lEDXEgDSn+kNvQz1h0+GcaArxvkG5ZmO3Jxwavft4sDR9yhM373OlsqPBOaArVNAm+EA6LB+9TEtYgSeaVLSLekPhpSpj/6sbOVueRRGjPMYQV3yCzMBL7L9DB6ZkxTtZZclCJe1UOgYAcfq4DZjbwpPBJBDN4f3J/1tHd2Ew==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 3410bf604baf3b1186e1b7c3ddb9946731989e4e31ae93aebc8156634f8d87f1 with SMTP id
 68d3ba8014c8477b826badd8; Wed, 24 Sep 2025 09:31:44 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
From: Alessandro Ratti <alessandro@0x65c.net>
To: berrange@redhat.com
Cc: alessandro.ratti@gmail.com, alessandro@0x65c.net, alex.bennee@linaro.org,
 armbru@redhat.com, mst@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3] virtio: improve virtqueue mapping error messages
Date: Wed, 24 Sep 2025 11:14:03 +0200
Message-ID: <20250924093138.559872-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aNLIHOwcGB47qbUY@redhat.com>
References: <aNLIHOwcGB47qbUY@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=161.38.204.227;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m204-227.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On Tue, 23 Sept 2025 at 18:17, Daniel P. Berrangé <berrange@redhat.com> wrote:
>
[...]
> >  hw/virtio/virtio.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 43 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 9a81ad912e..f5adc381a4 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -235,6 +235,37 @@ static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
> >      }
> >  }
> >
> > +static const char *virtio_get_pretty_dev_name(VirtIODevice *vdev)
>
> I'd suggest this be  'const char *qdev_get_printable_name(DeviceState *dev)'
> and live in  the same header & source files as qdev_get_dev_path.
>
> I used 'printable' rather than 'pretty' as I'm not sure I'd claim
> that qdev_get_dev_path() results can be said to be pretty :-)

Thanks for the review and the suggestion.

Fair enough :) — I've renamed the helper to qdev_get_printable_name() and moved
it next to qdev_get_dev_path() in `hw/core/qdev.c`, as you recommended.

[...]
> > +    /*
> > +     * Final fallback: if all else fails, return a placeholder string.
> > +     * This ensures the error message always contains a valid string.
> > +     */
> > +    return "<unknow device>";
>
> s/unknow/unknown/
>

Fixed, thanks for catching that!

[...]
>
> This part all looks good

Glad to hear! I've sent out v3 with the changes above. Let me know if you
have any further thoughts or improvements in mind.


Thanks again for your time and helpful reviews.

Best regards,
Alessandro

---

Changes since v2:
- Renamed helper to qdev_get_printable_name()
- Moved helper to appropriate source/header location
- Fixed typo in fallback string
- Incorporated review feedback from Daniel Barrangé

