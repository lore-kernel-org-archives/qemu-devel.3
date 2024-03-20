Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2101C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvkj-0008Mf-D0; Wed, 20 Mar 2024 09:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmvkf-0008Lw-EW
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmvkd-0008Mi-QL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710940381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SmwzvvN/91u3bKHB14c6R7RgV42Yfs6yA1oVXUscvb0=;
 b=h2jYGjwXyY2Nr3BO+T3N5GEkaHnkvJt1X1czNZl0gZqby6WSN38jl4aVBpk0s8EuBk6Lym
 VfzSw1roPFq7uhJFAxIKVpzNZ1q08W7K/wLFB1l31FUZ7PzF9dIrRFoUDsp23MuNDLmixe
 zAMBwC0jyiVBo2s7SBSitk+OaeoaglA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-nZ9_eCP5OEW_L_-lMibLXQ-1; Wed, 20 Mar 2024 09:13:00 -0400
X-MC-Unique: nZ9_eCP5OEW_L_-lMibLXQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41330261f8cso33353705e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 06:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710940378; x=1711545178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SmwzvvN/91u3bKHB14c6R7RgV42Yfs6yA1oVXUscvb0=;
 b=SrTpVwjsxxJuBF0aYg75rCv3HTyyVV/rBNrvjndbdYbx+GzhN9QXQMGPshguoOm+d0
 yH9mwHkCHEmL6dSz9t8QCt0Y5SScHCo14RkNoEWclXhG23+3OhCihkmlDgMCoABhtxvj
 4lZeRJY75irwjNrs5oUnWfA32FM02Y0fSkImg2P6+GZJLBWjVZIS2oq23biCHgTQDq/A
 0jRsX2YMbeIif0NlaOpGCzIjktmEPv88X4nuaN5QIVILxNyHWM1qdzFGy/cegHRuWaI4
 ryXrNW6Rc81WLKyao5lQ1O5s3C2tI/BTdaJE5+zfy8syg8CtqTakDlnZ8KmnH5OU5LBz
 BIcw==
X-Gm-Message-State: AOJu0Yzy7n3+zMOkxFhZMLc2WdrAGTbZcM+874IJqgzwdZN2euj0N2tY
 8kS5VecIauYjlprAdDTWamzcWTF6E0FE/abSdfT4SYdYJcap4W/1rilPbtxxdXeyPxFRvLH01Kp
 CCtrAMSIOXEQ40SeI3BR1S89iOkdi+y40KRVLP58TrKiZX2IuLStI
X-Received: by 2002:a05:600c:4ec7:b0:413:2e49:3e05 with SMTP id
 g7-20020a05600c4ec700b004132e493e05mr15000841wmq.12.1710940378524; 
 Wed, 20 Mar 2024 06:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLrA8yA7PaaDEzHei/NhWflhc160WYY3Zl9I+wgDG2YHUmpYrffqWpeccXg91SytMAhqPV6A==
X-Received: by 2002:a05:600c:4ec7:b0:413:2e49:3e05 with SMTP id
 g7-20020a05600c4ec700b004132e493e05mr15000823wmq.12.1710940377962; 
 Wed, 20 Mar 2024 06:12:57 -0700 (PDT)
Received: from redhat.com ([2.52.6.254]) by smtp.gmail.com with ESMTPSA id
 bd6-20020a05600c1f0600b0041330d49604sm2208509wmb.45.2024.03.20.06.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 06:12:57 -0700 (PDT)
Date: Wed, 20 Mar 2024 09:12:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Hao Chen <chenh@yusur.tech>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 32/68] hw/virtio: Add support for VDPA network simulation
 devices
Message-ID: <20240320091134-mutt-send-email-mst@kernel.org>
References: <cover.1710282274.git.mst@redhat.com>
 <cd341fd1ffded978b2aa0b5309b00be7c42e347c.1710282274.git.mst@redhat.com>
 <af9cdba4-ef07-4b91-8371-94f3f3b46812@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9cdba4-ef07-4b91-8371-94f3f3b46812@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Mar 20, 2024 at 09:58:40AM +0100, Paolo Bonzini wrote:
> On 3/12/24 23:27, Michael S. Tsirkin wrote:
> > diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
> > index 3e2bc2c97e..86733278ba 100644
> > --- a/include/standard-headers/linux/virtio_pci.h
> > +++ b/include/standard-headers/linux/virtio_pci.h
> > @@ -221,6 +221,13 @@ struct virtio_pci_cfg_cap {
> >   #define VIRTIO_PCI_COMMON_ADM_Q_IDX	60
> >   #define VIRTIO_PCI_COMMON_ADM_Q_NUM	62
> > +#define LM_LOGGING_CTRL                 0
> > +#define LM_BASE_ADDR_LOW                4
> > +#define LM_BASE_ADDR_HIGH               8
> > +#define LM_END_ADDR_LOW                 12
> > +#define LM_END_ADDR_HIGH                16
> > +#define LM_VRING_STATE_OFFSET           0x20
> 
> I cannot find these constants in upstream Linux (what will be 6.9). Is there
> a tree that defines these constants, or should they be moved to
> include/hw/virtio/vdpa-dev.h (or something like that)?
> 
> Thanks,
> 
> Paolo

They should be moved. If the contributor doesn't do that soon
I will revert the change. Thanks!

-- 
MST


