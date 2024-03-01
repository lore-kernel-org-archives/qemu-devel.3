Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6531C48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 01:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfrw5-0008E1-55; Thu, 29 Feb 2024 20:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfrw4-0008Dm-28
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:43:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfrw2-000502-2n
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709257417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fMvQcXfeSpZN+WU0P10PoJ1mOIt3MipilwZYJMeaV4Y=;
 b=Cl5Vln5VpqTjUucu1R3UWyi1pyHa13QMHbg9ozPLhs7FHftcj+sXyCglsHZIz1SrJI3p4Z
 /DyeEaCqyImdPrB+0FtXaR9DIOY8G1kn86XLEsqy82eUXUpS7G7zdG7ljAoj2yqGuwt0aa
 I37pP9L/jI3SK9KmQiJHcZE/I61ejhI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-3Zax6bJDNvKSjEGMRXC-qg-1; Thu, 29 Feb 2024 20:43:35 -0500
X-MC-Unique: 3Zax6bJDNvKSjEGMRXC-qg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dc2d4c7310so2964705ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 17:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709257414; x=1709862214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMvQcXfeSpZN+WU0P10PoJ1mOIt3MipilwZYJMeaV4Y=;
 b=JFrKbZr3GrZR00D1/+tvAzlO5TYRYSFgkYP4/HNnxtkyY19Xozi3Ng2c3Xfhrv/Z1k
 JT9UmTvVlNrovxsjp3CEwH1WRWb9o4q+hRt3v1arsNESCKspfGJ2Xx3khvvu2qCPRYZg
 vgRi2USIuWT5SzyCZWUCge/oQMAMh7/aJ6vwX9gEBNBXnVX9j7/dnWQR7+2Ob3ZxvkyF
 CqtqYHMCYDRS+CRVEoekUJwovN6xCLXxOR+rmZzBHI0inPza/AMZ3Pci4JoCn/+/jEC8
 v9WQ1Ymg7SDdJqBii0cqoMrx5SKidCG+oKShjjH+xZygdewf4cfmCxeYwJ0ndX9x9c9V
 KSNw==
X-Gm-Message-State: AOJu0Yyq9ThezUEFwNfOOVADNceEoA9K09lHFZSDcKsBtVJnwRQ8aFXF
 bcCkUPt8bYbW0+HoQ8Y4SIWxiY8jSThdnBBw9rMM9D0GYgdNU2s4bqIcEV5cg6xhHPeiDxWzh0u
 fZQh073cg90rOvtLydhjyKHGIYaAxjjyDTvnajS7I9md+U5VjnxsX
X-Received: by 2002:a17:902:d5cb:b0:1dc:51ac:88ef with SMTP id
 g11-20020a170902d5cb00b001dc51ac88efmr261132plh.6.1709257414578; 
 Thu, 29 Feb 2024 17:43:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF3NUtPUfQ1QelBnDP0Ful3g668m27Z4zeebZ3sdFAryxpYSjao/m+GY9NgC+VDg2bFKfSAQ==
X-Received: by 2002:a17:902:d5cb:b0:1dc:51ac:88ef with SMTP id
 g11-20020a170902d5cb00b001dc51ac88efmr261122plh.6.1709257414169; 
 Thu, 29 Feb 2024 17:43:34 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 le8-20020a170902fb0800b001dc8db3150asm2177108plb.199.2024.02.29.17.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 17:43:33 -0800 (PST)
Date: Fri, 1 Mar 2024 09:43:27 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 17/23] migration/multifd: Add outgoing QIOChannelFile
 support
Message-ID: <ZeEyvzBHvsmF56Ur@x1n>
References: <20240229153017.2221-1-farosas@suse.de>
 <20240229153017.2221-18-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229153017.2221-18-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

On Thu, Feb 29, 2024 at 12:30:11PM -0300, Fabiano Rosas wrote:
> Allow multifd to open file-backed channels. This will be used when
> enabling the mapped-ram migration stream format which expects a
> seekable transport.
> 
> The QIOChannel read and write methods will use the preadv/pwritev
> versions which don't update the file offset at each call so we can
> reuse the fd without re-opening for every channel.
> 
> Contrary to the socket migration, the file migration doesn't need an
> asynchronous channel creation process, so expose
> multifd_channel_connect() and call it directly.
> 
> Note that this is just setup code and multifd cannot yet make use of
> the file channels.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


