Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7C1C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 08:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9h3l-0003Nv-Q8; Wed, 22 May 2024 04:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s9h3j-0003Jz-Dn
 for qemu-devel@nongnu.org; Wed, 22 May 2024 04:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s9h3h-0000Lx-OT
 for qemu-devel@nongnu.org; Wed, 22 May 2024 04:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716365447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3MX0dfPxJQW/jPdajIzbnapO+LDnoMtyS+J863xbynU=;
 b=Ikni0Nmt+T+9llPLt99YGxn9aclDWFJq6u6eXz0SRu7XDHXD3mId3E5j4CKjVlOhfeAVk3
 11EFN5vAqOuiw1IKMauGNHldws3Gn1nhXXBRmRNWbHmVBpnudgJUFoZ3COnYw9nhXyPY2P
 Xz/7RMZT8CIIKR1vEUzaBouUjN/NDOU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-tI-JumeHOl6N7wCW1MfL-w-1; Wed, 22 May 2024 04:10:46 -0400
X-MC-Unique: tI-JumeHOl6N7wCW1MfL-w-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2b3773153feso11545680a91.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 01:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716365445; x=1716970245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MX0dfPxJQW/jPdajIzbnapO+LDnoMtyS+J863xbynU=;
 b=AMmiUQCKjniy4Md/Yq+IsrptRBw+l8v8kD3UkYlxRyK1ZVT0xhkqqJs3IbA7W/YasA
 ZLCjEH2mopYun54Qjs7q/diJraUnLr8uFJ3FafN4aqTf6+o8hN/7w/MYsI9qzS65Azfo
 LN/DiUkYBbjb3y+Uhv7wEPImvW7PB667XZsjXa0Ax4fWKGGsYaMadJta+qsoXHnmNaoP
 8QGZKX+TsOlAAohj0hVTBxAjy8stNVXlTWnGbgUAjq/5NXs2H/zcvfXviasSWMu+TeFV
 5Rs5sjyUVV9H9EB8mbl+VK27imN/EY3JZ1flytWTIhzNCjQ5ZvBAamtlDkQXRF9vVx4d
 hTTQ==
X-Gm-Message-State: AOJu0YwQgTjcomc0Qtr0E18XKDt2G3EkgJyaHaVKcy83XA5Z/+cTnggk
 EW5yTnn1WJ4rzyAQUIwQZ3+R7fpDS5dj1U5yEXGQEhSl1d3Fdf78w58qV0FZQtSBQyvN/9kNRYx
 knw5hFyvs63Yr8spxj2nU3TPskC36qfMemaGW3WIoHkzHMwoW5TOwpEYeUIyjzC8X55+dhPeY13
 U+//lmYcoftgc30FMLoV8WZTcKBoc=
X-Received: by 2002:a17:90a:f3c6:b0:2b9:e3:355f with SMTP id
 98e67ed59e1d1-2bd9f345813mr1396518a91.8.1716365444827; 
 Wed, 22 May 2024 01:10:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGC6O1kafe7nGK3VWY4HViL/pgQKbvmkYsdnPwWnvuikUQSFS7IUbI7eT0moExTx1i1hgdy4teWG8yKn6+RBU=
X-Received: by 2002:a17:90a:f3c6:b0:2b9:e3:355f with SMTP id
 98e67ed59e1d1-2bd9f345813mr1396489a91.8.1716365444387; Wed, 22 May 2024
 01:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240522062313.453317-1-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 May 2024 16:10:33 +0800
Message-ID: <CACGkMEuDVfL1ijqBdXqJ8UKrBf-Uj5Esw_kxRA2Df9CkcLkc+g@mail.gmail.com>
Subject: Re: [PATCH rfcv2 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Wed, May 22, 2024 at 2:25=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Hi,
>
> Per Jason Wang's suggestion, iommufd nesting series[1] is split into
> "Enable stage-1 translation for emulated device" series and
> "Enable stage-1 translation for passthrough device" series.
>
> This series enables stage-1 translation support for emulated device
> in intel iommu which we called "modern" mode.

Btw, I think we never merge RFC patches so I guess this series could
be sent as formal one for the next version.

Thanks


