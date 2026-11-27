Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D6606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U7tJekcF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eOt89Bh2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Wezt2c03;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rW/A8D53
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwks-0003PW-FW; Fri, 27 Nov 2026 09:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWwkk-0003EP-Qe
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:16:42 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWwki-00017S-KS
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:16:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE7FD1F443;
 Fri, 27 Nov 2026 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795788999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yI+uVl8xGETSKQILFnGGcylr7b6Gm87dfC46p5Ix81c=;
 b=U7tJekcFBYahRXCCABQvFrO07JO5+h3xI0pa3xeZ2aggXtzxdC9M0yJ4qO0JkdFL8ymiEb
 2IBFDK/rf9kJdDoK909qEQklLh9c76uubYVEyU6S6zn4JihgGYcm5+hXgDnZZ2UNUw2qdY
 wi3+eCqYQ2zh8mA7M+k3iCx/1f5OKrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795788999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yI+uVl8xGETSKQILFnGGcylr7b6Gm87dfC46p5Ix81c=;
 b=eOt89Bh2jDmJUv0MUrjJZUgYKO63S0nfaVMZSzs2z7adVMz35V4fyhGrpjx9rhf2yYijow
 TWQ65QjAvc+EgQDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wezt2c03;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="rW/A8D53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795788998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yI+uVl8xGETSKQILFnGGcylr7b6Gm87dfC46p5Ix81c=;
 b=Wezt2c03iXOnkG3XEuUrxiP2GRa8+aSZG8lLvX91BIB+wIabyOIKdtj4Wr9bp266Pb1X43
 LyNj5C0n/H0QoRM7+HmYwsrLjt9qrBAgdG9iHZtQFpd5I9Roxxe35eVdgFJ1nkswj21cCy
 bUg9og6a21LC10721eaQypksZ5r91UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795788998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yI+uVl8xGETSKQILFnGGcylr7b6Gm87dfC46p5Ix81c=;
 b=rW/A8D53mO4dTbJtoAUFXD8DsJ3EFENGwhy/mFIc3uU2VUzYmT0hc9/cTFsEDL3JQIOBaF
 WsywlCyUZPx6qrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5500B13432;
 Fri, 27 Nov 2026 14:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tPTNN8WQCWv+RgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Nov 2026 14:16:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, peterx@redhat.com, Gavin Shan
 <gshan@redhat.com>
Subject: Re: [PATCH for-12.0 v2 9/9] migration: Drop VMSTATE_VALIDATE() and
 VMS_MUST_EXIST
In-Reply-To: <20261126231631.3392756-10-peterx@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
 <20261126231631.3392756-10-peterx@redhat.com>
Date: Fri, 27 Nov 2026 11:16:31 -0300
Message-ID: <87mrquqs00.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: DE7FD1F443
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> We have moved all users to other API, now they're never used.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/vmstate.h | 11 -----------
>  migration/savevm.c          |  5 -----
>  migration/vmstate.c         | 12 ------------
>  3 files changed, 28 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 2901877308..de7a957140 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -130,10 +130,6 @@ enum VMStateFlags {
>       * allocated. Only valid in combination with VMS_VBUFFER. */
>      VMS_MULTIPLY         = 0x200,
>  
> -    /* Fail loading the serialised VM state if this field is missing
> -     * from the input. */
> -    VMS_MUST_EXIST       = 0x1000,
> -
>      /* When loading serialised VM state, allocate memory for the
>       * (entire) field. Only valid in combination with
>       * VMS_POINTER. Note: Not all combinations with other flags are
> @@ -458,13 +454,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      .offset       = vmstate_offset_value(_state, _field, _type),     \
>  }
>  
> -/* Validate state using a boolean predicate. */
> -#define VMSTATE_VALIDATE(_name, _test) { \
> -    .name         = (_name),                                         \
> -    .field_exists = (_test),                                         \
> -    .flags        = VMS_MUST_EXIST | VMS_NO_STATE,                   \
> -}
> -
>  #define VMSTATE_POINTER(_field, _state, _version, _info, _type) {    \
>      .name       = (stringify(_field)),                               \
>      .version_id = (_version),                                        \
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fe94ba96e4..e4f614cc86 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -622,11 +622,6 @@ static void dump_vmstate_vmsd(FILE *out_file,
>          fprintf(out_file, ",\n%*s\"Fields\": [\n", indent, "");
>          first = true;
>          while (field->name != NULL) {
> -            if (field->flags & VMS_MUST_EXIST) {
> -                /* Ignore VMSTATE_VALIDATE bits; these don't get migrated */
> -                field++;
> -                continue;
> -            }
>              if (!first) {
>                  fprintf(out_file, ",\n");
>              }
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 24004565bf..7734caab06 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -116,8 +116,6 @@ static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
>          n_elems = field->num;
>      } else if (field->flags & VMS_VARRAY) {
>          n_elems = vmstate_read_from_offset(&field->num_indirect, opaque);
> -    } else if (field->flags & VMS_MUST_EXIST && field->flags & VMS_NO_STATE) {
> -        n_elems = 0;
>      } else {
>          n_elems = 1;
>      }
> @@ -430,10 +428,6 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>                      return false;
>                  }
>              }
> -        } else if (field->flags & VMS_MUST_EXIST) {
> -            error_setg(errp, "Input validation failed: %s/%s version_id: %d",
> -                       vmsd->name, field->name, vmsd->version_id);
> -            return false;
>          }
>          field++;
>      }
> @@ -810,12 +804,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                      vmdesc_loop = NULL;
>                  }
>              }
> -        } else {
> -            if (field->flags & VMS_MUST_EXIST) {
> -                error_report("Output state validation failed: %s/%s",
> -                        vmsd->name, field->name);
> -                assert(!(field->flags & VMS_MUST_EXIST));
> -            }
>          }
>          field++;
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

