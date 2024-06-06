Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454A6C25B76
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 00:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0lU-0004nr-6z; Wed, 05 Jun 2024 20:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sF0lS-0004ne-WE
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 20:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sF0lO-00042o-Pl
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 20:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717632833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cBF5lKLfszxqcj2PxkBMGmgVn9fTGYfSNsTrr70M74=;
 b=Vtn08PQyKZjP4RoGrRu/CB+6FyAYVhB3EIf5Ign8kxR2R0Yib1VAqVBae/GmHxSUJmZ45J
 0vk9wGJAn7l/9Z76wFbDh4tGwhiI1ZxOaKly7zhVzz70dvB8W7mdJbg7I2rMMmg3/FqUqz
 fJJ0s9Ceo/MVtAHC5U7FvqzvM5Pw+L0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-lmwLSAi9O9ihG9PU8H49Ig-1; Wed, 05 Jun 2024 20:13:52 -0400
X-MC-Unique: lmwLSAi9O9ihG9PU8H49Ig-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c1b396d80aso350469a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 17:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717632830; x=1718237630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cBF5lKLfszxqcj2PxkBMGmgVn9fTGYfSNsTrr70M74=;
 b=aGhQaiqxtg/4T4DB6hGpzqyRCNQznI5kn7YGMJ//1ujxLinx/u+RtpZW5rVpfbKE6c
 jI56qxl/c1u5BZ/1/9s9wwy+QoDNuJpzKXKLhJxwibfVt+zBNOdyV6Fis4ezAxXW8veR
 c4l/dBvRfnnwvCVKWchsQBMSB9hHXyqtvBwvgPcgdMfjZ8t2m7/l6q3wj/OL5oI++4pi
 A/Glx+006z4ZvzEYD3YfEgCiTdITYgExIf6PQf7cm6UfU8//KGGdLqjaYfLO8WoueWia
 EG6tfdE62V1uT54hgUbNM/MkkMcPTk8PClEC/MX19o0DZsm18PUh/w7IA1tKfA0ddWdJ
 Qu7Q==
X-Gm-Message-State: AOJu0Yx4Cqh+YvHDj6nsK25LtZJsj0Mq3gHKtEOCKw1gZqX5Cphp8hAS
 McJITL2nd4v6dOtSJx381+BIYaRQgMl1stNVwdsbL8orQjMV5dcznfuzVRqH5lsFSLit7NyiC1u
 jFKz5ItF5werrMQelpihb2DYZTRPG2Ey8Saq8Ey/dQvJl1DGALXwaVUKCN5IUnE9IrIA3ZAzxLn
 9qFSP+xUqE7qf1G9qO8EOzbq4MCymGiGGo+QMGkA==
X-Received: by 2002:a17:90a:db92:b0:2c1:ad67:f1a1 with SMTP id
 98e67ed59e1d1-2c27db670e7mr4192512a91.46.1717632830667; 
 Wed, 05 Jun 2024 17:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwblU+CMFT0Pw6C6gj6ySIpucF/lHolU3YxxG0Xba9x1Tc5XVVr6/M15UHCFqgKIR2UiRNQTHpj1vTXB7ZsDo=
X-Received: by 2002:a17:90a:db92:b0:2c1:ad67:f1a1 with SMTP id
 98e67ed59e1d1-2c27db670e7mr4192495a91.46.1717632830226; Wed, 05 Jun 2024
 17:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240604073755.1859-1-jasowang@redhat.com>
 <40b59ff0-e3ff-4631-aac2-83a3214d28b6@tls.msk.ru>
In-Reply-To: <40b59ff0-e3ff-4631-aac2-83a3214d28b6@tls.msk.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 08:13:39 +0800
Message-ID: <CACGkMEu8BLLkTfpryrv_t+VhTvxLKyA++9q4shZdwdhfLMUgqw@mail.gmail.com>
Subject: Re: [PULL 00/20] Net patches
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 5, 2024 at 6:14=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 04.06.2024 10:37, Jason Wang wrote:
> > Akihiko Odaki (18):
> >        tap: Remove tap_probe_vnet_hdr_len()
> >        tap: Remove qemu_using_vnet_hdr()
> >        net: Move virtio-net header length assertion
> >        net: Remove receive_raw()
> >        tap: Call tap_receive_iov() from tap_receive()
> >        tap: Shrink zeroed virtio-net header
> >        virtio-net: Do not propagate ebpf-rss-fds errors
> >        virtio-net: Add only one queue pair when realizing
> >        virtio-net: Copy header only when necessary
> >        virtio-net: Shrink header byte swapping buffer
> >        virtio-net: Disable RSS on reset
> >        virtio-net: Unify the logic to update NIC state for RSS
> >        virtio-net: Always set populate_hash
> >        virtio-net: Do not write hashes to peer buffer
> >        ebpf: Fix RSS error handling
> >        ebpf: Return 0 when configuration fails
> >        ebpf: Refactor tun_rss_steering_prog()
> >        ebpf: Add a separate target for skeleton
> >
> > Alexey Dobriyan (1):
> >        virtio-net: drop too short packets early
> >
> > Andrew Melnychenko (1):
> >        ebpf: Added traces back. Changed source set for eBPF to 'system'=
.
>
> Is there anything in there for qemu-stable?
> (NOT picking up without explicit mention of stable)

One candidate might be "virtio-net: drop too short packets early".

Thanks

>
> Thanks,
>
> /mjt
> --
> GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
> New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D=
98 ECDF 2C8E
> Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0=
A0 8044 65C5
> Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt
>


