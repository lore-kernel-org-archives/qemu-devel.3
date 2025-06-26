Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E426C7EE31
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 14:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUnTJ-00056l-9F; Thu, 26 Jun 2025 10:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uUnTG-00056J-Oo
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 10:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uUnTC-0002e7-MU
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 10:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750947647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=StTXzO5ZjK6SXT/D8guH3V06KLCFGDUK8xmseOysfto=;
 b=F/mAe/SSztJYSDVqfj05jyED2YvczBxpqrYY0Gm2AdXl6MgsJ8eyKKjSWY3FpIKOKOuB3R
 PbEsD1+mF2+cZBhDOQi7xS87fQRXbZmq8iKEHSohxECohfCOe3S019KhRLoaDqo1rQQYdk
 WOeVt/UbPoCPKYWkkKT3w+cXitwSg28=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-DfRD4bL1McKH_jlmrbZCUQ-1; Thu, 26 Jun 2025 10:20:45 -0400
X-MC-Unique: DfRD4bL1McKH_jlmrbZCUQ-1
X-Mimecast-MFC-AGG-ID: DfRD4bL1McKH_jlmrbZCUQ_1750947645
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fb0e344e3eso13680316d6.1
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 07:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750947645; x=1751552445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StTXzO5ZjK6SXT/D8guH3V06KLCFGDUK8xmseOysfto=;
 b=H7fWVCo3M56mXm4FzJpqBj3+zSgLYyR2j9KJ/1uJ8piOeAiGoyW6KD9+BDLldRzx7p
 4JvkoL2zvYS7Z0fehBF53F3DI8BZoeAvDwMasICrkyhTUdUpFYybAuo0B3sZ32L76dUk
 EGbaEpd2YmTKr7UAke5BHNmDj5i6QaESswssaw91fiOpWorhN6xNumm6Bz2wP+6IOxfe
 1MBe7vQkQUmdDK3wQgd04xbaz0C8k9dyYIrM4SCq0Tlp7MHxpsFJLES5PU4D/NFdR6pl
 DjSc8stWBLkiBEpk6yMVVGNuLWCagvrjhkCSFeLlpDOSiniUgaPY2wigwC2T+4L8i9d3
 eQEQ==
X-Gm-Message-State: AOJu0Yy5aaPQA4/kaA6ERcB8YQTgblc6wkxlfqHcygfJpplP+BnRu4Kj
 xBU8C39COVX8gzpXcyX3rvCja0HKnPh0bIlKRPf1RclCDowfGgnRccmo5aoNhZPxvY1NTZrURxG
 3wsAPD8eKqAeBgnQSa3Ro9Tk2WbVQHvfRkOpacZWEFzp3xV0GjeM+yXd7
X-Gm-Gg: ASbGncuXDYLiD4cAWA/Mewio7pUKA39fJGaMytOyEQCQNU4yHtBJzh7aTn6wUZAnu5Y
 Nn4UNjkjf734tHB9Ky2O7NDKQiZ1OLyrDXVXZiLs6mkfJdL1UPwifccNTlJDGkuXwiyotz00vAC
 91n36c7kuAn6yGAHEiA5cAmy4sJUrJtqj7y/7zpUnfS9yjze0NQrVOYytVuiZEDbPftO+lOUB2P
 bFRlCITMKAQJ9UAMcm6cUHwFfL2zCh43r39wCV13A15FDb8wMDm02FYMX8XKJgeg843olzvhtFV
 V+6juv5nqbst0Q==
X-Received: by 2002:a05:6214:4981:b0:6fa:c0f8:4dff with SMTP id
 6a1803df08f44-6fd5ef979d0mr120257906d6.37.1750947644845; 
 Thu, 26 Jun 2025 07:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDxvBP61vXXAfo4sEhiYItXie8Hvbyjd7L9wj19kX+VLAbn2kxnnFxYLYRh3hS3d61Ze77hw==
X-Received: by 2002:a05:6214:4981:b0:6fa:c0f8:4dff with SMTP id
 6a1803df08f44-6fd5ef979d0mr120257326d6.37.1750947644326; 
 Thu, 26 Jun 2025 07:20:44 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730ae40sm7836096d6.106.2025.06.26.07.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 07:20:43 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:20:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Rename save_live_complete_precopy_thread to
 save_complete_precopy_thread
Message-ID: <aF1XOcVMHm_VSkip@x1.local>
References: <20250626085235.294690-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626085235.294690-1-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Jun 26, 2025 at 10:52:32AM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Recent patch [1] renames the save_live_complete_precopy handler to
> save_complete, as the machine is not live in most cases when this
> handler is executed. The same is true also for
> save_live_complete_precopy_thread, therefore this patch removes the
> "live" keyword from the handler itself and related types to keep the
> naming unified.
> 
> In contrast to save_complete, this handler is only executed at the end
> of precopy, therefore the "precopy" keyword is retained.
> 
> [1]: https://lore.kernel.org/all/20250613140801.474264-7-peterx@redhat.com/
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
> This patch is based on the following series:
> https://lore.kernel.org/all/20250613140801.474264-1-peterx@redhat.com/

queued, thanks.

-- 
Peter Xu


