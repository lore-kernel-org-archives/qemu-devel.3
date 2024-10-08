Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BFDCEFC26
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syCGh-0004tu-R5; Tue, 08 Oct 2024 11:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syCGg-0004tj-DA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syCGf-0002QV-1h
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728401815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SeAOtVxsxe5DgoivNpzbMICWKIG1igNj6NDUzY0aGTk=;
 b=Xd7YxRPtYwjIVcfr3Lm4fTbtnojnxLzVuyOj6ADCuQgRyc2FqzmfxGah+AaT6B3zTlIEgk
 2IZ1m1y+rLgYo0PKW/HzoOlzgKRexIMHz2vKZ0a6ATM9wnNGsOcqfXpECAYc4qiG+sLJ2X
 zuZcneDHnfQ5bpa/w7f7+fzng+JZMyU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-j63qmynDOT2F-sY7BhqweQ-1; Tue, 08 Oct 2024 11:36:54 -0400
X-MC-Unique: j63qmynDOT2F-sY7BhqweQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-45d94168de2so122082911cf.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 08:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728401814; x=1729006614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeAOtVxsxe5DgoivNpzbMICWKIG1igNj6NDUzY0aGTk=;
 b=MzEzJscomCveC8bI2Irhks/QHIIUsQTS4731YdsrE5Eza2XWZiibT5bdRoBRdjo3x8
 BtDsK/sGop67iHF7qeKBYNIr4xNWTTjN0O9PJAbLJ1iMhOpPUA/zKKmR6XpRKP2+UWbK
 9J3Hj7qoVgrhfq9rT7eY4zoY4+AdLNcmo1j/pjWLKaYOtG82OBLaxTDnB5FHg7pNHKn3
 vB+uKU1pXTmTr1uJtaj1uryTtLoMC3EjBiNEy2b6Qj/AWoJvyOLKG/AbecmD2e56rYSv
 PXiAHXaadJ9K7lwOJUs9/4W18l9/xsG/9r423boAdgQ4ztGOuKguzIEUZ75qZy6HhmnO
 RaUw==
X-Gm-Message-State: AOJu0Yya0g9tl5aXdOMCkCNAeKOtEyxZ9LBMFLLyTdef3JpU/malwD/Z
 EbfDLBjFzvTwvETCIdIYumAWpkOUPhyKlva2NMf+kVSJ2xVdoGDKeZ8nQ016kkJJisI429LcXOY
 D/2vSg7lu4FMn7QlveG1rGRKRkq8izQMIhIF8iiwo/jBV+DHnPALk
X-Received: by 2002:a05:622a:5b8e:b0:45e:f2df:2eca with SMTP id
 d75a77b69052e-45ef2df2f5fmr41351781cf.32.1728401814213; 
 Tue, 08 Oct 2024 08:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ8CWNR72aUK0W7m8X0Bg4OcOLrH7K30sNlrS/Z5lbWM4uKWraKK0KUltOOtX3zfV8HEi/ZA==
X-Received: by 2002:a05:622a:5b8e:b0:45e:f2df:2eca with SMTP id
 d75a77b69052e-45ef2df2f5fmr41351511cf.32.1728401813886; 
 Tue, 08 Oct 2024 08:36:53 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da75ed4e8sm37250651cf.64.2024.10.08.08.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 08:36:53 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:36:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 09/13] migration: cpr-transfer save and load
Message-ID: <ZwVRkzYyHpYPodNF@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-10-git-send-email-steven.sistare@oracle.com>
 <ZwQQlFkguUCp7UH1@x1n>
 <4ddfebeb-a1ec-44c4-9f73-a1618427a61d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ddfebeb-a1ec-44c4-9f73-a1618427a61d@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 07, 2024 at 03:31:18PM -0400, Steven Sistare wrote:
> On 10/7/2024 12:47 PM, Peter Xu wrote:
> > On Mon, Sep 30, 2024 at 12:40:40PM -0700, Steve Sistare wrote:
> > > Add functions to create a QEMUFile based on a unix URI, for saving or
> > > loading, for use by cpr-transfer mode to preserve CPR state.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > There're a few extra newlines below, though, which could be removed.
> 
> I added the extra lines for readability.  They separate multi-line conditional
> expressions from the body that follows, and separate one if-then-else body
> from the next body.

I think that's not what we normally do in QEMU's code base, but that's
still OK if you prefer; I don't think we have strong requirement on such
format yet.

-- 
Peter Xu


