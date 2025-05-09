Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696FEC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 05:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDGFj-0008KO-GW; Fri, 09 May 2025 01:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uDGFh-0008KA-Q5
 for qemu-devel@nongnu.org; Fri, 09 May 2025 01:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uDGFg-0007XD-2G
 for qemu-devel@nongnu.org; Fri, 09 May 2025 01:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746768385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f2zvqz+a+R7MjiE8mVFqZYsGf+9Jrq1e8882sYn2Pus=;
 b=IyGlGmzxlYq12t5UtluEn+sKInF8mSFCd5Vrz8u4Vic3eOfYZrpJGMMaFteWk1Uw0zz8OJ
 MI1hOqlS8Oul9cjjZnPcVCc8qo1IjdeBGqFKOF9ePHcAJR5JtD9DQgX0LoSJi9WmeBdVWL
 LmUobm2ZLXpbnv/BLOMVENkHLHT1XhM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-sFjmYwzHNkuYpdBtWAd97A-1; Fri, 09 May 2025 01:26:23 -0400
X-MC-Unique: sFjmYwzHNkuYpdBtWAd97A-1
X-Mimecast-MFC-AGG-ID: sFjmYwzHNkuYpdBtWAd97A_1746768383
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442d472cf7fso6777105e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 22:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746768382; x=1747373182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f2zvqz+a+R7MjiE8mVFqZYsGf+9Jrq1e8882sYn2Pus=;
 b=vGmJX1iosqL119u7SUSTHHTNUl42lMTazSmXTlPQRhGLOEEF128RNsTNxH+XX4+n8L
 D1yw3kGViz8ma3wapJH/O4V2eG1MaSwLOGkBef6eqN1ismi+nty6RtTrM0i8DtYC5Lh9
 vHOrgTsnHcSNCHbrhwkMvgcjAEnCDo3cjEZLY8sIue92bK7gO1aO5JfGQzeE/qcD2eD0
 d0wrXcsbzzx3xNTapKjPI8h7zsPTPTYanoaP+1bVg2bFGi50SZrNIrJu8mgXyfLr1km5
 //FjUjnJZa9pAUCA4QxDXH49Ju+7r1NfTdUHMUB4AblL5aRFHZLXELuORiwBZP4RB3EM
 97TQ==
X-Gm-Message-State: AOJu0Yyc+BsxQgGe6ouiOHJHdf21b158PJGb9gR9s2n52H0L7tppCrhX
 o+tDKkRGu8Tk+AgZurIrrWFOV3LBeYcbsF7RBZLE6A0Vm0esiKOKANGHu5euQhexyoZKlfizCL9
 gOw0NYotsUetFl93YLpcNud8Z9NbBiNUt0V1QUrx4oH7t6+pdtH5NQnse/E+5lpaNGxbnJV3hm1
 7YPrK81HaLs/h08CCdAEZMcjgRke4=
X-Gm-Gg: ASbGncu/+RkYke5O2qiqPtmkR++O/75ezGAkyzCqZtfRUoIuXjlXpetfN0JDwngkf0Z
 zzYWm7FmLekE776bOaUdn+09EX1z0Kq7i20xnYIGLtrjjOIqq+WUWd+0D0+S7mVKLtlnmyf8=
X-Received: by 2002:a05:600c:3d05:b0:440:6a37:be09 with SMTP id
 5b1f17b1804b1-442d6dbd4f3mr12420145e9.16.1746768382682; 
 Thu, 08 May 2025 22:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESWHmpSQ90Snkg/Np/N6o7BZ2cmTdp/mXFK+jwn0mANcHTUIEopEdxMdsN8XRjvYxonQFlrNtCRHxE1CM50ds=
X-Received: by 2002:a05:600c:3d05:b0:440:6a37:be09 with SMTP id
 5b1f17b1804b1-442d6dbd4f3mr12419955e9.16.1746768382341; Thu, 08 May 2025
 22:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-3-ppandit@redhat.com>
 <aB0AMQdPbcdNy_bS@x1.local>
In-Reply-To: <aB0AMQdPbcdNy_bS@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 9 May 2025 10:56:05 +0530
X-Gm-Features: AX0GCFsUtLJnoq8j8nnBEHX7yvTB3olgqgb_O6odgB1b8xG1CfmEsLZe5N0154o
Message-ID: <CAE8KmOx_7EXXNQa0q0gKvZmWMT-0hYcKH6wRFiUEs_-KANf1Ow@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] tests/qtest/migration: add postcopy tests with
 multifd
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 9 May 2025 at 00:34, Peter Xu <peterx@redhat.com> wrote:
> I may not have followed the whole discussions, but have you tried to avoid
> this global?

    -> https://lore.kernel.org/qemu-devel/875xkyyxyy.fsf@suse.de/

* Yes, it was discussed, passing it as a parameter would change the
function prototype and entail changing functions at many places.

Thank you.
---
  - Prasad


