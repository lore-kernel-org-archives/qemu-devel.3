Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4D6C54798
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 02:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reQS0-0006WU-2R; Sun, 25 Feb 2024 21:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQRy-0006W8-5j
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:10:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQRw-0002PZ-Pv
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708913434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JE7WBxlh/QwISZKmkfj0c9DTkg4wh+qjFnqEMuDcRUs=;
 b=QPAu+0mD2j/WzdvEkttMxz1hoOgcDrOu+184/dThuviijp9Ueil5Ni6K8skiqzXZY1dZJ6
 /6xngZHMNZ9iOB9ht9Z/O4keBx9wJgmD+7xthbh0z8d+26oAnbY7NfOtz6rE95aS2lZO46
 0GmSgtlzLtY5TX660pahRaq0tvB4GaE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ADiOpbDnNNyGOxBdvadLPg-1; Sun, 25 Feb 2024 21:10:33 -0500
X-MC-Unique: ADiOpbDnNNyGOxBdvadLPg-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5a07cec6189so171887eaf.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 18:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708913432; x=1709518232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JE7WBxlh/QwISZKmkfj0c9DTkg4wh+qjFnqEMuDcRUs=;
 b=CWkTQb/W0eIG4Z388a22jaIAWCn0RX5Jf4rWJrEDa6dVU9KmkzXtYsQsqxf5gE3H/g
 6ZOszzNjI64OtN8YsI4h0PLYTL9FyPgcUXGF6J7NaqJ4gthNSP8rl70II8yDRkhpuShe
 r42iFmifKG8OLMVCnTtmBLylTDgrhFSqzMxHWHsz5o4LELeWF94y0Z6s5+yTKSnmtodw
 ENy7SlPPEEd8C3nI9AdInXrv7VUbrbDkhuWKGTHvGKaiK+SxHQ/Dqusr5gK3yuu3mPXl
 cFORoYFR1N9y8dssf2rGmIlWJY8IjuQ8pRbg+z7L7QcclhmJYWOQ7e8TtPAXajcqo0eJ
 RgPw==
X-Gm-Message-State: AOJu0Yzw11CoSw/1Sp3bPlLoX/PUF6LgM/5eH4+jIABWncfg6FvRJIdE
 R0GN6uOQb36eWcPLZF1726IVV/JOjdzLMMITwwtnLN/Ajh2AR279lmCbQpxQqMoCM6x2FzlOlge
 Z3rnfv4xposjkD3eqJeFAaognAHi9SJH+vBftsZXWIO8n2CNZ6V8B
X-Received: by 2002:a05:6359:4588:b0:17b:7949:48d4 with SMTP id
 no8-20020a056359458800b0017b794948d4mr3817921rwb.0.1708913432419; 
 Sun, 25 Feb 2024 18:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIwLtvYG68KqHgT1jUQlewUUEIcMDqBisORx2Imsujo+2HBSelp7a1uMSFy3P4gjgn8wkhng==
X-Received: by 2002:a05:6359:4588:b0:17b:7949:48d4 with SMTP id
 no8-20020a056359458800b0017b794948d4mr3817899rwb.0.1708913432130; 
 Sun, 25 Feb 2024 18:10:32 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 du15-20020a056a002b4f00b006e4bcdcff43sm2900885pfb.78.2024.02.25.18.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 18:10:31 -0800 (PST)
Date: Mon, 26 Feb 2024 10:10:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V4 13/14] migration: update cpr-reboot description
Message-ID: <ZdvzEMmBy3lGgfK8@x1n>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-14-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1708622920-68779-14-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 22, 2024 at 09:28:39AM -0800, Steve Sistare wrote:
> Clarify qapi for cpr-reboot migration mode, and add vfio support.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


