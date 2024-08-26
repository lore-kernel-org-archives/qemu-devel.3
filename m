Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE171C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 17:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sidEy-0002x1-Pr; Mon, 26 Aug 2024 13:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sidEx-0002v0-BK
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 13:10:51 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sidEl-0007TA-Kg
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 13:10:51 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5bed83488b6so5209559a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724692237; x=1725297037; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6j6wCzuylx4sX4t4AEo3xeCNXI91fvCAnPC9hv//bq4=;
 b=KbwmNCO0JglQnr/8IYtZAFByyZN0KDNn6gSlii3S4QqKNRn3llqD55+tDFp+pbfJJ5
 jF5RvX427YgjEGQlzTciHOnvi+E2WxgYUiBd65GtorE+c2An4uCjOw9WDemf6i7fM+2O
 vYj5Tb66gYaQws/kB+ANr4pf4oCwjikWhP94tNNWTQxCBUAJixKxYsv5nnnbduYLhsZQ
 oWad2372wwZbEXTVyLzoepMTJsL961Qd3rcgTBhlRN3oaBI63hBfRvlWoxbvMnkiEn5S
 5M/89lTnFJGUGDfRyf5J3NfEYlXWYys8jIUyhHrcXfGXBbeJ3uZHZF1CTtY0pd5Yo4p+
 FW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724692237; x=1725297037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6j6wCzuylx4sX4t4AEo3xeCNXI91fvCAnPC9hv//bq4=;
 b=DhGEs7VLN/hLn957MfmVYD23rv+tUn8PbcEDsla7UoLGKu4NY57nfM2Tn195981agO
 f2szVz8XSh3sYb0e4hAexNmLYWdu+XClRkA54GY5xXxTJUl2GiJ4fRS+Bb8mVsL9gg2I
 cDtyvFAVwlStX483K4hwGT/e2xzt72iLH5FEXN/1ni4xx3+iS1vV//KSVlCFM8UQDV01
 a+f61WHqjnMjY/45pyPov1tC4FapflyO2CyboWQebz5pUGPK8QASUn7IZKjaBJGHZ0Hz
 79A/GTND3EB8TIljwormcUpB1DvLIYaknrZydZkv4g/03N4E29Pvps+MK/0HDHgULDVw
 hA+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUInltLm/c2urRiuO2aMXu3LJb7X5pl3q6Jp3ORNkH+OQOIrUJIsGqO/npjx4zIDUeb7X6zVG97LbfP@nongnu.org
X-Gm-Message-State: AOJu0YwcCspn1TffSrRTfa2cxl4KaIbyd7SeFXDcgZa6vq89Z6LVdf9g
 +P0zrDB2TfEIZ6RMx07YTELqHgZMT49ugmppPfPVZtMYEOoJJObSggMT7CJBpGrER2VY9dL1SjB
 fxQBGy/5IlAuNSw29iY+RpeyfMe3jve2PrU0StA==
X-Google-Smtp-Source: AGHT+IGxhY3D+GliDYvugUm/rOXOFebRnr66r8ZdYYOJi+mi4pG3rCzySCo8I1bfH0kVNgJjL0DNPij2bAaYHlbf17s=
X-Received: by 2002:a05:6402:35cf:b0:5c0:a8b1:a1f2 with SMTP id
 4fb4d7f45d1cf-5c0a8b1a660mr3671735a12.7.1724692237329; Mon, 26 Aug 2024
 10:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-6-a24c6dfa4ceb@daynix.com> <Zsydli9ME1u79A9X@x1n>
In-Reply-To: <Zsydli9ME1u79A9X@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Aug 2024 18:10:25 +0100
Message-ID: <CAFEAcA_uT3Db22V=Anqci_k6zOaAV7Qua2S1OVFxW_DQyh3bAA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] memory: Do not create circular reference with
 subregion
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Aug 2024 at 16:22, Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Aug 23, 2024 at 03:13:11PM +0900, Akihiko Odaki wrote:
> > memory_region_update_container_subregions() used to call
> > memory_region_ref(), which creates a reference to the owner of the
> > subregion, on behalf of the owner of the container. This results in a
> > circular reference if the subregion and container have the same owner.
> >
> > memory_region_ref() creates a reference to the owner instead of the
> > memory region to match the lifetime of the owner and memory region. We
> > do not need such a hack if the subregion and container have the same
> > owner because the owner will be alive as long as the container is.
> > Therefore, create a reference to the subregion itself instead ot its
> > owner in such a case; the reference to the subregion is still necessary
> > to ensure that the subregion gets finalized after the container.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  system/memory.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/system/memory.c b/system/memory.c
> > index 5e6eb459d5de..e4d3e9d1f427 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -2612,7 +2612,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
> >
> >      memory_region_transaction_begin();
> >
> > -    memory_region_ref(subregion);
> > +    object_ref(mr->owner == subregion->owner ?
> > +               OBJECT(subregion) : subregion->owner);
>
> The only place that mr->refcount is used so far is the owner with the
> object property attached to the mr, am I right (ignoring name-less MRs)?
>
> I worry this will further complicate refcounting, now we're actively using
> two refcounts for MRs..
>
> Continue discussion there:
>
> https://lore.kernel.org/r/067b17a4-cdfc-4f7e-b7e4-28c38e1c10f0@daynix.com
>
> What I don't see is how mr->subregions differs from mr->container, so we
> allow subregions to be attached but not the container when finalize()
> (which is, afaict, the other way round).
>
> It seems easier to me that we allow both container and subregions to exist
> as long as within the owner itself, rather than start heavier use of
> mr->refcount.

I don't think just "same owner" necessarily will be workable --
you can have a setup like:
  * device A has a container C_A
  * device A has a child-device B
  * device B has a memory region R_B
  * device A's realize method puts R_B into C_A

R_B's owner is B, and the container's owner is A,
but we still want to be able to get rid of A (in the process
getting rid of B because it gets unparented and unreffed,
and R_B and C_A also).

-- PMM

