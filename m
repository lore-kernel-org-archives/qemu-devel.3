Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E161C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 20:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjllo-0008Ar-T4; Thu, 29 Aug 2024 16:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjllm-0007yO-Fk
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 16:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjllk-0007EU-98
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 16:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724963362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N4bHervDiL2rnTMSPJWbTRTatD8UwTQITZ7LFKBPhzo=;
 b=OJBJ925OPB+D+HuC9G2SqALIJisOO+3iriLd4TTenDbMdzjQ/eZRekTvzDffEqGq0RL7iz
 id5Xi1RnRO57tNiX+Pe6q4E2YeNO+ziPPQFQsALvhNFMJ8VF+GWulqn1B02LZHzJtZxIe3
 SZnK/bnaP9Y1Wqnw8A7f1c82zia8KcQ=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-AkHQVQIiOdOy9Qv4XPYgaQ-1; Thu, 29 Aug 2024 16:29:21 -0400
X-MC-Unique: AkHQVQIiOdOy9Qv4XPYgaQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-2701eeb69f4so1127885fac.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 13:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724963360; x=1725568160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4bHervDiL2rnTMSPJWbTRTatD8UwTQITZ7LFKBPhzo=;
 b=btHAk3w/VdpPdtWdJhJs0rK7t4UKog79YLzzQ9EIOg3A1p2KL7sj1LVGjZRROT6gSG
 Gj4ct37mIHKZET3isq8mhULN76SXdMqu56ZpfrQkPDjoz5Y4Hd9dXm0gRwPR3/5OndhF
 5xybokQnLnh+3Ku4hrWowgj7xucYHlCqReqlZBSwlt+YGlN9yFfjWa/lkN7iiqvPF31g
 vdIvmn1GNruKgYqkukbVdisL2LkkMqORHPoux3AOHpF087GDDECg680GBQ6VhUJ58Dba
 En2rr/Ggla8mg0vB45BY+GsYL618KODuzRrg81Gooh2UiBIP/Da/K0/95QPUlEGa4wsI
 Nrog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP8qxlfV1b/BphRRBA/0EatjIArQxsLP38kTJ3CZUXQ+aISgbq9gi5C7MDJtekLMM8YE3tzhFEQ/WC@nongnu.org
X-Gm-Message-State: AOJu0YxpJtKWY76ZOcVtYXUnxIGN1ryEsxzmHs3HEDj5dRRccmDwYGMA
 ri60rHBvC4BOpnF31cQPI9s6i0DgjnF6F5mSMp8pM+bFNqOu7T60U/YnbaYkE9S7RNrFgZjB1Ru
 ONXDiQd8hukm03N+KXSLNxD5J8nilLWkNKBZ/BsXVxwIvD7600wkI
X-Received: by 2002:a05:6870:5686:b0:267:dfce:95eb with SMTP id
 586e51a60fabf-2779007fb84mr4594600fac.5.1724963360580; 
 Thu, 29 Aug 2024 13:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8iTetRlXXbfUIeHch+lg5zqZ9m3liAmJ7MthqwqwiFigndxATU6CaUcQFos71k6C7j0W6lA==
X-Received: by 2002:a05:6870:5686:b0:267:dfce:95eb with SMTP id
 586e51a60fabf-2779007fb84mr4594583fac.5.1724963360222; 
 Thu, 29 Aug 2024 13:29:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-277abae1dc0sm82743fac.12.2024.08.29.13.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 13:29:19 -0700 (PDT)
Date: Thu, 29 Aug 2024 16:29:16 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, jasowang@redhat.com, mcoqueli@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 2/2] vhost-user: add a request-reply lock
Message-ID: <ZtDaHPBvksT6x1Mj@x1n>
References: <20240828100914.105728-1-ppandit@redhat.com>
 <20240828100914.105728-3-ppandit@redhat.com>
 <20240829033717-mutt-send-email-mst@kernel.org>
 <CAE8KmOzC__Z6wgSv9sGcAPrbbZBOQg7tD=6An-=XZVouPCA2Bg@mail.gmail.com>
 <ZtCFxLfFKvojRD2u@x1n>
 <20240829104323-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829104323-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 29, 2024 at 11:05:15AM -0400, Michael S. Tsirkin wrote:
> > Personally I still prefer we look into why a separate mutex won't work and
> > why that timed out; that could be part of whoever is going to investigate
> > the whole issue (including the hang later on). Otherwise I'm ok from
> > migration pov that we take bql in the vhost-user hook, but not in savevm.c.
> 
> ok

Just something as a heads-up comment in case someone might keep looking
into the hang problem: I'm not sure whether the brew build failure on the
test case is relevant to the hang issue we observed, or even it is the hang
issue itself - if the failure is about a timeout that one qemu hanged.

IOW, whoever cannot reproduce the hang might leverage the mutex patch to
reproduce, if we want to figure out the last missing piece of the puzzle..

Thanks,

-- 
Peter Xu


