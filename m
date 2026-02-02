Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18477E7DEFC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmwPc-0004OS-SK; Mon, 02 Feb 2026 11:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmwPX-0004Nb-FJ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:04:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmwPS-0001Ib-2b
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770048256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8TWTN4DBEPVjtcflrZEAKY/Xxnmfk0DNkr8968bxJs=;
 b=idum3UUYRcWGLuTLavF91+rhrPWQR/3VfN0SmfolZsNV1BRTMY+SnD5Fdh6WzAzUTASARO
 pmqNjIyXIYqMa60/clf2GuRYOdz1S1GZyTwJ2vy+uRfVEZs2YD0mJHY/6998AxRFvyYwfM
 BGanHJ5d1az1J0hUsPEMRV5QbvntFb8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-CUeGZlmBPueshry3HSoakw-1; Mon, 02 Feb 2026 11:04:14 -0500
X-MC-Unique: CUeGZlmBPueshry3HSoakw-1
X-Mimecast-MFC-AGG-ID: CUeGZlmBPueshry3HSoakw_1770048253
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-480711d09f1so65913655e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770048253; x=1770653053; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F8TWTN4DBEPVjtcflrZEAKY/Xxnmfk0DNkr8968bxJs=;
 b=VRSycazRsmwUnvFsDDOKvXJsPV9bsWJqPKywn58cASkux3ftbEdvK0Ry734n3Ny+/G
 CZQSutEHsDvjeyA1+YFP37YBeWZMz8/6pkZr9HB3bcyxsUhgt/NDCKRv5sHRqlGqP3WE
 hGpAwDgXrljFNzkEjfKcgZ7zyv5ISB85jnwKs2sGgdXdmnamMe66Moh+x8689/kI3x1T
 ZVqhrrgbn9JGKOHYmwqV9JoZKi044vhk1FpKLI/S3Lese3dIf7/0R2NrMhhMzvJg7Vnt
 /gdD+20F5RwqmyhsLXbnOuNjdfrqGvR/AHkrRQQH99f9fEP55Jgql0KqraQsRyLD0MJK
 95BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770048253; x=1770653053;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8TWTN4DBEPVjtcflrZEAKY/Xxnmfk0DNkr8968bxJs=;
 b=tBG24laP6l/XUIZHWt8/kvv6Jdqgzqjdaiz+xKVzN9wtTlg1SIerNl8btz+58kijrw
 fYtar4IszJPE18U8lStqpBKmuKOIbhsYJ1eSUIfrzfiVPhquY2v1Y42/+ADExH3aQJ2P
 uqXcPcWLJhIyMm5oYg+8nlDILc3e10oFEkSFJnCj3fgDlmIVtZGUysRSLkpLSRWL8c2R
 5iGC9wnfOgj0//eO6trhqOK62uuhXuiU0Ll8fL/j/gtieFmMeEgJj+raD3Qia6sZsAb+
 553c9E5AF6H0BnhSr6osE/k1fHlzYBdRXux8n3G90lzNMxkaZTllUyn84/8fvZy/ZfNt
 jNWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQqu5J2hOUiBdllU1tztq0+GFaJI7qIc/hNEsXB3rZFiXXpRD33fDy0ozBVLuG3+XplXznTiK2hTHr@nongnu.org
X-Gm-Message-State: AOJu0Yw5ay5PKFjEH/ijPTwnXNsDPNXm3Dcs9D7d6mvFA5owUsQKavOZ
 Wgz1Nrb0PcQo+wHQksJ9PdGe78I+/SK+bGqOQOu1YKL9z2MrDLLvESfG6Z2tfP6Xz6mFfBMvh2N
 OKtpFyooIp0RG4l9AVS6c+kz0YeA7OnCDN5N1z+cEXAD0ZC5gNyjlcveR
X-Gm-Gg: AZuq6aJdXFuZAI4shVyL+aX//6N2/zT80dtqYyBPgysAe2kKvqVAnuk7sdHxQmR8QiI
 D0p7o9t/Q3kGilB+AcR5f7yPIX4jKBHos9gwBRO2v+Xkqw5rDjJMhuJvDBAzrheOMOB501AyoxU
 x+FlZr8GHg9+Z5kf8aXEJaCYUSU2FbFVKXsnyCzWLi3kXLTBnQPj/r8UFATPZh8BQSCtbvrsGEG
 Y6q41C6hUL6Ksu6FtM1HAfGb5KzRXlPjcXv5An/9yVVFPzr4OEgk8xmdFdFNobl64YCv0mjj16v
 TunnGsFO41bjreTuce1hHCX5XuHIl5WnKMYsPB/+vyYqss97v9rOtFfi1QWPa8mIov3jXwPHYa+
 PX5r+Rw==
X-Received: by 2002:a05:600c:1e8a:b0:480:1e92:dc65 with SMTP id
 5b1f17b1804b1-482db495b51mr169015015e9.31.1770048252623; 
 Mon, 02 Feb 2026 08:04:12 -0800 (PST)
X-Received: by 2002:a05:600c:1e8a:b0:480:1e92:dc65 with SMTP id
 5b1f17b1804b1-482db495b51mr169014075e9.31.1770048251980; 
 Mon, 02 Feb 2026 08:04:11 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e3:8f00:866c:5eeb:fc46:7674])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dffd47c2sm95887985e9.0.2026.02.02.08.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 08:04:11 -0800 (PST)
Date: Mon, 2 Feb 2026 11:04:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 stefanha@redhat.com
Subject: Re: [PATCH v3 04/11] hw/virtio: Use
 VirtIODevice::access_is_big_endian field
Message-ID: <20260202105847-mutt-send-email-mst@kernel.org>
References: <20260201232924.93399-1-philmd@linaro.org>
 <20260201232924.93399-5-philmd@linaro.org>
 <20260202024316-mutt-send-email-mst@kernel.org>
 <87bji7pa2e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bji7pa2e.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Feb 02, 2026 at 01:08:25PM +0000, Alex Bennée wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Mon, Feb 02, 2026 at 12:29:16AM +0100, Philippe Mathieu-Daudé wrote:
> >> Endianness access is constant between device resets.
> >> Use the field instead of calling the same function.
> >
> > yes but the function was inlined and often a NOP. worth mentioning.
> >
> >> 
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >> ---
> >>  include/hw/virtio/virtio-access.h | 24 ++++++++++++------------
> >>  hw/virtio/virtio.c                |  4 ++--
> >>  2 files changed, 14 insertions(+), 14 deletions(-)
> >> 
> >> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> >> index cd17d0c87eb..f3b4d0075b5 100644
> >> --- a/include/hw/virtio/virtio-access.h
> >> +++ b/include/hw/virtio/virtio-access.h
> >> @@ -42,7 +42,7 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
> >>  
> >>  static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
> >>  {
> >> -    if (virtio_access_is_big_endian(vdev)) {
> >> +    if (vdev->access_is_big_endian) {
> >>          stw_be_p(ptr, v);
> >>      } else {
> >>          stw_le_p(ptr, v);
> >
> >
> > So this is the main extra cost: on an LE host, we now have this branch on every
> > access where previously it was all optimized out.
> >
> > Is it measureable? It is worth testing.
> 
> I suspect not given this is a well predicted branch on the control
> plane.

Actually you are right. I meant the cached variants below. Not this one.





> But we can certainly try an measure it. Do we have any virtio
> performance benchmarks?
> 
> We only have a few in meson:
> 
>   ./pyvenv/bin/meson test --benchmark --list
>   bufferiszero-bench
>   benchmark-crypto-hash
>   benchmark-crypto-hmac
>   benchmark-crypto-cipher
>   benchmark-crypto-akcipher

I usually use fio but whatever blk maintainers use is fine by me.


> >
> >
> >
> >> @@ -51,7 +51,7 @@ static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
> >>  
> >>  static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
> >>  {
> >> -    if (virtio_access_is_big_endian(vdev)) {
> >> +    if (vdev->access_is_big_endian) {
> >>          stl_be_p(ptr, v);
> >>      } else {
> >>          stl_le_p(ptr, v);
> >> @@ -60,7 +60,7 @@ static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
> >>  
> >>  static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
> >>  {
> >> -    if (virtio_access_is_big_endian(vdev)) {
> >> +    if (vdev->access_is_big_endian) {
> >>          stq_be_p(ptr, v);
> >>      } else {
> >>          stq_le_p(ptr, v);
> >> @@ -69,7 +69,7 @@ static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
> >>  
> >>  static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
> >>  {
> >> -    if (virtio_access_is_big_endian(vdev)) {
> >> +    if (vdev->access_is_big_endian) {
> >>          return lduw_be_p(ptr);
> >>      } else {
> >>          return lduw_le_p(ptr);
> >
> > and this one.
> >
> >
> >> @@ -78,7 +78,7 @@ static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
> >>  
> >>  static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
> >>  {
> >> -    if (virtio_access_is_big_endian(vdev)) {
> >> +    if (vdev->access_is_big_endian) {
> >>          return ldl_be_p(ptr);
> >>      } else {
> >>          return ldl_le_p(ptr);
> >> @@ -87,7 +87,7 @@ static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
> >>  
> >>  static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
> >>  {
> >> -    if (virtio_access_is_big_endian(vdev)) {
> >> +    if (vdev->access_is_big_endian) {
> >>          return ldq_be_p(ptr);
> >>      } else {
> >>          return ldq_le_p(ptr);
> >> @@ -97,9 +97,9 @@ static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
> >>  static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
> >>  {
> >>  #if HOST_BIG_ENDIAN
> >> -    return virtio_access_is_big_endian(vdev) ? s : bswap16(s);
> >> +    return vdev->access_is_big_endian ? s : bswap16(s);
> >>  #else
> >> -    return virtio_access_is_big_endian(vdev) ? bswap16(s) : s;
> >> +    return vdev->access_is_big_endian ? bswap16(s) : s;
> >>  #endif
> >>  }
> >>  
> >> @@ -111,9 +111,9 @@ static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
> >>  static inline uint32_t virtio_tswap32(VirtIODevice *vdev, uint32_t s)
> >>  {
> >>  #if HOST_BIG_ENDIAN
> >> -    return virtio_access_is_big_endian(vdev) ? s : bswap32(s);
> >> +    return vdev->access_is_big_endian ? s : bswap32(s);
> >>  #else
> >> -    return virtio_access_is_big_endian(vdev) ? bswap32(s) : s;
> >> +    return vdev->access_is_big_endian ? bswap32(s) : s;
> >>  #endif
> >>  }
> >>  
> >> @@ -125,9 +125,9 @@ static inline void virtio_tswap32s(VirtIODevice *vdev, uint32_t *s)
> >>  static inline uint64_t virtio_tswap64(VirtIODevice *vdev, uint64_t s)
> >>  {
> >>  #if HOST_BIG_ENDIAN
> >> -    return virtio_access_is_big_endian(vdev) ? s : bswap64(s);
> >> +    return vdev->access_is_big_endian ? s : bswap64(s);
> >>  #else
> >> -    return virtio_access_is_big_endian(vdev) ? bswap64(s) : s;
> >> +    return vdev->access_is_big_endian ? bswap64(s) : s;
> >>  #endif
> >>  }
> >>  
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index 242c207a591..1dc60d37cb4 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -220,7 +220,7 @@ static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
> >>                                                 MemoryRegionCache *cache,
> >>                                                 hwaddr pa)
> >>  {
> >> -    if (virtio_access_is_big_endian(vdev)) {
> >> +    if (vdev->access_is_big_endian) {
> >>          return lduw_be_phys_cached(cache, pa);
> >>      }
> >>      return lduw_le_phys_cached(cache, pa);
> >> @@ -230,7 +230,7 @@ static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
> >>                                            MemoryRegionCache *cache,
> >>                                            hwaddr pa, uint16_t value)
> >>  {
> >> -    if (virtio_access_is_big_endian(vdev)) {
> >> +    if (vdev->access_is_big_endian) {
> >>          stw_be_phys_cached(cache, pa, value);
> >>      } else {
> >>          stw_le_phys_cached(cache, pa, value);
> >> -- 
> >> 2.52.0


I meant these ones.

> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


