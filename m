Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55A2C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUiDU-00028Y-JX; Tue, 30 Jan 2024 02:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUiDF-00022b-7r
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:07:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUiD5-0005Y8-KL
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706598423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFr3Z7NS3DfQTTHL0+5S1w4ffjKG9+5WemNBBmP8Xpw=;
 b=LNpiVaIEyHnihFAFO4uvvpYEisV+bOhB54cMogt8rLrVXHqzhatGD+9SVoS/GmXipMgV+x
 eTo/DwtgBmQavS/Y6pulaDxqpxX9LoN2/o9TXMYDDdCPP2jQRpc2uGwpOvxkldY+75pmzH
 jNgwFg5UMQ7rseuCTQx6qEMuK9Mp5C0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-U5lgktkHNKawxIlG1-I7fg-1; Tue, 30 Jan 2024 02:07:01 -0500
X-MC-Unique: U5lgktkHNKawxIlG1-I7fg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1d542680c9cso25888375ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706598420; x=1707203220;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFr3Z7NS3DfQTTHL0+5S1w4ffjKG9+5WemNBBmP8Xpw=;
 b=RlSzlzP6JeiNeNJNrng0UBZeyU1NB0QLjpsbYW1/9v5dRwrbR/otYEs0TTrvUoy3v+
 kdqjHKdv6AeafnyjGOcZunfQ3ey/+3DbayO+kgDfWzNpdwzaJ5dCpzh9weXleNeAaMNj
 9wm2RPZYi1pdDhXfTzUTT3fXtHOy1BP+GvjHG9jDqfO1Rd4eqlCe0Yx9PTZIBIB6RT/N
 kn5QyEgY15bScIav3zP7dHhp9TWAhwmzTpbF7w73K8Za+lN5/c4pMNjftCWjP5KFL8Gh
 TiHagkvCp06GpXwGWvlls9sKKLlHt3ACQUClR69Q/sLnFN0Dj2eFvvC77D+OIjO0wKQf
 n+6w==
X-Gm-Message-State: AOJu0Yw5eCrSEbPZF1GmqHPEdp26A5XXrVOuSbm5vbGwKTE2bPEGfdtn
 o8z/OR/RdHguwSYkvUzyVOOK3ckpxyxj3Gi/Af09WE3ghqVhziL2tSys6020f/NhyWdOxBP4s4G
 swyUHh5t1KYAekGyJ6MyLuUze3sr7+o56KkXImWioV6D3UhKwaBVJ
X-Received: by 2002:a17:902:654e:b0:1d8:f249:4401 with SMTP id
 d14-20020a170902654e00b001d8f2494401mr2116188pln.9.1706598420143; 
 Mon, 29 Jan 2024 23:07:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5TxAp6y+fxY/856vsuOcMUCK2LrJHaD3ZfrsYFJsa404V90ovqb//soqwekwewmn47k/JuA==
X-Received: by 2002:a17:902:654e:b0:1d8:f249:4401 with SMTP id
 d14-20020a170902654e00b001d8f2494401mr2116184pln.9.1706598419823; 
 Mon, 29 Jan 2024 23:06:59 -0800 (PST)
Received: from smtpclient.apple ([115.96.128.50])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a170902f20200b001d73ac054a0sm6487629plc.33.2024.01.29.23.06.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:06:59 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v2 1/2] hw/smbios: Fix OEM strings table option validation
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240129-smbios-v2-1-9ee6fede0d10@daynix.com>
Date: Tue, 30 Jan 2024 12:36:45 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Content-Transfer-Encoding: 7bit
Message-Id: <22DE3A91-D986-410B-B9A4-096C01920F7F@redhat.com>
References: <20240129-smbios-v2-0-9ee6fede0d10@daynix.com>
 <20240129-smbios-v2-1-9ee6fede0d10@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



> On 29-Jan-2024, at 13:33, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
> qemu_smbios_type11_opts did not have the list terminator and that
> resulted in out-of-bound memory access. It also needs to have an element
> for the type option.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 2d6dcbf93fb0 ("smbios: support setting OEM strings table")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Ani Sinha <anisinha@redhat.com>
> ---
> hw/smbios/smbios.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 2a90601ac5d9..522ed1ed9fe3 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -369,6 +369,11 @@ static const QemuOptDesc qemu_smbios_type8_opts[] = {
> };
> 
> static const QemuOptDesc qemu_smbios_type11_opts[] = {
> +    {
> +        .name = "type",
> +        .type = QEMU_OPT_NUMBER,
> +        .help = "SMBIOS element type",
> +    },
>     {
>         .name = "value",
>         .type = QEMU_OPT_STRING,
> @@ -379,6 +384,7 @@ static const QemuOptDesc qemu_smbios_type11_opts[] = {
>         .type = QEMU_OPT_STRING,
>         .help = "OEM string data from file",
>     },
> +    { /* end of list */ }
> };
> 
> static const QemuOptDesc qemu_smbios_type17_opts[] = {
> 
> -- 
> 2.43.0
> 


