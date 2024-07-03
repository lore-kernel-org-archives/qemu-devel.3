Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7B9C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 19:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP5zq-0006aa-3A; Wed, 03 Jul 2024 15:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP5zo-0006aH-QZ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 15:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP5zi-0000K2-0R
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 15:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720036219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3kTfD8o7GMkHUCjcMh8XxAcWG77aCxydExld3J0nQI=;
 b=BzPr9OHqAAOFqyGvAptzhiqjFILlNDFIc5cfk4SzPRvWqqfyR8yY6z8hsZOG1IiDOcS4ed
 uX5rOyPKUyptD3BGYagUpUUaOTqt6s0OKQmd7ESDZ1XY9oOzZRH/H7Nfcg5VaPPmKbOrsA
 0gghQXLwMbIiG7fioAmoZeF7lZedQCs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-ajaljOBgORmZegNREAqSog-1; Wed, 03 Jul 2024 15:50:18 -0400
X-MC-Unique: ajaljOBgORmZegNREAqSog-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36793b39ee5so689629f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 12:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720036216; x=1720641016;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d3kTfD8o7GMkHUCjcMh8XxAcWG77aCxydExld3J0nQI=;
 b=Y5HwzoaZRxDFmZDHqjXjEJzfQBzPYAN0eX09GT4zBwGef8DGD4g6yjnt2XUMOfuVp3
 kv51Ie8L3BNK3QG2uy0LqRbvMZrs/VU+tEk4yAGkPf0GCrmggG80O8asXuLEAZci+UHJ
 Da31dsRNgQKO84i56jaVuJOwnszo1aiCKb8Jo3a8eHTiQbyHgCO+mvV1EvbQT8OhYO9J
 +EEuVsfSsi9DE1Qd8i+DCLyArzBz2sALd284cMXzs9cALhf57r7Wll0oC3F+8pb1hOSY
 FYPzmdQM/F1IvI+wIJyCQUHZ4svx6LRzb5VfUlDNUh8iRS9pwJLwebKJL6rJeQiWAnos
 bp8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdlSWIwz5mSeh7gF6YCVmp1FHuabqeOC6ywVcxIB05ZRS7zpvhOqLTTXIBEhPEedBMKuu1Oi40s41Za5/4kiqCWvz3DHU=
X-Gm-Message-State: AOJu0YztsW7yKCH4f6klK5XDxHU/Cvz9+KYKNRiUxttlsv6imK8WChSu
 aHmP+h/UfcXkXlIHpMaMprOLzdsjMz7ccK4lk4pDHzHB0QUp3V9sUf64px69xhgSx0h/qRZgkzP
 ziuydVqbffcXgSk90w/Bg2p7oR9LNgzh0NyCjq5hYSs52FUWto8d+
X-Received: by 2002:a5d:6dc8:0:b0:360:8769:2bcd with SMTP id
 ffacd0b85a97d-367756b77d1mr7025648f8f.22.1720036215766; 
 Wed, 03 Jul 2024 12:50:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTOP5fhNRN7vZBVtnHoYl09z2/i4KD2wXAmMSqS4Fpb3g3inZoVl+TQ7F80pKLrZyfu0dLWw==
X-Received: by 2002:a5d:6dc8:0:b0:360:8769:2bcd with SMTP id
 ffacd0b85a97d-367756b77d1mr7025608f8f.22.1720036213683; 
 Wed, 03 Jul 2024 12:50:13 -0700 (PDT)
Received: from redhat.com ([31.187.78.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36795e3fe31sm1986088f8f.21.2024.07.03.12.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 12:50:13 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:50:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/88] virtio: features,fixes
Message-ID: <20240703154918-mutt-send-email-mst@kernel.org>
References: <cover.1719951168.git.mst@redhat.com>
 <f0961f6f-642c-4dc8-8bf3-1457f71da500@linaro.org>
 <20240703125101-mutt-send-email-mst@kernel.org>
 <d18ab076-47e4-4e8a-85d5-45f14f7b7e71@linaro.org>
 <54f9b0f4-d638-4273-935a-bb9bd129701b@redhat.com>
 <20240703154436-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703154436-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 03, 2024 at 03:45:53PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 03, 2024 at 08:46:38PM +0200, Thomas Huth wrote:
> > On 03/07/2024 19.01, Richard Henderson wrote:
> > > On 7/3/24 09:51, Michael S. Tsirkin wrote:
> > > > On Wed, Jul 03, 2024 at 09:31:45AM -0700, Richard Henderson wrote:
> > > > > On 7/2/24 13:15, Michael S. Tsirkin wrote:
> > > > > > The following changes since commit
> > > > > > 1152a0414944f03231f3177207d379d58125890e:
> > > > > > 
> > > > > >     Merge tag 'pull-xen-20240701'
> > > > > > ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm 
> > > > > > into staging (2024-07-01 09:06:25 -0700)
> > > > > > 
> > > > > > are available in the Git repository at:
> > > > > > 
> > > > > >     https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> > > > > > 
> > > > > > for you to fetch changes up to 29e45afd8d6abf7a67dab5db0ab1cfbc388daefe:
> > > > > > 
> > > > > >     hw/pci: Replace -1 with UINT32_MAX for romsize
> > > > > > (2024-07-02 11:27:19 -0400)
> > > > > > 
> > > > > > ----------------------------------------------------------------
> > > > > > virtio: features,fixes
> > > > > > 
> > > > > > A bunch of improvements:
> > > > > > - vhost dirty log is now only scanned once, not once per device
> > > > > > - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> > > > > > - cxl gained DCD emulation support
> > > > > > - pvpanic gained shutdown support
> > > > > > - beginning of patchset for Generic Port Affinity Structure
> > > > > > - s3 support
> > > > > > - friendlier error messages when boot fails on some illegal configs
> > > > > > - for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
> > > > > > - vhost-user now works on any POSIX system
> > > > > > - sr-iov VF setup code has been reworked significantly
> > > > > > - new tests, particularly for risc-v ACPI
> > > > > > - bugfixes
> > > > > > 
> > > > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > > > 
> > > > > Fails testing:
> > > > > 
> > > > > https://gitlab.com/qemu-project/qemu/-/jobs/7257337667
> > > > 
> > > > Could you give me a hint how to trigger this in CI pls?
> > > > All tests seem to pass when I push it to gitlab.
> > > > Any special variables to set?
> > > 
> > > In CI, FreeBSD uses travis; I'm not sure what's involved.
> > 
> > s/travis/cirrus-ci/
> > 
> > See .gitlab-ci.d/cirrus/README.rst for information how to enable it in your
> > private gitlab repo.
> > 
> > > I replicated it locally within a FreeBSD VM.
> > > 
> > > It should be reproducible with 'make vm-build-freebsd', but I think
> > > that's more difficult to debug after the fact than a full vm.
> > 
> > Just use "make vm-build-freebsd DEBUG=1" and you should get a shell prompt
> > for interactive debugging, so that's likely the best way to tackle such
> > issues.
> > 
> >  HTH,
> >   Thomas
> 
> Well 1st failure had to do with inabilit to find qemu-img.
> Which I guess should be used from build directory really?
> 
> After adding that to path for now, it crashes with:
> 
> ./scripts/archive-source.sh: line 55: meson: command not found
> 
> 
> Would appreciate some help here.


Hmm adding build/pyenv/bin to PATH helps.
Let's see how far I can get ...

-- 
MST


