Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B2BC54FD3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 13:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtQgb-0007Fe-QT; Fri, 20 Feb 2026 08:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtQgZ-0007FR-Jn
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 08:36:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtQgR-0001CO-8R
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 08:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771594597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M5FFCp8Z9V7kFvZ86LjQvLc5C+9jxNQJij/1dWNspq8=;
 b=Dn9LIEaunGrYn4JvX5TLPxvVJEEuH2ij41bI3J386g82iG4FYYrvs7X0h2r4sicy8znmDZ
 VDvRtBF6wgyZX1+l5DvkBbqhykbSxwbMrLx8c3f/QPN0dppE1e2JW8SfT39de+kHICvgB2
 wx16ukCgW7L17NiaojaidKbNM1j7UHg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-VCuoo5u7Ow21MtfDJDxeIw-1; Fri, 20 Feb 2026 08:36:36 -0500
X-MC-Unique: VCuoo5u7Ow21MtfDJDxeIw-1
X-Mimecast-MFC-AGG-ID: VCuoo5u7Ow21MtfDJDxeIw_1771594595
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48071615686so22319865e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 05:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771594594; x=1772199394; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M5FFCp8Z9V7kFvZ86LjQvLc5C+9jxNQJij/1dWNspq8=;
 b=qIJeroo287DMsXa2Jadg0+dRsPh7lRwar3iRz2XD5PJhbaoLp9n1oAa5aiR3C2GLWS
 DgOiQ4GdBGlSsE4BCq/K7729IETpuQqe94NTBix/mEwzIGoYFdt78YRzbpoYWdp9QnNC
 pmaf4bLlKEdNcetspm63VLtijCQYwXTg8u2IwdgU6eu6PBo4nlYIYkXsA+xobgN6mNin
 mG8gG9TeskfquTPJBXzPh5SCSqSLWK7Fhfzh8eivXBi/F/rCYeqA00HQiAK7XU2No03e
 HAGtgK1YoHHfewTJUNCg7rVCUiAFdS3CpTFjYzDodZ2B+66ss1egUzXs3bmwoEm/x2Dg
 2TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771594594; x=1772199394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5FFCp8Z9V7kFvZ86LjQvLc5C+9jxNQJij/1dWNspq8=;
 b=bvTvGeOsZ36UcFFVXCj8+dE56aQE2ObCxwfMol2T1g9UiRfq1WoHGYpExNr5tyByNX
 MpFQByGJvmkRMJf8DPBJsagxBNW+nbG6A7uRIIRVDX4WkBch9G/3oa26xQOXUvNtAOEM
 7yCna2iWSXtiEAOO8wcZS/CmgchSpTY3Tar/wS3AIfwxdAFg3WUGPidDffPBUb+giHF2
 kka4bLnjGd4fqoc61Ll9cgIUTX6E/X0gwpzQpyfRqGfPL9/Y2KCbf2NSbaXy5pKVu5FQ
 dsepveozbDQ2jkgsB7o8YRsG5T4Ezpv5lwXEZrCP9Zcrtgd4GjJMth6yDQPaBw2EXpai
 JKjA==
X-Gm-Message-State: AOJu0YwVEmGPcu9DLUfYVdarYQ/oVnQ86TnbzprE87mzjpXq8AqC2yw2
 hKntgUczj3EuJzvPlEjjIfgBDhGUzyxXh6QFr88GkhisMpBeedco2Rg/DlL2HvgebsAB9jUlolt
 oQtOtQev8lcB1Kdi/g5FClIXnKyF+niqvBuk6frpFUwPObVfOSo2l8F09Xz9szTcU
X-Gm-Gg: AZuq6aJZYU8cvOcqFJ6I2yNC6BPn9frk8Et50y7n9HOBe+PDPIaK9SubJEP2KrED3Mv
 KZG/s1qJnPVdSZMciTpLDPgsUrMZ8xx7uePehzbRIFzSLqyV7SCXWxTZn14IsZYvRuBLEtihnx8
 2XMyPivYzx5H0fNeTTVVFDl8FjTXFGqT5yzG5rNDSWlKP3vlk8SHOgQTfORPL+07wlfZGEG0QQF
 2ymXQ0J8plgsFmNjGGFC9mNETF7WWzwTVEhl8jDmvbm41ffHQLwZPnDh5/9cCnp+Xs9FpvURX5+
 6+2kGlogQVVJbg4jLmCqCt1f+2+c+0jMbB08WPfHTdfN1U20ybxOKWAnsM1eGYUgrH4O9qbJKA6
 4gfvLXZWv9kv5nXiISJNfeqI75dCiRehk3QkM7+N3UbQGdA==
X-Received: by 2002:a05:600c:c176:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-48398a4267dmr158168075e9.1.1771594594469; 
 Fri, 20 Feb 2026 05:36:34 -0800 (PST)
X-Received: by 2002:a05:600c:c176:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-48398a4267dmr158167245e9.1.1771594593900; 
 Fri, 20 Feb 2026 05:36:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31bfef4sm113165115e9.7.2026.02.20.05.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 05:36:33 -0800 (PST)
Date: Fri, 20 Feb 2026 08:36:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Subject: Re: [PATCH v2] vhost: fix vhost_inflight_buffer_pre_load
Message-ID: <20260220083623-mutt-send-email-mst@kernel.org>
References: <20260220094800.276489-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220094800.276489-1-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 20, 2026 at 02:48:01PM +0500, Alexandr Moshkov wrote:
> While I was rebasing my series about inflight migration, I missed a
> small issue in vhost_inflight_buffer_preload:
> 
> * fix wrong return type in function
> * fix error check
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Fixes: tag pls?

> ---
>  hw/virtio/vhost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 52801c1796..f83bdcaf8b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1926,8 +1926,8 @@ static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
>      void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
>                                    F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
>                                    &fd, errp);
> -    if (*errp) {
> -        return -ENOMEM;
> +    if (!addr) {
> +        return false;
>      }
>  
>      inflight->offset = 0;
> -- 
> 2.34.1


