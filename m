Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC8606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B3Yszt+K;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Kl6FMDCE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmNz-0005Su-LN; Fri, 30 Oct 2026 09:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xMmNy-0005Sc-BT
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xMmNw-0004mS-PO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793365868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=977KxC93iTuvR85LvASoivTdZvht76K1VRbcudl7O8A=;
 b=B3Yszt+KKZspSFuPOvDszVt+CMt+9NQ21fveBKg0lVPoegf9VIA+0OuWyK2iXTGGxSobGA
 phxjOlW5SViaLVRLrLIrNm2/X++A8GZbuh++Yj2GOjpDoMXH+zCt739ypo8WUufXVZGCev
 CAltyDcsHz6IQ8+CiLpaCPybVMaPRi8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-BLXX2LFSMbCGMHilN4xwlg-1; Fri, 30 Oct 2026 09:11:04 -0400
X-MC-Unique: BLXX2LFSMbCGMHilN4xwlg-1
X-Mimecast-MFC-AGG-ID: BLXX2LFSMbCGMHilN4xwlg_1793365864
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48c46582442so529582f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793365863; x=1793970663; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=977KxC93iTuvR85LvASoivTdZvht76K1VRbcudl7O8A=;
 b=Kl6FMDCEcfC44QHi3rEwT9L/+NenNREuk8UO6OGr+mmqEzcIE523dMpCbReglyJpFB
 lcsAP8sDWagCdVjhkTeADPB7hWvtzMrM8dXbOAmE0YNKdRN2xkWUAqhXyMxrYg3uRuzc
 8rHfSOD9u5RAdA/Lh11Tofxl9nTr6jl6tTeUD0mogXbGrpSEL81iQKtdIoOhWp+Bi/Fj
 w6SnjovN8WXQOh50FkDFY+8MJAdOPluG4m+CIhHJq+E1cK9VX2VfMGHNz4j7RftQCe53
 X/zkSQ/fBoCduKaIvV3HLTsNHNBZJctkBEzW1kCNdHCczOXoZgeZlAWVpMDj2yNMMd/w
 OkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793365863; x=1793970663;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=977KxC93iTuvR85LvASoivTdZvht76K1VRbcudl7O8A=;
 b=VS0tx3GlNE1eH1Bewww2DVNpxcSLzKbbK1ubPfgxN8ZXJXaqbvJ2DwH1h9x55yru/e
 UeMocFJj+a9uPCe1n0dpov/9FQ88LbE4g/NbOPJ6eBV5pJ+TGv51JDgQIHSlQHTpS141
 mHCkwA2YDT0wXvZT+5Jz4pIGWNWVQLkfP0k03X6eeBBIbaz8+g8IKERrlvQYWjyXCoYU
 t9AGdeo6mKC6sARXppiAsKJW+vEueSrbxFm8EnJysqLQcGYFAeTXyuf00d1Ob+VaDdlo
 v4qiSphqb7jNWanbZzA7qVW92e97Vz9jshlapkJJl6Od5lVF7bkIBJ2E5Py1t0R3gsfm
 vZgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxy2ESsgK+Y93QNvVBPg2lzSzO1+AYfNKMzUOHZoZOOUNtcd8AzQSy2t9JqxRkQ8hsN5EEnORgcpbG@nongnu.org
X-Gm-Message-State: AFq9FYLLwxljQi5Rjtv5UBh+c3y+umnXIeVJHRWfHddo3Jdct/dO9z6n
 SUdynqCpd7beVgb12i5F6VnEn4C0rr7SiN2t2ZAwSZb5+BuDuBGAhsQKMS30Di7bNUmhyXA97vO
 OIS0upUe2hAy6f2K0NFDzE1yiySnu0Ou/MmUfeSigC/Uttx+qceJS+teO
X-Gm-Gg: AYBFou20LjFjwzP5Nt8KcJjOPkGGLcJ5WinMw6XcG+ljqEnN1NP346W4PSkOEwnUEaE
 WJn9MuzF5jd7f/Y1xAckCpTs8bvIf2db5bxFZhTkTTsG5vIb4upsSp9f+LNqkWuAssOm4tEMZ1O
 zQs8IV/WdkGuJOzQypcYBhvXlhZv7b3oNqsrWC55MsizjUXH6YyXQHRM/l+niSLeMzqTMkDUaQ3
 RO5GPg8OlxVBofIhYsjEoXx8d2Q395btVheFBCcwzBlvbFJt1GlVOdYcu1cNKBPIkfdHGrIKrpq
 K5WtD5t0ap/Q06CFy4qC+eYbgDB7TE0ESx7a1AxCR78uw2I1uaGDfZFly7SnIpgQxXj9Cse4zw5
 cBWwG7LExr3QJcEUmts5mjrHw9rPD5fNUfy2xHyN9kfM=
X-Received: by 2002:a05:600c:a49:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4ac180f1b83mr50604255e9.23.1793365863422; 
 Fri, 30 Oct 2026 06:11:03 -0700 (PDT)
X-Received: by 2002:a05:600c:a49:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4ac180f1b83mr50603545e9.23.1793365862898; 
 Fri, 30 Oct 2026 06:11:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab61d8b9f4sm97172375e9.12.2026.10.30.06.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:11:01 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:10:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PULL 40/78] pcie_sriov: register user created virtual function
 before realizing it
Message-ID: <20261030091030-mutt-send-email-mst@kernel.org>
References: <cover.1793207602.git.mst@redhat.com>
 <ca7c24b7c8f69c13fef24a31660e1b6ea73686d3.1793207602.git.mst@redhat.com>
 <CANukVxsB2n2GCGxQk3X2SUzNTJQ0M30ZxxmF=oGZtS-OCmbw_A@mail.gmail.com>
 <fe0694c6-383b-4cf2-abc0-c6d73a3d6c3c@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0694c6-383b-4cf2-abc0-c6d73a3d6c3c@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 09:28:50AM +0300, Michael Tokarev wrote:
> On 10/28/26 20:34, Daniel Paziyski wrote:
> > Hello Michael,
> > 
> > I think you have queued this patch for pulling on accident. There is a bug here,
> > which is yet to be solved, as you have pointed out in
> > 
> > https://lore.kernel.org/qemu-devel/20261028074508-mutt-send-email-mst@kernel.org/T/#mca344ac148a62107cdc298e97e6713b6657b5c55
> > 
> > Please, hold off this patch for a while, until I come up with a fix soon.
> Am I right this buggy version of the patch has just landed in the master branch,
> instead of the fixed v2 one?
> 
> Here's the difference between what's in current master and the v2:
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index d4187293b1f..6242204a52c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2310,10 +2310,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>          pci_dev->cap_present |= QEMU_PCIE_CAP_CXL;
>      }
> 
> -    pci_dev = do_pci_register_device(pci_dev,
> -                                     object_get_typename(OBJECT(qdev)),
> -                                     pci_dev->devfn, errp);
> -    if (pci_dev == NULL) {
> +    if (!do_pci_register_device(pci_dev, object_get_typename(OBJECT(qdev)),
> +                                pci_dev->devfn, errp)) {
>          pci_unregister_acpi_index(pci_dev);
>          return;
>      }
> @@ -2332,6 +2330,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>          }
>      }
> 
> +    if (!pcie_sriov_check_after_realize(pci_dev, errp)) {
> +        pci_qdev_unrealize(DEVICE(pci_dev));
> +        return;
> +    }
> +
>      /*
>       * A PCIe Downstream Port that do not have ARI Forwarding enabled must
>       * associate only Device 0 with the device attached to the bus


Yes sorry, pls post a fix as a patch.

> ~
> 
> Thanks,
> 
> /mjt


