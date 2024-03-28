Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CE7CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 19:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpvcN-0000Mf-16; Thu, 28 Mar 2024 15:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpvcL-0000ME-CG
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 15:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpvcK-0005cT-1m
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 15:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711654851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80z4mjXoqEv2wjelgK9GkjtZn+baQQtzB/o/f+u7mgw=;
 b=LO8/hj64mslFprVJL2S258btArCyS6WrSWQRyeNiiOZ/TeyLsr0jUxlDM3zGxzMILhmk0R
 +Ek2HzMF0bwyzYNWeTK5W9C4BASUtl+bBGGnIGeKJ0D8u8uOSpNGBlEDcqGJnZFRVJWDo9
 TIlCXx+lzkfMcjkZwVZp6G85x794yiY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-YfM3NBklOAa2b2OCJxNBqA-1; Thu, 28 Mar 2024 15:40:50 -0400
X-MC-Unique: YfM3NBklOAa2b2OCJxNBqA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4311d908f3cso5872681cf.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 12:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711654849; x=1712259649;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=80z4mjXoqEv2wjelgK9GkjtZn+baQQtzB/o/f+u7mgw=;
 b=wpnziHkctO+EpKMXeRF4DQdz8jX+QWVqan49bRhnxtKhwYYtD6C3pZm205xGGyiY/Z
 ib0bbSjvSvZYPlE8IBzqzA1XW8wrjaGolz5G8zgSmNcnKcFQ6zb36Ixf8ObIDAasACo/
 RoR2QiaYmIzHomRtdaLXy+vMv3VQBPg01eq344tkAyQx6PuIaItpurobNU9jRHG+nSdi
 yYAfThXJevbY4qOZAGjFdMsgbjPIKfkVAXgSjsq0TkPz2v4qBGtpm/IDhCUuBMoCaiZQ
 iJ/4qNmLdOxrmK8fqMDMHaUx75ebFtbXEru3rfYUCq4EYstRSVAY2GVfmBTycJg0nHKI
 wlNw==
X-Gm-Message-State: AOJu0YydgkBgE2yjycaiM5mfDVKihM6fHaWvIjyTsSUXEuO20EsM3/p3
 un969tERU5PTFVuKB2NHZQZjXyshUFTyw5KUYlQU0VbP+dSbAqVDzGIGdWfow0rjPtWUBBJcHou
 70MnhbUsNT/oHI5XDVL3xbTNTWYYfODEh1XvaDW4v1Us7FTjLat9P
X-Received: by 2002:a0c:fad0:0:b0:696:9892:fe29 with SMTP id
 p16-20020a0cfad0000000b006969892fe29mr191830qvo.5.1711654848690; 
 Thu, 28 Mar 2024 12:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRZL2FmUdrGEmnEjQHd5lYfsrhGPNYicuYys+mCM7UFU9t1JBFNBUxQQXfULYWKSxWrgaSXg==
X-Received: by 2002:a0c:fad0:0:b0:696:9892:fe29 with SMTP id
 p16-20020a0cfad0000000b006969892fe29mr191802qvo.5.1711654848154; 
 Thu, 28 Mar 2024 12:40:48 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 jr12-20020a0562142a8c00b006986fd6c92bsm735284qvb.119.2024.03.28.12.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 12:40:47 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:40:45 -0400
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
Subject: Re: [PATCH 15/19] migration: fix -Werror=maybe-uninitialized
 false-positive
Message-ID: <ZgXHvTQ6HIonyVrn@x1n>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-16-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328102052.3499331-16-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 28, 2024 at 02:20:48PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../migration/ram.c:1873:23: error: ‘dirty’ may be used uninitialized [-Werror=maybe-uninitialized]
> 
> When 'block' != NULL, 'dirty' is initialized.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


