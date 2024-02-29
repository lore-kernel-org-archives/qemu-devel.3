Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0549EC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcKu-00084O-Kv; Thu, 29 Feb 2024 04:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfcKt-000833-0x
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:04:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfcKk-00043w-Lf
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709197445;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLGLKwN+DJbBTVe0ObBTGOPQRuqX+HnZEhfcgUHzNJw=;
 b=J0lU8xD7mw6wnFaoDZ1UzIZ6Ej5FFXhfmIsmn0XdloZp2PQTKItVLEFIzr96pzB0Dc+lzB
 ePe7b5Tn0DjbouEJRFDsAaZfrsAv+4vVPbKpg92TNBGUaPnyA1Awgd7m2F5JaT1ZBJHn9p
 0StM9r/dc84iZgHa7RuG8q/SGEGTE/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-tHha4JJfMwyHOr7Eqo82-Q-1; Thu, 29 Feb 2024 04:03:52 -0500
X-MC-Unique: tHha4JJfMwyHOr7Eqo82-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BC01106D062;
 Thu, 29 Feb 2024 09:03:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66EF82166B5D;
 Thu, 29 Feb 2024 09:03:51 +0000 (UTC)
Date: Thu, 29 Feb 2024 09:03:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH RFC 0/3] Support GM/T 0018-2012 cryptographic standard
Message-ID: <ZeBIdNQYkq4tnF7h@redhat.com>
References: <cover.1708527979.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1708527979.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Feb 24, 2024 at 10:34:55PM +0800, Hyman Huang wrote:
> This patchset introduce GM/T 0018-2012 as a crypto backend driver,
> which is applied for block encryption. Currently, we support SM4
> cipher algorithm only.
> 
> GM/T 0018-2012 is a cryptographic standard issued by the State
> Cryptography Administration of China. Visit https://hbba.sacinfo.org.cn
> search GM/T 0018-2012 for brief introduction.
> 
> The objective of the standard is to develop a uniform application
> interface standard for the service-based cryptography device under
> the public key cryptographic infrastructure application framework,
> and to call the cryptography device through this interface to
> provide basic cryptographic services for the uppler layer. For
> more information about contents of the standard, download the
> specificaiton from:
> "https://github.com/guanzhi/GM-Standards/blob/master/GMT密码行标/
> GMT 00018-2012 密码设备应用接口规范.pdf"
> 
> There are two benefits to doing this, at least.
>  * Performance - using a cryptography device for block encryption
>                  offers an opportunity to enhance the input/output
>                  performance once the hardware is certified
>  * Secrecy - hardware manufacturers may fortify cryptography
>              equipment with security features, so increasing the
>              secrecy of block encryption.
> 
> The precise way that vendors implement the standard APIs for data
> encryption using the cryptographic device is uncoupled from the
> GM/T 0018-2012 specification. Thus, if developers enable this
> functionality with the following conditions met, we could accomplish
> the general implementation:
> 
> 1. rename the header file provided by vendor to gmt-0018-2012.h
>    and copy it to the /usr/include directory.
> 2. rename the dynamic library provided by vendor to
>    gmt_0018_2012.so and copy it to the /usr/lib64 or any directory
>    that linker could find before compiling QEMU.
> 3. enable crypto_gmt option when compiling QEMU and make the feature
>    availiable.
> 
> By offering a development package for GM/T 0018-2012, the above
> provisions could be standardized; unfortunately, the hardware
> manufacturer has not completed this task. So developers who don't
> work with the vendor to obtain the cryptography device and related
> library may not be able to test this functionality because the
> standard implementation depends on the cryptography device supplied
> by the hardware vendor. We are hesitant to contribute to this series
> as a result.

Hmm, yes, that is a pretty unpleasant approach.

IMHO there really needs to be a reference implementation that is
pure software. eg a gmt_0018_2012.so + header files that simply
uses an existing crypto library. That way applications can build
and test their support for this, without having to have access
to a specific piece of hardware. Hardware vendors should only
have to provide their library impl, not the headers.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


