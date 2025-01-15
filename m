Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EDAC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 22:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYC6a-0000V1-Dt; Wed, 15 Jan 2025 17:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYC6F-0000Lz-HL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 17:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYC6B-0007JK-JG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 17:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736980973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAWPYBsWsC+Fe9VUk1/9wQP716MnbuwBH85rI7zEeNI=;
 b=GtkQLVCiZl4lliUya22wahgCMguBcilSF1F/zMdGC3bctM8v66kMF0UneuUbBR/irNeSwN
 /H4e/4cduX6nUom8QiMdYzcn/s2CNuF/VippiWVX/gcN3Q6J+LWOOrrEPAX4rwJg5K/vzK
 yfetGcuHeCIvrF778LLvXoSwRQpCnRo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-U48yAaJRN523WY7i_EaMOQ-1; Wed, 15 Jan 2025 17:42:49 -0500
X-MC-Unique: U48yAaJRN523WY7i_EaMOQ-1
X-Mimecast-MFC-AGG-ID: U48yAaJRN523WY7i_EaMOQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso1186355e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 14:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736980967; x=1737585767;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lAWPYBsWsC+Fe9VUk1/9wQP716MnbuwBH85rI7zEeNI=;
 b=YxGCg2aQMX10Hp69svetS9XqeGzt7259qlQ4NFOKTGGw5Ph6ewD1qVK7ICss34Iujg
 0NmiuSABZeDbgMI89Lq81wsdySpifdcyTXtav6Y5vOmMB9ubDhHN3hQx6hDFslxC2qiv
 46u/RvSaAzPgfBDaTkqOk+sxzixH/u8h9JgTsiwtH5WwGyF15/7PBS7Z1wxaEVCxZDyS
 5TfCnUxIdqmfgbKYGc8vAFlQ0f9WqHhR2fkv0Df7VELkaCSQ44BIIieRCaLIozoWV/rn
 lYxiXvZTypBytUgHmVoAMk/R5YYSmyckrel5Mf6LTObi9uYAzCjIl8xxcFWU5adGTG+b
 nhYg==
X-Gm-Message-State: AOJu0Yy5IHotD3eZO3iQvnt6rHyWAezlJNEp/T+1rxljCVl5c7KRjjxJ
 bxaFfIeJyMk647Xy8gadFZpyxSxLp90JB4fB5NZg08AJiURq+Uh9KQRDtz1PfR3+rIIGu7iSnE2
 zXnx827LXJjhlXfERXo5MPUqHlWwbx8UkhJ/mkaKQAMg0e/1Uvzfu
X-Gm-Gg: ASbGncsGajFMgu/N3RyRG4AxAxxHf5vQkUBXd/97JxTphMhY7n7JOge4JeCuaCPb4v0
 lHKDn6NBpx/Fe3xm1SiIeg+V8iRTR21+7/csj53Zfdfr4irEfZw+Mc5RnSCxFs87X0odbzfbVBd
 zMsWBM7ypAs8XEKS/LlDhx/sV7BzUMrBIiyzx8mHvXzGDedcR9BITJ0rt/7czGBMj7FyZ3eQNAT
 xE3U7rbrbJ9pxO9cQD5Vdi4D1cYZcuzwmux8EoXkJgnZxV/dRAr
X-Received: by 2002:a05:600c:3b88:b0:435:192:63fb with SMTP id
 5b1f17b1804b1-436e2686662mr269955925e9.3.1736980967515; 
 Wed, 15 Jan 2025 14:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/aizRyAB5pzKG2JCSSLLCpRCKd7bfRpBrDDLtUMsGx5ZoS/Bat+2EifzHza+JvIF4q1lahQ==
X-Received: by 2002:a05:600c:3b88:b0:435:192:63fb with SMTP id
 5b1f17b1804b1-436e2686662mr269955845e9.3.1736980967175; 
 Wed, 15 Jan 2025 14:42:47 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7540ae7sm37296995e9.33.2025.01.15.14.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 14:42:45 -0800 (PST)
Date: Wed, 15 Jan 2025 17:42:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/48] virtio,pc,pci: features, fixes, cleanups
Message-ID: <20250115174130-mutt-send-email-mst@kernel.org>
References: <cover.1736964487.git.mst@redhat.com>
 <4f0312153b3232dc25afbb3901f00a3c53465074.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f0312153b3232dc25afbb3901f00a3c53465074.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 15, 2025 at 07:15:18PM +0100, David Woodhouse wrote:
> On Wed, 2025-01-15 at 13:08 -0500, Michael S. Tsirkin wrote:
> > The following changes since commit 7433709a147706ad7d1956b15669279933d0f82b:
> > 
> >   Merge tag 'hw-misc-20250113' of https://github.com/philmd/qemu into staging (2025-01-14 12:46:56 -0500)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > 
> > for you to fetch changes up to 60f543ad917fad731e39ff8ce2ca83b9a9cc9d90:
> > 
> >   virtio-net: vhost-user: Implement internal migration (2025-01-15 13:07:34 -0500)
> > 
> > ----------------------------------------------------------------
> > virtio,pc,pci: features, fixes, cleanups
> > 
> > The big thing here are:
> > stage-1 translation in vtd
> > internal migration in vhost-user
> > ghes driver preparation for error injection
> > new resource uuid feature in virtio gpu
> > 
> > And as usual, fixes and cleanups.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Should I be concerned that the vmclock device isn't in this PR?
> 
> https://lore.kernel.org/qemu-devel/20250109080033-mutt-send-email-mst@kernel.org/
> 

Oops.. it was there :( Dropped by mistake in a rebase.
I'll redo the pull, thanks!


