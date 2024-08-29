Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05948C71135
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 09:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjbGR-0002Sd-Uz; Thu, 29 Aug 2024 05:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sjbGG-00029w-9n
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sjbGC-0003rf-3m
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724922965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=clyJnJCA/lG7gEklT/7SzAO8bDjGV6RgvPz4cu1Fcgc=;
 b=aMKGsH1JxsKSY/VSRQjmh+JUJBQr98TfOAauuQLEnObpO4GGuJQdwSTIMU8NJwyOnWvSEh
 ibq1kN2w5lZG+bgoz/Opa3/V5Wzdb+aSWYQ1bQyPdSOFHB7wolyS9KiWUQAsVLHEyYUVvI
 NqJU13mFGe8qg0HoF5xCEejk68naEM8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-MFJXTJABNWeTUvslT-kBVA-1; Thu, 29 Aug 2024 05:16:03 -0400
X-MC-Unique: MFJXTJABNWeTUvslT-kBVA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4282164fcbcso4561395e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 02:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724922962; x=1725527762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=clyJnJCA/lG7gEklT/7SzAO8bDjGV6RgvPz4cu1Fcgc=;
 b=xFjmfffDknn8KEeADuHMf7GM81zATOL6F5b2JnCMUbTx4Ju/Z7GX3Gk9+HR/pJZIg5
 g216KdH7vHS+qlRICTkYgGg1sXPTcQqV7i9ZRwimNirlArxhxpru83NZImNrm3yswFX6
 Tdu4W2tA7CTe1omrx1nEARt7L1oSp/hnv9M2jxlIgmCLCQhItiWnJpQ0E4Jog0YMXdds
 q+yVf+G93nt5mnGgT1wLxjN+unfQeC44t4eDYO3s4W4CvstRiuzelR2jd7OGUx7LSX/W
 lWlszH7rGm47DYPhPUGUZUfNAxymGz94DhVVadGrqfq6y/dQJWXms2gFhCiTjSfIAziH
 CELA==
X-Gm-Message-State: AOJu0YwPcZ8/fQnOorSKhydUajTfkh3lTTLhUC11LGy+6NUE3Bk41AHp
 3Z1PPEr8wWIyvoi4yw5A76Jei5pvl9iwdWzVxJWwF1cN2E1CIuffGp+j5+3LyaYi/NraXgbicmW
 prBigbjBmSczLhIB0vM+L3l+clGkdH+e2S84o9r3sXorYVkbB3YGDAZh6fAl7QB2o0nJ2WNBYfT
 HZTYItkFsEKSV3IlF0mQdHdwlmmXc=
X-Received: by 2002:a05:600c:470f:b0:426:6c70:dd9c with SMTP id
 5b1f17b1804b1-42bb01f242bmr18246455e9.31.1724922962415; 
 Thu, 29 Aug 2024 02:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqdsz1Aw9qPxz9gvs4PHkce3o5HX9m+OwVbMsGcMU+eeYZGz969WERF13XVCkXUHnZUt7fvPAvbI3/TP8SUbs=
X-Received: by 2002:a05:600c:470f:b0:426:6c70:dd9c with SMTP id
 5b1f17b1804b1-42bb01f242bmr18246185e9.31.1724922961857; Thu, 29 Aug 2024
 02:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240828100914.105728-1-ppandit@redhat.com>
 <20240828100914.105728-3-ppandit@redhat.com>
 <20240829033717-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240829033717-mutt-send-email-mst@kernel.org>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 29 Aug 2024 14:45:45 +0530
Message-ID: <CAE8KmOzC__Z6wgSv9sGcAPrbbZBOQg7tD=6An-=XZVouPCA2Bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vhost-user: add a request-reply lock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jasowang@redhat.com, 
 mcoqueli@redhat.com, peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Michael,

On Thu, 29 Aug 2024 at 13:12, Michael S. Tsirkin <mst@redhat.com> wrote:
> Weird.  Seems to indicate some kind of deadlock?

* Such a deadlock should occur across all environments I guess, not
sure why it happens selectively. It is strange.

> So maybe vhost_user_postcopy_end should take the BQL?
===
diff --git a/migration/savevm.c b/migration/savevm.c
index e7c1215671..31acda3818 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2050,7 +2050,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
          */
         qemu_event_wait(&mis->main_thread_load_event);
     }
+    bql_lock();
     postcopy_ram_incoming_cleanup(mis);
+    bql_unlock();

     if (load_res < 0) {
         /*
===

* Actually a BQL patch above was tested and it worked fine. But not
sure if it is an acceptable solution. Another contention was taking
BQL could make things more complicated, so a local vhost-user specific
lock should be better.

...wdyt?
---
  - Prasad


