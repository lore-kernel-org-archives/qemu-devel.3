Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846D2109C05B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5U8Z-0002hV-SS; Wed, 25 Mar 2026 15:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5U8Y-0002hM-Hb
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5U8W-0005ye-W5
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774467806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i43pi4duOZUxYwISmLRyprDGfJqRrw4E75gRkH3565s=;
 b=hx0r6LCXl1p4L/pZhKZ+MWgSTf99Xgwvf/IAzsM0/Cv5JFXMXjEXJQAqD1gBWvL0NwYiIy
 fpV9F5EZ2WagnNfpuf4CV7/GzHJIGRV7sJOnaVjLx14BWH5Up8ZVzIYAFPz6vl8DMawvJQ
 AYu7988zRyKSAH4sDykHy4n4eaK07Q0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-0IFtZx0nO-6_PS4Eqj5-xA-1; Wed, 25 Mar 2026 15:43:24 -0400
X-MC-Unique: 0IFtZx0nO-6_PS4Eqj5-xA-1
X-Mimecast-MFC-AGG-ID: 0IFtZx0nO-6_PS4Eqj5-xA_1774467804
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b8f848ebcbbso26492866b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774467803; x=1775072603; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i43pi4duOZUxYwISmLRyprDGfJqRrw4E75gRkH3565s=;
 b=UQL37d2V6SYgxzjM/stqyEhRkHiwdn8GGA0yfB34oHi0Ow3aJ2+FIHZBy9pWb0oO1y
 aMUX54769FFkD5srSScD4m8lVwKJCJgO84sLuWRnDawGkOX1OgvgxKYlDtuYsbUB1WFY
 XZybK23WdWxYkRvpjIARF3e2uH6hegKPOqvota0lRSmPa+PUHH9+H8+zw0fsLxX5hFM/
 BwksG6PtUlmRGMt38IODCRMBHcWYCObPwM1Z/MAW2sr3lLiDGAHTxdjv55C82R4a3/Af
 f3noXCmHw+C7oZnBWvEmfjSnycQQMAB08aJ/M6hYEOk7Ne9PCyM3LiEGSgAjRnZfe5xH
 jZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774467803; x=1775072603;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i43pi4duOZUxYwISmLRyprDGfJqRrw4E75gRkH3565s=;
 b=In/s6wBqEhdTy7RklEOz6q0728LqcPxIWn3mNPAnbhOjN+O8sWeXyk56CHb1U/AdrG
 ODnhxlkCN1NBglgadTgxDwoRH6IOje9rtkpJXtoBlxLRIPivBe7mLRooNNyPKr7Te39t
 KwJrLQpbg+PVaggFmX4WlWX0jh0PAHAWyI/KbHH2FiicspK2u6luHT+W0tmUkkEs45BO
 JVktL1iDse6sHNUAlEggj6CofmoHGHEVybr/fyS+Pj3l9hvjDYj8Cs0A+2oCzX+lPrug
 +tzRujiejzjtbvh8wiayiuMTDHh8WdRCGN8uyeO2OOFlm60PIjE8wmd9UVUBKgjD1Fk0
 hC2Q==
X-Gm-Message-State: AOJu0Yyw01EznT4dkMLoW36N2fdsg75aaKsnOjoaeGBrpiKm/zbt9M03
 BY5laWUwihaipmUIPtobInlN0LWgUiErcn1z8XBOjl2o6cV+E8z9q62JhOVzvsHbgS9/5xOqq1I
 l/2UgMn2ktEuKWHVtJ0jBzdFpCoj7Qj7NRiI4G7eqoEG9WTrZnLKZUza6
X-Gm-Gg: ATEYQzyRt8ImwRbhlw4CCvaYAR3qbNX+gEkmOLK7Sprp0cCTKkNbYTHm57fFfLuCmlh
 P4lt71AmYx99dQuy80++0JLPgA0GoAm8vFrHDtGVY32PNpV+l4M8uX/0d3DhC1tV3BzlLCm8KHr
 AcNAKaaNfKSbYRuecGbhQ5athsGlWar7iIrBh1FkfJ9kcn7m/nJ0JSpc3x9qQnuW3RCX1fcX8xg
 buYpyca04SlfKG8Q6+iKX6kWk4RZcA/GcgqMwe9XD0qNMj29geN5u5mv8rMBxm/ae0t/IT+xRiy
 L+KBHRcFMSNqwrIkiN+vm7xFdumgNgYEQvaeZvTtuY5i737S8bhQsyW9ucZXiQtiRDZIXqpjQ6l
 AvAA7+8drImPExg==
X-Received: by 2002:a17:907:890b:b0:b9b:1ed0:b403 with SMTP id
 a640c23a62f3a-b9b1ed0bbf3mr92042666b.35.1774467802751; 
 Wed, 25 Mar 2026 12:43:22 -0700 (PDT)
X-Received: by 2002:a17:907:890b:b0:b9b:1ed0:b403 with SMTP id
 a640c23a62f3a-b9b1ed0bbf3mr92040166b.35.1774467802207; 
 Wed, 25 Mar 2026 12:43:22 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b203eec9fsm19412766b.42.2026.03.25.12.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:43:21 -0700 (PDT)
Date: Wed, 25 Mar 2026 15:43:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 00/17] migration: vmstate_save|load changes for
 peterx
Message-ID: <acQ61yMtzZPfLUAj@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 24, 2026 at 04:43:15PM -0300, Fabiano Rosas wrote:
> Too much stuff to mention inline on the series, here's some patches on
> top. Let me know what you think! Feel free to drop it all or
> incorporate or whatever.
> 
> Based-on: [PATCH RFC 00/10] vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
> 20260317232332.15209-1-peterx@redhat.com
> https://lore.kernel.org/r/20260317232332.15209-1-peterx@redhat.com
> 
> which is in turn based on https://gitlab.com/farosas/qemu/-/commits/migration-staging
> 
> I pushed it all to https://gitlab.com/farosas/qemu/-/commits/migration-rfc-auto-alloc
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2406278684
> 
> Fabiano Rosas (17):
>   vmstate: fixup the use of AUTO_ALLOC flag
>   vmstate: Remove vmstate_use_marker_field
>   vmstate: Stop checking size for nullptr compression
>   vmstate: Set error inside of vmstate_save_field_with_vmdesc
>   vmstate: Remove vmdesc_loop
>   vmstate: Put array of pointers code together
>   vmstate: Create and save ptr marker in same function
>   vmstate: Don't recompute size and n_elems in vmstate_size
>   vmstate: Increase scope of vmstate_handle_alloc
>   vmstate: Remove curr_elem_p
>   vmstate: Introduce vmstate_first
>   vmstate: Introduce vmstate_next
>   vmstate: Drop VMS_ARRAY_OF_POINTER_AUTO_ALLOC
>   vmstate: Move VMS_MUST_EXIST check
>   vmstate: Invert exists check
>   vmstate: Declare variables at the top
>   vmstate: Reduce indentation levels

Considering that this prior series may block the nvme series, I'll be
slightly conservative on what to collect, but I'll collect as much as I can
that makes me still feel confident when I repost; we'll see.

Thanks for this work, Fabiano.

-- 
Peter Xu


