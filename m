Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABAFE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 20:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTRYV-0006cN-Nk; Thu, 02 Jan 2025 15:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTRYJ-0006M9-8h
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 15:12:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTRYG-00010g-Qg
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 15:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735848734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zbwJARHKzgEdXyHwqh1arhqSvoYfYYb75dJl79bX+zQ=;
 b=BUKr2icepgiLT3agFvfmnTrYgrFo0EnhD4p0BymHWtMYAz78q361NPZuGYjxjvlpS0kNXS
 AB9Y5Cm3FmGwG6Z+i1ivFd4Vu4G9BD5qkgoZbpJrdaJBwLx6JOIRLuNee8JDa6DHA569GA
 oYnNhGy08v1fAMit45SaIizmS3vcbG4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-oqsWv_cLPrqq77aoLwc7BQ-1; Thu, 02 Jan 2025 15:12:11 -0500
X-MC-Unique: oqsWv_cLPrqq77aoLwc7BQ-1
X-Mimecast-MFC-AGG-ID: oqsWv_cLPrqq77aoLwc7BQ
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6e1b0373bso363811385a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 12:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735848731; x=1736453531;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbwJARHKzgEdXyHwqh1arhqSvoYfYYb75dJl79bX+zQ=;
 b=BjnmhxOMBB9ichV5k2OaGKblM9PNBiFUATr/iwK0e2L0IlAvr1nk13I8EfmmiovqX9
 z4QA1Fh65/tavgfsLbfM3qERrKe3yNHFFmyzE7oBTlx0LRYiNrhyeLAoTv71MFMcW4oC
 AsNxYuAwWs/2DeafgG8iCvIhhZR3d/XHsAA1+YZp2IZB8UITLyvBdq6nI2qmtOHceBQt
 KqLkUIIqWDwLQ9xlTjVlucT2Ej37JBopIbC9/jrz0TmTPyoRILGoTF5VhjlLQ5r0wbl2
 w0OVLorS2nYAbdKFPLeI1dp07U29rWKWGhTSUaqYjiXPhp1eOAqEW6QAMek2YkIhAfh9
 kh7A==
X-Gm-Message-State: AOJu0Yw5Hdi3Lq9MI3eeGG5njZzfRRJJjZTqh+AyhSNADPTTVTPPEQYf
 KzNCw1pvJ/PiGPN7WZ3jBv2Xl4mkXvlXXwPne3YaNfmw8l+yLnCLhVccPO1pdvRlZL4wM2BdDk7
 EVUdj/7l+1PFlPnjju3R4z9Pko0UOg1oeDO6/LxYjddAHsgrT/LJu
X-Gm-Gg: ASbGnctT2smBGaU4Kgxl62ZwghDwFRKnFMlIEbGqL62OtDaKRZ4wNMRr7tcN9g8uqnc
 LQIFUj0p4+m1iBY3E01tGl9zvWp9VqVIObkVqoAoh2H0OVaKxTry4nnJ4vD9XJxnBGIZQMJQEHZ
 swjB+qRS5afFjf354z9jWku+P53/wBtF3EPguQiKADQsDadzfoAeA892F8t0arHZlSqyd5YCvDl
 P4GrK1y2f31Ty2D+bgSOA4tQQ1SrJN8PwiS4ShslrkLNRxeyQTJ0hRXgZzrHXyovxKVAsyx4taf
 A4KvUFN0S+3LaoCy3A==
X-Received: by 2002:a05:620a:2449:b0:7b6:d383:3cca with SMTP id
 af79cd13be357-7b9ba7ac3e2mr8231277985a.35.1735848731416; 
 Thu, 02 Jan 2025 12:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjM9HuqEsWuUAmCm9ARNKztosxa6TyRVrTwCHf4dnE5y+T+QNtv30hjDrQwX9I2RQyZPJfrQ==
X-Received: by 2002:a05:620a:2449:b0:7b6:d383:3cca with SMTP id
 af79cd13be357-7b9ba7ac3e2mr8231275585a.35.1735848731175; 
 Thu, 02 Jan 2025 12:12:11 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac4ec226sm1209742185a.120.2025.01.02.12.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 12:12:10 -0800 (PST)
Date: Thu, 2 Jan 2025 15:12:08 -0500
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
Subject: Re: [PATCH V5 22/23] migration-test: cpr-transfer
Message-ID: <Z3bzGL83Paq8LxeJ@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-23-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-23-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Dec 24, 2024 at 08:17:07AM -0800, Steve Sistare wrote:
> Add a migration test for cpr-transfer mode.  Defer the connection to the
> target monitor, else the test hangs because in cpr-transfer mode QEMU does
> not listen for monitor connections until we send the migrate command to
> source QEMU.
> 
> To test -incoming defer, send a migrate incoming command to the target,
> after sending the migrate command to the source, as required by
> cpr-transfer mode.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


