Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F34AC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5uu-0003R1-Ol; Fri, 15 Mar 2024 07:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl5uq-0003Iy-2C
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl5uj-0003wh-Mh
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710502793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TNkfaj8NfkcT1zImyUHGT2fEPj7puXv/wicEjpEcGEc=;
 b=itl/f+Zy5vXVbp9Cq/p/XLSq9bpFePENd78A6iUC/Fhs3NYP8oi/PTBlzoPgqQuFqbrg2A
 dZ29LDfFW9k74r6+5oJw0VMWwO9HvCs9g+XLsCrKEKbPK6+Ea3D5jPaERrJRNfkDdmsJH8
 K+loLMCtgvU35qQaBLKamVRD1FmNFfI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-wkFxe7HcNm2-NkEIfd8LSA-1; Fri, 15 Mar 2024 07:39:51 -0400
X-MC-Unique: wkFxe7HcNm2-NkEIfd8LSA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6dde25ac92fso859309a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 04:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710502791; x=1711107591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNkfaj8NfkcT1zImyUHGT2fEPj7puXv/wicEjpEcGEc=;
 b=esOUrfKMBShaKy1mdTGP6+MQ+T0T7dPGIixjmSpqV+AK794UyChj2PL96qi8X9+tVs
 zqeYylVzaKr86huGVaiUBEHX7BlryZJdFQXqHLLuYZr2HEKuV6VALFxeDDL23s7qz8rC
 VWXrQohYcrvNrdAaULehBmiIqLWiA7ZIP6Fw4LTZCGyIBZprECz27v9iK/KZRQMbZ6wN
 bvKd32dM6VsoPxYRU/Iz/aOoCY5twjJzd0W7bKxvTpwO6l+l3p6XMmQ/eZEgGQBGfg4g
 EKQsIiqQSSNOI2e2IjedGOtMToiZjEojmvh/K9iFqh/4hF4iol//tqqkJCjBPFCS3XIY
 j3WA==
X-Gm-Message-State: AOJu0YwbPn1BvarQVp1ZcO8/JIWpdaiLj8Z7VXVUQvVO5TUNFIURUw0C
 XCkfyBFTbQhjmRo2l5P+RD/QmfUrskn10lawb3gtloagWsALBkyrOkqIf08FdNbr4vztlWw6ol7
 NoMVOtNTK2vXzikVmemBOBBox/nvuu0TxyT9NEeQV0AVDNKMyA+sJ
X-Received: by 2002:a05:6808:2016:b0:3c3:661b:f112 with SMTP id
 q22-20020a056808201600b003c3661bf112mr1936988oiw.5.1710502790869; 
 Fri, 15 Mar 2024 04:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbVBYhGlR1YftttHkQjSTcAu6JYoDlEekgVEo8qkalyszu2T3kAhXMAYB5Thx14g0rnH934Q==
X-Received: by 2002:a05:6808:2016:b0:3c3:661b:f112 with SMTP id
 q22-20020a056808201600b003c3661bf112mr1936972oiw.5.1710502790543; 
 Fri, 15 Mar 2024 04:39:50 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 a9-20020a0ce349000000b006916003c53asm1671974qvm.27.2024.03.15.04.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 04:39:50 -0700 (PDT)
Date: Fri, 15 Mar 2024 07:39:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 2/3] migration/multifd: Duplicate the fd for the
 outgoing_args
Message-ID: <ZfQzhElQJypJFm64@x1n>
References: <20240315032040.7974-1-farosas@suse.de>
 <20240315032040.7974-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315032040.7974-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Mar 15, 2024 at 12:20:39AM -0300, Fabiano Rosas wrote:
> We currently store the file descriptor used during the main outgoing
> channel creation to use it again when creating the multifd
> channels.
> 
> Since this fd is used for the first iochannel, there's risk that the
> QIOChannel gets freed and the fd closed while outgoing_args.fd still
> has it available. This could lead to an fd-reuse bug.
> 
> Duplicate the outgoing_args fd to avoid this issue.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


