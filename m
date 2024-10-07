Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD65CFB455
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtGn-00085G-7p; Mon, 07 Oct 2024 15:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxtFV-0006Ft-G9
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxtFU-0004Ji-0n
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728328706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FC0do8QLQZQojwm5xRr5vLz+YlYwWK2qOE1wPRkAkSA=;
 b=jMm2PqIoKsoGBgC8dGs5YPSQCd5fojdmcxw6FEM2PkmpQvgtQqfSAcuzqUl99A+Zjvbl7r
 8pgHa5RBBlRPGWUruVSVSCblmz1qnxEh3OiRgz8LwYfZyyw6mMoMyZMRsc+z2Dximj2jF6
 8Pw9AT8Pv9nfyw7ESdxXvufCIl1HYIw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-U17hylVxPBShPbwdLzoyeg-1; Mon, 07 Oct 2024 15:18:24 -0400
X-MC-Unique: U17hylVxPBShPbwdLzoyeg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cb3a855022so89364156d6.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 12:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728328704; x=1728933504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FC0do8QLQZQojwm5xRr5vLz+YlYwWK2qOE1wPRkAkSA=;
 b=SteOBpuBhRkM38KDO0K/hCWEIJYxLuO0w6jYMNrqNHw8bMjNJsmE8bQHMa6EJiBALd
 /7Dg1kDF8FS/kwMOLQ7BN7M3nv3eJHO7OoeMMrKjleMC9/Ipyy6q2u4YvEXa7h3N5/rH
 3WYPjRnoGlmY4E3PE//iwcvwyXFkcx34zJKQHLoQv1gk2UpUXhhF8TwGwH0BPHSaWPir
 Pw0LkutNZvYWgKwLoH2R69YHXl2hoU3/UqARcsep1G9vf09bjWLg65aR0D+DqLQOFeAS
 Z2vbNMW5xeI3Tg1uNze9dd5s6j7y4/EnOdhjtvwujwDbeXMeJvdU5tJj2xebSoKYZ48r
 N8Pw==
X-Gm-Message-State: AOJu0YzGuP06SQLVp9pXARRaiV3RbX0bfRPVdX3c5ozeKfQT18j1CnhB
 m0cTjG0r1cB+J457L5rSFaS0wRCu71DW5e0uhb9X9FP9iMohJwrebGUVZNDFjOofopCv662DDhp
 /gqaSReLQ9ohVa9R/jT+qGpQbSRkMK8pQBg5GX7laZpi+6oPmjXun
X-Received: by 2002:a05:6214:4906:b0:6cb:8267:4a0e with SMTP id
 6a1803df08f44-6cb9a0328abmr215031336d6.0.1728328703771; 
 Mon, 07 Oct 2024 12:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE8JDz1gXTVDyv0R9+srHcOHH2I2SWti/CtyYLzbDhmIPlDbw9rkHXuqJ+8uqf82fyzzM8Hg==
X-Received: by 2002:a05:6214:4906:b0:6cb:8267:4a0e with SMTP id
 6a1803df08f44-6cb9a0328abmr215030886d6.0.1728328703384; 
 Mon, 07 Oct 2024 12:18:23 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46cad49sm28413456d6.4.2024.10.07.12.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 12:18:22 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:18:20 -0400
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
Subject: Re: [PATCH V2 12/13] migration: split qmp_migrate
Message-ID: <ZwQz_JpY7ZBJIptN@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-13-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-13-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 30, 2024 at 12:40:43PM -0700, Steve Sistare wrote:
> Split qmp_migrate into start and finish functions.  Finish will be
> called asynchronously in a subsequent patch, but for now, call it
> immediately.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


