Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FBAC48BC4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 17:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbl5u-0005YU-JB; Sun, 18 Feb 2024 12:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rbl5n-0005Vm-Nq
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 12:36:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rbl5l-0002b9-Ew
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 12:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708277799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=20eW7RVW9fifRSYoy+aQFRMy+M+OLoaDuDZmP5yn9cM=;
 b=RRBUGRIbGUJpu4uYdx8riXLuO/CuaglP3i5KIRrKQd2I58pDlnfhb559jJRn9h/iZfDmu9
 ZQ09yOehPaSNzqnYFgPYc+IKcySp58iJLQJYWSWQjc92Hq2jfY5GozOsQTr5JgqyOT3QAo
 amxsScuoU1HRKkuXNtGSuRZknOfYI7k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-nYbflYREOlWLef2nQY8G5g-1; Sun, 18 Feb 2024 12:36:37 -0500
X-MC-Unique: nYbflYREOlWLef2nQY8G5g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-410422e8cd1so13074215e9.3
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 09:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708277796; x=1708882596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20eW7RVW9fifRSYoy+aQFRMy+M+OLoaDuDZmP5yn9cM=;
 b=Fs+p+Or7iDevrPyJgrVUNYp24pPoPNz/Z2cMu3rfE+ijhqrsLVWlp51Btb0BbAdj4J
 g2h8Q5qXcVpzqNjEONctpsWyJZnaXNAviXlwOSgRsKq23cp/aELYf8edtl2AiwoieHcg
 tTqcSvWQO+akXlatsRx3aSbvLEQ8QFArzUnXvFqVXmsUG72HojXIQbTuCq/O7cwX7iw4
 LajDNg2ol0/m45pFMjdYRGV6VPte7HbeB7Iruf1xGXeyPMpv59Zk8Ci+8XtIgPXuwLrJ
 k12Gvs0mWyoa5nO8T91i4Cy9qCUAZERnqJTRz7jnFf/JYBHgPuvnTxkNIONVbNCnMvoS
 LWRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYqRHDQFUHcwYd07DSOme4m4n2r+TnGM3G6wPqdR3fvsPhWOk/h3twTdr3qCo27qyJeEq/9Db8pjoEc8jKhpFAvjufF9g=
X-Gm-Message-State: AOJu0Yw7NLSkl9PEX0WPiDam7qUcS83fQ9KMpRL+x8xOr3plkLltSZfl
 hi9avjwi2ot3o6WAl76L3ecqunUBxJDtb8yue5D+j7jHOmr2A7EbAjMOnmiLdYtRaU0FG9nlrxK
 yhVu5KBk7yTx/awExAkltIRtXZZkprirmkOig+qMt1dfD5SAoVlJIDSuzDT7E
X-Received: by 2002:a05:600c:314c:b0:412:65e0:cce5 with SMTP id
 h12-20020a05600c314c00b0041265e0cce5mr381135wmo.24.1708277796005; 
 Sun, 18 Feb 2024 09:36:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIYWtajbKxsI7BMSRhyM91nZhIY1VYvJiGWojr4QdST/5CqNyc+vuEjfwhIHzuOeyEFQ6AIQ==
X-Received: by 2002:a05:600c:314c:b0:412:65e0:cce5 with SMTP id
 h12-20020a05600c314c00b0041265e0cce5mr381120wmo.24.1708277795657; 
 Sun, 18 Feb 2024 09:36:35 -0800 (PST)
Received: from redhat.com ([2.52.19.211]) by smtp.gmail.com with ESMTPSA id
 iv6-20020a05600c548600b004103e15441dsm8875132wmb.6.2024.02.18.09.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 09:36:34 -0800 (PST)
Date: Sun, 18 Feb 2024 12:36:31 -0500
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
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v5 02/11] pcie_sriov: Validate NumVFs
Message-ID: <20240218123556-mutt-send-email-mst@kernel.org>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
 <20240218-reuse-v5-2-e4fc1c19b5a9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-reuse-v5-2-e4fc1c19b5a9@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
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

On Sun, Feb 18, 2024 at 01:56:07PM +0900, Akihiko Odaki wrote:
> The guest may write NumVFs greater than TotalVFs and that can lead
> to buffer overflow in VF implementations.
> 
> Cc: qemu-stable@nongnu.org
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
>  
>      dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);


This reminds me: how is this num_vfs value set on migration?


> 
> -- 
> 2.43.1


