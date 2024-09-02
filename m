Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07E6CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 13:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl7Ru-00064a-3c; Mon, 02 Sep 2024 09:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7Rp-00063N-SA
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 09:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7Rn-0001LT-Ji
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 09:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725285018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WCrar+FBOMbQ0FiMAUc1oduB2hxu3HtymS/zqj3OinI=;
 b=EHAKXkP+jEEp2n6dLsMjFwmJx/S0mi7gMNqcjcWNQ4MqSN7SxTZVJX/z7fnHkKmE4D0eNZ
 J3C4kKPCN4U5Wp/Xit8yK2e2KWM6P174CLl0WLueN3TQ/Tu/Vv5XuWo078BgRVSNOSQO9P
 lw6s+av+Hn7z9nPKOjlngrYOD6yTHAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-wqge-ACVPj6Ac8gdt4ErQw-1; Mon, 02 Sep 2024 09:50:14 -0400
X-MC-Unique: wqge-ACVPj6Ac8gdt4ErQw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42bafca2438so48550045e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 06:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725285014; x=1725889814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCrar+FBOMbQ0FiMAUc1oduB2hxu3HtymS/zqj3OinI=;
 b=RBL+w8q89Iku/qkj0cwQKy+pzZhLnwiYuIqny3MDq2FOH7fcjiJisNYDRPxvElkx3u
 7BdLLUzCId+FftIGETF7NRUtqGbBieNepysta136ef75rqO7qpzL3jYnClrfPOQS6FQ+
 zB5LlXvIDubH9MgG+ajemKDXdsh0MrOmdaaULEvAUsP7MSCPP/HmtKJEDFUM9bfroTBZ
 UYUe+gdK8jAWOu2PWtfgPPRVNBR8ev39JfvIyiKFaM4R8E05FXLrYbuEzQt6apJ+cAPE
 ruF3UCV/G5Ov6b5XgQXFj54vxJLcsZ1EO+tEhEwMq78gwqyBmLgdsH+F9LsUxPHuAvXK
 diBg==
X-Gm-Message-State: AOJu0YyXRqkvKyg0faD/ZwRFwLMDJECMmtYBivNGwV6jNDce4Lfh+y3K
 /TpADBOFhAG2BRLazLU3Fc+abI5x/e9xN9awHOXHNRmyQukMkfNnSiWtcQQE79VQaiDC1kCTL27
 vUjyPJNxDjOtbLppsSB+xXmTUyhCMtDAjQZt5HgzAomEu4or5BnK9
X-Received: by 2002:a05:600c:4f42:b0:426:6b14:1839 with SMTP id
 5b1f17b1804b1-42bb0136dadmr137687375e9.0.1725285013370; 
 Mon, 02 Sep 2024 06:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHykYwu14V48qe7QriZmWe6mTcENQlFSegsayPxQUDMQMrQnz8+ptXT1RKActSx2n3xJgUzEg==
X-Received: by 2002:a05:600c:4f42:b0:426:6b14:1839 with SMTP id
 5b1f17b1804b1-42bb0136dadmr137686635e9.0.1725285012359; 
 Mon, 02 Sep 2024 06:50:12 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.174])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e274c1sm138832215e9.36.2024.09.02.06.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 06:50:11 -0700 (PDT)
Date: Mon, 2 Sep 2024 15:50:06 +0200
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
Subject: Re: [PATCH v5 01/16] meson: Add optional dependency on IGVM library
Message-ID: <fw2s4mahnitrorypcuffhmv4nyrubyhwqki7ernh7gleg7ahwu@nft3wsjosgql>
References: <cover.1723560001.git.roy.hopkins@suse.com>
 <e91b60f15b87d0eb3e9e6319cce1e57f684536b5.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e91b60f15b87d0eb3e9e6319cce1e57f684536b5.1723560001.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 13, 2024 at 04:01:03PM GMT, Roy Hopkins wrote:
>The IGVM library allows Independent Guest Virtual Machine files to be
>parsed and processed. IGVM files are used to configure guest memory
>layout, initial processor state and other configuration pertaining to
>secure virtual machines.
>
>This adds the --enable-igvm configure option, enabled by default, which
>attempts to locate and link against the IGVM library via pkgconfig and
>sets CONFIG_IGVM if found.
>
>The library is added to the system_ss target in backends/meson.build
>where the IGVM parsing will be performed by the ConfidentialGuestSupport
>object.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>---
> backends/meson.build          | 3 +++
> meson.build                   | 8 ++++++++
> meson_options.txt             | 2 ++
> scripts/meson-buildoptions.sh | 3 +++
> 4 files changed, 16 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/backends/meson.build b/backends/meson.build
>index da714b93d1..b092a19efc 100644
>--- a/backends/meson.build
>+++ b/backends/meson.build
>@@ -32,6 +32,9 @@ if have_vhost_user_crypto
> endif
> system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
> system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
>+if igvm.found()
>+  system_ss.add(igvm)
>+endif
>
> system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
>
>diff --git a/meson.build b/meson.build
>index c2a050b844..11976674ff 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -1289,6 +1289,12 @@ if host_os == 'linux' and (have_system or have_tools)
>                        method: 'pkg-config',
>                        required: get_option('libudev'))
> endif
>+igvm = not_found
>+if not get_option('igvm').auto() or have_system
>+  igvm = dependency('igvm', version: '>= 0.3.0',
>+                    method: 'pkg-config',
>+                    required: get_option('igvm'))
>+endif
>
> mpathlibs = [libudev]
> mpathpersist = not_found
>@@ -2420,6 +2426,7 @@ config_host_data.set('CONFIG_CFI', get_option('cfi'))
> config_host_data.set('CONFIG_SELINUX', selinux.found())
> config_host_data.set('CONFIG_XEN_BACKEND', xen.found())
> config_host_data.set('CONFIG_LIBDW', libdw.found())
>+config_host_data.set('CONFIG_IGVM', igvm.found())
> if xen.found()
>   # protect from xen.version() having less than three components
>   xen_version = xen.version().split('.') + ['0', '0']
>@@ -4520,6 +4527,7 @@ summary_info += {'seccomp support':   seccomp}
> summary_info += {'GlusterFS support': glusterfs}
> summary_info += {'hv-balloon support': hv_balloon}
> summary_info += {'TPM support':       have_tpm}
>+summary_info += {'IGVM support':      igvm}
> summary_info += {'libssh support':    libssh}
> summary_info += {'lzo support':       lzo}
> summary_info += {'snappy support':    snappy}
>diff --git a/meson_options.txt b/meson_options.txt
>index 0269fa0f16..0b09c152dc 100644
>--- a/meson_options.txt
>+++ b/meson_options.txt
>@@ -111,6 +111,8 @@ option('dbus_display', type: 'feature', value: 'auto',
>        description: '-display dbus support')
> option('tpm', type : 'feature', value : 'auto',
>        description: 'TPM support')
>+option('igvm', type: 'feature', value: 'auto',
>+       description: 'Independent Guest Virtual Machine (IGVM) file support')
>
> # Do not enable it by default even for Mingw32, because it doesn't
> # work on Wine.
>diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
>index c97079a38c..264e46dd4a 100644
>--- a/scripts/meson-buildoptions.sh
>+++ b/scripts/meson-buildoptions.sh
>@@ -128,6 +128,7 @@ meson_options_help() {
>   printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
>   printf "%s\n" '  hvf             HVF acceleration support'
>   printf "%s\n" '  iconv           Font glyph conversion support'
>+  printf "%s\n" '  igvm            IGVM file support'
>   printf "%s\n" '  jack            JACK sound support'
>   printf "%s\n" '  keyring         Linux keyring support'
>   printf "%s\n" '  kvm             KVM acceleration support'
>@@ -343,6 +344,8 @@ _meson_option_parse() {
>     --iasl=*) quote_sh "-Diasl=$2" ;;
>     --enable-iconv) printf "%s" -Diconv=enabled ;;
>     --disable-iconv) printf "%s" -Diconv=disabled ;;
>+    --enable-igvm) printf "%s" -Digvm=enabled ;;
>+    --disable-igvm) printf "%s" -Digvm=disabled ;;
>     --includedir=*) quote_sh "-Dincludedir=$2" ;;
>     --enable-install-blobs) printf "%s" -Dinstall_blobs=true ;;
>     --disable-install-blobs) printf "%s" -Dinstall_blobs=false ;;
>-- 
>2.43.0
>


