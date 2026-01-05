Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F13C79FBD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcqYH-0005zh-In; Mon, 05 Jan 2026 14:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqYC-0005uS-Su
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:47:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqYA-0005Dn-2s
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767642453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpa2xPQQ+9zbrFcGFQi49VhLahVmaBWdz4p2uGSXUg0=;
 b=DqsrouFjYsOn5auI9D35W+0K7jagajp6G9PGl/T6iQc8PG3nLx6/jHuM8CaRJXyGE2iGeL
 UHPRNIZTgqAqQRKxDjdBUODO1h/2aMzUYmppJNdQC8IG2YLQ8adpabByOL+ipDiG4LH+h8
 Hx9FvPOgqn9JyFu8+rrm37JT2Uba7V4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-n-M5l4knNeeoEJOHV1GFrg-1; Mon, 05 Jan 2026 14:47:31 -0500
X-MC-Unique: n-M5l4knNeeoEJOHV1GFrg-1
X-Mimecast-MFC-AGG-ID: n-M5l4knNeeoEJOHV1GFrg_1767642451
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-bc240cdb249so173968a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767642451; x=1768247251; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mpa2xPQQ+9zbrFcGFQi49VhLahVmaBWdz4p2uGSXUg0=;
 b=XPV+K/E9ZV2jD1hXCJrjKZknY1rQ/W9Snb1jBLMVWdDwCI0nzMxzFU80Bd0TYslPHG
 KFPskzOYY0WjQQVuJaOKYMgSPb4gl8DLdo9OlDAMDICouT5sR6e2eu/QBOO19DKZG7zq
 4M86Fx6oMVnHUbnvlZv+1JPBbrqs5Ii3Wor7rtJEIFdjTfgAr1vUeOi4IAjTeGbvwMbW
 eyWTtoXWq/jeVVuk1DswOQ2n5lE8VOgZYZgEMaV72Zh1BxfyRy4zGLZxJwpBE3I2+VDQ
 2qem/VOeeO7PgIaPGJRY+Ld1YVChFvGqjbcdPySNu5zjiyWAsQktOxys8+0zTDewvQK3
 mLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767642451; x=1768247251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpa2xPQQ+9zbrFcGFQi49VhLahVmaBWdz4p2uGSXUg0=;
 b=Ud43Zdg73XV7hETwvq8xy+Tm0wkAVi7yPFFuhBmmEn2n66yYJSicELyLzDWi2JlBFH
 f76hMmufQdlxdZNASylnD8NUP1nrPAFzD6A4Ia96XK8y1JRMmCWYNX6oEyGgmc185rtr
 Bz3iOAcepAD78LzHCPkxtFWc+qVgfngIGgjWfOmgsl82hkw3JBsj4X46mjyKTxSsWvOu
 lfdjokoHhakyuhbK/YUSjW87Il82zRYyeue4bUbuPOa0+/VVupyYL1ajFrb9DU3fChbr
 /JrG/+xuigXH7bUpmrPovLTZOafrzlJthCl272q42ZRnPNxQYErTzenXMlrdXu3/ZkpX
 5Kgw==
X-Gm-Message-State: AOJu0Yyj0UA4BlqBQbx+a9hvH9AoEzMpmebl8nFHTljk4MRReyFa0vt5
 YGSHa007IU6CuU3oKbsVNFXM7pdcbgDLCHVtOpkyyocB4lc/OhiMv0AOoe4WdQqspmOANi/OHdS
 1nUPENoAngTEhYO7OA1iYwx9akd1IejFDHhp7ehSwUQ/S1yEptoUWmB0A
X-Gm-Gg: AY/fxX6qE2bMACK4IlpzPdxCgzTN9sJ5AZPzNR0INd2jb8ZTZwGn0wniEKLk0/1qKFh
 VoXjQjOdJ0b7fxNcgGkEe6A6NHVEWXX/E9Wf3wCSBU+JcTbRZqlPfizaJIdbtAcgzym4QLFccD8
 Irq5wDzj+ifni8c/NAx2iz8RPhOx/pUWt1oVHCZyFyKFKLP7g8Rqk/4S/tkPiYosVf7a7Dzmdq8
 6LujGv7kWxXkIAc26pX34INKxYyfaSx0hvIHlCnOAo3Co5DgkAPokF49Mpg3hKv6eYzWtXkvDL8
 51DnRjjsChkoD2nPsVaoPYdnHb+70uTVZhf6CyDVqJQzex2QzyQCM6o3Czt2QZAV4qSQmQMnYFv
 Jr64=
X-Received: by 2002:a05:7022:4403:b0:11b:b622:cad9 with SMTP id
 a92af1059eb24-121f18b6e27mr470184c88.21.1767642450510; 
 Mon, 05 Jan 2026 11:47:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRHxlsoXxBfl/qLxCHTDNkTIUJKwc/OFRSTQ0zZIMQ7qKPrKl0GfvaVziJ8TjK+fgZ4ZscHw==
X-Received: by 2002:a05:7022:4403:b0:11b:b622:cad9 with SMTP id
 a92af1059eb24-121f18b6e27mr470160c88.21.1767642449986; 
 Mon, 05 Jan 2026 11:47:29 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121f1392387sm1408424c88.10.2026.01.05.11.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:47:29 -0800 (PST)
Date: Mon, 5 Jan 2026 14:47:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2 18/25] migration: Move channel code to channel.c
Message-ID: <aVwVTMJBVGsIkEh_@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-19-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-19-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 05, 2026 at 04:06:35PM -0300, Fabiano Rosas wrote:
> Move the code responsible for the various channels connection into
> channel.c. This is all executed before the migration_thread and
> process_incoming_migration_co are running, so it helps the reasoning
> to have them out of migration.c.
> 
> migration_ioc_process_incoming becomes migration_channel_identify
> which is more in line with what the function does.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


