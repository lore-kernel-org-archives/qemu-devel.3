Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E23CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 18:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ayV-0002qw-UO; Thu, 02 May 2024 14:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2ayU-0002py-It
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2ayS-0004lP-UH
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714673763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZRCtS1amFyjxNEySTALuzbwtEToDCwdFv8S1fiEIBms=;
 b=ERa6FFEHhLMBfwxnNA10yOhJpjTccmOPWWeExyYmnkizcPi0R5AIdI78XbwhSyUatjpkhh
 GExLmK395RpNtZ/t0Az6+Sox0oDIKT7SSsNeAcMrTNNEiEVURUqp7d+OgRTWTTlOqyXAze
 TELm4QlXXTxTPJcfIsMIPE6BKLgxkXw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-VKQsHiQtNKSah1b7UZKsnQ-1; Thu, 02 May 2024 14:16:02 -0400
X-MC-Unique: VKQsHiQtNKSah1b7UZKsnQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c73b31c4e4so507534b6e.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 11:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714673762; x=1715278562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRCtS1amFyjxNEySTALuzbwtEToDCwdFv8S1fiEIBms=;
 b=KHtv0aR02xt1uSsgkBd4GQYaOqo1fWN8zoqoLoSHQ7INqcNNQGBrxajMZ0vviz9lpx
 yy0GjXZwRge6wdXP1u1gGCqCNsuZLSPlVZNOnOaqBTGmYMfVv2lG9mgmrcUGytTzc5nU
 STpm96Fp5cX1X2YziK2SE10j5om3gOxZeJQlpUjZKNTJZ1oXHKKr6czkE2IGq+wkkmw7
 HzsahJx6njETtOXzV3Zzg4bJJ9nKon8E+qUriwQnqOcbJ/u+9Od8+2SvvuwioyYFVmy6
 wMCqfFXvglslXFI/IKXZ6dItC6aIfEyA/ZN5wXyW19Trss/QU1L0UachkZj0CO5+LML6
 Kh4A==
X-Gm-Message-State: AOJu0YwPf6sEFutTncNiJY8cchQQmh4eDIFvMF9nlpUB6tSSqmMpiZ3r
 Gv0YAIGkHvjkyk/gUqe4GaETITkWo442amVsr0GLL3eVicZrsQ2wMifIbZYgAct5bFLSiOkARrn
 0zTanbZfX1EbR2yqsUE6Kx2e+6dGhNBuMO58Zp1bk0j8RE8MXjiiR
X-Received: by 2002:a05:6808:bd3:b0:3c8:4227:4fb0 with SMTP id
 o19-20020a0568080bd300b003c842274fb0mr691434oik.2.1714673761447; 
 Thu, 02 May 2024 11:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/03QHc8oSHTpinD7jlmPgDLW6WQPIi0jU5rb+0UcBia42ktoBHOv7bHtn3EbVozU2fwNn1w==
X-Received: by 2002:a05:6808:bd3:b0:3c8:4227:4fb0 with SMTP id
 o19-20020a0568080bd300b003c842274fb0mr691404oik.2.1714673760913; 
 Thu, 02 May 2024 11:16:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 cp9-20020a056808358900b003c5fa8c0e8dsm229916oib.37.2024.05.02.11.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 11:16:00 -0700 (PDT)
Date: Thu, 2 May 2024 14:15:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: cpr-exec doc (was Re: [PATCH V1 00/26] Live update: cpr-exec)
Message-ID: <ZjPYXtvefbppOGJu@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <19796c1c-4832-47f2-a221-106ae456b264@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19796c1c-4832-47f2-a221-106ae456b264@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 02, 2024 at 12:13:17PM -0400, Steven Sistare wrote:
> On 4/29/2024 11:55 AM, Steve Sistare wrote:
> > This patch series adds the live migration cpr-exec mode.
> 
> Here is the text I plan to add to docs/devel/migration/CPR.rst.  It is
> premature for me to submit this as a patch, because it includes all
> the functionality I plan to add in this and future series, but it may
> help you while reviewing this series.

I haven't reached this series at all yet but thanks for sending this,
definitely helpful for reviews.  I almost tried to ask for it. :)

I don't think it's an issue to send doc updates without full
implementations ready.  We can still mark things as BTD even in doc IMHO,
and it may help to provide a better picture of the whole thing if e.g. this
series only implemented part of them, to either reviewers or users (for the
latter, if the partially impl feature can already be consumed).

Thanks,

-- 
Peter Xu


