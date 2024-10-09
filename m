Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C9CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygP8-0002yy-G2; Wed, 09 Oct 2024 19:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygP5-0002yb-Ko
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:39 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygP3-0006bo-Qs
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:39 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbce9e4598so2573796d6.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728517657; x=1729122457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOMeFKnXZZxuQzQ4Ug4ts6vhOgDMsElUKC3GROOqZJI=;
 b=CUb8RL9rSL5j/g3WIgUEd4+TIhwzo23pz310arH9EXBc2numM4MbY+baBgxRMJXSYS
 EToQVB4YaXP8sSXf2FoKcrDq91WnjdWC2qbnNkfngcoe6/3VgQ7g5MJPTBkHdfCE21ch
 LmKVleOB+Jg5h02+7FwfLyRYo7NK2+M17CTf0EhhFuBni4xILvGQGsJqY1uq/MsAjFJA
 emPFEHmsjWM1pae31MJfNONhAIyc2rnCe6KmoaxwIkScXxjca7SPs23kcDUS5IIsBkl7
 bzviXytdyIdm8tAxAPyrlYjKUA0BR4RYQkdsS4ctCeXauKu29aEatkPciM/tngu5weUz
 Qo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728517657; x=1729122457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FOMeFKnXZZxuQzQ4Ug4ts6vhOgDMsElUKC3GROOqZJI=;
 b=m3cij7t4YwwX5Ic5WpTEcJaLcwpgNsUh3v4kGe/7DbYa97SdEkPOOD1oZ3FyWqmeB1
 KUv7AuCLGgxFAc7e1YQPscek1mEUb8/dHDP/V/CKOaA0pFisn6OOkPkRoRJqPjDMy78+
 o04UMAD7Fs1nXIcImDFzW1A8pZHH9JdsA7pMueae5WaSY4X5WwjAoeuLQrmW5los1csa
 gx18DTldEuPDb7YKUuffcDPaEaI+V5EUWzL6GmLPMZHdoHFMt91bO07dPE8RvhxEYkNo
 AZy2kaaN8SejxMeFIwOpFNFHlh1CRmBlnov2yWdXDbXFot13XifjaxVumr6432aoLO76
 VKmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCxLXZ+NwswUacyPQDo3ON8fOXRIcEe2wk7rwfsSI0KWaeA7tmZ1GPMfRZ37X8asB6InspERAHosoQ@nongnu.org
X-Gm-Message-State: AOJu0YyOQXYL14En/qz2I2Rafa93bg/ALnjMaiKFebuv3NN/rbv2BE7r
 qnCti2qrN3g6Y7pfeGSPGuZDl4Z767YFkEoyBSIEjsAOFIjvSC1OPdIxn536fyY=
X-Google-Smtp-Source: AGHT+IH7EmEF2zU6XQj9WxH8lIjFWc3CL249lzDa3fXLfwEVPokRkKk1cKlM3Z3iStjdfE0ps4c3Ng==
X-Received: by 2002:a05:6214:490a:b0:6cb:807b:eaec with SMTP id
 6a1803df08f44-6cbc954d8e0mr73875046d6.21.1728517656667; 
 Wed, 09 Oct 2024 16:47:36 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([2605:a7c0:0:301::44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85d856fsm264386d6.72.2024.10.09.16.47.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Oct 2024 16:47:36 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v6 02/12] util/dsa: Add idxd into linux header copy list.
Date: Wed,  9 Oct 2024 16:46:00 -0700
Message-Id: <20241009234610.27039-3-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009234610.27039-1-yichen.wang@bytedance.com>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index c34ac6454e..5aba95d9cb 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -193,7 +193,7 @@ rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
               psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
-              vduse.h iommufd.h bits.h; do
+              vduse.h iommufd.h bits.h idxd.h; do
     cp "$hdrdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
-- 
Yichen Wang


