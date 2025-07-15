Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D62EC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiLX-0002eM-FK; Tue, 15 Jul 2025 12:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubhlS-0007iq-Ab
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubhlP-0004JC-U8
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752594014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4x2jlzMGApIh8vYUvg0aTLjZqP/Wbam/+YquAKpgluc=;
 b=dEgjhxPtrGnVAsTHLL5JkUp2Ejz+vp8EAKEl2X9rvuzSK/yHgTZv3cAqVkiGo9u7lA7PN0
 oFKVLaJ1eJjEtE6Tre5IJcAfK6iwl5xeBdTfZOpf8D3TzyxI0pr61j1dBMzx6O7XjZ+s3b
 UFphpSLwIHBOp33hSvqr+eABB6Q4iQw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-lLP_EpGDMsaxmpjVkjh1bg-1; Tue, 15 Jul 2025 11:40:13 -0400
X-MC-Unique: lLP_EpGDMsaxmpjVkjh1bg-1
X-Mimecast-MFC-AGG-ID: lLP_EpGDMsaxmpjVkjh1bg_1752594012
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45526e19f43so15741145e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 08:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752594011; x=1753198811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4x2jlzMGApIh8vYUvg0aTLjZqP/Wbam/+YquAKpgluc=;
 b=oS2c3oXC0GQprt6i4QGxPdx5XQlUgZyV/jISp9o4OOCW9D0nj0Oa+jnX6cP1XBkxit
 uIIDAgbyaCyZT1uEUGSFaigAF6L43aZT6y8uEY4+6qpSygM0Qq9HcLIgqYlS3QS6BanB
 VqcczJAfTAHwrQPZlEH8h/fvvQ/0NcqR5PPl6M/Sx1vsXaCfwuokWnXwSsj4gO7Xhplp
 eqYQMo4434WOwRnPVhPr3VL2Jp3WMu1BwVoDKL0t/B0mo6HSpISGr2qM2QRwbDGooK2S
 Ddtr9O5hReHPIy19F1da3R/EO5MaowtLtITdTakOqnZXlVjT5KDpoYkqJeKqGIs07pbe
 lGsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWJS5dmPRnXGbdNfrfoY8RI60/AkeTVWmOQo7ZRNyJ9F14iU6hjylQRUev5FcGgxyMDH6L204JHJdq@nongnu.org
X-Gm-Message-State: AOJu0YwXrY3TtFadUYnPKGrtSksV2CKFmS09VH6uEfI2IHM5w3sIJZkD
 2TtzIhaROmXIB/j4MEKq5ML1nv/4QDwnoZ9h7GJfGJK0U2wO4aTt598BMZffcCRS2Tqe7GqccB/
 ckc6j/4y1rIXrraBLFCOdC8Y35VehM5IglXaG/Jdsg/Wtkt8kuSlUgLHw
X-Gm-Gg: ASbGncvcEGlCvIYDPqpulFAyXWC3RVM563b9f45qyfWgfLcgbe9tK7sMRk8osG6xnul
 9w7xaYFw8FpyR4tcma0f3Mru+C192lXTDv8PHoMsN1lILI5z/LwHtOAXVNwiJqYR5NaBcwCvXk/
 e6nDnc2JXMAup/MZWtb+TKa/FXAlJJcM5Ds4XrIW2j81wLQzX7cGqitv8HVVy0vDcLDHUG3rXSx
 I7wR7pB9TwRNfmT9JmDIo97awOkyw1+1Ajeta4DSc4eQy9yf5tcEUoNTkIPCUuhaIL7mM9G8Ska
 ua82va83J3JAhCzYYggi5QwNz4dw64KlGdTTIBbrJo+iQFW+lLjWlhsWU2LgUV++xvi6HRdR88/
 qIEdidjUmXOo=
X-Received: by 2002:a05:600c:4695:b0:450:d4a6:799e with SMTP id
 5b1f17b1804b1-454f4259c7cmr145301395e9.20.1752594011260; 
 Tue, 15 Jul 2025 08:40:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj/GOomg8/tuMfFm6+QQtZ8zHD+1Mr4bMdEvTBuHrv4Wc3OP8vgETy0L8oGZp1WPdBtBd1RA==
X-Received: by 2002:a05:600c:4695:b0:450:d4a6:799e with SMTP id
 5b1f17b1804b1-454f4259c7cmr145301085e9.20.1752594010805; 
 Tue, 15 Jul 2025 08:40:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f844c2dsm93287775e9.0.2025.07.15.08.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 08:40:10 -0700 (PDT)
Message-ID: <efd96b88-284c-4853-93ea-9e1b81b1ffe7@redhat.com>
Date: Tue, 15 Jul 2025 17:40:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/13] virtio: serialize extended features state
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <d0f97a8157c718dcb0799353394e1469153c6b22.1752229731.git.pabeni@redhat.com>
 <08285c9c-f522-4c64-ba3b-4fa533e42962@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <08285c9c-f522-4c64-ba3b-4fa533e42962@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/15/25 9:24 AM, Akihiko Odaki wrote:
> On 2025/07/11 22:02, Paolo Abeni wrote:
>> +     */
>> +    QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_DWORDS != 2);
>> +    if (virtio_128bit_features_needed(vdev)) {
> 
> There is no need to distinguish virtio_128bit_features_needed() and 
> virtio_64bit_features_needed() here.

Double checking I'm reading the above correctly. Are you suggesting to
replace this chunk with something alike:

    if (virtio_64bit_features_needed(vdev)) {
        /* The 64 highest bit has been cleared by the previous
         *  virtio_features_from_u64() and ev.
         * initialized as needed when loading
         * "virtio/128bit_features"*/
        uint64_t *val = vdev->guest_features_array;

        if (virtio_set_128bit_features_nocheck_maybe_co(vdev, val) < 0)
// ...

> For the 32-bit case, it will be simpler to have an array here and use 
> virtio_set_128bit_features_nocheck_maybe_co() instead of having 
> virtio_set_features_nocheck_maybe_co().

Again double checking I'm parsing the above correctly. You are
suggesting to dismiss the  virtio_set_features_nocheck_maybe_co() helper
entirely and use virtio_set_128bit_features_nocheck_maybe_co() even when
only 32bit features are loaded. Am I correct?

Thanks,

Paolo


