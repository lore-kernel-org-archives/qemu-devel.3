Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3C3CF6D2D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw0Qt-0006VR-N1; Wed, 02 Oct 2024 10:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sw0Qr-0006VB-Oq
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sw0Qq-0008HF-Al
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727879662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjz/kErgthNHrgId+j8I66MsIKAMvhgVNjnFBaOKGqo=;
 b=ZE2TJno88sA8FzE9Wdtf1RBhIeHDRfF0Lk/Mrxprt9MISHa2DHvam6NBq061FDhIldaoj8
 xBNfXLs3L4AbcCGRtE9K+SHu2wSKEvGG3lFdkr6YrHma0uxgsvSJi8kMDXll0tjn7yoenm
 kgsnZjo2gaaVNmxayzx+Kefj5DOXic0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-xbbky2YRO8675hC9q55lKQ-1; Wed, 02 Oct 2024 10:34:20 -0400
X-MC-Unique: xbbky2YRO8675hC9q55lKQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a9a653c6cdso155125785a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 07:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727879660; x=1728484460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjz/kErgthNHrgId+j8I66MsIKAMvhgVNjnFBaOKGqo=;
 b=nLawJOdMeQzjpXTy7afm2I8MqFOXNhu6kOmlQv82xLTCT9tQStk8GTZ+eTr1LHC1fS
 DNsqTx/cunUoxY7UNTGEm/6ctp//scVzEIk2hD62E1zb/R8hh7QZSSsz/sZbApj4h/Qv
 tOzpst9yfKg6YNWcRKNEhz16GHdkCCJaA6ZvnoOk9k5DuwvNVfR5PKkjoTVoMGGUSXs8
 3dIJ6RRFzfPYEfFUDsRfS2XMF4H+8PcspcWGT3PE8TOgKZtV654/SmESyFE80OqeJymz
 jr8f84NqoDQ7nvN4h2RxsAKr7xUeh82EvpvNlU9KOH0jBbM8uMjr2XD4qTv7lNRgDCkQ
 +z9w==
X-Gm-Message-State: AOJu0YwKCkPviung9Evak1xHDsyqnKjMh5CjgCcJTyGtZfEiJS7pxuzp
 374ZbM8z4QSVgrYxL6u7kH/oETwSjJLQt9s1lG4qgCdXeBR7tEwSH5Hs65AWzJbojFudn/EiJSD
 5hs0QpGgwmh6n8b6t0v4QF1HKslaBkS57n+X/Swkv9COBKCatwFl95V/8vqDK
X-Received: by 2002:a05:620a:408d:b0:7ac:bc66:5efb with SMTP id
 af79cd13be357-7ae5b85d76emr1116377285a.27.1727879659714; 
 Wed, 02 Oct 2024 07:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHszOjV5NTXsPtGADssIFMys0Q2PF420hTYkdeR5uwWzwl8TXBnWgBK/JGr1Za4rrjN8fbkjw==
X-Received: by 2002:a05:620a:408d:b0:7ac:bc66:5efb with SMTP id
 af79cd13be357-7ae5b85d76emr1116373385a.27.1727879659264; 
 Wed, 02 Oct 2024 07:34:19 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae3782b956sm626789485a.84.2024.10.02.07.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:34:18 -0700 (PDT)
Date: Wed, 2 Oct 2024 10:34:15 -0400
From: Peter Xu <peterx@redhat.com>
To: dave@treblig.org
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] util/iova-tree: Remove deadcode
Message-ID: <Zv1Z59b4urtFTPg8@x1n>
References: <20240918142515.153074-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240918142515.153074-1-dave@treblig.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Sep 18, 2024 at 03:25:15PM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> iova_tree_find_address, and iova_tree_foreach have never been
> used since the code was originally added by:
>   eecf5eedbd ("util: implement simple iova tree")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

queued.

-- 
Peter Xu


