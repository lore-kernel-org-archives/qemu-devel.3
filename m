Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31F5C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDEp-0004Pj-Ip; Wed, 14 Feb 2024 06:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEb-00049B-KZ
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEM-000714-Fb
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/GevgLgj9voaDnNnKRlj9zSBAyk98vBx5fEOilPhZE=;
 b=cSMiMTNLv6PBnfOmoWwJ6OQQb4oMnQvteB/l7oN0M9kunPu8IUdXw6irWvax/d0WsG6gHB
 PqnWgkpXUkqyCdfEeHrtMlEu8EE1wENva7PXe/MkTlJpRrmpwIpoCfM3/RufR5ufRJRHYM
 vrxtvID76ngfLg1BSaPsNwlZD9wDihE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-FXBcN5RgMUqEVZLNi2AXLA-1; Wed, 14 Feb 2024 06:15:06 -0500
X-MC-Unique: FXBcN5RgMUqEVZLNi2AXLA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3cdd79d960so114110466b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909304; x=1708514104;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l/GevgLgj9voaDnNnKRlj9zSBAyk98vBx5fEOilPhZE=;
 b=gd+99YZ4PFigqqgn8pOGC6wIfauibDM76aKPkTg9zHGoxjXkCpUU4TfAF0MWmrOaX/
 m3v1+joR8r+Xciu7WjdE2/L8MVm499xoFOBjQY4bK6TtOrUHu9uGA9+W9pUTnmp848tH
 LZ33Kng8LqJy7p/J/jhDR4TJHmrxEpsBUMbIX3mx58MVxUfPIPBeErECjV+tJVCBOTai
 QsgKSKv4QUKOWdjBteeQkfeshxbqt+ntauipCnppCImjxoZ+7xLZwz/e/WKxqiAUZ27j
 lOzuKpjw6bH9KmkoTLfJh5APiBz1RcS8tpQWjYLMjqyRpzekB2TjLMbPJXiqbxEebRY0
 r3fg==
X-Gm-Message-State: AOJu0Ywo65g9Quj8ZTsbuFa0lbcR6HjANfioCz9yK7fTkHmRPF9a7YpZ
 NpFLai/1oPK9kehm9YAsbUrmmf/WfsDbfRTUUrr7KAZ5Q6UWbDtWs3kC/xuHQqRKyCEDz7xvuJH
 yt88fuQMG5YIC6DxciKrJsewvHcNUJB6qvizfkPP6rFrIMsTA5zmx7XqwXzVFoSatA8kePPZP4P
 /D3Qfa4RM3V5cmM9+/D03hC99k+Ue6XQ==
X-Received: by 2002:a17:907:104a:b0:a38:8ed4:fc82 with SMTP id
 oy10-20020a170907104a00b00a388ed4fc82mr1396621ejb.15.1707909304478; 
 Wed, 14 Feb 2024 03:15:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnhcqC8taT79QS6qLJuk+vLqToWhB/bIZ4y45pBYTwyb5z5c8753J+Z/LOlK1ZbAxjMsWunQ==
X-Received: by 2002:a17:907:104a:b0:a38:8ed4:fc82 with SMTP id
 oy10-20020a170907104a00b00a388ed4fc82mr1396598ejb.15.1707909304005; 
 Wed, 14 Feb 2024 03:15:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWr2E1LeWwcIDTJquGh0IR7JfFSYxQ7zC1c/rzMOciSHMkdbtblhrGMgLkOpQCuwPh0+/rUrTZvUOo2puNvavQjY6zNcFhsDdLa3fhisyUguCwAfVkUCJ8pZMzMg1q2e6+hS1ITWG4dY2LWac7c2vJFc5pS94UcJzbuekf/dHY4feipLwp6b1y9T8kG528AEpisM1sbtLGhzdCwPaUBwtD7nA==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 mm19-20020a1709077a9300b00a3d4d78a769sm404919ejc.1.2024.02.14.03.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:03 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 34/60] MAINTAINERS: Drop myself as VT-d maintainers
Message-ID: <e8058c6d65252d920abf0bee027c455e8ffe41ff.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Due to my own limitation on bandwidth, I noticed that unfortunately I won't
have time to review VT-d patches at least in the near future.  Meanwhile I
expect a lot of possibilities could actually happen in this area in the
near future.

To reflect that reality, I decided to drop myself from the VT-d role.  It
shouldn't affect much since we still have Jason around like usual, and
Michael on top.  But I assume it'll always be good if anyone would like to
fill this role up.

I'll still work on QEMU.  So I suppose anyone can still copy me if one
thinks essential.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20240118091035.48178-1-peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 89f2d31f70..7a1afb40ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3630,7 +3630,6 @@ F: tests/uefi-test-tools/
 
 VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
-M: Peter Xu <peterx@redhat.com>
 R: Jason Wang <jasowang@redhat.com>
 S: Supported
 F: hw/i386/intel_iommu.c
-- 
MST


