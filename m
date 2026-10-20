Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E4606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WMV85Wbf;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FzP0cMQC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ6QN-0003e3-OT; Tue, 20 Oct 2026 05:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xJ6QL-0003db-2m
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 05:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xJ6QJ-0007xS-Ng
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 05:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792489583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8b9Vn35NKsVITMva3Zho/kTbvpYvIuI/FqJrB3s+ow=;
 b=WMV85WbfvCEbqmv5TEty5l7wJV1f2C77sfk2fTLYQESzq5hTj/PFkhJTid0v8ux22wC3Ju
 OpPxWcXkIZK9DyV+YALzOwvTRGoQ7ZCzDQfwYnYEdJbTWxg2WURyqfH1i7EJ4U6ZGkUs8B
 8b1dZl1bNNsS5BJDIzMC87FTpF/51y8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-w6s4c8DRNsqzbHx0Jolqpg-1; Tue, 20 Oct 2026 09:46:21 +0000
X-MC-Unique: w6s4c8DRNsqzbHx0Jolqpg-1
X-Mimecast-MFC-AGG-ID: w6s4c8DRNsqzbHx0Jolqpg_1792489581
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8afde3fe132so34885427b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792489581; cv=none;
 d=google.com; s=arc-20260327;
 b=PjLO92HmK4m4D2t9ZdiuE9IskTy3N3owIERwe2qbtpr+aybEE1d/qgsqFKtEm0LvPG
 tSswCWvDJR1f1/kZ9nUQC8C0DuMHspKXEKd7FN7Ijrl7tJP5MttTvTmdheaH9jdmmYQ3
 1tHQJFJCCBSVD7+0BCkT7rY1lM0OTUsagHTArs3na+Zo3dIlye2+xnC/+duoWhKwwwHB
 6zgKwOVnuZSZOS4EhxvK5FjLAEcIHGJQiaS2lsu+W4XPhT0eoujdF/3pRv44i0m4h2m/
 B0ON2DRkwQWWM3xvlwb3fL6QVEUoJB3k0Gb/9wlFrtSDKPGeTfdUyR5q42Hx12o8E2Df
 mwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W8b9Vn35NKsVITMva3Zho/kTbvpYvIuI/FqJrB3s+ow=;
 fh=vu9G8xhBbg9DJedcVEReobQVOPR8IL1PJGDV0Fuwo2A=;
 b=Qvu6FmypFS2QFFCd1FmnycHNoVD7vPrFZRor7yF6YkVHEut2CprCx3Q+v0EPvtoCRc
 ukh4qoVIcWo8AwmAcW2JU4X6FRLfWTIoKk9E+QLFIkjyAyS5NhxvoDQHqRds+bjl2EfO
 ZmrknyE/m2VFPnartJsJqqJNAF92Z5acnrz/jnL6CnncW4AUmiQqLCF+rt3hm+i7Q8zg
 8aZKUtjxKA85jEL+WNwHanZlAy6zj6D+UlURbJp5tlGXRbOMphSt6sS/BKT3P7cpaqLq
 r4AJzCte0tmhZVzUViP7Os0+gewHDge+c1ufZQEBafNQpY3u7Q6lLo6b5pGlHaDBKqqY
 bNJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792489581; x=1793094381; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W8b9Vn35NKsVITMva3Zho/kTbvpYvIuI/FqJrB3s+ow=;
 b=FzP0cMQC9QLf7B91BmKYFF5Izz4XmY0L5HVM+jCSM8WVF4VRaqtYb21E7X+GvygFDX
 BxSSPc/jcRqU2gRU+b5h4e652DBHYz8jBOstoLgoQ03YTdtaMHj5oI+v+EwjSbgTiU9D
 QVkJ30Ypf4Mi4VQCBomTKgGPcM/SyhdH/UiiT7iODuKjCYYw+xxqBA6lIEMZCeDiqOtj
 UZ1smsY8LPAuQdbDRbAJXiZEcxHSSWV7582o9qhIPp98AjoUT5Vp07V7WJWy9PePEm0a
 gaSW9pwjPTcUlIkcbseAqrEzqDTtuXZ9MPP2VYZgcl+hJzS8ZtkPJObaTohCRRMi46z3
 DOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792489581; x=1793094381;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W8b9Vn35NKsVITMva3Zho/kTbvpYvIuI/FqJrB3s+ow=;
 b=jZfdYuiSK3gDeasiUMiCUXjBa3qKV9dkbG4cEJzJDr3K1o5qsN1Jg12zhRL3cI6VHr
 kB7iXsVFRdJNVHaNjhtD9cg7z4Eq8k2PgW3ULih/OB84Yl90Csxmh23OZE/h99WVUrfi
 WAIsQ9CchEuTeZnkDBmyIee+57xIFZJFAIymT2yNcam9P+ePsvJsuU3rR4+fJrrYtRJt
 j4D2XI96ta0If/EXLer46gAIG1vGRv/shLa2pAlTHgi+V5Gens0QAZmYbgmUx4hik4dU
 rzrzI2Meuj/bu+6bJiGy+RbFg40GAdTMqor70Uae/kIaCgMZVQs65UBrJxmjIfD0uTQG
 Cx7g==
X-Forwarded-Encrypted: i=1;
 AKwUvByQif+VjfJj35tra2H8u4v5iAx5CjdNX1f3H0LFuxermPavf1XN4RP6UpCrFL06JkcKQbAfd0Tf0iNh@nongnu.org
X-Gm-Message-State: AFq9FYKAW9Ylis3YpwSGc91FtEu11EueCbkQpuzWTFLwcBvRRfMOdHwP
 qbKjbeJrWkTtcH5G46HaqhNm8CyH8QQWMuO5fkHSPHrbIm6R5ePIMsKUnQyfw5fEHUwsfxXiWJ6
 8ugNqi9D6Mg9YWj9phfSGgO3m5EM9t2eKe/U1R31Z8d+XejJTY4xRQdWxK/bkEGEAhDDgxuOXU6
 aPVViaeplUXErIeFlbldU7UV/nyJJa7VE=
X-Gm-Gg: AYBFou2NhowjSEiqtMCcqu3MAeg6MUOp1hrQT4ESElv3FtL78cbiSyhnpOHDrsgnLAT
 HPo/nOSl13sEl3S5W87linSMQ3+GoNM95d8atvKr881z5g0+7mPnGTIRnq2Cb/NvH2v6JT5j6EI
 P+bDwitS0BlK3lv4ldBGuiIvuFO0dKE/dTwGI4BAFYGMCt2l8NiQDzHF4Xwvd54853KKhI2jU6I
 pH1alWmFiSNCKA425HOYHfIjbOlxQL30gHIM2E5qOBJnuXApTHKBwDAq9w=
X-Received: by 2002:a05:690c:a08b:b0:8b0:f1c0:60c8 with SMTP id
 00721157ae682-8b0f214d10emr29517987b3.22.1792489581098; 
 Tue, 20 Oct 2026 02:46:21 -0700 (PDT)
X-Received: by 2002:a05:690c:a08b:b0:8b0:f1c0:60c8 with SMTP id
 00721157ae682-8b0f214d10emr29517917b3.22.1792489580665; Tue, 20 Oct 2026
 02:46:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260816043451.2547-1-narimansayed28@gmail.com>
 <20261007050718.926-1-narimansayed28@gmail.com>
 <CACt+UE7HTzkeym-4GCy7YnzX=XM_zUBPE6Pbi71dPcCcTi6PLQ@mail.gmail.com>
 <20261020033724-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261020033724-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 20 Oct 2026 11:45:43 +0200
X-Gm-Features: AclHuK_fhRXxUmnrMvjQqlTpsUjezG5_JMR_ciKZI4Q8ynGCrXQV01oh9FZRYSY
Message-ID: <CAJaqyWdLNZM6f-hFvkPR+MEGUQazLdEpJQqySTVgeWDzmqiDQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] net/tap,
 virtio-net: auto-detect MTU from host tap device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Nariman Sayed <narimansayed28@gmail.com>, qemu-devel@nongnu.org, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 9:38=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 20, 2026 at 08:19:19AM +0300, Nariman Sayed wrote:
> > Hi all,
> >
> > Gentle ping on this series. v2 addresses Eugenio's feedback by adding
> > a generic get_mtu callback to NetClientInfo, so virtio-net no longer
> > checks the backend type.
> >
> > Jason, Michael, could you please take a look when you have time?
> >
> > Thanks,
> > Nariman
>
> Given Eugenio gave feedback on this one, I'd like his ack that
> his comments have been addressed.
>

Yes it does! I missed the v2, thanks for the heads up!


