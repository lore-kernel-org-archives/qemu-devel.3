Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96CDCA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDPsq-0000tl-I7; Sun, 04 Oct 2026 13:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1xDPsj-0000tH-Gc
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 13:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1xDPsY-0005po-B1
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 13:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791134396;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/5APpgYutW8EwYPScaE+FLCMrLEaxJMkhsglm33AjaA=;
 b=VZpdsVN9W2yacQo1GzE+lDif1sMCQ4KlBcbcXyrjwI2i2UIzj5PnAODJTBb924pDcr3i4A
 y0qfhFHN1xwUbGyzY9H6yxQwyFlLPi7foq93Pf4X46DChnuFETMQVUi/ibbyZdNC72ZrTr
 tF/ZalgwN2GZbaSeKDRCNwjkt8tUQV0=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-esY41PQwONmgZ5cXQFoLJw-1; Sun, 04 Oct 2026 13:19:55 -0400
X-MC-Unique: esY41PQwONmgZ5cXQFoLJw-1
X-Mimecast-MFC-AGG-ID: esY41PQwONmgZ5cXQFoLJw_1791134394
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-150efa76c57so1194831c88.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791134394; x=1791739194; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/5APpgYutW8EwYPScaE+FLCMrLEaxJMkhsglm33AjaA=;
 b=bLo1soXmWPin2w2E6W0g3Q800Rrsh6VqFoPfcMAJtOdhz2AyTQEQG89GAUFnYzmqyh
 g394CndXArirs5yQgWTcR58HWXxWNj5KW6RZbO7B/6YRBiVhg6h102/1QFheIG5vpIjv
 QzkuJL2Ty97gXgQqI6SaaEH2dJgRLl/69wvd37GTdrWXNE5rmsJr6qaR7kTEINiu7NEw
 F2jUVOcgZsPYm2FuYdfEgvgmtpp2jUVEIGLjVgoTazrKI+XWWtkyZxCveeFbdSl8Lx0d
 XSexIRunSkw2mWIbi75SAWtuC/4NIcYTnbzXTZ2eWIBWgAEEYqreBcBYqLc0jH1u/5Un
 GPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791134394; x=1791739194;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/5APpgYutW8EwYPScaE+FLCMrLEaxJMkhsglm33AjaA=;
 b=rY5N/EbCeYPlxcVd8IyW0BOpLkkVfVK81oYY4NIpZAHxH4G8esK1G97T1naWzIQldv
 gY0BxcbE5OSpxJ8fzQzhPg8lH6bhZBtR/+Y9MO5j1mzNQm3puF/rIfmdIPQQuZ0+q9wf
 MPQZY4qXWPoKq0cg5X4MTT6YQ/D72amy/t72YO/gdjQdBJHt84eUmE2+SGJ/GWfBMnwi
 +Y9Olc/0QQlADEpuWBNy4BdUa65EEmw6paZIQ9BzPwBugAT9AsTwQfIQ7eWyoE/Zcalr
 2ZdFCzqHemQ1hILdNCsu4xnNijTlh1H+zxFmTWq07B+q3LTKWGegqsFVMqEEm7A6/5L3
 mKQw==
X-Gm-Message-State: AFuF++lUZE17uzBq+fjAVY6WOSlRm0yTh7m71YV7fZIz69U17Mn1+jfm
 LalMQqDIJN0Vk0LHYHlSraNNBjjpfMkY8CTcWoS5QdaG82h7qwAsmH13NM8p5pjoOu6iekTgSaX
 8obOflwM21D0VbWKnd1SjDCp/Zo4ABwGBiybn6jt1HPLZ3ZV6ALhJ30eO
X-Gm-Gg: AYBFou2Lu8FMxHaZljBi7yvQgQ3YuXvoCrviNiLK6l25GM2vrjuQs8UBEfIwkScjCEc
 2yNwftuto39ItkQvJh9kgJ+FOeAkXluqkKddHoEO/ZtZPB6NwDPMjh4DrfL960k859TUPxlUgQ4
 H8G86nQgHP5tnqB8JDTmFXqcv0E1FBkBjCskXOsdaaf/coP7DNkpXziEYi5PzU82slguQSlwufQ
 VUDpzjIsNul4hhpfSvSwnPYMVJrU4ZKPrHV36ARu7lemrrt0jsTl2ufPQ3FULRqQ2HpA3zzgPdv
 rsGjxHEJ4dncQSEm3LlkyGeuxDcKwJGyL+3zalRZm+x/y09N0JdRzqnweVY/8X5mfV0=
X-Received: by 2002:a05:701b:2810:b0:151:5575:d18a with SMTP id
 a92af1059eb24-151bdd5eafamr6133883c88.0.1791134393587; 
 Sun, 04 Oct 2026 10:19:53 -0700 (PDT)
X-Received: by 2002:a05:701b:2810:b0:151:5575:d18a with SMTP id
 a92af1059eb24-151bdd5eafamr6133861c88.0.1791134392993; 
 Sun, 04 Oct 2026 10:19:52 -0700 (PDT)
Received: from fedora ([49.47.193.161]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fa751693sm35421748c88.2.2026.10.04.10.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 10:19:52 -0700 (PDT)
Date: Sun, 4 Oct 2026 22:49:46 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com
Subject: Re: [PATCH v3 01/10] tpm_util: Pass TPMVersion to function writing
 fatal error response
Message-ID: <asKKsnshHBhGoWx2@fedora>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
 <20261002142516.2063735-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002142516.2063735-2-stefanb@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Stefan,

On Fri, Oct 02, 2026 at 10:25:07AM -0400, Stefan Berger wrote:
> Have tpm_util_write_fatal_error_response write a TPM version specific
> error response with error code TPM_FAIL for a TPM 1.2 and TPM_RC_FAILURE
> for a TPM 2. Adjust the callers.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  backends/tpm/tpm_emulator.c    |  3 ++-
>  backends/tpm/tpm_passthrough.c |  2 +-
>  backends/tpm/tpm_util.c        | 17 ++++++++++++++---
>  include/system/tpm_util.h      |  3 ++-
>  4 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 95d2de2f48..16ae44c8d7 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -270,7 +270,8 @@ static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
>          tpm_emulator_unix_tx_bufs(tpm_emu, cmd->in, cmd->in_len,
>                                    cmd->out, cmd->out_len,
>                                    &cmd->selftest_done, errp) < 0) {
> -        tpm_util_write_fatal_error_response(cmd->out, cmd->out_len);
> +        tpm_util_write_fatal_error_response(cmd->out, cmd->out_len,
> +                                            TPM_EMULATOR(tb)->tpm_version);
nitpick,
+        tpm_util_write_fatal_error_response(cmd->out, cmd->out_len,
+                                            tpm_emu->tpm_version);
>      }
>  }
>  
> diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
> index a9f35ab7d6..8a4f8183c7 100644
> --- a/backends/tpm/tpm_passthrough.c
> +++ b/backends/tpm/tpm_passthrough.c
> @@ -118,7 +118,7 @@ static void tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>  
>  err_exit:
>      if (ret < 0) {
> -        tpm_util_write_fatal_error_response(out, out_len);
> +        tpm_util_write_fatal_error_response(out, out_len, tpm_pt->tpm_version);
>      }
>  
>      tpm_pt->tpm_executing = false;
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index 264bff22a9..7019f7fd3e 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -87,12 +87,23 @@ const PropertyInfo qdev_prop_tpm = {
>  /*
>   * Write an error message in the given output buffer.
>   */
> -void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
> +void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len,
> +                                         TPMVersion tpm_version)
>  {
>      if (out_len >= sizeof(struct tpm_resp_hdr)) {
> -        tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
> +        switch (tpm_version) {
> +        case TPM_VERSION_1_2:
> +            tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
> +            tpm_cmd_set_error(out, TPM_FAIL);
> +            break;
> +        case TPM_VERSION_2_0:
> +            tpm_cmd_set_tag(out, TPM2_ST_NO_SESSIONS);
> +            tpm_cmd_set_error(out, TPM_RC_FAILURE);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
>          tpm_cmd_set_size(out, sizeof(struct tpm_resp_hdr));
> -        tpm_cmd_set_error(out, TPM_FAIL);
>      }
>  }
>  
> diff --git a/include/system/tpm_util.h b/include/system/tpm_util.h
> index 1858693225..3ab2fe693d 100644
> --- a/include/system/tpm_util.h
> +++ b/include/system/tpm_util.h
> @@ -25,7 +25,8 @@
>  #include "system/tpm.h"
>  #include "qemu/bswap.h"
>  
> -void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len);
> +void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len,
> +                                         TPMVersion tpm_version);
>  
>  bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len);
>  
> -- 
> 2.55.0
> 

Reviewed-by: Arun Menon <armenon@redhat.com>


