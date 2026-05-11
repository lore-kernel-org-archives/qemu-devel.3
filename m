Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4081ECD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNII-000157-Ji; Mon, 11 May 2026 05:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMNGO-0007Op-3P
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMNGE-0003mT-6v
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778492952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NhdVyNzcUS2qH8/jez6doF+ti3xk1/afh6wD+0/QKiA=;
 b=U4YPkdA/B82CqlnK3QwVmudOMWQ4Rt+HiIpIh0/rlqXCdd5I5VYq7EFGT3RASyA6rG1VSz
 XHJuuVZ90VAXyf5c2SjTGBAy9diXPVHAz1CC+zsIpdc1+fSr+it30mwJAkysimI86wwieZ
 UfWyv6PUUiTPYvKPtpGUWZnBD5HcUlg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-pJ-RX_EkMrqlVcXEP8cN1Q-1; Mon, 11 May 2026 05:09:40 -0400
X-MC-Unique: pJ-RX_EkMrqlVcXEP8cN1Q-1
X-Mimecast-MFC-AGG-ID: pJ-RX_EkMrqlVcXEP8cN1Q_1778490579
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488d8deb75fso30086955e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778490579; x=1779095379; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NhdVyNzcUS2qH8/jez6doF+ti3xk1/afh6wD+0/QKiA=;
 b=H1DyKQpbEmWt655ouz3spkcujaXhPWbhs4eCOd+JKBq27N3NfR/ubQ0K+eDAJ1559x
 2HYR/difnANZQLOFcNlK+VR4Fch2Y2JzuBBxBYbr0Bj3eMald9KpZSTJMar4p40c7g4t
 EO+Kc7KP6JrX3vQo+4IiAhL3FR8hzPTaW+LGBmoOdWnrje2KlukLb4o+oytwOtwPzQ9d
 Ymon3PWoudBCQJe/SEojBe+j4t9qhO13xncaJ+afU+R3uqFBJXiwiRVxFuxek+3TYBmY
 c26A634uYCk5qBswZIS0vgvxUYATcf66KlipMODvbFcXprV5Cdt/UeAFZPmgfFCp3xo6
 vNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778490579; x=1779095379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhdVyNzcUS2qH8/jez6doF+ti3xk1/afh6wD+0/QKiA=;
 b=dKGndnW8+cIAp5riGFxjTHVAg9qt9pCBcHUTX0LR6tlvhFw25bde8+NRyHGiUM1eYp
 z3shxI0BnfSFPOfKqmAoqZlYE6r6M4cDXVTpkOjY1aRrm54KcKnuSulOjHk3HuYIh49+
 Q++G7UxlBtq82EKRu00uqM2maJbxQ7G8sx2toYMiyTldQWCKIWcQAxk/Nxn2nP2XpSg9
 FvRL08PJsVs5fqRzzByTtbDned7iWzuB3MmzmqLPQm4EdSz9rZH+muOzMACpNzq5q72S
 0+ozIafv1jTm3fXGNqsBinoOZ+gVedRe23w2PkRDs8JWWe/DWoQBL+2dyhNm9VleheVx
 7IzQ==
X-Gm-Message-State: AOJu0Yx4SrtFbZHRXA7nynszRgxPfd9WV+ZqbyKjWWSTXnTLJ4oxDTRT
 O5jEg016cFEJsPWBGgZjRzbSYTuBF/1fgTalnnz4QVSpk/9S0vnmSKD+7raq+RASQydqGfGKcb0
 8XDSfI7GYJtZYfO1HTOgzeaBYNUGog+8VsNttfIrAU7We8aY+UIGsh6sp
X-Gm-Gg: Acq92OH1687ur608lsJv/VFV+XxPDwHwC4VNGiWb6Aj4P6tLEmkQDp9ckRbXX0C9fiR
 NRNPu54/qUX2OkDbTxmjQA3ewSFsraWwjEp6AuC/+9HzHJ+FyDcqPAG+Lqi51A0OW90PFbDWDCA
 NWf5FGCJ+IngRjlkjrdrZgIbopiHmRLsSDas3Z6x0C2EtioJam5+lbVnKXAhVlIpZ5alWnXoMd5
 iWnGJWg/tPmBTiDrQg0+YBlly3snt5gJ1iLQnx4oA0IEpHa3yKiWZlRerudtaacbQ26QXxePMda
 IRBswWyWEeWb8ZgZqZosFJY94DaBl4sUooWJJmS6LfeVz4q/2bzOIJe0CIGYuY8CPveODSKqOku
 VFTGLsa3tcaTAG8/FyiDsrTy39ZXNGoXnDL12xqRG
X-Received: by 2002:a05:600c:4450:b0:48e:8741:fd53 with SMTP id
 5b1f17b1804b1-48e8741fed3mr14251895e9.15.1778490578897; 
 Mon, 11 May 2026 02:09:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4450:b0:48e:8741:fd53 with SMTP id
 5b1f17b1804b1-48e8741fed3mr14251185e9.15.1778490578408; 
 Mon, 11 May 2026 02:09:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6fff9c91sm182612165e9.1.2026.05.11.02.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 02:09:38 -0700 (PDT)
Date: Mon, 11 May 2026 05:09:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: qemu-devel@nongnu.org, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: Re: [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI pre-enumeration and
 fixed BAR allocation
Message-ID: <20260511050459-mutt-send-email-mst@kernel.org>
References: <20260508183717.193630-1-tdave@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 08, 2026 at 01:37:09PM -0500, Tushar Dave wrote:
> This RFC introduces a mechanism to specify Guest Physical Addresses
> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
> addresses to match host physical addresses for assigned devices.
> 
> On some platforms, P2P DMA is performed between devices within the same
> IOMMU group. The PCI fabric ACS is configured to permit direct P2P
> without going through the host bridge in order to achieve the required
> performance.

Pass this info to guest firmware, let it set bars any way it wants?


