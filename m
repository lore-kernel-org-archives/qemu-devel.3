Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC82CEFCE5A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 03:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxzo2-0007pQ-7e; Wed, 04 Mar 2026 22:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxzo0-0007oq-06
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:55:20 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxznx-0006Jd-NY
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:55:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772682899; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TApmIcD+um5VHG/OY9Hk0ysbU4z1tk/KsBVrANMpIw1C27oZ2tJYh72sA8Btzx7q2aaHTkHs2c0t+UepPNKuG6f4ql50lP19G2wHOvZCCYZc5u63ELNHsJcv5YztCDRGisi22p+bm6iizQDffcVxd1ESwzoFUmzZt6VUvUIgvXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772682899;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=e5V7gapiyc1B8oivLojekVugxHQwnO2MabGBw+dpBZo=; 
 b=ify3lOJcu20S5UA9G7ulzZIRIomkOyBK9t0Y1C4rH4wxldCo+o01TiSEfRC/ojyDZ/HLbj2mCYfHV8daXcZcBA5FJHyANau7CZA+jis4u31u4qdMHJ462EYZQN1GaLgdqEGTgtA+JU046W+SP8ts52cRJqZOE7m8GlEtFt2pnGw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772682899; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=e5V7gapiyc1B8oivLojekVugxHQwnO2MabGBw+dpBZo=;
 b=CI+ld7F7jodBOUxP3vuyXcW0R+TatfolPa8m8Zt4Vmow2uUWFnft/CR6L8vtxIlY
 E8PdRaq6vlqAv3xz5FVEXXlXNQ5rrlL5xkjj/P6wm7ly5Ojg8XyZCv3lakpYiXAp+3J
 NLoz0Gq8mcQmU/2Pb28nzQ/sAn8VM1LuQGLswgFU=
Received: by mx.zohomail.com with SMTPS id 1772682898252760.3970480819205;
 Wed, 4 Mar 2026 19:54:58 -0800 (PST)
Message-ID: <9a0eda08-0474-4283-8060-e8b31193ed59@collabora.com>
Date: Thu, 5 Mar 2026 06:54:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 72/85] audio/mixeng: replace redundant pcm_info fields
 with AudioFormat
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
 <20260223134731.2377432-73-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260223134731.2377432-73-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

On 2/23/26 16:47, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The audio_pcm_info structure stored three fields (bits, is_signed,
> is_float) that were always derived from the AudioFormat enum. This
> redundancy meant the same information was represented twice, with no
> type-level guarantee that they stayed in sync.
> 
> Replace these fields with a single AudioFormat field, and add helper
> functions to extract the derived properties when needed:
> - audio_format_bits()
> - audio_format_is_signed()
> - audio_format_is_float()
> 
> This improves type safety by making AudioFormat the single source of
> truth, eliminating the possibility of inconsistent state between the
> format enum and its derived boolean/integer representations.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  audio/audio_int.h       |   4 +-
>  audio/audio_template.h  |  12 +--
>  include/qemu/audio.h    |  49 +++++++++
>  audio/audio-mixeng-be.c | 218 ++++++++++++----------------------------
>  audio/dbusaudio.c       |  12 +--
>  audio/coreaudio.m       |   2 +-
>  6 files changed, 126 insertions(+), 171 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 5334c4baad2..dd5f2220d75 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -45,9 +45,7 @@ struct audio_callback {
>  };
>  
>  struct audio_pcm_info {
> -    int bits;
> -    bool is_signed;
> -    bool is_float;
> +    AudioFormat af;
>      int freq;
>      int nchannels;
>      int bytes_per_frame;
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 08d60422589..3da91a4782c 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -173,7 +173,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>      sw->empty = true;
>  #endif
>  
> -    if (sw->info.is_float) {
> +    if (audio_format_is_float(hw->info.af)) {
>  #ifdef DAC
>          sw->conv = mixeng_conv_float[sw->info.nchannels == 2]
>              [sw->info.swap_endianness];
> @@ -188,9 +188,9 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>          sw->clip = mixeng_clip
>  #endif
>              [sw->info.nchannels == 2]
> -            [sw->info.is_signed]
> +            [audio_format_is_signed(hw->info.af)]
>              [sw->info.swap_endianness]
> -            [audio_bits_to_index(sw->info.bits)];
> +            [audio_format_to_index(hw->info.af)];
>      }
>  
>      sw->name = g_strdup (name);
> @@ -300,7 +300,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>          goto err1;
>      }
>  
> -    if (hw->info.is_float) {
> +    if (audio_format_is_float(hw->info.af)) {
>  #ifdef DAC
>          hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
>              [hw->info.swap_endianness];
> @@ -315,9 +315,9 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>          hw->conv = mixeng_conv
>  #endif
>              [hw->info.nchannels == 2]
> -            [hw->info.is_signed]
> +            [audio_format_is_signed(hw->info.af)]
>              [hw->info.swap_endianness]
> -            [audio_bits_to_index(hw->info.bits)];
> +            [audio_format_to_index(hw->info.af)];
>      }
>  
>      glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index b6b6ee9b560..9e4566d60aa 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -185,6 +185,55 @@ bool audio_be_set_dbus_server(AudioBackend *be,
>  
>  const char *audio_application_name(void);
>  
> +static inline int audio_format_bits(AudioFormat fmt)
> +{
> +    switch (fmt) {
> +    case AUDIO_FORMAT_S8:
> +    case AUDIO_FORMAT_U8:
> +        return 8;
> +
> +    case AUDIO_FORMAT_S16:
> +    case AUDIO_FORMAT_U16:
> +        return 16;
> +
> +    case AUDIO_FORMAT_F32:
> +    case AUDIO_FORMAT_S32:
> +    case AUDIO_FORMAT_U32:
> +        return 32;
> +
> +    case AUDIO_FORMAT__MAX:
> +        break;
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +static inline bool audio_format_is_float(AudioFormat fmt)
> +{
> +    return fmt == AUDIO_FORMAT_F32;
> +}
> +
> +static inline bool audio_format_is_signed(AudioFormat fmt)
> +{
> +    switch (fmt) {
> +    case AUDIO_FORMAT_S8:
> +    case AUDIO_FORMAT_S16:
> +    case AUDIO_FORMAT_S32:
> +    case AUDIO_FORMAT_F32:
> +        return true;
> +
> +    case AUDIO_FORMAT_U8:
> +    case AUDIO_FORMAT_U16:
> +    case AUDIO_FORMAT_U32:
> +        return false;
> +
> +    case AUDIO_FORMAT__MAX:
> +        break;
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
>  #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
>      DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
>  
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index d02cfe3c509..931d5b206f2 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -62,23 +62,28 @@ int audio_bug (const char *funcname, int cond)
>      return cond;
>  }
>  
> -static inline int audio_bits_to_index (int bits)
> +/*
> + * Convert audio format to mixeng_clip index. Used by audio_pcm_sw_init_ and
> + * audio_mixeng_backend_add_capture()
> + */
> +static int audio_format_to_index(AudioFormat af)
>  {
> -    switch (bits) {
> -    case 8:
> +    switch (af) {
> +    case AUDIO_FORMAT_U8:
> +    case AUDIO_FORMAT_S8:
>          return 0;
> -
> -    case 16:
> +    case AUDIO_FORMAT_U16:
> +    case AUDIO_FORMAT_S16:
>          return 1;
> -
> -    case 32:
> +    case AUDIO_FORMAT_U32:
> +    case AUDIO_FORMAT_S32:
>          return 2;
> -
> -    default:
> -        audio_bug ("bits_to_index", 1);
> -        AUD_log (NULL, "invalid bits %d\n", bits);
> -        return 0;
> +    case AUDIO_FORMAT_F32:
> +    case AUDIO_FORMAT__MAX:
> +        break;
>      }
> +
> +    g_assert_not_reached();
>  }
>  
>  void AUD_vlog (const char *cap, const char *fmt, va_list ap)
> @@ -172,141 +177,68 @@ static int audio_validate_settings (const struct audsettings *as)
>  
>  static int audio_pcm_info_eq (struct audio_pcm_info *info, const struct audsettings *as)
>  {
> -    int bits = 8;
> -    bool is_signed = false, is_float = false;
> -
> -    switch (as->fmt) {
> -    case AUDIO_FORMAT_S8:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U8:
> -        break;
> -
> -    case AUDIO_FORMAT_S16:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U16:
> -        bits = 16;
> -        break;
> -
> -    case AUDIO_FORMAT_F32:
> -        is_float = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_S32:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U32:
> -        bits = 32;
> -        break;
> -
> -    default:
> -        abort();
> -    }
> -    return info->freq == as->freq
> +    return info->af == as->fmt
> +        && info->freq == as->freq
>          && info->nchannels == as->nchannels
> -        && info->is_signed == is_signed
> -        && info->is_float == is_float
> -        && info->bits == bits
>          && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
>  }
>  
>  void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as)
>  {
> -    int bits = 8, mul;
> -    bool is_signed = false, is_float = false;
> -
> -    switch (as->fmt) {
> -    case AUDIO_FORMAT_S8:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U8:
> -        mul = 1;
> -        break;
> -
> -    case AUDIO_FORMAT_S16:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U16:
> -        bits = 16;
> -        mul = 2;
> -        break;
> -
> -    case AUDIO_FORMAT_F32:
> -        is_float = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_S32:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U32:
> -        bits = 32;
> -        mul = 4;
> -        break;
> -
> -    default:
> -        abort();
> -    }
> -
> +    info->af = as->fmt;
>      info->freq = as->freq;
> -    info->bits = bits;
> -    info->is_signed = is_signed;
> -    info->is_float = is_float;
>      info->nchannels = as->nchannels;
> -    info->bytes_per_frame = as->nchannels * mul;
> +    info->bytes_per_frame = as->nchannels * audio_format_bits(as->fmt) / 8;
>      info->bytes_per_second = info->freq * info->bytes_per_frame;
>      info->swap_endianness = (as->endianness != HOST_BIG_ENDIAN);
>  }
>  
> -void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
> +void audio_pcm_info_clear_buf(struct audio_pcm_info *info, void *buf, int len)
>  {
>      if (!len) {
>          return;
>      }
>  
> -    if (info->is_signed || info->is_float) {
> -        memset(buf, 0x00, len * info->bytes_per_frame);
> -    } else {
> -        switch (info->bits) {
> -        case 8:
> -            memset(buf, 0x80, len * info->bytes_per_frame);
> -            break;
> -
> -        case 16:
> -            {
> -                int i;
> -                uint16_t *p = buf;
> -                short s = INT16_MAX;
> -
> -                if (info->swap_endianness) {
> -                    s = bswap16 (s);
> -                }
> -
> -                for (i = 0; i < len * info->nchannels; i++) {
> -                    p[i] = s;
> -                }
> -            }
> -            break;
> +    switch (info->af) {
> +    case AUDIO_FORMAT_U8:
> +        memset(buf, 0x80, len * info->bytes_per_frame);
> +        break;
> +    case AUDIO_FORMAT_U16: {
> +        int i;
> +        uint16_t *p = buf;
> +        short s = INT16_MAX;
>  
> -        case 32:
> -            {
> -                int i;
> -                uint32_t *p = buf;
> -                int32_t s = INT32_MAX;
> +        if (info->swap_endianness) {
> +            s = bswap16(s);
> +        }
>  
> -                if (info->swap_endianness) {
> -                    s = bswap32 (s);
> -                }
> +        for (i = 0; i < len * info->nchannels; i++) {
> +            p[i] = s;
> +        }
> +        break;
> +    }
> +    case AUDIO_FORMAT_U32: {
> +        int i;
> +        uint32_t *p = buf;
> +        int32_t s = INT32_MAX;
>  
> -                for (i = 0; i < len * info->nchannels; i++) {
> -                    p[i] = s;
> -                }
> -            }
> -            break;
> +        if (info->swap_endianness) {
> +            s = bswap32(s);
> +        }
>  
> -        default:
> -            AUD_log (NULL, "audio_pcm_info_clear_buf: invalid bits %d\n",
> -                     info->bits);
> -            break;
> +        for (i = 0; i < len * info->nchannels; i++) {
> +            p[i] = s;
>          }
> +        break;
> +    }
> +    case AUDIO_FORMAT_S8:
> +    case AUDIO_FORMAT_S16:
> +    case AUDIO_FORMAT_S32:
> +    case AUDIO_FORMAT_F32:
> +        memset(buf, 0x00, len * info->bytes_per_frame);
> +        break;
> +    case AUDIO_FORMAT__MAX:
> +        g_assert_not_reached();
>      }
>  }
>  
> @@ -719,8 +651,8 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
>  #ifdef DEBUG_AUDIO
>  static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
>  {
> -    dolog("%s: bits %d, sign %d, float %d, freq %d, nchan %d\n",
> -          cap, info->bits, info->is_signed, info->is_float, info->freq,
> +    dolog("%s: %s, freq %d, nchan %d\n",
> +          cap, AudioFormat_str(info->af), info->freq,
>            info->nchannels);
>  }
>  #endif
> @@ -1759,15 +1691,15 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>  
>          cap->buf = g_malloc0_n(hw->mix_buf.size, hw->info.bytes_per_frame);
>  
> -        if (hw->info.is_float) {
> +        if (audio_format_is_float(hw->info.af)) {
>              hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
>                  [hw->info.swap_endianness];
>          } else {
>              hw->clip = mixeng_clip
>                  [hw->info.nchannels == 2]
> -                [hw->info.is_signed]
> +                [audio_format_is_signed(hw->info.af)]
>                  [hw->info.swap_endianness]
> -                [audio_bits_to_index(hw->info.bits)];
> +                [audio_format_to_index(hw->info.af)];
>          }
>  
>          QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
> @@ -1869,29 +1801,6 @@ audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
>      };
>  }
>  
> -int audioformat_bytes_per_sample(AudioFormat fmt)
> -{
> -    switch (fmt) {
> -    case AUDIO_FORMAT_U8:
> -    case AUDIO_FORMAT_S8:
> -        return 1;
> -
> -    case AUDIO_FORMAT_U16:
> -    case AUDIO_FORMAT_S16:
> -        return 2;
> -
> -    case AUDIO_FORMAT_U32:
> -    case AUDIO_FORMAT_S32:
> -    case AUDIO_FORMAT_F32:
> -        return 4;
> -
> -    case AUDIO_FORMAT__MAX:
> -        ;
> -    }
> -    abort();
> -}
> -
> -
>  /* frames = freq * usec / 1e6 */
>  int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
>                          audsettings *as, int def_usecs)
> @@ -1914,8 +1823,7 @@ int audio_buffer_samples(AudiodevPerDirectionOptions *pdo,
>  int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
>                         audsettings *as, int def_usecs)
>  {
> -    return audio_buffer_samples(pdo, as, def_usecs) *
> -        audioformat_bytes_per_sample(as->fmt);
> +    return audio_buffer_samples(pdo, as, def_usecs) * audio_format_bits(as->fmt) / 8;
>  }
>  
>  void audio_rate_start(RateCtl *rate)
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 5f65c043c16..b212b3d6022 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -147,9 +147,9 @@ dbus_init_out_listener(QemuDBusDisplay1AudioOutListener *listener,
>      qemu_dbus_display1_audio_out_listener_call_init(
>          listener,
>          (uintptr_t)hw,
> -        hw->info.bits,
> -        hw->info.is_signed,
> -        hw->info.is_float,
> +        audio_format_bits(hw->info.af),
> +        audio_format_is_signed(hw->info.af),
> +        audio_format_is_float(hw->info.af),
>          hw->info.freq,
>          hw->info.nchannels,
>          hw->info.bytes_per_frame,
> @@ -273,9 +273,9 @@ dbus_init_in_listener(QemuDBusDisplay1AudioInListener *listener, HWVoiceIn *hw)
>      qemu_dbus_display1_audio_in_listener_call_init(
>          listener,
>          (uintptr_t)hw,
> -        hw->info.bits,
> -        hw->info.is_signed,
> -        hw->info.is_float,
> +        audio_format_bits(hw->info.af),
> +        audio_format_is_signed(hw->info.af),
> +        audio_format_is_float(hw->info.af),
>          hw->info.freq,
>          hw->info.nchannels,
>          hw->info.bytes_per_frame,
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 0c0e8583c89..1f4b3d9d467 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -359,7 +359,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>      AudioValueRange frameRange;
>  
>      AudioStreamBasicDescription streamBasicDescription = {
> -        .mBitsPerChannel = core->hw.info.bits,
> +        .mBitsPerChannel = audio_format_bits(core->hw.info.af),
>          .mBytesPerFrame = core->hw.info.bytes_per_frame,
>          .mBytesPerPacket = core->hw.info.bytes_per_frame,
>          .mChannelsPerFrame = core->hw.info.nchannels,

Audio (driver=pipewire,model=virtio) is broken/distorted on staging tree
and I bisected it to this patch. Can't see anything obviously wrong in
the code, any ideas where the problem could be?

-- 
Best regards,
Dmitry

