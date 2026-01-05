Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC36C79FBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcqXX-0005jH-MM; Mon, 05 Jan 2026 14:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqXT-0005ir-BE
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqXR-00054V-Rk
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767642408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DUBmv5xfJx8DwJvoeFwHfGP9fhrawenx3Z8JhuE2GsE=;
 b=ZJUkveysuwYpYspKPztKYJcLUxylpd2OXBVAp23E3nwtKWgR8sgA+GrIkt3vfF3ECFU2Rr
 4LTMMEowHOabsMXlIlIumW4yDAUf0s3q3Mxps7XdYYAeWK1cbE9hwJ7OCKKO7RoPK70fEh
 HXhIRkGOnHFKyT9IzEowVzuwEemwANw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-xOcseWy8PGSRSZV2pClKqQ-1; Mon, 05 Jan 2026 14:46:47 -0500
X-MC-Unique: xOcseWy8PGSRSZV2pClKqQ-1
X-Mimecast-MFC-AGG-ID: xOcseWy8PGSRSZV2pClKqQ_1767642406
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b6ce1b57b9cso207745a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 11:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767642406; x=1768247206; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DUBmv5xfJx8DwJvoeFwHfGP9fhrawenx3Z8JhuE2GsE=;
 b=QLd5LtOzoiJcQJOl07etv8BEd91nzLssgqXJcMdpeAdTJg5zlQIAN2Mc9qnz/tceyG
 kWU7cIdPSlLJuIM5hbLLRPoVoaUxSaH/Hn2I/lFN5NnZr1pxMPjSM8NNzCHgKyxKc0Vn
 DTo0acX7wol1S3aqqojVJJmDV9FZH4qWi/XWsYAHwhx6Dau8CrxH09YxwcV4L9uHiKqR
 I9TtmukrB90utCpEQA4L2K2N7yMeAP3sEU8kGdObBo4UYyHDoTsgMoxngIMFYCNb+Qnx
 dkS9rzj838e6oCgMY6N57q4DtWOpmHhaC+k52PRNJtGeMcA8xpxsHUPvpGlUWG8SmFIE
 Htzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767642406; x=1768247206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUBmv5xfJx8DwJvoeFwHfGP9fhrawenx3Z8JhuE2GsE=;
 b=nT4+a5UmQle+QS3X5hhLcXPKRJwTYM8DffvucInUZJoia5fGVCDc2HTcGKJynHLz6p
 IxrXqzaz513Kql65f0NnbbMmK8oWZGsUSl/HevObw/0uIpoOhHpLuiWwBVYya27IlO+g
 bKrykzR1BAuagBS//+oAtRBb3Nf6ATadFYuUeU5pdtLLU+alD/NCVAhXg3R+ZOofINh0
 cFkCXYEalJd9pqsb114wCcGW/bGtp5fba666F0vPdsborg341rYIHOOCUf2ILYQWNG81
 yD4AZdnm+eXRGdHASaIyJZhTs2aHc2W/zqgmLklJh7bbpiDF/bVo1eHKq3QIcutVHOAT
 +8hg==
X-Gm-Message-State: AOJu0Ywgil50vquSeI1g0IndKM2it1sTa7fWSEWT258ybJPcdMGSRgJm
 unKFXOE1GO2cZcf9ZMAI/6zfO48nuPGfM+jQ16OhMUqBAzIbW44ErnK6xi4RZYf0ivb9Uuxb5HA
 e/CZ+mk1HJQ6M6uv8nhsklvy+3v05ZjU17b1qVGViyzmwUaZAinMaxrz1
X-Gm-Gg: AY/fxX6JqSYpjBvO80D07QgKtLfN8NNFJT4AIQBxhntF8All64sAsUi56iK3s38yxgu
 5RUqdYMSaips74y1WcvfmS+lDZGY+KSabvUdz9zLpa+s1den5A6ZAkRZrCP8p0XZiIXef4ZloUN
 ZSavj/4Ho6BQcTRc1JQ9sVjJ8p5z2qROgan1sPXsvVfXqxYi6h3cgBDCSHg6VGFUc1LKq+juVxQ
 8iGKHmE3UXDBminzSnBCA5EuLq/+Kg3hjj5Y2mUBCOMTwPn/6NCvaEksCr+qDbWISiiM/U6LHt1
 QF8PAZvqV6PTXApj+Xcbj5n5mENdGUUVsFxJo6FY3tp2aqw9kJwWyq9M7RmSR/M89PisgTgPr3w
 4GCY=
X-Received: by 2002:a05:7301:7110:b0:2ac:1caa:8705 with SMTP id
 5a478bee46e88-2b16f91965cmr324685eec.36.1767642406140; 
 Mon, 05 Jan 2026 11:46:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvyToQcfWRZPoDaBS10Z2jYz7oW8ty8LeJRjw87//iLiwtI8mnNCjHUOHyl9rAce/uDMjvZw==
X-Received: by 2002:a05:7301:7110:b0:2ac:1caa:8705 with SMTP id
 5a478bee46e88-2b16f91965cmr324664eec.36.1767642405560; 
 Mon, 05 Jan 2026 11:46:45 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b1707d76aasm48763eec.33.2026.01.05.11.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:46:45 -0800 (PST)
Date: Mon, 5 Jan 2026 14:46:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2 17/25] migration: Rename instances of start
Message-ID: <aVwVIAt46jc_TxpW@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-18-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-18-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jan 05, 2026 at 04:06:34PM -0300, Fabiano Rosas wrote:
> To make it easier to follow the code, rename the functions that start
> the migration thread and migration coroutine to contain the word
> "start".
> 
> This will give new contributors the chance of seeing the word start
> and reaching the actual migration code, instead of twists and turns of
> qio_channel_add_watch and qio_task_run_in_thread.
> 
> Remove all other instances of "start" and use wording more suitable to
> what the current migration stage is. The transport code such as
> fd_start_migration_outgoing becomes fd_connect_outgoing, the early
> setup code such as qemu_start_incoming_migration becomes
> qemu_setup_incoming_migration and so on.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


