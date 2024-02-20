Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76458C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNUc-0001y8-LF; Tue, 20 Feb 2024 05:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rcNUa-0001xb-TO
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:36:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rcNUY-0001GJ-Pp
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708425410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZ1/3do3csR+939GBQz7EblHL3Am9aGcs6d7LZRxae8=;
 b=DzAcv/wvC4KqupNEQsVw/BbAlHtgAQ4bEKXgOBKDMAxESiJ/oPszCaXDoGR0Z6CVZSBHZ1
 /gzZlRGHY7AkQlLca+8pCooTLVbW9pZUIBPO2h9NV84WQoKr4cgwkx4nWRx7MEX1mcq7vB
 svBxp+iYTZvoQn+FgUKUcxFb6KwiQuQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-0RNgF6r8OM6Q2MrGcRrRqA-1; Tue, 20 Feb 2024 05:36:47 -0500
X-MC-Unique: 0RNgF6r8OM6Q2MrGcRrRqA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-411c650ec25so30601315e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 02:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708425406; x=1709030206;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IZ1/3do3csR+939GBQz7EblHL3Am9aGcs6d7LZRxae8=;
 b=tfnkvYWkcxjX9cz5pJoPetalfCz20qei8Wgqb6wyiJT56EsLAJtUuB0i3T0Pvmjbq5
 bnv08jxoDxvuUk2HEnaVposrzu2lgBa2t9A5YYfzyS16W2i9lBcy/+30bAes0ueV1Tzk
 q7Rqwkl87VtW71kPGHo+LhbeDvJsQKBLHqP3JBjAg6kVPandSw8Q/Bm2qKuDOrQOGVdl
 Y/rpWd3ZQtxFCzsc9t6rt0O5M824JeCd9JK0sX7qUVdgxK05wI9hHIiBZCqnC01aDU0e
 A2UNgVd1rakts4Zd81Qt/48/EJPvusto+patC5AkzR9aTlO/REk4hitxeRcdS/NlorA1
 F0SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSXMalGAKJXt0Q6Sd0cV7WH7RplqMZwPYsJ6FqBmdjz+p5i1q7OIKU+D1t8dF8Zha1Z3/SAiuQJ4srXnasFP0M/aSgbB0=
X-Gm-Message-State: AOJu0YyXI4pBorAHh2+/afeY+Q+dPiZTIu0KCBss1w0NsZJgxOySB6NX
 Z5ZeCklWKizqTf+lzNoBzLWlSo8mYZgPJiilQi8y4ZKDzvanjJg8W6DYCaI07YAhrNTm3P4ydbO
 FAkZ7pwIRAJ5LLxQGlqKXdFNwrs9/oQbVyKF3kcwWrKmAjovtwpKG
X-Received: by 2002:a05:600c:3147:b0:412:5af3:bf4f with SMTP id
 h7-20020a05600c314700b004125af3bf4fmr5111184wmo.4.1708425406630; 
 Tue, 20 Feb 2024 02:36:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExcnrculQ+vehXsnDUiL1NBTflE+xykEai/C0tZgcgysZpzVYfM8qQ7o6D47W0OAKma1Fk/w==
X-Received: by 2002:a05:600c:3147:b0:412:5af3:bf4f with SMTP id
 h7-20020a05600c314700b004125af3bf4fmr5111168wmo.4.1708425406224; 
 Tue, 20 Feb 2024 02:36:46 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:1376:5352:3710:49bb:419e])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a7bce91000000b00412656ba919sm6346436wmj.20.2024.02.20.02.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 02:36:45 -0800 (PST)
Date: Tue, 20 Feb 2024 05:36:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Hongren (Zenithal) Zheng" <i@zenithal.me>,
 "Canokeys.org" <contact@canokeys.org>
Subject: Re: [PATCH v1 01/21] docs: correct typos
Message-ID: <20240220053538-mutt-send-email-mst@kernel.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <135bbfcb6dd09377cfd39fb73c862cd0fb66bb20.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <135bbfcb6dd09377cfd39fb73c862cd0fb66bb20.1708419115.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 10:52:08AM +0200, Manos Pitsidianakis wrote:
> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  docs/devel/ci-jobs.rst.inc      | 2 +-
>  docs/devel/docs.rst             | 2 +-
>  docs/devel/testing.rst          | 2 +-
>  docs/interop/prl-xml.txt        | 2 +-
>  docs/interop/vhost-user.rst     | 2 +-
>  docs/system/devices/canokey.rst | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
> index 4c39cdb2d9..6678b4f4ef 100644
> --- a/docs/devel/ci-jobs.rst.inc
> +++ b/docs/devel/ci-jobs.rst.inc
> @@ -147,7 +147,7 @@ Set this variable to 1 to create the pipelines, but leave all
>  the jobs to be manually started from the UI
>  
>  Set this variable to 2 to create the pipelines and run all
> -the jobs immediately, as was historicaly behaviour
> +the jobs immediately, as was historically behaviour

as long as we do this let's fix grammar too?

as was historically the behaviour

>  QEMU_CI_AVOCADO_TESTING
>  ~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
> index 50ff0d67f8..a7768b5311 100644
> --- a/docs/devel/docs.rst
> +++ b/docs/devel/docs.rst
> @@ -21,7 +21,7 @@ are processed in two ways:
>  
>  The syntax of these ``.hx`` files is simple. It is broadly an
>  alternation of C code put into the C output and rST format text
> -put into the documention. A few special directives are recognised;
> +put into the documentation. A few special directives are recognised;
>  these are all-caps and must be at the beginning of the line.
>  
>  ``HXCOMM`` is the comment marker. The line, including any arbitrary
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index bd132306c1..aa96eacec5 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -728,7 +728,7 @@ For example to setup the HPPA ports builds of Debian::
>      EXECUTABLE=(pwd)/qemu-hppa V=1
>  
>  The ``DEB_`` variables are substitutions used by
> -``debian-boostrap.pre`` which is called to do the initial debootstrap
> +``debian-bootstrap.pre`` which is called to do the initial debootstrap
>  of the rootfs before it is copied into the container. The second stage
>  is run as part of the build. The final image will be tagged as
>  ``qemu/debian-sid-hppa``.
> diff --git a/docs/interop/prl-xml.txt b/docs/interop/prl-xml.txt
> index 7031f8752c..cf9b3fba26 100644
> --- a/docs/interop/prl-xml.txt
> +++ b/docs/interop/prl-xml.txt
> @@ -122,7 +122,7 @@ Each Image element has following child elements:
>      * Type - image type of the element. It can be:
>               "Plain" for raw files.
>               "Compressed" for expanding disks.
> -    * File - path to image file. Path can be relative to DiskDecriptor.xml or
> +    * File - path to image file. Path can be relative to DiskDescriptor.xml or
>               absolute.
>  
>  == Snapshots element ==
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index ad6e142f23..d1ed39dfa0 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -989,7 +989,7 @@ When reconnecting:
>  
>     #. If ``d.flags`` is not equal to the calculated flags value (means
>        back-end has submitted the buffer to guest driver before crash, so
> -      it has to commit the in-progres update), set ``old_free_head``,
> +      it has to commit the in-progress update), set ``old_free_head``,
>        ``old_used_idx``, ``old_used_wrap_counter`` to ``free_head``,
>        ``used_idx``, ``used_wrap_counter``
>  
> diff --git a/docs/system/devices/canokey.rst b/docs/system/devices/canokey.rst
> index cfa6186e48..7f3664963f 100644
> --- a/docs/system/devices/canokey.rst
> +++ b/docs/system/devices/canokey.rst
> @@ -14,7 +14,7 @@ CanoKey [1]_ is an open-source secure key with supports of
>  All these platform-independent features are in canokey-core [3]_.
>  
>  For different platforms, CanoKey has different implementations,
> -including both hardware implementions and virtual cards:
> +including both hardware implementations and virtual cards:
>  
>  * CanoKey STM32 [4]_
>  * CanoKey Pigeon [5]_
> -- 
> γαῖα πυρί μιχθήτω


