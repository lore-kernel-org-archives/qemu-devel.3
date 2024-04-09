Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69770CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru5yN-0007Sx-UR; Tue, 09 Apr 2024 03:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5yH-0007Mo-29
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5yE-0001eL-1F
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712647960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SjJapfA0EMdaBP1MiLjrwUGdMH/J/+78hWE+vX3muqw=;
 b=VLs76ezz02nsPGnbEaXqTUKe7RMr68hFrmhx3h3rF4bzOZLU/TtKFID3OGjtZez0Z8WNl1
 oWSw3cZKyjxGr5PDf1qGWOj8Irc4OENXXTQOcrD+1RYgMtJixqhOMNpL0EvScfUZe6RoL7
 Qb3WqrhLWAcva3eEVELQYHvezZaViG4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-e9Py1mDsOj2mS7wckG8-Rg-1; Tue, 09 Apr 2024 03:32:38 -0400
X-MC-Unique: e9Py1mDsOj2mS7wckG8-Rg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a519e10623bso268642566b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712647957; x=1713252757;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjJapfA0EMdaBP1MiLjrwUGdMH/J/+78hWE+vX3muqw=;
 b=Y3y7A1LbfVEBPCW6AaJAIKScRZX7Xw2+htrqllWCJEKQR45oEDZ1IJg6f77qF4svec
 tPHF369PVvs2x+LlDBb3efAvkbDnU9cmQXgyuRBtvaEl7xZ61YQKFJHJ4hOhVlB+rU4m
 Isekp6W+noEyLlhpinSB44JqqIc8iJRvptlPq76c92TGvAO8GJNzQNd/B7QF2LA1lRYf
 iK9TCBSjraeUKxT/W3chCPXGtbNw+lW7cNF+qQbMSyzEAhJ1NXLxaXhXCN12C+saiIYa
 fgVFW5835kCSt5AjkON2m3pg+e8ynpTMRvUEnIHa70TjNuhO9OVSzaAjWiL7cnbwW9oF
 VtgQ==
X-Gm-Message-State: AOJu0YzqHvc36JNXF8vF5AvqBNTuC2R7V6hl//TGMbPeyCZvEw0Ar2ED
 VyAzfLujSV/JLPlrrXZ5RZEk8cJZCQdNmlUaRZmbVZIW4rw1gxbmPoPJMrY8dWSfSPV6EUYzfoS
 3PaUpP+TPd70eB1+0PHiOcI4Nwm4G4CYW+VtCiSX5j1La0Nzf5Z4XVyL4oDLWB1Zc5P3nn/Qzve
 vjVJCxwFJdGT4bCCAIX0NkcXzMdaRz6w==
X-Received: by 2002:a17:906:bc48:b0:a4e:8c9d:a724 with SMTP id
 s8-20020a170906bc4800b00a4e8c9da724mr7418231ejv.69.1712647956738; 
 Tue, 09 Apr 2024 00:32:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0WH62Gjd0zz7nrdwhT+Up4RR+3xeh8r8Au3kZ5XRTAh6A3Yv/zE9zH2qJ73uYgKAr2sCq2A==
X-Received: by 2002:a17:906:bc48:b0:a4e:8c9d:a724 with SMTP id
 s8-20020a170906bc4800b00a4e8c9da724mr7418209ejv.69.1712647956282; 
 Tue, 09 Apr 2024 00:32:36 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 ld11-20020a170906f94b00b00a51d8a3a632sm1966027ejb.168.2024.04.09.00.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 00:32:35 -0700 (PDT)
Date: Tue, 9 Apr 2024 03:32:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 7/7] qdev-monitor: fix error message in find_device_state()
Message-ID: <e1999904a960c33b68fedf26dfb7b8e00abab8f2.1712647890.git.mst@redhat.com>
References: <cover.1712647890.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712647890.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

This "hotpluggable" here is misleading. Actually we check is object a
device or not. Let's drop the word.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240329183758.3360733-3-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 system/qdev-monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c1243891c3..840177d19f 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -891,7 +891,7 @@ static DeviceState *find_device_state(const char *id, Error **errp)
 
     dev = (DeviceState *)object_dynamic_cast(obj, TYPE_DEVICE);
     if (!dev) {
-        error_setg(errp, "%s is not a hotpluggable device", id);
+        error_setg(errp, "%s is not a device", id);
         return NULL;
     }
 
-- 
MST


