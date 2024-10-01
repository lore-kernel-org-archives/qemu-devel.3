Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A19CCEACC6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdXI-0005eY-K8; Tue, 01 Oct 2024 10:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1svdXG-0005YH-D3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1svdX0-0001V0-P8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727791632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2IKp/hgAKRk9lcdxrxyUzTzXKsQG/+we0OoGwiinoI=;
 b=S2r8af/RgaMeU4iKwcmN0zGOvb8b8iipUOg0Yp4XhN86VgrKZc/KsETRO4Rfdx04+nelwB
 WlAua13z827ZV/0OLLGumR7ZpaD7oBI4GlsDcZVFZWJn9su5JvMwoHxt9tIsL8F1MBFnHs
 4BNAGnEWgYn+JdC87sZt+aE9hk2Wg6E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-TAoivW_MO8CX0L5gx88KBQ-1; Tue, 01 Oct 2024 09:27:47 -0400
X-MC-Unique: TAoivW_MO8CX0L5gx88KBQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cb45b4c988so67130496d6.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 06:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727789267; x=1728394067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2IKp/hgAKRk9lcdxrxyUzTzXKsQG/+we0OoGwiinoI=;
 b=oS++lnU9I9drCUWOZBOYKrFzI3SDhARi9UyK7puQcu2B0/j/m8ut+Q+jIB4yzCRcHB
 XeGQSglwJwQ0iLwEtCN6ukGYUjstlv3SN7diBYuVu3RQzglhkWFgwoo4UH9vKGvbjtgp
 TSkStLJmRvBScNyyBDunuiEYixOcjRThEPU4i0ve2Np4nijQF7r2jJW9Fj5xBnrOopsO
 iTzXo2eeuiuLj97zKXhf7HGkdKh63L5QtubQEfQiYaITDViYLmibpUY4K9oV2DaxI243
 u+qaVCWiyJWyHnwWGfSep29kT4GOaU2oTb2uEfsIOaCZUkr05hJH0UZt1aOIseqrdXpH
 d01g==
X-Gm-Message-State: AOJu0YwhEP493aCeGHDhPn5Pf75U6OKuSo+yhGHYeGywarNosgQiYi6O
 nse4FuNNuwqBg2uLI1v4nL68o+PqkXMFK78fF7sohlFPz5ggkfBWPlpVobWbO/AChFB3okMKiR0
 ze7vcqEuFlwo22ZllSUIk1VB46tU8Sz/8xLg4TZFDbsynCE7ihY/ubXLyIEwwuAtRck7XQivY17
 Gp2z0iIOMgLeNSIURZSbmOzGeIsnNrJAanl5gad37R
X-Received: by 2002:a05:6214:3d8a:b0:6c5:73a6:ff37 with SMTP id
 6a1803df08f44-6cb3b5b8004mr266344616d6.5.1727789267124; 
 Tue, 01 Oct 2024 06:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExt98DhAhlxrG0Lx85b9ryB7vLD3C2tss3THgsfIabVXU7zN1gPHQveDHdm2taAXKXuV6A2m7JlDiUsPr6R6U=
X-Received: by 2002:a05:6214:3d8a:b0:6c5:73a6:ff37 with SMTP id
 6a1803df08f44-6cb3b5b8004mr266344426d6.5.1727789266887; Tue, 01 Oct 2024
 06:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
In-Reply-To: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 1 Oct 2024 17:27:35 +0400
Message-ID: <CAMxuvazmjoWNedfh2a=g2NcdQSRjKY2WNcVYkHPfYKpc_1uY7A@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] -Werror=maybe-uninitialized fixes
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Fam Zheng <fam@euphon.net>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 qemu-block@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Hi

On Mon, Sep 30, 2024 at 12:15=E2=80=AFPM <marcandre.lureau@redhat.com> wrot=
e:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> Depending on -Doptimization=3D<value>, GCC (14.2.1 here) produces differe=
nt
> maybe-uninitialized warnings:
> - g: produces -Werror=3Dmaybe-uninitialized errors
> - 0: clean build
> - 1: produces -Werror=3Dmaybe-uninitialized errors
> - 2: clean build
> - 3: produces few -Werror=3Dmaybe-uninitialized errors
> - s: produces -Werror=3Dmaybe-uninitialized errors
>
> Most are false-positive, because prior LOCK_GUARD should guarantee an
> initialization path. Few of them are a bit trickier. Finally, I found
> a potential related memory leak.
>
> Patches missing r-b: 6, 10-11, 15-21

Patches missing review: 16, 20, 21.
"target/loongarch: fix -Werror=3Dmaybe-uninitialized false-positive"
"block: fix -Werror=3Dmaybe-uninitialized false-positive"
"qom/object: fix -Werror=3Dmaybe-uninitialized"

thanks!


