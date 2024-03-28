Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6167BCD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 19:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpvcD-0000IP-4p; Thu, 28 Mar 2024 15:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpvcB-0000HZ-DI
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 15:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpvc9-0005bw-Qi
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 15:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711654841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyGZSip86QClwc8hyXOW3Un18Pn8QOunKcRVQZzKt0I=;
 b=fsBvBgmbioPU+lezqOfsdCCJeJ2NJqNY3S5JWx3lRu86ts0zHZsVygqcV0jGomxy3v20+W
 SmPsU+9q9S55i9SDgBoElrHpKb3EtiEOAqpHaoMkjrPcv3pvsAcYRK43AdaSgY2rCXvVBC
 0r6DZPSDOK7xKaIbNv279N1daLwsFAU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-6btIFlWmPtKCTa1JTAW3Yg-1; Thu, 28 Mar 2024 15:40:39 -0400
X-MC-Unique: 6btIFlWmPtKCTa1JTAW3Yg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-690ab2b0de1so2413336d6.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 12:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711654839; x=1712259639;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SyGZSip86QClwc8hyXOW3Un18Pn8QOunKcRVQZzKt0I=;
 b=UavxcGBIQEJlBPYpQEfQqLuYafRbwC1f7JuWPvJ2oVk5gslLVTOvczq1SWYJV+27lZ
 Em/qbMYQZPaPqnIFfocVKcDbTQWca3tBhXrhB+xCjN20YXVqoW9iVS61k+JdGGdQotPO
 3Uqy8rrjgrnmA7eJ3fBkmbcjMb3FYuweUuyFfiJAy+8O3UFAt6/f6rcH4daz/QK2n6lI
 mclb4oVCXnIGEynMiVNBkuVn3KnrhENXKEC6YtGbZrTAFIpZCZMP3W2lhM7e4KOqhucY
 Uq1xwafFISD46qoWOMtb4WWaEEPI2GrPgic6j4zGvgHHMs6ia9DZtfZIu8hoqyrJaKSj
 Dt6A==
X-Gm-Message-State: AOJu0Yw4oe5RWwyCxVLuyrvpzWvoGvbr4+noUD3U11tPMJHjpGLt/ph3
 8w/Jt7yVKV/LAGNG6LsrwqTCT4iDZF7IXAE+PIp2L4blLj5yl6Twp52bhnGgaaaUnIyZOGkAySK
 g89Qd3DNtq1Y2p33CgQOo+7RuEqV8xFhGfoLFyqF6mXppfTqqU6cP
X-Received: by 2002:a0c:f3c6:0:b0:68f:e779:70f2 with SMTP id
 f6-20020a0cf3c6000000b0068fe77970f2mr205783qvm.3.1711654838877; 
 Thu, 28 Mar 2024 12:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfUS2YFCAR0k61ys3a97H2y/Vg4wcRMCwPHiEpLNCY9VP7PEqnLvSyPquZ58mLD0bfWgJ5NQ==
X-Received: by 2002:a0c:f3c6:0:b0:68f:e779:70f2 with SMTP id
 f6-20020a0cf3c6000000b0068fe77970f2mr205752qvm.3.1711654838404; 
 Thu, 28 Mar 2024 12:40:38 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 t7-20020ad45bc7000000b00698b0639689sm443813qvt.11.2024.03.28.12.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 12:40:38 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:40:35 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 12/19] migration: fix -Werror=maybe-uninitialized
 false-positives
Message-ID: <ZgXHs01HR5GSsCys@x1n>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328102052.3499331-13-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

On Thu, Mar 28, 2024 at 02:20:45PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../migration/dirtyrate.c:186:5: error: ‘records’ may be used uninitialized [-Werror=maybe-uninitialized]
> ../migration/dirtyrate.c:168:12: error: ‘gen_id’ may be used uninitialized [-Werror=maybe-uninitialized]
> ../migration/migration.c:2273:5: error: ‘file’ may be used uninitialized [-Werror=maybe-uninitialized]
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


