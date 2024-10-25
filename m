Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813B4D0C5EA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 08:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Fuw-0002m6-L2; Fri, 25 Oct 2024 04:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t4Fuv-0002lx-1Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t4Fut-00052O-1F
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729845809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyaXzuS4AjnXapS3OYCh/bUy2GGzqX8slW24eD3p38A=;
 b=KLx0StMB57D39u6P2HB6aRLxglJ7rDuAGin5J4nu0okvZvweZ07+8csU2heWGx8LbXBgWT
 xRMmutvz6oB2RFouR4Jiz67Cku9NJjAAIObraFmJtF55ZF7eRUHoQKkL6lFgz72g0Ejsy+
 nKeQ1nt0oD+B//ygg9cdw7xznCqXa7k=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-KMCU0YeNOa-A61BltEAPLQ-1; Fri, 25 Oct 2024 04:43:27 -0400
X-MC-Unique: KMCU0YeNOa-A61BltEAPLQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-71e5a1eefeeso2096477b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 01:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729845806; x=1730450606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uyaXzuS4AjnXapS3OYCh/bUy2GGzqX8slW24eD3p38A=;
 b=ImFVEJROC/bMZP+0d4lXm4fAQE3V4Ph3MXzTnE6Q5M/Mi5tqXC7wiOhbqC5Ivvzh03
 ryMMcct9TGqXPTgB7xRV8spRHXIo1iQ4k3N24E39CEmOgZk0FhCzlSp45Dz2gDGGHZTZ
 eCGzBCN3vtyy0eg6HPbzlPUNPzspWNGhUWUgOOA3ioYmQZ312BOCGEF3UOxBoa0vn7Rd
 SlI0x574d+YybxVYsyO2SaZpJCW32BMHp00O3lZmcfJuavio9hrGM/+0hPbP4UqtIgEl
 LWV/QpvBVmY25D96yT+Q9rik1OsdpXTUxFpWN27eqfCHcO75AFl1r1a4OvztvNlpzfVF
 uNkg==
X-Gm-Message-State: AOJu0Yz8XCPJvhYbbJ8D+Q//gFMnIpCbna0xZzzwlHzuw6WrILxEO8fP
 ym66KWcIYYq5/xmV3iBLHuGPWiOfgnqd4iQgvBQ+IAXOIdrRueWJQMdDYg4ll2zR2UkvwO3krvj
 HY6FAdAhyVfrumMLBFX3Te50x4znE0vTOy5QKHPE+AkENzPXX+EkwmONOp9y6deUU/lir+kRR7R
 dxGnXHGhvyBqfitjG4x3WV/TXyyGo=
X-Received: by 2002:a05:6a00:8c3:b0:71e:a3:935b with SMTP id
 d2e1a72fcca58-72030cd2654mr10981441b3a.25.1729845806226; 
 Fri, 25 Oct 2024 01:43:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw0YCj9BzzLR+f+n1UELatSfEtU952s89BlTAIvIvuMcT68JLjospFI3kCPDI2phmbGa2wzM+/LSdQzh4OG7M=
X-Received: by 2002:a05:6a00:8c3:b0:71e:a3:935b with SMTP id
 d2e1a72fcca58-72030cd2654mr10981424b3a.25.1729845805776; Fri, 25 Oct 2024
 01:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241023075753.580534-1-zhenzhong.duan@intel.com>
In-Reply-To: <20241023075753.580534-1-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Oct 2024 16:43:14 +0800
Message-ID: <CACGkMEvyUES7as4gnyNJZFK0omqeL4x4ULERxYXxAHH+r3FWTQ@mail.gmail.com>
Subject: Re: [PATCH v4] intel_iommu: Introduce property "stale-tm" to control
 Transient Mapping (TM) field
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
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Wed, Oct 23, 2024 at 4:01=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> VT-d spec removed Transient Mapping (TM) field from second-level page-tab=
les
> and treat the field as Reserved(0) since revision 3.2.
>
> Changing the field as reserved(0) will break backward compatibility, so
> introduce a property "stale-tm" to allow user to control the setting.
>
> Use hw_compat_9_1 to handle the compatibility for machines before 9.2 whi=
ch
> allow guest to set the field. Starting from 9.2, this field is reserved(0=
)
> by default to match spec. Of course, user can force it on command line.
>
> This doesn't impact function of vIOMMU as there was no logic to emulate
> Transient Mapping.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v4: s/x-stale-tm/stale-tm (Jason)
> v3: still need to check x86_iommu->dt_supported
> v2: introcude "x-stale-tm" to handle migration compatibility (Jason)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


