Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33226CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ixp-0000Ec-5x; Mon, 29 Sep 2025 14:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3Ixh-000061-PV
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3Ixd-0008VF-1h
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759171852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2T46oBtKfdonChCzSmqbGwDPEoRXX3pq98lv4JkfMw=;
 b=LM3XaefEJDLI49i7m2Ga2+0w7MEnXehZwW5fjo5bM0wgbABmRe88tsiLt07VIA1scqEC+u
 Tr4XJKOw/lLRwwlV78GSi/4gVy9v32tO2olH43Aawj9gU6FFpGMx3KchlKKhNQCoIBIh/k
 7W3VMRnOVcEO6OYFuQRKakyJsg4/Tdk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-g7p5QzuaPhK4uxh3Ynynaw-1; Mon, 29 Sep 2025 14:50:49 -0400
X-MC-Unique: g7p5QzuaPhK4uxh3Ynynaw-1
X-Mimecast-MFC-AGG-ID: g7p5QzuaPhK4uxh3Ynynaw_1759171849
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-79390b83c48so90304096d6.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759171849; x=1759776649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2T46oBtKfdonChCzSmqbGwDPEoRXX3pq98lv4JkfMw=;
 b=XkCbkCCA2AuKxYqJQQ16bXPcJmEB6nALb4VpFwBqMc1Qtb8BRbdpa5/uVry8nRBpG5
 faiStYi+tSVOezRaioLOqAlTJmNpukf5cTk6qM271/3qMmoINGEfNGSbub17aVE1L+m7
 F0i3/KwjPPm+g5lEdUias1+2YqFMtIyuiBG2kIf2JbO0zokzdEhWgIE03CIMoQqW8VCs
 1F//Ds1QemLFcRhoG6wGrjRAb1khe7lFX1B6AD2BQYnZLGMdSAOREpkmbNnvkbpufGCG
 KDJKZiuoxbUTBkKJpZtqWGcAYvKQmYDrpximWmQLJC5KG/aE3awRN60J4W7mQUgMIjlH
 mjKA==
X-Gm-Message-State: AOJu0YzrW4exPCHyKbbW9tI+xu3H04kTwUBH4vZKIGL6CDGCuW0EC73E
 XVPQyTHOCa4QB11tschDG4G+f1SeT6qP1EZVNkHyEe6Ry081MS7p3wFVGkP0JUEiPOxJgQJzLLq
 2/orvjEI4LMlYbLEX7VH68+sK8l5SDiXdEYRWTYecXbpMv+F/MCgi7mRN
X-Gm-Gg: ASbGnctL0JR2+8Dheps5j8rq5xLxjcc8J0PQtxuToQvLXtOD4VJLvlIFGfpKM0WqYjU
 RObmGt4UQ0Tha37NU17NOTFTz4tDAFo2KG+udFZT+WDBaQBd0lZFBdVbBAqmL+vS5J7+FKKP8GM
 qffZbwhJsyaw/1cEUqOXJFibQp7nv/RQpb+Xu8p0b8TG1VUncSSgvkk03u7cUTPIBEwK2uqLVpU
 IwqM/aIyL3hKbkDmikMCZ2Oc35qq8+9OvkBEdrd9HNFVCKwn63XmxklvQxCibi8a3WqlJfeSXKl
 g19/myfTC6N8+A9jCzOqq6r59kuE3TxB
X-Received: by 2002:a05:6214:20c5:b0:815:7c28:99c3 with SMTP id
 6a1803df08f44-8157c289b1cmr185138386d6.9.1759171848681; 
 Mon, 29 Sep 2025 11:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXRWNmzKkgguzyUsmPfW6xZjVwL/QhFNZfy1Pyaq3MOWCwma/mrX2zAe+d/TJyBZbb32+cvw==
X-Received: by 2002:a05:6214:20c5:b0:815:7c28:99c3 with SMTP id
 6a1803df08f44-8157c289b1cmr185137776d6.9.1759171848150; 
 Mon, 29 Sep 2025 11:50:48 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8013c742a14sm81236526d6.22.2025.09.29.11.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 11:50:47 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:50:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v14 25/27] migration: Rename post_save() to
 cleanup_save() and make it void
Message-ID: <aNrVBYf4FP82ZTha@x1.local>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
 <20250918-propagate_tpm_error-v14-25-36f11a6fb9d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250918-propagate_tpm_error-v14-25-36f11a6fb9d3@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 18, 2025 at 08:53:42PM +0530, Arun Menon wrote:
> The post_save() function call is responsible for cleaning up resources
> after the device state has been saved.
> Currently it is infallible, and does not return an error.
> 
> It is called regardless of whether there is a preceding error from
> save or subsection save. That is, save and post_save() together are
> considered to be an atomic logical operation.
> 
> It should not be confused as a counterpart of the post_load() function
> because post_load() does some sanity checks and returns an error if it
> fails. This commit, therefore, renames post_save() to cleanup_save()
> and makes it a void function.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Arun Menon <armenon@redhat.com>

I'll need to drop this one patch because it breaks Rust.  Please feel free
to send it separately or just leave post_save() as-is for now.

PS: IMHO post_save() is still a good name to me, pairing well with
pre_save() and all *_load*() functions too.  Dropping the retval should
already imply it cannot fail with/without a name change (and also because
modules can do more than "cleanups" in post_save()..).

-- 
Peter Xu


