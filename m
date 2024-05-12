Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D98C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mg-0003HI-Kx; Sun, 12 May 2024 06:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mg-0003H5-1Z
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mb-0005z9-L8
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zF5LVRbs0/4q2/lIEg0QJLc1GOZk9sPQzeFoK9/sVOo=;
 b=BWAW3fO7vZ3N/+j64x029EOti3ivrd5sSNmZTeCzWYSkw4zMGtlJX5U9Kg0YAZdspGZXYm
 4SduxAqXbiDQUIaCODc+T6VEbGUkfBgsO8vkeNZICabzVUNeSdGXD0c9MkMNEQKI4/k9Uz
 vz+drGuwidrklHBID1wIoOoP6FxJCAc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-sfOXU9euPJ605m8L_FFx-A-1; Sun, 12 May 2024 06:50:09 -0400
X-MC-Unique: sfOXU9euPJ605m8L_FFx-A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59c2583f0bso196887566b.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511008; x=1716115808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zF5LVRbs0/4q2/lIEg0QJLc1GOZk9sPQzeFoK9/sVOo=;
 b=iD5jzmaMiDeWKxpEcETuWkuogXJIRsScPHw3PoiQMlhW49soz8vpUUNrWB6huW1e8G
 XqNX0Pc0ymHZGpjzNxqevORskwOjK+UtPOyOoantolx6GkIZqsdldGnqjmBLBHJqboQb
 71SH9pJY3+GB88qmqkfzkCaQ9k08Ji739Mhcwh5aQIBKVDWsDmoc55MkK9jRFa0YEm/G
 WiW2Dmg39qIl3n/SR7qGi0BUBIHje77ablZBGNF9Y2IisOG63BuOAeQbamC/uZ/F3wi5
 0rFWx/Yi4SqzfeGRygB6IOHwCpJAt+vsXS8tQVMcoDwog5jhWUV5c8m+8pJS24vQnCJe
 xCpg==
X-Gm-Message-State: AOJu0YymVfVjqyeK/SV4lXf912/LlQFzT4rawwtdKjqA0Chv2MrA6NgN
 SjlgSpFu5stcACdtj07iNZfXg9+S25Pu2YOVYvzOyP4uNvtNF/+1g7kPIlAdnNjqF6/VQEPy6kC
 3IsE2jeDZJyFjwOQoK5D+dP1Ap+iWfFUG7hgAoPzMJQTXnBar69MGD7nFKYRksOkLJY4iE5NVuz
 V5FYU4x6p3/cPvqAwkse0AZWwSKgjzjbuNGREZ
X-Received: by 2002:a17:906:f296:b0:a59:c833:d272 with SMTP id
 a640c23a62f3a-a5a2d5356eamr516731866b.13.1715511007850; 
 Sun, 12 May 2024 03:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExouaiLBy+L56RxCCT7GX1h+JKb6y41Fy6mcMrB5VCNyLHuMyN4a4KPHlLNAK1mvX6AEE6bQ==
X-Received: by 2002:a17:906:f296:b0:a59:c833:d272 with SMTP id
 a640c23a62f3a-a5a2d5356eamr516730666b.13.1715511007517; 
 Sun, 12 May 2024 03:50:07 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c8173sm444164866b.109.2024.05.12.03.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PULL 07/27] configure: quote -D options that are passed through to
 meson
Date: Sun, 12 May 2024 12:49:25 +0200
Message-ID: <20240512104945.130198-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ensure that they go through unmodified, instead of removing one layer
of quoting.

-D is a pretty specialized option and most options that can have spaces
do not need it (for example, c_args is covered by --extra-cflags).
Therefore it's unlikely that this causes actual trouble.  However,
a somewhat realistic failure case would be with -Dpkg_config_path
and a pkg-config directory that contains spaces.

Cc: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 1dca3d94c04..330664786dc 100755
--- a/configure
+++ b/configure
@@ -762,7 +762,7 @@ for opt do
   --*) meson_option_parse "$opt" "$optarg"
   ;;
   # Pass through -Dxxxx options to meson
-  -D*) meson_options="$meson_options $opt"
+  -D*) meson_option_add "$opt"
   ;;
   esac
 done
-- 
2.45.0


