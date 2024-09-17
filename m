Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB492C35FF4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqThS-0004TI-IG; Tue, 17 Sep 2024 04:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sqThO-0004SY-3Q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:36:38 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sqThM-00067y-J0
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:36:37 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5e5568f1baaso951776eaf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 01:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726562192; x=1727166992; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qVQqfUHY4tV0D5MLmX3JhZxcTGyb9S5vkvePgnWyIo8=;
 b=ZZSUAuRKPEBDlrS47phBE0xMdvvLFKssOO2nBe5ZS8wcrOrQIrDCfxWafA1WNiIrfT
 ve5I1x8CBprQCqCLKDgDLkqZuN01aXOAnwhMLz+4URlMU4DHNRea+XxTj/l0fEdP9GPb
 YqrWQm0cXwujrnQe17Y35bjCEwo7mUiik/U8blEUxllEjfQ9y7j5ZiLDqBh93PUKjpMC
 o8yBVYVBHPpIyUXJInoZBdEP+sy5paY6MO+kER5hEJzq7H7GnrVOFEg/85uuz6w6azP0
 n8wmnQkZejkmMNyyko5iGqqYHhwcaNgLCKbdkvwkJuF2IuIHnq1ar/T/13MIIQ1COSqz
 x8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726562192; x=1727166992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVQqfUHY4tV0D5MLmX3JhZxcTGyb9S5vkvePgnWyIo8=;
 b=jeeMITbU2GAclJlzbSWp1TXye6bauAHD8jeSUOeqb0vUWtWk54AQoGYqkxxEBW8o+L
 fAQJXJS3xh+WlFUeng8ttpv8DbA2Ag9pSROItqs5NSRqXR5uXr/9Vfvq6JbpeBInrlho
 snSWn6VAm1myWH1qXDJxZ8PefLGOuxrXImGjcuVX/8GnmaAbHxK88TVwG8Dw0+j79LbI
 9AwYpvsFhIW7j+g73d+un0F8QjXJFlS/CQkePlENXjC04WSFlsL4SNdcl0V3V7lS0KBg
 +Rls/sPuCMlLDvV/Yu5xWX6uHz/JJ4TOb+aQTuWa2Yg6hxOBJQ8VP7TeoSxFv6AYdYIW
 sMSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ru8ePL9Usrht0U8Mo/Avj7zyv7tUmYfLY09+zD0PPm86P548KK57+J3mU2NqNm1YqF7EhyYNyETr@nongnu.org
X-Gm-Message-State: AOJu0YyopJ8uudyzHAxddbCuFeTNzRS9X79WBr0+EDO4IfHz4gsR8tvO
 c4N/gHMtkgP7DyJ8pAoItBJXJuUMjTFW3B11Xjb6s7RNN7wEdpEuZdvfFI7Ra7hWUYoWNXm/5sw
 DPNnyyyg1cc2D8Sf+3/zeSK5uluU=
X-Google-Smtp-Source: AGHT+IEXfsT2lEGT5QkFQxVKN30PB/KDClDOI2GB/liwc0HOUnMJjPb2G5oMtb96ZzVdnuBL4ETKkIwnxFIYTFNy2kw=
X-Received: by 2002:a05:6870:1646:b0:27b:8902:5ac9 with SMTP id
 586e51a60fabf-27c3f6aa053mr13463626fac.40.1726562192338; Tue, 17 Sep 2024
 01:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-5-aesteve@redhat.com>
 <20240917083258.GE575885@fedora.redhat.com>
In-Reply-To: <20240917083258.GE575885@fedora.redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 17 Sep 2024 10:36:20 +0200
Message-ID: <CAJSP0QWAqFrNHMGkvgSPboKFHfBD-fXeOzDFSsuuJgQLVXyUxA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] vhost-user-dev: Add cache BAR
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, slp@redhat.com, 
 hi@alyssa.is, mst@redhat.com, david@redhat.com, jasowang@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 17 Sept 2024 at 10:33, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Sep 12, 2024 at 04:53:34PM +0200, Albert Esteve wrote:
> > @@ -331,6 +333,37 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
> >          do_vhost_user_cleanup(vdev, vub);
> >      }
> >
> > +    ret = vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost_dev,
> > +                                                           &nregions,
> > +                                                           memory_sizes,
> > +                                                           errp);
> > +
> > +    if (ret < 0) {
> > +        do_vhost_user_cleanup(vdev, vub);
> > +    }
> > +
> > +    for (i = 0; i < nregions; i++) {
> > +        if (memory_sizes[i]) {
> > +            if (memory_sizes[i] % qemu_real_host_page_size() != 0) {
> > +                error_setg(errp, "Shared memory %d size must be a power of 2 "
> > +                                 "no smaller than the page size", i);
> > +                return;
> > +            }
> > +
> > +            cache_ptr = mmap(NULL, memory_sizes[i], PROT_NONE,
> > +                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > +            if (cache_ptr == MAP_FAILED) {
> > +                error_setg_errno(errp, errno, "Unable to mmap blank cache");
> > +                return;
> > +            }
> > +
> > +            virtio_new_shmem_region(vdev);
> > +            memory_region_init_ram_ptr(vdev->shmem_list[i].mr,
>
> I don't think this works because virtio_new_shmem_region() leaves .mr =
> NULL? Why allocates the MemoryRegion and assigns it to shmem_list[i].mr?

"Why" -> "Who"

