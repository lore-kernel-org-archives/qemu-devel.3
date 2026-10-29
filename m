Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X+AXxKBu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mnILFc8i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOmm-0008JN-7t; Thu, 29 Oct 2026 07:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMNT3-0007uu-1S
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMNT1-0004px-7j
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793270082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WtzZIMDOiqrk6lsp6O6oixpiQO/z6HQTu+TLVzSWDes=;
 b=X+AXxKBuQqkl5P3BMctY8NTIU/pyEwv2+Rxv5VnQ2S8dbPPfpHy7VF/VY8S9xasgi2ZUGE
 WQXvIy9uO4TWSBtqdFkr3crt40pZDId6fvGU9cvm3uraiWvl9NbyfzADPufdBLtqDS2ppM
 rdSnpZtxMzILIJNH7cE9A2ZEMMfInTo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-b7_EfOsqNOymdNL6j2Jrzw-1; Thu, 29 Oct 2026 06:34:40 -0400
X-MC-Unique: b7_EfOsqNOymdNL6j2Jrzw-1
X-Mimecast-MFC-AGG-ID: b7_EfOsqNOymdNL6j2Jrzw_1793270080
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a214a5f8a1so18443245e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 03:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793270079; x=1793874879; darn=nongnu.org;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WtzZIMDOiqrk6lsp6O6oixpiQO/z6HQTu+TLVzSWDes=;
 b=mnILFc8i0L9EGEFvH6c3UPZbtCKbUGRFslQXDkRaoM2XaPXVWwyIO+oIUbhEYmAc7D
 VkuMGMtFvx5+RZg1Fv1Sjb00o2TXc/1OqHCgIJHs05rUGr5RwJ9hSx6FAZCOj6xaaG/Q
 j4HrNZ9cO9rzLd3+bAltMYi24TPaOZSmt2VAC0v38wOsZ5cg1PLeWG0AmLLBs+aXSqju
 qWPbvYON+lKAWq2QE/s05Z4T3sDec3elTHUDT04uAxm4zlhNHY3E3B803fMLzikuUrTY
 jwsSuRkh77xWZtNDF1Bf9MWurEqD/taIPS2F8HqhvJRDvIPF4AcUO3ASY1qOEvQ02kZX
 S0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793270079; x=1793874879;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WtzZIMDOiqrk6lsp6O6oixpiQO/z6HQTu+TLVzSWDes=;
 b=GuFfNAGTX5Pu19RtoXPbkcBKAH1VlqCfBCQVWu4QvdI21lTT0HU1Kn0/RQhFJd3C/Q
 sL5Bt5IhFlncNVUvEvbwkoggnslbzE9kf/LXWuqTyEnzx1HAjiYN3y9QLWTGsyNnA2S7
 PXvutzGJaMNUUQGgE9nJfwlv1aFSlEKW1GGEkRCo6qHxD/hr+3YtKvjPLCU3iynmYOZ6
 0MBpnWEEzmz5EvnYYH1bwlomejWHgwT8pSwPNfo1lvvLNM5cztb+aPWaBJScJ2+8uFW2
 tGbY2GjaCrLgh3TWVPjILdlc8wLhy2GDOslW6HpV0xoBNe54yFLm1gOZmOQs/pEeoDtz
 Rxmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/xw8x77nJXspdJc6ZLVvX2x39JAvEUCRNQGj5UABlBUreJiyABlcszeJmawuGvpYlJKux+ccIL0xS@nongnu.org
X-Gm-Message-State: AFq9FYLBbpvIdT8laeQRYJTLY6bbYHQzFlshrJwuyEOXupGrfZtgGuJ+
 HBi+zdvgAsdGBqGEzKFU+boseAsfaT8OoQ2hEncnUEH+/tjYt9ulH/j2kKhAhaOAZSne69ycNnH
 u+5xvaknegeT3R7vkw7iHtceZb3DkaTW8XOCQZPuUIUfTa/moF8R0JQ07
X-Gm-Gg: AYBFou1RUv0C9opoH+JMjY2KN+GUuKzKw7hSiAsnBxbqqjN4JM0J+6hrwhK1zuNETyC
 UM7Y9MLebzIt5ziEU3e/Ftbc1CjrS2jnanVsyLJZGJ6xHipPFrVt7xtEWx79Bs0xXrYgqt3dyZu
 NOM6QvzTMPh8j6wBeQ37JpUXR3k28Iv5KW4PsYFoYcd/pxcJVGtFhIel5dZsJUtYWrYXLVYPnO1
 k5qYTRT+MUvw0XlzFGAbQZRluBo12LN0sRyZgBeE2DzygcW/KaAa5KXtM0bVzrcg93gNqUut9k3
 jvPkjpN0gl6yAFZ+1xikjiPEUWY2Q+J15DqLWdAo9Us9Aj75ZCQmV1COAUhRxJt1I4S1g9jrFUR
 TmKfhsqsQGj1mSGXvO8R0/4RJem3PFObkQ+hl7fDKtWGD3BTGnhhBk08SIFolc2SntFFMEvgJip
 Ui+ipoX77Sbq7SjFH+P0nvZO5wcmVlNlvbCWUZYbg=
X-Received: by 2002:a05:600c:34ca:b0:4a2:133:45e1 with SMTP id
 5b1f17b1804b1-4a967202e8emr113490505e9.24.1793270079624; 
 Thu, 29 Oct 2026 03:34:39 -0700 (PDT)
X-Received: by 2002:a05:600c:34ca:b0:4a2:133:45e1 with SMTP id
 5b1f17b1804b1-4a967202e8emr113490355e9.24.1793270079299; 
 Thu, 29 Oct 2026 03:34:39 -0700 (PDT)
Received: from seott-rh (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de.
 [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f322c46sm53459235e9.2.2026.10.29.03.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:34:38 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:34:37 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, 
 khushit.shah@nutanix.com, richard.henderson@linaro.org, 
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com, 
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com, 
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com, 
 armbru@redhat.com, mbawa@redhat.com
Subject: Re: [PATCH for-11.2 4/9] target/arm: Enforce MPIDR into isar.idregs[]
 storage
In-Reply-To: <20261029092307.281287-5-eric.auger@redhat.com>
Message-ID: <18224a5d-a88a-a63e-058a-5217bc531bc9@redhat.com>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-5-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=seott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:59:09 -0400
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 29 Oct 2026, Eric Auger wrote:

> At the moment MPIDR_EL1 has no real storage. Instead cpu
> mp_affinity field stores the Aff0-Aff2 bits only and the
> ID register is reconstructed when needed. There is also
> an mp-affinity property used for TCG only.
>
> Keep the mp-affinity property and its associated storage
> while making sure the MPIDR_EL1 full register is stored
> in cpu->isar.idregs[] as other ID registers.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Khushit Shah <khushit.shah@nutanix.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


