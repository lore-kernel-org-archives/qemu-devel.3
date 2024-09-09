Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AC3ECE588
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkk2-0000Tf-1x; Mon, 09 Sep 2024 16:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkk0-0000O4-LH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkjy-00052b-T8
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8TZl7MGrUC/7HcoL7VayMG078Iin7hnDhhYjY6hvtU=;
 b=HuOVEU42klydjvMMLNZ4pRrgphmya4x9hAwrw8KKytdAFgBDrgJ0AznKa+VvvmzzB5OFte
 PmpHOfYPEKgXSUEXhFMakhLi344UexEklyGZRI2AnICT30DoktSJricbTvOMHKS5Tr/0ON
 1rj1vNJ8ShXuXrjcpquKG/e40+XR8Xo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-p0G91ztjMYuzKYMxx1i7wA-1; Mon, 09 Sep 2024 16:12:01 -0400
X-MC-Unique: p0G91ztjMYuzKYMxx1i7wA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-454e94467ceso88982011cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912720; x=1726517520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8TZl7MGrUC/7HcoL7VayMG078Iin7hnDhhYjY6hvtU=;
 b=F4kYtl7K+/JyAiPxrbgk8X1xqG8OzrZTFPAttNmbWP3j/BQxjF1632WkVp5nrpFB5o
 nhS7dVAcCY49YdGjHlyxaOLhVXsjVrphGnlJdra+ChESqaScjX9TakEqBb63xMyH5S0G
 rjbmuEW8Lp8Mq8007IckXiL4PQSv3fJPwndZqFE6vYPP2OWhkpl37F5d6PmkZXhBAauW
 Oecm3oiu/MVoRgJOdV/pH91EKlu40BAQuM5foCV1iAqqkouDHYIBSsx9rQFRceJubONe
 Wx/a0t1AAPKxEfyxvnyzogGcrRnIqMimfT/wOiVUeDuo3eFkB1YvY9eUPuEeZ43s2qK6
 N7OA==
X-Gm-Message-State: AOJu0YxuYvMVzURfV9sMNqnAo/i6QbsUTHTum2ziUe7btbvuvzN4cjad
 TJzU2wpZTXPJD2nuoBLSOFUXNchxqiCIaHK58vqHpW+vsEvMFV9z7+ZA/eg2NsNZ9Mhthbq6nQ5
 P9s1D+aVULTvEWVgPRmASGoRly+yYBPxwzS8Ed5On64BIgSO4gnULaV7a/owi0EmKT7MUGArPFh
 XYC3as3/z+/sZzm3RPQXzkCsy9gTmpItfmxQ==
X-Received: by 2002:a05:622a:1304:b0:458:34be:88c2 with SMTP id
 d75a77b69052e-45834be8cafmr56965001cf.48.1725912720504; 
 Mon, 09 Sep 2024 13:12:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2tAB2X8NKL/8XWan95k8iIiFYTn5HAmT94iRzyWGhu3aPSA8adlc8PqgWtmf3plqOvLpPfA==
X-Received: by 2002:a05:622a:1304:b0:458:34be:88c2 with SMTP id
 d75a77b69052e-45834be8cafmr56964621cf.48.1725912720027; 
 Mon, 09 Sep 2024 13:12:00 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f93978sm22838561cf.83.2024.09.09.13.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:11:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bryan Zhang <bryan.zhang@bytedance.com>,
 Hao Xiang <hao.xiang@linux.dev>, Yichen Wang <yichen.wang@bytedance.com>
Subject: [PULL 5/9] meson: Introduce 'qatzip' feature to the build system
Date: Mon,  9 Sep 2024 16:11:43 -0400
Message-ID: <20240909201147.3761639-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909201147.3761639-1-peterx@redhat.com>
References: <20240909201147.3761639-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Add a 'qatzip' feature, which is automatically disabled, and which
depends on the QATzip library if enabled.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Link: https://lore.kernel.org/r/20240830232722.58272-3-yichen.wang@bytedance.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 meson.build                   | 10 ++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/meson.build b/meson.build
index fbda17c987..b89b713e79 100644
--- a/meson.build
+++ b/meson.build
@@ -1262,6 +1262,14 @@ if not get_option('uadk').auto() or have_system
      uadk = declare_dependency(dependencies: [libwd, libwd_comp])
   endif
 endif
+
+qatzip = not_found
+if not get_option('qatzip').auto() or have_system
+  qatzip = dependency('qatzip', version: '>=1.1.2',
+                      required: get_option('qatzip'),
+                      method: 'pkg-config')
+endif
+
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
@@ -2412,6 +2420,7 @@ config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_UADK', uadk.found())
+config_host_data.set('CONFIG_QATZIP', qatzip.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4535,6 +4544,7 @@ summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
 summary_info += {'Query Processing Library support': qpl}
 summary_info += {'UADK Library support': uadk}
+summary_info += {'qatzip support':    qatzip}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index 0269fa0f16..f7b652b30d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -261,6 +261,8 @@ option('qpl', type : 'feature', value : 'auto',
        description: 'Query Processing Library support')
 option('uadk', type : 'feature', value : 'auto',
        description: 'UADK Library support')
+option('qatzip', type: 'feature', value: 'auto',
+       description: 'QATzip compression support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c97079a38c..5f377a6d81 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -163,6 +163,7 @@ meson_options_help() {
   printf "%s\n" '  pixman          pixman support'
   printf "%s\n" '  plugins         TCG plugins via shared library loading'
   printf "%s\n" '  png             PNG support with libpng'
+  printf "%s\n" '  qatzip          QATzip compression support'
   printf "%s\n" '  qcow1           qcow1 image format support'
   printf "%s\n" '  qed             qed image format support'
   printf "%s\n" '  qga-vss         build QGA VSS support (broken with MinGW)'
@@ -427,6 +428,8 @@ _meson_option_parse() {
     --enable-png) printf "%s" -Dpng=enabled ;;
     --disable-png) printf "%s" -Dpng=disabled ;;
     --prefix=*) quote_sh "-Dprefix=$2" ;;
+    --enable-qatzip) printf "%s" -Dqatzip=enabled ;;
+    --disable-qatzip) printf "%s" -Dqatzip=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
     --disable-qcow1) printf "%s" -Dqcow1=disabled ;;
     --enable-qed) printf "%s" -Dqed=enabled ;;
-- 
2.45.0


