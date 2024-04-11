Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43FEC001CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 18:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruzNM-0004DY-5e; Thu, 11 Apr 2024 14:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruzNK-0004D0-Ew
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 14:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruzNI-0001hV-RY
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 14:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712860935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DivIzD4Em29Sio/jy/opXbpwrZrIoIWhYjsWr98pzcI=;
 b=CLlYkhlRgpb8cmO2Jjb1q1rf8gWqVWYpQb9rHInmX9cVHTYToTl36MLnQMiN0gnOrdPMas
 vUyYMNXNK5rt6bF088KfZMG/MkJJwAstybHWvJxFCRCYOB2NC5f9pz/0J5jqwji5jJq3G3
 JytZY8D5P4z+Qpec+CXes4WH0gCgQ28=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-lJqgGN4ROcujXTxNFmsKtQ-1; Thu, 11 Apr 2024 14:42:13 -0400
X-MC-Unique: lJqgGN4ROcujXTxNFmsKtQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-436507937ecso206791cf.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 11:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712860933; x=1713465733;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DivIzD4Em29Sio/jy/opXbpwrZrIoIWhYjsWr98pzcI=;
 b=cclNEeqAnd3P4LiBmIGGa6i+gVXcfQo9gQn/WesGB7qn5rQyU5OLUO7uVTbr5dO2Co
 vNLUudGZz2g5cgpxtheDmbmkLHmja0OEDRp/KgqCymglGJPUJ+9So05itl/HZLzXZrMm
 n+cQ4TgB30x2gAyMH5TdJv7zswUijll7cg/vxD+XtS9ezJn5+tIMJ27Jg8s+My/5BE8y
 E3rrb1ZdCmirM8QZiLZSO8x7Ja+qMD6shS6dGuZJMjzlNIC5M8h6Coq35Kp2WkP6ZXit
 JY03cU64pVsr6Q9ityFalSkY1a/BirZe1mAAN9WpgxZOM3HOruf+K+lia2x9nEPRfTM3
 Yc6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzTYzpLgWzrKUdShFdLVbs/0R/OzPPH1ocgqflFPK+4tCG0G4MbQgEjAl7CMTeKEUeRYYWF4B2AllNSkOTeZgDhVrI3bc=
X-Gm-Message-State: AOJu0Yx/uGXMpvhduvaSIf4/0788ROei8S+qXaRraqGb4uIYgr8K16Px
 uSuW2YXQDzVDMf6TZmrz76ygVr3ppm9ZIHUbYlISyqo++DZiQ1gpeFH27ZpjMESx/0eImlHzNSl
 bkP9KMYVhldpfHXDDwMfTnfN2yH9Z5nxhGKkzKwSkvlCDjfXEK+21
X-Received: by 2002:a05:6214:e6c:b0:69b:188a:f32b with SMTP id
 jz12-20020a0562140e6c00b0069b188af32bmr605689qvb.1.1712860932665; 
 Thu, 11 Apr 2024 11:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrEZ5m9pZ5B8YTSK6F5xaw2MYTC2KeeTsEZhWLpzMNDy4KDf2mJ6GNTU42Df4Y7dXO3rt22w==
X-Received: by 2002:a05:6214:e6c:b0:69b:188a:f32b with SMTP id
 jz12-20020a0562140e6c00b0069b188af32bmr605666qvb.1.1712860932199; 
 Thu, 11 Apr 2024 11:42:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 y2-20020ad445a2000000b00696b152514dsm1272794qvu.12.2024.04.11.11.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 11:42:11 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:42:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 prerna.saxena@nutanix.com
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none() to
 use new QAPI syntax"
Message-ID: <ZhgvAicT_36OLEBR@x1n>
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-2-het.gala@nutanix.com>
 <874jc9v066.fsf@suse.de> <Zhan0Brg_CXzt79-@x1n>
 <8621e850-168a-454a-8f00-615f476eac31@nutanix.com>
 <ZhfzMt3t2oU7qt90@x1n>
 <e0f41009-a2bc-4302-82d5-c396d95a5cff@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0f41009-a2bc-4302-82d5-c396d95a5cff@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

On Thu, Apr 11, 2024 at 11:31:08PM +0530, Het Gala wrote:
> I just wanted to highlight couple of pointers:
> 1. though we are using 'channels' in the precopy tests for 'migrate' QAPI,
> we
>    use the old uri for 'migrate-incoming' QAPI.
> 2. We do not cover other 'channels' abi, only have tcp path tested.
> 
> So, the TO-DOs could be:
> 1. Omit the 4th patch here, which introduced postcopy qtests with 'channels'
>    interface OR have 'channels' interface with other than tcp transport
>    (file, exec, vsock, etc) so as to cover different code paths.
> 2. Extend channels interface to migrate-incoming QAPI for precopy qtests

You can see whether Fabiano has anything to say, but what you proposed
looks good to me.

Thanks!

-- 
Peter Xu


