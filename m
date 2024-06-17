Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1B1C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHrP-0001BH-F5; Mon, 17 Jun 2024 15:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJHrN-0001Ax-NO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJHrM-0000TM-2n
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718651862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+DXd1LTPn8LaoulIy+ErT35oPExmnD0ZvxR+lEP84Gk=;
 b=Kf9zSz/QZdLYp9C+lvm9gziLIDT1Yd4PRN6W11j8VibKiNlW/EWZY8aZqGVxXAiKDC1msr
 Wixw2htWyM/VT913fczVOKM5XY7/3fRVuwB3YrZl6OQaZBEr1lhKfV+n/hMF/wTG+Y9YSl
 878/xRGJorTnK52GzE7idMyvcb5Y9vg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-5Yf6OYUKPEmV1xHMUFxMCA-1; Mon, 17 Jun 2024 15:17:41 -0400
X-MC-Unique: 5Yf6OYUKPEmV1xHMUFxMCA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4409ac6b7f2so12236431cf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 12:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718651861; x=1719256661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+DXd1LTPn8LaoulIy+ErT35oPExmnD0ZvxR+lEP84Gk=;
 b=S9ZsxRyyc/UzgPENqXGz9lL+l67fmj89BU5DegJwcRg04qmjOiwYWZO9NScEakv3YF
 +IBo5hx9wNWEZXwhliiuwiHWJUH2n4zZw6Y6as7a+4+7gk7Tj0J/KtILOObBnjhdyA7U
 7toO4ma9XFLU56JAnovcWINqgjfK4WBdMBAED1rY9fC+rxYGq4zl7SJ/sJ8qDUwNgJcr
 5uvU3NHpfqwn/DWwE1vRTMHA2Eo5/ply4kstctM7zoTxrKR4YAV/OApjYNZHmpLRa3/y
 I2jQxvaUOlGF5fGOojRHGLHqZ/bkxFqYdKeX29/xRafSRNMsTh9wH5sI5teJ7jmRc9oi
 L2Tw==
X-Gm-Message-State: AOJu0Yw0IvSl3HUywaUSDdS1+L1czUXWLAO4b9BK4nC2BlemxPYEc+Jx
 1YIxtr/TZ463UdReAf4YMZYIxXVzvlIE6yMUEnS5/adK/VWnD73gerfk6nc/2xOtt1oqom+SaUd
 OOxqvKgRS14Oxj3KvGFspRY0R6QnCO/H2UPWeF37PiUJK8sfLYxGW
X-Received: by 2002:ac8:5e4b:0:b0:441:322:af8f with SMTP id
 d75a77b69052e-44216dbfd47mr115427901cf.4.1718651860680; 
 Mon, 17 Jun 2024 12:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXJquKftMIX2YNJuchEQYUwLTl3RZoefa/EOG8wwP1RIrpGkdSfQrBbPApKsjhHFEYzrONOA==
X-Received: by 2002:ac8:5e4b:0:b0:441:322:af8f with SMTP id
 d75a77b69052e-44216dbfd47mr115427671cf.4.1718651860098; 
 Mon, 17 Jun 2024 12:17:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-442198f6133sm39367761cf.47.2024.06.17.12.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 12:17:39 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:17:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v3 01/16] migration: Drop reference to QIOChannel if file
 seeking fails
Message-ID: <ZnCL0XFZkeKDgD-Y@x1n>
References: <20240617185731.9725-1-farosas@suse.de>
 <20240617185731.9725-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617185731.9725-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Mon, Jun 17, 2024 at 03:57:16PM -0300, Fabiano Rosas wrote:
> We forgot to drop the reference to the QIOChannel in the error path of
> the offset adjustment. Do it now.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


