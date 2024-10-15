Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E07D216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hRd-0002Ke-Pn; Tue, 15 Oct 2024 09:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRb-0002Jr-DQ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRa-0001QO-1f
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAnhQzltstUpaxSarWgWHJgCpx75eSMfHNbMPr/IPaY=;
 b=SM2NCXQpZkkvNWcFbNwzLgSAeDqNt1OpnEZ0tbzWtRjB5fSJ6jMwmMf/+Am7DOlFsJCVWQ
 +kf5uF4bCtKbNqbL/ftAZpytTiu4y+IUhGNGuS+GHMEv/8t0aVCK8ffEeN4Pl0eG7YUXm7
 TH9YaJZLRK65HWn0TcFOe4Pgx7+F4So=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-VxD9-DzNPaG4mPTFv5AQRQ-1; Tue, 15 Oct 2024 09:18:30 -0400
X-MC-Unique: VxD9-DzNPaG4mPTFv5AQRQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539f7ed336bso1672756e87.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998308; x=1729603108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sAnhQzltstUpaxSarWgWHJgCpx75eSMfHNbMPr/IPaY=;
 b=o5scljayQ2qvO5NlRd4HzNwNjCLa9Zo1acoh78vvIgRvp7z5oey9uJLe1otTAoBJ+y
 PcDNXcXMad6++10B8pZUCwnw0Chxf5DWuwETaA7pHK2SzaT7iVMHDKKs5CVszcVhw7p9
 huI+AitcU9UmUeMRgRLAQXPkhmtqiCaDF4kcNjPDk5GT1OBB139+eDf1sxqmsZjeJk6x
 buR+RCjItfWdIBVdqQsXxsEeae04S9jyMWbIbwafANm4IF8yNEv8AHmol7wXaTp7PMz9
 JD+D6skirOXkDfH2eLGi0wxopQFZ/23mdi0dMvuZnKPH+bFPw1Z2RxnD6/bFwXV2TU/G
 iHug==
X-Gm-Message-State: AOJu0YyR6uxycpIXsc3vAbZBJ58+wfShmCBKYuzEoKu9W1PCqksJ4qv8
 LLzAHq3lGjL9vSMLU9eyTb9GhJ9dwJKobf4O+oY0YVcDS9pCJGpulN2IkhwQ3YvQWVbD66Tgjb/
 Ayjut8cW56vJYxXfkkmf/XirxHyrBXgW/Scq/V/yG7DUg4msxvMpuUM6MhON1OKs4lS37sc27Oi
 ExECdOcQoKEMZ97A5QMkPPXHHR1+y+7H1KM8q55eg=
X-Received: by 2002:a05:6512:3e14:b0:539:f26f:d280 with SMTP id
 2adb3069b0e04-53a03f0bdc9mr244937e87.5.1728998308126; 
 Tue, 15 Oct 2024 06:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQMlOEKSLD1sF/wTcl+Lp3LcGYF2J1eHYuIUM3CKP7/KuD3qLUj+h0MwjOxIcbKS/xa4Rkmw==
X-Received: by 2002:a05:6512:3e14:b0:539:f26f:d280 with SMTP id
 2adb3069b0e04-53a03f0bdc9mr244902e87.5.1728998307527; 
 Tue, 15 Oct 2024 06:18:27 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4314bf60fc4sm849625e9.38.2024.10.15.06.18.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:18:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/16] rust: allow older version of bindgen
Date: Tue, 15 Oct 2024 15:17:34 +0200
Message-ID: <20241015131735.518771-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Cope with the old version that is provided in Debian 12 and Ubuntu 22.04.
--size_t-is-usize is needed on bindgen <0.61.0 (Debian 12, Ubuntu 22.04),
and it was removed in bindgen 0.65.0, so check for it in meson.build.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index e08f226ee8a..2a292935a94 100644
--- a/meson.build
+++ b/meson.build
@@ -74,6 +74,7 @@ endif
 have_rust =3D false
 if not get_option('rust').disabled() and add_languages('rust', required: g=
et_option('rust'), native: false) \
     and add_languages('rust', required: get_option('rust'), native: true)
+  bindgen =3D find_program('bindgen')
   rustc =3D meson.get_compiler('rust')
   have_rust =3D true
   if rustc.version().version_compare('<1.63.0')
@@ -3939,6 +3940,9 @@ if have_rust and have_system
     '--allowlist-file', meson.project_source_root() + '/.*',
     '--allowlist-file', meson.project_build_root() + '/.*'
     ]
+  if bindgen.version().version_compare('<0.65.0')
+    bindgen_args +=3D ['--size_t-is-usize']
+  endif
   c_enums =3D [
     'DeviceCategory',
     'GpioPolarity',
@@ -3974,7 +3978,7 @@ if have_rust and have_system
     dependencies: common_ss.all_dependencies(),
     output: 'bindings.rs',
     include_directories: include_directories('.', 'include'),
-    bindgen_version: ['>=3D0.69.4'],
+    bindgen_version: ['>=3D0.59.1'],
     args: bindgen_args,
     )
   subdir('rust')
--=20
2.46.2


