Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B475CCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 17:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEsWQ-0002XW-Fv; Fri, 31 Oct 2025 13:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEsWM-0002X3-JQ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 13:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEsWG-0000I6-LS
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 13:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761930143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o3jMo0JnZY4A5tFGxnlY4A9QjaehVw5cb4sYsaITDBw=;
 b=DV8GscwZyZ0iYU91k7CjBjJKF1M0KFSnZO7fE1eBn9CuHeb6caqxRnzY6RYn90RNF/CZpq
 +koAXtsG0TSAzGiXgHKrRYx8Y0OhEXo7hiiXSXsY7LTWNqzJ30hfjurYvtvLxBZVSnaYpP
 bHGisJSLJjeBJk6DRNuvWTLB6Nna+x8=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-h9LH6X_VMaeoZkBAXPWoLg-1; Fri, 31 Oct 2025 13:02:21 -0400
X-MC-Unique: h9LH6X_VMaeoZkBAXPWoLg-1
X-Mimecast-MFC-AGG-ID: h9LH6X_VMaeoZkBAXPWoLg_1761930141
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-932c2fe4900so939893241.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 10:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761930141; x=1762534941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3jMo0JnZY4A5tFGxnlY4A9QjaehVw5cb4sYsaITDBw=;
 b=UTsztbxs7NyCAxQ283t1P6n3nclwiBdqgH+PZmUYpFzxJpjaXhSTnIzoar3I62DGZ6
 uHIKR3+Aww0gxtymWqeJaC/piLckca8xLIBcAlRgurybImsl2fDKDMuu6vXr801zE8To
 CUaN5GtRPoKAJlMfggYove4o5fn3JKRjgwl8vkkpg6vrtF2yuNh51CWh4XoiJjkYigHO
 nmcJKwfW1btJRIK4NlYFjh6LLe334iNk8FjEvHmI3+BidYOCo8kfeeL9ovG0DNKoQVul
 UvkJpLpucLNCaP6o82GcTXD85tYlkDfLefqwBORwQ31U61HsTi0auR5wXIL6YrPPOEBH
 SURA==
X-Gm-Message-State: AOJu0Yz9zDhnWsrSZJiPLcd9ULaV/I/k4Vtf8HB4ZOMLxybrDqU6uEov
 A9xHKamjFHheeWZmGX9Z7qYi2NNd1CUWQ8DC5ZO1muTUKiEW5SJ1OD1FZoMO5lbAOormk0xIV9X
 LWBWi0xN4gkpWQwXIDb0VmQzl/ZFjrtXODua0+5qWkCoWcdxaUpMWgC+m
X-Gm-Gg: ASbGncvJ9tuSCk9Ktzovz9LDGevW1N9kf4sZX9MX9Ukokya0xi5ytgwVFOJu4RQlNaJ
 HK1gkU7bqlyz52LDa32BG+sWHWByRQtGCCulIZlG4M7H3gKYy8OTPQz86aggc3kLd3QTbOL8CI9
 lsj3h/9XG077dbv578bEQzkSadnoiFsx4GxH4uXmNrwWaWCsWjwgw9GuhEWMDYDxN6GwvN5CcvJ
 RVr+ajgyAwgPAPha/50XFpPbfCrDzWI88NkL4HlwrrP3TAC6HtJmilLDmYd1AU+T/MhvCTZkb9L
 7btTl5Un8PTvnNpg+rmdTEUeThQECxflA22i/4AJx7JKUffFMP5FgZWNLTfhjDpqdcA=
X-Received: by 2002:a05:6102:3587:b0:5d7:ddf6:b3b7 with SMTP id
 ada2fe7eead31-5dbb11e039fmr1341856137.8.1761930130288; 
 Fri, 31 Oct 2025 10:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ2uPqHyMPuAFnyMw7Qo8s/RyORJTpS4e/LC+G9GvCQbr/m4/157JqTx94h3y+ws1ycw9UIA==
X-Received: by 2002:a05:6102:3587:b0:5d7:ddf6:b3b7 with SMTP id
 ada2fe7eead31-5dbb11e039fmr1338774137.8.1761930112410; 
 Fri, 31 Oct 2025 10:01:52 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8803634bca9sm14433696d6.48.2025.10.31.10.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 10:01:51 -0700 (PDT)
Date: Fri, 31 Oct 2025 13:01:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Arun Menon <armenon@redhat.com>
Subject: Re: [PATCH v3 4/7] migration: Refactor all incoming cleanup info
 migration_incoming_destroy()
Message-ID: <aQTrfaffgc6nIgFZ@x1.local>
References: <20251030214915.1411860-1-jmarcin@redhat.com>
 <20251030214915.1411860-5-jmarcin@redhat.com>
 <aQPrYgJMyXIN5yZ2@x1.local>
 <bbggqirwmxugoq3ijnx6ymewfvozwnqnhlmawn7kckln2i6rwq@aztu47ekvpea>
 <aQTj6DnXA3XzT9JA@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQTj6DnXA3XzT9JA@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 31, 2025 at 12:29:28PM -0400, Peter Xu wrote:
> I've queued the series, thanks!

Ahh, this series seems to break iotests 194..

https://gitlab.com/peterx/qemu/-/jobs/11916678476

Juraj, please have a look.  If the fix is small feel free to send a fixup
on top of a patch.

IIUC, we at least need below, but maybe not enough:

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index e114c0b269..f6b34814a2 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -76,7 +76,7 @@ with iotests.FilePath('source.img') as source_img_path, \
 
     while True:
         event1 = source_vm.event_wait('MIGRATION')
-        if event1['data']['status'] == 'postcopy-active':
+        if event1['data']['status'] in ('postcopy-active', 'postcopy-device'):
             # This event is racy, it depends do we really do postcopy or bitmap
             # was migrated during downtime (and no data to migrate in postcopy
             # phase). So, don't log it.

-- 
Peter Xu


