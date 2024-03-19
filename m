Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682A0CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmb75-00080N-O0; Tue, 19 Mar 2024 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rmb6v-0007fb-79
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rmb6t-0007bU-5I
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710861037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IYAoZ0bwVFFPxApX+6DHmzL/1Y/tj56z7sfwLqdUCI=;
 b=JQ2WDTibGgcRqqI8GajYWNpGTY7cn05LfEze6WyyQkyVQoGMaog0X7JP9ePO/h+wQ0EE3z
 45HFAd5HMwvn4FOPaqxfxwx4cxBCWBKaQj1p5zswrY1kvQ81eJvI24fX/OHcey/bAkerAV
 xNc8+TJpHCodZLFugC6c6WVwOnaZFOY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-C-X5YQJIOY-xuMxD0jMPOw-1; Tue, 19 Mar 2024 11:10:30 -0400
X-MC-Unique: C-X5YQJIOY-xuMxD0jMPOw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3416632aeffso1420695f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710861029; x=1711465829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IYAoZ0bwVFFPxApX+6DHmzL/1Y/tj56z7sfwLqdUCI=;
 b=MrZDYTfK7U3ndYxmE0Q3NgC74Fg+PU9RQO0FogFMnxI8d9UpVbPKCMWAH76QceV4KH
 Uciwan+MDPIZR0gL6cgSaFqcOh2V+NqKZScyRgS5DmigvQ6LwewCoyPoKtP9WCJw+uJ4
 UJugLEdNP10ZEHErqWwsw2Efr8KT1Jh4m021XnaTV9gtZKgNJqIxtpmgo059EW0iOGIM
 3LHlVATDTnZ+2wz35n5G0Np9WTGzZttKn4bdi+j8BgHGbI4S945Z5ZVkGJVpP6/CIb7a
 ZEBS+TqKI5VTrkMUVMJPXwkmq35uQOQAGwvc68Y8KqgMhglSDXO5a8RtEPvNzZ0E4YJG
 smeg==
X-Gm-Message-State: AOJu0YwW2U5OwyYs5yHq1nxjfDJcpptBS9WGd6cyJIl2ZJmBUP/kSVQR
 7Iihxgjvs9CUklJEvGmpk/FA+9/cnh+nrqpFo/1P/7eENNnyJPAtX9o9xm/c/zifndLtYezFEFa
 P7o/DBO+QA2F5zPKgVa/EIBtIrXREgDZUDLXmOmp8+TwjUreLt3nJ
X-Received: by 2002:a5d:6da9:0:b0:341:72b8:83c9 with SMTP id
 u9-20020a5d6da9000000b0034172b883c9mr4675336wrs.70.1710861029215; 
 Tue, 19 Mar 2024 08:10:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUoP/caJCGuyLD72TP48x05XujXNvBZi1uIdNWr1YJ9vUpZdjuetWiquDOp7wiCFvxMTrTGA==
X-Received: by 2002:a5d:6da9:0:b0:341:72b8:83c9 with SMTP id
 u9-20020a5d6da9000000b0034172b883c9mr4675310wrs.70.1710861028794; 
 Tue, 19 Mar 2024 08:10:28 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 b8-20020a5d45c8000000b0033e7715bafasm12547642wrs.59.2024.03.19.08.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 08:10:28 -0700 (PDT)
Date: Tue, 19 Mar 2024 16:10:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH 2/9] backends/confidential-guest-support: Add IGVM file
 parameter
Message-ID: <4ayfzr7mwmb2smh5jdwnimasmvazmozeo7kn7x2oojaqreijjn@myyxobx4rml4>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <26c2bb5f2de41471dde304223cd943215d3183c5.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <26c2bb5f2de41471dde304223cd943215d3183c5.1709044754.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 27, 2024 at 02:50:08PM +0000, Roy Hopkins wrote:
>In order to add support for parsing IGVM files for secure virtual
>machines, a the path to an IGVM file needs to be specified as
>part of the guest configuration. It makes sense to add this to
>the ConfidentialGuestSupport object as this is common to all secure
>virtual machines that potentially could support IGVM based
>configuration.
>
>This patch allows the filename to be configured via the QEMU
>object model in preparation for subsequent patches that will read and
>parse the IGVM file.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>---
> backends/confidential-guest-support.c     | 21 +++++++++++++++++++++
> include/exec/confidential-guest-support.h |  9 +++++++++
> qapi/qom.json                             | 13 +++++++++++++
> qemu-options.hx                           |  8 +++++++-
> 4 files changed, 50 insertions(+), 1 deletion(-)
>
>diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>index 052fde8db0..da436fb736 100644
>--- a/backends/confidential-guest-support.c
>+++ b/backends/confidential-guest-support.c
>@@ -20,8 +20,29 @@ OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
>                             CONFIDENTIAL_GUEST_SUPPORT,
>                             OBJECT)
>
>+#if defined(CONFIG_IGVM)
>+static char *get_igvm(Object *obj, Error **errp)
>+{
>+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
>+    return g_strdup(cgs->igvm_filename);
>+}
>+
>+static void set_igvm(Object *obj, const char *value, Error **errp)
>+{
>+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
>+    g_free(cgs->igvm_filename);
>+    cgs->igvm_filename = g_strdup(value);
>+}
>+#endif
>+
> static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
> {
>+#if defined(CONFIG_IGVM)
>+    object_class_property_add_str(oc, "igvm-file",
>+        get_igvm, set_igvm);
>+    object_class_property_set_description(oc, "igvm-file",
>+        "Set the IGVM filename to use");
>+#endif
> }
>
> static void confidential_guest_support_init(Object *obj)
>diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
>index ba2dd4b5df..b08ad8de4d 100644
>--- a/include/exec/confidential-guest-support.h
>+++ b/include/exec/confidential-guest-support.h
>@@ -51,6 +51,15 @@ struct ConfidentialGuestSupport {
>      * so 'ready' is not set, we'll abort.
>      */
>     bool ready;
>+
>+#if defined(CONFIG_IGVM)
>+    /*
>+     * igvm_filename: Optional filename that specifies a file that contains
>+     *                the configuration of the guest in Isolated Guest
>+     *                Virtual Machine (IGVM) format.
>+     */
>+    char *igvm_filename;
>+#endif
> };
>
> typedef struct ConfidentialGuestSupportClass {
>diff --git a/qapi/qom.json b/qapi/qom.json
>index 2a6e49365a..570bdd7d55 100644
>--- a/qapi/qom.json
>+++ b/qapi/qom.json
>@@ -859,6 +859,18 @@
>   'base': 'RngProperties',
>   'data': { '*filename': 'str' } }
>
>+##
>+# @ConfidentialGuestProperties:
>+#
>+# Properties common to objects that are derivatives of confidential-guest-support.
>+#
>+# @igvm-file: IGVM file to use to configure guest (default: none)
>+#
>+# Since: 8.2

Should it be 9.0 or maybe 9.1 ?

>+##
>+{ 'struct': 'ConfidentialGuestProperties',
>+  'data': { '*igvm-file': 'str' } }
>+
> ##
> # @SevGuestProperties:
> #
>@@ -886,6 +898,7 @@
> # Since: 2.12
> ##
> { 'struct': 'SevGuestProperties',
>+  'base': 'ConfidentialGuestProperties',
>   'data': { '*sev-device': 'str',
>             '*dh-cert-file': 'str',
>             '*session-file': 'str',
>diff --git a/qemu-options.hx b/qemu-options.hx
>index 9be1e5817c..49d9226e35 100644
>--- a/qemu-options.hx
>+++ b/qemu-options.hx
>@@ -5640,7 +5640,7 @@ SRST
>                  -object secret,id=sec0,keyid=secmaster0,format=base64,\\
>                      data=$SECRET,iv=$(<iv.b64)
>
>-    ``-object sev-guest,id=id,cbitpos=cbitpos,reduced-phys-bits=val,[sev-device=string,policy=policy,handle=handle,dh-cert-file=file,session-file=file,kernel-hashes=on|off]``
>+    ``-object sev-guest,id=id,cbitpos=cbitpos,reduced-phys-bits=val,[sev-device=string,policy=policy,handle=handle,dh-cert-file=file,session-file=file,kernel-hashes=on|off,igvm-file=file]``
>         Create a Secure Encrypted Virtualization (SEV) guest object,
>         which can be used to provide the guest memory encryption support
>         on AMD processors.
>@@ -5684,6 +5684,12 @@ SRST
>         cmdline to a designated guest firmware page for measured Linux
>         boot with -kernel. The default is off. (Since 6.2)
>
>+        The ``igvm-file`` is an optional parameter that, when specified,
>+        allows an Independent Guest Virtual Machine (IGVM) file to be
>+        specified that configures the secure virtual machine and can
>+        include, for example, an SVSM module, system firmware, initial
>+        boot state, etc.
>+
>         e.g to launch a SEV guest
>
>         .. parsed-literal::
>-- 
>2.43.0
>
>


