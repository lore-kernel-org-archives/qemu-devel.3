Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F14DC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHPVz-0007ES-DJ; Wed, 12 Jun 2024 11:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPVy-0007EK-3Y
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPVw-0006ia-DM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718204630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AQ6ffAcYyGtUjjJkQZnMwx4jibHGeXsUlpFebaPwdIw=;
 b=Ax2VsdPEO3jadvukfr9tnCmge+dcYGYWDM4jRrw+3mGOKu8XY9hAqe09Q15/FocqFMsvRz
 XPek+tGQuzy1DzGt7WUT/FM2UXk0Hk6oae+JfqVK9McBpxv4KKuQUdMkesjQbVsIc5uX1X
 40IScAR5bSyzcusHaRz7mrcQt1o+Fw4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-ZiKNhcW2NHqjFHXUr6szMQ-1; Wed, 12 Jun 2024 11:03:49 -0400
X-MC-Unique: ZiKNhcW2NHqjFHXUr6szMQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-44026f38681so1979821cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718204628; x=1718809428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQ6ffAcYyGtUjjJkQZnMwx4jibHGeXsUlpFebaPwdIw=;
 b=h14uEqfN1zrdrLGS77pCafSDhsTx/XvruAgmWJGR6u+jJlP8i4lrg3qCeB5q5HThsW
 +XN+ofHusd7bDpWceXD+Meg7zLRqoXMhwPAOOK7CZB2/K43EGU9keLiRpuklkS1EZrWf
 QeqIRHlAHVJUOXyDSm03l0K+bQH+XOlWL9Lr2r+0L3wv7jFflWjXQzyjoAmjRhLd1zqx
 pDb7pwFgKZ1HX9scj8uDAOwyhoHvOZ8SFIyoiHHc6T/oFC6fUpGmz9xQKEhmuVhHJbcu
 UeDj0+3WCt+YTbCCmj5sjqNmosB9HZAj8sFvDEUk71R18LbLswmJAzoZ4CJXaO04ig1h
 Mkyw==
X-Gm-Message-State: AOJu0YzejTYvb3dSelsa7ltCYEl2X5QAT4IUjUmqhAD9U/4uH9gL/FY9
 EHWIJNmAIivBqU3D2aXrFNpQV5xfDM4/eH/kfsVGg1VgGMyjUndho+/k0Y+QkF3ar08MUMWqmEg
 w1d8govpe1qRIICMLwfxyp6qDj8cEme+9JjFe6w1AFnP02kB2doWElagH0q64KLEnl46Y6oAY93
 RE2X3DGF+Dhl0gY/+jZLfKvXaiatwv3A6Law==
X-Received: by 2002:a05:620a:26a0:b0:795:5896:f83e with SMTP id
 af79cd13be357-797f6156394mr191446385a.5.1718204627533; 
 Wed, 12 Jun 2024 08:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1ZqOEC92FbTeMkMwXXhwHOv9W6XWHkaZQjB6b8hfh06ZC6AKtURUTdZykaJ3BCu6rajtT0Q==
X-Received: by 2002:a05:620a:26a0:b0:795:5896:f83e with SMTP id
 af79cd13be357-797f6156394mr191439185a.5.1718204626524; 
 Wed, 12 Jun 2024 08:03:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-795dca7ce06sm290649685a.112.2024.06.12.08.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 08:03:46 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:03:43 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH 3/4] migration: Use MigrationStatus instead of int
Message-ID: <Zmm4z0qbv8H39pC0@x1n>
References: <20240612144228.1179240-1-peterx@redhat.com>
 <20240612144228.1179240-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240612144228.1179240-4-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 12, 2024 at 10:42:27AM -0400, Peter Xu wrote:
> @@ -1544,7 +1545,7 @@ bool migration_in_postcopy(void)
>      }
>  }
>  
> -bool migration_postcopy_is_alive(int state)
> +bool migration_postcopy_is_alive(MigrationStatus state)
>  {
>      switch (state) {
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> @@ -1598,7 +1599,7 @@ bool migration_is_idle(void)
>      case MIGRATION_STATUS_DEVICE:
>      case MIGRATION_STATUS_WAIT_UNPLUG:
>          return false;
> -    case MIGRATION_STATUS__MAX:
> +    default:
>          g_assert_not_reached();
>      }

This survives the tests, but I just found that it's risky, as it's not
covering all the states..

I'll squash below when I send v2 instead.

===8<===
From 1fc42c76294044c0ccca8841e482472486de5459 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 12 Jun 2024 10:57:26 -0400
Subject: [PATCH] fixup! migration: Use MigrationStatus instead of int

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9475dce7dc..706cee1b69 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1637,20 +1637,9 @@ bool migration_is_idle(void)
     case MIGRATION_STATUS_COMPLETED:
     case MIGRATION_STATUS_FAILED:
         return true;
-    case MIGRATION_STATUS_SETUP:
-    case MIGRATION_STATUS_CANCELLING:
-    case MIGRATION_STATUS_ACTIVE:
-    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
-    case MIGRATION_STATUS_COLO:
-    case MIGRATION_STATUS_PRE_SWITCHOVER:
-    case MIGRATION_STATUS_DEVICE:
-    case MIGRATION_STATUS_WAIT_UNPLUG:
-        return false;
     default:
-        g_assert_not_reached();
+        return false;
     }
-
-    return false;
 }
 
 bool migration_is_active(void)
-- 
2.45.0

===8<===

-- 
Peter Xu


