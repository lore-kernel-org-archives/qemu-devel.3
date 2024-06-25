Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E8DC3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM6kL-00041r-68; Tue, 25 Jun 2024 10:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sM6kJ-0003zE-Fo
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sM6kH-0001CD-QP
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719324123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzsE3I1EKOYd/UsaTclg68Gv2PlMPO5zbfjHM8RBCdw=;
 b=TuYjCh4I59sAhe5hdTh2ucT85jm7fR/DzWe9CPiTQnI4o5cDO/F8aYY/0U06yDP0xZY0p+
 +V9xwjADdmnv30DAUdZi37NztRfDMqbmSZdwgWce1GGFjeCD9GNRy4bwXpPuL/mYTEZpel
 b4bAt0Rv8burJimbgWnv7YjalR8xcVU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-j0PtHLipPzOdKJbQcOndiw-1; Tue, 25 Jun 2024 10:01:58 -0400
X-MC-Unique: j0PtHLipPzOdKJbQcOndiw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7274fd9099so52082866b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719324116; x=1719928916;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzsE3I1EKOYd/UsaTclg68Gv2PlMPO5zbfjHM8RBCdw=;
 b=DG4oynj8KtBAUQ4wNicpwZaLGtVJVqHayU46g6NtaVT6ef9u4VTr2kDQ8JfywRr3F3
 4QMAfH31T6YWAfE1yrBPoLbx7dnX7zWORS5Ic/2ZiSY6EQuvbRHeH9eIt0Bn4pYG11oT
 IS3bhSPibRN+r0bwCjPeyOF2uhYK++wZoQIFk39wlMHapGAuB/NZUr0CQ/XAQnLL+66d
 YYJTiV1KFWAxq1PrS7trrkVqESGORdKmDop57lC7bOqu31VkWps6KkvsIOpiWfGz1cBE
 8xXk6NDkq7tipBQUWX0chrtk9ygYugX6nq50x91PiWV4eDuL633E65bCcFsZzIrQ3FXM
 9yfg==
X-Gm-Message-State: AOJu0Ywag9P8Nhnaxt81dKNyhmAQp6tcYr8Uy0zXFC3kcForYLBGxVR/
 V6WRXkQyYbOUQ+ZSmRBEqIld/JTsOHnZ2U/lgQveJzipm2nTKCqC+J3IDD51hFOVbj2i5B417JP
 uyvU1b5FYzcVuAKNsZm1rlDwrQ+pu2d0YB5uU4U97vaZOOQ8dThSfOeugpnkPdXE=
X-Received: by 2002:a17:906:9d12:b0:a6f:b702:8a21 with SMTP id
 a640c23a62f3a-a7245cc04f8mr414241966b.63.1719324116181; 
 Tue, 25 Jun 2024 07:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKxxHoupo6ZpFX9CSOl5d/z/P+r3hIuCvjVRNN4b+9N4LScmmoOSVMar/oaTX4086jLvCN8g==
X-Received: by 2002:a17:906:9d12:b0:a6f:b702:8a21 with SMTP id
 a640c23a62f3a-a7245cc04f8mr414238166b.63.1719324115422; 
 Tue, 25 Jun 2024 07:01:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fe30e6a1esm398074066b.216.2024.06.25.07.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:01:54 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:01:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/46] virtio: features,fixes
Message-ID: <20240625100046-mutt-send-email-mst@kernel.org>
References: <cover.1717527933.git.mst@redhat.com>
 <CAFEAcA_cJjtN8Qq=9xJiyJLtazL-8zTWJTgjFG74SE3MQHpdNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_cJjtN8Qq=9xJiyJLtazL-8zTWJTgjFG74SE3MQHpdNA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Tue, Jun 25, 2024 at 02:06:04PM +0100, Peter Maydell wrote:
> On Tue, 4 Jun 2024 at 20:06, Michael S. Tsirkin <mst@redhat.com> wrote:
> > ----------------------------------------------------------------
> > virtio: features,fixes
> >
> > A bunch of improvements:
> > - vhost dirty log is now only scanned once, not once per device
> > - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> > - cxl gained DCD emulation support
> > - pvpanic gained shutdown support
> > - acpi now supports Generic Port Affinity Structure
> > - new tests
> > - bugfixes
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Cindy Lu (2):
> >       virtio-pci: Fix the use of an uninitialized irqfd.
> >       virtio-pci: Fix the failure process in kvm_virtio_pci_vector_use_one()
> 
> Hi -- I was wondering what happened to this virtio-pci patch,
> which I reviewed. It seems like it got into this pullreq
> which didn't get merged because of a bios-tables-test failure.
> 
> Michael, do you plan to respin this pullreq soon ?
> 
> -- PMM

For some reason I was sure it got merged.
Whatevs I will do a new pull req.


