Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E55606A329
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=q0E2YGpP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRsz-0001hY-QP; Wed, 21 Oct 2026 04:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xJRsy-0001hB-FC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:41:24 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xJRsv-00013p-NZ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:41:24 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-353804b591eso898363eec.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792572080; cv=none;
 d=google.com; s=arc-20260327;
 b=DRmwTMKta/CmjNwysS+tqS2f9p6rqzKb4M/XJMhm/bOcdbp/MurdZs6Zsp0STJqBmX
 oDDRRcL4OYgyXTJe/O6kUK+mB3LWWxzoltkNVhrhYoHyMyg1s3LJgo/LjeEw/r15phRM
 FnBMYrJU4BLKdQ9CPxjPYT3JM6ye4Su1Kj9Hx0jQwu+AWYDPQQq+ABEcWU4PVDaDUi50
 9TRpbnLfTcnTQ7zJ8TmpbQddmF0CEgRvHOPpsYjgQt79ol5uxzfN73gFx4fgpIJYHeAm
 H4RKBHyq4CSKmPk4umwa/xTm+i57KYy0nuBZKZBIBToH+P9Kv0YUm3BCGS/OFC3zO8qA
 4oGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wWXBB9ZKVaxCy4Fe4r6kgxRI6i5AUaIDR+xXQk8Z/OA=;
 fh=OygGRhpNCEiMMVRc/14YjKxWQSAFp20WLIZeP6DM1aU=;
 b=Y9JLKBm2es0m6oB8qffzfQMvLTcMkTOmuk5EUVbDz76sC/ILyFGcovjSXzJ7VFPdSF
 aYMcB2visOjBzRvum1YQFYKMEtmbVpSbk44DrbT9JOKr6EIVSU3waW89+h2gEGMD7mdK
 vLVB+2XGndLfIDW935A4lLgfwABz4X8UEQDOvmahVCoqIr8bXwIT3TxtINJ7dsB5zo/t
 pLF4k0GRaRKM/O/Lj/+Yoy/W4sj/yvf/N7l3V9hx/UiRfM4Xx6XFvNgWrli683tcdUsv
 nhFQ8nCOxAowchprBGr1jKB05bUdYldBQvTLLJu1ZbT10561245u4qYtcBBEV2cBhLRr
 DO2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792572080; x=1793176880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wWXBB9ZKVaxCy4Fe4r6kgxRI6i5AUaIDR+xXQk8Z/OA=;
 b=q0E2YGpPEpS4zKgK37gEY0Rhek9VthWaFG/ap+NRArDEz5Hp2f0kZ32bpLdNhZcqZ3
 rR+ytJR4vKkrVunkY9XUzNm8gxOVLmEJ3gofJsLR8rVBVIkMNt+sQetuMuNQxaT4Miyv
 WniqRCY9lm04zAUFuqeiaKTtlO17IS6bMSPUhPOaID/aY1clTEf99OfQKFL0q2L252oQ
 AvQ97VovCLhqRpl55fXpba/lbQQZysPP9IeW4DpvrUlMhRCVqSASM6MiR08uYXriuIm3
 auTcWTDVNi9TgxXKGnTOYocPnuiqEGJpFlO3ESYKeiduLn5z5g93tqTQghQPtAhQxkAH
 tFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572080; x=1793176880;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wWXBB9ZKVaxCy4Fe4r6kgxRI6i5AUaIDR+xXQk8Z/OA=;
 b=SZYPzhx7VwBr3FUU1bZ+2jcMPh4y8fASCVTPXIqT1t1pSPZYppVKrIIz6d+rd/yGph
 Lgp8braF7CddVhkuBQnAbALyQ0J5O810nOxFMe6uY587FmPd8nL+s+mBVBtEwWeAUvfQ
 Qf5Y1mx9cSmFl0HJ/20bshEnS+8/CUgYALTiGPgo/MDMEeCxdsfTPMIk65IFkB2ZKqFT
 /HOkCvKqiHHzKVzEZrNk1XcgXKhSYu2KDco1Tz5xgBoU85N5MpjDkwIq6bPAin2bhPvW
 yIsQBS23hwQBnzeURJVNfCYw77s4pPBfXAMp2qrYEQ4Y5HGgaPLXWF1GQyjhgUhxxVCp
 lfBA==
X-Gm-Message-State: AFq9FYL2JLJaNtE41xtBtgBrp8c+iDhGx/YOBq3rzTQQPu1zRJz8uVy0
 g31E6BE6f/LxyZ9rpqiIc3upoSyY34h2dmj2McL4ez9AFQDLHSY7LN1Z8ERShlN6ljgSiCXvEt+
 ZGPqN4ibE1oOwXDtUr9zAUvKV3V6ru0M=
X-Gm-Gg: AYBFou36trV7aiVrgrJax19W8C5mOw2JjfvKWIc1SRND8umuHaP6AJRe1pSgbJ8jL4Y
 kPF/j6+mOWuaCV3KjW42pn7049+BpHFKp08MraQGYbQggKnrZh3GT4D2c0bjJKiBrxAtSB472mv
 gWqFBM8fQerI3DJYzpQ9TxFU5IwQiXiPiyNGvyNrKdkRtqca4Qq4TbW41h11iGngtm5QYOJvVew
 Ctw32hMQ66qysmsGQkjI1jrHgnVKkpmURiYmC/CdwxYckaXPjYJru3O5tYgnNY6rMboekXeL0CV
 cD3niCxQO5E1uANKTMMDjYTw8+IQEPdksAGQhgmMX4MsbHj+CHkB4Roiqy/jAG5nTrkXMg2r7E7
 0E2o21n18XRvrJ/instGhIIY1V3adEvBSxAQO0F1YGuOtliL9pBSVKvZlzN2JBpj8RwsEUA==
X-Received: by 2002:a05:693c:65cc:b0:35c:99e1:c755 with SMTP id
 5a478bee46e88-3674e355183mr2566088eec.38.1792572079760; Wed, 21 Oct 2026
 01:41:19 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-7-2b21e63974f3@redhat.com>
 <CAJ+F1C+NLd2Nzmg1eLnH1La2yA1vw8dm7nEb2k93tcUCK4LzrA@mail.gmail.com>
 <atCEEIRn9yFLj1hg@nucbdw.ghoffman.csb.home.kraxel.org>
In-Reply-To: <atCEEIRn9yFLj1hg@nucbdw.ghoffman.csb.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 12:41:07 +0400
X-Gm-Features: AclHuK8KxrX2xn_AzMiuXoY7iPlUyFWkpJy2w-SQdg4SnfLv6PPDS6VyKADyS2o
Message-ID: <CAJ+F1CKv-YmLFOA-HA2siAEvvkyPuVX2K4O+79Z+T40n=KrHjA@mail.gmail.com>
Subject: Re: [PATCH 7/9] igvm: release found memory region on success
To: Gerd Hoffman <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Thu, Oct 15, 2026 at 11:49=E2=80=AFAM Gerd Hoffman <kraxel@redhat.com> w=
rote:
>
> On Tue, Oct 13, 2026 at 05:31:41PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Sun, Sep 6, 2026 at 12:55=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > Not only in error paths must the mrs.mr be released.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> >
> > ping
>
> Sorry, slipped though.
>
> Ani, you looked into this recently, any comment?
>
> Also: what is the overall state if this series?  There is another igvm
> patch (8/9), but trying to apply the whole series fails due to conflicts
> in the igvm code.
>

rebased, see, "[PATCH v2 0/9] Various ASAN & tests fixes"

thanks

