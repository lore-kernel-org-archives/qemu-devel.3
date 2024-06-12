Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5EAC27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 18:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHSgk-0000PS-4v; Wed, 12 Jun 2024 14:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHSgi-0000Jn-9q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHSgg-0003G6-OM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718216829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8N0tCfQDxZKgqXkEkMY4W8skwzm7AxYnBHGEioODlP0=;
 b=TSs5Ji8i2gkpFv6XEkLekokhEO1HR6Y2xHHRK4IqS8uAG8jZULwlT6jzSQBLVeP2h5Rpkk
 Ts47GXByQtfMkkbIvM6lrEpO0l75HYG6pwB7ebDGTZAlGavBN/17Nf0GhEyxEji+Pj+KJG
 voBujaz56dAlQ+zQmUtrrHJ7l8787tA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-LfJyM9iiO36LXF7DB_2UWQ-1; Wed, 12 Jun 2024 14:27:08 -0400
X-MC-Unique: LfJyM9iiO36LXF7DB_2UWQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b06c786b64so112076d6.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 11:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718216827; x=1718821627;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8N0tCfQDxZKgqXkEkMY4W8skwzm7AxYnBHGEioODlP0=;
 b=txxieqx7B3MadFUg2GgsusqZslKnDR5Tpdt96AKQkWQXFLecM23YhA36z7cZlnMdn6
 42M1LRS5fj4kZwveE6HhT7fLSHy8wNbWTBZIbtZKJ+G3E7tgl8HzqK4qdzn4bgxKpUnr
 0sUTi4NJKb5wACCpgOvbw3VzPRnUgVIMOwKixiARjFP0QzItvEgy5uLSt34U3WXqoyE8
 WoWowE38rfoSL6wMO+jK7OZ0Ep5N90tbVBP18y9UCiMi4ZBWtZzMrYkykOHIlVw2D9nv
 r7xkWEZ35P4inHVRxhT9FlA3CDHwCLvpePPFGsV1E88zQ9mQcPDNz/isgl0b/nabMBh6
 DOpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXmn4bQW4/TO8mYCCSiiLQ53p2b5H6ISClN/53dF+yHbmzM4icr0WhRmwt2VcAGd/V9Q3afeoBObvaEXz4uUB50yejB1Q=
X-Gm-Message-State: AOJu0YxvBLyKUrUjgUl+eOiMVXtnc+r9WmryG80Qt7uQTjDl/rfk0cCs
 mlfCsOmC1G4VfqNr6L7A2NYRT7Ex7FZnZvyEHtm+oUi2wUzsT4LkpCLtWiQjdT91u4nG2Eo9h12
 cCJY1YfaAFBObsJnJ5YliA4kTnSeNXE/nIQF347832LQ5Wlv0bR2E
X-Received: by 2002:ad4:5d69:0:b0:6ab:7ce8:820c with SMTP id
 6a1803df08f44-6b1b5b124bdmr27010316d6.5.1718216827408; 
 Wed, 12 Jun 2024 11:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+p7D6PRAglYgAzyHyFF8Vn9L9ej5LEHPJMgym7hOibfz7ef+cJF99vizD7GKorUkyP4hK6w==
X-Received: by 2002:ad4:5d69:0:b0:6ab:7ce8:820c with SMTP id
 6a1803df08f44-6b1b5b124bdmr27010046d6.5.1718216826760; 
 Wed, 12 Jun 2024 11:27:06 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b06f915c78sm45772256d6.104.2024.06.12.11.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 11:27:06 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:27:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Claudio Fontana <cfontana@suse.de>,
 Jim Fehlig <jfehlig@suse.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to precopy
 file migration
Message-ID: <ZmnoeEKhvxx8rxu5@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
 <87y17gwq5g.fsf@suse.de> <ZmclVQw0x7KKLxmF@x1n>
 <87r0d4wv1q.fsf@suse.de> <ZmdNstq2bONG-7M7@x1n>
 <87le3cwo9e.fsf@suse.de> <87ed92c9vh.fsf@suse.de>
 <Zmnlt0jUx2o1MEgy@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zmnlt0jUx2o1MEgy@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Wed, Jun 12, 2024 at 07:15:19PM +0100, Daniel P. Berrangé wrote:
> IIUC, with the "fixed-ram" feature, the on-disk format of a saved VM
> should end up the same whether we're using traditional migration, or
> multifd migration. Use of multifd is simply an optimization that lets
> us write RAM in parallel to the file, with direct-io further optimizing.
> 
> There's also a clear break with libvirt between the existing on-disk
> format libvirt uses, and the new fixed-ram format. So we have no backwards
> compatibilty concerns added from multifd, beyond what we already have to
> figure out when deciding on use of 'fixed-ram'. 
> 
> Thus I believe there is no downside to always using multifd for save
> images with fixed-ram, even if we only want nchannels=1.

That sounds good.

Just to double check with all of us: so we allow mapped-ram to be used in
whatever case when !dio, however we restrict dio only when with multifd=on,
am I right?

I'd personally like that, and it also pretty much matches with what we have
with tcp zerocopy send too. After all they're really similar stuff to me on
pinning implications and locked_vm restrictions.  It's just that the target
of the data movement is different here, either to NIC, or to/from a file.

Thanks,

-- 
Peter Xu


