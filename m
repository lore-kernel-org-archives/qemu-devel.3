Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F731C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4N6V-0004Tp-1y; Tue, 07 May 2024 11:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4N6R-0004TE-5C
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4N6P-0004sm-Lq
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715097096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5xC4mmxAv7PbmZhQWGyCId8fJujH6vW2g0QyDQ6YYCM=;
 b=FAi4QiqA2pQqmQHsjrSzt3tHMEufsij/R2J6LFRjcKY52UlnNrM7on7vaXK9M1CsQvKEub
 W+WxlRGS9w0dRO9Fv3P51qUIcmsOB2XUwkU8YCBUdlq203DwEDo2PSHKHj9ItsxFZVKL9D
 HJLL9kdJUyqou0swYqnlISmxWU/nmUw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-ynKQi857PGmmE6yEOaAOUQ-1; Tue, 07 May 2024 11:51:35 -0400
X-MC-Unique: ynKQi857PGmmE6yEOaAOUQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c96e10b290so140998b6e.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715097094; x=1715701894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xC4mmxAv7PbmZhQWGyCId8fJujH6vW2g0QyDQ6YYCM=;
 b=G9HWO32mGG2a/M5YodvBuatI0ht8bJrFt2XWY8iQGC1lTAYQsbOfZSp7umdJ0WoXuO
 dApoNkUoDtz0a4168Gr5jMN4M0kNy25i5O8cQ0KQenwNT6WNzXblwEXkmJQWQamRk1jZ
 1j/BlSdDeAyI2zJvCfIw+rZ/ZEMOyu1HdcGPTVH/ULyL95DeFLchva7jL+7h9Nsgwwha
 EFPioG/sNiCmdApvo4/dNZjdD3lpBWyZ4XW8Bz9ANITAjrxYed+gsNI85DBFqzGvZ2kf
 McdWigauHN2MlwnrniCEh0eW8aNtL7QdmHDlK5UKpteiAAqJDOWIv8WRLBlx7AhjIg7o
 InTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVole/+9UnkviYK+hDf4+lfaZBISlNBykzP/xDNuRPc2Dgx6pHkq64cd+rjgLRYDVKiwI7UyPm1xFV0+exZfHa7gGYHMs=
X-Gm-Message-State: AOJu0YybQWCVWOAfqNULR/X4mFONcPSqsf2corwMXJtgU0URsY9dV9ND
 hjW00xOjHadE87LiJxsbCv/0wj3aOOMdtHIxje5+flsfWCCZLOtCQ1YezBalhCtsbQtGY2FzLUs
 RfXXB513EF8zYWLwIEkFiqEeVjSl6+CdSZKOdnY0+1HwKQ8jlYnV3
X-Received: by 2002:a05:6808:1a19:b0:3c8:4e7f:47bd with SMTP id
 bk25-20020a0568081a1900b003c84e7f47bdmr17294995oib.5.1715097093871; 
 Tue, 07 May 2024 08:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhfkGQCGap/tDEW9ARn8JfXLxQ+Keaqtbt+HxADBqqfaQT0JLDd1l2FPc+dIjBmsi0nlo5qQ==
X-Received: by 2002:a05:6808:1a19:b0:3c8:4e7f:47bd with SMTP id
 bk25-20020a0568081a1900b003c84e7f47bdmr17294963oib.5.1715097093248; 
 Tue, 07 May 2024 08:51:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 n10-20020a05620a222a00b007929914d7cbsm2126943qkh.81.2024.05.07.08.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 08:51:32 -0700 (PDT)
Date: Tue, 7 May 2024 11:51:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] vfio/migration: Emit VFIO device migration state
 change QAPI event
Message-ID: <ZjpOAm3kXE-7Rg6G@x1n>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-3-avihaih@nvidia.com>
 <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
 <0d368ac4-fbba-4829-b25d-d49957b7c9da@nvidia.com>
 <5e9c1edd-4e99-4fb7-8b9a-159b1a6503c5@oracle.com>
 <600825d2-a314-4120-ad2a-0b1f3c5bb8d9@nvidia.com>
 <87pltzsfl3.fsf@pond.sub.org> <87ikzrm2ev.fsf@suse.de>
 <ZjjyPESK-YC-XtFO@x1n>
 <23edb44a-7147-443e-b0e3-2a832aff5aa4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23edb44a-7147-443e-b0e3-2a832aff5aa4@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Tue, May 07, 2024 at 10:47:13AM +0300, Avihai Horon wrote:
> > While at it, another trivial comment is maybe it's nice to have a helper to
> > both update the vfio migration state, plus emitting events when necessary.
> 
> I think vfio_migration_set_state() does exactly that, no?

Ah yes, looks so.  It's just that I saw some common patterns, like:

===8<===
@@ -126,11 +167,13 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         }
 
         migration->device_state = recover_state;
+        vfio_migration_send_state_change_event(vbasedev);
 
         return ret;
     }
 
     migration->device_state = new_state;
+    vfio_migration_send_state_change_event(vbasedev);
     if (mig_state->data_fd != -1) {
         if (migration->data_fd != -1) {
             /*
@@ -157,6 +200,7 @@ reset_device:
     }
 
     migration->device_state = VFIO_DEVICE_STATE_RUNNING;
+    vfio_migration_send_state_change_event(vbasedev);
 
     return ret;
 }
===8<===

So maybe some more internal helpers?  It doesn't look like to cover all
updates to device_state, but I really didn't read into it.  Not a huge deal
really, feel free to keep it as-is if maintainers are happy.

Thanks,

-- 
Peter Xu


