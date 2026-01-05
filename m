Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AD9C79FBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcqaE-0007Fd-6c; Mon, 05 Jan 2026 14:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqa9-0007Dv-4x
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqa7-0005jE-AR
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767642574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WzJ03KFVpxOB/1G9pxAMDR2SacnkGHyLUTqv7Ika9Ts=;
 b=NRG0NF2xsbWhwFBJgNgnDT9O0YP+3sdqEltC6K5UBv8Go2W/94I8IYBvTpEBjBTgKfadpb
 5qzIW2HuJVxRBEBMhyQnBo3NtM5BrvVEndu805jUcYfGuAdYv7+6O6HhA47aiY56Ae/8CC
 lXL9IyDKo48LkJ+aqftsvYM6ySSqGgY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-nYJp7mn-MySEuA3P2VOeHQ-1; Mon, 05 Jan 2026 14:49:32 -0500
X-MC-Unique: nYJp7mn-MySEuA3P2VOeHQ-1
X-Mimecast-MFC-AGG-ID: nYJp7mn-MySEuA3P2VOeHQ_1767642571
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a0a0bad5dfso4554455ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 11:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767642571; x=1768247371; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WzJ03KFVpxOB/1G9pxAMDR2SacnkGHyLUTqv7Ika9Ts=;
 b=nBg4uKq3Vd/piLzday9OIGzvKt01n+rmDL1o+cPqJES8av8kUPrvDYvrQvKUkFeEhw
 lsdHSJM+aZw0fpU9fCtu/AGG7bBJXctmEDhBElsEde7mrmF949CMjsISHl9ePPZIkwKF
 1B87Tv/KJI6OR5zcVYKWc1p2VosVHfkLTk/mpcL7uZIZR/CoJVZQUEFWF5iK4JOUMpt2
 Q5/r00a2UIaF31H3AcmcVx7PKBdLi8nQ4jB/wppU0vkYmXU3+hBZBegqc4v/lnvSJHJa
 QMMYNZTmYKoOYgrk/5/uIi7ndCv5T0Eljbo+uvVITi8Ujh3MhBu+XfrALniukLvupy0J
 /XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767642571; x=1768247371;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WzJ03KFVpxOB/1G9pxAMDR2SacnkGHyLUTqv7Ika9Ts=;
 b=Iixqc4RDaNIjrdA8ixJSbOrjo2PXk7JnF3Sur7gS6S6ajXi6fmh2OcMzmZTDINQmUS
 /yJiiOnwy9Tg8rNMgDnMZmg3z77F/kkbn2mC+7C+uPIInLSQpQ3Ude3Mp2WwwQw2rzJ1
 KcxDEHdIcclD7t16MAlt/Vc0uGakLEONyQpaJ9dsBCogLhnLeRPedqSt0bg9g3BWCoCE
 sBaKJz5VMD1TSth/KEwgpXPLq+78CnDan7BNfCZAlgBI+I+SqqQtUQTCSTuLBr8egM/A
 KFGpUzafRWDb8l6tme05o1CKN2oKL4impmAs5GvrP96s11IxpNbd/H3RS3r6eLvNz85n
 F65A==
X-Gm-Message-State: AOJu0YzsQ+5op9BrdcgfXGGpsnlznJMKoRrF8uCwLVirVg57wy+r/y8C
 5E5s6v2TEJZDrf+SgE7KaaEY5loxY0JYDluJ388ptC6vI7HWo9Ss9y+h92nkrAKOH/KJvHEU7Pt
 Ar/EESd/4XmTll+20SzxIGZoPvLqs+HGezkcZU0CbjR7c5TgNE6pCfX8VLXeFvE4z
X-Gm-Gg: AY/fxX4G68Z/tbJn4BxLpOTDP2N2nRDM9QEXu/y/luw9dVsSFrvMirGqD8vUsdUdLvw
 FnvPcJvtDg2i1f2Z0SI8yE2JeEvqyUPfdj2+tFwYXidIAe5KhJ2BrAKfBWzkGOJIMHjjneinZua
 QjypVvNqavhqRc+5KNHRpJ8l1OWkrQOUPBTMR/vO6D2Lhl0ZHa6zzL+twlLPPjcGFuic9iTwmbi
 LLRb77gDysxQ8lkRx5MeMgkN2umWmm9/ktZe7VAnHo2NbMKRM6EogHWlLZ6pb5aspyqdVXZcBSk
 GVG09siVpphR5PCEAE25XbSbWu0mUZ0pCOn3ECSDindKZ38nUXvlC3PwsHqH09GkdWlQTH4tOpr
 snkc=
X-Received: by 2002:a05:7022:2609:b0:119:e56c:189c with SMTP id
 a92af1059eb24-121f18ae827mr479296c88.4.1767642571212; 
 Mon, 05 Jan 2026 11:49:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcfZcwH4dQTr6p0uWyKZeSv+t1TX/2xFoKaFce0BJC2U7u2lQHQdMTGCNK+dx6hygHm/4kEA==
X-Received: by 2002:a05:7022:2609:b0:119:e56c:189c with SMTP id
 a92af1059eb24-121f18ae827mr479277c88.4.1767642570627; 
 Mon, 05 Jan 2026 11:49:30 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b1707d60b1sm64088eec.31.2026.01.05.11.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:49:30 -0800 (PST)
Date: Mon, 5 Jan 2026 14:49:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2 19/25] migration: Move transport connection code into
 channel.c
Message-ID: <aVwVxUVdcUFg-2qq@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-20-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 05, 2026 at 04:06:36PM -0300, Fabiano Rosas wrote:
> Move the <transport>_connect_incoming|outgoing functions to channel.c.
> It leaves migration.c to deal with the established connection only.
> 
> (I sorted the includes)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


