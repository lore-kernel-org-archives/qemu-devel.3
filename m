Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2217AC36001
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 04:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twZd6-0006TL-CE; Mon, 24 Mar 2025 00:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1twZcm-0006SU-EP
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 00:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1twZck-0008BB-2F
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 00:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742791273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yBLGfftTqg+5/F8g/qlAFCQ4DoC9wJhalJEYW4TgEtM=;
 b=WPZTDlJKBZJhyLfXATrSlYr9a/5oXW+ALRudfFWo8n4JkzitIPstSP6oeCa57I7TFSKENr
 7vGjIEtUel28aK28wp9o6Q9jGtWyi8qqBk1WwlyaQs4lvBmTOrVep7lKSpvAYQ526sppJ/
 hJ8YdHoYoeLlykLNctrFYFgiX3sveNw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-q-mtdtT9MvGh8v8sXofw1w-1; Mon, 24 Mar 2025 00:41:10 -0400
X-MC-Unique: q-mtdtT9MvGh8v8sXofw1w-1
X-Mimecast-MFC-AGG-ID: q-mtdtT9MvGh8v8sXofw1w_1742791269
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so23906865e9.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 21:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742791269; x=1743396069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBLGfftTqg+5/F8g/qlAFCQ4DoC9wJhalJEYW4TgEtM=;
 b=JWKhYT+piJRl53gC5QFfdJTPEl/NfHJyVor5ShCctq6bgU6FBGoA+uL97gS+P8eLte
 EeYscZGmS17MpmMQtGMRNZpb2pTHmfxlIG+1HHwMBF5B+ReAgr2KFM9AvjPpEc4Wwosh
 fR3yBJFz76eg4/CdswXvRoqcRWdS2JG2mxyeygRKtSAiFUCWtOIbAZEYXQqMk839qRdM
 wD+YMTpzXY8UjBCCFV413emJCyFNdmSPIwiBzKxUv2CITnr8RybocazSIkGe8Kbrrw6d
 0mY0jsFCxO8/xIfuOZmicByK1RYWHAaYPg3Hwu15zcfPLPdlBFPSo0SpzcySICbUrS7z
 LrEA==
X-Gm-Message-State: AOJu0YzRuGilka1zq59LCUK3NS2oVCp6EMwO+DFt65NsKND3o7MpFmM+
 lBYN9OUUUWT6JqAASCjMnwdoCV9a2Z5WNoXAI+EZz7R8bTGrc7rGajGJ1WZITZiv4L6IP6WGlbo
 ScVb6HkwuTGpR9fOO58DRHrpWbXNl6dYvgWNnbNdAaEiQNUe0bbluNm0pJ6tp/8M1HnCykhXQBa
 mGQraBc7LYlNfyAzdL8hiAxGnmyrs=
X-Gm-Gg: ASbGncsf/3gcj+qnMEB2ksPIf+W7FfDUMkmAxwV+0UVo+jTJyhsN/qhIt3Y4+yl/Bb1
 378eayvj80L5ryokFsLp3xHO37KS6VHgsdrR23S0Fbfwhz3DBWdC9wqD960C38VdesKVPrwE1cw
 ==
X-Received: by 2002:a05:600c:3110:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-43d509e2e92mr96525135e9.2.1742791269296; 
 Sun, 23 Mar 2025 21:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH35S/z/H2pbnf/Vv3/z3gYebWEU93UU2Dq13SxoinfoshMfNDiuV4foOpEYkLhLLFnmpOTAIOL9DKpLLpIlvg=
X-Received: by 2002:a05:600c:3110:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-43d509e2e92mr96525015e9.2.1742791268879; Sun, 23 Mar 2025
 21:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-26-clg@redhat.com>
 <CAE8KmOyBghHqFSmW-vbQfe1zvDkDJ8Dkq1FgUdZHXt4dGO9vLA@mail.gmail.com>
 <d64ecace-2a6a-4d5b-8689-5182cd770bb7@redhat.com>
In-Reply-To: <d64ecace-2a6a-4d5b-8689-5182cd770bb7@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 24 Mar 2025 10:10:52 +0530
X-Gm-Features: AQ5f1JrxLAyNcBqYfGifXUTW3W8iUzfnZwKIK3EmlOu6k8zkF3U0wdVe7BBDd1M
Message-ID: <CAE8KmOxi8Vv7=SC_i7rF0t5-tAV-s2WdNLPViVosGj2A+ppRuA@mail.gmail.com>
Subject: Re: [PATCH for-10.1 25/32] vfio: Move vfio_set_migration_error() into
 migration.c
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Fri, 21 Mar 2025 at 15:49, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> So you mean open coding :
>      if (migration_is_running()) {
>          migration_file_set_error(ret, errp);
>      }
> ?

* Yes.

> Yes. I think it is a good idea to limit proliferation of this wrapper.
> Ideally, we wouldn't need to use migration_file_set_error() at all but
> we still have some callback routines not taking an Error **parameter
> unfortunately.
>
> IOMMU notifiers :
>
>    vfio_iommu_map_notify
>    vfio_iommu_map_dirty_notify
>
> MemoryListener handlers :
>
>    vfio_listener_log_global_stop
>    vfio_listener_log_sync
>
> I will send a series removing vfio_migration_set_error() to improve
> error reporting in the dirty tracking handlers. This makes sense,
> thanks for reminding me.

Thank you.
---
  - Prasad


