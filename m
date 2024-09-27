Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4094CEBF69
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 04:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2Hj-0004SE-Lo; Fri, 27 Sep 2024 00:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2Hi-0004RV-0F
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2Hf-0006Ic-0c
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/j/AxdBrkewXMOzyUEvIq4nN98IrFCYqkQ7zh0Sml8=;
 b=aWEirnEQQrGIYuw9rVqhejmVwMw5qJcdGeBN1DKHSl4jpu2TvcFoZSRkithkrUQtNe4MeK
 oooYCfunRbxeBGUHuGQ9OyaPLDlLt5g0jiWOU8i72m2rBTf340oRf97De80e5UP/6DjDEN
 2/lTJI3RASrYPFBGBhC2ORfkd1kgUZw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-HomMsMxcMsaJw8pdOxwaqw-1; Fri, 27 Sep 2024 00:08:38 -0400
X-MC-Unique: HomMsMxcMsaJw8pdOxwaqw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7174c6cbdbaso2160921b3a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410117; x=1728014917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/j/AxdBrkewXMOzyUEvIq4nN98IrFCYqkQ7zh0Sml8=;
 b=klI5kDw3rItzq5L1BqOIGTzOwf3tMkBeyaHiKW0XQ3rXKu6l7NVQHaPNRNaFiNrgbn
 S2ZWUi7uREEEwQfWM6r93BE/Edo5P9S/PrmtCG4j2MEAV6ueB3rtjtrszo172JEr0idl
 7Vp7VRG9PwxWMEvw+FhqNBcTgmLFeYHWZ9mgJIsj15q7+wbO8JtXQBGiuT4JEReCEnCG
 WlQZggIznAUXxTPp+/ypeaUPv9KNQC93Sm6zRciQyjE6TbIh+8L8NT2an0nKW7T7Gibl
 04xFEGOiZljZ/LBwA0T5VOGizcaF29FzwgM5zCFrAU6C4Z2VXDaZibXzGEFXIhk3WbVB
 S3Pw==
X-Gm-Message-State: AOJu0YzhYbk0V7ZcaOxLYkZ1ZypNGUrCiMO29KqABARe9WHqGjCJwIMo
 UNpP3DDVnrgKVUVcw6yC7q0dwDAhaRVcSn6vgFa08B99oqWYvgHC7AI/cnBTBTWjEbV179m/PEM
 9UPi6LHwo7SZJ3NQ3OQmrPUxvjvJEL90WE0132AdyMWk8LZ6px+DnRqpE1Rg+HNp6oyehizcqZ8
 o7TGCywgg4UH0LHEmcqGJcwP3oR7s=
X-Received: by 2002:a05:6a20:cd8f:b0:1d2:eb9d:997d with SMTP id
 adf61e73a8af0-1d4fa64d8ebmr2456912637.7.1727410117449; 
 Thu, 26 Sep 2024 21:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/v/hEwStb3REk4nGNgfQHycwyjuAjnHjFWJ1lr4rCphbI0/323/eUwD+gwfY7mgPTPxGQo0qd7v7xiqnOcVk=
X-Received: by 2002:a05:6a20:cd8f:b0:1d2:eb9d:997d with SMTP id
 adf61e73a8af0-1d4fa64d8ebmr2456889637.7.1727410117055; Thu, 26 Sep 2024
 21:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-18-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-18-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:08:23 +0800
Message-ID: <CACGkMEv3qADLZoxhemew9e_8HnG_xbYqDtKnVp3VqK8U9Fiq0A@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] tests/qtest: Add intel-iommu test
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, Sep 11, 2024 at 1:27=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Add the framework to test the intel-iommu device.
>
> Currently only tested cap/ecap bits correctness in scalable
> modern mode. Also tested cap/ecap bits consistency before
> and after system reset.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


