Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC49CEDA694
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSTD-0004Co-GK; Tue, 03 Mar 2026 11:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSTB-0004At-C9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:19:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxST7-0007Sk-Sr
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772554761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6CFk+nJvxWBytK3lcVLQPYUwU7CbYu3mmTtPUc09vTw=;
 b=J/W4KVYeN79gRbjkgIhTptCBiILMBUL1CldWZX9DhyUn9tQasRU3uI+9saVQOwBNZr++yx
 TNVASDJ2AsxpWnSDHYSkQkQmx6CiUuFKIicikDhrqGEvbSZCU3cVAjDiKZ1HV3lMj3kkgc
 VW78/q0wxLqJPvtWo6CGhXmkZ3tlw0c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-eMNr1McTNlGN_PrgHVIZ7Q-1; Tue, 03 Mar 2026 11:19:20 -0500
X-MC-Unique: eMNr1McTNlGN_PrgHVIZ7Q-1
X-Mimecast-MFC-AGG-ID: eMNr1McTNlGN_PrgHVIZ7Q_1772554760
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb390a0c4eso3789761285a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772554760; x=1773159560; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6CFk+nJvxWBytK3lcVLQPYUwU7CbYu3mmTtPUc09vTw=;
 b=cIH+t4Dzc9S3tkkeAXEhBDr6jrmQMTA78wBxSw9aAmWrV/NSUmsf81DtacksmOvnsS
 bbg1eovQ7KugjFrnOng6vTCbTUT/1/AVmn989bhkT1R0a9jSN2JZQ+tXuzRoEA44Xpcg
 rR3Z7BHCeF1vEin7iq9hEEzYQLq59EKkKQ4p1nSQHyxjq65/LkWu+PxZxxhvJA9dq6at
 5PR4R8WXXkOv5k2YPItfGE5y1+23MVTaBYOa+7nJOuqklryA8TMR+82VHDkWGADyaG3x
 341lWzNeN79O2AYKUCPWWeEdr7NxaeaP/gzxSkFU/npvZ5FgVbtyV+Re5TwKW5AhDLmh
 uUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772554760; x=1773159560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6CFk+nJvxWBytK3lcVLQPYUwU7CbYu3mmTtPUc09vTw=;
 b=ui5YqmlDEZiV9Xnu8SXxQ4SSPsKCOVgh8shXe6K/UvAGJXhrTK36Jq4IEpX5sHeiEl
 Vna7JTBGdwXPJ1bI2Ef0MWm0pHH7dmGD863c/wxoUioT8iCq/6TiIDWXDBJcDW9Fbd1U
 +KTROzNShMpNdfC2i1aTsb3OkShcBrnmlSC5mFyNzqkbfrfqotqex32ApqcQ0np0iN1N
 Vc6mQxFnpRXSYgF7uxfi3oSJArU/4nSvZmbGlncxBu1txPAtY+kCXZERbF4s4KK7oKTT
 sl4v6rWgdOIjp4O6hITWnWa2JTLgLuCKh4c+fv6uP9DvO3ICJd/Bskyn6hIyYD1PHkNk
 qJkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSZ/19Sqk+z+2SP/77Z+9cOKFsrGwjET0is9RQKDfGKj0TmugUX01YWr81sKngVbNUiFpB13Tyhll4@nongnu.org
X-Gm-Message-State: AOJu0YxMCoGkDm+taFSLaKYrRjgLXwvV37dKRq9iekj6s231VeZMGtjI
 m9pHPjax32lD+L9w7MoeXkQhunB3bPcCjMVLNENnfjbcAr7J50UUzlDymlTCRUYR4/oXSDhRsPk
 DRtDb0KvtzzeEF8Lme0g6ps3sGSGodu8athaPzqxbjQ4f7r/fkXW4Xq0J
X-Gm-Gg: ATEYQzx7m5a+skDXrBZbEwC5uokPF3twkTjXH6T20w/nLO+qNmEGUfHztBAaZ6mw9YD
 iZChtq7dVTAa0nS2B6Yln/unfGlVWZ9dOtL3YkFAXoHVD1MWoZ4qgblE9hPjl6vNrhZrXkymIG/
 VNxLFlEE6buy/exkJu4lMk/ntSLIJXmMo3Wau8S9nBPZ9yO+NjiNi0VgTYfGJ2OBjVrwnIpCaLf
 iqFrJDhHqucq70jUXnOjUXNlw5r4KTt4BmiLjMO1X8AtoUoKucfwZnTPuAoezYK+4dWw8kQnR2U
 h6AEFIQy745V55GzJ64bg9N5e3vSHPZXIMS78Ef8lN60Jmeq0UuPB9NU3aUUFgBIY05IqGWbxIg
 GxRkjTONGSWKhGw==
X-Received: by 2002:a05:620a:29c1:b0:8cb:55cc:6245 with SMTP id
 af79cd13be357-8cbc8d6f198mr2141806885a.12.1772554759648; 
 Tue, 03 Mar 2026 08:19:19 -0800 (PST)
X-Received: by 2002:a05:620a:29c1:b0:8cb:55cc:6245 with SMTP id
 af79cd13be357-8cbc8d6f198mr2141801185a.12.1772554759041; 
 Tue, 03 Mar 2026 08:19:19 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6535b4sm1419131685a.9.2026.03.03.08.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 08:19:18 -0800 (PST)
Date: Tue, 3 Mar 2026 11:19:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 12/16] migration: VMStateInfo: introduce new handlers
 with errp
Message-ID: <aacJ-3JDA16aYVKF@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-13-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-13-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Feb 21, 2026 at 12:02:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add new APIs with errp, to allow handlers report good
> error messages. We'll convert existing handlers soon.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


