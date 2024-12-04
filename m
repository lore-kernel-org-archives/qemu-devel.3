Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3631EE7716E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIerN-0003lW-NL; Tue, 03 Dec 2024 21:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tIerJ-0003l2-RH
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tIerH-0005M0-HJ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733278275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KXqjIe26rxk5vzp7K0TLSIYpHWSzvgq1ApEU4iECR4=;
 b=HngkPKgbC90zBLHgIO/NnzR0MpRfNxUOlnBIoLK/ghaLBhd9uplActLtbYBmxL6VLuMeuV
 NoroJCVrEiggXZIEpZhXcAfn+B6QutfFb9t1KPwx3aw8LqlBUoq5bv/5qPBq50WtNCPrW1
 sPufAfErM0gYp9jGkqQw74aenTIPtcY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-HtZdpL2MO5y0Vaarj1DrWQ-1; Tue, 03 Dec 2024 21:11:14 -0500
X-MC-Unique: HtZdpL2MO5y0Vaarj1DrWQ-1
X-Mimecast-MFC-AGG-ID: HtZdpL2MO5y0Vaarj1DrWQ
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ee5668e09bso5288620a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 18:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733278273; x=1733883073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2KXqjIe26rxk5vzp7K0TLSIYpHWSzvgq1ApEU4iECR4=;
 b=P8EhM2y4D/HXyRSmhwGzhirhwuVMBwPku6BbjEfWuXKES3+jV4ClHi/M9DFxB5Z1Jd
 hMgjM2PkFBPTRqllh1jk79zl6fT1Zy8z4sIU7FFns0vm5BySatZ7WSS66UNyNhVnzkMa
 vscj0hPrggbORrAsuabhEbUJoo4lR2vMJzDiDw1FR+/WpXBJa0rZVDcBIYgqpvvkh8AG
 pn+eSsm0F4c0alxaq53dydLlO4rdhzPzeGMfNo4brrw0QDG3lMLk+LP6zbSHnA6GNkvi
 W38d0hst3qOx+dIqtj6fYOjarOK8dUGs0ecXwhK8Asv0OEClfqPw4iUYAFAr8yhrUseM
 95eQ==
X-Gm-Message-State: AOJu0Yyoe7U+5MrPKVRxAMExALlkyZYQHRD+yiR1tirEJY/kp8/Oezn8
 BlKc+v3ABj97fAJC2H/Ncfffb8rZAfS7/2XqD6fGd3G912HBB/LJ4qXb6gpL63NNU05A7+02b85
 JmfntKayELOaIrGuhCnK9nlSWMvhBGFIjiG8lOZbMS2qtQed5NiXoaGDMoMbLxaTTfkAtLve42F
 KfxWAFvjAfo3PkEKCL2JHPR9NT3Uw=
X-Gm-Gg: ASbGncskQWR5YbYADcDI5xTph7AaxCDcQzX/pbllNF5y3udA6ZJsVhk4A2f3gLXSXLd
 zSg1TCFp2TiiXEaqubqkacgFExuUXGwtt
X-Received: by 2002:a17:90b:4a4e:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-2ef011e6836mr6715846a91.7.1733278273343; 
 Tue, 03 Dec 2024 18:11:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFGzWQLlXIRFA9KOjkXE+juvzkX6+xEovEGmD4jy8f79blxCWssTpxzoK9ts07zQY8YaDe6y6LBrJoOqAwHTM=
X-Received: by 2002:a17:90b:4a4e:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-2ef011e6836mr6715808a91.7.1733278272932; Tue, 03 Dec 2024
 18:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-9-zhenzhong.duan@intel.com>
In-Reply-To: <20241111083457.2090664-9-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:11:01 +0800
Message-ID: <CACGkMEuRwo+_aMkioo_=JByMtSzJq6a9VEhvCDxxRj3w-fPU+A@mail.gmail.com>
Subject: Re: [PATCH v5 08/20] intel_iommu: Check stage-1 translation result
 with interrupt range
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
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 11, 2024 at 4:38=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Per VT-d spec 4.1 section 3.15, "Untranslated requests and translation
> requests that result in an address in the interrupt range will be
> blocked with condition code LGN.4 or SGN.8."
>
> This applies to both stage-1 and stage-2 IOMMU page table, move the
> check from vtd_iova_to_slpte() to vtd_do_iommu_translate() so stage-1
> page table could also be checked.
>
> By this chance, update the comment with correct section number.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


