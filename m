Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F8CC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 22:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9tTj-0003bq-63; Tue, 29 Apr 2025 18:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9tTc-0003aU-Hm
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 18:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9tTa-0000jK-OK
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 18:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745965853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCZjV8nenmIWH736nx0tWmzLkRQBMs8cP17mfRA4pC8=;
 b=XgNS6VbH6tmjirDzMlnqH16X1SnGuja7vlkuPOOZnie8Oc+ybtgINGxFfjFClISIlxsor1
 TmsvygiUo4qz8oGTu0HAxecuM6Nl/I0Mwu3Ll+cgZUWxcTsq3r6C4PXITMAp9v9j9yr3gW
 Ve2DV/YzuCfv7yjzSlX51dPRcxrvink=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-ll6_cSbzO3uAGXKMk3wdEA-1; Tue, 29 Apr 2025 18:30:49 -0400
X-MC-Unique: ll6_cSbzO3uAGXKMk3wdEA-1
X-Mimecast-MFC-AGG-ID: ll6_cSbzO3uAGXKMk3wdEA_1745965848
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e8ed78717eso107400856d6.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 15:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745965848; x=1746570648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCZjV8nenmIWH736nx0tWmzLkRQBMs8cP17mfRA4pC8=;
 b=L0Z6apoLyEkjVFEum+OO8OfTuzy+zKb5YMkWW4mQld5tlI4PDqpGEvILSoKz7/ljCH
 Q8fx4u0FQtCXgn/K/hQbbzeBSwRYIymhTVgHjxtj0nRjJWi5OyYoI5bGgtKq5+9kG94l
 t0Jla1ndNjouDBfCAxLluDomwILLQQI4/tQest/z+x0EqWgkE220DAKxateMi9Zx1ptZ
 1t11pKqvPIChf9v3hw9U2cdCsMtEm7P3SynNfqth2ZshDXdPaPvzJ3InedcywEO6c4vD
 1NbftcxWfN+zWJhekbDjq0Cre4Gadj9PfMnhc1DsEClQVo5YehSc4pVIMu2JzMC4AZdN
 h3qw==
X-Gm-Message-State: AOJu0YytzmgN1MoQtPxamjSYIvh0MGkjuiBXm0tzhBXbRHkoGizHEN53
 2psoDfLInXRaWeTPnjXes4add+0hZ87F+GeGYt4j4kGMWyrOM5PPpTGRU4ahYex4cKB8bJSUK1A
 LeBKPAUnfTmOie41fZXDnIamnRexe0JSwHNJY25XFW4gNLrjgY7HHiEru9y5b
X-Gm-Gg: ASbGncspLRy14U/kJqyPP/POW7ZpLOa8XIKy7nXhYe8fQFrEUSa15w+sgKIHxUz+eiO
 sESuBbtPUuMsWtRSlUAgGBO+5g8oJIzcfD8Mn5Ovys3hDw1VPjNyFenD6AdOIToN/KEJepxe3VW
 9lPBqDfFa3c4VONSBrMidcs0wTTqm0kHP00BY+a69jNXgxwdyu/HG88wB7nrN0GrnellQP4UGnq
 8wLeZT8BatPogFfUcbWVYvfkDvwe3wSSdfq7WNgyzlEZU8ovYjPbBeLAJ47TXwoJkgxkC47HZWy
 mko=
X-Received: by 2002:a05:6214:cca:b0:6e8:fe60:fded with SMTP id
 6a1803df08f44-6f4fcf8f447mr16199376d6.30.1745965848254; 
 Tue, 29 Apr 2025 15:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0HR+/fqfnk2gJpj2b3Z8+D389EhtsSg+muHW1ifBtyQ/w0prdmAtbmMV+1k2MKOBJh1G43w==
X-Received: by 2002:a05:6214:cca:b0:6e8:fe60:fded with SMTP id
 6a1803df08f44-6f4fcf8f447mr16198986d6.30.1745965847808; 
 Tue, 29 Apr 2025 15:30:47 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f4fe835441sm778346d6.69.2025.04.29.15.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 15:30:47 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:30:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 3/4] tests/data/vmstate-static-checker: Add dump files
 from QEMU 7.2.17
Message-ID: <aBFTE8r3lyqUcAsT@x1.local>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-4-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429152141.294380-4-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Apr 29, 2025 at 05:21:40PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> For automatic tests, we need reference files from older QEMU versions.
> QEMU 7.2 is a long term stable release, so it's a good candidate for
> checking whether the migration could still work correctly. Let's add the
> files from that version that have been taken with the "-dump-vmstate"
> parameter of QEMU (compiled with single machines and the configure switch
> "--without-default-devices" to keep the json files reasonable small).
> 
> Some devices also have been removed manually from the json files, e.g.
> the "pci-bridge" (which can be disabled in later QEMU versions via Kconfig),
> and some Linux-related devices like "scsi-block" and "scsi-generic" and
> KVM-related devices. Without removing them, we might get errors otherwise
> if these devices have not been compiled into the destination QEMU build.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                   |    1 +
>  .../aarch64/virt-7.2.json                     | 2571 +++++++++++++
>  .../vmstate-static-checker/m68k/virt-7.2.json | 2936 ++++++++++++++
>  .../ppc64/pseries-7.2.json                    | 1068 ++++++
>  .../s390x/s390-ccw-virtio-7.2.json            |  475 +++
>  .../x86_64/pc-q35-7.2.json                    | 3402 +++++++++++++++++
>  6 files changed, 10453 insertions(+)
>  create mode 100644 tests/data/vmstate-static-checker/aarch64/virt-7.2.json
>  create mode 100644 tests/data/vmstate-static-checker/m68k/virt-7.2.json
>  create mode 100644 tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
>  create mode 100644 tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
>  create mode 100644 tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json

This looks like an improvement indeed, it so far only covers machine type
7.2, rather than all machine types.  I used to run these by hands before
each release.. and sometimes I forgot.  Before me, I am aware at least Dave
used to run also during softfreezes.

One thing I am wondering is if we can do it the same way as the compat
migration test in CI, so that we always compare with a base (which is the
previous release binary), then move the base after each release.

After all, due to migration-compat-common CI job, we always build the base
version of QEMU already in build-previous-qemu, so we already have two
binaries at hand.  IIUC we only need one new job to generate the two JSON
blobs, and feed them to the checker on both directions.

If that is the case, it might have a benefit that we can cover all the
machines as long as listed on both binaries, then check all of them?

Meanwhile, if we keep the ball rolling for each release (by boosting the
base QEMU binary version), IIUC it guarantees all the new binaries will
make sure to provide compatible VMSDs all across since we start running the
job.

Would that work?

-- 
Peter Xu


