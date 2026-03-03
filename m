Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A91DEDA68D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSLj-00067N-BV; Tue, 03 Mar 2026 11:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSLS-0005z6-IP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:11:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSLM-0005b6-GN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772554289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=olgD0clpE0baOpuO5+pOb2Ld3gPgWX6Rcbk30mz6MHo=;
 b=ee+5JRAwSYnlZt9896pTIfhRlSZ1LLG1gW8MWzJSCbsg+YwsISLF2C1ltiBxSZjchli8AG
 qmdlTUrZyUWXZtyDERfOK5aionLg9q+v3zjh0L4lh4yrjRirByMJSroCAwHsOIV2WFwcE2
 9PsMSGtsdYGDYqC9RqEP88ZDm97Zyjo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-Ec5ofgz6MXSO31ESYoQfNQ-1; Tue, 03 Mar 2026 11:11:26 -0500
X-MC-Unique: Ec5ofgz6MXSO31ESYoQfNQ-1
X-Mimecast-MFC-AGG-ID: Ec5ofgz6MXSO31ESYoQfNQ_1772554286
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-899f92be718so59849716d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772554285; x=1773159085; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=olgD0clpE0baOpuO5+pOb2Ld3gPgWX6Rcbk30mz6MHo=;
 b=UEZq+iUNR2Lgs8XD4dn7g9ev+els8FlBo4M1g0Ii3iNpoM3fWTgkrgXPvbhnHDi0A+
 dpKUq/iqe1rqa3bIOn9zdRrl2WUPhPgboVDBQVcSoPPHyzx1akL5vSoFCw8mA1UGd8Yx
 7akqEmxRJSPP+86D0EItJ0XMjn3eAgWaCcZwF7HITXznqKj6JUDtv9yqQxifSPEvVKNU
 cU3IiZZ7jeT8iQWe6ZuBrqC4XYOozi1d+1PuAL4IfRZuiZa1xbWKwq4qzfBmAMhaN9wu
 uaixe9fs15KXJ8DQA0HHAV2AREKW/uJsIleVuW0Rm97pcZdaABygTrAMtZXFdF0Iqe7m
 CfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772554285; x=1773159085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olgD0clpE0baOpuO5+pOb2Ld3gPgWX6Rcbk30mz6MHo=;
 b=MJFS48vTqPLlQVnq1/tOv0oThgrs86cAKJ5BLH83fBo5CIcTEM8Q9DyNG5XT3HlRuG
 Y3WWsCjSyrnfWeTNXbSLuU2/RZYb5RLr6QYExRYqV+8Q1xPJ9kugna3jgtIBPqO6TjcK
 djwcOHMOAkUVXB4D/dnQpn7FdVX5FimycxGg7/rI5Rw5chEWjdtUtwcbpgMb51y7E2h/
 K5DeAVppW3sUuaRrmdeRSbLQleZKfRmfLQ+PV6Hi6Fb5wBnN1FgzbHSrCnJTEPZe261L
 T9X1FQTGNkOkeVZq1fU1M9PzZL2RcmO/xu2ao5a2e9BOg/h6qve+FXWF1JPeMP/BRb4D
 8YtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH68ywJYWV108j3HDQe7UAEYxJYibgCGZ/qJMMwwtXXkG4bKVVT+Ocd7Vfr9sRwxks9TurvFNSjzbc@nongnu.org
X-Gm-Message-State: AOJu0YwcSuPnys0x7V/MkWjmmU/svogZUFnwPjDvrcN+wsyYdNx2Faej
 fEGIhX1guyFImjocAtjcImID4a3bnSQfPGCdblbDEm3zG7JC7yKVhGoAF30ZX/g4SiKWNZYyTDZ
 9clKlIB0Kai4E6x4FHwaotLNqrkpzmGXlH2CtqR9lm2sXFbe4v6infEnWscg53btP
X-Gm-Gg: ATEYQzyW9WKh6O8Kw8nc5qk+LbgfiChwSD5Ndo0wS3ci2V3omV97//SSPiOqVphLCcR
 utGxfD0vIooVO07wYTEOPkYrsgfHKVpQA3Oyf9bZHxRzRSsoSAOsciRa8LsR6sriiRoWmlaGEAS
 3lZm3E5+TCNIKI0LC2pfbPUFeP2WTQndlzQYUIfRx9b0l1U3fXTV4H+YxfwVxdB+LMD/XSVmwKF
 r4fvKItTXtZpn6OlpRNPR+LaIiD2jPWyAqPeLZ637cP3DdKG9RRumDR6BUmmaXOP+6QmqBqMkW6
 UseZF4BRLKhgxyzPdW0oXiXNSPfPef5NO10rGiocLjp6V6epq3qY3Y4filkJRP9Z9xXeJAcgUn1
 tFj9WGqKniBi+Qw==
X-Received: by 2002:a05:6214:c6d:b0:89a:125f:37dd with SMTP id
 6a1803df08f44-89a125f394amr20372166d6.49.1772554285457; 
 Tue, 03 Mar 2026 08:11:25 -0800 (PST)
X-Received: by 2002:a05:6214:c6d:b0:89a:125f:37dd with SMTP id
 6a1803df08f44-89a125f394amr20371606d6.49.1772554284991; 
 Tue, 03 Mar 2026 08:11:24 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c7159b72sm134813326d6.7.2026.03.03.08.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 08:11:24 -0800 (PST)
Date: Tue, 3 Mar 2026 11:11:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 08/16] migration: factor out vmstate_pre_load() from
 vmstate_load_state()
Message-ID: <aacIIVfQaDxOJxPH@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-9-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-9-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Feb 21, 2026 at 12:02:06AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Simplify vmstate_load_state() which is rather big, and simplify further
> refactoring.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


