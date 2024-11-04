Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142BFD1BDED
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 20:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t83tF-0005BH-Vl; Mon, 04 Nov 2024 15:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t83t8-00058W-TV
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t83t5-0002hN-VT
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730752882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MOinXhd+AjmA5LD2kP3ASsHkS42ms6a0hQDtMFqnFB0=;
 b=F02vIEB5NeMwxFuIqIwOwq/vo/KpIgbFBAZj7GRlj+qjuPiMWE0uCz6gTrqiN0OD7h9GIS
 DVBlCX3X8CQ6pxLOnjHGgx3lvQW5dX/tCtrp7C1qXzISoE+IQNxk+eyFXfKa/en6ppXmlJ
 vC/gkStXbUghPEPdbo5zJ/1znYfWmGs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-uj0tyOixMuu8-hG5AwspKA-1; Mon, 04 Nov 2024 15:41:21 -0500
X-MC-Unique: uj0tyOixMuu8-hG5AwspKA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-71816436594so3855738a34.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 12:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730752880; x=1731357680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOinXhd+AjmA5LD2kP3ASsHkS42ms6a0hQDtMFqnFB0=;
 b=aSbtMy+JGhMe5R+AHF5HVmuxIyQXwyoQVnmBFVQCyvl/BUef6JmIWIi48mSRCSKmFT
 x97EGdjiFB1TQB5QvaqDELIv2wPm2Jv9exg25GILELHroD+usACevFjLRbl769H49MBl
 kG9/MIjKaFvOr+lN6LO98yPyDB5rE5Ob2W+v15at7q42jpHuj37ryzz1NbDJqglKNicQ
 NieDS+ttAXi5VAm/pADZHS0/jilOKix4GGNUbJMmayJFIpK/EyIoOY3uwUE5i722r+Ar
 EoQZQgBPZTzB49dBl/8CFC7QI8k6DkXquHPUa/ujg0LQYf5/tKA+rZMx7s9TcyGEfi8F
 My+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOImOu++rDBfLnE6FJRHvuECXsKsUf0CKI8unui6zJAxsxTFoqppqXRsuSA2t+Ij6QnH8BdTD7Vu/3@nongnu.org
X-Gm-Message-State: AOJu0YxhjLv8x865pFUyzAM/naBr8w9UclAY8tV468FVPJ57JceQiEe2
 94Sw4J6TGIKN3nx3+uckEXyZvaH93NxFuuDSZleYfeT5pHzrk4KEEqisg3zzwmcuVKSF9v6Y4qM
 8lXtJfIS0KX70gsgIlPH6kL2klZq838Jfh7EFvrxa8ABY0RTcfs9f
X-Received: by 2002:a05:6830:7190:b0:718:7bb:138a with SMTP id
 46e09a7af769-719ca14328cmr9820641a34.10.1730752880333; 
 Mon, 04 Nov 2024 12:41:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkaTfaultGE7yw4w1u/zN7Xm+nSwvFXc3SSR6IeJDrjdaEiSkG9OnESxeFrOlNENDycp0K8w==
X-Received: by 2002:a05:6830:7190:b0:718:7bb:138a with SMTP id
 46e09a7af769-719ca14328cmr9820625a34.10.1730752879983; 
 Mon, 04 Nov 2024 12:41:19 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ec70641405sm1985983eaf.41.2024.11.04.12.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 12:41:19 -0800 (PST)
Date: Mon, 4 Nov 2024 15:41:17 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
Message-ID: <ZykxbYfrrPYFoYkW@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <ZykrPpmwMg7N2Rbe@x1n>
 <48418812-331a-436e-83dd-9037acad3573@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48418812-331a-436e-83dd-9037acad3573@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 04, 2024 at 09:17:30PM +0100, David Hildenbrand wrote:
> On 04.11.24 21:14, Peter Xu wrote:
> > On Mon, Nov 04, 2024 at 08:51:56PM +0100, David Hildenbrand wrote:
> > > > I did that previously, and Peter objected, saying the explicit anon-shared
> > > > should not override the implicit shared=off.
> > > 
> > > Yes, it's better if we can detect that somehow. There should be easy ways to
> > > make that work, so I wouldn't worry about that.
> > 
> > I still think whenever the caller is capable of passing RAM_SHARED flag
> > into ram_block_add(), we should always respect what's passed in from the
> > caller, no matter it's a shared / private request.
> > 
> > A major issue with that idea is when !RAM_SHARED, we don't easily know
> > whether it's because the caller explicitly chose share=off, or if it's
> > simply the type of ramblock that we don't care (e.g. ROMs).
> 
> Agreed. But note that I think ram_block_add() is one level to deep to handle
> that.

True.. qemu_ram_alloc_internal() is probably the best place to do the trick.

Thanks,

-- 
Peter Xu


