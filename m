Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5199C54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfX1E-0003jt-Bk; Wed, 28 Feb 2024 22:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfX1C-0003jV-JE
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:23:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfX17-0006FH-Cq
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709177007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0zgqCfD84Ie2gnjMmKQaP/DL/mo3iAzOUtITzenI4A=;
 b=R/sDtCjXvtqBjQakhSwbEBjrMKkVV8Vzjqf3XGq2ipqKqm6OXXhQ9sBgl17eg7KHWS0Clr
 YkwxOhmj2ExBM3Wjzh94AfZwTf0qaLL5F7PC/0/4DiHPCBx6PvsrnFfDuQYDzaNlmbRGxJ
 LIXpdMbNkVIGWpX2TTdQrgBc1jsX1G4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-pU06RD8LMuWcuoMcOQKpvw-1; Wed, 28 Feb 2024 22:23:23 -0500
X-MC-Unique: pU06RD8LMuWcuoMcOQKpvw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6dbd919aba8so143638b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 19:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709177003; x=1709781803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0zgqCfD84Ie2gnjMmKQaP/DL/mo3iAzOUtITzenI4A=;
 b=IBngMaQByTNZ034KWlySDeKP0FJJsFSz188xsIrUQlGLxcQHqtXGrslyTbvgO8G717
 EH6n1Vphku4sFckDu6EvFS4X/6AgdzStMz63BdYR1wn9RJT5EE+r2xXLoiWeExo6h82x
 NDVxsZoEsrcn+MGzVzkp80zDQ6VeP/Pby3bJUcgBcU4ViRQhYLl6FH2brMZAu5YiM+sJ
 LAEEQsMET5UzvO7q0uQzsF04d8YBb3wibcediGbluIN1occqcY3LGxH6CIdjVV8VyTdR
 VMWcUyPj9zLwHCMfll7V6V5RTQ1QHxHFHqrEi1adBCx1RU0lBv+ICQHLuOv3WeNiRPxV
 T4nA==
X-Gm-Message-State: AOJu0YztY1U3polTQBtypGzQffqCv8igByo+8duWtMIUYZlNlUhkTSlB
 92LjhmGjHWznsQl5koO15eiOLLoHvQlTRq67i7yWHkgedVjsU6hEPUfD25ReDgfR1hlWRrmXUWE
 7OLy6HDql5C4k57N1YmdyVcakQVEFBC9QvHV0Kv4NvXbjX8mESnxM
X-Received: by 2002:a17:902:ed54:b0:1db:c3b8:4620 with SMTP id
 y20-20020a170902ed5400b001dbc3b84620mr848752plb.5.1709177002945; 
 Wed, 28 Feb 2024 19:23:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpUSPKRn+zlADqTkVZgFKsWzyEePZD1D+bJPEdKF8EHKZ1bGKey03WdHpIzopd6rHq6++l2A==
X-Received: by 2002:a17:902:ed54:b0:1db:c3b8:4620 with SMTP id
 y20-20020a170902ed5400b001dbc3b84620mr848746plb.5.1709177002642; 
 Wed, 28 Feb 2024 19:23:22 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 y15-20020a17090264cf00b001dcc18c7e3fsm209492pli.148.2024.02.28.19.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 19:23:22 -0800 (PST)
Date: Thu, 29 Feb 2024 11:23:13 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 21/23] migration/multifd: Support incoming mapped-ram
 stream format
Message-ID: <Zd_4oVh4X0bN-Gsy@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-22-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228152127.18769-22-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 12:21:25PM -0300, Fabiano Rosas wrote:
> For the incoming mapped-ram migration we need to read the ramblock
> headers, get the pages bitmap and send the host address of each
> non-zero page to the multifd channel thread for writing.
> 
> Usage on HMP is:
> 
> (qemu) migrate_set_capability multifd on
> (qemu) migrate_set_capability mapped-ram on
> (qemu) migrate_incoming file:migfile
> 
> (the ram.h include needs to move because we've been previously relying
> on it being included from migration.c. Now file.h will start including
> multifd.h before migration.o is processed)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


