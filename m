Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B6EC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8K6J-00023g-C1; Fri, 25 Apr 2025 10:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8K6A-0001zT-Nr; Fri, 25 Apr 2025 10:32:19 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8K68-0003oA-6r; Fri, 25 Apr 2025 10:32:14 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54d65cb6e8aso2941521e87.1; 
 Fri, 25 Apr 2025 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745591528; x=1746196328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=azeeqSY8CzJ4Bp0LEe7Hpbdx1EyTNPLikM5147epRk8=;
 b=cqqHFS/I96s2V6VbN08+bPt4sbCxrolHctb7hllUPwJ9omru43+pUwP/Xr/m3ta8hW
 gEzashMpW6wvTGRT+X0eT9lLXdBgUxmY1hqiXzGVe77X9/He19SMDZq2bMky2RJAS7YL
 CDT+tQPAuxx7TAfK2YRpWfh7maY7a9DF6rkY9jUAvYFuYkoPJVoGzIVmMvCys6NF98pP
 IfB72bFsUuxC5EM4IYOLUbbV8L71I9YJ/gUPFOwK4Zt3AWtloIMA8GF8d/l3olibaQRy
 lge1xZLnAcgaZJnuA8ElUT5ktcruSpyFmLtWga3pjOM7kB+tkLfuc0bwXAhWTGsomyjb
 zERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745591528; x=1746196328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=azeeqSY8CzJ4Bp0LEe7Hpbdx1EyTNPLikM5147epRk8=;
 b=qQ7tOW62XhLMK8V7yB4MDo3YxGa1aVVGUmzBvUe0X0eSAb4iyuZ3MA9fNFnSJwBq+V
 gVmkONnIbLzurzJyX+ojuChY7LicP8nKIKFtlytM8BTxU/vl1kIHobGby88r5MHZhxyL
 Z3GH//bE6NOdHL1UV8LqQxCKpmKPzhrjvSykuivvcIzf/LQiQ4z1omQtrumbmVSEhGHn
 hZ/FfavBg7qQrnkCx8u1J4dj06vz2zcz4qF0BlfFG/616IlVfQBRq+95GW04SbA/Zh4q
 ZCJXYBzxSe/d5fF6+GQrnBA+qweuQj+kC5GSM6TbT3QIVETGJ9T483u254tdo+/TPFKb
 t7vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgHXpO+mLg5voIBDVt2ZGAW6Y1xIfhyEwvmbHkC/ArvEJznhxe/KTT3HESZabNhGAX89iuW1/mB4Zu1g==@nongnu.org
X-Gm-Message-State: AOJu0YyhnN7XX3krqfeNL1qEf3+JQRTi4aNptAI2Abf1yY1htLMSCAqs
 AriwuSRkv1WLUbTrIEVVADXWePIQa6m2rTWEFCRm6+Zpvx6aWIryvM4lQpoz0LA=
X-Gm-Gg: ASbGncv5urrFT2TnY8XJDjPr6f7a8ZkxkEbw6okbKq58dmOzMRBSYkw5UK9D+aCxDO2
 oua5xD6VW4oz1xTuwzYuOh60sbTgddjl5B/9cnid3wlWHXbn5cs/dN2Cje0iNBSGhUe0wDfX+Fp
 i7CneEcqUaq/hgALeCuDefu7kGmpyu7tB2PZqKDJS9toUxwqa9YQeuc6YYEBgwdTiZJCYkN3bbb
 BfX+vEenDkH6D23Un7b6fq+mmmKJarX4GxgXTqVY6ncCe5iMxcdxPWEnfRDCcrmlS9Rfttk6TW6
 g9VM4qkwdE4jo5xK29VKB01Fnr68KT8WqtN1QEZfjrWQ06pS92lRA2JdBpDrRftT5F8/Sh0MeJw
 95cK8UsNgAhIv
X-Google-Smtp-Source: AGHT+IF6GoiPiuFmU1v0uNdbuCBJilb8xb2JfSTEgACYnhGTyApmLy4m47IQ+SEYeYHqhegvkysP7A==
X-Received: by 2002:a05:6512:10cf:b0:54b:f04:59e8 with SMTP id
 2adb3069b0e04-54e8cbd55e2mr744424e87.23.1745591527794; 
 Fri, 25 Apr 2025 07:32:07 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54e7cc9e883sm632540e87.133.2025.04.25.07.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 07:32:06 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: [PATCH v1 0/1] xen: mapcache: grants: Fix mixup betwen ro and rw
 mappings
Date: Fri, 25 Apr 2025 16:31:55 +0200
Message-ID: <20250425143156.204452-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

This fixes an issue with grant mappings when a read-only
mapping is requested followed by a read-write mapping for
the same page. Today, we don't track write-ability and
read-write lookups hit on read-only entries.

This series is an attempt to fix this by splitting mapcache_grants
in two, a read-only and a read-write instance.

I tried a couple of other approaches, one was to speculatively
map grants as read-write and if mapping fails, then fall back
to read-only. This works but since Xen logs each failed grant
mapping, it gets noisy.

Another way is to track writeability per mapping in the cache
and modify the lookup logic to only hit on compatible mappings.
It works but adds more complexity to the lookup logic compared
with the split cache approach.
https://gitlab.com/edgar.iglesias/qemu/-/commits/edgar/grants-ro-rw-fix

Cheers,
Edgar

Edgar E. Iglesias (1):
  xen: mapcache: Split mapcache_grants by ro and rw

 hw/xen/xen-mapcache.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

-- 
2.43.0


