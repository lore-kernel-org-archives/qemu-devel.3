Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4935DC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 20:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhOR-0006jH-BP; Mon, 27 May 2024 16:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBhOD-0006hX-Rl
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBhO9-0000N8-Qp
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716843373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gM1dQFFDiP1Rnc4EpMqt2I/zSPCn1BKZf7F8xZOYKdI=;
 b=ZC9faGSSiittmSBF9q7E9IkHHW0m/bXH168wMWk2Y1sY5c17kVx7PvHCWYOBHqHIv8rNn+
 qOnZXiv4FPyNBPLva+JDZkT8Q5s9UNf5unowyMFmxjFo+/ffYa8xzIMiMhSCq3MKgNdNzo
 ajSqnKpayJCeNYxQaDFsc3SYFZPUbQc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-ryWV8OkbONCLtoHaBGXK0w-1; Mon, 27 May 2024 16:56:11 -0400
X-MC-Unique: ryWV8OkbONCLtoHaBGXK0w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ab9d3f089dso298806d6.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 13:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716843371; x=1717448171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gM1dQFFDiP1Rnc4EpMqt2I/zSPCn1BKZf7F8xZOYKdI=;
 b=afaFnuiT+Jsv4AVPpC9ZOqErFrvBW2AGXrz8kZrRJJ1m4jwBnFwjoauCIGfDYUMdhu
 tjuKW8r+7Y+Xks1rq7oN25Uqwn3wn9AlTIc1tq2Ozl37DxPXHQDXbe4SrMxcqEPIFC0r
 MQBYPbn8swd3xA6rK3T2C8Ls7b4QTUR7DblyDDG7EsbR1YuzYlNQEtyD4mcA8pNbhnXi
 2BZ4Wr3/M4OBNQ2Wv8KDL6F71kfRQFEbc494a9Zvj5EVLSTo/jEvCtxQ+QdkSHCOSdmb
 g/FIYLZZDj4lriR6xUWYYi+Tt9UUGReMMbZOAzqjWwHdALjmNp0wqnTdxql6ZVIXe1N3
 6P6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUum4vtHlVdjsq8oirgxW0pDny2GKGrYGnAv2QZpLJhoOlvWAIkhax3aLoApIQ7DaUsFJiA2KyLufg2TViqk1oP33OiTU4=
X-Gm-Message-State: AOJu0Yw1QnfviyfcgOkGx1V5JAlIxM9Xs0OjB4TabpOqo2OWl5o1yM0e
 s11VCZH02y7wHN1O1w6/T09nuXLBM0aJYyikdP0FW92qCv6fmqVKqsyYZNVsAyrGWxjTceFdUdi
 xA2hXeaqVIFfvMchKUDWKGqVq2Lj9wazKE/SqCV5WbZ4yRyjLEJJ7
X-Received: by 2002:a05:6214:c2e:b0:6a3:3ea4:7156 with SMTP id
 6a1803df08f44-6abbbcc044fmr109117076d6.1.1716843370485; 
 Mon, 27 May 2024 13:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7pYz7pqkMzerLU0G4JBDpLWP21vWrtrU9CwulihmGh+DbIl66xXGBtBZFfc2aqBLTqK9cLQ==
X-Received: by 2002:a05:6214:c2e:b0:6a3:3ea4:7156 with SMTP id
 6a1803df08f44-6abbbcc044fmr109116896d6.1.1716843369823; 
 Mon, 27 May 2024 13:56:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18aecbdsm36775331cf.61.2024.05.27.13.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 13:56:09 -0700 (PDT)
Date: Mon, 27 May 2024 16:56:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, nanhai.zou@intel.com
Subject: Re: [PATCH v6 7/7] tests/migration-test: add qpl compression test
Message-ID: <ZlTzZ8epiucEr0W3@x1n>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-8-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240505165751.2392198-8-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Mon, May 06, 2024 at 12:57:51AM +0800, Yuan Liu wrote:
> add qpl to compression method test for multifd migration
> 
> the qpl compression supports software path and hardware
> path(IAA device), and the hardware path is used first by
> default. If the hardware path is unavailable, it will
> automatically fallback to the software path for testing.
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


