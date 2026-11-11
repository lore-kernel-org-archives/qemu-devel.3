Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SZMfgABg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR5rB-0003Cw-By; Wed, 11 Nov 2026 05:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5r9-00038t-Ok
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:47:07 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5r8-0003l4-40
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:47:07 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so17944565e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 02:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794394024; x=1794998824; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZF7b6UmiKlHJjKuXVXbtK1bIRtyKE9E/RPjsPR7w3Q0=;
 b=SZMfgABgCZqybWegoZlXgTdN6OZ1nipP96P1jVtI12KvJlbmfbNG5rdLdTYy2DyN0G
 HcfV0+zSZTwvVJsOmwEA4NwbQtjunXPpAE+16S2wzpWm3z0nVMvFumgzjKitkup8pU6L
 0EfWt3ulxHYxMFkW6ZQmopGHGMo7xwTt7RxiKXB4r483n4PnDrgD2yP9j4Xb2Sb5uPM1
 Mp0W3d49fFCNqLIljEDJ94ro730V8TK1oEO+f+lA/MLjKtYAMjjvJSefmEEWuQ11Dn9O
 DR7cL46z38vNl2K8eVNvan8+omDs+3RIbBsoD84GBrkMDakGHA8fchO2TkhVWyfYvI/F
 Gfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794394024; x=1794998824;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZF7b6UmiKlHJjKuXVXbtK1bIRtyKE9E/RPjsPR7w3Q0=;
 b=MDA29sdiZQgg/nnA6Yk/BeZVy3lbWychp1AC7HnKnYr9NpEB/6frjoeXRTJo9k2YFd
 nWdYKULVRmHZBTZKwo6ecqCoFlpDG7brk4aeOarVnQVxja0WsudY7BvTEb2ZoOPt7cVa
 ard1WRkzRqMCFgWtItdsVrOtwNZcLsKixWPngn/6wQID8F3EfOHGu3yd8XkvdV6NN3w5
 +naeJrX+NAzDnYCQpzJ2xLnhLjM+fpSgRg5hvT7ReobuALY6MN6gp+xgNEKjR9l+/7ax
 U3xxKtlXLrCtSGsFS/ArP+TYqYpGqYtXhv8H9hMoOaPJSUKJivyi3L63hA3TqJT4sUyr
 /LBg==
X-Gm-Message-State: APuU4Z+a8oCxsmGxh2Cyy6Ze2YnVeR5Mqjbb3AUWc40vN9rBuApY3+hd
 lWrVVoCojvDe7/OK0Q4mIQ00bBPkNnWfbvEC1LuairZurP5Xjrb4Ai2A8AfLAfZXkzM=
X-Gm-Gg: AYBFou1jx+KnO+fandZ2rNleuU/6XpK9ONlKkDpWwR/9Jq4IN+Rc4Fn3zu633b2F2Yj
 LkA09H5rgPpMLCTEr/zkeFuh367V6u8C2ST6icMZyUkZLUSrKnqgGpkU6dHgWiRF47D6D3WwJtf
 5sN40qDpErhTcsoxvRLMm5Dop4+TBwbld336eHUY4JGElnV6DCSbDk0k1Mjnv3SYxBTnlZbVFVj
 j9bFq3Q4kY2/Ai8hUaq3EjWDnVG2jGd2SLpBTS6DgTFcSwLILRqxSyG6imf16LbqVSrEh1qFTbj
 jGruRbKSTE2giJM+skC9aria3r4so2/gKL1xw43xymKxaiVCBlJDAc2f3WG1kaFcH6eg90tGeS+
 CmrCXxoSyfMnhY6JBkpJbTGqYDrKY8prbHVP1gPNCiPdnuunRnFxhsgUTHnAb+qnMUdE082IN/n
 RqseXElxKq5561eUJjJ4Qp47QR72IqtqW/MnpIE01yjaKTgQg/opsqUHCW2lI32rumjOWiNac31
 tX7jV/vVL4MSUacBZEONf8Uh11yPuj3mAKkBJ/Lt/ExWFDbNupYNhkfyr6IxFyWZVhq0j5dnPVE
 F+ksmojT4oon4N2nSnQNSLY7Ubt5oNtY
X-Received: by 2002:a05:600d:103:b0:4a2:c41:d85b with SMTP id
 5b1f17b1804b1-4ba08e205e5mr28318595e9.17.1794394024639; 
 Wed, 11 Nov 2026 02:47:04 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:81bc:371c:5725:cc4d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983284c9b1sm9518790f8f.6.2026.11.11.02.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:47:04 -0800 (PST)
Date: Wed, 11 Nov 2026 10:47:02 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/6] virtio-snd: add pcm_state_to_str()
Message-ID: <avRHpir8yFEA5QkA@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
 <20261110-virtio-snd-fixes-v2-2-d5b654217676@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-virtio-snd-fixes-v2-2-d5b654217676@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x335.google.com
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

On Tue, Nov 10, 2026 at 02:39:31PM +0200, Manos Pitsidianakis wrote:
> Add macro to print the stream state in a human-understandable state,
> since this is an internal enum and one would have to inspect the source
> code to understand what a e.g. "2" state means in an error message.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/audio/virtio-snd.c | 49 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index bed36203f2..f1dc03d1b8 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -38,6 +38,26 @@ typedef enum virtio_snd_pcm_state {
>      VIRTIO_SND_PCM_STATE_RELEASED,
>  } virtio_snd_pcm_state;
>  
> +static inline const char *pcm_state_to_str(virtio_snd_pcm_state s)
> +{
> +    switch (s) {
> +    case VIRTIO_SND_PCM_STATE_UNINIT:
> +        return "UNINIT";
> +    case VIRTIO_SND_PCM_STATE_PARAMS_SET:
> +        return "PARAMS_SET";
> +    case VIRTIO_SND_PCM_STATE_PREPARED:
> +        return "PREPARED";
> +    case VIRTIO_SND_PCM_STATE_STARTED:
> +        return "STARTED";
> +    case VIRTIO_SND_PCM_STATE_STOPPED:
> +        return "STOPPED";
> +    case VIRTIO_SND_PCM_STATE_RELEASED:
> +        return "RELEASED";
> +    default:
> +        return "invalid";
> +    }
> +}
> +
>  static inline bool virtio_snd_pcm_state_prepared(virtio_snd_pcm_state s)
>  {
>      return s > VIRTIO_SND_PCM_STATE_PARAMS_SET &&
> @@ -310,8 +330,10 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>      case VIRTIO_SND_PCM_STATE_RELEASED:
>          break;
>      default:
> -        error_report("%s unexpected stream state in %s: %"PRIu32,
> -                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
> +        error_report("%s unexpected stream state in %s: "
> +                     "%s (%"PRIu32")", VIRTIO_DEVICE(s)->name,
> +                     __func__, pcm_state_to_str(stream->state),
> +                     stream->state);
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>  
> @@ -535,8 +557,10 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>      case VIRTIO_SND_PCM_STATE_RELEASED:
>          break;
>      default:
> -        error_report("%s unexpected stream state in %s: %"PRIu32,
> -                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
> +        error_report("%s unexpected stream state in %s: "
> +                     "%s (%"PRIu32")", VIRTIO_DEVICE(s)->name,
> +                     __func__, pcm_state_to_str(stream->state),
> +                     stream->state);
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>  
> @@ -624,8 +648,10 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
>          case VIRTIO_SND_PCM_STATE_STOPPED:
>              break;
>          default:
> -            error_report("%s unexpected stream state in %s start: %"PRIu32,
> -                         VIRTIO_DEVICE(s)->name, __func__, stream->state);
> +            error_report("%s unexpected stream state in %s start: "
> +                         "%s (%"PRIu32")", VIRTIO_DEVICE(s)->name,
> +                         __func__, pcm_state_to_str(stream->state),
> +                         stream->state);
>              return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>          }
>  
> @@ -635,8 +661,9 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
>          case VIRTIO_SND_PCM_STATE_STARTED:
>              break;
>          default:
> -            error_report("%s unexpected stream state in %s stop: %"PRIu32,
> -                         VIRTIO_DEVICE(s)->name, __func__,
> +            error_report("%s unexpected stream state in %s stop: "
> +                         "%s (%"PRIu32")", VIRTIO_DEVICE(s)->name,
> +                         __func__, pcm_state_to_str(stream->state),
>                           stream->state);
>              return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>          }
> @@ -736,8 +763,10 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
>      case VIRTIO_SND_PCM_STATE_STOPPED:
>          break;
>      default:
> -        error_report("%s unexpected stream state in %s: %"PRIu32,
> -                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
> +        error_report("%s unexpected stream state in %s: "
> +                     "%s (%"PRIu32")", VIRTIO_DEVICE(s)->name,
> +                     __func__, pcm_state_to_str(stream->state),
> +                     stream->state);
>          cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>          return;
>      }
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>

