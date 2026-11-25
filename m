Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF30606A33A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPXARZCx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWB7G-0006P8-ON; Wed, 25 Nov 2026 06:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWB7A-0006O4-Ee
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:24:40 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWB78-0000zP-BJ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:24:39 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c50cc7540b7so793250766b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605876; x=1796210676; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gzc2evg1RQu08SoZpm7hU+pHzGBQ6fSq/GTpySlh5ek=;
 b=lPXARZCxRuk9mfj9v9ZMgPOQvqb2MqBp1Untd9M1muhZrq7XYgUPJLI2aQl5emC+ce
 g9wIQRHwwv12otGRVTY5HW2lUJE2280Pk5nLk4O0Y0GCnuZEoaAuyaXonwcPX7uZwOez
 Dzr9P+XSXRPSxgXKudzM/cvu3Pn/HfD/idXWU+hXg08MQc7iUDUgpPeHUDjw8HKLf4j8
 fOo5YyM7spkgxNNRr4ZXGD1vfKMD1be2RRFse2FbdvbF9+9nMcNSaX+4xtUE6lTsgifb
 v6G9MYnR8sJVQ1c1u7s9pW2eqWzQcAGRv0psKM4vts/Obw6tpZvGDAWZZ4X821bxvixg
 5uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605876; x=1796210676;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Gzc2evg1RQu08SoZpm7hU+pHzGBQ6fSq/GTpySlh5ek=;
 b=Lq4d7UoDg+myILQrYHRe54SA/QfwCE5t+2K2DkWU92Btchq1QRIxhdnUIILyRsQrqv
 mueq95rUfMYpLW34VOCqEQCJJ8os33YIYrttbNPcOLX3tsn/3VnMa0pv7sNFQ3tkA0vJ
 2fewSLVCiCF43MO3UHeyVTmBbvMZmHPHNjJQ3l/f9NrVzsM9EnV14D18goN4lHsSwrWG
 ho9K3X5VLWyO0QV54pDWPh9k/tlIOJ2sZAk1VtK0Jjw6IvWj1g2wEMwqW/2HJcGsz1Hi
 U8IRosMW0Z5gxixLAd3yiVpSo/4iQfsmRbH2EcTTrqrRlUImK9zJB2h8JQnLIp0H1adl
 VEOg==
X-Forwarded-Encrypted: i=1;
 AL+hErET7zsxDogjbqEQqt4Sho4hGg70J2cRvxAlTL6iH/8JquJoD9529Xfr972Gf5inHL3dVpC0pBKwj+oQ@nongnu.org
X-Gm-Message-State: APuU4Z8bM0ZYZq+wUObvZ8cgyBlNT9iCr5G21sF8VLzDiTp4/r4aPwbk
 OXEwUdpU1PZcYN1FV4XLHKU5ru/mMBpCAEepI15T0xiacIUL+NSGdw9W
X-Gm-Gg: AZFdTZf+iRFPs1gOxg5BW3fnY8LWJ0UoQUc5OlJnw3YFsC3Hzdr/3MqULTvYjI+R4L4
 UivBYwuLQCwcPRAX+qFM8k9vPtNriFObkJTgyf5HFCl3V+9AeBvkltHrFewrFtdpJ2plNCYhG/8
 wBMuWh1SVIIumpULVO5IBP+alAA7wXejXOBBKoUKz1KmaLXshdzIdMW06Zz/Xd0LBw9eEcShzG+
 GLoxnfLRkT8qBO5ro+adLw/EP3jhz2W88pLoC7sILqvJlNmSI2l8rUYepPt2qaYOBQdtPkSteIa
 mS0Fn1mCHlxJRyCeWM924EKeBJPojxwJdqKDFieA2rfbgniT7OQulM08i9xJiH1nD+O7tOtCyKE
 uK2cRSYA9HgwsU80JRpoRoJplz1x0w1k+wMCUYBX/QVPeP7ApWerGY+oYnBmMWY3d1EEBdwcGmk
 AO+8UYJv1000UUIQf7zHHO4Inz3AcG5F9P+uikujNfs5ZGezgPWbuEAaU89zFcQohGh+83YCKIL
 enTQgd+sAVG5DtLfKHYwO0DW9WzrMQ8fAAwVc+WadolunUMlNt2LWoe5ssSG16s21FRw3cx1g4G
 ilbRmg86LgpNqI68d6aRY4cavGbNcFCOuJY=
X-Received: by 2002:a17:906:115a:b0:c3e:ee86:d2c with SMTP id
 a640c23a62f3a-c513a866684mr1271536266b.27.1795605876461; 
 Wed, 25 Nov 2026 03:24:36 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afed51asm608298566b.76.2026.11.25.03.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:24:36 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <883b59a1-8ec4-4047-a3c7-d7980730f6f1@xen.org>
Date: Wed, 25 Nov 2026 11:24:34 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/21] hw/char/xen_console: Fix buffer trim when size
 exceeds twice the limit
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-14-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-14-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=xadimgnik@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> In buffer_append() we handle a full buffer by discarding bytes from the
> *middle*, preserving the oldest and the newest data. When the overflow
> exceeded the max capacity (a limit set by the guest), the memmove()
> destination was miscalculated and ended up before the start of the
> buffer. In that case there is no older data worth preserving anyway;
> just keep the newest max_capacity bytes.
> 
> Fixes: CVE-2026-123071
> Fixes: e57dd20bb706 ("xen: add console backend driver.")
> Reported-by: Giovanni Vignone <https://gitlab.com/gio24>
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4191
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/char/xen_console.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

