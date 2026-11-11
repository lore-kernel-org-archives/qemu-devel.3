Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846AC606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sWs7VoN8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR5qi-0002TW-Jl; Wed, 11 Nov 2026 05:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5qe-0002Oo-5n
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:46:36 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5qc-0003jy-FL
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:46:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so24838375e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 02:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794393991; x=1794998791; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XwKGEcTe88ku4wEuKH9DC68y+2uo3WNWgjrysEvO5Zs=;
 b=sWs7VoN8xEgbiHlVKm7CipOL41PBU8Cpwqp1Z0ht098ouxqQfS1NlA5jGImXEJ5Air
 ClYvJ94AUgFbtSbNv+oWLZjHCJl1u6Pzez46v5IRUPM/DYa9+vsV+aViXV6sGhr/P0JG
 9pTAstvDGb2ZioYgnLZaXyX9pb7wSr4Ol9oEtm3oBCtTYjv/PKNJ0z9xTFlAoLf+vcNV
 jIwGzji7CwGCaDHP5K83qDartvgd2GJCz0U4hyd2XOHlpLDV0YFBT7OgWhhMg4V+x5tL
 F+ZB/Onv03rEqNS9QXvRXLMPcuYGHDFcub2wofSz0CZ5R66r8vn2gIKFINdLI6NY/a5S
 FDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794393991; x=1794998791;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XwKGEcTe88ku4wEuKH9DC68y+2uo3WNWgjrysEvO5Zs=;
 b=agVEaDLm+SoSP9dxv107wnBRSuMe0wU4RDpt2RiL6AMm+vU4qdKOXPxAYpXWSeLuP8
 wxvG3hv4SYTZmE3kdLtJHDZvojPkjGB2XXzHkrzgunafA6MttFQW4iK3oKK9uBn4zxPP
 5jdfYtNoyHlbJcaFNvhriv+P3pWYswAyuZcYuXPoAvJkzab5djnDSZEMfsqOerMWtnP6
 jVGSiUsB0IsdYlgE6F2RLpprWfKRJFNeiTcXHoGJz04v9XtZ//cbZZetLgIPAOXWTsRZ
 lCXzJ6Tq1PtIyglEUewwGtHnRPRef4q5f2ESEtmgJON5/xKg1rC3HQRzX263k5n/Bsfl
 i5pA==
X-Gm-Message-State: APuU4Z9bC1/i9hRKpeD8BVYwhBkNG4wIi31dwLIxmoQOXZISRlrYfsIa
 pQ93xK8QnfKna3eZbFGSGN1w2uFK4JQo/lrBULdhRJF50d61pAMKXeXdAdM6qAApUjg=
X-Gm-Gg: AYBFou1fPE504lfVhgbn36tkkY0wrSJDZT0N2sofR7xP2z2Uj6kyuLAWQutIFwBgMzJ
 uzoRoJeWdCbd2m6VnHXNC+cq4JrHTejShjVCmSAB1N4szomFNuSq9a3f3vBsRfmn2c3FXry9XhY
 8pHhut5FE3UtJXuUCE+Jov8c3DP84OnVnFY8AeyGf+Lc7wrAerL8VOfyfHSKGJsiIVgGDIDuquO
 j+dKtdxICOvc3yv8FatCvAlw/YpHzh7UhblP+C+QcROmNX1il/tKzY/IvKZuSUP36IE3Du//vop
 4LE8kShj8xB0iwU+m3qCrDoq/jh33dNWqht+V00uB5bOnGMa1F1y1Gn9NRNPNpz3TuZIO57al0e
 YdTRrL0kKzLzZSEQrpIrj8pvk9b9NzlGTtqN59bTs/WzuTvdYpAS2hDsedZikBiXJhG77s6+R0t
 NCsiFtixjrguSg6xvk5QAJTcIVwcCtL1Hs+CDjT+4CTiF7aXScRXEwzOm0VYlCo3lehQAQfIn36
 nCHS/DQw+85e5H2+CuJGj4vei2yOGqROBRJon7qPFraL5T2cUlhNixUwLArxjMD1xqohEW1/CoW
 eDvXCcwwiOqqFjskLrzLvjPTkBEcidwl
X-Received: by 2002:a05:600c:4f12:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4ba09365bc4mr38856045e9.17.1794393991199; 
 Wed, 11 Nov 2026 02:46:31 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:81bc:371c:5725:cc4d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fdac9csm200910805e9.0.2026.11.11.02.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:46:30 -0800 (PST)
Date: Wed, 11 Nov 2026 10:46:28 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/6] virtio-snd: convert virtio_error to error_report
Message-ID: <avRHhNt-dZoGYmsz@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
 <20261110-virtio-snd-fixes-v2-1-d5b654217676@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-virtio-snd-fixes-v2-1-d5b654217676@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32b.google.com
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

On Tue, Nov 10, 2026 at 02:39:30PM +0200, Manos Pitsidianakis wrote:
> virtio_error() also signals a RESET, which is not what we want: we want
> the guest driver to read the VIRTIO_SND_S_BAD_MSG response.
> 
> If a guest sends an invalid command and we do virtio_error() and reply
> with a BAD_MSG response, the guest needs to detect the device reset
> otherwise it hangs forever waiting for the response.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/audio/virtio-snd.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index fb22d79949..bed36203f2 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -298,8 +298,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>  
>      stream = virtio_snd_pcm_get_stream(s, stream_id);
>      if (!stream) {
> -        virtio_error(VIRTIO_DEVICE(s), "invalid stream id: %"PRIu32,
> -                     stream_id);
> +        error_report("%s invalid stream id: %"PRIu32,
> +                     VIRTIO_DEVICE(s)->name, stream_id);
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>  
> @@ -310,8 +310,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>      case VIRTIO_SND_PCM_STATE_RELEASED:
>          break;
>      default:
> -        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
> -                     stream->state);
> +        error_report("%s unexpected stream state in %s: %"PRIu32,
> +                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>  
> @@ -535,8 +535,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>      case VIRTIO_SND_PCM_STATE_RELEASED:
>          break;
>      default:
> -        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
> -                     stream->state);
> +        error_report("%s unexpected stream state in %s: %"PRIu32,
> +                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>  
> @@ -624,8 +624,8 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
>          case VIRTIO_SND_PCM_STATE_STOPPED:
>              break;
>          default:
> -            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
> -                         stream->state);
> +            error_report("%s unexpected stream state in %s start: %"PRIu32,
> +                         VIRTIO_DEVICE(s)->name, __func__, stream->state);
>              return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>          }
>  
> @@ -635,7 +635,8 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
>          case VIRTIO_SND_PCM_STATE_STARTED:
>              break;
>          default:
> -            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
> +            error_report("%s unexpected stream state in %s stop: %"PRIu32,
> +                         VIRTIO_DEVICE(s)->name, __func__,
>                           stream->state);
>              return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>          }
> @@ -724,10 +725,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
>      trace_virtio_snd_handle_pcm_release(stream_id);
>      stream = virtio_snd_pcm_get_stream(s, stream_id);
>      if (stream == NULL) {
> -        error_report("already released stream %"PRIu32, stream_id);
> -        virtio_error(VIRTIO_DEVICE(s),
> -                     "already released stream %"PRIu32,
> -                     stream_id);
> +        error_report("%s already released stream %"PRIu32,
> +                     VIRTIO_DEVICE(s)->name, stream_id);
>          cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>          return;
>      }
> @@ -737,8 +736,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
>      case VIRTIO_SND_PCM_STATE_STOPPED:
>          break;
>      default:
> -        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
> -                     stream->state);
> +        error_report("%s unexpected stream state in %s: %"PRIu32,
> +                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
>          cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>          return;
>      }

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


