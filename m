Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1FFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shADg-0000x6-Kk; Thu, 22 Aug 2024 11:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shADf-0000wZ-5i
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shADa-0003g5-PQ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724342361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iFA2z9JfXFjnL2SG3Gn7KjisECx4I6Cx2N/LvXW1y1s=;
 b=L/5jGrRiM4p+q60O9+4o+KCc1KGx0bjAgZR6gLzS7M8+EyFUkErvQa0eRSFmyMNf0lLKrt
 r00KQ0I0EMoCb71rG/3bw3X9LLhnutZEimWMKvLnF97tioZr6/L2jTLN6jNrq1cdPxZN/q
 GG/dOhyPY8cJSGZMLgc2bA3RAPpAT90=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-DWqnjnLkOECsCWZcpFyFBw-1; Thu, 22 Aug 2024 11:59:17 -0400
X-MC-Unique: DWqnjnLkOECsCWZcpFyFBw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6bf7a4ff102so16618846d6.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724342357; x=1724947157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFA2z9JfXFjnL2SG3Gn7KjisECx4I6Cx2N/LvXW1y1s=;
 b=dsu34nVkvQSOIzV2GNU4XZCsz5Hf/x168ZUTClYPqpTqSlcUXuHvdVfme9M3Klw2RH
 FTlipalPOYwimmuAPBDSMa9xQFbE7sWAIAN+EX/3VTjYO3qe2tvqopNpQHim80GPjpXa
 ugsQq+/O1JLxqSatr6Kj1Dg1HHzKeIckew0CrmtWB55azcQFXVBzIucAIs0mJDaW9aMn
 HnSKPhdZow7vsffwBAK2nr56B/dcX9gpflfyTvYAcJSutZjeid4lkBz4ZlqVKn2XreYR
 8LD4idIPuzLQeMYgLm/zNlbu/a4mx1pjw30TUZX1s+bwc4+KY8g5I3Y82ACmHNK4ao95
 hmNQ==
X-Gm-Message-State: AOJu0YymJLYCT41BeXxugDiSxDXcetqYc8g6xXibrmF4wWrA7Z4d3ewx
 HJw0XBJbzwgQ9gicAtfSj+6cMM+1xgxAuIAZOWDOGrftHgUO1uOIaBeZShL4dqbSHI0p3C5sbHl
 MU2hKVPxMaYgymoXgz0taej3eIu62uMu3ZoH3GocKzRdVdu3PaQbI
X-Received: by 2002:a05:6214:224a:b0:6b5:101c:6473 with SMTP id
 6a1803df08f44-6c160c410d0mr59741286d6.2.1724342357046; 
 Thu, 22 Aug 2024 08:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtkQGXWdUmwIVh4L4B2a4OkhwQ94JLy86HxRDSNu/lRbzzXFJU5c0VaZklvDRnQszy/hGbGg==
X-Received: by 2002:a05:6214:224a:b0:6b5:101c:6473 with SMTP id
 6a1803df08f44-6c160c410d0mr59741046d6.2.1724342356680; 
 Thu, 22 Aug 2024 08:59:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d4a29bsm8868916d6.40.2024.08.22.08.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 08:59:16 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:59:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 11/14] migration/multifd: Replace
 multifd_send_state->pages with client data
Message-ID: <ZsdgUn6oPJVFpKfU@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801123516.4498-12-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Aug 01, 2024 at 09:35:13AM -0300, Fabiano Rosas wrote:
> Multifd currently has a simple scheduling mechanism that distributes
> work to the various channels by keeping storage space within each
> channel and an extra space that is given to the client. Each time the
> client fills the space with data and calls into multifd, that space is
> given to the next idle channel and a free storage space is taken from
> the channel and given to client for the next iteration.
> 
> This means we always need (#multifd_channels + 1) memory slots to
> operate multifd.
> 
> This is fine, except that the presence of this one extra memory slot
> doesn't allow different types of payloads to be processed at the same
> time in different channels, i.e. the data type of
> multifd_send_state->pages needs to be the same as p->pages.
> 
> For each new data type different from MultiFDPage_t that is to be
> handled, this logic would need to be duplicated by adding new fields
> to multifd_send_state, to the channels and to multifd_send_pages().
> 
> Fix this situation by moving the extra slot into the client and using
> only the generic type MultiFDSendData in the multifd core.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


