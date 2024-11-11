Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8EDD2E9E4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 12:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tATjG-0001se-BE; Mon, 11 Nov 2024 07:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tATjD-0001qR-Sv
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 07:41:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tATjB-0003Zy-Ie
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 07:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731328868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9fcrL7ci12chRT2aI21y5McyDVwIVK0MMWGrFO2NEZ4=;
 b=I57MWiJtMg+8we8T6Grn5uEbSVr9hTHVDPpuzh08U5uRM79Dhug7SzB/Eu9LUj7oNfn7/e
 YZ/rWQMVILXnXiY1lExhHHCJQGCOEHkRHUO4eJdCh/oTEBAc97sYEk8giT53RB00UA/p72
 PIZedPeRcplREohqhuG8oaQog17Ptjw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-HnBZjuZcPwOmFZi8LARrUw-1; Mon, 11 Nov 2024 07:41:07 -0500
X-MC-Unique: HnBZjuZcPwOmFZi8LARrUw-1
X-Mimecast-MFC-AGG-ID: HnBZjuZcPwOmFZi8LARrUw
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d354ec5288so64986666d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 04:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731328865; x=1731933665;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9fcrL7ci12chRT2aI21y5McyDVwIVK0MMWGrFO2NEZ4=;
 b=qZXZjNzN3uOgTDLAAaJy0XSoYSeom0UikuG7QgCShPBu25L2EThUosidu8k2R+vVlS
 Yg1lPAxysBhcOtQ7XvqsgL0TyTfUAQ2r+ohxUU/nd7WZs9Ac7kej0DDq/uiX+zYMSKbH
 ehnaLx81LxwTWF81fVfFcMnKcCGphwNWDpecGC6VXkzyJ371UoGKcvmaghjgGezv7V6J
 fWko+jf98ulpUQRqLfGK5ILPqt0LdYKcx+hvAMRCFtPmN96k6ciubMHyx1jL7h62AuZ0
 MEB/FbD2rRR2gHnJgePB5SZelse0pmOUvY1ZTNMQAfLngQyztC24md1wQRFTP4nXYLrT
 Qijw==
X-Gm-Message-State: AOJu0YwQF/AWA7qoSludOFBWdMBwcf9hmfM78EV/49BFAaQgs+RcwMKC
 dy4jbUDLCK2ErZgOFdnG7BDOxZ5IwU8up2X8CrKFn0/BpXOtiTt6YXnrwM3J47UgOOY2Or5U9j8
 EF334sZ7hu2yL0RBFyVjE0dDp0BEfGqX9Hzg19PgmHEHcbDosPU8zraZiI5MHMJe9/gK9MvVhJw
 aXFuBeWKL1XaAj2xd3nR0Lfjip1GoO/8YlEA==
X-Received: by 2002:a05:6214:43c1:b0:6cd:4972:59b1 with SMTP id
 6a1803df08f44-6d39e18643cmr227124956d6.27.1731328865240; 
 Mon, 11 Nov 2024 04:41:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXjmvAd1NlzqzyKni8Ye3lOEGheeWheXpa48Oq2HauqkQpIW+kWerXnYDrAhrkmJqf33wbBA==
X-Received: by 2002:a05:6214:43c1:b0:6cd:4972:59b1 with SMTP id
 6a1803df08f44-6d39e18643cmr227124656d6.27.1731328864905; 
 Mon, 11 Nov 2024 04:41:04 -0800 (PST)
Received: from rh (p200300f6af368f00f7bae606b15f3bdb.dip0.t-ipconnect.de.
 [2003:f6:af36:8f00:f7ba:e606:b15f:3bdb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d396208436sm58870806d6.56.2024.11.11.04.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 04:41:04 -0800 (PST)
Date: Mon, 11 Nov 2024 13:40:59 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: qemu-devel@nongnu.org
cc: Alex Williamson <alex.williamson@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: ensure valid link status bits for downstream
 ports
In-Reply-To: <20241111123756.18393-1-sebott@redhat.com>
Message-ID: <0a0049d2-7c72-5e5b-c35f-d777418f3eaa@redhat.com>
References: <20241111123756.18393-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 11 Nov 2024, Sebastian Ott wrote:
> PCI hotplug for downstream endpoints on arm fails because Linux'
> PCIe hotplug driver doesn't like the QEMU provided LNKSTA:
>
>  pcieport 0000:08:01.0: pciehp: Slot(2): Card present
>  pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
>  pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000
>
> There's 2 cases where LNKSTA isn't setup properly:
> * the downstream device has no express capability

I stumbled over this while debugging - is a pci device attached
to a pcie downstream even a valid usecase?

> * max link width of the bridge is 0

MLW for the downstream is initialized with defaults but gets overwritten
later because speed and width properties are 0. Dunno if that's the issue
we should address?

Sebastian


