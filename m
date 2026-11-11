Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC9606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NSQo4CO3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR5ru-00043h-Jy; Wed, 11 Nov 2026 05:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5rt-00040I-1L
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:47:53 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5rr-0005NQ-Go
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:47:52 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso2668788f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 02:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794394069; x=1794998869; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7fW6jLHE/J82EIXH52/OhhWybeNV5uJE4PQsZ00J7GE=;
 b=NSQo4CO3t1KR5jgNL6r+Hgmg7bRYFkXD07hk8suphGVRODV9xQ9FY7Rql8SE8MxQ7f
 BPgEh5Vke6CJ7KCJPPaKCTLARH/d4dVKpOK008LEV28mKZ2+0+ARNXQoHLGdrsej5ZxB
 I4sO8UrimNEACLYdxU3uLmFTbrvZ/R1C0UeS5GvKajcIexRQM8ZIyFnbbBo4G95ip02S
 AkCdwfa4gxR5hs25GHpewFtXpwGO6ti3C/tly+XTAg5p2DzaXLo8jOfyNySIMQjTZ7ji
 /5qLOQGnX69oqgz613aWrponktbH9Q0vOweYSeXQkdpX5d+3PYMdLdDT0Jz9EnmPzj/y
 K2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794394069; x=1794998869;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7fW6jLHE/J82EIXH52/OhhWybeNV5uJE4PQsZ00J7GE=;
 b=hEUfKuzo7ReHnoTff9ag8soC8akK8p1K3O+21TOB8Qpt/RSzfcQYTDJdhOcwF803M7
 NQhX4PFOD/8HaS1rVvEhK+q8Os4oQqJg/DCGgzefYxk0QMlaooHc7BldRE1igoKyGEUL
 TQtffPF96kbW1C+DWIXNZCJtLRHzxefMFjQZit1dNQawgafegIcrcfEh2dsF8yLF7Awd
 GxOXrDV4dUzM0oCQC+uBeTZj5dx1qIaKq8KjZbA9uesT8Pe9JNidc9qTDVNEqx4GUHLA
 Aefu6EhJOienC/IZtJFVJU9GkRNO1NhNdSW+o8Hc8ByXBpkdwx7QhwUZ8VUbi/NFl+me
 wMKQ==
X-Gm-Message-State: APuU4Z/PYuTxJQXRNMbvyAO1vQeZ+08h3B+NsyQ+Ckd15dRWo7chDbgm
 OT+pwdpmNe1MuBcCRdPsxush4mBhZbbZFLnQO9eQh+RctNWQS74v7Ap7xUN9PwgOFzo=
X-Gm-Gg: AYBFou0/+1brco/L4fuRVSGjaJJcASMTTOh2+8GKkeGS2IVHozD8hPw8OIg8WTCz7jL
 LzOIQQBk8Z1SJhXJi//ObEGS/muURrIvkj12PMVwX9R9aTVNTa6srSQl/fyBhSpc034XiOT5j1V
 UMyBG/kJyONml5qyoVJarYdH3u2ZeeWPV1NWAWhEJXf9ugVWW0YHvUzp7IAqLiwK8ShzsZXFuVw
 5ejGrYAwse0NJYNAMsZ8Hcevlwv8tdm8f7agAqBplvTZpdAqgF2mTqYimXR0WsSFqOzDcNyB1xY
 C3sFxjJ8kQ8uqXrQ/iadWXFIfotBi+ZU7hrSC0nMt54nWBG4Q8g+uzQ+ivHJdy7Wa7wC8sg7J3R
 LW1C9sVKT36CbWAcKiFEkvrTAuttycJ/9IckBJvL1kjzAkLxYOfiWaouCwctx6cDQcfuiFW9ZwH
 uU+OcITSpNSJhuLuOIu6TyA+Kih9VH0V1Z/wMjZrerubnFLHUVVQkokmb/qkKCCRnfoS6vO8lJL
 PgoqiqE7iDpX5jM2od+OdDDx7fJpWfc2xD/B3cDdB1sal/WeA7wnHpY9SE0GiJKQjBAItsWg0Hu
 QqIaxWub5QjS45u0PG3jCZHnCGZEG7dR
X-Received: by 2002:a05:6000:4b0f:b0:492:3176:3d64 with SMTP id
 ffacd0b85a97d-499c472020emr3131839f8f.8.1794394069591; 
 Wed, 11 Nov 2026 02:47:49 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:81bc:371c:5725:cc4d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983600bd6esm10537473f8f.28.2026.11.11.02.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:47:48 -0800 (PST)
Date: Wed, 11 Nov 2026 10:47:47 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 4/6] virtio-snd: don't allocate pcm_info zero-count buf
Message-ID: <avRH05rhYYgTr-sa@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
 <20261110-virtio-snd-fixes-v2-4-d5b654217676@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-virtio-snd-fixes-v2-4-d5b654217676@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 02:39:33PM +0200, Manos Pitsidianakis wrote:
> g_new0() might return NULL, which is UB if passed to a memcpy
> implementation that does not expect it (not in the usual case).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3778
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/audio/virtio-snd.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 89406f0a3a..a7d749f24f 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -267,6 +267,11 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
>          return;
>      }
>  
> +    if (count == 0) {
> +        cmd->payload_size = 0;
> +        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
> +        return;
> +    }
>      pcm_info = g_new0(virtio_snd_pcm_info, count);
>      for (uint32_t i = 0; i < count; i++) {
>          stream_id = i + start_id;
> 
> -- 
> 2.56.0
> 
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>

