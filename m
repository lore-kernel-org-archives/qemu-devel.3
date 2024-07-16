Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C857C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThtq-0004F9-CL; Tue, 16 Jul 2024 09:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sThtj-0003n4-1o
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sThte-0000ED-T5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721135226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+fRnieW3dWh1aYlC001+e9YMQMnaILD8TJMecrXq1Q=;
 b=CPNxAyf8EH/9s0fNCd9CQ5P5xFo6b4vMLFBuFe3GDHQ2yjU9WIKCEfdm0wDgM3lB1sxrHW
 15uAQXrO/nsVybIxTDQtAnGJzbzDgmciHRTMUtcuDjf+ZjIE+zGzd2HqZM7Hw4BbGRVrE/
 lG8u41h0+qOr+99f1CRk76XWKIHNGoY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-_6apBf0MNI-kTGTzh6cJPw-1; Tue, 16 Jul 2024 09:07:05 -0400
X-MC-Unique: _6apBf0MNI-kTGTzh6cJPw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-368255d4bd8so486811f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721135224; x=1721740024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+fRnieW3dWh1aYlC001+e9YMQMnaILD8TJMecrXq1Q=;
 b=m0Dgfe+i9GM7xpzu6I621yQ6qG2DtaRl0pFHit5hJmOBuO00+oFyr1Ex4aO7OAYwfc
 RfqvCFWfLAJ21AD5nqRIjBoFNcg7XUlmuUzqTTmbt0WfjBAC57rhpvIeqb/YJnwSsMfs
 XBoY1sDyyyZxzUHX5tP+DY39byfVkPY0LuIbXFitsPKXMWf2mI/EyZqm5tzq+B2qHykf
 QTkiQ4n++3gEXxt/kCQkzHgL5FV4r9KWFJEdjfREIdzfTm0OxEXoKLMM/k4LeB1Q3GCh
 MZUquXjWTY+XZJzfdLbkFUdCi2VeyI8CNmTSt4raUkwTHNI2jl6CwObNj7d6r2DP7cye
 Wnaw==
X-Gm-Message-State: AOJu0Yy86sAMD4bQCe3p0GcT9oE4hws5pr9dtLI8425ikn4XPt5Jw8T4
 G+tIZGngow2/1YWv1vLaNZwCwAyo7BblHCpsL8Q9JNj7eyVrbl9E4LG+UF3QjY/sxYkiURVBFbW
 WE3rb4P239ReYLv69YNuz6ds4M5FXhEi/PV5O9yGjNTizseH94Olg
X-Received: by 2002:adf:f843:0:b0:367:9769:35a5 with SMTP id
 ffacd0b85a97d-368260c3613mr1266163f8f.7.1721135223934; 
 Tue, 16 Jul 2024 06:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbUtFdSNv+pvbWCKkIKSMh3cN1Qbg4+++4asLI5zLTizqLIpTMvDMAsbHnEIe70zD7PTOy+g==
X-Received: by 2002:adf:f843:0:b0:367:9769:35a5 with SMTP id
 ffacd0b85a97d-368260c3613mr1266139f8f.7.1721135223380; 
 Tue, 16 Jul 2024 06:07:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:360d:da73:bbf7:ba86:37fb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb91csm9103894f8f.74.2024.07.16.06.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 06:07:02 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:06:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH] tests: increase timeout per instance of bios-tables-test
Message-ID: <20240716090554-mutt-send-email-mst@kernel.org>
References: <20240716125930.620861-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716125930.620861-1-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Jul 16, 2024 at 02:59:30PM +0200, Igor Mammedov wrote:
> CI often fails 'cross-i686-tci' job due to runner slowness
> Log shows that test almost complete, with a few remaining
> when bios-tables-test timeout hits:
> 
>   19/270 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
>     TIMEOUT        610.02s   killed by signal 15 SIGTERM
>   ...
>   stderr:
>   TAP parsing error: Too few tests run (expected 8, got 7)
> 
> At the same time overall job running time is only ~30 out of 1hr allowed.
> 
> Increase bios-tables-test instance timeout on 5min as a fix
> for slow CI runners.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

We can't just keep increasing the timeout.
The issue is checking wall time on a busy host,
isn't it? Let's check CPU time instead.

> ---
>  tests/qtest/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 6508bfb1a2..ff9200f882 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -1,6 +1,6 @@
>  slow_qtests = {
>    'aspeed_smc-test': 360,
> -  'bios-tables-test' : 610,
> +  'bios-tables-test' : 910,
>    'cdrom-test' : 610,
>    'device-introspect-test' : 720,
>    'migration-test' : 480,
> -- 
> 2.43.0


