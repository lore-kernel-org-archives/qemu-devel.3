Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD52C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 05:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZOW8-0007Lx-Q7; Thu, 01 Aug 2024 01:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZOW7-0007Ig-Rj
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZOW6-0007cq-4O
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722490701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vvU6MiXagV7sOAqShKol3qt3aDdMNeEYJNvrTNc2CVc=;
 b=IPyqF9NiRA5JzikjQ4Fy5S8rtll6fe2YJgQCDxEXIqYxiGY65dojOfBKxj8zje1i1z2MfX
 IW+vTLRNBW0yBIPocb0XE1bPx6wgYh3isRnY0O3Et80monpDU0pMt0cAfBixEv6TGl3Cap
 Mxzkz3lTGFicGAqSvjFf25oDs2/mN80=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-nD7POfx0NYyj62c_2ugIQw-1; Thu, 01 Aug 2024 01:38:16 -0400
X-MC-Unique: nD7POfx0NYyj62c_2ugIQw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5af95f7d65bso4611948a12.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 22:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722490695; x=1723095495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvU6MiXagV7sOAqShKol3qt3aDdMNeEYJNvrTNc2CVc=;
 b=GsoRp++eSXpClyg/glNSjOFAe3TJNAFGa3OVJ4v8J4+0TV5mO2P5ykXBq/xO+/a9qp
 m/WvKeJsAno3/tHI1o86NT+qo4if9nH8QiMw+GnCSqmgWV2zjZsBQLybrD80lbKCpknx
 QkU/BD64vA36LzRvERVZ6FPBkL1rCusNODkR4n2d8D2B3nGPxi87NtEFjj4kklWs0xLG
 05DqVCLavznISi2w+IAB8UYaIRGMLhMgV0qqV/8K0gbkDZaPKdNjDxaZ2zc3oyYIzhAp
 omtmiukmHr+j2CzRfABWJpT8EFCiBHea8hPKzlWfu8j7LZxz6vINrGsJZNS6jFqvOY5P
 W3Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp4qOKHakkHA7qYmgQqNbY5Mn0fxw5QTqmw9OFFZnxelp1pbsMJZ3fMWQ+l0gk6D4sTk1RcEbrnSp67I4YFdSr1jxqmP0=
X-Gm-Message-State: AOJu0YwXvKYuxF4oNVWIxEU7rietRbNMe3KFwm7JGvJVOHoidWbRPj1V
 qO+BYv1PEKNXsyWm/i7J5gT1sv8b7PoJ0l/HUmCS9MbxVomynxMTqsUBUzP2WrFMIqfxtP7pPKH
 Tjv9BX7a3UeMQ9uap9VEg+bjWNhE8zmWctKF3cM1z1TusaJLqjNWB
X-Received: by 2002:aa7:da4d:0:b0:5a2:8802:8e10 with SMTP id
 4fb4d7f45d1cf-5b6fe72a922mr622352a12.8.1722490695530; 
 Wed, 31 Jul 2024 22:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6bxNVotBbvMWVhZjqmX3NVrat8liDnYJ3dI43Vj6tZtP0JceUp2QTQKU3iW81jlRCbSFjQA==
X-Received: by 2002:aa7:da4d:0:b0:5a2:8802:8e10 with SMTP id
 4fb4d7f45d1cf-5b6fe72a922mr622323a12.8.1722490694669; 
 Wed, 31 Jul 2024 22:38:14 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5af758a6c36sm8038513a12.73.2024.07.31.22.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:38:13 -0700 (PDT)
Date: Thu, 1 Aug 2024 01:38:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240801013539-mutt-send-email-mst@kernel.org>
References: <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com>
 <da9de7f6-da16-4858-b680-0e2ee15162dc@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9de7f6-da16-4858-b680-0e2ee15162dc@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Tue, Jul 30, 2024 at 02:02:27AM +0900, Akihiko Odaki wrote:
> I think it is simpler to analyze the platform dependency and dump it for the
> management layer. For example, libvirt can request QEMU to analyze the
> platform dependency when it creates a new domain. QEMU will then figure out
> that the host kernel is capable of USO and bake it as a platform dependency.
> 
> Regards,
> Akihiko Odaki

I think for starters, we can just have dump-features as a QEMU command.
Pass it on command line on destination.
Achieves the same thing as making userspace pass each flag
manually, but without the pain of teaching management to enable
each new feature.


-- 
MST


