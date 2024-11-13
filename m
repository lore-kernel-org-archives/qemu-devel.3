Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555C5D637C4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 21:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBLNa-00053b-NR; Wed, 13 Nov 2024 16:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBLNZ-00053I-0D
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 16:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBLNX-0000oG-6w
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 16:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731535101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3mhakVSZlpYbfZ15Io+r9OwTTlTDRZSnkgVEwep30c=;
 b=GbI3PIDOt9G0V87+Pja8KZUC6rjDYHVgl+IVh5k3iSn5zpRF1NN3O4xZHTtD8ZQelHMrLR
 P2Wztu2fwKTu/9VFHJpHnq3MVowMlp7IzOaXcPPSbmZ4QzESAXgdNs8PTFmZSOxG03t8mi
 J+TAqPt4GGF1EmmzegNrTz2gGAy+Z1g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-NuXKjsZkOJ2wJQw8Gff6cQ-1; Wed, 13 Nov 2024 16:58:20 -0500
X-MC-Unique: NuXKjsZkOJ2wJQw8Gff6cQ-1
X-Mimecast-MFC-AGG-ID: NuXKjsZkOJ2wJQw8Gff6cQ
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-460a9b67fadso104847511cf.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 13:58:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731535100; x=1732139900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3mhakVSZlpYbfZ15Io+r9OwTTlTDRZSnkgVEwep30c=;
 b=B8nmwSgXn3wFfbQO7xrZa+G+Lhm8QU7MUEb7Euie5QK64vZ5ka89Mqo/aU5X1G0sTZ
 pUUCUweFQnDbWkDGWq8kpLk9vohy9l1B/A3trEfNnbIlZcNMpS2nhD14cDyukvWfXTAg
 g9osX7rEhToy3jZE40DwYXbQQXq4Fk9DiXB9vg9Ncvxn0Adam8ldSd5/REkTvhVG2hjC
 v7mjGbaJZyY0+RM/sauQ7UfAiukdiEh6FqPd9HmhYwXPL78oAFLcKKbhs2q4FDJzvFU2
 F6biO64RK5YaFSUDdffFeda/cEb6ufRO2hXLfFJMt8yibKiBJrzJh9OoSnYgoZ2Z8VQC
 v73Q==
X-Gm-Message-State: AOJu0YwzHel28iyHMiCXB6tJqp37lr6z3Dq9FBKXTk22uC42UOmJfpwM
 r+pgbIXCIpnh5t9zCZn5Ocz+vwsO/FVyweQTdNQt+Z2qxE89LXspmlLTL8A0Eq+qKCP/gT+nHAz
 PvNb7+EDtGdEDCmX3Gef6na5MlfOnGU8IyJUF/ld9DRC2DWErNzHe
X-Received: by 2002:a05:622a:22a8:b0:458:5ea0:c799 with SMTP id
 d75a77b69052e-46309300366mr318950561cf.3.1731535100111; 
 Wed, 13 Nov 2024 13:58:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGImqgPu42nv+URVGH62eVkD98q8OQ6pcCY2l7S9z76SrtY8EWyeUFyS5UWdosynijxfYADJQ==
X-Received: by 2002:a05:622a:22a8:b0:458:5ea0:c799 with SMTP id
 d75a77b69052e-46309300366mr318950361cf.3.1731535099807; 
 Wed, 13 Nov 2024 13:58:19 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff580feesm94375881cf.68.2024.11.13.13.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 13:58:19 -0800 (PST)
Date: Wed, 13 Nov 2024 16:58:15 -0500
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
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
Message-ID: <ZzUg9w0Kvfuleuxk@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

On Fri, Nov 01, 2024 at 06:47:50AM -0700, Steve Sistare wrote:
> Add the cpr-transfer migration mode.  Usage:
>   qemu-system-$arch -machine anon-alloc=memfd ...
> 
>   start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
> 
>   Issue commands to old QEMU:
>   migrate_set_parameter mode cpr-transfer
>   migrate_set_parameter cpr-uri <uri-2>
>   migrate -d <uri-1>

QMP command "migrate" already allows taking MigrationChannel lists, cpr can
be the 2nd supported channel besides "main".

I apologize on only noticing this until now.. I wished the incoming side
can do the same already (which also takes 'MigrationChannel') if monitors
init can be moved earlier, and if precreate worked out.  If not, we should
still consider doing that on source, because cpr-uri isn't usable on dest
anyway.. so they need to be treated separately even now.

Then after we make the monitor code run earlier in the future we could
introduce that to incoming side too, obsoleting -cpr-uri there.

-- 
Peter Xu


