Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F90CEBF69
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 04:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2H8-0002hP-V9; Fri, 27 Sep 2024 00:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2H7-0002fu-KD
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2H6-0006FL-6L
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUtLn6mEP9jXNcxiSkfFT1wOD+LMw57OEZ4rKSa6gWQ=;
 b=FMECw8lSA/EIvWU1/g+ffC6szcEHYcZWQj6PYqgOXriOBdn98QP3uwVNz2a+XW3DEab2Zj
 /SyhITCBe4GWPNuUtW9uCOn7yvQDoAAV0v1QIfpGDVJ17HiDW2oajeYKPlaK9IfUx/RDw5
 PYrqZZ6YQfm8cbfbDtaJkEhTjycwzkY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-ehLebv4KP22xl5NuH8Vz7A-1; Fri, 27 Sep 2024 00:08:07 -0400
X-MC-Unique: ehLebv4KP22xl5NuH8Vz7A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e072f4300cso2282457a91.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410087; x=1728014887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sUtLn6mEP9jXNcxiSkfFT1wOD+LMw57OEZ4rKSa6gWQ=;
 b=BE3EEzBf0qYKGDlwAh1fuBPb+BDgQxHmdK2Fjs48TZT53n9tB3PCRp25ayJ/sRtAJC
 HuZ7HS4mYSPYQWWwMBl5tqMSQBOKYRrUcgm/ik4XJ5P6aEu1N9FRIz3evEcsVc0NvvXw
 d9pTTH56xIPYK422JzBpjgKuMgd/9mEpIUQh9pfMfgwNWjNi6yCA0QMiwneeIIN+RzKm
 q2gS4rmLbuIjzptbtmt3wjz06jUxAxfy5ffKFad3T+vFmV3X5XRW5q5k5H0SxKRtcXr9
 3pgynBwpL/R5n3KhwBMhVMcBROj5n5rHr0RtLHGxV46PzHetCI+IfD9iG8hjQQBJCd+P
 vwbw==
X-Gm-Message-State: AOJu0Yx7jiL2ZBghO6CnGIZvVjcHQG0ll6d1tcyS8NZuoaLd96GLMqKv
 AUcgM2Nhu/04UQfgg2MLMzcgEaxWq1yfMdJGwXEBG0gCT62QDlVMQ52cRp9OsI4Q+C9djVJuW7d
 Cziw7Qnn1wQ7MrpWQCk4qDSoEHTR3MxfHPry4O4x1zgQ+O2Jq95q9RU8j9NodK4snk5JS5bTOJP
 1sfQvDQO4JCEil8tbk5tCIgphZWI8=
X-Received: by 2002:a17:90a:2d89:b0:2da:5acb:5b76 with SMTP id
 98e67ed59e1d1-2e0b8c42223mr2372269a91.23.1727410086833; 
 Thu, 26 Sep 2024 21:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzeTlrLgBJdduA4DgIe748utw0KK5PmFMBJrdZtAY8L79tg/Ht9DDQZK2vABspJkK++8a2UVntRZtPH0TXZyo=
X-Received: by 2002:a17:90a:2d89:b0:2da:5acb:5b76 with SMTP id
 98e67ed59e1d1-2e0b8c42223mr2372248a91.23.1727410086323; Thu, 26 Sep 2024
 21:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-8-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-8-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:07:53 +0800
Message-ID: <CACGkMEt5dv-Hs_89Ev2XkAuve_wbX37_=2FBrLLZP6DXzTHKyg@mail.gmail.com>
Subject: Re: [PATCH v3 07/17] intel_iommu: Check if the input address is
 canonical
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
> From: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
>
> First stage translation must fail if the address to translate is
> not canonical.
>
> Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.c=
om>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


