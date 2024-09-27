Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EE9CEBF60
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stycg-0004cs-W8; Thu, 26 Sep 2024 20:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1stycf-0004W5-4i
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 20:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1stycd-0003F6-Ma
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 20:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727396050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZxkK39iWIhBklipRPm+D7bJoC3g+gRtIqmTFuPN8jd8=;
 b=a3vfLX7Jy7yDNRojgNZ+Budey9pu36ROEjsmqOMBQQmuQz4ZSdrnDGNk5ut6RvsYqKVpaS
 cYwmbdowYY3EgenPFK1jKPg+dZJGTXKg0PBYExrUlxCQqfacJ6ldWV+kpo/jb7TLbcxHxT
 /n+d+/Tqxf7S0ZdxDj/ctNly+iVyYCM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-idxw-bOCM_uohB6_8KvW5A-1; Thu, 26 Sep 2024 20:14:09 -0400
X-MC-Unique: idxw-bOCM_uohB6_8KvW5A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e09b55778fso1713423a91.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 17:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727396048; x=1728000848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxkK39iWIhBklipRPm+D7bJoC3g+gRtIqmTFuPN8jd8=;
 b=JA25cDozWT+k7C6pqWbnK6CXLggkC2wHuL7y13lRIaccKG5Eb0a3rDZaf/GnsU0Yc+
 FVr4Ze+c78Pqk1Ic4V7NtMFAg7sJRGiJpcA3ayl4V+dmISZKj7hlsMJbcKOGdhD02QeC
 3d7ATyiEynUsuXgzBdN9oy7SrJ0aG3M98fjwOMDMMfPFWhYRcMldBjiW6Ka5DRyh052Z
 rsMGKCZP2uo23yzU075hV1YPZOSF03R50dJQwqBwBNBivLleNCm6grglDGY10ErREJcO
 E4pe3q5Py69Gz4ikozqPkh62qoxmIqg11ikt2YsqWR5TKDrN6qLjVjwC5Ea6IpTuklzD
 RquQ==
X-Gm-Message-State: AOJu0YyYMz7Zla6uLc7cLKEsJteqdmD0Qr48tfG03hm05jcPLnBZzeBV
 SiFTKT9mSeX9eHJrTd4rN+owaL44OJo93sw/8VetDu1EoGkKL54kgmI+rpP7Ow8KIkPefhq5cvI
 KIPu1WDOjrPTail0BSBH2JO8vuF87VuuS8zj+zroc/kXfy3sfxkAeJOj2687CdS+kkNPXDJb3QU
 Dtc1oOeinR8DhNUXqcb6ogLme60WM=
X-Received: by 2002:a17:90b:3d2:b0:2d8:8ab3:2889 with SMTP id
 98e67ed59e1d1-2e0b89dec14mr1764237a91.11.1727396048285; 
 Thu, 26 Sep 2024 17:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzJPe3rWJEWpPXcRdQI0Oyz8/V+GyLlZClnc1VU6Yyex6eXSed6jOrjZziym6guegBaIUuBOWv+rsFU3u+KKg=
X-Received: by 2002:a17:90b:3d2:b0:2d8:8ab3:2889 with SMTP id
 98e67ed59e1d1-2e0b89dec14mr1764198a91.11.1727396047803; Thu, 26 Sep 2024
 17:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-3-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-3-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 08:13:54 +0800
Message-ID: <CACGkMEuj5+HVa-kK3yow0SUtXSg047f5nCvWdT3qcQ9pDTVyCQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] intel_iommu: Make pasid entry type check accurate
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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
> When guest configures Nested Translation(011b) or First-stage Translation=
 only
> (001b), type check passed unaccurately.
>
> Fails the type check in those cases as their simulation isn't supported y=
et.
>
> Fixes: fb43cf739e1 ("intel_iommu: scalable mode emulation")
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


