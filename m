Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF6FC47258
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 03:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTCcW-0006ds-NQ; Thu, 25 Jan 2024 22:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTCcU-0006cb-Q4
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 22:11:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTCcS-0004BT-Mz
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 22:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706238663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E/Vk+b8r4RhTuHz/3oahxs/AnoHOQ4TIaeV5kJlPJL4=;
 b=RNxLzi2HzMIXskbvAPQxqKOdOGuJ3MW4C2raHAvRoThBKfBcvCw6TvIY1YC5rSDflOxuxe
 2pgrRQJvlcw7glFWs7+leB5wZsQPPp8TvbkN6h2k1ktAqWFKW4lHHAEfpQfnWPZeYH+VoL
 KY0P3CdgQzLeQY+zWcWlcrMpkoU682c=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-ILMSls35PYWVvdVFQZG6Qg-1; Thu, 25 Jan 2024 22:11:01 -0500
X-MC-Unique: ILMSls35PYWVvdVFQZG6Qg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5ce9b15f4ccso1581035a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 19:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706238660; x=1706843460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/Vk+b8r4RhTuHz/3oahxs/AnoHOQ4TIaeV5kJlPJL4=;
 b=HT3M12tqHmqjHaS/K5GpPqg8iq6JI+VGxGVvL1C4rpJSORZiaB9fGDbjdJ/PR4BlET
 yAhPIH1DcZSdsqddfQvTIyFy5PmQpYuOp8+LwxmSPeTIQkiK9WWq/s+EfCfQ6OE6AblI
 gWoUvtt5l7H3p8COD6Ecif99f22BJYVehYEUqw7DRXZJ3+FEp+/WkNEQVpSptoNPWxqL
 NxNTzN5GSwpaVIGqrLWFqMsyUiwLMseo1d1256mhg3y5E8irK++SuTn+e1fPdqkt9sLV
 fcNgBhRJmMGkPe3RRQcyFB9NEsP6flgQDQRwLi5ybXlPNSgFPIcMKcNJ1WPTnjouNfMv
 5WFw==
X-Gm-Message-State: AOJu0YwJPcZlwkzcUd0pR1SxvOpKDX6kBF4dj7yqepyjJQ4d1fWk5flm
 vxGPCISAyZjvECcxVmgfP+3k1xOC5ShqKP9M6x4q4TeAprne4oyM39w7kpcrYio2UK+iJ/9FTVv
 2TR0V7Xr0gP2wOn1B2AdBCtSPpoOTxU1jZsrE+AsqwEf7+nqrjgMt
X-Received: by 2002:a17:902:ee53:b0:1d5:dfd8:a92a with SMTP id
 19-20020a170902ee5300b001d5dfd8a92amr1341557plo.1.1706238660079; 
 Thu, 25 Jan 2024 19:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv6rZDtgmf12NyNw1hyib44HpFSSofaISnLkjoc4PxpQjsu9VnezLA4CwnPAwdDCRWsdkXWw==
X-Received: by 2002:a17:902:ee53:b0:1d5:dfd8:a92a with SMTP id
 19-20020a170902ee5300b001d5dfd8a92amr1341542plo.1.1706238659719; 
 Thu, 25 Jan 2024 19:10:59 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 kk12-20020a170903070c00b001d70953f166sm201302plb.155.2024.01.25.19.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 19:10:59 -0800 (PST)
Date: Fri, 26 Jan 2024 11:10:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 02/17] migration: Move local_err check in
 migration_ioc_process_incoming()
Message-ID: <ZbMiwBjr7cNmQDNR@x1n>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-3-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125162528.7552-3-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

On Thu, Jan 25, 2024 at 06:25:13PM +0200, Avihai Horon wrote:
> local_err in migration_ioc_process_incoming() is used only in the
> multifd if branch. Move the local_err check under the multifd branch,
> where it is actually used.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


