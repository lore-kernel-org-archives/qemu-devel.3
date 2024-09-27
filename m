Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C6FCEBF77
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 04:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2HB-0002qn-IR; Fri, 27 Sep 2024 00:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2H7-0002fv-KK
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2H5-0006F7-2D
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHWfqUI9XgNZZmDWMTNXZNktqEyDqUCQnJ+3MuzTrZc=;
 b=hIx4Mdt9Cx83cXA6RNTAPDVR8DCYmR/GBdwix7w4rIVZlOiXEXjvzGPWF0hI4WwThID8CW
 LCWvi+Y0LhiFCVIvUgrAGRCMYzX7cr90fdmAN3fqPE6zBQjTv4DP2a+yBb1VMevgodrLFI
 M3fEkSHJNKaKns86FvOtW5tB4/1EeWI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Tly60PMiPgChIXhhyecMGA-1; Fri, 27 Sep 2024 00:08:04 -0400
X-MC-Unique: Tly60PMiPgChIXhhyecMGA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7d4fc1a2bb7so1641252a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410083; x=1728014883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHWfqUI9XgNZZmDWMTNXZNktqEyDqUCQnJ+3MuzTrZc=;
 b=CYq/nAT7Dh72ObxkKti1Al3OgX4brJWZ7IECb1W8eSgL08NVHCiiYu7Dl/gbialoCx
 Jls7l7QRLwIvH9jVBgzOAtE8usL32OwirYESzfzbJvfR3FUNiP18frfQF+G0rGWfAxNF
 Vi80U9NH5KiRToR17quZI2rjOeahUHwP6Uj+0Sft2gmK0n7Yi8nIYM5e+bP0Yip66PZ+
 /LV/1mbLp4TZASgFMHluUa5rtjE4FKK5vKbtsdC5dWp5QjjJiBs0uBUYENNEmAt/NR4z
 Lp7/4qyoeOUT3xOsCqY2D/BxiwEUJhEIQqsI04/rcdkycwsrqsjhbnM6lMgDoTg8WOQM
 OoQQ==
X-Gm-Message-State: AOJu0YxOsbaAy5kKkN4h0cy1IidE1QeCZBqgBiWhl9pVuoRsOYA4lE7m
 /HorpdHmDLlp6g1cSGE3gm35HIpv3VpxDIJHdys0/sYNf56e1hrsOzgnBrFDoXBys2JweuqzmG5
 8tYfNP3kTNvq53+aqT4U8HBuPYuYZs/tZDROT89IBQSvUsKRF01LMnlLo61srg1z6Zo79ZP/tUG
 dQLf0+rqEbvg1UC9yiu4q4oujD3js=
X-Received: by 2002:a05:6a20:d8a:b0:1cc:b22d:979f with SMTP id
 adf61e73a8af0-1d4fa64d9demr2509396637.4.1727410083299; 
 Thu, 26 Sep 2024 21:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErX511WGaIsppD4u1Xmjg9WpbncQPZOoUq9XGJ53Vx4/PY1i0axD+TjnYQ70Z3RFk/8KSaZ7R16IXP2hW2N7A=
X-Received: by 2002:a05:6a20:d8a:b0:1cc:b22d:979f with SMTP id
 adf61e73a8af0-1d4fa64d9demr2509368637.4.1727410082887; Thu, 26 Sep 2024
 21:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-7-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-7-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:07:50 +0800
Message-ID: <CACGkMEv3v3uwDEmEquBcfJPbcfNO5f3g76CxJK+AE-gbDXnoTA@mail.gmail.com>
Subject: Re: [PATCH v3 06/17] intel_iommu: Implement stage-1 translation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 11, 2024 at 1:26=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> From: Yi Liu <yi.l.liu@intel.com>
>
> This adds stage-1 page table walking to support stage-1 only
> transltion in scalable modern mode.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Co-developed-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden=
.com>
> Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.c=
om>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


