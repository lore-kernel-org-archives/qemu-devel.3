Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAF1CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 14:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl82y-0003k5-Mp; Mon, 02 Sep 2024 10:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl82w-0003jT-PU
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl82u-0005KW-76
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725287322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wwLrvi6mBVOHrImmOnGj3OJ6rkK4Bpc8jLKha5bZTFI=;
 b=cJoKSUk/544CKQXeXDZ203Hi703a1VZMObbKPhbjMGYE5n1CTZwvJ5p695ACIZkplBGIV4
 CVW0Fmw/CD7sQ3Nr86LbU3ZerQclZJrh4l6ggmyX8KdcUJedjqq2fYn8GX3ZR/ewnZmh13
 ye6TXupByr0E3YzBETUYfq29CkXLN1U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-qsqWVFOnMt2F1ppEaXwR4Q-1; Mon, 02 Sep 2024 10:28:41 -0400
X-MC-Unique: qsqWVFOnMt2F1ppEaXwR4Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42bbd062ac1so29645745e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 07:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725287320; x=1725892120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwLrvi6mBVOHrImmOnGj3OJ6rkK4Bpc8jLKha5bZTFI=;
 b=dYEhIsXrRbtlg6kx497yTPlK5ahtagL6ZtBlZV6O8QrqWlZWAF5fwtk66eu56ULIJ1
 +AMxOgk2lY7Fy01ZiZ9nFc0/vpCp7NhSFnW+2aFgBQaIy2m5gq2enKUC9RHMuitX6BmI
 6oPqTq79vXRXjVQ+cWA0yY4/ncp+LwYz4Z+SGu1AEYA2mn975Z+5VZcCNHc0BMocjf4A
 ud4TqYVfJaI1AsK7kLEjs1SFEQaO7SpR6LPAt3YLVY3uzoHrHlxWsoCpRWDfnQJMQ+i0
 llQRJzNzhvy8DNovnZK2svJAR8S9Ke+nMv1JDLn68RWnH3dc/VwA/fx+SpagTnf2DUYt
 b7zw==
X-Gm-Message-State: AOJu0Yz96pQ2sr/EkReoLFvK8Fk23uzZd0igC+uTDD+DsF+MV72/nUvG
 /4rACBBK1lI3rk//2zvnhkz9hI3AUdowVnav74rlUSdHNS8GME0Hgh8S/xZVccz0575B2VTJ/WT
 +g8mVG0YhwVeEHJdkSqVliqTL+jvkUN8qqlPwKKpPXqFC0tymIKYO
X-Received: by 2002:a05:600c:3146:b0:428:16a0:1c3f with SMTP id
 5b1f17b1804b1-42be48faa09mr64942775e9.32.1725287320191; 
 Mon, 02 Sep 2024 07:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4gxjDcV1uwEFdLUZYYJHPDlRbk2h/hm7hFuiAw3jRKHEKHGQk4b0pH8ZoAP9Nwo0xpj9ubQ==
X-Received: by 2002:a05:600c:3146:b0:428:16a0:1c3f with SMTP id
 5b1f17b1804b1-42be48faa09mr64942185e9.32.1725287319118; 
 Mon, 02 Sep 2024 07:28:39 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.174])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6425811sm177537295e9.40.2024.09.02.07.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 07:28:38 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:28:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v5 11/16] docs/interop/firmware.json: Add igvm to
 FirmwareDevice
Message-ID: <vxooj6frfqohwhdhs4n2dvzmst3xvefh6pyolr5uev6aekozbj@2gz5d2vno6lo>
References: <cover.1723560001.git.roy.hopkins@suse.com>
 <66f109b23606914f8ad26f4deddd0bfc63980734.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <66f109b23606914f8ad26f4deddd0bfc63980734.1723560001.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 13, 2024 at 04:01:13PM GMT, Roy Hopkins wrote:
>Create an enum entry within FirmwareDevice for 'igvm' to describe that
>an IGVM file can be used to map firmware into memory as an alternative
>to pre-existing firmware devices.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>---
> docs/interop/firmware.json | 30 ++++++++++++++++++++++++++++--
> 1 file changed, 28 insertions(+), 2 deletions(-)
>
>diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
>index 57f55f6c54..59ae39cb13 100644
>--- a/docs/interop/firmware.json
>+++ b/docs/interop/firmware.json
>@@ -57,10 +57,17 @@
> #
> # @memory: The firmware is to be mapped into memory.
> #
>+# @igvm: The firmware is defined by a file conforming to the IGVM
>+#        specification and mapped into memory according to directives
>+#        defined in the file. This is similar to @memory but may
>+#        include additional processing defined by the IGVM file
>+#        including initial CPU state or population of metadata into
>+#        the guest address space. Since: 9.1

Since: 9.2

>+#
> # Since: 3.0
> ##
> { 'enum' : 'FirmwareDevice',
>-  'data' : [ 'flash', 'kernel', 'memory' ] }
>+  'data' : [ 'flash', 'kernel', 'memory', 'igvm' ] }
>
> ##
> # @FirmwareArchitecture:
>@@ -367,6 +374,24 @@
> { 'struct' : 'FirmwareMappingMemory',
>   'data'   : { 'filename' : 'str' } }
>
>+##
>+# @FirmwareMappingIgvm:
>+#
>+# Describes loading and mapping properties for the firmware executable,
>+# when @FirmwareDevice is @igvm.
>+#
>+# @filename: Identifies the IGVM file containing the firmware executable
>+#            along with other information used to configure the initial
>+#            state of the guest. The IGVM file may be shared by multiple
>+#            virtual machine definitions. This corresponds to creating
>+#            an object on the command line with "-object igvm-cfg,
>+#            file=@filename".
>+#
>+# Since: 9.1

Ditto

With them fixed:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>+##
>+{ 'struct' : 'FirmwareMappingIgvm',
>+  'data'   : { 'filename' : 'str' } }
>+
> ##
> # @FirmwareMapping:
> #
>@@ -383,7 +408,8 @@
>   'discriminator' : 'device',
>   'data'          : { 'flash'  : 'FirmwareMappingFlash',
>                       'kernel' : 'FirmwareMappingKernel',
>-                      'memory' : 'FirmwareMappingMemory' } }
>+                      'memory' : 'FirmwareMappingMemory',
>+                      'igvm'   : 'FirmwareMappingIgvm' } }
>
> ##
> # @Firmware:
>-- 
>2.43.0
>


