Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD737D6A22C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgG8-0001tn-PT; Thu, 14 Nov 2024 15:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBgG6-0001ta-Ry
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:16:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBgG1-0005Wo-Eq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731615357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmJnIzt/aQmAPhwkO5SkHX2ArfNmjBcqpi/47O4BkoM=;
 b=f5XMLOBc6kco73Tnz3yIhAs0abdvhXKn9F9tetjZiBCZ+Zp2xMNOkBCJSypBWR3MuBCTC4
 fFbCXf+MYssddu0Lk+e5zUUUK2wweGvBHZacgmJhzQVKzfuLQLIZh4/XPgHN4x8j8USrr8
 QNqey3sF8+6tNYNROIb8eR1w4Ss51qM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-qaW5veMQOrGLkjGmtjcjxg-1; Thu, 14 Nov 2024 15:15:54 -0500
X-MC-Unique: qaW5veMQOrGLkjGmtjcjxg-1
X-Mimecast-MFC-AGG-ID: qaW5veMQOrGLkjGmtjcjxg
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83aed4f24a9so107960539f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 12:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731615354; x=1732220154;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmJnIzt/aQmAPhwkO5SkHX2ArfNmjBcqpi/47O4BkoM=;
 b=uNmoLCNCbWh47m4MH7G+y+iyiz+3VS74u76TXOnz0jjUKu4g8wh80biljNjPPEMfF+
 xcU1w4hQvm8eDDd6PF5GNv519i0rFBpI+pqH8mMYUsvKMg7HfwjCGsaaAUzWUnIgUCmR
 P7pW+GFnRDWRgyfxAGTqxADvXrHHxY3kBtkDqDpQxqv8NVwbT9KbEtAx6ustvLDk7eJi
 yXZCavj1DasBVzWt3Hu2jbVabFXUULhZXGkxniU5QFY981Kkcaob/A6AhUS5bSOQQh2A
 O+hwbNimTygQignDVlPCu54DiiKXHeIwhwonnDcUY1ZwbsYyY8tTyZm9Why+PSCYQwxt
 cbhQ==
X-Gm-Message-State: AOJu0YyMCUL5KgAkXScCi/W31EIavDEuVvW5jM+K+sVQlrDH/Al7PiDa
 Gl8Zc9OwaspHsVvlM0QQufejv2Ykv1/OLL17dn6GL/OusKLwTRVPR1TYxi0w/Ht238BnJe1UhwK
 b+2NjwM51FxtjuuFPqJ3+y93xJev4YdlZAAV0j9X3rHJ6/7z4zj++
X-Received: by 2002:a05:6602:60c7:b0:83a:a9cc:69ff with SMTP id
 ca18e2360f4ac-83e6c18ca66mr41251639f.13.1731615353887; 
 Thu, 14 Nov 2024 12:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+vApARh9eC8WTJWH0bHu+0M08z/txJa68G01YBJZmDNDM8i4Ee0vO9FIbRa99dlUGKHFc4Q==
X-Received: by 2002:a05:6602:60c7:b0:83a:a9cc:69ff with SMTP id
 ca18e2360f4ac-83e6c18ca66mr41249039f.13.1731615353502; 
 Thu, 14 Nov 2024 12:15:53 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e605698eesm41824639f.17.2024.11.14.12.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 12:15:52 -0800 (PST)
Date: Thu, 14 Nov 2024 15:15:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 3/8] qom: introduce object_new_dynamic()
Message-ID: <ZzZadlJh1z8tWR2e@x1n>
References: <20241111155555.90091-1-berrange@redhat.com>
 <20241111155555.90091-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111155555.90091-4-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Nov 11, 2024 at 03:55:50PM +0000, Daniel P. Berrangé wrote:
> object_new() has a failure scenario where it will assert() if given
> an abstract type. Callers which are creating objects based on user
> input, or unknown/untrusted type names, must manually check the
> result of object_class_is_abstract() before calling object_new()
> to propagate an Error, instead of asserting.
> 
> Introduce a object_new_dynamic() method which is a counterpart to
> object_new() that directly returns an Error, instead of asserting.
> This new method is to be used where the typename is specified
> dynamically by code separate from the immediate caller.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


