Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607B2D6A22C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgOD-00047C-ED; Thu, 14 Nov 2024 15:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBgOB-000471-Jx
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:24:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBgOA-0006bn-49
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731615864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/c7pNC04nUGbe5vOvzXN9z08xYsSLc2NBZNZJAPvQ4=;
 b=WUTf8p8qInTm4mZ80A2pfaioQczZraCl8Zl9vemWDjCBM/MyGMmZImSDRvnuRAkhmLN9uc
 3es8h3DDl680zZhYp5Lfl5QyrB4Od28JJLhtRUzZQdiRzrSkAQLg33wUAHfR77in8odc4c
 WLJwrmO3eDAGOLntyYcWtJAqLL7mYYU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-CzaANbUANLK0h-qmMYWINw-1; Thu, 14 Nov 2024 15:24:22 -0500
X-MC-Unique: CzaANbUANLK0h-qmMYWINw-1
X-Mimecast-MFC-AGG-ID: CzaANbUANLK0h-qmMYWINw
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83dff8bc954so106639739f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 12:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731615862; x=1732220662;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s/c7pNC04nUGbe5vOvzXN9z08xYsSLc2NBZNZJAPvQ4=;
 b=dSClRH0WKbrA0a4SeS8L2V8Zgl9P/r7CfemPEXfaciEJWQOX61FoQEMNh79VX2Le3d
 ERGP7bg27vN/dVasww/Jy1odszz+/6G/ZAfLnpP+dwQXAIek3FQQ9nlup3FOla2UPw1r
 iRutyZZFon8FxWTJQc7i/OEni1JLr+w+EoNnxoUKtnwONYoMK6hUSzNGtMF0wbqWmBTX
 WqGjbSOutX/bMJ3sNU6krsAuvoR+1pD8ZTebpr/+i1UJCtSIeP3vkmQ/QI/r2uv06K16
 IqbK6B1WHeAdsSm3kfPHypsRuUxmE6vTYoR1Z/4UPLQ6bjsXlMVKfJKbyj2v6mSp9Dpd
 g+hA==
X-Gm-Message-State: AOJu0YwL1/H97Sm+aHyL6zVkodt3MjEAYEisw//lsL5RXp2jLZcuVyPG
 jsf8iwtXzdHggE6P9mfIEZgtuSl2xDOBGMoJwPHK9+tA6sQwu2S0HVx79Hl+A9m3yIKpWjVO5v4
 uVS5JD8/+KMkjxzOYM0JZw2mgoFOCSQrF5DjDhvKMseIlInUEk1VI
X-Received: by 2002:a05:6602:13d4:b0:82c:f85a:4dcb with SMTP id
 ca18e2360f4ac-83e6c276dc3mr43641639f.6.1731615862067; 
 Thu, 14 Nov 2024 12:24:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnktmxGikP7xO9lZovG1W7FFGhEtX5zW2sxZi8O1TFjjeCOp0OIvdMPKDWGrKe+o/7Lw7l8Q==
X-Received: by 2002:a05:6602:13d4:b0:82c:f85a:4dcb with SMTP id
 ca18e2360f4ac-83e6c276dc3mr43639439f.6.1731615861740; 
 Thu, 14 Nov 2024 12:24:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d709929sm7452173.57.2024.11.14.12.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 12:24:21 -0800 (PST)
Date: Thu, 14 Nov 2024 15:24:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 4/8] convert code to object_new_dynamic() where
 appropriate
Message-ID: <ZzZcc-dYL5ekRQ1F@x1n>
References: <20241111155555.90091-1-berrange@redhat.com>
 <20241111155555.90091-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111155555.90091-5-berrange@redhat.com>
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

On Mon, Nov 11, 2024 at 03:55:51PM +0000, Daniel P. Berrangé wrote:
> In cases where object_new() is not being passed a static, const
> string, the caller cannot be sure what type they are instantiating.
> There is a risk that instantiation could fail, if it is an abstract
> type.
> 
> Convert such cases over to use object_new_dynamic() such that they
> are forced to expect failure. In some cases failure can be easily
> propagated, but in others using &error_abort or &error_fatal will
> maintain existnig behaviour.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


