Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C96AC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sicNW-0003dM-Ha; Mon, 26 Aug 2024 12:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sicNV-0003Vz-9k
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sicNT-0001AW-Pw
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724688935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ie1Cuh2j23l+0Cb9Tbm50zEd9YdplBvTHuIyNJ5JIs4=;
 b=fwfDI7gBHaetlJbRIIuoG+eYC38+Rh/jJEXTJQ6mh6Zq2LhqAurJpEAOb+IzWN8F0CPOAV
 0JSZYiTq8LE09aPSm1EKdF+si9S26gjJSvt6rZesXFiDv1fec1UNlkaUfM7r6q6PwseNkI
 i1vxvraLTdHPzLivlSijA47Kl7PIVBc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-J8hGM6ucOrqF2Jvoc7sumQ-1; Mon, 26 Aug 2024 12:15:33 -0400
X-MC-Unique: J8hGM6ucOrqF2Jvoc7sumQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-44ff196bbfaso59783141cf.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724688933; x=1725293733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ie1Cuh2j23l+0Cb9Tbm50zEd9YdplBvTHuIyNJ5JIs4=;
 b=mmGCkRxN80Ao5QxYGVg7JN9LplhfJXSyS8g5kEA2KtJXpdFrBvikXmrKCrfvcjnCAk
 7GHPUTS2Ec8tiF61DJ2C4hH6RThPo0EmjiKYxX/NXQdK7rMDWayVVTOm4mWXKtJuxsB1
 t0pW21yqEjZV/NUf8pOca8yeOh/euqpc1mWseFmYCaluaTCzNrxkd9hMA86+wzIKPvUb
 ddC1n3IsoAjjKI/Bcn9n7zlryVj10BRGWYgaCoAzbU3zNKotSxcAyCmKE8/Sm0keJuTl
 dUDEprVPayAa+u+n2FSrcrB6HEhm2iBoznUW+O40DH0peBu0HtkL8n7vBwoAPKDlsIBw
 Ub+g==
X-Gm-Message-State: AOJu0Yw4kZuXGbtsDyiCxy41AVZTHIPURlvj+axDTBHzl9inS74M5T3f
 QAqw3bo5bBNHCxcb+g9xkqPU4QiVhsZIK9ruIOwDHbkOWOxosGoCjFgbSnGJ25lKCxn1FHlFhSx
 CrS6cUjdg5MzUMh+57eOqWViYAMpfdCQeKKPJvaW2oAmO/xPGVzOD
X-Received: by 2002:a05:622a:6104:b0:455:1f:c876 with SMTP id
 d75a77b69052e-45509c53221mr111414561cf.13.1724688932973; 
 Mon, 26 Aug 2024 09:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHquTh8GTWLGN/NIGQQ9vkUBN2L1UToa2Kz3mEOkANnSd9qv0ypuNK2S4NO9YdBN3rLdJyGaw==
X-Received: by 2002:a05:622a:6104:b0:455:1f:c876 with SMTP id
 d75a77b69052e-45509c53221mr111414231cf.13.1724688932529; 
 Mon, 26 Aug 2024 09:15:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c9bedsm44085851cf.95.2024.08.26.09.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:15:32 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:15:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 15/16] migration/multifd: Register nocomp ops
 dynamically
Message-ID: <ZsyqItHv9eq_KMQn@x1n>
References: <20240823173911.6712-1-farosas@suse.de>
 <20240823173911.6712-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823173911.6712-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 23, 2024 at 02:39:10PM -0300, Fabiano Rosas wrote:
> Prior to moving the ram code into multifd-nocomp.c, change the code to
> register the nocomp ops dynamically so we don't need to have the ops
> structure defined in multifd.c.
> 
> While here, move the ops struct initialization to the end of the file
> to make the next diff cleaner.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


