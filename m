Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656FBD6A22D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgx5-0008Ff-Or; Thu, 14 Nov 2024 16:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBgx3-0008Ej-Jc
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBgx1-0007uk-TB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731618025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0Hut3RTDnL/voQ2ISTVQZmwUdqtrb97TOVExpaB64A=;
 b=aCkQ37JpN1pjErFO3Sa5peqXhwW2RURgxTXGGyskLfviLA0T5SRExnIv4ARhMIKou1GF5z
 zX5g7weFELKK95OYh8DGUe33BCmXqbUZvsY+oLHtPZm5Z7jfedQpyV/Cl2AqHml0OcROvQ
 i6+apmx39ChRy5v2MQwn5qa6YRcWm64=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-ezzcLfWgPA2qeKHJaqBqpw-1; Thu, 14 Nov 2024 16:00:24 -0500
X-MC-Unique: ezzcLfWgPA2qeKHJaqBqpw-1
X-Mimecast-MFC-AGG-ID: ezzcLfWgPA2qeKHJaqBqpw
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83aa6bcd7b3so116649339f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618023; x=1732222823;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+0Hut3RTDnL/voQ2ISTVQZmwUdqtrb97TOVExpaB64A=;
 b=MFcTydMa09HNjTNlBC+OMa7mJ0ci6v8y5z/4F1stZRMna1nygpmI0twrph7M9CqcLY
 2+dKFQEw2/ixna8Th//U734CvaCcyQKz0uweY7ljc36McrPKPrusbT44wTKlK5LX468g
 +iW4Cdc4bX/+hGBMPVcIBPHxvEuCX6jODRtiwg2r8y6X/eJtlm2AxH5CInV6cM7f9Anr
 c8wY0HBVbKpf6suHrOMBAGlSODTBe0ar3x9iAVs+/ri2W6aX8D+4XPN7YQAsS8sqJlio
 EZVwLemY0Be47nArYOmq6iY8sPP/Q7V3PZR9vRiQLU+vmXMYsR8GwgsTcOaq1hVV4+eO
 uXPg==
X-Gm-Message-State: AOJu0YwLis48C2zEEiyz/aOQo9ilGB3Hf9VjN8ZDni38EG+c4BlyVqN+
 DEoXSW33S7u+1pAllbLM1e8NI3TtZGGx/dpNFGFSuBcS4tAL7aeZSrwOFxVNrP1FmNXlZ0l4XP9
 X0+0o6tJtaR98QQ8xzK6EiHQe6rVxfbv7LbWdoevBBuHD3ijjqZRG0dtoUIAj
X-Received: by 2002:a05:6602:13c1:b0:83a:a82b:f856 with SMTP id
 ca18e2360f4ac-83e6c0a935emr64269739f.3.1731618023176; 
 Thu, 14 Nov 2024 13:00:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVHr44QikO3Fu+C3sNhpyCDmG42HiHCn2f8PdXrYS5M64Z+su+CYHde7H/c5Mq9DKD0L6eHQ==
X-Received: by 2002:a05:6602:13c1:b0:83a:a82b:f856 with SMTP id
 ca18e2360f4ac-83e6c0a935emr64266739f.3.1731618022840; 
 Thu, 14 Nov 2024 13:00:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d6eadb2sm21405173.22.2024.11.14.13.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 13:00:22 -0800 (PST)
Date: Thu, 14 Nov 2024 16:00:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 7/8] convert code to qdev_new_dynamic() where
 appropriate
Message-ID: <ZzZk5KAzbu6NVl9Z@x1n>
References: <20241111155555.90091-1-berrange@redhat.com>
 <20241111155555.90091-8-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111155555.90091-8-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
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

On Mon, Nov 11, 2024 at 03:55:54PM +0000, Daniel P. Berrangé wrote:
> In cases where qdev_new() is not being passed a static, const
> string, the caller cannot be sure what type they are instantiating.
> There is a risk that instantiation could fail, if it is an abstract
> type.
> 
> Convert such cases over to use qdev_new_dynamic() such that they
> are forced to expect failure. In some cases failure can be easily
> propagated, but in others using &error_abort or &error_fatal will
> maintain existing behaviour.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


