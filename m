Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19191C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqVX-0002t9-B9; Tue, 13 Feb 2024 05:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqVU-0002si-MM
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:59:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqVT-00061f-7t
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707821958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+WEniuVO/K44jckRuF1F76Eoxoe96Z6mlPzpyvMtF24=;
 b=PXGe8phE9lWSUFuF3i8A0MEGG63/nEfIcY42ssyQkTLFluQVJ1ycvD93Gs1jk8/WPy6FBk
 uNNQPv3fzrn1U5H1UNT0eYVrvvzCd5yS9lDGsjpKNzPgI1gU/y76cywg1WCy1KcGjY1s4e
 Y3OnK/9c7MFPxX59F8xeu0FD95caduI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-XazDG0q3P-ys6dDI1JIxCw-1; Tue, 13 Feb 2024 05:59:16 -0500
X-MC-Unique: XazDG0q3P-ys6dDI1JIxCw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a381d3277a9so184847466b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707821956; x=1708426756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WEniuVO/K44jckRuF1F76Eoxoe96Z6mlPzpyvMtF24=;
 b=lqiHz1pqh5YB4pPhA46o2Sy5FTSNNU0Lyss1m6xNFj6Quwjy8z9BsSNfrBdJ+Q2E/N
 h4v/4wHdJtHtXevBqUJttW7pkKnQak4Wcnr16+ja7JPsNPtPclUhrpo4R+Rwr905IdmN
 WdoDdCqs/nnDyhnd4PzE81xGNai2Sed4/dWu4ayxJMAIMQ0W9JIv+iJTlLHxIJ3Gk8Bz
 lF6WUoOUeFq/mIJDOKv5EA3OMq9SI5zf6Qh38acamswgt5KcfSKwrMSborbEIUpC7Taj
 Q290T32Enc5a7uUpwROMKbgYOpc9VDESdlQttt093zXG+aiBxolYe0wbZmUICewMEcFy
 B4ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlNGTVg04qJvX7KI36oLNA8DUZXyooKChMH15d0Nly7X92C/LTinIzolhTs6o6/ftcOJRlZJf7QVJEVpItE0G7Rs0N1Bk=
X-Gm-Message-State: AOJu0Yz58PdqKoDs8zW5QT9CvtBRw/Kj/g2EzpYpbYb2KsNDN3Qj9g+Q
 R4Kztk8T/q3kvCcv9d3k2T9xLQAViwX3E+i6omNrR9QTAXDMmPWwoOhLNTEjUNZlu4Nb4aPPJFy
 dcjBA2yb4G0A5uM9SKWTZyXhvyDLh04AoDnrA1Drv+f7/Nomd+Pea
X-Received: by 2002:a17:906:4a4f:b0:a2f:1077:68d with SMTP id
 a15-20020a1709064a4f00b00a2f1077068dmr6430904ejv.39.1707821955761; 
 Tue, 13 Feb 2024 02:59:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVHCKp1UhWEaF1FMJKRxaVwgVB/BcqMPg/7Il7J0FjddPhUQTdwiLUp962anMmtuj2+6bMKA==
X-Received: by 2002:a17:906:4a4f:b0:a2f:1077:68d with SMTP id
 a15-20020a1709064a4f00b00a2f1077068dmr6430870ejv.39.1707821955140; 
 Tue, 13 Feb 2024 02:59:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUINgSuJBgOXJzVQ95MflHzELbcCyQsk5t6WJ2sPG8xaGR1sc9PgaucafIze3S5/n/24xvXvRUe+JGFS84jsd9p8RM+YGogwQf5ghuxf+IPD05aqrpnLTfikkmJHJnjCtWdn0zOr58koo0ZEor308NDbD4V+XOGsVi5ijsyajBV6qx/Z04bS+RND5HTPJN2gUQMOJdNQOYrmn68pBd1YA9QTb9/sL6iRyHAUra6jGshxy8bhzylKTH0kd0VSU8kDD2JgdnV9zU+rKfP5Y9nY/WfslMn6tcYrH6dQKEqg5nCrUZ6g4JPlQM24NAOvyBgqaGbdTDxbgrd8pD8m3C5AIQJe0kLxmEK30ttdKiAbTZ/rd0Z/5bqCr7qYdnlZ5X8G9HT6fPIdOdPFnMaaIFpyQnnpUMW8TV/RpWdhg==
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 a6-20020a1709065f8600b00a370a76d3a0sm1172055eju.123.2024.02.13.02.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 02:59:14 -0800 (PST)
Date: Tue, 13 Feb 2024 05:59:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 5/7] pcie_sriov: Validate NumVFs
Message-ID: <20240213055345-mutt-send-email-mst@kernel.org>
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
 <20240212-reuse-v3-5-8017b689ce7f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-reuse-v3-5-8017b689ce7f@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 12, 2024 at 07:20:33PM +0900, Akihiko Odaki wrote:
> The guest may write NumVFs greater than TotalVFs and that can lead
> to buffer overflow in VF implementations.
> 
> Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/pci/pcie_sriov.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index a1fe65f5d801..da209b7f47fd 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
>  
>      assert(sriov_cap > 0);
>      num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> +    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
> +        return;
> +    }

Indeed:
     The results are undefined if NumVFs is set to a value greater than TotalVFs.

However I note that hw/nvme/ctrl.c will still poke at NumVFs.

Since it's undefined, I propose a simpler hack and just force it
to PCI_SRIOV_TOTAL_VF. This way everyone can just assume it's ok.


>  
>      dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
>  
> 
> -- 
> 2.43.0


