Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B0606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjdyiQ+X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLu8l-0008QC-18; Tue, 27 Oct 2026 23:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLu8i-0008PQ-Uy
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:15:48 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLu8h-0003Tf-3U
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:15:48 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso768629a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 20:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793157345; cv=none;
 d=google.com; s=arc-20260327;
 b=Nz3Qp6LyDqYFLInQoflpKCKbRO8nBSScRtBdtptEid+njtlztoUgRc0EhpIlj33V83
 k3JZNYh6iTuPHUyldKP1kJPUfwyzH3wRWVYPh9mAEyY+d9t+fv5PQmq7gJzW0OjKMhxp
 S2IG/AIFiXaBtAaQk5jy3tohPm/t7fnCtsTdpmgA3uUxGt94BqasvirQopsHcpC5olJS
 7HAaSfic/xW4syIr5hELIQTCWizEpEUZf8ZlPrBUP0wU/eZujFm95CHPK1xUyz6I3sDR
 xtjlg0jcHJpK/s8CofT5SiwJ64Dc8Aq0UlmFJz8L8pWsBx7OVuYqWjarZc0P/Nepxnjs
 x99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=MqATXC3g1C7B2A4jjbemUTKdSmHPGWY0cvAnc0DM8nY=;
 fh=46U1FE5Qw0fo7evi6utX9h5HLfzSsvyXi+QDnZDegHo=;
 b=cp9KYxhXN4NsJyKVURGY5pCkreQQns3EeS6/kmHiP3/agNBuDhD1v93vU4LEY9kgKn
 UZoBwqd3Vh5DUJb+67NoFE8PiS6BiAd4IHfaCbFlR+45ggOSKJbhvakaI3G8AQYug4YW
 ezAutJ5qLUWO4gwJD/VEJqi2+6zgteCmhqfz+yZv/CwCf9YPtJrh9KAdWi8Qd1l8KBKf
 q5SOKvHWpIIIP/qr3v4OGFtPCuaAoLfC93d8b8VNxWxKAFJ91bj7rZc6MJ9tSq+bk15d
 +x4gXSiec38p5cs1iSQjrbiF7SeAH8x3sf+aCDYEDAuNPAM5dyJYMkUUR7RDTqIAVn5w
 K74Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793157345; x=1793762145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MqATXC3g1C7B2A4jjbemUTKdSmHPGWY0cvAnc0DM8nY=;
 b=gjdyiQ+XuBUW/3c2xW0RWqJwpP7MNf3jybFZsOCUlX9aPWMHUngT2/76M1eeJ25pv3
 AqCBY3iXujvX3w423tWt88Lah56Mg+j7RoSwvIYDEf10NMsrs9Y11RT8gVUXUZflpSQe
 zEjzijRiBzQAOvyzuelRBZmuNlNGYnCBgZIFf/5xzKZHYtBY8lWylv1R0kdNfdf8QRfS
 9jGYbMWeLRXtbY6acWWhZmr9dZ0gZA8qtS5zgybxZTn7qXHgcTCodv0iFRIFAwXQs/6i
 TM0Nv3QWjyDVE8E8+AL2CUdAmWSB6L0kU1OOhgdbhrLhens2Vg5W5FBOIPHMI/SwGNMr
 Jf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793157345; x=1793762145;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MqATXC3g1C7B2A4jjbemUTKdSmHPGWY0cvAnc0DM8nY=;
 b=LA1QAlpeCPpZ04CP1Ock/YzY/tEvgJGFpXtVPs6QBGUINPQTbhfVS9wXBs6Lu+V6Dt
 5XLVrp5GGemRcS6X8zgRGiE+qSiba5b95hMfulzcJBZ2Kuge+Ta1y1hW6ZcQrCAB5Tg4
 Yhz91QaAFmDUaYG+LLKNUumialaKXzLPKQP4vFfp712p37RoaIqZ/bCFOMR4aJKGzNc7
 bgrzg4MI8G5sbYOYNWi1EpRRre1np5HDrCIu6As7Raldxg5e+2MIsCbURMfTzOeP2GkX
 Sg+xpxLSarcdTt5nPSdtx1/VcXCpED6ceWShhb6O8H/4tNYRr2JO0mPEDmCn+aP1+sj9
 l7IQ==
X-Gm-Message-State: AFq9FYJHw84ldsQUALcB88O6gs+/Cqxyk/pIylWdWUq0Jma6D+dBFVM4
 x9Ica4J0AHchccFScIu4GxiQW9iDW29TNuClUoZlr4+eFErfPrHC/Tqf5fXmwyo1wWB68iKuKX1
 xIj0zZ3l8rFvpQT9Wp5+EWCEYLeNl+OO0nlUH5mA=
X-Gm-Gg: AYBFou0zTJuqlJeeNzR5m+ufy3s/jAi7SFS3TQZPGZrPyEu6d8n/eK5jryVPINzcW4X
 gySGHnAj8ocYFd1WQTjbNVuJHwP+8DoCxiGXy/XXveOytx2scO8mmmVfW7cuAeyZaDLJNDnghXS
 15r3n4JyJkYlAu2IukUd1j5a+4pN+1TQdlQHMFOWsN37q4n4Qhkk0B6w6bJzGPOo0IUlMwNFIZm
 r6qPExCvHmfKoVU+GXPi2zl/fk0Ap6aexRvrQhlQ9D2+cgJdVP9qMeGEmwxe9o1U22uZrUzvdVN
 fHoh6pzhyglmIX4XE2erLhvqW9dhc6CVBYWP7fAlRRB9HRcdqr6b6AFtZQ37Ga6Tlj64XHLnTrn
 eT2qvv1pD7McrJGAMUv73atFAxvKvbnXaAqQI
X-Received: by 2002:aa7:d48c:0:b0:6b3:cfa0:77cb with SMTP id
 4fb4d7f45d1cf-6b47bcb01dfmr2276972a12.10.1793157345307; Tue, 27 Oct 2026
 20:15:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_4_kLo+p2k+3+JvD_pPLPjc5M9_HSX70_6ewqjg1HyEQ@mail.gmail.com>
 <cd06ea46-5935-40cc-9897-bf004c0983d7@oss.qualcomm.com>
 <CAE2XoE-xipsj_xNJ5tQ5GEkNV+sJE3VuoATxuHj8M9xyVW2u0Q@mail.gmail.com>
 <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
In-Reply-To: <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 28 Oct 2026 11:15:32 +0800
X-Gm-Features: AclHuK_I8EfdDco9vCALpRdZiOEsq8QEL_8DcXK_4aD3T1jAQ-xZsYlUS3R6K_I
Message-ID: <CAE2XoE-iOCdGxPtg7MqydmahpnOTFM_15dR0eJKGMrQKxrgeQQ@mail.gmail.com>
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 1:40=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/26/2026 9:57 PM, Yonggang Luo wrote:
> >> I hope that through the recent series sent on multi target topic, you
> >> can see better how to try to slice work in smaller pieces. I try to
> >> focus on having a clear goal for each series, and each patch has a
> >> unique purpose. Then wait for reviews, and iterate from here.
> >
> > I have learned much, I need more information or discussion about thow t=
o
> > avoid calling target_info() in class_init. You suggest me to use is_ava=
ilable
> > but I still did not get it, because for multi-target binary, the is_ava=
ilable
> > will not be called. so adding more things into is_available is
> > useless(for my target).
> > So I want a more clean explanation of how to do that. (I have already
> > tried rename/duplicate
> > the QOM name with is_available, too much changes and cumbersome)
> >
>
> First step is to create distinct duplicated types for every QOM type
> concerned (like two cpu max, one for arm, one for aarch64), and select
> the right one with is_available.

I think this is easily implemented. So this is fine.

>
> Once we have all types correctly duplicated, and using is_available
> everywhere, we can replace the callback approach with a declarative
> approach (.targets), and register types in distinct buckets.

Indeed, we can compute .targets from is_available, as we can create a
constant mapping
for those target_* is_available callbacks. So the prototype can leverage th=
at.



> Then we can have an automatic naming convention "arch-type" which hits
> this bucket, or "type" which must exist uniquely among all buckets.


So you mean use "<target-name>-<TypeInfo::name>" as the QOM name when
registering?
For example, most types are QEMU_ARCH_ALL, then they will be
registered multiple times?
Or for all type with QEMU_ARCH_ALL, will only be registered a single time, =
with
narrow QEMU_ARCH_*, emulate <target-name>=EF=BC=8C then register all
"<target-name>-<TypeInfo::name>"
at type_register_internal?


>
> Yes it's a big change, and it can be done in parallel to current effort
> to support multiple targets linked together, it's unrelated.
>
> Please note that the bucket idea is just an idea at this point, and I'm
> not sure if this will be accepted. In all cases, the refactoring for
> using is_available and have duplicated first is needed first, so lets
> focus on that.
>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

