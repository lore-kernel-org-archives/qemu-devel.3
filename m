Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BFBC44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 16:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wklVK-0005uH-9h; Fri, 17 Jul 2026 12:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wklVI-0005tr-4y
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 12:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wklVG-00089A-3W
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 12:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784306012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BHPFparUF819IwONJkaBg2U52ByZ8ExvsDB8nlNNvc4=;
 b=IcsivAbDrYNlshky7wzHs3pnR7UL66zYijA1RXDzV+wi2RSdGAYvwV5ucIbwXfkObCPXIb
 M30y9rg+nPgFqdG9YkMdIkk+zu7lrX5+7JB38NoURl8egDRZHBHAaizr5ExrY/gZLrBmeg
 2yV+hdaZn7KBR4PnLcRzb39yDKzIzI0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-sAP93aMVMe6mkMXDmVzDQw-1; Fri, 17 Jul 2026 12:33:31 -0400
X-MC-Unique: sAP93aMVMe6mkMXDmVzDQw-1
X-Mimecast-MFC-AGG-ID: sAP93aMVMe6mkMXDmVzDQw_1784306010
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso50777761cf.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784306010; x=1784910810; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BHPFparUF819IwONJkaBg2U52ByZ8ExvsDB8nlNNvc4=;
 b=Y7OhYlqob7o1/E2kTvF8xAbdXwKMNivBI3RQNN1E7C4Jw0CjPPP0qOQzMEC+GwCIJi
 sBBg+wJdMkQuESHyhaDU3w2aJghq0BN22pQV1AC/OSlw+3m8SyfypcvQgIOF2mvhAJxZ
 uWrQ9qjGMNEtjaUyD1m4Bvs720t85o78JPXQ5LxaVsKDGevfs4OBpuWFUMecho8Wj77N
 UF2xYMM5IP3zo11mARVfK+NgJtu74creeRwfzo02UOonr1XTszYiy9//gwbJGduq2kOU
 9UfHWAiUeAI6agsZMkF5WzAL/LVUqGT2YnanOGPpIiRnF4xA5U11VGc35Lu78pz+nC2x
 TNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784306010; x=1784910810;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BHPFparUF819IwONJkaBg2U52ByZ8ExvsDB8nlNNvc4=;
 b=nvtg8nb0KumM+F3WEA1a/tYTUJ8anQmXf4KZLRGH45Ndf1qg0U9rcbD4kX0gzslVwB
 MqmkPbN8ei2/wPhDaAdf1ZYB0M7MoU86z5kxXRbVOOdlT27QBmQMZfA/DjXDvfLVlenZ
 tJFHPurlHpQsHGizTMYjPQtTYnTx/qKEEBdLpkDeV8Q5I/jIbirg2Z+0ZI9dHybYgoME
 rXMr4r+fbM27/TbNLX2c7MvdOZC94azm844vrDVUQ79Y+acp15dn6kPW1jETbiQt2HbG
 sYq5NYwp39FOZwvmJy+RhQFV+ybNseSiyNc4ilfAvHD9Rwq0/vHF3uNLLB2iABp398qO
 WZ2Q==
X-Gm-Message-State: AOJu0YxZz+QzT3GZAhpj14N7gsABAk+MSI1+Snd3ErfSuLz6PnxLaLRR
 nxSN43rjUmmiHSP9mrBdCvSNrLnNcRC3x2XroVHO31J2+OaE7EVc5IoNVDy0cLGyj0ghEvIGnbH
 +mc9cUwNtA/neN5NC7ZOX1OaZj+ipPhbdZcLrZ4Jfm6QRdNCtlQVljerv
X-Gm-Gg: AfdE7cl6LVTRWf2hUBm77BW75oZSN8Go32SBEPtVZP6lGgy27AgpuxclgcWM4A+dMpJ
 k9EHCQKekuiGmu08s5Dkp9cXEbXQgEEkVh7dR6+Trr4OuzQfC6bLYcAQZUq2GWuKG1GRUFWRgmV
 SwMziOhBImbl0OFdBdb4AeydshusunXBU6rAXzL60qwuPB/kcN6a3qyKWbTmMjCFmU497//PUyZ
 cIBOT+YbcsQfpoFeD23OXisX97+y6x6a7kOPu5yc28fbGDHtQSVQwg68iYd4e0ei4FuG5JtyhvI
 jg2cxABeWq8gngAK0uOOhfHM/1wivp/wekbjiXOr0qRSBOcSUMXwJ2tiFOhw2xqnPxR8
X-Received: by 2002:a05:622a:307:b0:51c:7aa7:e0ef with SMTP id
 d75a77b69052e-5212c9eb5b3mr34670931cf.44.1784306010255; 
 Fri, 17 Jul 2026 09:33:30 -0700 (PDT)
X-Received: by 2002:a05:622a:307:b0:51c:7aa7:e0ef with SMTP id
 d75a77b69052e-5212c9eb5b3mr34670231cf.44.1784306009352; 
 Fri, 17 Jul 2026 09:33:29 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5214c5cc8d5sm16008371cf.6.2026.07.17.09.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 09:33:28 -0700 (PDT)
Date: Fri, 17 Jul 2026 12:33:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 0/3] migration: postcopy blocktime cleanups and assert fix
Message-ID: <alpZTRIw8IB6Hv8O@x1.local>
References: <20260716101952.65329-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716101952.65329-1-guobin@linux.alibaba.com>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 16, 2026 at 06:19:49PM +0800, Bin Guo wrote:
> This series fixes a couple of issues in the postcopy blocktime
> fine-grained tracking feature:
> 
>   - Patch 1 fixes an ineffective overflow assert in vcpu_faults_current[].
>   - Patch 2 fixes the const/gchar mismatch in format_time_str().

This one was intentional to add some protection on the char string, it's
common way to use, try grep "g_autofree const char" in the tree.

>   - Patch 3 collects minor cleanups: remove a redundant memset() and
>     fix the HMP label for non-vCPU latency.

I queued patch 1+3, thanks!

-- 
Peter Xu


