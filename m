Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F75EDF04B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 07:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQiE-0000fQ-1m; Thu, 12 Feb 2026 02:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vqQiA-0000f7-PK
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vqQi8-0003Ho-Ji
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770879718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gzX/XQt7NjFBonUTFTZowD1NIh1wMSAwGIzcxbXnn4U=;
 b=EccRsKy+j6eFotFLpu8/UssdRLDmsUJ8mZ94sXX9xDv3CdzhMPqN4ULPdReAd86ox+1+vB
 OungoMf85OgQJkDJsLJ0swiUhnQA58uQeGsOZ3IAtzIYgoVPLAPiT7PHYW+peqMWUkRgiG
 ifIdOH5amUK+//KIvqnjbAPd8p4tCig=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-23GHQ1WiNNKPMHNoKBfKfQ-1; Thu, 12 Feb 2026 02:01:56 -0500
X-MC-Unique: 23GHQ1WiNNKPMHNoKBfKfQ-1
X-Mimecast-MFC-AGG-ID: 23GHQ1WiNNKPMHNoKBfKfQ_1770879716
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-480717a8ef9so14885615e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 23:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770879715; x=1771484515; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gzX/XQt7NjFBonUTFTZowD1NIh1wMSAwGIzcxbXnn4U=;
 b=IWeZs7//5pylSVMy2hSAVF4w69Jo5zrvX1ksi5TmqTnlwopsXq8OGjonsNeQ4HFhd4
 evBi/cv+5zMF4NMUaH22ejG/gd6RsgzgLEccA1JI8XdqkCf1FQyGJHR2lznkoGDNYtfE
 gxNvk0QiyO64unEnESYI3BzwPcICyusRZiN74qNPqe7gnZHHcZ+RBEv1Iae5tRL7gpR2
 W8tpIRkXt/L0LnCbbtITfmKJ5aiak/pYOfOxBRP2sAn/3zfKqMVRvaBUcgNXVzYbx7xz
 P5KzaGflyaeppL6LQagPY5kfhluVuFuaCfjCXpEaC436rg7uPsJssy7nO2Jb0MhUSody
 VusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770879715; x=1771484515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzX/XQt7NjFBonUTFTZowD1NIh1wMSAwGIzcxbXnn4U=;
 b=utSAosdv4hzQGqlXk0eOj9PQ8wj9KdjeET0Y7bHVbhfIhiNOSIwwm+MwmIY/fWMwXL
 I7Esbhkjmc/j1hvfNaAzaBo4rD3mrcHfyhuExzlyPysdg97iZnhdridIkPaUR1abQhgI
 EWAGisyC7XQe75RGj5XrB8sK1EAwWPK01bZp5xSstGffJH1uzShLgaW9U5DqBBiXCueM
 tLaQ07WFH0uJhi5mB+Q6XCnkDoAsqiyfWbGVYTl3UwIi84jp5gA1Ge4N7h2QBITsf7UC
 yCgraYnvL8TGgK5JqkRB6DQ18q3LNyr0UqrDCqbbci5Y9wZgy2vOivSUHppR97N909/x
 sdOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIDWnN/cUDO1UrJBFod/t8599NpVUoZNbOLAEU2IrbNoVsVSe1n4R5iyLJPmS9dzCDK2obhsYttQn8@nongnu.org
X-Gm-Message-State: AOJu0YwnoXw9lhQs1zCzU9Mko4HdDMhOu6q9q7nauWoI1JitnmTCL693
 jWqyK7NI0sRz00RjyucqE5Nl3+7F7vXpsjRguzrJsHjepwdUhJYdvvtJ34IKcWAWjdfvUGTzAtV
 DE8MufwQ2j7cTIijnSUZ6IA/KR6+AmuOKdvnaT+sdb5hOJCbQG/Uil9W1
X-Gm-Gg: AZuq6aKPjUUPbcEoaFuWhAkzEiozIdpIyV/xANk777lZ8a9Cdv9JI34+X9yGc3bUBXD
 m9+JdDQJxqK7NWk0hQ6o+Jnmt0WpA8/h/9N6gl95t3Y1G8Wm7L2mW5qYcGE7vDNsLL07FbPmm4c
 7/5IW+XwqYbhSvNcfr7U3Rj/EIbGayow9evP4iK6od9B1Psc1tu7n6iOzUwCGb0MO6uV7eqLxxb
 BbhfvI3nCVX8c4hm4AAMswKfGIXBza8lWhGs7UtNy5lHXnUZuiVHff5R1WMspn8+XXQGrz8Mus0
 1uaBMmF08UaNacMIn0ZjNMo8SYOqvTKheiX+CCpvP0Jf6nFmK5IYvqzChcvYnjZu3LBOjPkuleS
 euGrA0IvFpvRB8h7TgAtnwvltjskbL2yI5VRTU/7w2le6fA==
X-Received: by 2002:a05:600c:6a18:b0:477:991c:a17c with SMTP id
 5b1f17b1804b1-48365fe5a1fmr12907705e9.6.1770879715394; 
 Wed, 11 Feb 2026 23:01:55 -0800 (PST)
X-Received: by 2002:a05:600c:6a18:b0:477:991c:a17c with SMTP id
 5b1f17b1804b1-48365fe5a1fmr12907265e9.6.1770879714979; 
 Wed, 11 Feb 2026 23:01:54 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836131d4bfsm24327265e9.23.2026.02.11.23.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 23:01:53 -0800 (PST)
Date: Thu, 12 Feb 2026 02:01:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Joelle van Dyne <j@getutm.app>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
Message-ID: <20260212020117-mutt-send-email-mst@kernel.org>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
 <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
 <68223045-effa-4319-817b-1a31f227c081@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68223045-effa-4319-817b-1a31f227c081@collabora.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 12, 2026 at 01:53:09AM +0300, Dmitry Osipenko wrote:
> On 2/12/26 00:32, Joelle van Dyne wrote:
> > Yes, it does seem like v1 was picked up and not v2. v1 was broken for this
> > reason.
> 
> Thanks for the confirmation. Most likely you will need to send a new
> version of the patch fixing the applied one.
> 
> -- 
> Best regards,
> Dmitry

applied one was v3 according to my records
but if it crashes pls do send a fixup.

Thanks!

-- 
MST


