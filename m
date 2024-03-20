Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99989C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxiZ-0003vP-PE; Wed, 20 Mar 2024 11:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmxiY-0003vA-Kn
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmxiV-0000ex-NJ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710947937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2DvitvJUAGQ+uBsIXNwcAKXy9/+kL0SU0v8MLPW744=;
 b=cbPI//N5XDlJFtuAdFX937qVYzi2C1kchSodgU1j2LIsH82MWq2dlBiVIPLYAAQKuw32M6
 F47imKviw18OCt3R8nTFMFVooJ0blk82Ul/zNjte3v1x+CzxWv3srvqWCuKWfSdHWISdog
 XLvui1+v7T3qQN7ILufm5IpRm3I7a94=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-p2m6doDQNDyVnC4FhiFBbw-1; Wed, 20 Mar 2024 11:18:56 -0400
X-MC-Unique: p2m6doDQNDyVnC4FhiFBbw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69152af7760so10847006d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 08:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710947935; x=1711552735;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s2DvitvJUAGQ+uBsIXNwcAKXy9/+kL0SU0v8MLPW744=;
 b=XAd6kSgGVG9980xtpeTBGu8+AyOX5QdWfk40UTKfG0drrpff2iatv+Iame8p8siLZc
 lpInRZsgGrPFXDYeAK5F33MCAPH2d8d3jwyZ6Duj0iylJHuCa6TAQPEk4tPTbJAxK8vL
 afIKrfQn/8xLgZyU28LGWZSxGFo8YoFqfzgWp+JHG/z2T3pfMlYfbC7vgvIpvDOcJZqU
 h9TximK3VtbMRk7V6tc+fd6Kv3mCv0jMpZtlYjE4pustEPq7PaVqdGwUuRnPKTI2EovX
 272dWj8ANb+HlajtlnXp0DZEfab7fI1PMZJ8nwqKYOEhQj4NsbM3fVG+IwKWW6i1rMUf
 eLUQ==
X-Gm-Message-State: AOJu0YyU/lX0UjaM048ntSSkSvUUvNgnNBTFr3v1fF0cu/yYsl8VgBdb
 Xprd7gFvwEGuTgWDttsi+oD+TkXm5BzPUirsxDd8lOj0PLltQW/tSoGGessh+oYJZyD7ioPdDAj
 hKNBHbUxXWXO+mMzjr9CcIXAZNX9LKZD+aE8Cazoe7x9bW8pXSOWG
X-Received: by 2002:a05:6214:2c0a:b0:691:ca1:ce8a with SMTP id
 qq10-20020a0562142c0a00b006910ca1ce8amr17165773qvb.6.1710947935430; 
 Wed, 20 Mar 2024 08:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbL7zZQNMBAIJ0oNJjyY75oTWKW14gtRa4+lC6J/hUqhi8KWup2nqqLGWT4/foNMc/P4lVhQ==
X-Received: by 2002:a05:6214:2c0a:b0:691:ca1:ce8a with SMTP id
 qq10-20020a0562142c0a00b006910ca1ce8amr17165742qvb.6.1710947934926; 
 Wed, 20 Mar 2024 08:18:54 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 gi6-20020a056214248600b0069068161388sm7946153qvb.131.2024.03.20.08.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 08:18:54 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:18:51 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hyman Huang <yong.huang@smartx.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, xen-devel@lists.xenproject.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: Re: [PATCH for-9.1 v5 11/14] memory: Add Error** argument to the
 global_dirty_log routines
Message-ID: <Zfr-W0aubJC_lfaK@x1n>
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-12-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320064911.545001-12-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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

On Wed, Mar 20, 2024 at 07:49:07AM +0100, Cédric Le Goater wrote:
> Now that the log_global*() handlers take an Error** parameter and
> return a bool, do the same for memory_global_dirty_log_start() and
> memory_global_dirty_log_stop(). The error is reported in the callers
> for now and it will be propagated in the call stack in the next
> changes.
> 
> To be noted a functional change in ram_init_bitmaps(), if the dirty
> pages logger fails to start, there is no need to synchronize the dirty
> pages bitmaps. colo_incoming_start_dirty_log() could be modified in a
> similar way.
> 
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hyman Huang <yong.huang@smartx.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Just to mention that for the rest users (dirtylimit/dirtyrate/colo) the
code still just keeps going even if start logging failed even after this
series applied as a whole.  Migration framework handles the failure
gracefully, not yet the rest.

That might be an issue for some, e.g., ideally we should be able to fail a
calc-dirty-rate request, but it's not supported so far.  Adding that could
add quite some burden to this series, so maybe that's fine to be done
later.  After all, having a VFIO device (that can fail a start_log()), plus
any of those features should be even rarer, I think?

It seems at least memory_global_dirty_log_sync() can be called even without
start logging, so I expect nothing should crash immediately. I spot one in
colo_incoming_start_dirty_log() already of such use.  My wild guess is it
relies on all log_sync*() hooks to cope with it, e.g. KVM ioctl() should
fail with -ENENT on most archs I think when it sees dirty log not ever
started.

For those bits, I'll wait and see whether Yong or Hailiang (cced) has any
comments. From generic migration/memory side, nothing I see wrong:

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


