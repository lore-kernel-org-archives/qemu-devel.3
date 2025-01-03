Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AE0E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 15:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTjhc-0007MD-U6; Fri, 03 Jan 2025 10:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTjhW-0007JE-Tc
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:35:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTjhU-00047O-2A
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735918493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JciSd8nQWkabREtq+8TmGYrMysfkvslQZoFiKJxalIA=;
 b=XMJ4Zb91zZwpeWlLAuMYabPvnSW/T3hI9HNqXJrrJZbOsuJN2g2ga8xhV9w7m9EgJclzrp
 eaX4OYA8+PKcfj/nh+FBzm7JMnM0Ain/24hU1U41jp3hZOrS8dN9g9Yj3B9dDXdW5SbELm
 AIy05t752kUIF7lUlaB2YrMcN5xlqlQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-Ol1Fcvk2MMGdSaz2y8_P8Q-1; Fri, 03 Jan 2025 10:34:51 -0500
X-MC-Unique: Ol1Fcvk2MMGdSaz2y8_P8Q-1
X-Mimecast-MFC-AGG-ID: Ol1Fcvk2MMGdSaz2y8_P8Q
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e1c50ef1so1936984885a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 07:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735918491; x=1736523291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JciSd8nQWkabREtq+8TmGYrMysfkvslQZoFiKJxalIA=;
 b=DwXGAG5YuUTSAWrUhV4lufFHoKDUeV1ACRbTPsmUnGb4tsN6BpB0OcmIjiPnksqq5Y
 R0GCrYhTV0Ol+pugZW2YJDMP7snf1j5EBOeoFXToOfldqtwTU6+Zd1NMVPsbSgKhvXYn
 1pkFM+aS42te6FKQIvah8yluABEAZ+Qq55bcYPrBVOJdiZno/X7NLlkcu60+tboFFUju
 C6fvPZJAzs8RIVGtUW2IK3o57R2ntFlLM3FqLEHtNRD3VZJT9aVljS73GrfTAuuZPQqd
 nlRp2kHAeWgjhPuW/iuf9ERp6fcLe7hU/gUORMxUUGLHho1Ml7NaEfHZgSEFXP/ERbYq
 +fTA==
X-Gm-Message-State: AOJu0YyKINHNoK74zi20ZZrb3YX5t3/bTRBT0ZnC+IuXx6ce1R/3DR4e
 oeg7xXmxHQ2jEO2l6JRlEcHbfE3rWmGhghpeJmcHiB0six0k98GsFt2rZGuGhbRUAxcqvD5DomT
 2o4uNwj5rWWk/qVU7RlnrvFTix1lNe89Po6usROQTG1PnmU1w3oBJ
X-Gm-Gg: ASbGnctvrm9OttzHt5as1592lb2s+G8FG1z1gyu+OtQCWw45j6dN378Ayxrznqwi7OI
 ZSDNg5Fu5Pdsxt9vEDm2Z/o/DhQekbIr/m6+2eATKkqMdCgEY474/nbRWJG5IhZ8pVMyyPP0ttv
 q4PhTcNfpuRF6oXHJZhUIdmWjd4sNCjcT7k1BTwhOobMcxPOMmjklY0HpyTRfAyVqxJ1iWGSSxb
 9Pp56bHk7xxIoYfgnu5lJS0hhqwfA6AvZ5Te+0xSXbkek5gmzjHETw7MPmYoQOCNQJQDtcRAt5P
 ugHCriFWF7qg28KFwQ==
X-Received: by 2002:a05:620a:4156:b0:7b6:d736:55c4 with SMTP id
 af79cd13be357-7b9ba73ad08mr7867670985a.17.1735918491036; 
 Fri, 03 Jan 2025 07:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN1gik0JBG+r9K4e770rrQ3qvwcLco3GBCU2+0X1QK0BHs9ksIq612dRPY0jE4P9UYGA00kw==
X-Received: by 2002:a05:620a:4156:b0:7b6:d736:55c4 with SMTP id
 af79cd13be357-7b9ba73ad08mr7867668585a.17.1735918490761; 
 Fri, 03 Jan 2025 07:34:50 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb16c7bsm147045371cf.63.2025.01.03.07.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 07:34:49 -0800 (PST)
Date: Fri, 3 Jan 2025 10:34:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] migration: Add more error handling to
 analyze-migration.py
Message-ID: <Z3gDlxXWWIykLUxP@x1n>
References: <20250103141305.8435-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103141305.8435-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Jan 03, 2025 at 11:13:05AM -0300, Fabiano Rosas wrote:
> The analyze-migration script was seen failing in s390x in misterious
> ways. It seems we're reaching the VMSDFieldStruct constructor without
> any fields, which would indicate an empty .subsection entry, a
> VMSTATE_STRUCT with no fields or a vmsd with no fields. We don't have
> any of those, at least not without the unmigratable flag set, so this
> should never happen.
> 
> Add some debug statements so that we can see what's going on the next
> time the issue happens.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


