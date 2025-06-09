Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3B0C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 22:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOkcR-0001lA-Na; Mon, 09 Jun 2025 18:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOkcQ-0001ki-DS
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 18:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOkcO-0003Tq-VV
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 18:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749506723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRxy/RmZWDWh5y3iQ80Qe/y74RtbpRQy2MhGcLQaHY0=;
 b=bS/nOIU1+FN0tRpIG+YlgbXb1AfD05vxLPK2hUfTVplbxTlMGSgo+7tZajJgkfQ4HMM8yh
 2en8cJmT5ITUG0R1uie9KpesB1npTOshCzEKpwy7WOqXOorc40WsrW9hhaiglfTt4TPIto
 zMR079c4w2nmG4fqRtuimn7cRCH8Xj4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497--c5WZn21MZKe81_q1Eix8Q-1; Mon, 09 Jun 2025 18:05:21 -0400
X-MC-Unique: -c5WZn21MZKe81_q1Eix8Q-1
X-Mimecast-MFC-AGG-ID: -c5WZn21MZKe81_q1Eix8Q_1749506721
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7d09ed509aaso869390385a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 15:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749506721; x=1750111521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRxy/RmZWDWh5y3iQ80Qe/y74RtbpRQy2MhGcLQaHY0=;
 b=ogOAD1q4zj5fLcSnzpRwcWlrCrFrV27Nliu9lmq7hJrw5TMz7uMTeSTJryNFWmvLko
 17p8qMrkmsUi1e+MJjDEl+LBf5YNukGQWUMSFZ6RPaaWkhdsxa/RimluUuU3InvvaPj6
 TYJ0rSeCvvCFN3EPOwKyTWSNZYXM3zSLUZqx7LRx7CUw5YxaoH/RT5jcF8dPGpSUw13l
 XNlrLZcfGLvChp4oZd+TvLFCszQruto8z3y20ft0I5eutA9jhQqYqDJFJoDXGkjZitOG
 I2MDoVXdaZ6mF9pRQthrwR53A7LXuK7ZDaSqOwg6ids6nr1V8B3hmQXMCk3znO9YVmMV
 DVew==
X-Gm-Message-State: AOJu0YwXAFB18OFPStA2B2naKniTstqR6UalyjxyA+3i8kSt63y0ZzlO
 0Zz27JAFZgpxWoD8Kre4yJ8WParOpCP+Sdu54q/Rom5XGL1jbOveTCrA0QvaaxrDSMdFr1yx0Ck
 HIprxvD/u3GJUdemNMme0TFE/Vxs9whMPFwZXPeOm017Lj/nfG6H0qEmWYkDn+TOQxg39DhdCwC
 42I7vtSUZP7S7aleNvADtki3zRab8T1Skt51ZyYQ==
X-Gm-Gg: ASbGncsr/KMTQHdc4IdJxyvZkS731IFnFlufOXJv7CnhD1z7OM/A9tefHaddfv4u57z
 EctbkHHKl2BOXGIgMed+duFqCnGRfb4lI5Uf2avImRTFBXB6sj3OVoX2j3qBwJ3pEz+VxIdRG5g
 dlncjLMpmrohMYJb+1WXIzCHCW+XB8eMnDTyjmXbOX6AcOWqY5IOaCTu58z0Eqbko68PmjilS3e
 LafSK3Q3jTC829Asc+rGtyOVdYNuUZAbwwvRixsRdnxN0YPzo/2GrkmiayCvTFfxpM/ueIG0Tl8
 81sWC5PtlCpIZA==
X-Received: by 2002:a05:620a:1a85:b0:7d0:9d42:732b with SMTP id
 af79cd13be357-7d39f5962a2mr53704785a.20.1749506720914; 
 Mon, 09 Jun 2025 15:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdMF9svvgKZS3eNdywgOvHULdRALqwDmWs2cQb+OiTAuJCl5BYuheqrYuat52zomeOUFcLPw==
X-Received: by 2002:a05:620a:1a85:b0:7d0:9d42:732b with SMTP id
 af79cd13be357-7d39f5962a2mr53701585a.20.1749506720424; 
 Mon, 09 Jun 2025 15:05:20 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d38f63dd31sm302955885a.5.2025.06.09.15.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 15:05:19 -0700 (PDT)
Date: Mon, 9 Jun 2025 18:05:16 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 08/13] migration/postcopy: Report fault latencies in
 blocktime
Message-ID: <aEdanIDLjSR4szMo@x1.local>
References: <20250609191259.9053-1-peterx@redhat.com>
 <20250609191259.9053-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250609191259.9053-9-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jun 09, 2025 at 03:12:54PM -0400, Peter Xu wrote:
> +static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
> +{
> +    if (info->has_postcopy_blocktime) {
> +        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
> +                       info->postcopy_blocktime);
> +    }
> +
> +    if (info->has_postcopy_vcpu_blocktime) {
> +        uint32List *item = info->postcopy_vcpu_blocktime;
> +        const char *sep = "";
> +        int count = 0;
> +
> +        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
> +
> +        while (item) {
> +            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
> +            item = item->next;
> +            /* Each line 10 vcpu results, newline if there's more */
> +            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
> +        }
> +        monitor_printf(mon, "]\n");
> +    }
> +
> +    if (info->has_postcopy_latency) {
> +        monitor_printf(mon, "Postcopy Latency (us): %" PRIu64 "\n",
> +                       info->postcopy_latency);
> +    }
> +
> +    if (info->has_postcopy_vcpu_latency) {
> +        uint64List *item = info->postcopy_vcpu_latency;
> +        int count = 0;
> +
> +        monitor_printf(mon, "Postcopy vCPU Latencies (us): \n [");
> +
> +        while (item) {
> +            monitor_printf(mon, "%"PRIu64", ", item->value);
> +            item = item->next;
> +            /* Each line 10 vcpu results, newline if there's more */
> +            if ((++count % 10 == 0) && item) {
> +                monitor_printf(mon, "\n  ");
> +            }
> +        }
> +        monitor_printf(mon, "\b\b]\n");

In the review of the other series I posted, Markus pointed out we should
avoid using "\b" and suggested a better way.  I fixed it there, but I
overlooked I have this similar use case in this series.  I'll fix this too
when posting v3 with similar approach.

> +    }
> +}

-- 
Peter Xu


