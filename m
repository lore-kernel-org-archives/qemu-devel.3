Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA9FC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 14:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl8L3-000202-64; Fri, 15 Mar 2024 10:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rl8L0-0001zV-5b
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rl8Kt-0005bk-EK
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710512102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1364j2VhZB6bZhx3dW4KI7A3t7vXn+5+aieG8tbcDE=;
 b=a5iZ+pvlWI3hNbHicgptTFKGnjb2/x/q9YsY0aT1jbUH0CIiLIUBFZUft8JfIJKF6y1B6z
 WELQj+xNTBuR0lcOA4CFu1TS9NdcxRwRduypXKLl15ISIcqdizsmwZnU5dUMK+zjTlcd2W
 eM+qAVGQ+mKbdJxrjll3tJa3meN1YOU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-Z4j6xV0fN9K2mE4iAZV98A-1; Fri, 15 Mar 2024 10:14:58 -0400
X-MC-Unique: Z4j6xV0fN9K2mE4iAZV98A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B89A2185A781;
 Fri, 15 Mar 2024 14:14:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E923200AFA5;
 Fri, 15 Mar 2024 14:14:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E90FA1800DD4; Fri, 15 Mar 2024 15:14:55 +0100 (CET)
Date: Fri, 15 Mar 2024 15:14:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Alistair Francis <alistair23@gmail.com>, Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>
Subject: Re: [PATCH 02/12] uefi-test-tools/UefiTestToolsPkg: Add RISC-V support
Message-ID: <f6wp7r5e6covd5bjubvqcvwvhgur25yjxcqxg54ivlfhwencme@gtyxkxji3ear>
References: <20240315130519.2378765-1-sunilvl@ventanamicro.com>
 <20240315130519.2378765-3-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315130519.2378765-3-sunilvl@ventanamicro.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 15, 2024 at 06:35:09PM +0530, Sunil V L wrote:
> Enable building the test application for RISC-V with appropriate
> dependencies updated.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Gerd Hoffmann <kraxel@redhat.com>


