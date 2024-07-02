Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61602C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOYtw-0002XL-IJ; Tue, 02 Jul 2024 04:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sOYtu-0002X5-LQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sOYtt-0006hy-7V
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719909008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kC0cPw9y45v679oJEtioTuaLvA8Xl1ijXhsCgPNIk58=;
 b=NxAGq5MnJqQLLVJ035vX17OgXUGa7RuRqaiwvisfAdVzSOFG65pTyEg/feS96pt6iYOLlW
 4JVrejT0T5zCMxnFSjALBwA7o3WXDYIb3CCkadCSzK7MZ4K1ERHf/MYcsT+TORtSrwPBc6
 7QbN1VyaK6m0/oZIxzaKjFxg/3fZF7k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-sNmzDPtZNKOeD35PaeDrRQ-1; Tue, 02 Jul 2024 04:30:07 -0400
X-MC-Unique: sNmzDPtZNKOeD35PaeDrRQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36789def10eso148346f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 01:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719909006; x=1720513806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kC0cPw9y45v679oJEtioTuaLvA8Xl1ijXhsCgPNIk58=;
 b=QDrPpj5dJd1zeBbpoHo1cHD2kwB8OHu24rJzy8zrtSa04Asr0rOeu/C/3AvVFPPw1H
 /T3PjaUhQo/Bna+tU084Nn5NpQbpKoLGt7g1B7cUPZDyEwZgu4HEP7IneE+Zz0DRXybx
 mTYafp+hotSJtDY/mmphwFk7MEOwQPjnZUz14xnypSzy4LLoZqwjME+ZGeQIZP5Yo4gT
 WZ9zv4hWvkCh/pa+ZrIv3pea+BDBzDLvfxdg3n3mEGZ+6eQffB5jzNdbwl0fXZoVR0tB
 LIbEugu3on2z4KGDS4wfKPKE9MgItb4MNv1lrwsu4M66kmHQTcI6slGijjKstqTaxVQq
 CyBA==
X-Gm-Message-State: AOJu0Yz1EoLlq7UhpI8aOYuxyi3sKuo51ZGgURO+1ypsonB7o7h1xWRB
 3xOg725xvOrXsNYWZgKdxhL2TJiyziWkD55kPpMEAgBl8Axu/PaX7ArHCqv0OWtx+qKKlHhe6qQ
 qporTLIBVusfE9SFOGjjeVT+SdwQIkPiwk+O9IpNtl8LQxIWVSa7x
X-Received: by 2002:a5d:4043:0:b0:367:4b78:20d1 with SMTP id
 ffacd0b85a97d-36775698c08mr4874681f8f.13.1719909005937; 
 Tue, 02 Jul 2024 01:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH03dIYy79QRpQMabTnQ/ThNgEOXT50w1++t6ut6m/aHr/OBSxixz3kkFS6S3ZRsfuadiCl5A==
X-Received: by 2002:a5d:4043:0:b0:367:4b78:20d1 with SMTP id
 ffacd0b85a97d-36775698c08mr4874656f8f.13.1719909005603; 
 Tue, 02 Jul 2024 01:30:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fbbfesm12546857f8f.66.2024.07.02.01.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 01:30:05 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:30:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Alistair
 Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 06/16] tests/qtest/bios-tables-test.c: Add support
 for arch in path
Message-ID: <20240702103002.69a8678d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240625150839.1358279-7-sunilvl@ventanamicro.com>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
 <20240625150839.1358279-7-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Tue, 25 Jun 2024 20:38:29 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> Since machine name can be common for multiple architectures (ex: virt),
> add "arch" in the path to search for expected AML files. Since the AML
> files are still under old path, add support for searching with and
> without arch in the path.

we probably should remove fallback path lookup after series is merged.
it' fine to do it as a follow up patch.

> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>


