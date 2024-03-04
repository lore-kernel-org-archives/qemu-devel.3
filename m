Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD7DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 05:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh0m4-00019J-Pj; Mon, 04 Mar 2024 00:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rh0lu-00018P-EC
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 00:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rh0lr-0005MQ-My
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 00:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709529709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tLuY6z6eSqKo2kxz8rTsZHrCsC4uXixTekkf26Wge3A=;
 b=hIoyggQZInxpVKOWD1+Uuj4/Vr6WQ4aQhpU7H6yrbYpv9q0x5vQjFutpJbKLHjTKmSX6QH
 XS6ZXFeO3LnmvNj9Cd7VXpirtKFQIh0HfLHAvG7d2Ky4Hx42i3YXvgf/f4Z7WDJcmbR4SN
 a8l6Los29lAL4hIasrCE6t+oZbKfQzE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-VuTqFIG2M6C19l3q4QrjJQ-1; Mon, 04 Mar 2024 00:21:47 -0500
X-MC-Unique: VuTqFIG2M6C19l3q4QrjJQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-412e355e2abso2949885e9.2
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 21:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709529706; x=1710134506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tLuY6z6eSqKo2kxz8rTsZHrCsC4uXixTekkf26Wge3A=;
 b=weKZtv4+PT9BO/3x+sskg/ZqvoPZaesJdx0N2ULpGLwmb2/WAm0ExBKROGG6O3eR+2
 vKe6IGr52SRpmVUReZFix0BZL/yk/mdREFidiXhwk3AEpm4qBvEx2zS3iQcwdGutMJ+H
 dDnRiB10gVJZVecJ3/qYHm2xayKL8CY77r2W66TSSCNTdRsG/EaxGFeMUDHL04dlA9ip
 nNOFUTdszvw59JF3492SC2aDBkTRTULlWqRq6t5mJJdf2T3yakED/3cm+SxI4rpDvay+
 xDvMZIrseCVPPWxd6HCXpK+R4BBOLDcUc999/1AEMciGMxuATiliD/MmTr0GkyW+BLEo
 TJXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSQeXx8iU30gfXlcSz6/IcTqz8AbYNSq4ROwcb6mvqh7YrnuU4BRkbhjqqh3hm/bCydK8aG/sya2l1UvDFTqtMEkdWN5U=
X-Gm-Message-State: AOJu0Yx4YzkxxiYnpkrmzSDO1G3adR5gbjJDr61KUICGl0j4Vfzb3Jw3
 vBh/14CEszZrGwXt2n3C49OByStyGI/jxdCG61zvFwbKRTt5CGy5ITFE7+bTzgx2If2TFpUkIB/
 fqy4BFZ50GJS+1Bw7b/YHBkSQtckPnmoF7kMU0NV4OXM+T273+OMcp71jxmc3PJWA86ZEQw5mKg
 AVeq/3Ug9b0k28ybIOSy4SEX82GqQ=
X-Received: by 2002:a05:600c:3107:b0:412:b8cf:150b with SMTP id
 g7-20020a05600c310700b00412b8cf150bmr6468792wmo.10.1709529706691; 
 Sun, 03 Mar 2024 21:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHRZCXSiLumqJw1S71Vzt5CKJYjQzV02YP361bIq1+ZZoW4R6cNtahmd+msLv91GHvigs1WoB2oGxvL/W4eD8=
X-Received: by 2002:a05:600c:3107:b0:412:b8cf:150b with SMTP id
 g7-20020a05600c310700b00412b8cf150bmr6468783wmo.10.1709529706394; Sun, 03 Mar
 2024 21:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20240301091524.39900-1-peterx@redhat.com>
 <CAE8KmOz_5-DtSO2BHpBXgD2kJUjwsLaqKguOcWgfXC2efB2rWA@mail.gmail.com>
 <ZeIVYDnAkPTpKHsP@redhat.com> <ZeUWGa20ELoWse5q@x1n>
In-Reply-To: <ZeUWGa20ELoWse5q@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Mar 2024 10:51:30 +0530
Message-ID: <CAE8KmOwP0gjiBtQXgy+J24cPRrSDQzA55UrqqpYr0QYvo5s8DA@mail.gmail.com>
Subject: Re: [PATCH] migration/multifd: Document two places for mapped-ram
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 4 Mar 2024 at 06:00, Peter Xu <peterx@redhat.com> wrote:
> Yes I think you're looking at the right path, it's just that the relevant
> patches haven't yet landed upstream but is planned.  I normally use
> "Based-on" tag for such patch that has a dependency outside master, like:
>
> Based-on: <20240229153017.2221-1-farosas@suse.de>
>
> I believe many others on the qemu list do the same.  I think the rational
> is this will be both recognized by human beings and also by patchew,
> e.g. patchew will report a good apply status here:
>
> https://patchew.org/QEMU/20240301091524.39900-1-peterx@redhat.com/
>
> And in the same patch if you fetch the tree patchew provided:
>
>   git fetch https://github.com/patchew-project/qemu tags/patchew/20240301091524.39900-1-peterx@redhat.com
>
> You can also directly fetch the whole tree with this patch applied
> correctly on top of the dependency series.
>
> Personally I don't use patchew, but I kept that habit to declare patch
> dependencies just in case it'll help others who use it (e.g., I think
> patchew has other review tools like version comparisons, which I also don't
> use myself).

* Interesting. Thank you.
---
  - Prasad


