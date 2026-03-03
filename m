Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1316EDEBEB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVjR-0002Km-Uo; Tue, 03 Mar 2026 14:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxVjQ-0002KK-Dq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:48:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxVjO-000217-UN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772567314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mah6Rptv9qO9EnrZrVhLS3/tVZQsJm7csPd9ev3L8Ic=;
 b=UnDaXNFqUU/b+sPguqutEknTd5g2yhz+Ao52l9IgqYnWNipHFsZqqSZWk/WKwpIllJ0X/+
 oPk9pUdfXNp3nA/hbs4YWkmbELeTpjIj5UVtiOlBHPf0jM26HZFSGUPF07Y4Xw/J9HDJ/m
 P/5WNtvSnVm7kv9n/ckCx8ID+L5Tyjc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-Fuinq2hFOSe6zJPqD32RDA-1; Tue, 03 Mar 2026 14:48:32 -0500
X-MC-Unique: Fuinq2hFOSe6zJPqD32RDA-1
X-Mimecast-MFC-AGG-ID: Fuinq2hFOSe6zJPqD32RDA_1772567312
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c71304beb4so530442885a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772567312; x=1773172112; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mah6Rptv9qO9EnrZrVhLS3/tVZQsJm7csPd9ev3L8Ic=;
 b=dMdDxch4PqngVCs9utuesl7pf0iB+pcXnr+Ckf+yA1/sgvoXJrH6yVCP99b+d90cvz
 Wz2UQcHA3kyxIYlRGu+1f+L9KHXphXdlXt2QpIYptARzm4XGSB2ryAbE/2p7Vsa56sVQ
 4QNr7YbjoCtXo7U5slg8y9PVQj7h9s4CDAx4jUA5CuUbNXnqSaD+FhlS3KfiSTlxHR2i
 pAMzfN2PDdJ0z3hJktae96OtXTZdK0IDrQlaq/UeyM3bJCaZmRdDzuhRFkZvH4ou1vIP
 5d8kn0K9YxTK/6svdUm9E9DkMvuEYmeA1zetKL0Xa7PnrPht+ccZTooDUHSDc2oJuVLd
 leHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567312; x=1773172112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mah6Rptv9qO9EnrZrVhLS3/tVZQsJm7csPd9ev3L8Ic=;
 b=WlaANp2zfkSE4CCrvTn8GJjwL1P2z4U2YIz1imAMmmsf6o0h7h6SBWFsxO9aEEigPP
 nt3s4cdtpAiQr2kXXhCAeNyCXOb72vIUJaofZvrgcPYyANbYL/bxXSysgYagUasECLOU
 ZlYCmc1QKNSkZkJrlaN5kUu2rijp1xCmEQ+kjdIC7/V6GtXOuBoYo1fkufU9/Gs3ifyY
 jSz7u8k35yo15Bj5QQ4NO1kktZnZvg9eA5EhTjAZPoxtpWIl42MzNCpJocb9aef4qZH0
 86+oUnXcj3TJ2fB9Scps3EfopHFKI73iUwQRsIkQsYUGHa8GLTNnH5hS3M8R4s+t/7ag
 JKvA==
X-Gm-Message-State: AOJu0Yzy4k4PSz+lPJbrzRHOYhyL9ufXEkiuVjiJ/CVpD+hC4SesbrAh
 Zog37pNLQuLCyeVmxFd9NLKRBT8GULvCUSgHJX9smBzxmpQL0UApzNpUB5odk3WieaFtWHJuCzV
 /9WK5tiCk3iK74+AzTMI148/DWUbiz77s8ZVyvqD9Oetro3VvhTQl05nC
X-Gm-Gg: ATEYQzzQ2LzF91IpSVnOQXF4+HiprnVy+q6v2AFZ/+PioffBG6RzRpV4ChbgMhumnfu
 /g0U/Vbs6iTlia64/o7qMWWHG43s/uZCcSI6O9Xoir4wecwVE/De/16shyFy3p05ZqZbNUQaEs7
 BdTgeMZ/hkZpI/OJePNWueXp5ZYQ4h8Cocxv6rXAA3PgFn1a3laSx2nhLC4dZ56SvcuFDf6Nctv
 fLg0zoxHBqTEbZgy61dtH3K5VC2PWtZt0RDEB/7O7ZqMzEfBNxnHJg6e5f9xiYCgj4HPxU7GlC7
 9kNql6lWr3FQW6+d+HPmzV72QG1YYTvjUSugZcIy9atVj0kxOPIOPQtmy3QaEX69OkZiiOMEsLe
 c7k7735jG09CPaA==
X-Received: by 2002:a05:620a:1a22:b0:8c7:c25:9e69 with SMTP id
 af79cd13be357-8cbc8e2e9efmr2045286885a.66.1772567311969; 
 Tue, 03 Mar 2026 11:48:31 -0800 (PST)
X-Received: by 2002:a05:620a:1a22:b0:8c7:c25:9e69 with SMTP id
 af79cd13be357-8cbc8e2e9efmr2045282785a.66.1772567311362; 
 Tue, 03 Mar 2026 11:48:31 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0485ca0asm38444196d6.11.2026.03.03.11.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:48:31 -0800 (PST)
Date: Tue, 3 Mar 2026 14:48:19 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 08/15] system/memory: constify section arguments
Message-ID: <aac7A4XbqFNmYzCT@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-9-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 26, 2026 at 02:59:53PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The sections shouldn't be modified.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


