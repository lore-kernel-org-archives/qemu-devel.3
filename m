Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972F9CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBdK4-0003ng-H4; Tue, 29 Sep 2026 15:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBdJr-0003lR-FQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 15:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBdJp-00051Y-VT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 15:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790709408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zr4ttoSXHNg6/T4ZIV3Yen6JhtgWktUSl1HfXjwFSms=;
 b=jQLROIIobwf4qsHem4CULwa8B7Lxrv/Ju1m0EGJppz8ae0D7bKvYn9JoNtZep59dDShtfe
 Ad1tF5YQEC1PE6nVkEfypNl+QH8gXG5IgyDXyb5+NI7zeN91fIRHJQ+jkhxE6ZwVIT/d6m
 xHj2K6DhyM2EQirOSHSeYi1QuNXiTgQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-h6nT0TNLNmK4X7diZqXU2A-1; Tue, 29 Sep 2026 15:16:46 -0400
X-MC-Unique: h6nT0TNLNmK4X7diZqXU2A-1
X-Mimecast-MFC-AGG-ID: h6nT0TNLNmK4X7diZqXU2A_1790709406
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53310b75674so89884761cf.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790709406; x=1791314206; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zr4ttoSXHNg6/T4ZIV3Yen6JhtgWktUSl1HfXjwFSms=;
 b=iI+SbUVG+HPbOPCBgr84J1s/pHIYNFUlMrpLSuKdUHt1/kcIEtWfnKjx81D+PYisGF
 vyaKD7HQg1liqZEZh0xkdjNqQnwjKjkNaTrJWY1X78N/7R5jXYIohbnncm3qqmmzThIh
 gxGIX6DjMqf1uEihGMDx+Qe0n7ArsXob9nca6XZJhPkfeox5UiCCneXVvrsxO/q4tKSM
 mzbB60T8UwY8/tK+8U54NqNGptUcDIy/ADHtoEZcelCkgzefUeKZuH0vDPlYCnH14thG
 Gkze9YpN0lEW/Dn+yondWCC3mNNAoGO6yL+bAtfjIvqghR/ud1ZL8b9z+7v5aI0mqn4o
 QZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790709406; x=1791314206;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zr4ttoSXHNg6/T4ZIV3Yen6JhtgWktUSl1HfXjwFSms=;
 b=2U2+yLfSPLDeEIRacaagEYPz/FrDeIXU3XGdWkIbeyKp7rbJJPff6H9FYq8yb6b0e4
 F2vSAVXuNQjTXTY9eZzrOzQof4Y8FwGExBC17exNovxiFwSoUIIPTAH3ftN2Y2uyy+w0
 OO3k5RYvkeKCsNIwddBqMtlSzrPXGYSACZmRQZeEFSjVa/vvel0hS/0MpxFF0sT4TtC+
 pWr3t9LWSqlNzTh9jxN4rWE06wfMCdya8SRJQLlTW8aO3KkdRzf229THtuMzler5Dw5f
 noyq0YIWrzd1UwxuY792TBHX4nMA6Eb19CtOGRuPZo5tlKWsWqBualL+OEbTD5cW7fXl
 UB0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5f3ChgD5RfdPXy0ALfTKHUDRonS6sXZpfPO2C6iy2Rf4qpLAkuf1IugCKaeVWHa3IK7NH2uDD5afv@nongnu.org
X-Gm-Message-State: AFuF++mGaIzpbjyyyk+5nYoYt492/peognEtyi/eErWPCNu3KAe6GD2a
 h9o0UZjd6Ir+A7xb0tv4kl6k3eFFBuwFhWAn+5Rn806L80QmMvOrg5M5QQT1QB3VPpgkGW74pw6
 gCLKv38OxA1h9yHyscleFgQcp9QU1Gxt15Tv+JUcs5/0RWYEOhq+A2Tbt
X-Gm-Gg: AYBFou3NOtdDqLr6fWBptSKzoTHs0CN8h+4hyQJ8osrv9awDs1YZX/6E1Sq8wHtphxF
 q1JTzYSVnwQES29FFAapI0KZpeQYZ+ZiI4VG9pGmQJgPB97QKyCpWbLldHHQhGRQrgcCrMz4Xnf
 epW6kUrtWU8VKt5hEJyYvKF2XUvIsPdqn9aiPcA4wvJFVeNBzFWeaJ39dPp8KVo6A7UpaUWfvVL
 g/fRVTy/6xUP/o1vUEvaeq0hkNwVnmOPmd1d1AyG1kL56a5k4AnGa5PEmKt6Q7Tfa4OIYgsAjGq
 24eO1qmEigtZRTiRS64ztHuTqzsmztr3C6xFXJSx8MgonJOtvJTkJrNvgYehNF9UOzmj5Ok=
X-Received: by 2002:ac8:5a0d:0:b0:531:e1:6fcc with SMTP id
 d75a77b69052e-5336a2f53b6mr5164011cf.14.1790709406066; 
 Tue, 29 Sep 2026 12:16:46 -0700 (PDT)
X-Received: by 2002:ac8:5a0d:0:b0:531:e1:6fcc with SMTP id
 d75a77b69052e-5336a2f53b6mr5163511cf.14.1790709405482; 
 Tue, 29 Sep 2026 12:16:45 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53369988e00sm2656471cf.2.2026.09.29.12.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 12:16:44 -0700 (PDT)
Date: Tue, 29 Sep 2026 15:16:39 -0400
From: Peter Xu <peterx@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 clg@redhat.com, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, sgarzare@redhat.com,
 bchaney@akamai.com, dongli.zhang@oracle.com, Paul Durrant <paul@xen.org>
Subject: Re: [PATCH v8 04/17] migration: forbid snapshots under Xen
Message-ID: <arwOl9OvOlXJTtwS@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-4-12bcf1c0b84a@virtuozzo.com>
 <arwCADGhCZenoYke@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <b7d2302dfa4b48480e45423ffaceb93ce2239e7b.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7d2302dfa4b48480e45423ffaceb93ce2239e7b.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 29, 2026 at 07:34:50PM +0100, David Woodhouse wrote:
> On Tue, 2026-09-29 at 14:22 -0400, Peter Xu wrote:
> > On Tue, Sep 29, 2026 at 08:23:23PM +0300, Andrey Drobyshev wrote:
> > > The snapshot RAM-saving path does not support Xen's memory mappings.
> > > Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
> > > same way they are refused for CPR migration modes.
> > > 
> > > Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > 
> > Acked-by: Peter Xu <peterx@redhat.com>
> > 
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Paul Durrant <paul@xen.org>
> 
> Hm, but surely if QEMU is running as a device model for a Xen domain,
> all it should be saving and restoring is that device model. It's then
> up to Xen and its toolstack to migrate the domain and its memory.
> 
> We've had guest-transparent live migration working on Xen, as well as
> in-place update of QEMU on the same host. Surely all of those require
> save/load support?

Looks like I was wise copying more people..

I knew Xen had qmp_xen_save_devices_state(), I was thinking that is the
save support wiring together with Xen's facilities.

I confess I never know what is the load support, and I was taking it for
granted RAM was managed elsewhere, so load perhaps the same.

So I suppose this is still a question to the author, or maybe Akihiko?

Thanks,

-- 
Peter Xu


