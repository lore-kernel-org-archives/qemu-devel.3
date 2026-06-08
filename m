Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4607CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWcO-0001P7-DP; Mon, 08 Jun 2026 05:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wWWcM-0001OM-Ko; Mon, 08 Jun 2026 05:50:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wWWcJ-0001SN-Oa; Mon, 08 Jun 2026 05:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1780912187; bh=MTOj3ZU441qz5/DZXDZZjvTjnwuSNwsyoXT3OQx0F1A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bkkJkENMB6H+iaDlmWRz0rdkKB9BmoYIn23lBb3hhAuqo1pP772ockCow2vJhQX8L
 DYkkuYsQoPbRJgGvd6A0NuHel9K1/8banzc0O9Hjt1+33Cy1HRpZSOuSh2oY0m/Tzm
 Oq+/e219IcukQwRIxY8sSpuiv1OHb7wToOhNLiUYngTy4Qie7XiRZ0nJdob8kotAtQ
 PP0LiZjlONERcQDk8nLIonPoM9BRdkeOOuuPcc3kj2i6rl/ub2sYg45Bm9pYPoSMYK
 ujXIVG8hKd0ZB23DDnVTtYN3CCsFllB2/0rnmyhQAkBG30VTiAKTp2Ca3W0roqxPK+
 fz2tyD1MbwP3Q==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 4F94B1B571B;
 Mon, 08 Jun 2026 12:49:47 +0300 (MSK)
Message-ID: <252f4369-68c4-4b34-a076-9c844b25720e@tls.msk.ru>
Date: Mon, 8 Jun 2026 12:49:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/audio/fmopl.c: Convert malloc, free to g_malloc0,
 g_new and g_free
To: Lucas Cardoso <luc.fast2004@gmail.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-trivial@nongnu.org, marcandre.lureau@redhat.com
References: <20260428162048.2995097-1-luc.fast2004@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260428162048.2995097-1-luc.fast2004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28.04.2026 19:20, Lucas Cardoso wrote:
> In accordance with QEMU's coding style guidelines, replace raw memory
> allocation functions (malloc/free) with their GLib equivalents
> (g_new/g_malloc0/g_free/g_clear_pointer).
> 
> Also removes the old generic error-handling code from
> OPLOpenTable(), since the Glib functions abort the program automatically
> if memory is exhausted.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1798
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Lucas Cardoso <luc.fast2004@gmail.com>
> ---
> v2:
> - After some studying, I decided to follow Marc-André's feedback to use g_clear_pointer() instead of g_free(), on the OPLCloseTable function.
>   hw/audio/fmopl.c | 43 ++++++++++++-------------------------------
>   1 file changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c

> +    TL_TABLE = g_new(int32_t, TL_MAX * 2);
> +    SIN_TABLE = g_new(int32_t *, SIN_ENT * 4);
> +    AMS_TABLE = g_new(int32_t, AMS_ENT * 2);
> +    VIB_TABLE = g_new(int32_t, VIB_ENT * 2);


How about this:

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index a63ad0f04d..91a41f5fa9 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -175,18 +175,18 @@ static const int32_t SL_TABLE[16]={
  /* TotalLevel : 48 24 12  6  3 1.5 0.75 (dB) */
  /* TL_TABLE[ 0      to TL_MAX          ] : plus  section */
  /* TL_TABLE[ TL_MAX to TL_MAX+TL_MAX-1 ] : minus section */
-static int32_t *TL_TABLE;
+static int32_t TL_TABLE[TL_MAX*2];

  /* pointers to TL_TABLE with sinwave output offset */
-static int32_t **SIN_TABLE;
+static int32_t *SIN_TABLE[SIN_ENT * 4];

  /* LFO table */
-static int32_t *AMS_TABLE;
-static int32_t *VIB_TABLE;
+static int32_t AMS_TABLE[AMS_ENT * 2];
+static int32_t VIB_TABLE[VIB_ENT * 2];

  /* envelope output curve table */
  /* attack + decay + OFF */
-static int32_t *ENV_CURVE;
+static int32_t ENV_CURVE[2 * EG_ENT + 1];

  /* multiple table */
  #define ML 2
@@ -606,28 +606,6 @@ static int OPLOpenTable( void )
         int i,j;
         double pom;

-       /* allocate dynamic tables */
-       if( (TL_TABLE = malloc(TL_MAX*2*sizeof(int32_t))) == NULL)
-               return 0;
-       if( (SIN_TABLE = malloc(SIN_ENT*4 *sizeof(int32_t *))) == NULL)
-       {
-               free(TL_TABLE);
-               return 0;
-       }
-       if( (AMS_TABLE = malloc(AMS_ENT*2 *sizeof(int32_t))) == NULL)
-       {
-               free(TL_TABLE);
-               free(SIN_TABLE);
-               return 0;
-       }
-       if( (VIB_TABLE = malloc(VIB_ENT*2 *sizeof(int32_t))) == NULL)
-       {
-               free(TL_TABLE);
-               free(SIN_TABLE);
-               free(AMS_TABLE);
-               return 0;
-       }
-    ENV_CURVE = g_new(int32_t, 2 * EG_ENT + 1);
         /* make total level table */
         for (t = 0;t < EG_ENT-1 ;t++){
                 rate = ((1<<TL_BITS)-1)/pow(10,EG_STEP*t/20);   /* dB 
-> voltage */
@@ -693,15 +671,6 @@ static int OPLOpenTable( void )
  }


-static void OPLCloseTable( void )
-{
-    g_free(ENV_CURVE);
-       free(TL_TABLE);
-       free(SIN_TABLE);
-       free(AMS_TABLE);
-       free(VIB_TABLE);
-}
-
  /* CSM Key Control */
  static inline void CSMKeyControll(OPL_CH *CH)
  {
@@ -970,7 +939,6 @@ static void OPL_UnLockTable(void)
         if(num_lock) return;
         /* last time */
         cur_chip = NULL;
-       OPLCloseTable();
  }

  /*******************************************************************************/

?

> @@ -1081,11 +1065,8 @@ FM_OPL *OPLCreate(int clock, int rate)
>   	/* allocate OPL state space */
>   	state_size  = sizeof(FM_OPL);
>   	state_size += sizeof(OPL_CH)*max_ch;
> -	/* allocate memory block */
> -	ptr = malloc(state_size);
> -	if(ptr==NULL) return NULL;
> -	/* clear */
> -	memset(ptr,0,state_size);
> +    /* allocate memory block and zero-initialize */
> +    ptr = g_malloc0(state_size);
>   	OPL        = (FM_OPL *)ptr; ptr+=sizeof(FM_OPL);
>   	OPL->P_CH  = (OPL_CH *)ptr; ptr+=sizeof(OPL_CH)*max_ch;
>   	/* set channel state pointer */
> @@ -1128,7 +1109,7 @@ void OPLDestroy(FM_OPL *OPL)
>   	}
>   #endif
>   	OPL_UnLockTable();
> -	free(OPL);
> +    g_free(OPL);
>   }

And this is a 2-piece allocation in one go.  Which is,
by the way, is also fixed-size (state_size is constant).
I'd either split it into two separate allocations, or better yet,
made OPL->P_CH an array (instead of a pointer.

This whole file needs quite some care.  Incomplete or wrong or out of
place comments, mix of different coding styles, tricky allocations like
this one which don't need to be tricky, etc..  Many different things.

I dunno...

/mjt

