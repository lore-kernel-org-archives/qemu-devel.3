Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B92C5B56C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtRdL-0003rM-Hx; Mon, 10 Aug 2026 11:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtRdI-0003qL-Q3
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtRdH-0001Ke-FY
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786374582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cT3tH2kjeBqdia3+thmIb4iWedIDwmb9exLSqYlN8PA=;
 b=iZF0df7C9BzHXSadZuSiA0WVsps5HfAnzgIsDHl0dAVBGWQV9v8/aYcdod11sfi9QPmwib
 1E86pr1aHWF9fFwvPC+mDvhcoFzHddt+1UmBoFajd5PoDpyff6lAmO/XJo68C78Huifo+V
 cb1Js0DR91I50YThRd/ApoAlfPgl+Rk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-mYPYA0CqNUCKOXJv3bYpHw-1; Mon, 10 Aug 2026 11:09:40 -0400
X-MC-Unique: mYPYA0CqNUCKOXJv3bYpHw-1
X-Mimecast-MFC-AGG-ID: mYPYA0CqNUCKOXJv3bYpHw_1786374578
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso1252194f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786374578; x=1786979378; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cT3tH2kjeBqdia3+thmIb4iWedIDwmb9exLSqYlN8PA=;
 b=QTt/bNbD1niOioSc8lb0pdixcfNTmawhVvitk1pFXkDyMoTlWEg+ABaHCMa2smAOj5
 S+rcWGlFBh79cEsPD2KK1pEQBpDufczVGzy98TU5F7Mxnma9gt51SynNTSVo/91rmzLx
 6bTW2rkMT8eccCiFw1fJvNVtnyA+D+050SMRh9YvDs92WlXZoDOzN8tck+DBsa5uMdJC
 AaBhgRbLALVEn7uzfa81OEz249ga9CHWgorXPxexDY4F8E/8WGrgvuoYbRmYw+ks2kIW
 7KOlfE9c0go+aTP9dRB2DnjwqO+r+ldJ9SVaWqqXIf5LI8pt6wYHc1RtN5YJlwIs0Oi3
 6guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786374578; x=1786979378;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cT3tH2kjeBqdia3+thmIb4iWedIDwmb9exLSqYlN8PA=;
 b=tGBFd+ihHe6iD0Cj0ucu+d2WvIr90eptcM0G24ugDjxDdf6EFB9VBWu3lOBSoIVzMH
 5MFC8K2x7NAD2PIrr0ztA9xTanfgc0hh/WxLoTL5riguYjXxwzbNZuGfT972s1oEA4uX
 6W2nSRBn1nfDlttDdVJuchZGOVE5BlKI9FhOUVFm1ZlDRe5xWoq7zfjP16dp2gPVAxV5
 r+43WTclN4xbfCrCe5oRxdfczyf3sYLFD9fKARjAklJ6V1TkOtuPry91uTbDPrWOV3KW
 x7uuIEczYEV7IUpc/ksNSa+J74wxduLIi4Mj3G1eUjntQIwiZX2JZCrXQohPuKvW30d4
 +7KA==
X-Gm-Message-State: AOJu0YznsZ0WV36EQ3hoAPyXT0WTrAxgIgqfWoUl91Yof9J11TYDDvGF
 ew3XHEIyR0lgGZB9Q8cquPNtSdfCBf615JdeF8ho/evW/EHHRUsquoNAqKjjj99nR75ICm8FTUb
 vobNGNtREY0PUKGuzfq3GwA6sxll/L1xWGHttQEgX9+jmijjz6faii8R9
X-Gm-Gg: AR+sD13TNbC/Fe+j/0r6jOCLfJ45gKiaj7DNA0HkzPueibNyPgbDioCEH0l8jgNsyaS
 LvoKcbQIwTCcPHIkAE3whmrF4adCmO7UVOoJddAujSnXa6vw8qGH+94WjjFMbSL+1fiPxayaeRa
 DGvNG+FB5jgkQ1/G8RSgrMPlUttJY797YeKhYx9QoFuqd5xehWmEOFS5kCsVo209vSC2ZaroBoh
 L3Hh6MJzzNqcsto8AZFYg4v2mlI+loz+OKEqhh0h4jtoRtx7WeJMy08PCXIBmauVK7mMXMqGtEJ
 KuAxofizeHbmV1QywaZlPFGEGBwbefc+4DCDihWgVRlkeu3XpX9ux1Um
X-Received: by 2002:a05:600d:15a:10b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-4994e73ce4fmr496831525e9.7.1786374578024; 
 Mon, 10 Aug 2026 08:09:38 -0700 (PDT)
X-Received: by 2002:a05:600d:15a:10b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-4994e73ce4fmr496830965e9.7.1786374577679; 
 Mon, 10 Aug 2026 08:09:37 -0700 (PDT)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995428f294sm416721285e9.15.2026.08.10.08.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:09:37 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:09:34 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 pbonzini@redhat.com, philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 03/11] migration: Rename postcopy_listen_thread_bh
Message-ID: <annpg8JponHlro6K@fedora>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-4-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-4-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026-08-01 08:06, Aadeshveer Singh wrote:
> Rename postcopy_listen_thread_bh to postcopy_incoming_complete_bh for a
> more robust naming scheme. This will allow fast snapshot load to use
> this bh funciton directly to cleanup the incoming state.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/postcopy-ram.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


