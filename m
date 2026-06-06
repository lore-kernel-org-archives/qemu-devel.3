Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADF7CD8C8B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 08:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVmWs-0001Ji-BJ; Sat, 06 Jun 2026 04:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVmWq-0001JG-Rd
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 04:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVmWp-0007mj-4f
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 04:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780735033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=etH7cFrA4S8E/jy0w/VD1BAxngru3JhvFHHGHpGeRnw=;
 b=Tx0ZKEftAdJdGlEzjNi9iTnwRlmCvQ6uzkU664zx5SKUMm3UBxq4E8Fi7onUhUkQGoXxYe
 EK183QUbvI9wzAtm7pfbyVFx70xaID5OVivNGXARDBNcuZk50oNzZR4c2v7CVUByG9sdlM
 gH2hJ1+RmuGuxLCctZgswf+Qbz9fICg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-MskJBaA-MqaJYN855Mn8Ug-1; Sat, 06 Jun 2026 04:37:11 -0400
X-MC-Unique: MskJBaA-MqaJYN855Mn8Ug-1
X-Mimecast-MFC-AGG-ID: MskJBaA-MqaJYN855Mn8Ug_1780735030
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eee3f9f03so2473336f8f.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2026 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780735030; x=1781339830; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=etH7cFrA4S8E/jy0w/VD1BAxngru3JhvFHHGHpGeRnw=;
 b=Ct+cYJmPqDnn3koa4QIW5OYfOaCiJmPTje1SrYtdqRCPZoRvdtF4kru91q2qhsZ5Bn
 ehBgO7Dyrfz1+zcAxN1QxBC7YjmlWLuNAgdxpTySluCWZ2+dsEF883OtOJEl1tS4EvqC
 Kzw/Ct7/t5SsqTUYWtezic6wRkv3kFzhJHi68SENgOm9XOAeynEOSFnYZ2mCQ4B2l0Kb
 arXDl/gFg0q9gi7DQ6/DSDlDbbETE5kgxyFqc7yYaMFqIgpZ7xUA7j7PylHMKyrXO0CX
 Rxwth0Cb4BkN+reO+ESda+b1bQ9dcx63y4ha/QSQFFzVS3Zki/tY93GWfmUvnMEdBwWi
 oCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780735030; x=1781339830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etH7cFrA4S8E/jy0w/VD1BAxngru3JhvFHHGHpGeRnw=;
 b=MXPhftslvnwBKnOuBHyvrtM9uYpDyIsNJhlHZ0My4EzSdj75Ep17fMViHiZQAG2oDi
 rfOJKvI3Zr+nxkpql6lSCt1NvUUnSwKVzhh5SPMgm3QlrYOP/PpPDlMrt6ruoYvhKayw
 WXAjTT/dQ/YXqYefVJjFTrSh3MW3tJVNr8AEu9uDcvsIl/oAlzI8aldZGdIYj27JsRL8
 sOWvKPcO+76jMajfLIURJ7l2XxxLlnLoYo0GtKPVV9mZBp7vIzJUAYYETaQwNYpv143p
 XYU26ShD4GO0dNCMeI3QG1UMJB9MXDW0ypDSiXKoSU6Bw0Sk3w/1SCd28B+BB+ky7Qaa
 fQhA==
X-Gm-Message-State: AOJu0YxStYG6bvxLg0/Gzgm0Gsaln7Lvk/lPn2/zD6y0hr1dBUXGZ8hD
 bVQoC5TgE3pECuY2/bD8hrYKR9P7lmEv7WgOsPnbbKiKj3va7Xfb4lOhb+buF2tpr+Foxl0DkSi
 GuumgMHaNh/R45dAJahP8FtuWc1tXSd2AB6z++dq/Lp/R7H/DK3dZaRaB
X-Gm-Gg: Acq92OH/fiJ/nqBdgqLhskKoRD2Tc4Lx46XfoBhmsjH0NdP22ZMa4efNFalpAY0AFBD
 REYcalR+d2CpOX700BEJLYzmf++XVq6uS8N7KYlydNWijNjVQ9hCBsJGfJJ6fVZLgw1ADHBu0xU
 YpJ9+fRoH0cbWTjXckJW1Wu1/cP8cXlkytnmTyG69m7HZ6dC46ZSAaLcon76Z9hQKj34Tqztiyr
 xQw3rV3DAb5Aj1rVRZkkOp++LLiXiI53M2MowsySce+VWlE24v/KL1ZWmRl2J/bvdeLyiq+SDKm
 FKiuBuyGro8JBeM2+dOKGWl33PMrPGSvbgMyfwlFmPRRf+sfkx/iSUIt6PMNtq1mg604NmjCjbM
 O066ui10g3R2dzcK6jZ91n/E=
X-Received: by 2002:a5d:4811:0:b0:45e:7997:8b7a with SMTP id
 ffacd0b85a97d-460302e8170mr8455557f8f.16.1780735030221; 
 Sat, 06 Jun 2026 01:37:10 -0700 (PDT)
X-Received: by 2002:a5d:4811:0:b0:45e:7997:8b7a with SMTP id
 ffacd0b85a97d-460302e8170mr8455523f8f.16.1780735029665; 
 Sat, 06 Jun 2026 01:37:09 -0700 (PDT)
Received: from redhat.com ([31.152.37.159]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dcbdsm22687480f8f.7.2026.06.06.01.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 01:37:08 -0700 (PDT)
Date: Sat, 6 Jun 2026 04:37:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: helei <lhestz@163.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, zhenwei.pi@linux.dev
Subject: Re: [PATCH 0/1] hw/virtio-crypto: add akcipher keylen validation
Message-ID: <20260606043251-mutt-send-email-mst@kernel.org>
References: <20260606074756.43804-1-lhestz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606074756.43804-1-lhestz@163.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jun 06, 2026 at 03:47:55PM +0800, helei wrote:
> The virtio-crypto spec does not dictate a maximum length limit for 
> asymmetric cipher (akcipher) keys. We added a hard limit which mirrors
> the linux kernels's internal limit for akcipher keys (see 
> keyctl framework and the add_key syscall).

We have max_size - doesn't that apply?
backends/cryptodev-builtin.c actually sets it:
backends/cryptodev-builtin.c:#define CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE  (1024 * 1024)
backends/cryptodev-builtin.c:    backend->conf.max_size = CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE;



> Maybe we should update the virtio-spec and add a max_akcipher_key_len
> field for virtio crypto devices.

maybe

> 
> helei (1):
>   hw/virtio-crypto: enforce max akcipher key length
> 
>  hw/virtio/virtio-crypto.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> -- 
> 2.43.0


