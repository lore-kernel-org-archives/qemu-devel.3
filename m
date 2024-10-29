Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DF6D3A660
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 14:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nHO-00059Z-PT; Tue, 29 Oct 2024 10:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5nHK-00059D-JJ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5nHI-0000yP-F0
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730212377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfU/UJizFK2GEOJbpCoKy5yEms3LV902fT+SBP2fBcE=;
 b=ImRPtaaJxR8IOaNVio3O6MYjrnM1cL6K+lJxrVNKpyQT2/6UiYUGUismHqmBQRhL/vztL8
 DV4RPaN7IhKTNsT+KYd6KqRN1P4o4xYRo7c1YJgA6a49IQ02eaNcKgZt2QkdlX6E5tebw9
 73dm95sAR8yYT7gW2omRdHuaS5EsYtQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-B_aHA7NiPO-d8Z6-0PChkA-1; Tue, 29 Oct 2024 10:32:56 -0400
X-MC-Unique: B_aHA7NiPO-d8Z6-0PChkA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b147855414so968500585a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 07:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730212376; x=1730817176;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfU/UJizFK2GEOJbpCoKy5yEms3LV902fT+SBP2fBcE=;
 b=uSXe9GoIHsBGElqBt9Z4cGjovIBisJg7vBV9uIL4FAkMZnL9VDm2vqeCb4zLYS20K1
 6WvSd2q4R1Jt49WMs6tYmiXvplmJgVvrap+ky39cZhotsq3B4M1Y5Di+Fmmwm2xCwtTv
 GplVz1+8J5bqqEx9udzY8SeItqHew8nTKrLU/OvOpuhLMHae5VDhDlvAD76iPeUG2EdC
 6L77r7wZvvq4QiWSv+uwi2Hvm3Cy9ZTYy2VfRIYpFfb/vH6HFpr9Q3Cf+wHBWTnCxBaK
 Xa2JdNyAlkU+ZYsXmCx7E8NWOPisx6pHZyZeDLddX+9EDHVjPchpqaxwDWeCLuA6MwOT
 IkcQ==
X-Gm-Message-State: AOJu0YxIxf1lFUUpk1WovK2YVA//xbQNZoLScvSJ4kqfMLF8iZQR/GW0
 zasugbHnZg7O9/1rz+6jcnGqT5cZwyPtaALTR1Lr8y3OVID9NuDU8AD/ITSANh7l6A4oVxAa0g/
 uHa2wR1MxQlIcTjdsgBNGiklMmD7sJgPsx7Q+PidehyC1BspR7TLo
X-Received: by 2002:a05:620a:462b:b0:7b1:4fe2:a32a with SMTP id
 af79cd13be357-7b193f5df02mr1734292885a.55.1730212375818; 
 Tue, 29 Oct 2024 07:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExYwqTrKvfFVFhi8JjdN4aeV3TkQQRzLZp+y3qXt5/HS3I1BvFGOAAHUJTm44ivoVkXSoraQ==
X-Received: by 2002:a05:620a:462b:b0:7b1:4fe2:a32a with SMTP id
 af79cd13be357-7b193f5df02mr1734288685a.55.1730212375392; 
 Tue, 29 Oct 2024 07:32:55 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d32a5c1sm423504485a.74.2024.10.29.07.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 07:32:54 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:32:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/4] x86/iommu: Make x86-iommu a singleton object
Message-ID: <ZyDyFSZDR5uP7_gG@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-3-peterx@redhat.com>
 <ZyC9KsmomvRAP1EP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyC9KsmomvRAP1EP@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Tue, Oct 29, 2024 at 10:47:06AM +0000, Daniel P. Berrangé wrote:
> On Thu, Oct 24, 2024 at 12:56:25PM -0400, Peter Xu wrote:
> > X86 IOMMUs cannot be created more than one on a system yet.  Make it a
> > singleton so it guards the system from accidentally create yet another
> > IOMMU object when one already presents.
> > 
> > Now if someone tries to create more than one, e.g., via:
> > 
> >   ./qemu -M q35 -device intel-iommu -device intel-iommu
> > 
> > The error will change from:
> > 
> >   qemu-system-x86_64: -device intel-iommu: QEMU does not support multiple vIOMMUs for x86 yet.
> > 
> > To:
> > 
> >   qemu-system-x86_64: -device intel-iommu: Class 'intel-iommu' only supports one instance
> > 
> > Unfortunately, yet we can't remove the singleton check in the machine
> > hook (pc_machine_device_pre_plug_cb), because there can also be
> > virtio-iommu involved, which doesn't share a common parent class yet.
> 
> Presumably the 'class' reported is the one that the user requested,
> but this would imply if we were to do
> 
>   qemu-system-x86_64 -device intel-iommu -device virtio-iommu
> 
> Then QEMU would report
> 
>    "Class 'virtio-iommu' only supports one instance"
> 
> at which point the user is wondering, huh, I only requested one virtio-iommu
> instance ?
> 
> IOW, the current error message would be better as it is not referring to a
> specific subclass, but rather to the more general fact that only a single
> IOMMU is permitted, no matter what it's impl is.

True.. though IIUC this is more or less a cosmetic change only.  E.g., if
we want (assuming after we could have object_new_allowed(Error **errp),
checking both abstract + singleton classes) we could make the error points
to the base class (rather than the top class to be initiated) that declared
TYPE_SINGLETON when it failed due to the singleton check.

One step further, we can even provide a custom Error for any singleton
class to say whatever it wants if it hits a duplicate.

So to me it's a separate issue from whether we would like to have a generic
way to define a singleton class.  I am still ok if we want to avoid
introducing the singleton, but just to mention I believe it can report
something similar as before if we want.

Thanks,

-- 
Peter Xu


