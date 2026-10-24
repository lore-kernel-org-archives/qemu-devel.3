Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB6606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dr+aEC5w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKX6w-0001nF-Uo; Sat, 24 Oct 2026 04:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xKX6r-0001mp-2X
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 04:28:13 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xKX6o-0006R5-8t
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 04:28:12 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-35f1f76ea84so2633159eec.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 01:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792830486; cv=none;
 d=google.com; s=arc-20260327;
 b=P6BcWuyAW/jbbpkKi6ETchdGYRK1FTXOYUdvMj+9JNrAo1dvGSRXHmlhpsTt76jWbU
 lC/5I1wZWvpcRUii6L4BQa8/GdOSPUv3JZi3splei2uAOnCjFxM8+Ax3m333UYpamTiv
 BTTV5pB5W2O461p/H3m8MZ+ajFj5Ib7mtSQ7KNRs+a2TLMBYiJ6oB8GfkTFjkIZhzFMf
 LTLvWmZiOWCBNVuwdxEVAKWARNRZu/dlzfsmAVqTfAzN8f1DbD91oivXElMTs8AXx/7a
 xZn4nVS3j9S3JOBQgRHlV0NZACUqACL46rDwS2tVAsWjJru2oUhAu5PI+rgaHCJTzXdx
 aN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kg/4D1s0bOV4d6W2icZJE9P/Owo9k+huzU18ZvVbNxc=;
 fh=qAX0oJxOOYE5IQsixN1XiS6rs9CNjF4Qy4Pvsd2Byrs=;
 b=kd/iuLoTTDt6pGgE0uko8E0zfYWf9k6nPaRVykjIm2FRdI+Y/BuqOSmB3ak4DXMf/0
 hDBrJl+rUsl+IvFjPUvgzRDxbNplX0zgRjjsisPMCgmi4zAhbt0UisNTmbI6Ub3vdS3t
 ljlqvjYzy3H6FmOcgB0SXxBGhGnb0y4N/OVfhTEncD3oEL4vnUGHZZUbh5PWFnraPno4
 lYB5VluscWHy/79Ta0YJejSOBMFsTfqonv+axFnRHH4DZmBfZca9LBBwUM5pWId8WRp+
 hlMdHOWUeevMLOzRjTb6z/nxBRaPvRvx76rogwSBP4mXC6v3A1ZFRNlpZ/P5nWKvixWi
 5hXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792830486; x=1793435286; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kg/4D1s0bOV4d6W2icZJE9P/Owo9k+huzU18ZvVbNxc=;
 b=dr+aEC5w8f6XRHLTrmpgehm7gzymTEqnSXqndjqRtxlMbCCXFxBpHw00KDWhnzgUIf
 58XvCH6MRTWxAATMUy4MBB90pgXXmhvVfdVcPWHpJuOYPaQ6nMALdJ9mZAX+nRkIb9yS
 g2ux6eub8lVdnLMZVH7P/Z0QhRGVbafcF/A7232sHSAwTOC1cJEoFAfX+mzcvcJ2cmt0
 udF7ib0tUSRStn2fQrbW7pq82f0/2S6a026j33c2ifh9MS3pAyBsvXpyoybddA8N3gPq
 c7+AfFqKtQwRbmfrxWkCZEMuC8s6XswNANFsEeZi3VUaPKiTzvLLXJoxSo6JstgLVI39
 hdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792830486; x=1793435286;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kg/4D1s0bOV4d6W2icZJE9P/Owo9k+huzU18ZvVbNxc=;
 b=G/USvuwIDt2NzpdLS1fwP73pnG7eRofqDQ6gdMSl5nYzT4oGye3fh+U55LlZJKmoIW
 ReRf1pq+Yc55jqhygrgIH43IgOK4Fb9UulSHNz7LxXR0pzcQWFKCYF8k/u7jBU8beWw1
 BE6VaWSwMduUIpiNp1Qw5+0MQTTLOMCI60KFRAyvtKWPEvqJGiXpobxF65ve+l8ccIoi
 SG66iE8bnEjjRMSASBDPp9SUeL6uwfkiVgPM9kGmVAiyBuSN1Q/VDGxDrwm2DoL9sKt+
 yV4q0gq+pbjOIEFWerzmadth1PxpRPUcYT1dyNP6fES4chvR5zVCy+5GyLlptpVJic3Y
 t8OA==
X-Gm-Message-State: AFq9FYJhFZGsa7q1GZxJluWiqVr6nBtB9EdzUAM+rXhCw7+06HmcLikZ
 GXYPgTOkZz+iUjkkn9DIH9XHDMAB9gmxaMjrbD0DHfm7+skcy5ckk4kCWpPmv1pCstL2ZS1HFbN
 B19FccfnjdMcrKOfHVxwckSNzOGqvTmjuRq5yX5U=
X-Gm-Gg: AYBFou2XgBowwIOcuv0eLaY93gROd3sPGPb5XzQxVoRCfFw2bS3o9GPwCtdGtBWPfus
 Uj6BBICFCpsNMVoLqlHf7E1/myQ3qNxiI6HrypEyt49kZRVK2CF9Eqe+WC9iwBIdrMAYzkSf5Wk
 lgTw2fvWx52gaRLMKZo/LqUsw9DKE4aYRxWWQEMQ5Aw+NqCDYoKr7lU3u20+fWiKzUuo+DB3jv4
 OWDedlLWrl+6DHTX8qjBkDm13ZvZSUGArFmd2T3F8+T4s619DcqUxP09WZjK5P+WbK7DhqU+Xgu
 0/zdLf2PEISHogC7xbmkhSaIzGIQniF946QZ55I8WoGYpSjx/vD/Bn0b87vLSb/qAhXTLgimaM5
 uH1UVjqfrUgPSO90ofIN0bQ/0nXEemTyyydq+nsBeBfednV8touY6c0MijMQFBJceX9a5Xstp/8
 4mxfk1RREfC+axFzk=
X-Received: by 2002:a05:693c:2a0b:b0:35d:e9b1:1c6f with SMTP id
 5a478bee46e88-369e820d99dmr1927862eec.0.1792830486324; Sat, 24 Oct 2026
 01:28:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016122113.226920-1-apolivodaa433@gmail.com>
 <CAGscdFvtLkFsLaTzWLPd=J757ioWyFmBKds_yb467WY7RrqhJA@mail.gmail.com>
 <CAGscdFuxDUWVsNOsLCwHjqT4KYGp0aoBzrUjp9svjLyofi1uoQ@mail.gmail.com>
In-Reply-To: <CAGscdFuxDUWVsNOsLCwHjqT4KYGp0aoBzrUjp9svjLyofi1uoQ@mail.gmail.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Sat, 24 Oct 2026 18:27:54 +1000
X-Gm-Features: AclHuK8ALAcmwyvVqWS4AbKOsYeXSMZV2EVrgXBfJFo2Job78oQejJzzeHfAQDY
Message-ID: <CAGscdFsYAYi_mnN5R-AkQJx30rHnFJ2NFq4DFja2OVEWjgF8qA@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Reject VPINSRW with VEX.pp != 0b01
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x132a.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, PYZOR_CHECK=1.392,
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping
https://lore.kernel.org/qemu-devel/20261016122113.226920-1-apolivodaa433@gmail.com/T/#u

