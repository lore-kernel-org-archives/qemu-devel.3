Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17495D3C90B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKnW-0006TL-C4; Wed, 10 Dec 2025 09:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vTKnA-0006Hj-MX
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:03:44 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vTKn6-0007Bh-JQ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:03:44 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BAE2tFN028937
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 10 Dec 2025 23:03:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=VLq7XYWmX3NZT2/OAI+J/GhEGlcxfFQxR1Sl8BSrQrk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:From:Subject:To;
 s=rs20250326; t=1765375391; v=1;
 b=Nt9GNSU2AVZclO5ksw2pwTmDwlyQyIcbOfJAiRWh+/+aRF5IAb4hRvUip/2HMpOK
 f+iDSVxguCPTSK6zvvOoYKG5kNK3NtfUHTeJ96OA0za4jbSp8YGkQ9fv5bGM07xo
 7U+vtyKQ+gyA+2WhZZ3JAKO0446q5qsOOk/jt5THXLN5PQmLmZwjUHxYhnUx5z3l
 W4u37IICmZqyapbd8kqbAs9Il1C5zQWyjEwblGzk9I7ecT5+cmrVg/mTwgPpwtdG
 W6qE3KSJiiG6/UHh/0eyZVOaJzF0YCPck5x5T9BwqWrok9/ykt+HOnJGGPmrlims
 xNAzBybKKFWmnPzgIbe5pQ==
Message-ID: <dbce27ef-12a5-4f5d-9c6f-8ad4fe0393ba@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 10 Dec 2025 23:02:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [RFC 02/24] audio: remove obsolete/obscure functions
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <20251201112309.4163921-3-marcandre.lureau@redhat.com>
Content-Language: en-US
In-Reply-To: <20251201112309.4163921-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025/12/01 20:22, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> AUD_init_time_stamp_{in,out} and AUD_get_elapsed_usec_{in,out} are only
> used by the adlib device. The result isn't actually being used since
> ADLIB_KILL_TIMERS was set some 20y ago. Let's drop this dead code now.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_template.h | 34 ----------------------------------
>   include/qemu/audio.h   |  6 ------
>   hw/audio/adlib.c       | 18 +-----------------
>   3 files changed, 1 insertion(+), 57 deletions(-)
> 
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 7a8c431f2d..1ab3c47fd7 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -569,40 +569,6 @@ bool glue(AUD_is_active_, TYPE)(SW *sw)
>       return sw ? sw->active : 0;
>   }
>   
> -void glue (AUD_init_time_stamp_, TYPE) (SW *sw, QEMUAudioTimeStamp *ts)
> -{
> -    if (!sw) {
> -        return;
> -    }
> -
> -    ts->old_ts = sw->hw->ts_helper;
> -}
> -
> -uint64_t glue (AUD_get_elapsed_usec_, TYPE) (SW *sw, QEMUAudioTimeStamp *ts)
> -{
> -    uint64_t delta, cur_ts, old_ts;
> -
> -    if (!sw) {
> -        return 0;
> -    }
> -
> -    cur_ts = sw->hw->ts_helper;
> -    old_ts = ts->old_ts;

It seems old_ts of QEMUAudioTimeStamp is no longer used.

Regards,
Akihiko Odaki

> -    /* dolog ("cur %" PRId64 " old %" PRId64 "\n", cur_ts, old_ts); */
> -
> -    if (cur_ts >= old_ts) {
> -        delta = cur_ts - old_ts;
> -    } else {
> -        delta = UINT64_MAX - old_ts + cur_ts;
> -    }
> -
> -    if (!delta) {
> -        return 0;
> -    }
> -
> -    return muldiv64 (delta, sw->hw->info.freq, 1000000);
> -}
> -
>   #undef TYPE
>   #undef HW
>   #undef SW
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index c56af895d6..2562710bec 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -71,9 +71,6 @@ int  AUD_get_buffer_size_out (SWVoiceOut *sw);
>   void AUD_set_active_out(SWVoiceOut *sw, bool on);
>   bool AUD_is_active_out(SWVoiceOut *sw);
>   
> -void     AUD_init_time_stamp_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
> -uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
> -
>   #define AUDIO_MAX_CHANNELS 16
>   typedef struct Volume {
>       bool mute;
> @@ -112,9 +109,6 @@ size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
>   void AUD_set_active_in(SWVoiceIn *sw, bool on);
>   bool AUD_is_active_in(SWVoiceIn *sw);
>   
> -void     AUD_init_time_stamp_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
> -uint64_t AUD_get_elapsed_usec_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
> -
>   void audio_cleanup(void);
>   
>   typedef struct st_sample st_sample;
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index 19d3a5f128..2a2fe7d04f 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -34,8 +34,6 @@
>   
>   #define DEBUG 0
>   
> -#define ADLIB_KILL_TIMERS 1
> -
>   #define ADLIB_DESC "Yamaha YM3812 (OPL2)"
>   
>   #if DEBUG
> @@ -71,7 +69,6 @@ struct AdlibState {
>       uint64_t dexp[2];
>       SWVoiceOut *voice;
>       int left, pos, samples;
> -    QEMUAudioTimeStamp ats;
>       FM_OPL *opl;
>       PortioList port_list;
>   };
> @@ -88,19 +85,7 @@ static void adlib_kill_timers (AdlibState *s)
>   
>       for (i = 0; i < 2; ++i) {
>           if (s->ticking[i]) {
> -            uint64_t delta;
> -
> -            delta = AUD_get_elapsed_usec_out (s->voice, &s->ats);
> -            ldebug (
> -                "delta = %f dexp = %f expired => %d",
> -                delta / 1000000.0,
> -                s->dexp[i] / 1000000.0,
> -                delta >= s->dexp[i]
> -                );
> -            if (ADLIB_KILL_TIMERS || delta >= s->dexp[i]) {
> -                adlib_stop_opl_timer (s, i);
> -                AUD_init_time_stamp_out (s->voice, &s->ats);
> -            }
> +            adlib_stop_opl_timer(s, i);
>           }
>       }
>   }
> @@ -149,7 +134,6 @@ static void timer_handler (void *opaque, int c, double interval_Sec)
>   #endif
>   
>       s->dexp[n] = interval_Sec * 1000000.0;
> -    AUD_init_time_stamp_out (s->voice, &s->ats);
>   }
>   
>   static int write_audio (AdlibState *s, int samples)


