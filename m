Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9485C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdLvH-0007oO-Om; Thu, 22 Feb 2024 22:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdLvG-0007nv-4D
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdLvE-0001V1-LD
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708657703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3mSsZU9QcUX0krqZZf0MkZ3EARMTAJ8CYrelJx+Ec0=;
 b=WxI68obsTw/dzniapx8m4wTGP2m+/thH2pKK742KTc+HJpVlfWmkiGhLwqHGrynJHXfcsh
 TpwRYSF6BHUmaEkULZIpkb6flX0Qt0mlJedyq2XMCWGjvdEWBpE5rzdlwd9PpEw/4LY1Em
 yjpuzOzgV3WLOvJZ4nDsFrlAuvhO2/o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-KDxndx8rNIW7sIbTaosFHw-1; Thu, 22 Feb 2024 22:08:21 -0500
X-MC-Unique: KDxndx8rNIW7sIbTaosFHw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1dc2d4c7310so674435ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 19:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708657700; x=1709262500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3mSsZU9QcUX0krqZZf0MkZ3EARMTAJ8CYrelJx+Ec0=;
 b=UMwRf/Uqw186CkFj/sceIwRjhb8a9QRtEGns5Ht3vfNSEDGD2+zKOZ6vd/A9lSAKr9
 8KseBkf7sN6ywWEbrIMMhQgbbLG4cNfLc6YErRAlnFjdU7aCMHKZGqppKznRdEtHeLjP
 V9NHWzxFDPukICWHtiQhBcDAiEa4qZu538NLAV+ehncmz1lWwSsRtb2QxVho6ZicJGsp
 R2OL29iP2oy9+28XfWnP2oM1pR6Pj8Cdlo0MzCgCKuqSybhUwmk6UND8WlKFx6UwkLWh
 cz7CoU7/9uHoRSA/E/Qi4wAhbCc/1XFnXZ8/hiOFPoFsjzXjMJPX+JL6d+dPQxumpDDr
 Waug==
X-Gm-Message-State: AOJu0Yxf+lJKIE4hICc/ODN+BFIbupn1Lwy2hfA667+XP7mvcRDmjQ2N
 hB9XCTIPldiuZUlBxtBaZSiw078eWlzxSEqeia+68VZCwvxXCPxSbTVGle+0tjOAY+zycdv5iX9
 C0De1TTZh78Vhe0fg7SsjXEGEqYnOZSKtrDbQipV6N4OzB1xiGn3h
X-Received: by 2002:a17:902:ee81:b0:1dc:51ac:88ef with SMTP id
 a1-20020a170902ee8100b001dc51ac88efmr688404pld.6.1708657700726; 
 Thu, 22 Feb 2024 19:08:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHexuqDgsWT7onYX1WJUWLpzzfJ5lAm+Uqu6iP+ozsxhFhtjeXJE3Sa66OYtgq8113tUd3UNA==
X-Received: by 2002:a17:902:ee81:b0:1dc:51ac:88ef with SMTP id
 a1-20020a170902ee8100b001dc51ac88efmr688393pld.6.1708657700455; 
 Thu, 22 Feb 2024 19:08:20 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 17-20020a170902c21100b001dc23e877c9sm4664381pll.106.2024.02.22.19.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 19:08:20 -0800 (PST)
Date: Fri, 23 Feb 2024 11:08:11 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 03/34] tests/qtest/migration: Add a fd + file test
Message-ID: <ZdgMG9KMseYMcoAF@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 20, 2024 at 07:41:07PM -0300, Fabiano Rosas wrote:
> The fd URI supports an fd that is backed by a file. The code should
> select between QIOChannelFile and QIOChannelSocket, depending on the
> type of the fd. Add a test for that.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


