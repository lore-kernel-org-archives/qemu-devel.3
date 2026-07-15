Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A76DC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjtoM-0005Ga-Qi; Wed, 15 Jul 2026 03:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjtoJ-0005GL-LC
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 03:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjtoH-0006nH-Tl
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 03:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784099615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wdg99n/spo3tfC4hGCRxi4oh0gDICk5j/Dcb2LUW0ao=;
 b=QhAb8xLnYmvgnd16hZOM7K/YUxDdj47uAbfvOSeLF6buJvefasUEz6Zn0oQohGZDeHYbew
 pt5TtTI/sKmiLJ8y9FUtZqfGt5O08UH9iswAQWZfAPyegm+jmVDEeZ5xagN0Q6XFievZGg
 GG70M/ECvmsHOi5eHx+uxyNjqj/+Jas=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-dhrb5csgPoyiESJcxBewOw-1; Wed, 15 Jul 2026 03:13:33 -0400
X-MC-Unique: dhrb5csgPoyiESJcxBewOw-1
X-Mimecast-MFC-AGG-ID: dhrb5csgPoyiESJcxBewOw_1784099612
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493c526df6bso15808025e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784099612; x=1784704412; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wdg99n/spo3tfC4hGCRxi4oh0gDICk5j/Dcb2LUW0ao=;
 b=Vx5LnIgbIsfLOnSa6uAE9anGjzv4LZhQdYagI37dTCXlGTfAD/+TfCfaZzWaDGjCWZ
 lCa7tpvATgMGhJarTu27ph3rVE1NaDnaGDeizmHk1+5g3J4HYOAQUfQ3HbHnH/2Rz4Uf
 QLUOP+TSirLEqDjQW741Snlbc0Wrkc7dliWk4pUiM5krpQVto1VBSODb5mJnjNjS9g2g
 XCOGMXguCz3C7hJPXGOUa37QMlap3FkutguZmvyBdyv/8zqJya6kaoULFLnVI+kAEy8a
 1ngl9yR5EbtL173E4ToYIiZ5I/34RauSjpZzOBxCSCnWbYMJC8VXJYrZqAaLYhmuMYyx
 wb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784099612; x=1784704412;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wdg99n/spo3tfC4hGCRxi4oh0gDICk5j/Dcb2LUW0ao=;
 b=iS3YUFTrLe7c99vtdVstTf27bgsDfswlJ2x2zkQj19OH+QfmfpQC9671U8I/HzX74C
 gF+MG/ddebGNx7WBj/Z2exzsXHg0xfM6Jz/sHvgWFmYzFzOTEEZiGnAizjdHX0U2L8WN
 OZ6ma87F01D4Ot5z+J19wmglrlbpPI/vGXEfOWzxdE0XRcmZcenwpcujzkgFQmTtnnBt
 xJS49y+0W0WtBBJGvzBQMoJQQeCxnvyj2GMpVorrsU4mTNjSF7f93YpfTUrGXu86l5cS
 8vuatb6R7nqcDe2/HuJxQJ/p5kA+t/0cl2hvv8BCcigy7W0FU4cwIisYvddI6zWGP0Sc
 K8og==
X-Gm-Message-State: AOJu0YzzQ022Gw7ttZfoQCn+0jkfXWZwQDTybdnmJbUs1xftcunzKYLd
 hqQ9icsEYzPNYIAbyd2QHd34xOiafiWqaglsGSABk5WxayK4odE+TmNl1hAxrxaLY2Y8WemS5/4
 Xvk3HCIbQAn5hnH0qrxkpsiFM0LG1OXCSBYcBQuQC4g/RVaCBziLro87E
X-Gm-Gg: AfdE7cnbJk2Av7bOOwzBsDFGhdpdbiwzVEEcFE3W/AapKYRDwp7S4yYxVBEUDixs0ok
 ZV4QTJTss0JlL2zc+3nt07nmgx/XlIKcaH5GT3DItbve2U4FWlPbRhI/QAezA8Q+gTrraLwwC0c
 2qm/HehMMeD2Ahg9qIRTrBVkV1KvZoLcc1fKwWnjpDEFn28oYrdhIfjY/zdHGBEFANqGNb4e8Hf
 J95SHGisQg4tJU0uXNzQTI+YVcKjCL4yOJyHc+uGsHaOJ3Nm+Y8dR8S3/Q3eHhNil3ED/jtvLRz
 qV229yOBLjme2HR+ZzDsgbCZkeyS/FzMDTzLmVazrV8Q3aWVq6NOoMccgeFC4YtY8NmGB1GGkjX
 5VqbrCIyJB4IuIWtIkAmR2lnr5QaXt5KkCkE=
X-Received: by 2002:a05:600c:3f06:b0:495:3c8c:c16a with SMTP id
 5b1f17b1804b1-4953c8cc25bmr14926635e9.0.1784099611708; 
 Wed, 15 Jul 2026 00:13:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3f06:b0:495:3c8c:c16a with SMTP id
 5b1f17b1804b1-4953c8cc25bmr14926145e9.0.1784099611182; 
 Wed, 15 Jul 2026 00:13:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e5c3sm13484225f8f.1.2026.07.15.00.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 00:13:30 -0700 (PDT)
Date: Wed, 15 Jul 2026 03:13:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: shenjiatong <yshxxsjt715@163.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] rtc/mc146818rtc: fix QEMU crash when time runs backwards
Message-ID: <20260715031232-mutt-send-email-mst@kernel.org>
References: <20251113030211.6283-1-yshxxsjt715@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113030211.6283-1-yshxxsjt715@163.com>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Nov 13, 2025 at 11:02:11AM +0800, shenjiatong wrote:
> Loosen restriction on computed lost_tick. When QEMU's rtc_clock is set
> to host, the walltime is used for mc146818rtc which requires computed
> lost_tick to be strictly non-negative. But host walltime could possibly
> run backwards, for example, configured by NTP service. Under such
> circumstances QEMU process could crash unexpectly. This situation is
> easy to reproduce for Windows 2012/2016 guests.

Looks like this feel through the cracks.
The patch lacks your Signed off by certifying the DCO.
Could you pls confirm that?

> ---
>  hw/rtc/mc146818rtc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index 8631386b9f..04185eb6e9 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -173,8 +173,7 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
>          next_periodic_clock = muldiv64(s->next_periodic_time,
>                                  RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
>          last_periodic_clock = next_periodic_clock - old_period;
> -        lost_clock = cur_clock - last_periodic_clock;
> -        assert(lost_clock >= 0);
> +        lost_clock = MAX(cur_clock - last_periodic_clock, 0);
>      }
>  
>      /*
> -- 
> 2.34.1
> 
> 
> 


