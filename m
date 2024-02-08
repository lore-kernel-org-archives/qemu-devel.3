Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95088C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 04:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXw45-00038Y-5m; Wed, 07 Feb 2024 23:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXw44-00038O-5y
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 23:31:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXw42-00015f-Ox
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 23:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707366666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXW2xWU5PjA/gKG90EW/QS7IKmLd0DUsE20KVtNqt6Q=;
 b=Z0DtoIagEQL3GlSdYQWRfvKTDA2hpb1aAVgvmkQoYHrUd7zzDsIAOVVthDDvN0TOC6uUsB
 w5CsKl6rpjmw0W2Z+RQby5/3ENtAlAsGb67i9QQWLherkAPc43B/rbq4rf0pabpQGHGG+D
 twhF6t8HBXYUXKiXCKZdb6bQtlwMekI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-tp2Kb4UmMRaPg4KEAW4jiw-1; Wed, 07 Feb 2024 23:31:02 -0500
X-MC-Unique: tp2Kb4UmMRaPg4KEAW4jiw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so467401a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 20:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707366661; x=1707971461;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RXW2xWU5PjA/gKG90EW/QS7IKmLd0DUsE20KVtNqt6Q=;
 b=a99b2x0qrPzZ/wN68WbgUStQX0e/lBvANQalOSZms7PRrnyv5dxYhtrfjj3SMOZ5OR
 2ieJwVyPiW6cZIcv/O3uL3hOwXHFlOAu/NdnvvjKP++kix8KQJxi0suJXu/60tvWlYeq
 n71AncxupQ9e3xq/CA/3BXpoXdqFNPAYgV7vQoomKxxMbCokL5+4J1rm4RPr79eRXN+0
 QzVZ8V5gaPklPKyT2QgycxBPWkkgpn+JJOT0epoev+WGc9V00h0ZeyHi2bG6tHl9YY2T
 a6TSJ2irDvprkSQ/Zl6I/aVOfuwv0CS1L6o7e+cfJexHr3Lq/qlslWsmyBlY9OvAd9xZ
 k7Kw==
X-Gm-Message-State: AOJu0Yx4cTt76S2QSjt/Rq7oa8EHbTMubgBiacl3edqzRvSsndkm5T7i
 eu+rPERKyqZPUFk/v3BLFa+wX9AuAqTtCrQK0C3NGPWSxI0NhMFVw9NJ8l/zW9mGaDRlAsY6eCr
 mKX1FH2yC17BzE8GpICJ/BPt3kAPsNLbd4h7URrUF7VaXSJdy13QI
X-Received: by 2002:a17:902:9f8e:b0:1d9:38d0:4d6 with SMTP id
 g14-20020a1709029f8e00b001d938d004d6mr8509064plq.6.1707366661590; 
 Wed, 07 Feb 2024 20:31:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4Ke9nxIBz/PQ97nPebCtabH4OfCp06lKE18M0av3xzOzH2bkAVTxEybzS1lmn4nbifAQm7Q==
X-Received: by 2002:a17:902:9f8e:b0:1d9:38d0:4d6 with SMTP id
 g14-20020a1709029f8e00b001d938d004d6mr8509053plq.6.1707366661271; 
 Wed, 07 Feb 2024 20:31:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUtTx4HZ/HbVp4cTGO1OZIQhBW8gqg/ysLEgzAFUqh9ytBbNpqvLgkBUk1a9daYFl8owL43mELhnaSs3dW/leK+nMB2ZaYGaZZnl4YX/QesaKjxpjx0tnThJXwy
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 iz6-20020a170902ef8600b001d95a70ee93sm2309529plb.240.2024.02.07.20.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 20:31:00 -0800 (PST)
Date: Thu, 8 Feb 2024 12:30:55 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 02/14] migration: Add Error** argument to .load_setup()
 handler
Message-ID: <ZcRY_-BE_vCwK68H@x1n>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-3-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207133347.1115903-3-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 07, 2024 at 02:33:35PM +0100, Cédric Le Goater wrote:
> diff --git a/migration/ram.c b/migration/ram.c
> index 136c237f4079f68d4e578cf1c72eec2efc815bc8..8dac9bac2fe8b8c19e102c771a7ef6e976252906 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3498,7 +3498,7 @@ void colo_release_ram_cache(void)
>   * @f: QEMUFile where to receive the data
>   * @opaque: RAMState pointer

Another one may need touch up..

>   */
> -static int ram_load_setup(QEMUFile *f, void *opaque)
> +static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
>  {
>      xbzrle_load_setup();
>      ramblock_recv_map_init();
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f2ae799bad13e631bccf733a34c3a8fd22e8dd48..990f4249a26d28117ee365d8b20fc5bbca0d43d6 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2737,7 +2737,7 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
>      trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
>  }
>  
> -static int qemu_loadvm_state_setup(QEMUFile *f)
> +static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>  {
>      SaveStateEntry *se;
>      int ret;
> @@ -2753,10 +2753,11 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
>              }
>          }
>  
> -        ret = se->ops->load_setup(f, se->opaque);
> +        ret = se->ops->load_setup(f, se->opaque, errp);
>          if (ret < 0) {
> +            error_prepend(errp, "Load state of device %s failed: ",
> +                          se->idstr);
>              qemu_file_set_error(f, ret);

Do we also want to switch to _set_error_obj()?  Or even use
migrate_set_error() (the latter may apply to previous patch too if it
works)?

> -            error_report("Load state of device %s failed", se->idstr);
>              return ret;
>          }
>      }
> @@ -2937,7 +2938,8 @@ int qemu_loadvm_state(QEMUFile *f)
>          return ret;
>      }
>  
> -    if (qemu_loadvm_state_setup(f) != 0) {
> +    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
> +        error_report_err(local_err);
>          return -EINVAL;
>      }
>  
> -- 
> 2.43.0
> 
> 

-- 
Peter Xu


