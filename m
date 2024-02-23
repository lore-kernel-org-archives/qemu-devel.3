Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FC6C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdLos-0001v7-ET; Thu, 22 Feb 2024 22:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdLoq-0001uj-Ca
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:01:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdLop-0000Tf-0z
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708657306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=INtrFyP7qpgbCVyzPLuBu8mQ792fSvsfq+2a6pqjDBk=;
 b=gNQEd6/6PoyF3a+FEq4lfoJJFvYtWI13OVq3EydpDdvQE6TYljU3yE/4I4GsaZcwsibLKW
 60W2FK+DaBX90CHKgjPtckYBgvrDm5TdaH4eVm9Kvo+Xe2j3trBv77nElqu366+dLMXEEl
 8u9h7stg2hWBFWsvAaW71hHdYoOWKqc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-6lXtNim8PDadyEvmnc4BEw-1; Thu, 22 Feb 2024 22:01:44 -0500
X-MC-Unique: 6lXtNim8PDadyEvmnc4BEw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cf8663f2d6so89240a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 19:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708657303; x=1709262103;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INtrFyP7qpgbCVyzPLuBu8mQ792fSvsfq+2a6pqjDBk=;
 b=VNZdCMq/j66N28KZk6Z+EL0F0hBWUycuf9wgza6M9MIYuAJNn6hzkq+SkY9Ia9YkZ9
 7pnSRPs5gqIeb7gR3w+bvGT4zxbCG/5PRRzRBnxvrqnClAh1OKohyD5n8k1RgJQBmUc1
 Byrp+7WVwCJwDStiyoL84kHf/rfA7wMzG9b9+k+cVkPNGmWZBvRculhRPRzOQ3UGzgQo
 RDhJQLeXpMBTCvA0TFe9ITUWWeY6DvbGeTe6vL0pECdW3fhlrFGj80TVwkiu/pVdwMcw
 dcVIpFGuUIjY0lcScRdksOmAoy+n0muEIf1h07TXlZGv+1fWYnecAb5EJ+F9x4CckVud
 A8MQ==
X-Gm-Message-State: AOJu0YzULCPOM4ctvfwLRVBeEp2kDtOutadisvnlCXeIR5lUxVq2iU03
 Wc8+Yin2EEUdMzXskrbsHt4BkTV9gONsT1GQXJcnMYAhwmr0dD5Np1a62OeWbnvvWHVsVSCh0KX
 JEeQuth94DRebQ9HcOZochldP7bTel2PEbfBgvISSZ2J2Fc4rUD9r
X-Received: by 2002:a17:902:d344:b0:1db:ce31:96b1 with SMTP id
 l4-20020a170902d34400b001dbce3196b1mr691608plk.6.1708657303564; 
 Thu, 22 Feb 2024 19:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMY9lUBuy7gAczhTokRVP8xBlZFCz1w2dpW2uj01r53VyPzzmvk9SBt/PEnYjxg1FSe/O6/w==
X-Received: by 2002:a17:902:d344:b0:1db:ce31:96b1 with SMTP id
 l4-20020a170902d34400b001dbce3196b1mr691596plk.6.1708657303269; 
 Thu, 22 Feb 2024 19:01:43 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t17-20020a170902d29100b001db5ecb2899sm10706965plc.162.2024.02.22.19.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 19:01:42 -0800 (PST)
Date: Fri, 23 Feb 2024 11:01:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 01/34] docs/devel/migration.rst: Document the file
 transport
Message-ID: <ZdgKiMcQS7yiVxnw@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
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

On Tue, Feb 20, 2024 at 07:41:05PM -0300, Fabiano Rosas wrote:
> When adding the support for file migration with the file: transport,
> we missed adding documentation for it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


