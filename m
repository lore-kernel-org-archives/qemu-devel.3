Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BDEE91264
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 06:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnt5k-0007eH-FB; Thu, 05 Feb 2026 01:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnt5j-0007dt-1x
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 01:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnt5f-00040T-KX
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 01:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770273825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vdyw88tlJi7i6jEzlUBeqdIjHYfbRkrUddcO9CidtNQ=;
 b=Dv/ZcoZA4JBzFz7uTB4/rBRFn6wOG2v6kK+nuk4tQLaJf/5vg1OIMyCZVq+Q0r+tTWNd6V
 T0HFqVWrQ5j5Z5NQE+NnkQPbrdgDVLtO/3GVMwniD1QXA2tCqqbXbnHay7KDy9XbBTuC/8
 nDD1wX1OD5wPgat+SsNubkYWxk4yANo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-VkbAk9LiPwaKU3dj58R8rQ-1; Thu, 05 Feb 2026 01:43:44 -0500
X-MC-Unique: VkbAk9LiPwaKU3dj58R8rQ-1
X-Mimecast-MFC-AGG-ID: VkbAk9LiPwaKU3dj58R8rQ_1770273823
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430f57cd2caso644897f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 22:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770273823; x=1770878623; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vdyw88tlJi7i6jEzlUBeqdIjHYfbRkrUddcO9CidtNQ=;
 b=JRe8rcmWxXkEoKVADdHGIAH12WVIK+LtlsNxjYnNdIbBoVpTTEl+5Qpjp628jG+9O8
 P6TAQUptXlgLU1CJqa6iosBA/uXnhvdaYz1m1KnJRdQka09jPC8DzHNN9XB11AmKukzc
 lmAfZHfeHvYugjMoXBW7WL3NtuJhhuGAK6XLfuJepTQeNFiGOpC5KdEcgzu5GprXBIFI
 r3kOGqvgU+3FJUw8rF6+yVFbAtepcE8tGEn3eARjt6W5WZUrkXTN3qrjUygOLoiS39Ct
 XVUAghzHTZTx5dQX3XOFoM9/xhVTLDTZZ0dP9TX+W0I/krea1xSXOuSEVtx8C/njCHac
 +sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770273823; x=1770878623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vdyw88tlJi7i6jEzlUBeqdIjHYfbRkrUddcO9CidtNQ=;
 b=bIKLyIvIklkwEbsuT+9MiReZMOcgTf/L08h9scdbnSGfjEBfChj3YLUq+l5PueDk04
 8yXgxykKmwk2c6iaRIkdzlHl5g3wcZBG6/fV9y4FSrzolmHy7V9VipTA1IO5eEiiVFVr
 +WOK5hnAkc+ON6oI+iZxk2RZTGc+LIOpKBKE79dST0xL3foZrsFsE2jBmfLcBDnAkbwG
 sLHagNV69pSlJ7Eh/x9P981nuW6SbmcPvnTTujrRJoRxY3EgkUNXCNdickUuHfaKfZrw
 xpNEipvqxTZUJvDQdU86E0OrlxM0aHwRed2e4ghuXaHa/2kXwNGO5CGM59JLiRG4WE3c
 5pnw==
X-Gm-Message-State: AOJu0YwlH9EjSaEjSkmxFdFrQjcOuYCgDEBY+U+wo0e2VVSFP0d8nmNL
 +bHqdva+NMAJdx5v1xXMTW13HY73YkcGDRaoS0SIOnAj8vvs0L8ceEg+PcUW2/ls22R3xPrhSfM
 j+vlpcwl0S1ROhiZ65NY89vf+6dBu3+hSOj3/hJoE37JeyjfaAmlKhe0M
X-Gm-Gg: AZuq6aJc/qFEn5EJU5Fw0VSQdThqMDuNAt3m7qAOYf/o8lCSNC5xg01L4NZHAhTRXQ+
 DnpG31r5rY/hhrTzZrCHeMfP+VVuuUdIhhQ6x1DkCsMA7QqpcZgttdweEze3AV0L7o0p8lN5de4
 r4iboKv7A0ZnFQdOZEJPPw+LUAitWcU9+XZ7cmLlpd5vxpXmSC8psFwN/YxzFVufelEtGzX1rL6
 IE/ykI1FcTsCVcz3yOgAA0TrAIga1Ubqx2x5bvE7BL3/VYCHRhx++Sbggn8kv2jQWUDtSzpHfB8
 L6lEAE2o9yTWg75b9qB+u5UV25Pkg0c0RYI64NWhkCZSfIomeW0GkO3ldkWRs1rOXy0hSmsa6BK
 HxEOHbdIXz0oqfurwZrI4rIXxU/b0Hvh/8g==
X-Received: by 2002:a05:6000:2905:b0:435:a815:dd93 with SMTP id
 ffacd0b85a97d-43618056bb9mr8419002f8f.35.1770273822961; 
 Wed, 04 Feb 2026 22:43:42 -0800 (PST)
X-Received: by 2002:a05:6000:2905:b0:435:a815:dd93 with SMTP id
 ffacd0b85a97d-43618056bb9mr8418977f8f.35.1770273822532; 
 Wed, 04 Feb 2026 22:43:42 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618064844sm11436098f8f.42.2026.02.04.22.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 22:43:41 -0800 (PST)
Date: Thu, 5 Feb 2026 01:43:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v4 0/9] single-binary: hw/virtio
Message-ID: <20260205014101-mutt-send-email-mst@kernel.org>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
 <571ef1d1-88f1-4f4c-9800-00f114a85e02@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571ef1d1-88f1-4f4c-9800-00f114a85e02@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 04, 2026 at 09:27:10PM -0800, Pierrick Bouvier wrote:
> On 2/3/26 12:56 PM, Pierrick Bouvier wrote:
> > This series eliminates target specifics in hw/virtio and replace them with
> > runtime functions where needed.
> > 
> > Performance has been measured with this automated fio benchmark, with
> > original instructions from Stefan [1].
> > 
> > $ git clone https://github.com/pbo-linaro/qemu-linux-stack -b x86_64_io_benchmark
> > $ cd qemu-linux-stack
> > $ ./build.sh
> > $ ./run.sh /path/to/qemu-system-x86_64
> > 
> > [1] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/
> > 
> > Results are on 20 runs and expressed in kIOPS:
> > reference: mean=239.2 std_dev=3.48
> > with_series: mean=238.5 std_dev=3.46
> > 
> > Performance is on par, and within standard deviation.
> > 
> 
> Does it look better to you Michael?
> 
> Regards,
> Pierrick


better for sure. is there a reason you dropped stefanha
from CC? he suggested these tests...

-- 
MST


