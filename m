Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CA7C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 21:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCn50-0004Oh-T0; Thu, 30 May 2024 17:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCn4z-0004OB-Dc
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCn4x-0004L1-UV
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717103574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwfaALokU9KkD2hsY2py358/g230n+GAlBROcvYNK40=;
 b=Br/rbK3826OO4kyH8woWUyxYIOhJ2W227AtspDwtl2Do5A1R/tox0wA0EwWo7kirS1UQls
 pWLAnYC+lzZzHSDpqw8+8mVg1yo7TrO/BqbDH+bTuaZv3pixFYg5Io4z37GkisyI23m/Sd
 A7qSDKDrm0y/xHXjXBGKYUevCLONcOw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-wDJ_DP3dPoeFtj9st_39kA-1; Thu, 30 May 2024 17:12:53 -0400
X-MC-Unique: wDJ_DP3dPoeFtj9st_39kA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ae3c7688f6so985966d6.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 14:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717103572; x=1717708372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwfaALokU9KkD2hsY2py358/g230n+GAlBROcvYNK40=;
 b=bf30HuJ2KN9e4qgjixadeVSM0zxTZqbCLXk+vNZRUMv3s/zA/aGX1k+MW3MrQ1PI+S
 meExP30p5AA6JRlw8aV3rVHjMEkFPvrRaBi02ijJIYKrJjWSd3aSA6W2PQjuM2n87KMN
 nb+yzQz4+KebpTKvXX2z822rAdlc6UJ4/8txQOk5DORjpylWwol4JUB0fELUjNCflk8u
 /31nrQTY1XpeNC0p/q5IX/LRwcWhxpXfSXhM90BEVZli8pkmHZjwcSYPkp7z3Yt9kImf
 nfe8g6haolmN1LO0MTUg2YXcIif1691JHzXFBfGgDCvfjlXmt0RN/9/9Fjz+jptTud9F
 xOxQ==
X-Gm-Message-State: AOJu0YxxSx50BIavTKUhC478rxHfBl2VbXquyp7MQBKeOCwPE6h8fmn0
 jBB1lIryAHlEVqNZ5fGVt6HneX4usgO0Am1N3nBPf5fBv1MXlukAaZTwKDM1qD9c9EeGumr7iJa
 bi4Gc+YVfWICgHeuILfLOnIYlqAyalhaH/1sySTYjR9/HKZ5mqRZQ0Zu+/F1K
X-Received: by 2002:a05:622a:1a18:b0:439:9377:3aed with SMTP id
 d75a77b69052e-43ff336a84cmr2351571cf.3.1717103571186; 
 Thu, 30 May 2024 14:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpWT44w5PvT9uxzq5/dD6yosAprNSutmTllXKdJT4X+avT+UzNwzvMwXYtcG3HOXNJMlWLEw==
X-Received: by 2002:a05:622a:1a18:b0:439:9377:3aed with SMTP id
 d75a77b69052e-43ff336a84cmr2351291cf.3.1717103570512; 
 Thu, 30 May 2024 14:12:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff2468b5dsm1719621cf.63.2024.05.30.14.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 14:12:50 -0700 (PDT)
Date: Thu, 30 May 2024 17:12:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 10/18] migration: Add direct-io parameter
Message-ID: <Zljr0FxkuV9vbKpf@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, May 23, 2024 at 04:05:40PM -0300, Fabiano Rosas wrote:
> Add the direct-io migration parameter that tells the migration code to
> use O_DIRECT when opening the migration stream file whenever possible.
> 
> This is currently only used with the mapped-ram migration that has a
> clear window guaranteed to perform aligned writes.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


