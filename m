Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ABCCFB44C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqw2-0004s0-UX; Mon, 07 Oct 2024 12:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqw1-0004rB-Aq
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqvz-0001wi-Uy
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728319810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DdGSft+0Iu4wWjxR3kcfrNHZ4XBcHm9Cekh5ucLKmj4=;
 b=GaPNkKKKuREmJt7BhtcVde6p+nRGX6b/unXd8+Xv8QhK3Yk4qFQPKl4e8jrlkSDodnd/BR
 nhswsEo+WDCqc4CzfSJlgHDdsJZ1yVn6+26oodYySQZrOxmwgqrLROac0ueXBSltv02XIF
 +pX0SAznGN8tPgSs5Wj1i4HA/UAv3NY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-t81Wi1AdMfCjZ9QfuMlCgg-1; Mon, 07 Oct 2024 12:50:09 -0400
X-MC-Unique: t81Wi1AdMfCjZ9QfuMlCgg-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-82cea2c4e35so569269839f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728319808; x=1728924608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdGSft+0Iu4wWjxR3kcfrNHZ4XBcHm9Cekh5ucLKmj4=;
 b=TVvtNV+HeYCcJRJNWtGM0o23JAWxkYf5P+b3mc7FEdcx51a3cqb5Lw0z+20ZXgZFzr
 KXUw+g+Q2LntqiTuk/CkQILb38smNRsjgYa/1YOMi04xmnYRVCGbF8jFYxU1JTX+hyBW
 UChN6b5csXDsJz/JL7VWzgRNHI20h+a/v/wMqWlps+LnrTkDUpakYjyQo52osf65DaKd
 n7F6xLyXaZrKa9axqLxfQDW4OoCX8Sae/jWkvOe8GlCQf8xZqQiwZtPzkeGH6A81xh3v
 c3sQtIgN70swvaQr4jDDZV0ehMMFY9ZYGSAcyQ6VL430sVu2jli5CuWuzFnmMQwWd4bG
 kv4w==
X-Gm-Message-State: AOJu0YzRI7C/UEEdt5LyZCrAmab3C8iUiFsyncIcUelqwrqFyY1DQkSu
 iRgk5nhfF+EnfvaGxn1m0uRzGuJenz9QQlDBu3mYiWEVzjXp0Dr61cdVOIAukRtBe2U63ifUVYY
 /MBNVu9hSXL/M/VjcnZmGc3e+QLjfePDzagwqGnz8Pf23OIE6rF/0WxZDGHXM
X-Received: by 2002:a05:6602:485:b0:82a:a8af:626f with SMTP id
 ca18e2360f4ac-834f7c73a72mr1066150239f.2.1728319808467; 
 Mon, 07 Oct 2024 09:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHBINNaGhBy9m+BLnze3h2lx8h95Mc2ccoejBfG/Ju+TXa1igoYf5RC9edXKBeme92uLXlbA==
X-Received: by 2002:a05:6602:485:b0:82a:a8af:626f with SMTP id
 ca18e2360f4ac-834f7c73a72mr1066147839f.2.1728319808118; 
 Mon, 07 Oct 2024 09:50:08 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4db8d6484c7sm274765173.140.2024.10.07.09.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 09:50:07 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:50:05 -0400
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
Subject: Re: [PATCH V2 11/13] migration: cpr-uri option
Message-ID: <ZwQRPf0SV4ipb6qu@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-12-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-12-git-send-email-steven.sistare@oracle.com>
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

On Mon, Sep 30, 2024 at 12:40:42PM -0700, Steve Sistare wrote:
> Define the cpr-uri QEMU command-line option to specify the URI from
> which CPR vmstate is loaded for cpr-transfer mode.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


