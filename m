Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C34CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5Fd-0000HK-8F; Tue, 24 Sep 2024 09:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1st5FH-0006lW-3X
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1st5FB-0000RZ-Nw
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727183176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8MvGZCDnvu3YloI81vW9SfEzPc+oP5DXTaxW1XN6+9A=;
 b=aBqrnLWAPY4l21oHd+VdJoY4n++K/4QvMP2cmv6wCVFe3xohe/tc8/fxxB7Fmf9GtYPp+V
 enzVqVJQUvdSzwXfTiDY2OjZtFgDpevICr2Zy/l+P5DTgtvdR1DJlR2tYpNX1uAJ386tIX
 bXqzsVC2zn+p8ad3HKp41xqQHRQsAMQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-zC68HCHrNZmtCcW0doat9Q-1; Tue, 24 Sep 2024 09:06:15 -0400
X-MC-Unique: zC68HCHrNZmtCcW0doat9Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374aef640a4so1902908f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 06:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727183174; x=1727787974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8MvGZCDnvu3YloI81vW9SfEzPc+oP5DXTaxW1XN6+9A=;
 b=C8FuDMPlcT3HK616LFieEf08ZlAmln3UMyDeVWkgZl6oYh60NYtzzSYgUtfRYl7/d1
 RKTcwUR/g9KdIItQLpBqFOzyLrMKk1XIaYg5iV6JGahHmiMC1pAukZjfTlu7yIWRBlQm
 iP6Dz3DPKQBgtFTls5l/oOwNmPibNft5vOboB+Qn+tQPE+Y6yPbc3VgUX/VgbBXwKxI0
 vciZXzfaD2jkRMWcUNWdFjvicjdA8hBFFXyxzxMasDzHHn2FXIMCWi0mGCgBZae6SFAH
 VV6V17ZHFTkaVVBLZseZo1VT0Gna9WKLmZL+HqAu13jRnTaapw1j+mxwcpzSjA+KUa26
 jnGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxYm3oz4c5xCDQsb6zSGJ7j1CR6LxkqywvryhQ6hk5GaPZd5w/mBlRw4tChrfNKKUHsacZ9pFuP05h@nongnu.org
X-Gm-Message-State: AOJu0YxOCPLGfcjir0+W+qfmqBS6XhZErU9O9IAQGZs+PLY2Mk/CC4sT
 Rk0Z46AlW3hLWi52xgAzxfsAL7R+PFMaV43gkKTMwXC2UDrDgw2yZngxFPd8Ljwp5TOclNa6saI
 0wuzRBFME4Vx6ApCia/R0eeDPHYLFO5RJ20aKDFIc6mrbau0i5uKa
X-Received: by 2002:a05:6000:50b:b0:374:c8a0:5d05 with SMTP id
 ffacd0b85a97d-37a431a6ba2mr7973640f8f.50.1727183174096; 
 Tue, 24 Sep 2024 06:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdebWosvPix4Q/Ak6DqY3DHVUAnxlh0E+P06fHSejAcP2xc3J2sYMq8OM3iOUpy6EufWXFmw==
X-Received: by 2002:a05:6000:50b:b0:374:c8a0:5d05 with SMTP id
 ffacd0b85a97d-37a431a6ba2mr7973619f8f.50.1727183173664; 
 Tue, 24 Sep 2024 06:06:13 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2ab52fsm1546026f8f.13.2024.09.24.06.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 06:06:13 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:06:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/3] hw/i386/acpi-build: return a non-var package from
 _PRT()
Message-ID: <20240924150611.42f04215@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240922143216.662873-3-ribalda@chromium.org>
References: <20240922143216.662873-1-ribalda@chromium.org>
 <20240922143216.662873-3-ribalda@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
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

On Sun, 22 Sep 2024 14:31:10 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Windows XP seems to have issues when _PRT() returns a variable package.
> We know in advance the size, so we can return a fixed package instead.

XP doesn't support VarPackage, if you attach with wingdb to guest,
you'll likely will see ACPI related error 
 
> https://lore.kernel.org/qemu-devel/c82d9331-a8ce-4bb0-b51f-2ee789e27c86@ilande.co.uk/T/#m541190c942676bccf7a7f7fbcb450d94a4e2da53
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Fixes: 99cb2c6c7b ("hw/i386/acpi-build: Return a pre-computed _PRT table")
> Closes: https://lore.kernel.org/all/eb11c984-ebe4-4a09-9d71-1e9db7fe7e6f@ilande.co.uk/
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  hw/i386/acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4967aa7459..e7db51afba 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -741,7 +741,7 @@ static Aml *build_prt(bool is_pci0_prt)
>      int pin;
>  
>      method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
> -    rt_pkg = aml_varpackage(nroutes);

I'd add an assert here, to make sure that nroutes < 256

> +    rt_pkg = aml_package(nroutes);

Given that nroutes is 128, older Package should be able to
handle it.

>  
>      for (pin = 0; pin < nroutes; pin++) {
>          Aml *pkg = aml_package(4);

With assert added,
Reviewed-by: Igor Mammedov <imammedo@redhat.com>


