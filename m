Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB92EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 16:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUqT1-0007xK-Jp; Fri, 19 Jul 2024 12:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUqSz-0007wV-Uf
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUqSx-0002ds-JE
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721406497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UuX42X/yKsA5znO4k3OK1xGFvZoJshl5haW9XBx7iQ=;
 b=DWe8zYlyhtgx+EZ0YRhjO37lURNaOD3aU/luCOrMj5/9mQJvCXfSqxPOmwfqc6TRcNitlN
 VSDSrHj+Ftd36m1X7t2I20lwDwULNt971NLaSl6U5ZPuoMUnOuv2TAO2gr9cMhiEpbwI1C
 5+sjK3lvZ+9I3Jx+s9un0bXtjzA7J3o=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-48LfaK06NwyVdOeoFctUDw-1; Fri, 19 Jul 2024 12:28:12 -0400
X-MC-Unique: 48LfaK06NwyVdOeoFctUDw-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-8064498eb84so29261839f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406492; x=1722011292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UuX42X/yKsA5znO4k3OK1xGFvZoJshl5haW9XBx7iQ=;
 b=Bq/fL9spgAGRpmnYi5iVVEvdcZmuCP3DDrwMJrC9RnY7jVw+80Pe8hYaFlcB+ykFOm
 ylGnxChN47Svkmf27tcIoZGUBWjpaD/EyIrYYx1ntngUV38vEESEC0XNnyQetmUsjupU
 KoQJm4B38nH4gTNUg+EzIZ6kivQ8OUy3uVOkWecib+1nlbsj5kf+BMd3kSzXP5MyxWmI
 1NRarOhebOF2ktbgFMabGwHwNpzGyLa4KBebgKG7YAG9ClJbwwo8tWtY1v+4lUbdiyAi
 RdZnZ+RO843657Q50WGTwM8jjCHbcF0ad2FAkhkm+4XnOXjEUmOLnnNM1uQgV9CvTaVF
 zFaQ==
X-Gm-Message-State: AOJu0YxTbKvcU+q5EJvjtNNVXqgusUSHUo3Uz6nEJlf86DmchFIO+v/k
 xqMbVdKxzpeyjytLjIMujIfrlwWkOEV9yyuXCbJFBCXevJ0Z4pXMbpbi5JFHnfAnf2zhpme1HZ/
 /KfR3L85IYiaJnVJ3pevEL/rLbr8kPd15xKIf9Qt0hJ2XTCGr9Wu7
X-Received: by 2002:a05:6602:304a:b0:7f9:3fd9:cbb with SMTP id
 ca18e2360f4ac-81aa4bd5cd5mr29559839f.1.1721406491984; 
 Fri, 19 Jul 2024 09:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkwogKD9mmrsCtsJNwFtA5+x+w7doEbErwVU8cygMPAigT1iyGptwxtC74tQeumw3gTVeGPQ==
X-Received: by 2002:a05:6602:304a:b0:7f9:3fd9:cbb with SMTP id
 ca18e2360f4ac-81aa4bd5cd5mr29558539f.1.1721406491616; 
 Fri, 19 Jul 2024 09:28:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c234407d49sm379734173.179.2024.07.19.09.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 09:28:11 -0700 (PDT)
Date: Fri, 19 Jul 2024 12:28:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 06/11] migration: fix mismatched GPAs during cpr
Message-ID: <ZpqUGYclrONQEuc7@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-7-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1719776434-435013-7-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jun 30, 2024 at 12:40:29PM -0700, Steve Sistare wrote:
> For new cpr modes, ramblock_is_ignored will always be true, because the
> memory is preserved in place rather than copied.  However, for an ignored
> block, parse_ramblock currently requires that the received address of the
> block must match the address of the statically initialized region on the
> target.  This fails for a PCI rom block, because the memory region address
> is set when the guest writes to a BAR on the source, which does not occur
> on the target, causing a "Mismatched GPAs" error during cpr migration.

Is this a common fix with/without cpr mode?

It looks to me mr->addr (for these ROMs) should only be set in PCI config
region updates as you mentioned.  But then I didn't figure out when they're
updated on dest in live migration: the ramblock info was sent at the
beginning of migration, so it doesn't even have PCI config space migrated;
I thought the real mr->addr should be in there.

I also failed to understand yet on why the mr->addr check needs to be done
by ignore-shared only.  Some explanation would be greatly helpful around
this area..

Thanks,

-- 
Peter Xu


