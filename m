Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0E0C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 04:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXZJL-0004vP-0Z; Tue, 06 Feb 2024 23:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXZJJ-0004vD-M4
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 23:13:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXZJI-00007c-8R
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 23:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707279199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4I24TIdXzyDgU8YHEV1SMPsJ+vzOOsNCyGzxihe4dao=;
 b=Uwj9FzaBBddoNK3Cu5gNqLIaj6GMGsa/O8t6rkr/0E5yy5gJBnGR9JUHtU+PqNAeEVpKER
 rBC0hkE42DaXMXQkxjmWlb02Y1xgc4gjish8SujKYqqsA61ikg/rZac6D7n1/epSs8ecBo
 fnAlFXWTj/VCW7NmZ2hV2x5FJT8ELZU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-iLmXaXl1N6OCTQrsWQ_w3w-1; Tue, 06 Feb 2024 23:13:17 -0500
X-MC-Unique: iLmXaXl1N6OCTQrsWQ_w3w-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5dc1aeb6a58so95865a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 20:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707279196; x=1707883996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4I24TIdXzyDgU8YHEV1SMPsJ+vzOOsNCyGzxihe4dao=;
 b=pmLcYFd/2lamO30VZLKfNUZoTx1jVG20b6xl4H1KN72TBSvMSXqM8nmDmWxZezYGEU
 J0zp0nft32Hyo5r6o5161rheoAlBa8u26bUSgtfKSW3NWfK1jx9zGcEdsqwGCiLezbMc
 J9toysl0sIkvknJ1PNhUX+7ytLVgm/PWinofnW1yj9J+7/8NHjAqK/HkKc0lak2bw4W2
 aUdKgT1LA4rdN57Yb5Z5Ld64i4LAYEK5/64EGwqF+ZEEzLIv2EE72lrd0mUP4cQU1er0
 cud7KHk+ZRDSqOqXHdib5kVP53SJr67ZIZhehKrbZwQan5OHuOViLhkmbzC6WX0VRjDD
 brrw==
X-Gm-Message-State: AOJu0YxGhZ3aR+7EeZqexkDk+MEvwt5AQtWJJZSwzush6OKlyDW+reiH
 WujYLIzYa5tyEZAvMXoAXanRPKEjNmgflv4maftQ3xdWkEnaT/2Wt6glK7N3Vk724mf7l8D3sDF
 5PWFcClt3vzTfNDRI/oH03fLh3sBgYpUUunpwYyyHSiay1w0pwBj4
X-Received: by 2002:a17:90b:4b52:b0:296:643d:76a with SMTP id
 mi18-20020a17090b4b5200b00296643d076amr4745199pjb.0.1707279196038; 
 Tue, 06 Feb 2024 20:13:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdKTSdFhsTjRKufCfikCLFcyXX14YtJOJOV+zzepQTRocjDl7l4oNrNAxay8PlV5zR4aFEGw==
X-Received: by 2002:a17:90b:4b52:b0:296:643d:76a with SMTP id
 mi18-20020a17090b4b5200b00296643d076amr4745189pjb.0.1707279195712; 
 Tue, 06 Feb 2024 20:13:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV9r3pynsAj5HvXs7mjs/0MYfk4UQSs+3yFu3V1dTTLrADr5iSdyt749ceN2Cj7pvNMqFrceONO2WrniCURu8E=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j1-20020a17090a318100b00296a4c3a7aasm2857868pjb.52.2024.02.06.20.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 20:13:15 -0800 (PST)
Date: Wed, 7 Feb 2024 12:13:10 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 2/6] migration/multifd: Add zero pages and zero bytes
 counter to migration status interface.
Message-ID: <ZcMDVpLilA-PZ3he@x1n>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <20240206231908.1792529-3-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206231908.1792529-3-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On Tue, Feb 06, 2024 at 11:19:04PM +0000, Hao Xiang wrote:
> This change extends the MigrationStatus interface to track zero pages
> and zero bytes counter.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

When post anything QAPI relevant, please always remember to copy QAPI
maintainers too, thanks.

$ ./scripts/get_maintainer.pl -f qapi/migration.json 
Eric Blake <eblake@redhat.com> (supporter:QAPI Schema)
Markus Armbruster <armbru@redhat.com> (supporter:QAPI Schema)
Peter Xu <peterx@redhat.com> (maintainer:Migration)
Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
qemu-devel@nongnu.org (open list:All patches CC here)

-- 
Peter Xu


