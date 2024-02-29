Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5100CC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 02:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWBD-0000R7-TW; Wed, 28 Feb 2024 21:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfWBB-0000QV-GP
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:29:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfWBA-00059p-4o
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709173787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K+Ui07Am7U8q3ARkGep8i55RdDOfBnWpFwlFEbJVlZE=;
 b=MoUlPj4ZsS3tjGI5bh7MZemKvkD357sfr0C9Z0B4QzUsxbVoBmGgRKTombpU6FVrC2LPQV
 Pimp6Jp2sPlgrR3d0f9H30D0Kz7LbmGJoyh3Z7gNiwEh8W0/huQn9+CJk/I63vg6PKH+fK
 HQdI/qlCJoueKOG57fYzj9er9mWuvbg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-5O6gSaewPiCj4h64qgkGsQ-1; Wed, 28 Feb 2024 21:29:45 -0500
X-MC-Unique: 5O6gSaewPiCj4h64qgkGsQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-299180d546bso62787a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709173785; x=1709778585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+Ui07Am7U8q3ARkGep8i55RdDOfBnWpFwlFEbJVlZE=;
 b=Yk3aO2XSfSnRTeVrgN0okh2ywBAaYYgLnrTChaQUxhVhTMh9380WVUEo8g0ewTUC4s
 lZQ+zQ/AClxGHTQFcxElxtW2+D9EkdIDvS0nx5h/Hk0e7c3FhvVZkVbRlx6mqoltLqHu
 hEGAu+nnKkJaM2le7u+bE2o+Ab1HEzCUthvR2P0QKss/42dfWI0D+8wXfSHR7EBD9eMp
 42d1yztDcYPwaZlt4qQMakkjibsFaFk9FzHkGTUhZQ+w6/emxBcrHUiwgWmBYlAoALqW
 9kThPDqxa+rYlVv7/cDvRoDQRNFL81BA7TGETbdu8ipIlKS5SN2Y+OJrQpx7BzvBum2W
 miZQ==
X-Gm-Message-State: AOJu0YyDyTbQcjoyK56xxDkh0DprlM/Lyw0e0qPSFREpP4PeKMYUUG+o
 aBHLUsvyJoziWa8+zKF9Jwqi6xngH8CpayUwGSV/zc1KTH0BKmhT/ngg5PeAdBK+BSPdIQc5W0k
 33R+TBe6ImBE48t1QR4aq8DAygBBb/+dxucEGn9pqNuMkcsm4bS6w
X-Received: by 2002:a17:90a:3d45:b0:298:b736:ecf7 with SMTP id
 o5-20020a17090a3d4500b00298b736ecf7mr1026402pjf.0.1709173784978; 
 Wed, 28 Feb 2024 18:29:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMtRMt5hj4Spo3I6jvN2YudC+bE/LM7+L9tahm7ioEUnPo+P49Qcp1dcXkNfa7Zdv7O1I2AA==
X-Received: by 2002:a17:90a:3d45:b0:298:b736:ecf7 with SMTP id
 o5-20020a17090a3d4500b00298b736ecf7mr1026393pjf.0.1709173784657; 
 Wed, 28 Feb 2024 18:29:44 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sm7-20020a17090b2e4700b002997e87b390sm2405250pjb.29.2024.02.28.18.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 18:29:44 -0800 (PST)
Date: Thu, 29 Feb 2024 10:29:37 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 16/23] migration/multifd: Add a wrapper for
 channels_created
Message-ID: <Zd_sEVNkO0XH456b@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228152127.18769-17-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Wed, Feb 28, 2024 at 12:21:20PM -0300, Fabiano Rosas wrote:
> We'll need to access multifd_send_state->channels_created from outside
> multifd.c, so introduce a helper for that.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


