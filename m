Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37443C7113E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 05:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPalU-0006nm-O3; Thu, 12 Jun 2025 01:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPalS-0006mv-NI
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 01:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPalP-0002UO-5O
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 01:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749707170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uWtXl9tUGCTILZjTP+f50HFmNhKS7AiuhqytRSts3uM=;
 b=FVbCM09ur6pzUVQfWC4JzULDSkvuwbBCNmx6CHX0Ckzk7CdoCwWoDZ1FCSdBHof3uZ7hCJ
 br7nb1QtfKrn57eUd37mvEZPofK5J55rccUXQRWX5Xn5P9R6nHrS9+MBfIZPZGBC9VB2iX
 TC7Yvrb7ZLrVVxBCppcktaqMFbFvgyQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631--oQ2cNGMPpKMV84WX7us3A-1; Thu, 12 Jun 2025 01:46:07 -0400
X-MC-Unique: -oQ2cNGMPpKMV84WX7us3A-1
X-Mimecast-MFC-AGG-ID: -oQ2cNGMPpKMV84WX7us3A_1749707166
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so234012f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 22:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749707166; x=1750311966;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uWtXl9tUGCTILZjTP+f50HFmNhKS7AiuhqytRSts3uM=;
 b=Pg/SjpydLSiRnk6z/LXt9HOVppC0hcWVHl/zb4AEuwU8SEw/7rKkfKgWblABWoq2e4
 QGmRwnnqKn1i9NFD6y7cyFeXcwDYxRrD+LWzwXcnSU6TuZcd6F0vHiLaVKfu29/8E5FR
 zGJbgehp6RN96B0oh+4QQsDubN35FTMhOx8FuIqZhQruvGgkmbLNqxqFrZoue3xyba04
 lAn4M02fuR1doBQiKUKnDdhRGRWvIK86oepFejyBJTJfZh5Mw8K1Nut8KPNtcs+0WI6h
 q5gFFSV6E2e8pgS6csmarJRJsxCzEjZP51MXpAVpSEMM9kLW+KXVw4asbm46qXNoywPz
 XkTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYz+u0oUkMmSJJ97z5/XbMQXkl9XGNKpch9zth2sSrDH+v6ZnmnvWXBPamL5zo8OuMvpt5SG+ZBD1n@nongnu.org
X-Gm-Message-State: AOJu0YxyCYarsRV0vB6IHP9+dtSbqtt+yHeN3nuFax5xOSvNQMlPAUSV
 dqEcxCzAXb1bgkWZOM/QsELGaCG0DJB08lzRSFSBIteZz0yHgsMQOOz3rScfLufa/xyDL2s7BYg
 Cl6nyS+CNGxCFM8gVSQcOqsK1WHq4E8o/Wuw8H1YXUQ3ZUvECPa6s/agu
X-Gm-Gg: ASbGncsBkfW/nDUq4wm3f60y2tnPzjbK2MqyCifew7DlEh+Xtqd5MxiiG87b0Ob17X/
 1ywtaINi6+0dJexEitRFEFDQWOcwSsAMX8v1TKQAO3YJiDxGc1/K/4n4l1dfoQpcQGAZFOdWU5Y
 2squy8CN86zXwXt4EX4Yz/RkSjdIdG/YQ8sbZOmvs+AEKJ5zuKUGsGziYD0pCNfYRQwNk9kW/au
 y1bzc+RI33L1sNVvZrhr9cMmWdHAf649qwR015m/bx09lYL3MvOZZC+Rh0ZezLljpbEZVNbtJvg
 0Sk43JRg70IHe+QBHEbeNwDs
X-Received: by 2002:a05:6000:2408:b0:3a5:3a03:79c1 with SMTP id
 ffacd0b85a97d-3a56138ae5amr1231533f8f.48.1749707165825; 
 Wed, 11 Jun 2025 22:46:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmRtHE6mVVfZkKz24Hapa/727wzwhCp6cubAx5pe6MqxwW0uO1+GfbyAkGw+L6idwqj3i4Tg==
X-Received: by 2002:a05:6000:2408:b0:3a5:3a03:79c1 with SMTP id
 ffacd0b85a97d-3a56138ae5amr1231509f8f.48.1749707165471; 
 Wed, 11 Jun 2025 22:46:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3cd54sm890590f8f.47.2025.06.11.22.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 22:46:04 -0700 (PDT)
Message-ID: <d2860e38-241e-4778-ad9c-7042c73edfd9@redhat.com>
Date: Thu, 12 Jun 2025 07:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] configure: Add dtc option
From: Paolo Bonzini <pbonzini@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250610204131.2862-1-shentey@gmail.com>
 <20250610204131.2862-5-shentey@gmail.com>
 <cdfc561e-23a9-607a-d9a8-70e07e73e0fd@eik.bme.hu>
 <aElCJnmjrB-X9M-n@redhat.com>
 <6eb6aa79-33f8-57ea-5714-af264557f8c8@eik.bme.hu>
 <c29386d1-1a4b-4f3b-a669-4206c366ad9e@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <c29386d1-1a4b-4f3b-a669-4206c366ad9e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/12/25 07:12, Paolo Bonzini wrote:
> I'll send a patch to the upstream dtc project and you can add it to QEMU 
> via diff_files (see commit 64644bc4eab2f for an example).
This is the patch, backported to QEMU's version of the dtc subproject:

diff --git a/libfdt/meson.build b/libfdt/meson.build
index 0307ffb..6581965 100644
--- a/libfdt/meson.build
+++ b/libfdt/meson.build
@@ -30,6 +30,7 @@ libfdt_dep = declare_dependency(
    include_directories: libfdt_inc,
    link_with: libfdt,
  )
+meson.override_dependency('libfdt', libfdt_dep)
  
  install_headers(
    files(
diff --git a/meson.build b/meson.build
index b23ea1b..7def0a6 100644
--- a/meson.build
+++ b/meson.build
@@ -54,6 +54,7 @@ version_gen_h = vcs_tag(
  
  subdir('libfdt')
  
+dtc_tools = []
  if get_option('tools')
    flex = find_program('flex', required: true)
    bison = find_program('bison', required: true)
@@ -77,7 +78,7 @@ if get_option('tools')
    )
  
    if cc.check_header('fnmatch.h')
-    executable(
+    dtc_tools += executable(
        'convert-dtsv0',
        [
          lgen.process('convert-dtsv0-lexer.l'),
@@ -88,7 +89,7 @@ if get_option('tools')
      )
    endif
  
-  executable(
+  dtc_tools += executable(
      'dtc',
      [
        lgen.process('dtc-lexer.l'),
@@ -108,7 +109,7 @@ if get_option('tools')
    )
  
    foreach e: ['fdtdump', 'fdtget', 'fdtput', 'fdtoverlay']
-    executable(e, files(e + '.c'), dependencies: util_dep, install: true)
+    dtc_tools += executable(e, files(e + '.c'), dependencies: util_dep, install: true)
    endforeach
  
    install_data(
@@ -118,6 +119,10 @@ if get_option('tools')
    )
  endif
  
+foreach e: dtc_tools
+  meson.override_find_program(e.name(), e)
+endforeach
+
  if not meson.is_cross_build()
    if py.found() and swig.found()
      subdir('pylibfdt')


and this is how you can then find dtc in QEMU's meson.build:

diff --git a/meson.build b/meson.build
index 61595015802..831678b4580 100644
--- a/meson.build
+++ b/meson.build
@@ -2121,13 +2121,15 @@ if numa.found() and not cc.links('''
  endif
  
  fdt = not_found
+dtc = not_found
  fdt_opt = get_option('fdt')
  if fdt_opt == 'enabled' and get_option('wrap_mode') == 'nodownload'
    fdt_opt = 'system'
  endif
  if fdt_opt in ['enabled', 'system'] or (fdt_opt == 'auto' and have_system)
    fdt = cc.find_library('fdt', required: fdt_opt == 'system')
-  if fdt.found() and cc.links('''
+  dtc = find_program('dtc', required: fdt_opt == 'system')
+  if dtc.found() and fdt.found() and cc.links('''
       #include <libfdt.h>
       #include <libfdt_env.h>
       int main(void) { fdt_find_max_phandle(NULL, NULL); return 0; }''',
@@ -2136,8 +2138,12 @@ if fdt_opt in ['enabled', 'system'] or (fdt_opt == 'auto' and have_system)
    elif fdt_opt != 'system'
      fdt_opt = get_option('wrap_mode') == 'nodownload' ? 'disabled' : 'internal'
      fdt = not_found
+    dtc = not_found
    else
-    error('system libfdt is too old (1.5.1 or newer required)')
+    if dtc.found()
+      error('system libfdt is too old (1.5.1 or newer required)')
+    else
+      error('device tree compiler not found')
    endif
  endif
  if fdt_opt == 'internal'
@@ -2145,7 +2148,8 @@ if fdt_opt == 'internal'
    libfdt_proj = subproject('dtc', required: true,
                             default_options: ['tools=false',  'yaml=disabled',
                                               'python=disabled', 'default_library=static'])
-  fdt = libfdt_proj.get_variable('libfdt_dep')
+  fdt = dependency('libfdt', required: true)
+  dtc = find_program('dtc', required: true)
  endif
  
  rdma = not_found


