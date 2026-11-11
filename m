Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1310606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SxhRYwsr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR5rX-0003kw-3y; Wed, 11 Nov 2026 05:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5rV-0003je-Rs
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:47:29 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5rU-0004Uk-7d
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:47:29 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-491846221ffso2129493f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 02:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794394047; x=1794998847; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BP+eLEtNYsMHdJI96KAlkCbOSax1DuDZb5lIz4KBSoM=;
 b=SxhRYwsrA7ehRr4TJJ+6gtNzTx8w0cERn1hwALr2jO+KGOSuerB11zxecRTg2VXmYu
 oNLUX32UC5UMLnmH4pGvR+3hCR2MDrJz9rfI1OonYtzp4ir4PAPYSvFMk+7KDBpsA2KA
 oruk5HThlXerr2JCm2MmAMenIO+2P2ZUBE4xg9L20ORzRec3GjHqfxdYFj6vFvDo8ayf
 4Il5g9NseqiudXirHUFamaXNFjdxBg636mO6ZpmCdESxsGjMylIvrJrwVKc3OrWYyUDx
 BM0yrmSmxSOSuZ9xtm44Wr9OK0qlinfG1ye9nm1GCEoAlixvR77PspcKfp8Wqe1okOeO
 ACRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794394047; x=1794998847;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BP+eLEtNYsMHdJI96KAlkCbOSax1DuDZb5lIz4KBSoM=;
 b=FXhsYZjBrAbUrt2xUDABxkg4uBpATI4+m4yl0zYPW9ARBvJiMfmI63OEaiKfNWpRGB
 jhz3LMvwn5DzqDIRsLqTId6OsnY+FQKzwr1tG4rKYuQT8GuCyy5ZQN9/L2TxRIIqHnma
 odJNPS6hLshJOT+c+Z9HogOmXxik9/HTd1inCjSzVYsPt6TSsqqaLcQfC6Ox67uVXMnF
 Qtsw9zgAuhPkZlpGPmSQWwZm9vFaHaT3ZRtZEY4ILT8pvwhgiV12sICST1XZd0wmcauM
 P61MOoo3V7QhYkyUXkYr9qNBJYHoh6cV/TGpQyvewpDAxtQBj5XCTp+vPXOJFt8Q/jYU
 6y6A==
X-Gm-Message-State: APuU4Z+Fopyic6G/4SYo0rmUwj7/6ZwejZuyecVVgBROoBcf1/Ykrsnx
 g7sOHXw8Tlt50Kwh4m4gDDdiiz2l0VcFB19nHnVWARxVrWOwLk3k5wgg5ubqvd5oBec=
X-Gm-Gg: AYBFou07nX4iMxEagCy/TpXSaGr7qd5JcGHbcsLNrPQ1TTRQnQsKxF0BYnXRGi377pC
 lv3euf1tMdWgcTRH81Q2w6/Ywp3A6gcj9JN5bzB/WLh9Q2GCQlQjSl4GOLlBNpCLa3Vw0kKWLgm
 w9rhUMiA/MCJcFNvONZ3RWV7jUx2WWBfqSSi06wBJEZs6r2M6bBpqu9Pkcw2aVPb8E7xZyEM9/m
 dPUNnGz6+8+Kpse477I02C0m5O+fN6VVqOt+Vf1roQ9NBDs0wDVf7AJ90vXVPWcG3Ici2xyyEyB
 xexYRBhOrk8x3SzbYHMLrAvw7jGKg/rZ78LyjbA9AtTo8kdu3o8bVGHfgMAcdVVkmW9st8oAx4v
 nax+IIcCAMIqhGoAr7ABusfXXoiBMF+tJKpTppJmvzXuTUPIywEqp6eyl6kh2ZdNy/7HFMOqibm
 EKw6rPEgYQ1mqt3eIAbboBp1K54NCTzpHnbGF5VEdHYXTGbQEeQte85Tywjeetk/LJmYUtdaMnf
 cWfJq/lHiRuolPplSI2/dcoX7AxOWQ6AGA96qMZdwG2s2lCXjFQtggh/0DN+XCpW+OprneDzYhS
 Y5Igsu/CSgha/sMRzP7Ud2XJqvZW9MUn
X-Received: by 2002:a05:6000:18a9:b0:48e:679a:4aeb with SMTP id
 ffacd0b85a97d-499c38bcd22mr3577016f8f.3.1794394046711; 
 Wed, 11 Nov 2026 02:47:26 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:81bc:371c:5725:cc4d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49836c835fcsm9821340f8f.59.2026.11.11.02.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:47:25 -0800 (PST)
Date: Wed, 11 Nov 2026 10:47:24 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 3/6] virtio-snd: reject invalid feats in set_pcm_params
Message-ID: <avRHvJMPwH4Sq2Eg@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
 <20261110-virtio-snd-fixes-v2-3-d5b654217676@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-virtio-snd-fixes-v2-3-d5b654217676@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42b.google.com
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

On Tue, Nov 10, 2026 at 02:39:32PM +0200, Manos Pitsidianakis wrote:
> Do not blindly accept features for a stream, check them against what we
> had reported to the guest with pcm_info.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/audio/virtio-snd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index f1dc03d1b8..89406f0a3a 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -351,6 +351,18 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>          error_report("Stream rate is not supported.");
>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>      }
> +    if ((le32_to_cpu(params->features) & ~(stream->info.features)) > 0) {
> +        error_report("%s: invalid stream features. "
> +                     "Stream %d offers 0x%"PRIx32", "
> +                     "guest requested 0x%"PRIx32
> +                     " (invalid: 0x%"PRIx32")",
> +                     VIRTIO_DEVICE(s)->name, stream_id,
> +                     stream->info.features,
> +                     le32_to_cpu(params->features),
> +                     le32_to_cpu(params->features)
> +                     & ~(stream->info.features));
> +        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +    }
>  
>      st_params = virtio_snd_pcm_get_params(s, stream_id);
>  
> 
> -- 
> 2.56.0
> 
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>

