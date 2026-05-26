Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E98CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxnK-0008Or-Rq; Tue, 26 May 2026 15:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRxn5-00082t-DD
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRxn3-0008TC-6T
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779825011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDlhsQjUJn+lnHF5LXarjZWXkkWTPwZBKtfG/46fsgo=;
 b=B7hMKiLjQ7kIvEgDapZotJqL0QcOmerOMgoDFaUP0mWtnaGBqenMC14vyCehLk6cC28i6a
 L+xFod/w/nn3kfOPxoDiWDJkpVa1Iu1X1e80mWgavIkqPst9Z/dbfG16/B/2adB3kV1FAn
 XbX1uNUl7KOQ8lbFC1v3FodndA3lEOI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-DDGfgzUQOH27d31ej1Fstw-1; Tue, 26 May 2026 15:50:07 -0400
X-MC-Unique: DDGfgzUQOH27d31ej1Fstw-1
X-Mimecast-MFC-AGG-ID: DDGfgzUQOH27d31ej1Fstw_1779825006
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45e78dd7baaso8847959f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 12:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779825006; x=1780429806; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TDlhsQjUJn+lnHF5LXarjZWXkkWTPwZBKtfG/46fsgo=;
 b=o/QT9iJTTV0cFKMfJP4cObe1DfvwLu4ySgefSkXDoAinrkj0XTmvA02LhlQI4X1d46
 cWK9tMvkR9ONjWaVU8tIXyskPAzDVVqljmnvVZpFPawrw6W7Rp0V8sA4JBmevNv9tYVD
 6lh3xjpoZgiyRRRwDs6TD5M4Fo0dPN0hDnxN/vYo4vHiEipnqsFOR2n8EemX2n8RQ2oZ
 EGI8ZEK35qsWK5mY57LgaHxyMO3z4bSbudG8r/NC/nhyGbwCN6Hsy1yrKH4BgKHH1Lq7
 B92NBD1DZaJNNGC60h6L9VWXri1QfQa2jKl6hlOsCWpgA4R2EwnwaGUTUjXg/vruuJoE
 +nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779825006; x=1780429806;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDlhsQjUJn+lnHF5LXarjZWXkkWTPwZBKtfG/46fsgo=;
 b=Pr0X4Kmw8idjveChjJGKgc4gHaAE6Brr3uf6DKWWSgzuO4QNNB3aNG0rsJzjpHipBX
 jZTJmG1+njfk1N+7aKB1HHbr3GztOtCAOKZHux+D2ET9L/G82ls/UMBhYnpH+oks/ixg
 09yU5aiz1TU7GXYAxE2hy8SAsc1tDS4rlNOtPxvNDYBCWd+AnMU0Zjwe3Lh9CKtq8W9o
 2mycvzEaR+7eqY8coH6j/FFjuTXTNB0C5N1Qxnj51eLC0APCXsFypsvnb4asdaMDmFNG
 gY/9+k4oyswPu2K/+KRt+TAvRzewpXeluZJIBI6IwMvUIxStEstTYFDOTLTmFXF3wwsn
 UGcQ==
X-Gm-Message-State: AOJu0YwbzQORbqXCGZEoBE6UKVOYysYM3Mvj6Y+u9jcgai7gkZmSPEtV
 DNJ70f5eDnKOQRI7AZgjeEto/av1newY0jWpEkuJUa2qWYEyieFshdZuTWluW9x7q98Zp6AQ0RJ
 wngneDSlepLuH5w3zZLJ4I9xDYwCt0kjh8PgTbwnCUobbQupn9lCVkPrN
X-Gm-Gg: Acq92OFiz+lTRFIqJhRbjQn/IFryvFJljZGDmn6H9Jdj4TVSr8RxpTpHh/8trZYsf0S
 GO2G9APQ9O04A8VGOz6AXAt2lZVBchXqweWGYys2rp5Yv176+fRcWPSAWAmFJQfCqQtTxs6BGde
 Z6oQoHV+yqbJsYUebG2/uiHI8PO502DP7X5X9z1KWeHWdxeYMBQes3O112DfrA61RjL/inSVbP+
 lQKeWcc8tVbWjpR/Do3HPRnKVr+B6DfL4bcEEObd9q9HPiq+rMynVuuKdAzQwUE807SGOdfGPVv
 YaDqzrz4hnadAYr+YdTJfSIqn+b7gTrKGrobG/IbtinTq28/CwprDWZojzL1Mlu/6WFB6XDek7x
 dlagmPRRelQvyHK78iQ1xsMi6W6Crm/ecomUDhK1T7EY=
X-Received: by 2002:a05:6000:144c:b0:455:8733:2026 with SMTP id
 ffacd0b85a97d-45eb3697f64mr34054852f8f.15.1779825006200; 
 Tue, 26 May 2026 12:50:06 -0700 (PDT)
X-Received: by 2002:a05:6000:144c:b0:455:8733:2026 with SMTP id
 ffacd0b85a97d-45eb3697f64mr34054811f8f.15.1779825005706; 
 Tue, 26 May 2026 12:50:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a432sm759824f8f.3.2026.05.26.12.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 12:50:05 -0700 (PDT)
Date: Tue, 26 May 2026 15:50:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260526154712-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahXtqyuIa4XqkMHb@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 26, 2026 at 08:59:55PM +0200, Kevin Wolf wrote:
> maybe practically speaking it has to be all or nothing in terms of
> creativity (for lack of a better word).

That's exactly what copyright is, right? creative expression.
So e.g. adding an include to make a file compile is not creative.

-- 
MST


