Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29624C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 15:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSILR-000217-A8; Fri, 12 Jul 2024 11:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sSILN-000203-Or
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sSILL-0002Lk-Tj
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720798674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTGYnNNsHEbBC8OACYJ5MscpsHiEyJc4+q0BrYygCzE=;
 b=fxDmmg3XzxEfLwStYPB4tbkT75xMNuFwvaZASt9bBC9jh0rwLHkrsCEOmaL0GrH51ByEUi
 0IWJAtQnyCv1gQp4sqWC2ZnyQrDLVmGchwAXA3lbZqDZuEa32kWvLYYNPQ1pWCEb7pUuGr
 pp59pu1WWWgapMvEcGNwJtxojjS+Jlg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-mUdO8u77OPWH4Xw5DIcX4g-1; Fri, 12 Jul 2024 11:37:51 -0400
X-MC-Unique: mUdO8u77OPWH4Xw5DIcX4g-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-447e34d7437so1984371cf.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 08:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720798671; x=1721403471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTGYnNNsHEbBC8OACYJ5MscpsHiEyJc4+q0BrYygCzE=;
 b=xMl36EA4maV6dN9i1yZIICn3eqb+7h4rnDxKXERKXCOQo4Y9dztezQ7AyrcNHEoqqs
 8WM55V0PyVaWMskSG+aK/JZ/dNFyuFMYfcydc1n1LZe1Q/9NLsMr4zxXcg19yUF4K97L
 5QM/4816RxhmYekTiOPSoNIvgslRizr7+enfz3k9ziaVjUhv+kNYJUfji4srlS3i5Ho5
 A9SphWwUS0U2Ef67qvJG+2JLfgTiCqhpRpu0R0DvasmzMkoaVoIvGqem1YTjhM7V7P+C
 ksJce9qUU9y4+b7OnFi1b++nVMMQEtV7fPWti+PDTQmSYWeiYjx+LFx0KlpWmOz2EZ7y
 y4Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIkWRXgbK2myV/YIA4oG4jG0N5qLG/ywacREs0T02d/NPzgM3y36X8uLeJxG7+fi4PCIWM3aHtr1+YalOOWGH9l23B8oA=
X-Gm-Message-State: AOJu0YzWlO0KG2RT/yIMyRmb0gKhx1qgDA/MCIeE37tFHk/wEmF3brR/
 vXZj3JBPc9pXf6ruUVAnMo2xjD2bwfEePPpK02QtaCw009OqVyTddijbK46tuCoypDq7DyzGop+
 J7+vHuFg+clwBcNIGJrH6328nmorfl5X7ta9jkTc8rhBJsC4XSOfp
X-Received: by 2002:a05:620a:70d0:b0:7a1:456b:fd5b with SMTP id
 af79cd13be357-7a14717a82emr494406185a.1.1720798671352; 
 Fri, 12 Jul 2024 08:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKmX4XPVDW47CfdUb35s7fc2JmJEBNjeHjqjmB+q/98Cq5iGUSUyr3avm9abvfLSYXgIuIOw==
X-Received: by 2002:a05:620a:70d0:b0:7a1:456b:fd5b with SMTP id
 af79cd13be357-7a14717a82emr494404985a.1.1720798670928; 
 Fri, 12 Jul 2024 08:37:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f1902bdf5sm410026085a.66.2024.07.12.08.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 08:37:50 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:37:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <ZpFNywuZ3Z-OPH9X@x1n>
References: <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de>
 <ZpAEIvbNr-ANuASV@x1n> <87bk33en41.fsf@suse.de>
 <ZpBAL3U6G46OBGEN@x1n> <878qy7eipf.fsf@suse.de>
 <ZpBXejPa8Vac6ZqG@x1n> <875xtaeq5p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xtaeq5p.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 12, 2024 at 09:44:02AM -0300, Fabiano Rosas wrote:
> Do you have a reference for that kubevirt issue I could look at? It
> maybe interesting to investigate further. Where's the throttling coming
> from? And doesn't less vcpu time imply less dirtying and therefore
> faster convergence?

Sorry I don't have a link on hand.. sometimes it's not about converge, it's
about impacting the guest workload too much without intention which is not
wanted, especially if on a public cloud.

It's understandable to me since they're under the same cgroup with
throttled cpu resources applie to QEMU+Libvirt processes as a whole,
probably based on N_VCPUS with some tiny extra room for other stuff.

For example, I remember they also hit other threads content with the vcpu
threads like the block layer thread pools.

It's a separate issue here when talking about locked_vm, as kubevirt
probably need to figure out a way to say "these are mgmt threads, and those
are vcpu threads", because mgmt threads can take quite some cpu resources
sometimes and it's not avoidable.  Page pinning will be another story, as
in many cases pinning should not be required, except VFIO, zerocopy and
other special stuff.

-- 
Peter Xu


