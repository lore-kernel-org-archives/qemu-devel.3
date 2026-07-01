Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F7FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weoYp-0005Ed-T7; Wed, 01 Jul 2026 02:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1weoYg-0005Db-NM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1weoYe-0002wY-0f
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782887786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpHduVCKoV1yMJ5bTEQfP38wjMLVg2uUlOX0m9d5Rck=;
 b=Mh8TKi9ByP3uESRK+cRMI8jzTN+ELn6vmZGD/PPAchVBkAAPuAThcRV3CLmMdXfWNhjRwI
 0esMYwf3aHmbihp/+2pyJlcvJ5eXRgSxywucRxFAx2mUEFnF27Dul7R6kZDrWIhj8bIKIv
 +0nAxy8CIXsiqQ7owD2ndZl2OwIEulE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-TosnNVsgNomnL74LfZTbsg-1; Wed, 01 Jul 2026 02:36:24 -0400
X-MC-Unique: TosnNVsgNomnL74LfZTbsg-1
X-Mimecast-MFC-AGG-ID: TosnNVsgNomnL74LfZTbsg_1782887782
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-472bdd6f529so159354f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 23:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782887782; x=1783492582; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mpHduVCKoV1yMJ5bTEQfP38wjMLVg2uUlOX0m9d5Rck=;
 b=LNlgn26LCXTqZRHZMTj9Y3Pl9UWZdeVZcQkyqmrbWGeTvyd8AUeXNk4a+4LNPReYbe
 DtN551lXtukdnOd/n/kefOYJD5enqrqJtt5uEXLdhT5lSbn1ItaFgderRxdMuYTa8o6P
 jnLM+jj+fG5CxnWysCwkD2qVfROcufIV9CRxqm8LZyC+kcVtqjfB5XXM9mWM7VkpXCcL
 wS4teizavzuha0rUOSH9bBH1pBAxkh7nz4YSKSl3CrwLWGwcvvZVSE1jkC/A/Akt7DhI
 6k3TMMjtI23lCdD2of8e3R3y25O0t2SkYFfTPN8X3rjhzw+QajDJJJPAMjIWQNjASh6u
 7YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782887782; x=1783492582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpHduVCKoV1yMJ5bTEQfP38wjMLVg2uUlOX0m9d5Rck=;
 b=lI+6Eis4KuyMf2eFSkTLYc7Q3zxCUhu9+bUeOb5UhR53nbqaBLgurIOT5o5IM9Q+Ql
 og7ktGN9etpGICWsLPTueSAqx1cLe08P0vdl0hfx0lnQrPBg0p3GZxRhIQC7EyMlG6z+
 eB4IUL7gPou/BFVcooQdvU5Kv0ELi7G8IlHIwJDc1NSi37ZAedf2N1sPv+zUa0GwUfoH
 V2gkk1NMMQN9iQYC1ZajWIp00VSffc7rOgbEH/2yNS5ItEZn40/c/wqYZmOzH0DOokno
 E54w8p/AcoGQj2pMeanzy10pLMLM2pSNfBwFVw8tpoDJ8fS4+ljdaJvXc0Nfrw/16Qsl
 Ozrg==
X-Gm-Message-State: AOJu0YyAxSojyHzUF6bWDJlr+HbiTDP0fs/8zZBtR2vxEpM6V8wfLgBG
 yfTaHBJH4pRa02ERDYpVhuUVazoS4066pCr8U1rzPDbzC9pvoZkbAQUBMeXQX2WtH2ne/JpE+Ua
 5b+C/rCYi2vCejafCQuUf8wVD1ujWfRPmipmhc3Q2QByHT9FDNcGawUYt
X-Gm-Gg: AfdE7cn5NIrFHBfaV72FBDmUhGv1w0PgTSH+Ipa55yLY7wYA41F5syd2AgRjz35K1ip
 O13BG3EzJkdN62SOgwrISC4zg20hasSXuFYzUnw5ro9R5yFu1TsMH4OwvvgiW3eHdhnZoLlC7n7
 7jVPbNGuePeDKIVnI4aoWRhZZQGiNTWz+/oykWv8ZTreym2+h7mBPydCeZVhDspJa/veJtcpqR/
 S61sAdjCVlu1uNvrNl+CByRKnZ7fA+CzxMxZaZzwhjEfFTbpW6FSFwLdSxhkY9dRcu1hTOvvsJM
 Vrn7QdHqYZsSUdQ9r1ZzUMu4IjqKrn65NkxyVwWvLxBUDt5fKI+snT7lJgrj9BNoqaNlpIzqqMg
 BPNG8Fg9Rg4klCW7ReOCYb2VttsRna71X
X-Received: by 2002:a05:600d:c:b0:493:bc31:b2ae with SMTP id
 5b1f17b1804b1-493c2b4431amr4030345e9.10.1782887782366; 
 Tue, 30 Jun 2026 23:36:22 -0700 (PDT)
X-Received: by 2002:a05:600d:c:b0:493:bc31:b2ae with SMTP id
 5b1f17b1804b1-493c2b4431amr4030055e9.10.1782887781845; 
 Tue, 30 Jun 2026 23:36:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4540aesm51732175e9.0.2026.06.30.23.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 23:36:20 -0700 (PDT)
Date: Wed, 1 Jul 2026 02:36:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: qemu-devel@nongnu.org, sarunkod@amd.com, qemu@demindiro.com,
 imammedo@redhat.com, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Subject: Re: [PATCH 0/5] amd_iommu fixes staged for 11.1
Message-ID: <20260701023508-mutt-send-email-mst@kernel.org>
References: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
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

On Tue, Jun 30, 2026 at 10:08:01PM +0000, Alejandro Jimenez wrote:
> Hi Michael,
> 
> I have staged these recently reviewed AMD vIOMMU fixes for 11.1:
> 
> https://github.com/aljimenezb/qemu/commits/amdvi-next
> Base: 30e8a06b64aa ("Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging")
> Tip:  018c1dfb3e8c ("amd_iommu: Fix endianness handling for command buffer entries")
> 
> Patch 1 is an independent fix previously posted at:
> https://lore.kernel.org/qemu-devel/20260616174620.438468-1-alejandro.j.jimenez@oracle.com/
> 
> Patches 2-5 address a Coverity finding and big-endian portability
> issues. They were reviewed in:
> https://lore.kernel.org/qemu-devel/20260624195925.1254462-1-alejandro.j.jimenez@oracle.com/

Great, I'm applying these. Thanks!


> 
> I did basic smoke testing on an AMD Zen4 host using the AMD vIOMMU device.
> Completed several guest boot and reboot cycles with xtsup both enabled and
> disabled. No regressions were observed in guest startup or reboot behavior.
> 
> There are two other outstanding series pending review, but I am unlikely to
> complete review/testing by myself for those before the upcoming soft-freeze
> deadline.
> 
> Thank you,
> Alejandro


To be frank, these are bugfixes and such changes are okay after soft freeze. Thanks!

> Alejandro Jimenez (4):
>   amd_iommu: Return int from page walk status helpers
>   amd_iommu: Decode XT interrupt control register without bitfields
>   amd_iommu: Decode IRTEs without bitfields
>   amd_iommu: Fix endianness handling for command buffer entries
> 
> David Hoppenbrouwers (1):
>   amd_iommu: Fix opcode reported in invalid command handling
> 
>  hw/i386/amd_iommu.c | 168 +++++++++++++++++++++++++++++++-------------
>  hw/i386/amd_iommu.h |  63 -----------------
>  2 files changed, 120 insertions(+), 111 deletions(-)
> 
> 
> base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
> -- 
> 2.47.3


