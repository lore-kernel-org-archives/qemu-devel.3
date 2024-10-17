Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB9DD2F7F6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KXw-0001wi-Jg; Thu, 17 Oct 2024 03:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1KXv-0001wS-2b
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1KXt-0003Wt-2E
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729148619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmhZsvDNgXV9ZLdsHxRdUcqIrF14uyfLqF09SPmyBOE=;
 b=aiWf+Oajeo9mbT89C/hMROmmfK/dpaTvS2UsdTz/Kc/EPYhJCAb2tPPtCvofHqT25eJwPh
 UWRWaz60iqvBSidHVLKdz5XLwDWloq77qKlaofBTNR8uESASqkUNXQL7o0FkefPm+XrmrL
 ERkGa76fEhgpd0//meULj9mg6X7hO70=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-qVTCXQHFM7OgnXXwPERSIw-1; Thu, 17 Oct 2024 03:03:38 -0400
X-MC-Unique: qVTCXQHFM7OgnXXwPERSIw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5eb64c95e58so617197eaf.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 00:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729148617; x=1729753417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmhZsvDNgXV9ZLdsHxRdUcqIrF14uyfLqF09SPmyBOE=;
 b=oySiTCs6sfOnqaAptrKtxmXoEtxgvSpH7clBojQYcjm3nQxMkMneOo/uv4dlSWVZCU
 DZqUMyzIpNn70GfXd/2K3tnRlByTSbLepKmhwNXtXlZ1H81z+Oq9ymv33JYxlnRRrWD3
 vYr4Ttlh46ia9MxueTPS9s3bsN9N4LI30hKuGBVyIjJoDPGYUFtLCmfBd3MIB8VWzgto
 /26lndGUROKOYK5xNNMuA4hjiMN8jabtqW7PxGtzlDcxAq++bfTYGAU3DGr1JG2zALDy
 2X7aK40O1UQbFJvVetH7e0mhRTOLf5dvljuvYXnk+fmM5kDOa0sLr5BGIbAHgqvHX/qf
 mMNA==
X-Gm-Message-State: AOJu0YyjxPerhe3tOL2V3LyN7zbQHxOeOt4EEk57TWHLVNDbVev1mtmX
 96+3D39ogUoAGersHI3kdmKBZ+pc70yhannVkQWWWLDmA1T7iG2xVvbFy1OrEQufeAvWRkI5BQq
 GzL2WIUM5l5bjweP3bvftX+eHozmqWSGQvGbHCft3pCG2BWdH2aHEKi9h5MVJWpxHLhC82V610W
 gE0B8abApE8huCmil+/8y7TVGu4/I=
X-Received: by 2002:a05:6358:5922:b0:1c3:9572:5c9c with SMTP id
 e5c5f4694b2df-1c395725fccmr10339855d.23.1729148617683; 
 Thu, 17 Oct 2024 00:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf/HYRw9v5cKirPBxboUn5nTWqcR/Khcb4VakjQx1M5eOCcV+YDZC0GChXbnvv/rpzx0DnliDWpC8a4TswNjo=
X-Received: by 2002:a05:6358:5922:b0:1c3:9572:5c9c with SMTP id
 e5c5f4694b2df-1c395725fccmr10336255d.23.1729148617271; Thu, 17 Oct 2024
 00:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241010075354.3582221-1-zhenzhong.duan@intel.com>
In-Reply-To: <20241010075354.3582221-1-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Oct 2024 15:03:25 +0800
Message-ID: <CACGkMEt+M=nEiivOM4OPm6jxe9ygDm-41nDxQUCBMskETFAO8Q@mail.gmail.com>
Subject: Re: [PATCH v2] intel_iommu: Introduce property "x-stale-tm" to
 control Transient Mapping (TM) field
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, chao.p.peng@intel.com, Yi Liu <yi.l.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
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

On Thu, Oct 10, 2024 at 3:57=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> VT-d spec removed Transient Mapping (TM) field from second-level page-tab=
les
> and treat the field as Reserved(0) since revision 3.2.
>
> Changing the field as reserved(0) will break backward compatibility, so
> introduce a property "x-stale-tm" to allow user to control the setting.

Nit: I think we probably don't need the x prefix? As we try to
maintain the compatibility via:

> +    { TYPE_INTEL_IOMMU_DEVICE, "x-stale-tm", "on" },

?

Thanks


