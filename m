Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F045CC54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 03:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riR5H-000338-Sn; Thu, 07 Mar 2024 22:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1riR5F-00032u-OS
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 22:39:46 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1riR5E-0001DW-6S
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 22:39:45 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e66e8fcc2dso37595b3a.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 19:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709869182; x=1710473982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxXMvS7OWnGqyma7pLrMX/tOGFYshgRj6XNbvvtivrM=;
 b=KzH2sZ2FsP0l9wL+7q6zTCtM8ILYT9QfOnTX+puadpmFTJ9uVg96MRzilqnldJuiY3
 AzG5YOxncwCqzjO+3CvlWm77VEtJcJ2kakU4afVxniUZniXFKn78NjFe4RlXNRMF6SCb
 8ZLwHSXHPlL7YDRdw5SF4BgZQIqoVq46g/CT+kMO4fD+51Ru8t4cdHLPyJKhQfaG1Ioo
 n9yVjfm6UO3yuf1BFjW1NsmzeGazk635Tjbs0fBDZh3CHxYhic3hBx+usW0upY4iw+1P
 7GhS2OvqEawNrHt5h+jN8KUs6CeSbdCLv1oNEobJ/w3GzJQD/A+y8g3LioXsjx89ubgz
 hg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709869182; x=1710473982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxXMvS7OWnGqyma7pLrMX/tOGFYshgRj6XNbvvtivrM=;
 b=oH0fFffzdHlCk3U+/c60Q5mMM8ed8POq77TlxhW2Wfv5+nQ2SY3jo/s93VDFmc2FZB
 b+xtypX8il1psgIuA6NjedRsACrab5n7uyvyi4jb1OsXpQglz4hFsxbbEaeJR92soz6P
 mhVxpuBMZtUWVbkEOFA+D60+YQMHKolKbWNYPP1KGJ9Z+bgEQTgB/CQUCWNEc1nyW3Uj
 bMYm54k5z1qPBdTh7y8m0cfQ07ZI3SYRxT8GF2bSudnfPPAg9ERfga6fc7YG8A8SStNj
 0uIC7furZ97/YNiKbR5qvOIYAToE8PjLiBNNMY98VaMrQPufqwRhh+T4bwVWI93BdJ3Y
 R5NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsF+qTuQ1/OAxY97VVFTV69gr9MGopQIF2iiwEJLP8pSs5omaKtNREnpy+tDuliLO76m8uZ4GUwzYy43T4+ENIYcwS6j0=
X-Gm-Message-State: AOJu0YzSb2Sy+kYHX8NO6ZCEOyHzeiMVIyxVdMjEJAzqW7ZHH2gt2ggd
 ez+pbqPvWMHnOEWCpUBa+Xaf2jx1/rUc+Lw3EUUob69SixSxgoyu
X-Google-Smtp-Source: AGHT+IGjotYHs6RkUrDnyGDDum4K75Sywq//snhv3hj+WmZpb2IVtNY+8qTutInqDyQkD2rOIg3eDw==
X-Received: by 2002:a05:6a00:1149:b0:6e6:44d4:fcb3 with SMTP id
 b9-20020a056a00114900b006e644d4fcb3mr10378343pfm.6.1709869181638; 
 Thu, 07 Mar 2024 19:39:41 -0800 (PST)
Received: from localhost.localdomain (c-24-7-119-110.hsd1.ca.comcast.net.
 [24.7.119.110]) by smtp.gmail.com with ESMTPSA id
 j8-20020a62e908000000b006e48e64ef54sm8988678pfh.173.2024.03.07.19.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 19:39:41 -0800 (PST)
From: Justinien Bouron <justinien.bouron@gmail.com>
To: berrange@redhat.com
Cc: armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 justinien.bouron@gmail.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] input-linux: Add option to not grab a device upon guest
 startup
Date: Thu,  7 Mar 2024 19:38:27 -0800
Message-ID: <20240308033827.2835989-1-justinien.bouron@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZemO6VnxhuRI-7c5@redhat.com>
References: <ZemO6VnxhuRI-7c5@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=justinien.bouron@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> This last two lines doesn't make sense to me. Isn't the grab
> toggling entirely in control of the QEMU process, regardless
> of what state the guest is at ?

Actually, you're right, they do not make sense. This issue of having the guest
taking a while to start and the toggle keys not working, only seem to appear
when running the VM under libvirt. I was not able to reproduce this issue when
running qemu directly from the command line. So either this is a libvirt issue
or something related to my setup (VFIO with GPU passthrough, so a lot can go
wrong).

Should I send a new version of the patch with an updated commit message that
does not mention this issue?

Regards,
Justinien

