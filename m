Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CB3CEBF76
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 04:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2HY-00045H-EK; Fri, 27 Sep 2024 00:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HW-00044l-IU
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HV-0006Hj-5B
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmERbfS9JqtF9TVDtNLICsUaw8SgIpZmDQar8W7CTSY=;
 b=TI4GJRr1qMzEDM0xvPDovXHxTJ3B0sWBrRIW+89kNRhdm43wFY0Qc7EuXsazRjTDX5QNku
 YM5Bc0XBnGyxaK7uOLw5hPEUz1V8CVf/DC11v4GJvwPXSRxfZqKxwtLLJo3lLub8eBNdEr
 vrsl71SVmrwm/xa03yK2M4VpS7BNBsU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-G2yvEB0xPiuqyaeCZqBcPw-1; Fri, 27 Sep 2024 00:08:33 -0400
X-MC-Unique: G2yvEB0xPiuqyaeCZqBcPw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e0b6b4d427so678355a91.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410112; x=1728014912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmERbfS9JqtF9TVDtNLICsUaw8SgIpZmDQar8W7CTSY=;
 b=akajzf11N/USiDzHkKs5sr/95/nXrAFkEuvxttTwFcB/VEdfqNCoeLEgIFigvJmCfI
 H9VTPCjryG6KJZeWomvhbmFKG7sjnC+wjvH4ytYGTtgF2NoRNL/43RWlY71JNlab7k2t
 3gs/zpAUCxy/evfIRCIya1F5nACUFdQ/PK23eJkcvLl/mCH4xzlFriVs2VPLn/ZZhNKd
 G1vBx4eGKa73XhM6JyGbwd+rJ0SljdASxcu6vHvWZj1RQZ109j2PvxL4iZGVVt78aY6M
 2fCG/UyRn415AThtN5+79MqoRsPalTYg4AQ9MKcMQwZzrsSGZ39t1ZA29bzF/OXrJmbh
 GHnA==
X-Gm-Message-State: AOJu0Yy6qkPCRGUhWipsQeJtYNv+Aq4Npof2mh76qRwvQ5+AoPTImqbk
 NeR7EY3YR/rPuYHWlal5BNNxd+VanL6ldye+AaFseTHoQyfx/bl57mkXSFVryY3iUgUxQyeXpfd
 MFtbXiBu7Vw5JWSpohJZzu7ktFyV3k6iGVXwJsaYlEh+GxIfsdqvb8YwYBa9bBTMf4+pEtS1+Gx
 Gq8MLrdE1ymvkM3emFSX9HSdR92nU=
X-Received: by 2002:a17:90b:258:b0:2e0:80ac:8fb5 with SMTP id
 98e67ed59e1d1-2e09113ca42mr8095725a91.9.1727410112156; 
 Thu, 26 Sep 2024 21:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN+0W6qHkap3JMrYjR8motjLdrN5yevd84HGCT/l80ymx3EgCrBSR0zymgKgbNs0pQh5Zp7HgBsdov4Qc2Yqs=
X-Received: by 2002:a17:90b:258:b0:2e0:80ac:8fb5 with SMTP id
 98e67ed59e1d1-2e09113ca42mr8095679a91.9.1727410111675; Thu, 26 Sep 2024
 21:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-16-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-16-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:08:17 +0800
Message-ID: <CACGkMEutsgWhp0mrCG6A3QA1NXnMj8RFDHMKPq3eBv3WxaQ=Vg@mail.gmail.com>
Subject: Re: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be string
 option to expose scalable modern mode
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

On Wed, Sep 11, 2024 at 1:27=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> From: Yi Liu <yi.l.liu@intel.com>
>
> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabiliti=
es
> related to scalable mode translation, thus there are multiple combination=
s.
> While this vIOMMU implementation wants to simplify it for user by providi=
ng
> typical combinations. User could config it by "x-scalable-mode" option. T=
he
> usage is as below:
>
> "-device intel-iommu,x-scalable-mode=3D["legacy"|"modern"|"off"]"
>
>  - "legacy": gives support for stage-2 page table
>  - "modern": gives support for stage-1 page table
>  - "off": no scalable mode support
>  - any other string, will throw error

Those we had "x" prefix but I wonder if this is the best option for
enabling scalable-modern mode since the "on" is illegal after this
change.

Maybe it's better to just have an "x-fls". Or if we considering the
scalable mode is kind of complete, it's time to get rid of "x" prefix.

Thanks


