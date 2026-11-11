Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01076606A33F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eJTurNN3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR5sm-0004m0-4v; Wed, 11 Nov 2026 05:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5se-0004k3-Dl
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:48:42 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5sc-0005SM-AS
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:48:40 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so27776375e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 02:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794394116; x=1794998916; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NAd/O0wuZZ7hERm9MjJ09UFIbcx7+f1jPsRVQwQ+hmI=;
 b=eJTurNN3Ae1RuqbWajSE+zL42tRRz2UNUrGveMuEwVOtGRuhA0HJ/z1hudKmhNoUSx
 49VG7wi18A1ubdkmjo2a0OHJ62KpV7Atj/JaTEQ5kIGWYPTnaqg/8gSM+4TCPTg5PLvt
 ItNieHQjcU3FxG1KnxWEvt5ApoRB1aiuHzJFGN3MrbUXfqsK3aWBaY88/j1ce5HlXLcN
 TKWNlBhBRhvHmyCyNuvIrSjjmHwf/LS2Rjf1Sf38wGhvfdieEV2iLOPq8HOLM5giNUT7
 HKujFNawMPdVZaMdtFFz+vXKXZxrsx62R+sGizX0fmwOUGmu3+oOHILT1nhuJXR2Jh16
 y1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794394116; x=1794998916;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NAd/O0wuZZ7hERm9MjJ09UFIbcx7+f1jPsRVQwQ+hmI=;
 b=gqzXGmV2aVxWnsqcdSXWfaJIw3oLb1UFNRuyJd+1onovMchZ1CGa8TUTyqguS7FaJ6
 4tI9YSLzhnRQ2wpd1ASw+iD9/F9Qjto6P/JyLbqQvN4BbtTTC3D4EvSDlZ96Cr91JCnO
 mvHJrNV7P9IcpREE92k/RdXBuoMs4jvzX3+P+1hXkLBmfZ39T+DdCZYjOmjIfy0anVJc
 PT8MPljMYP3a+OoOZZSftgwc0JRS0ylH6o3hqafYUNuC/1iJlrFShIfN0lNrrlx0dwvk
 JI+7oHQAYlI9eBF5jmE86W8lyYkdsKFuiYYF+QDmrTaq9jkdWzc/HSvj9a5K++50Tg/g
 HwoA==
X-Gm-Message-State: APuU4Z/zoB0G5uagTe9FjdwnLytc5d6iI3Y0V5fjiUwCpPLmd10Z6IA5
 hFmC3k/FaKJrlCElJNEYVvjRc4VH/Y4Myy6HmBVj62+BFehbUnejJMMXpUZfUa83NBw=
X-Gm-Gg: AYBFou3fqTlNkWYtDEMkitoqW1xmMeweHipF5op6k7NShNFwQO3LasZMa0Xr4Gf0EmQ
 bo1z1W+S9uGFFnL5nR838w2OZpG/FG4I1hESxzMf2SuhuIBhq0yR/Ggc5wk73oJM9qJoWBNuPOb
 gE1KRo3SC7pUQqq2ZAM3ILb+B4P24EM04u2RnGcxVbvYTCZrjrNspW+/qeNNFKpMxBhkRMZrqs7
 V0F50/+s96wqdpGiVJFMMzROLda0Ntm5TEosWFYDtIF+7/8yOWM+AEYAIaCmn1t31E7C4UwLzDk
 ThuqME4Q07DS/SaQST9OzVXDhG6FHLl3U7LhVcDkyWs2g9pdOvxSDWwtnFw9mz4udfITaTbSIzv
 izmxjNNoeZPyUMHyYneIeohC9eQusISzCnofuHu7K8bkU58Pe4iAKo2g5dhvNtwrBcAKN9GjEFU
 wQX5OZVZlZKr0i/TQ7HxnV7p/sRD/PSI9CpamgzYlNt3kWMseiEL3KmGBAGDsnhTD0tIRoMC9/J
 +AyCLPPAxxZzFpoSfwI5TEYfO+DhW2iHytX5Z8LDKSKhJhUAJFTkpNBrX7aeGGNWtEBQdWpi4Xt
 I2v4BQTRjrHUbAt+jnkW3yaiurMimsDn
X-Received: by 2002:a05:600c:34c7:b0:4a1:992f:d0e7 with SMTP id
 5b1f17b1804b1-4ba09391696mr33590735e9.16.1794394116401; 
 Wed, 11 Nov 2026 02:48:36 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:81bc:371c:5725:cc4d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585c5b9sm10026631f8f.9.2026.11.11.02.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:48:35 -0800 (PST)
Date: Wed, 11 Nov 2026 10:48:33 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 6/6] virtio-snd: period_bytes divides buffer_bytes
Message-ID: <avRIAfyzFSiMPGKR@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
 <20261110-virtio-snd-fixes-v2-6-d5b654217676@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-virtio-snd-fixes-v2-6-d5b654217676@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x331.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 02:39:35PM +0200, Manos Pitsidianakis wrote:
> Add a check for the VIRTIO spec statement:
> 
>   5.14.6.6.3.2 Driver Requirements: Stream Parameters
> 
>       period_bytes MUST be a divider buffer_bytes, i.e. buffer_bytes % period_bytes == 0.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/audio/virtio-snd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index a6036d5b75..1cbc4da752 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -380,6 +380,17 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>  
> +    if (le32_to_cpu(params->buffer_bytes)
> +        % le32_to_cpu(params->period_bytes) != 0) {
> +        error_report("%s: 5.14.6.6.3.2 period_bytes MUST be a divider of "
> +                     "buffer_bytes, i.e. buffer_bytes %% period_bytes == 0. "
> +                     "Got buffer_bytes = %"PRIu32", period_bytes = %"PRIu32,
> +                     VIRTIO_DEVICE(s)->name,
> +                     le32_to_cpu(params->buffer_bytes),
> +                     le32_to_cpu(params->period_bytes));
> +        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +    }
> +
>      st_params = virtio_snd_pcm_get_params(s, stream_id);
>  
>      st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
> 
> -- 
> 2.56.0

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>

