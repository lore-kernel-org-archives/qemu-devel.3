Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44517C5AE49
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtQmj-0002kF-JL; Mon, 10 Aug 2026 10:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtQmU-0002cQ-FE
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtQmQ-0001z7-KL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786371305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/JVOjOsdLw46U5wf76i9LPv3QuZPEvP3XANE+nMJB+M=;
 b=ASLBr7CHEKN2E4Nfitr6gMIIk6PzgH8PmZXHQH2utNlrOh7Rzbz3OpeBRA/XE20EU+Tp2Y
 f4kWYv7THOA/vKM2uBqAC1eySFuGNEJ38/Vo4U7FEsoYH1mbwEABCJHSoyY+cfQizyo0Tg
 hbeGqrPtGcxpbD7RF4GVJLt2d7g+H80=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-7_Qakrc0ObWSfMwmL7fy5Q-1; Mon, 10 Aug 2026 10:15:04 -0400
X-MC-Unique: 7_Qakrc0ObWSfMwmL7fy5Q-1
X-Mimecast-MFC-AGG-ID: 7_Qakrc0ObWSfMwmL7fy5Q_1786371304
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9368f2b7b2bso103717785a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786371304; x=1786976104; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/JVOjOsdLw46U5wf76i9LPv3QuZPEvP3XANE+nMJB+M=;
 b=aGmfQYrl5sW9s1GH5YfIbC8RW+x8IK4t+4EAvG6STJaU+u7/47gn6Mi3yuJSecve8D
 ESH46tdNluBS4scqgkNRAm10kycRuUx6y4KaLo6xISj46rzgN5GkMdU4GhzRVGmtZDcr
 OMvPhPlToZ9x5HlEZpxzUfcqUgIzpQax7A/Ro3gTpOQTu4dLgyxjMxE2A+2MRsmMArGU
 3vvM1zDKpqgXticDwiM8YXq6IA7oS9DSaj1fWvmxTCS8OnO5uZqrmPr7GCYW2PCBkrWM
 sGOJvQ9R3bp0ZMO1Qj7HgOk7CXSppubJdA+W4Di8m53bAeoIHH55/MNeYdsqIFgbMajI
 KatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786371304; x=1786976104;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/JVOjOsdLw46U5wf76i9LPv3QuZPEvP3XANE+nMJB+M=;
 b=qW0hqmS8gCxjCFf41L1b/blQwQdzWypZwbQPIopHRSx6OtCtSBh945cUZfYJAHs6dL
 iswnQv2SYoaqL/8U38+D01x31wRrp/+tzuHB0LD5gixUHancch5rp4ovU/LNSz+3Loyr
 Hv29EbggsIo/lsz1+6PIFxXlzVdR/Hyr2Ax9wK7jkGrNctLdCFXCslMXL2MpETMdSpSD
 BgOqf/8cRgneWrZzUggaVyU7uCVW5ctcjOMiH8y0Dg5NOeWX07aNWwuUg+7L+lSi2Gg8
 qocZLDVkDeIOy9Mf05FP5j7myfFLcp1dziTXgPcoKCn0NWSHhxu9mVsjb+0BARN6xcr8
 66tw==
X-Gm-Message-State: AOJu0YyMeRXTc6wUFCuQG9pqU+WZ68O/+t8gjPr0P7+PIfYurenc/d8c
 uT/DNMzGW/Z9nflSfwLlV0ygLppsIC3efHxzeVL/zelQS+kOR7nqscr+Lmj0mSNL7y3KlYFktqk
 b7wOZykOO0Ha/rfFX2vJeC7qv0mDt0lTME6IW0I1jmYSOiiLgYc/2TenO
X-Gm-Gg: AR+sD11+vYbszkIjcjcUix1jYEtf+s7t26w/ZaDxCNq0s4iwfu89EyPrbxf8XDVnmsW
 NXJ3C3i8GfMpxzV0AHZIw6O4xe+sWsv3fkCXaRi1EuROS1AnigjxHxZ/3Be7h6KKpJlLAomR33z
 aduLd5TYdgkE0H1nO1ZhKiC6PYSYlAKLD5olKdFcejTfTmd3csSeYcwN9GBAq3yhcqwFWy4A2sN
 cC95CDRRzhrQZAIk/mCOCU1FkE3XYMY1H/14Jfz+NxHojy4Q8raZ/n0xqqZ9FedgCww4J2vYHhD
 A9eTW96lnR2D5F0D6C5Pyy2nokt1fB+8EXeQnWrp54WGgtET3+1QbPrrBBAOf3hCQniUYT1G
X-Received: by 2002:a05:620a:700f:b0:92e:4859:49dd with SMTP id
 af79cd13be357-9369d081bf7mr188145685a.26.1786371303375; 
 Mon, 10 Aug 2026 07:15:03 -0700 (PDT)
X-Received: by 2002:a05:620a:700f:b0:92e:4859:49dd with SMTP id
 af79cd13be357-9369d081bf7mr188136785a.26.1786371302806; 
 Mon, 10 Aug 2026 07:15:02 -0700 (PDT)
Received: from x1.local ([2605:8d80:6cca:6745:8cc0:20fa:c0c1:4a55])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e279f0esm784763085a.38.2026.08.10.07.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:14:59 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:14:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 05/11] migration: Make qemu_get_buffer_at() thread-safe
Message-ID: <annc38EEuLehN-mE@x1.local>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-6-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-6-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Sat, Aug 01, 2026 at 08:06:22AM +0530, Aadeshveer Singh wrote:
> Remove the internal QEMUFile error state modification from
> qemu_get_buffer_at(). This function is called by two functions, both of
> which already check for unexpected return values and handle their own
> error reporting.
> 
> Removing this shared state modification makes qemu_get_buffer_at()
> strictly thread-safe for concurrent disk reads, serving as a
> preparatory change for the upcoming fast snapshot load feature.
> 
> Removed local error by passing errp to improve on error handling,
> consequently also change caller to use error_prevent and not error_setg.
> 
> Set errp in case of f->last_error as function should set errp in case it
> fails, and caller can simply use error_prepend without checking errp in
> case of error.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


