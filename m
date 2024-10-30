Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A7BD6B6C0
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 18:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Dqm-0008E3-Bg; Wed, 30 Oct 2024 14:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6Dqk-0008DZ-5D
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6Dqi-0005Vr-8Y
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730314518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+WpU+zXWsfOGZm1OxDKkgXCpmDBGKfj2dZ6VjtLdJM=;
 b=RxIEc3vBxMEUU+jADaaZzTIb5NwOXkTaZu23sxij1Zg6fsBK1W5St+jrftzC7WtddDcTwc
 vUeIwaLFtkrfyYZiiPvBqwRuLZlxlXJg/LnVrPF0621t8pkTReFfLG8t1pglwBZzPvzeEM
 LF165i20kPJnJEdquYA4mk9lTSjRCKg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-Jl8XE-YqNtSmDUohfNM1uA-1; Wed, 30 Oct 2024 14:55:17 -0400
X-MC-Unique: Jl8XE-YqNtSmDUohfNM1uA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cc32a0b26bso1983236d6.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 11:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730314516; x=1730919316;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A+WpU+zXWsfOGZm1OxDKkgXCpmDBGKfj2dZ6VjtLdJM=;
 b=XG6cwQZlHE9ixrfA21/5it5+QhmUpoCWcaLbdqOZP2uckO4Vz7z5ImOj8xPJhgbapt
 DZ82MrY5TDYDIaSKsk7q0o7UbNbxMrOZztOqnkd+GCY0cCFj2rZvDSnnH/gYxHDsCSrM
 wF0exTxj27wqYTAcqUg8emIuuB3UaNXNxHo6st9ChVu7m6jS3+mhXgGmi7sCPnJcEVTt
 xtx5gs0uH7yuJVHguc0qdpHSsLXMDVhasCUCCX2TJxDUgex61snCh8R89o9evI9sI6Vp
 LNrYOq1uuEUCWrTSUpHVASkLhjw33/tvs/sYUKu4fYGloOWZElfx0pfc5ZsRutG+NTkt
 uOYA==
X-Gm-Message-State: AOJu0Yx8QYC9lfQIB2/PPt1Sq+Sp/xeAVpqUqt6hMzBbY2ScyuBUNsqp
 E74v2cMadSQUVF5B+rpkYalO8iS1foATohtfZw6i0/JtCi8pzq8T5GmoL+sPqp6f+9uGEdODWWP
 SviENgjo4RDn5QbRqum8GpzWOn6aiH0NCRL+JJVpXeeq/Mt0T7nCf
X-Received: by 2002:a05:6214:3bca:b0:6d1:7331:4b00 with SMTP id
 6a1803df08f44-6d185849099mr235191516d6.42.1730314516747; 
 Wed, 30 Oct 2024 11:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyCEybIsMz794i683S6wcGD/6EUQp83u5mNnhatCxCz4/wm/xv5cTVTkpyxVRqbtqSR+dsJw==
X-Received: by 2002:a05:6214:3bca:b0:6d1:7331:4b00 with SMTP id
 6a1803df08f44-6d185849099mr235191356d6.42.1730314516488; 
 Wed, 30 Oct 2024 11:55:16 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17972f572sm54272946d6.20.2024.10.30.11.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 11:55:15 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:55:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 0/7] QOM: Singleton interface
Message-ID: <ZyKBEa-Tkv5CQApS@x1n>
References: <20241029211607.2114845-1-peterx@redhat.com>
 <ZyIA1zruTAxHfGcn@redhat.com> <ZyIw6Rt8kgrFRtXs@x1n>
 <ZyJbRZ02wX4XM-iR@redhat.com> <ZyJyOnHidTsPAXrR@x1n>
 <ZyJzt2gxWLPOE9fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyJzt2gxWLPOE9fe@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 30, 2024 at 05:58:15PM +0000, Daniel P. Berrangé wrote:
> That's a result from moving the "assert()" into the constructor.
> The assert(!current_migration) can be kept in migration_object_init,
> the constructor could conditionally set current_migration only if it
> is NULL, and the finalizer could conditionally clear current_migration
> only if it matches the current object. There's no conceptual dependancy
> on having a singleton interface in the patch.

Yes that could work, but that sounds more hackish from my POV, trying to
detect "which is the real migration object".  We need to assume (1) the
1st migration object being created must be the global migration object,
then (2) we still allow concurrent creations of such object, which I
personally don't really like, even with a hack already.

If this series cannot get accepted, I can try go with that, or I'll
implement the refcount in migration.c, whichever I found better at last.

To me, both are less clean comparing to singleton.

-- 
Peter Xu


