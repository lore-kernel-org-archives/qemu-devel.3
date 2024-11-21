Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6F9E64012
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 21:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEENN-0001TO-8q; Thu, 21 Nov 2024 16:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEENF-0001Sq-4A
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 16:06:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEENA-0003RC-EG
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 16:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732223154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v1uXNGcvkaA/O0m24D4+nXnCsyWsS8WD9pbofGs9Dq4=;
 b=A0A78l3t3IE1BkNle0VfjuzuxUzfZnl+aJLWJdiMerH0sKhdCJrJvZqlWOslIQIGmt4Rhg
 ug6U+hOELtOy+hOEh+gi6bftzDMcBSaeKt5U15GknC4Qwm+fyRvvXswe/KARikMEQQom+Z
 gnHy64CN/VWMi+f2JkctDcI05NU/3Sg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-T7P7R7nnOamTSPW2hTqr3w-1; Thu, 21 Nov 2024 16:05:52 -0500
X-MC-Unique: T7P7R7nnOamTSPW2hTqr3w-1
X-Mimecast-MFC-AGG-ID: T7P7R7nnOamTSPW2hTqr3w
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a778ce76fbso14142345ab.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 13:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732223152; x=1732827952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1uXNGcvkaA/O0m24D4+nXnCsyWsS8WD9pbofGs9Dq4=;
 b=dXZiJAxHBXtvQUg6j8sfh5gwWNP21EnjefcKD3P5kKhiuU0HsPJB/ygVoMqTS2PH76
 TSXGEunNnVlS6Q5suZhQEguzALVp+oM+xmxEZslsEKxJxVXDaropFM1KG3k+qxJpdGA9
 sm8RbqSQfg3hc5lUE63RfeqgRcXg7H1ntl7tp9yaHRYFLSA+V3XM6U7N1UtZkviQD7Ke
 sbSHL1Tbj/Oz6S/Imt8yPzvcd+sKUyIQvG4qUB6xLPA4ivl2dUTZRZvaXLiWQxQwKBss
 e0QqD6OYldW3vcbIZf0LPwr0nsS5dGrzRe1DX2fTpPruvSVICi8jg3lWtfIrTaBqDFoX
 JXgQ==
X-Gm-Message-State: AOJu0YxwJOvyhQrPOImUmY0oeMoMMNVPfHPlzvAPwb02mSEYrwz4Jtx7
 gXdrWB0sOAgXs2RnMzKyTlB4nxtKBVEiOpvYiQSvlZ4gYqDEnGSIKwcDXsDU1CtsAMz+qmX8i5o
 EyK3VSWg/uLPnlY/DDS+CHwx4BvaIzAAen/G0s7oZ4nefoWm4bQKH
X-Gm-Gg: ASbGncsdiFh0naUOr764KKcuBfwZg9/9M3XUG+ZkQZo0kvn6204cSZjf6Ae/Z1nL0EC
 9Mw8Al7Hs3JmZxLCc15ccLd/jf92hkpesASHTlcjBVLgqXrcxf9is5X3oJwQjxoTOquLrbYXQWi
 1a4vz7xT2blYxG6OYGl99S/r09lftYGM7hjp0uX74vl93uPBRa7Uj53ICW2wgrWeRqVW0gACzZO
 bpseni0/IhH+hoMRzDDtNXX9IOvgVB7R3C0G7rVRRWpL+EgCEwXlpkAlA0O78oYFCYoM3v3f8Lm
 VQ9cz6kh36Y=
X-Received: by 2002:a05:6e02:1a83:b0:3a7:6d14:cc18 with SMTP id
 e9e14a558f8ab-3a79af9ec8dmr6359335ab.23.1732223151829; 
 Thu, 21 Nov 2024 13:05:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECQmTJJ4UAsBOUjR3IJdKdjKVdnvArAzS7JBxDcfydzmCpDzPbPk7j4nZwgKxBCaXWb0GL8g==
X-Received: by 2002:a05:6e02:1a83:b0:3a7:6d14:cc18 with SMTP id
 e9e14a558f8ab-3a79af9ec8dmr6359105ab.23.1732223151564; 
 Thu, 21 Nov 2024 13:05:51 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a79acb77easm1366485ab.66.2024.11.21.13.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 13:05:50 -0800 (PST)
Date: Thu, 21 Nov 2024 16:05:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 04/22] tests/migration: Disambiguate guestperf vs. a-b
Message-ID: <Zz-gq4XOzzaQnnz5@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 13, 2024 at 04:46:12PM -0300, Fabiano Rosas wrote:
> The current build structure for migration tests is confusing. There is
> the tests/migration directory, which contains two different guest code
> implementations, one for the qtests (a-b-{bootblock|kernel}.S) and
> another for the guestperf script (stress.c). One uses a Makefile,
> while the other uses meson.
> 
> The next patches will add a new qtests/migration/ directory to hold
> qtest code which will make the situation even more confusing.
> 
> Move the guest code used by qtests into a new qtests/migration/
> directory and rename the old one to tests/migration-stress.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Generally makes sense to me.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


