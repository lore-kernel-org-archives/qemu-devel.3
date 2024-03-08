Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A5FC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUDO-0005wA-7p; Fri, 08 Mar 2024 02:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riUDG-0005vI-7H
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:00:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riUDD-0006kj-Md
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709881210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J57HrATTXrfjWtB7fywcVu7vtlGHJqOd7j5cxWLsXtU=;
 b=AW0t0f7BMjb6gWinx5I5PJ4x0QHmNdVXLzVtE2znhfm1a5mDW6Nut+KsjSrSqAOOQ3Wzuu
 y5Vs4NkH830Kdts97+KqaVL+DCr6XavBNJsBzNTbKusKPeY7brEfDsfhRODdhrCZlypd0r
 +SjpH5tl9t8AC2F8Pb/5rkPpHtsog68=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-J4-NWr_4PO2aFeGU1FM41w-1; Fri, 08 Mar 2024 02:00:08 -0500
X-MC-Unique: J4-NWr_4PO2aFeGU1FM41w-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29bae9b83a8so205923a91.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 23:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709881206; x=1710486006;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J57HrATTXrfjWtB7fywcVu7vtlGHJqOd7j5cxWLsXtU=;
 b=YJTzNzhJT20mChSQGSWKvl/8Ka0KLlfu8GxEQ9VPEUGCQN8oMZVo4ekILuiByFhfQA
 3CfAA1bSr/5bPoRJR7COFApk9XNg+TAnQowQ6MjtknBZ6pQ6RfBzKSTJg1Snb6cP6Z/r
 yozgoh+7yh84DGSF4uildhks9N0+StgLkmroOjx351GHNw5Vbu5DN82poMiMxR/v6srM
 RqwxEA0lo+YazNte3Ch2lmRdNeaSyKUq6/6o0HX+Ok5Zt9eZq8nJ2R8s2EQIXzQXD8fx
 A9G+UzPxjY0ur2q2U2ewzmXP9Pwsu8VAg7q6WUwWStrwhXOLMvSIpvXir92sFp5Et/HB
 8L8g==
X-Gm-Message-State: AOJu0Yyxzm2lRBgFcul73+2c8Sz1Kp3D4buYOM6iZhWUsGUHQb7i2AB1
 k3hOpkrmotS/pzYl5KOE1pq/Wx06ZUqFarW9W/dzLxptMiQIQzhyq+GTaelDmTBRUBdm6DAcbPF
 ny19eMIA8ksxN1Al+Y2nhEQcAxnsCGEJjABIb7uS2DwFNQdi/BZ5Y
X-Received: by 2002:a17:90a:f3d4:b0:29b:780c:c671 with SMTP id
 ha20-20020a17090af3d400b0029b780cc671mr1110575pjb.0.1709881206628; 
 Thu, 07 Mar 2024 23:00:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhg662dYkK7YHoeR2Jei63TLhM97+2A8DKPIE8xWgb/gAb4uj0FuwlEp7l3V1OqguuJNX9Wg==
X-Received: by 2002:a17:90a:f3d4:b0:29b:780c:c671 with SMTP id
 ha20-20020a17090af3d400b0029b780cc671mr1110540pjb.0.1709881205767; 
 Thu, 07 Mar 2024 23:00:05 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 qe5-20020a17090b4f8500b0029b82593a6csm2546843pjb.0.2024.03.07.23.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 23:00:05 -0800 (PST)
Date: Fri, 8 Mar 2024 14:59:57 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 07/25] migration: Always report an error in
 block_save_setup()
Message-ID: <Zeq3bfUt6cpug4GC@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-8-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306133441.2351700-8-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

On Wed, Mar 06, 2024 at 02:34:22PM +0100, Cédric Le Goater wrote:
> @@ -404,6 +403,10 @@ static int init_blk_migration(QEMUFile *f)
>          sectors = bdrv_nb_sectors(bs);
>          if (sectors <= 0) {

Not directly relevant to this patch, but just to mention that this looks
suspicious (even if I know nothing about block migration..) - I am not sure
whether any block drive would return 0 here, if so it looks still like a
problem if we do the cleanup, ignoring the rest and return a success.

>              ret = sectors;
> +            if (ret < 0) {
> +                error_setg(errp, "Error getting length of block device %s",
> +                           bdrv_get_device_name(bs));
> +            }
>              bdrv_next_cleanup(&it);
>              goto out;
>          }

-- 
Peter Xu


