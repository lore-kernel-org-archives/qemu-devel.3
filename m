Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76940CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPO8q-00059r-TH; Tue, 19 May 2026 13:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPO8l-00057w-Nj
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPO8k-0001Yc-A6
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779211317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HxUKMicxQL8qvyB9Q0NbwN0ADL4uiQ0R8pX4AUVPcK8=;
 b=QGQLfzYy+0m8OpIc/BuzoDnzLUsP0g8asdei9Q9yhaQiuuM3D7+6X45GBrHbkSIt9+zdG2
 5CRwOV3NQF28Q/UR1jwYOsTasjP12Cmc4huyYok2HFDhCUEiHf0dAjtKAYqatmLIfImfE/
 23emYRZ/w/7OMIO3ijA6l+fKD4VGo8Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-Q4BB8wfdO2-jKNxIYXgVNg-1; Tue, 19 May 2026 13:21:55 -0400
X-MC-Unique: Q4BB8wfdO2-jKNxIYXgVNg-1
X-Mimecast-MFC-AGG-ID: Q4BB8wfdO2-jKNxIYXgVNg_1779211315
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-90f5248b209so922614885a.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779211314; x=1779816114; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HxUKMicxQL8qvyB9Q0NbwN0ADL4uiQ0R8pX4AUVPcK8=;
 b=DRXye4/NwUGvP0FjL6NBrr+HO9Kf41d5c9EEP0MYHDEEVu9EsMrx+uVHHfiWlA7vfO
 o9yPUoDZqm7U1JedO8cbxcIzxMMQsDA+10nW6QGY/KgMLd7wLP5i8X8HX3Vf4Hjf+eDk
 +Dq9bgdYcyTtZ7XKQs6vcd5aPFrAzBqMAJatTy1J8+f3VEq0xKz/QbtLmPJ2580qI+En
 WkArRP7HZ3eryd17NG79bXOPd27dwwzkLnZujF+yLOEiRieylPGoDTrh2MpL3gcdijQX
 WxuiUI47aghcgetku3uOO204FWKbzx37kJvEaAAKtC3Q5DlvB7k6suNQ/gX0667ILZqn
 6GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211314; x=1779816114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxUKMicxQL8qvyB9Q0NbwN0ADL4uiQ0R8pX4AUVPcK8=;
 b=pc4ZU0hOa8/YbGCp0irl2klYMKwL3945wCTO4PwjGjiK0unLeNL4ydPkQMV0BtYQ89
 OEJah0tdC8iVj/aXa3b1T4G2TzCH9HeThxIzJt96fdVv5xpgsZqMMGn4owv0PahkjaD8
 vqi1qemStR8FcvmFqdjL/dD+YeuUizr0vk1jDrur+W7qxI2YbEdTzGc8y9GzSlCYVGWu
 LLg+Nz4ZcPajp17du/Lw3lU+pU8E+B9bIz2XAX3qgi2raMtVXzoQ0HqoqFQNA9ti7chJ
 iiVU8XYU0vx9TWcD4LKcf+gaQLkuEw+eHvKOH2oumvF1SeYucj5mhNFqBBgRwExEi79R
 P0OA==
X-Gm-Message-State: AOJu0Yzt8dWYX++2yLfj/w8HR/xSLAgHaMtw/AZ70ODKXyHiAdFDqCJD
 5jygkyO7/9b7s2s+fwpal806xuvZ9Yrc5HMClICnCysec84Zy6bjTL2h37VVd7R51D9A6JI7HYy
 RBWaMq9hl+zm5SfXTGGCnr0ZxYn7gIzWo27Gc8FKuFM8n5xD2zhAuEsXJcZidFJUB
X-Gm-Gg: Acq92OGag/pvAsTDbCczc2av0XQVuV6w6o2KVwBZnia8nL8CItcJA493Iy/5cfHkLwc
 2K4qXN2ViTEmROKRQ/4U7FLGAp7fbzkuleqhLukukt2k9YW2j1CV2TDEACD/xHahVwCC3/Dt/Az
 pSHK4bvxvkvWcg5lnhZuE3fZKwGhgRtjb1/xVowuBPYtMJobiRYTFflJOFda9XEdw/Hsv/wqqu7
 gzd0FGSQT3Yi7/vrGBfywltqz0NahZZkwiiIChWyPTLpj6DDj5GwYmR6zySCiNMgOoCbfEiFPNJ
 mpVN5+oz+OKCKyj9Gg2xtmsBWA8Es3lZlJRY/tzByGQfgrCZKDuVDn98+6Xs9dx3/nnCzSJyJoT
 Jdwd0P2M8B5swFTR3dLBz1V5Gc4KDj9bYtE3xRE5W+4HFiwc=
X-Received: by 2002:a05:620a:17a1:b0:90f:c88d:ebb9 with SMTP id
 af79cd13be357-911cda50ab4mr3111870785a.13.1779211314370; 
 Tue, 19 May 2026 10:21:54 -0700 (PDT)
X-Received: by 2002:a05:620a:17a1:b0:90f:c88d:ebb9 with SMTP id
 af79cd13be357-911cda50ab4mr3111863585a.13.1779211313719; 
 Tue, 19 May 2026 10:21:53 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bab3ad15sm1874488785a.16.2026.05.19.10.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 10:21:53 -0700 (PDT)
Date: Tue, 19 May 2026 13:21:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Klaus Jensen <its@irrelevant.dk>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v7 1/8] tests/functional/migration: add VM
 launch/configure hooks
Message-ID: <agycLqsUoEautDQ6@x1.local>
References: <20260511151131.483217-1-alexander@mihalicyn.com>
 <20260511151131.483217-2-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511151131.483217-2-alexander@mihalicyn.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 11, 2026 at 05:11:24PM +0200, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> 
> Introduce configure_machine, launch_source_vm and assert_dest_vm
> methods to allow child classes to override some pieces of
> source/dest VMs creation, start and check logic.
> 
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


