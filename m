Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC31C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 20:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trjM2-000518-V3; Mon, 10 Mar 2025 16:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1trjLh-0004yt-NK
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 16:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1trjLd-0004Fy-Vi
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 16:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741637015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7teXWz0/UHWkxIx3kGgB5EzIhqX9cIVuzQOFIGgCSw=;
 b=ZUI6CfzTR0CeGUYBmbQGAQmcHjGNGhWe9t/HD898BZ/3u8eCz0qYxmi6SV6eGzgFxOLPEQ
 Q4BnSMiTtq23zhexc9yfzEE7kc/AkYkRWLVAFD7W3XJ0j/wZnY/9Q2dPgGe/AHpka28xBP
 LxdcjSut1qz5uNBGTNODpxCdMuObEiw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-cPmAq1jvMxmEyIk_PgmSBQ-1; Mon, 10 Mar 2025 16:03:31 -0400
X-MC-Unique: cPmAq1jvMxmEyIk_PgmSBQ-1
X-Mimecast-MFC-AGG-ID: cPmAq1jvMxmEyIk_PgmSBQ_1741637011
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-476664bffbeso55464111cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 13:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741637011; x=1742241811;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h7teXWz0/UHWkxIx3kGgB5EzIhqX9cIVuzQOFIGgCSw=;
 b=DLuDqmnUZxrSNKvSwoEEUeqivIw3puMBm6kPRxqe1I8sAqkwbhDBjVBUJ0YveA2inr
 EYpBNBtDNFIoJbYaD490prUczh/DHyzoVWdSgQsVi+I8DO08zpyYsb1AQDRlwKMo5jew
 +C/DweAzAQEmW7HG2TZQFeWX5daVhEKOtfXFVcFJrLkcnC1ekNjk4c89ssvhcUZ67Adg
 gHS80CJg0NNftbnUX1C4cqvUnBm7lceIi7kxFxfwa0WFClFuIobrg0StnxIHuI3EDfMp
 ZYO9ceJHfT7R9Mslr4qNQf5RyU9UKMbNUui4OYEd6AiN/qRawr2D4e8TET+++VjjFOlS
 W1tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJdam0Lf5GlTZjzFwvPIrz/Yrl5wbkSLPB8a2V8sytZvmeqZEmvhwo3Tx8wv+KQBW0DeGqv7B9Ypp/@nongnu.org
X-Gm-Message-State: AOJu0YwGG5UJ7fzzrJ44KiR+qZn4xohXe/OuTSRFe8ge9TTHnAfKD/f/
 hgQyRLwe9mPKiRDCTtf26P6TGuKRUOR1VGmpKrBikfo5A3IKdzg6MjiqIz2hnisYznzRhLPZbJB
 Bl/m64aGR5fYuitg2267OYfqy0hZAt6vnkJ5KTLig4Xjzk7RLtZ9t
X-Gm-Gg: ASbGncu2sIacPIj5/CEbgvjUzjM4SiA+gjGj9TZpjpXZHY+oT+qnCf7cG/R+glmEKa7
 fh6dILkHOz/WZBiriVq1fKL2IL8fC8sg4K7z+O7skYlFROa3LJeEUqRUKUS6YdH4Qzilhbw6wzj
 VdxvSjtx+ay47H/gLVwsfdLaaZhPSaA31U2c79dI2SMD2zdvIvaEwz+ANukIDYTjmgKIO4VBxkG
 sK9d0oXevzf+o9hkSBID7Ou3YjU74SdbGavkzizQZ551EsSChHrn8cdpmDSzWqbaLgbKad4d5Gq
 JSBTr/g=
X-Received: by 2002:a05:622a:450:b0:474:bdfa:2bb3 with SMTP id
 d75a77b69052e-476109ae4aamr171869091cf.22.1741637010735; 
 Mon, 10 Mar 2025 13:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ9Mgf8K+uFM/1ZfWooy8Ac2M1tLJOQSKIYHUI/fCJ7lP3eUH4A12XcK8h9BKdpO0N6YrpOQ==
X-Received: by 2002:a05:622a:450:b0:474:bdfa:2bb3 with SMTP id
 d75a77b69052e-476109ae4aamr171868901cf.22.1741637010443; 
 Mon, 10 Mar 2025 13:03:30 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476747bb85esm30528521cf.58.2025.03.10.13.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 13:03:29 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:03:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org,
 leobras@redhat.com, farosas@suse.de
Subject: Re: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue
 on ENOBUF failure for sendmsg
Message-ID: <Z89FjreYuRjEeX1f@x1.local>
References: <20250310011500.240782-1-manish.mishra@nutanix.com>
 <Z885hS6QmGOZYj7N@x1.local> <Z89CALrwKnHdO4hx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z89CALrwKnHdO4hx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 10, 2025 at 07:48:16PM +0000, Daniel P. Berrangé wrote:
> Given this is in public API, the data needs to remain reported accurately
> for the whole deprecation period. IOW, the patch to qiochannel needs to
> preserve this data too.

:-(

We could potentially mark MigrationStats to be experimental as a whole and
declare that in deprecate.rst too, then after two releases, we can randomly
add / remove fields as wish without always need to go through the
deprecation process, am I right?

Maybe we should do that..

Thanks,

-- 
Peter Xu


