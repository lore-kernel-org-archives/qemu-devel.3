Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B82BE92FE2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 22:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaLSa-0008Kg-7I; Mon, 29 Dec 2025 17:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaLSY-0008KD-0v
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:11:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaLSW-0001uq-Gn
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767046283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=abQIuGVnkPQl727MqNYmLNB8lMqv7+ASsf/FWIKMjmE=;
 b=in8p8+bXhRRcPSQnWFevPKSuigfKeJ+jtw1cUgBmSfZp/lR1mupFamqOBaBLOT6g6Tc8vu
 0ueqL2KCGuYSTN0duWlpC0eUiQVTuofPzs101mWO2jewQGqMSJhv44kH8q27BGAS5q2/RL
 9NvY6e4w7jzjRdqiXgc473TiKq8xapY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-yozoMwf6Oa2Bgd0FSJVMDA-1; Mon, 29 Dec 2025 17:11:21 -0500
X-MC-Unique: yozoMwf6Oa2Bgd0FSJVMDA-1
X-Mimecast-MFC-AGG-ID: yozoMwf6Oa2Bgd0FSJVMDA_1767046281
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2f0be2cf0so3521812685a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767046280; x=1767651080; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=abQIuGVnkPQl727MqNYmLNB8lMqv7+ASsf/FWIKMjmE=;
 b=MiYaEGYiUxj7/cm4h46u6/K0r4nXDhLUWDpPyyd+sskBYfSEXKPaEidMYKQDYnoslx
 DOlzrIwTfVrWx5ZgGQE4K6Zgc2kwfz1UZ3JGo0AVruQia4e8W3qM0+3i+CWgMvf+cmRC
 JYavXC9PScCF6TMvEnklvEYVZCoYJ87VK9x/ZTOxpVCeC9MXFGjRkPazEhiO4F7nXqSc
 S6gK8DTHlpe91hBoyjICPRTwDQztPLS4jsWHOLrG4Q8SU244O2pFD8xUjeJw5/naKgMc
 HN17vSm9ry8b3zUYI8MewmDyVRKh2Kx1gttJdaVGCTKMF18GvNX9pioUjUIOcXAaAJZ3
 pyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767046280; x=1767651080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abQIuGVnkPQl727MqNYmLNB8lMqv7+ASsf/FWIKMjmE=;
 b=mcQLZtJfE+6XpBS+Ec2GGazp+mT6O7CGYwi2bbmmHzVwwmJ+VYx2bWUe0uIOYXf3g0
 z7XyqEOtV3TPUL3f6afosHHcsxE8RfnfRgAP9IMw0Cx1H4ZgOEnZM24sylJmygNCT3r/
 kq6tTZKefOk3lvkNz2p3EzOH6nnRuvgC72UnPRtiXqOsmhSBl7U2mHVY/d+if1gb46o9
 PKcnUlf9AwebqVfZwOJlqX4wQ+wzn636BGOnhzgoN0K+nM8aOONHJwgcCnCsUVkgh9Xy
 GVpJXfqQsYbfGVtkQ74fvpnxGpwwjY7J8g0FcHW7EkYOKtFabNlgQzLmhJ9iV382S1SI
 wMmQ==
X-Gm-Message-State: AOJu0Yxq1VhuyRrUFl+8RyiiFiRxMNS6qMRlQEYnrFhzx03g1v71Ye1V
 hwNBq6937cT1Kba1I6oGS7hADAZuuGkrtFktc7KEB3I+QzqwvDXiEa8Ll262D+28DE68bIBbwVk
 P6ZWn6I2zxL++n6wA6mh27MgHGITIW96jZRFyxvMRuJWobvOBOxl7hmf4Jx6lwszX
X-Gm-Gg: AY/fxX4DWDffDRWPxGX3t94rLSBpvN6sYsYW2OQGLlPJc2yNRtJb1lRCJ9vVeut0KTM
 iP5WaKKVczk4+8cL69I6+BVfIVi4RoSdOVPVYW1f/a9dkbxUviFhTprjil45VnPsWKqGY7BYLCy
 1lDe2iQ87esT0lik5M/r4VIEe/oF8mojOa021yuG3oxrE8YPppnjK6k4dKxScF5fW5Wdnjeo35S
 d/dRvpBcuxqpZn4e8yo+5tBNBTamzbNFfwqh5QmeYT9hYTk946KmczbcXqKWf4nEXsk/kmDl+2D
 IMUH0i9znKQzhp5HfXMb/XH9w/wtkh5+VkgMs3GXMSG84Jp/2NdoPxfcb11N8Gve6iJ4vVfMy2P
 2QRc=
X-Received: by 2002:a05:620a:319f:b0:8b2:3a3c:f261 with SMTP id
 af79cd13be357-8c08fbba6f5mr4523612685a.32.1767046280580; 
 Mon, 29 Dec 2025 14:11:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8mPDmm0WIrllWfrDzKF2mWmrvwCsmWGGIMhn7Fsh/cJJ5s/o6rMt8K3SXJhW7LZUmH4JNsw==
X-Received: by 2002:a05:620a:319f:b0:8b2:3a3c:f261 with SMTP id
 af79cd13be357-8c08fbba6f5mr4523610285a.32.1767046280147; 
 Mon, 29 Dec 2025 14:11:20 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0968913ccsm2525860885a.16.2025.12.29.14.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:11:19 -0800 (PST)
Date: Mon, 29 Dec 2025 17:11:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 24/25] migration: Move URI parsing to channel.c
Message-ID: <aVL8hqV1V64vzX9v@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-25-farosas@suse.de>
 <aVLtyglUqAkT4VEI@x1.local> <87344t7zlv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87344t7zlv.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 29, 2025 at 06:22:04PM -0300, Fabiano Rosas wrote:
> You're talking about the comments not being at the right place? I can
> duplicate them in migration_connect_outgoing|incoming.

Yep, dup it is fine, or just drop them?

Normally we should assume all parameters to be freed anytime by default for
a function.  AFAIU that's the common case.

OTOH, IMHO we may better need comments where the function can transit
ownership of the memory of the parameters... while this is not the case.

-- 
Peter Xu


