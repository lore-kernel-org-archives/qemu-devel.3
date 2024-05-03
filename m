Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D4FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s30PU-0000iO-7U; Fri, 03 May 2024 17:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s30PR-0000er-N3
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s30PP-00074J-RN
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714771534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=whRxnkmyR8eq8lWQIAenIQIlhNlWkzaOqNNXJCL8Zco=;
 b=JkkNNd5g5/N11qUNmtok+TtkCzo2JMIhB7JiJidv3Djb7HyC+E52hZjrZk74LJ7eZVDgHj
 FtMlRnsDQA5u7W+DlVmQxSfzNet5oL4H6t23FrhqlTCUxsIcgULMCFvozQLdsXPKMvu9Jm
 0qY794+AuN7L+HskTn3uz+uro9yuQX4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-HO0UTuoSNpOc6ATQXwZrrA-1; Fri, 03 May 2024 17:25:33 -0400
X-MC-Unique: HO0UTuoSNpOc6ATQXwZrrA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1ec7cb6942cso236625ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 14:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714771532; x=1715376332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whRxnkmyR8eq8lWQIAenIQIlhNlWkzaOqNNXJCL8Zco=;
 b=b1qRD4PzpxczC/90AyIy69RkAGLO9EGOMqJ2lT0uoljjQ6dju+7myxcSs0KTM8ccSZ
 4jok8Eek1+3om/9cl7H3a0amFQ8gTfnbXQ6FYpKT/Ecc/vNPwWj9tZUHd+Khg8/6xP9e
 kc+U2S/fjA2O4XeatnTYz5+icdSkBSUsfkZwPMRjzsh5q1UVrPJJzue8LdFK9O8hxviG
 y5u+Lj07okjn/UDSlwYsi0NoZhXumkb+iT+bJVjwhzrjD/BDhc5urQFMdHW+dmo6g4Q7
 2iK5+Iz+Zz7dz63LJ87qq09L9I4cIIyKsx2UM3nTwGM06B4JAKpU97NfZJBhe/ETmvb5
 8qWA==
X-Gm-Message-State: AOJu0YwKjjdFIJtugne7U9SEu1fyalBy5l4Rur7AIB81OffI5Y5fExcB
 wB+wVXfrakWCjOYbU15Q0tK8Oac0HgXNc1zAgriIXG1h4wID8c/yL4LxqfR8XFp+lRdZil+0LuN
 /4eXHcSLhPGipGs9Q0YGfBG4efpwpoluDyAEftPA6cJ9DuqwJ6YGa
X-Received: by 2002:a17:902:f68e:b0:1e4:397b:492c with SMTP id
 l14-20020a170902f68e00b001e4397b492cmr4241075plg.4.1714771532124; 
 Fri, 03 May 2024 14:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGso2SQDotZJHMIb9Jc/qMDpQVE6QdzNZE2IqfTghY6mZRFMZx+1yal5z4MbB+4buQsoBsqKQ==
X-Received: by 2002:a17:902:f68e:b0:1e4:397b:492c with SMTP id
 l14-20020a170902f68e00b001e4397b492cmr4241027plg.4.1714771531464; 
 Fri, 03 May 2024 14:25:31 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c8-20020a170903234800b001e3e09690c6sm3724575plh.199.2024.05.03.14.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 14:25:31 -0700 (PDT)
Date: Fri, 3 May 2024 17:25:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/9] tests/qtest/migration: Add tests for file migration
 with direct-io
Message-ID: <ZjVWRzUdhAEwyWoV@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-7-farosas@suse.de> <ZjUvHjBOicENBbva@x1n>
 <87v83umws0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v83umws0.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 03, 2024 at 06:05:19PM -0300, Fabiano Rosas wrote:
> >> +#ifdef O_DIRECT
> >> +static void *migrate_mapped_ram_dio_start(QTestState *from,
> >> +                                                 QTestState *to)
> >> +{
> >> +    migrate_mapped_ram_start(from, to);
> >
> > This line seems redundant, migrate_multifd_mapped_ram_start() should cover that.
> >
> 
> This is an artifact of another patch that adds direct-io + mapped-ram
> without multifd. I'm bringing that back on v2. We were having a
> discussion[1] about it in the libvirt mailing list. Having direct-io
> even without multifd might still be useful for libvirt.
> 
> 1- https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/K4BDDJDMJ22XMJEFAUE323H5S5E47VQX/

Ah that's fine then.  Maybe add a comment somewhere for future readers?  Or
a sentence in the commit log would work too.

-- 
Peter Xu


