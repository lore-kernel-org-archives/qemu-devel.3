Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70615C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 14:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sixTZ-0005Pq-FU; Tue, 27 Aug 2024 10:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sixTT-0005OA-Ap
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 10:47:11 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sixTN-0006Kz-VM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 10:47:11 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c07eebf29eso2512524a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724770024; x=1725374824; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SPch/eNzsSQ9VeLpCCkqrNxJnqZUL+GAu8BB8VjCmTA=;
 b=IepzmDpZUiKFnu1iQWPIc70FHuEJRpbCAd5TyW1ObJN/BPYZJA1WwgiuCmNLHq/Zsv
 V+Kwgx/hRgojL8XQbyxPASRj1OJwwtPk4A39g4svxfKqmNZzroks3p/j8As7Xl1A00eu
 SNeg4ANSw6Jj2BASr6SCA0FeV8c4K1zGekGDNvH1CvzWBi+X+LcHtu3ozZi4L6Uq3UIi
 +8FSqjqqsAH1YeEh3xHzd0hXUzpXLVsFIE5kn++00Pvnjy3qCbonzpoxeVFYm/IvYAUk
 6HQrYTFEGApLY4v03cTzvXfpmQb5FnB29wne8jxy4rWubaxR7oErnpKIEwh0YcTEKZed
 kDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724770024; x=1725374824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SPch/eNzsSQ9VeLpCCkqrNxJnqZUL+GAu8BB8VjCmTA=;
 b=Du0YEsifd3bkTyfJXfv2WG1sKkatAGYSSc1j5Q/CjlKzIPWa7IF53eVhGvUrrfFgjs
 IIukaWg3NSoDpX2UinuF1agXN41ieBahMURNtghrTmhIzg1D19s1TTFOzOaJCbphRy7+
 gMb4NQZnzg9tIfZ95Qt5tEWpmiskSGx2VmQmMMUfAqqAK5CE1mV1OxkKXTeAOI2mTjiy
 25c1h95kXFa9tShL8NrjL1e1LjqVsef32gPDfUxVW9Hq/PzxVr9lFmRhe3QeDUHgQ3yl
 1hNzbwuZkRG/a6LNPzoFEIestex0iFmIceyCpVarMJ7zxb+GvJWC3AEhzy7d5EcHHg3j
 6J2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUAPbKtDGvma9zvvh8h4c4N4g9HSTjNRyjCxj4mc0brLJR/GIDS9pd492UMq0RIar0BV3MCAbQ5Nuz@nongnu.org
X-Gm-Message-State: AOJu0YzmzqbelQisQXSw9jzLPhAhVuCRn1bF7oSxU1v345TTuIAiMlI+
 y+VfgOTsJuuolILXcHkXnXo9jEYkBiOR89ku3hba4yEucg95o9EOOYCSl60ucZlMG6dHuUGv4pK
 dcP+5P9VKf3LXMcZr/wk+/ZjwgU0NOO9eiHmkFw==
X-Google-Smtp-Source: AGHT+IFDGtmo+V0s8AcKCUR1QKO0qFeJyGnFN0HtoIFaNH3tdj/wgWHJREHt8MfaECzzQ8nnEAAyIXTLsjHkzzxExAc=
X-Received: by 2002:a05:6402:5c9:b0:58b:1a5e:c0e7 with SMTP id
 4fb4d7f45d1cf-5c0891b421bmr11634190a12.35.1724770023724; Tue, 27 Aug 2024
 07:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-7-a24c6dfa4ceb@daynix.com>
 <Zsyesfaf02ktFU1A@x1n> <86d9b2b7-505d-4223-bcd0-4e4a7847ec56@redhat.com>
 <87zfoyvzaa.fsf@suse.de>
In-Reply-To: <87zfoyvzaa.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2024 15:46:52 +0100
Message-ID: <CAFEAcA-8peUP-TJW8X3JJQg1p7MKvo2vTZ4HcgrTh+d9T1smRA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] tests/qtest: Delete previous boot file
To: Fabiano Rosas <farosas@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Eduardo Habkost <eduardo@habkost.net>,
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
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 27 Aug 2024 at 15:03, Fabiano Rosas <farosas@suse.de> wrote:
>
> Thomas Huth <thuth@redhat.com> writes:
>
> > On 26/08/2024 17.26, Peter Xu wrote:
> >> On Fri, Aug 23, 2024 at 03:13:12PM +0900, Akihiko Odaki wrote:
> >>> A test run may create boot files several times. Delete the previous boot
> >>> file before creating a new one.
> >>>
> >>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >>> Acked-by: Thomas Huth <thuth@redhat.com>
> >>
> >> I didn't track which came early, but I think Fabiano has queued the other
> >> one here:
> >>
> >> https://lore.kernel.org/r/20240820144912.320744-2-peter.maydell@linaro.org
> >> https://gitlab.com/farosas/qemu/-/commits/migration-staging/
> >>
> >> So we should be good.
> >
> > Ooops, sorry, I think I might have jumped the gun and put this patch here in
> > my final PR for 9.1 ... I hope it's ok to do modifications on top of that
> > later if it is still necessary.
>
> It's fine, don't worry. I'll just drop the other one, they're basically
> the same.

They're not quite the same -- my one also fixes the bug
where if we run no tests we call bootfile_delete()
without ever having called bootfile_create() and as
a result try to unlink(NULL). So if we take Akihiko's
patch I'll respin my patch to be just that fix.

thanks
-- PMM

