Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0754CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 14:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruZK6-0004nX-Su; Wed, 10 Apr 2024 10:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruZK5-0004nK-Jr
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 10:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruZK4-0006gG-36
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 10:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712760790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/h/TNmo0F+OAndnIIoxs/HTz/VoDakMvSCofeZ0TgE=;
 b=Dvq5Ex8EvYVSzHrqORff4ukPHcsa0y7oqzEtnmaPf36OI/8KkFHshT4Gtdd7AlAv8F90R+
 5w3beQs9j074J0JOu2bpUtgPwgzM7f+xpymJOwU1Mi1lI3D0WO0bAwB8pa+tlICJCHD+MB
 7jbl/CmTe0kxalqPHeVfjtLVsfMnj0Y=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-B3s_zFk8Pb6b-iUAubZGEg-1; Wed, 10 Apr 2024 10:53:06 -0400
X-MC-Unique: B3s_zFk8Pb6b-iUAubZGEg-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6dea8b7e74aso2430092a34.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 07:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712760786; x=1713365586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/h/TNmo0F+OAndnIIoxs/HTz/VoDakMvSCofeZ0TgE=;
 b=ajueS6xMI12Jfc7YF2jBZqQFJchoHlgyauZSj9WUNFvqAQ+MsQ/GByoeMYJcYXRHwG
 L5ESfzJHzEDfhX3++3mdIhzdqtHzYaaRupn4ZYCEJ8eIuHFz5oZPdgPT5iS2IGlG7rSI
 wB2mnshBijLgtaaSPdMH7/bQkOKn2eqYv8osikDSQM9mYdX1O5OjlyRbrJoU2zGWLUc8
 VHq7E2N3LTKtE8KEIYjnF9rUZv2Wql4UKipbf2NGFEu4vjFFDrnI+wZ/A2+dV6KT+Bnx
 Dx55c3Jt3zPVphNI5KCKN2pF06XQAFfCIeMz4VhjEWC9g9HRpJEiQ3XAFhQn0374XdPS
 TN1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg1UPI1gQT/jLb+9c2/yuz6jVGXb35oqtD4um+c+6fCkgXsBB7+9eD9vJgidk2rN0xekfWF/1r6Az2OwMNaCF1YjIiOCo=
X-Gm-Message-State: AOJu0YwquptJm/6aukLz4AjLFmUC8lpqfzSiLIuI1XfrzHzDWTVpbCrX
 aP6pFP7xGajGI1a0zVppTsx1RS36XEVfd8o1PRNByx2r+Qbj08YNHe+6O72/hjlZhEZiDc9xtaQ
 x2pQZjX5XmVQcF5gQCLxv6cNdW3c+IOcBEeEg8khlqLNKDgjlkfCA
X-Received: by 2002:a9d:7dc2:0:b0:6ea:10b8:954c with SMTP id
 k2-20020a9d7dc2000000b006ea10b8954cmr3225158otn.0.1712760786048; 
 Wed, 10 Apr 2024 07:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfOZUr0kfLVutAeDhA/BWlkevu03yE6GQXaxd0QVNX1Jat+l4/Hf+ImCkQFUsFRVHX3km6QA==
X-Received: by 2002:a9d:7dc2:0:b0:6ea:10b8:954c with SMTP id
 k2-20020a9d7dc2000000b006ea10b8954cmr3225135otn.0.1712760785639; 
 Wed, 10 Apr 2024 07:53:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 cx19-20020a05620a51d300b0078d582a4b6esm4214245qkb.12.2024.04.10.07.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 07:53:05 -0700 (PDT)
Date: Wed, 10 Apr 2024 10:53:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 prerna.saxena@nutanix.com
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none() to
 use new QAPI syntax"
Message-ID: <Zhan0Brg_CXzt79-@x1n>
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-2-het.gala@nutanix.com>
 <874jc9v066.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jc9v066.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 10, 2024 at 10:04:33AM -0300, Fabiano Rosas wrote:
> Het Gala <het.gala@nutanix.com> writes:
> 
> > This reverts commit 8e3766eefbb4036cbc280c1f1a0d28537929f7fb
> >
> > After addition of 'channels' as the starting argument of new QAPI
> > syntax inside postcopy test, even if the user entered the old QAPI
> > syntax, test used the new syntax.
> > It was a temporary patch added to have some presence of the new syntax
> > since the migration qtest framework lacked any logic for introducing
> > 'channels' argument.
> 
> That wasn't clear to me when we merged that. Was that really the case?

Yeah these look all a bit confusing..

I'm wondering whether do we need the new interface to cover both precopy
and postcopy, or one would suffice?

Both should share the same interface.  I think it means if we covered the
channels interface in precopy, then perhaps we don't need to test anywhere
else, as we got the code paths all covered.

We actually do the same already for all kinds of channels for postcopy,
where we stick with either tcp/unix but don't cover the rest.

-- 
Peter Xu


