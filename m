Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00873C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpqAl-0001QW-17; Fri, 31 Jul 2026 12:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpqAf-0001PP-Se
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:33:17 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpqAd-0003lQ-Jv
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:33:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70FEE418A;
 Fri, 31 Jul 2026 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785515589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpyaHivTc4ihb/sUbJAVJi4mhk8+byBB6H8u9uyiLQU=;
 b=rkhhNdBwMMXlRhGyArotBzfTJe8/kXydVV2eE6XD7J0aiDPa0x16L5vUzXroqEtBFbcZXl
 K54c80nwKFms+lo4zdG1nY/Sau3y3vismacy+scaFRCeeWI43GlO+gAPpBV7Ps0OmfackB
 HA8jZcPysHw1PoAB011SwFnUN8KOOr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785515589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpyaHivTc4ihb/sUbJAVJi4mhk8+byBB6H8u9uyiLQU=;
 b=c4Z49IwIcsSMQc7rWbH6hmK6v35PUltUop/J5cO+3f6+frYKbyvwun4aH/ee8n6884O1E7
 G/55xXj8AQm1eAAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JhNTubF5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lKiQihl7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785515585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpyaHivTc4ihb/sUbJAVJi4mhk8+byBB6H8u9uyiLQU=;
 b=JhNTubF5qK4SujVlsWnSDmwis1Pefp7ghkrlGW8azfpTcX95wenqeOQ9++ugAJKH5aZU45
 pJ+EA5ussFGttfoaWMmmEErTSEXsMnGNfPVEAt3h1UzNUQOmim5lbPoa+1NkRYhdGaay+7
 iZxMBuMDaNlVvpXyrUcyeVA2y2efCYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785515585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpyaHivTc4ihb/sUbJAVJi4mhk8+byBB6H8u9uyiLQU=;
 b=lKiQihl7cZz4wSwC3HFl/XgJaIaLx4zMeE3lbSRarqb9K0c3mYdedkl1SP7eNanYacMTA8
 XRkDW4iWkc4hNOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12724779B0;
 Fri, 31 Jul 2026 16:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2SZDNUDObGordwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 Jul 2026 16:33:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alexandr
 Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH 2/4] migration: Introduce VMStateOffset
In-Reply-To: <87ldarm8rp.fsf@suse.de>
References: <20260729225227.1170574-1-farosas@suse.de>
 <20260729225227.1170574-3-farosas@suse.de>
 <3166925a-0456-42b6-80d3-8154e3e66825@yandex-team.ru>
 <87o6fnmf4c.fsf@suse.de> <amzGTh3DXvX9ovJQ@x1.local>
 <87ldarm8rp.fsf@suse.de>
Date: Fri, 31 Jul 2026 13:33:02 -0300
Message-ID: <87ik5vm85d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 70FEE418A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Fri, Jul 31, 2026 at 11:02:27AM -0300, Fabiano Rosas wrote:
>>> Hi Vladimir, I've been looking at this, could you clarify which vmstates
>>> do you think we could merge? I don't see it, either VARRAY vs. VBUFFER
>>> or VARRAY vs. BUFFER, also ARRAY vs. BUFFER doesn't seem to work.
>>> 
>>> One main point of difference is the size_offset/num_offset variants are
>>> only known at load-time, so we can't convert them between each other at
>>> build time because the either the total size or num will not be know.
>>
>> Something like this?
>>
>> NOTE: I hid a fix to a comment that is irrelevant.. which I mentioned @size
>> and @size_offset can't co-exist, but it can when VMS_MULTIPLY is set.  I
>> had a vague feeling we can further clean vmstate flags.
>
> Is there a reason we cannot use .num for MULTIPLY instead of .size?
>
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 24631fd678..3a02709650 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -69,17 +69,15 @@ enum VMStateFlags {
>>       * }). Dereference the pointer before using it as basis for
>>       * further pointer arithmetic (see e.g. VMS_ARRAY). Does not
>>       * affect the meaning of VMStateField.num_offset or
>> -     * VMStateField.size_offset; see VMS_VARRAY and VMS_VBUFFER for
>> -     * those.
>> +     * VMStateField.size_offset; see VMS_VARRAY for those.
>>       */
>>      VMS_POINTER          = 0x002,
>>  
>>      /* The field is an array of fixed size. VMStateField.num contains
>>       * the number of entries in the array. The size of each entry is
>>       * given by VMStateField.size and / or opaque +
>> -     * VMStateField.size_offset; see VMS_VBUFFER and
>> -     * VMS_MULTIPLY. Each array entry will be processed individually
>> -     * (VMStateField.info.get()/put() if VMS_STRUCT is not set,
>> +     * VMStateField.size_offset. Each array entry will be processed
>> +     * individually (VMStateField.info.get()/put() if VMS_STRUCT is not set,
>>       * recursion into VMStateField.vmsd if VMS_STRUCT is set). May not
>>       * be combined with VMS_VARRAY.
>>       */
>> @@ -108,18 +106,10 @@ enum VMStateFlags {
>>       */
>>      VMS_ARRAY_OF_POINTER = 0x040,
>>  
>> -    /* The size of the individual entries (a single array entry if
>> -     * VMS_ARRAY or VMS_VARRAY are set, or the field itself if
>> -     * neither is set) is variable (i.e. not known at compile-time),
>> -     * but the same for all entries. Use the int32_t at opaque +
>> -     * VMStateField.size_offset (subject to VMS_MULTIPLY) to determine
>> -     * the size of each (and every) entry. */
>> -    VMS_VBUFFER          = 0x100,
>> -
>>      /* Multiply the entry size given by the int32_t at opaque +
>> -     * VMStateField.size_offset (see VMS_VBUFFER description) with
>> -     * VMStateField.size to determine the number of bytes to be
>> -     * allocated. Only valid in combination with VMS_VBUFFER. */
>> +     * VMStateField.size_offset with VMStateField.size to determine the
>> +     * number of bytes to be allocated.
>> +     */
>>      VMS_MULTIPLY         = 0x200,
>>  
>>      /* Fail loading the serialised VM state if this field is missing
>> @@ -181,8 +171,8 @@ struct VMStateField {
>>  
>>      /*
>>       * @size or @size_offset specifies the size of the element embeded in
>> -     * the field.  Only one of them should be present never both.  When
>> -     * @size_offset is used together with VMS_VBUFFER, it means the size is
>> +     * the field.  Only one of them should be present never both, except
>> +     * VMS_MULTIPLY.  When @size_offset is used, it means the size is
>>       * dynamic calculated instead of a constant.
>>       *
>>       * When the field is an array of any type, this stores the size of one
>> @@ -696,7 +686,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>>      .size_offset  = vmstate_field_offset(_state, _field_size),       \
>>      .size         = (_multiply),                                      \
>>      .info         = &vmstate_info_buffer,                            \
>> -    .flags        = VMS_VBUFFER|VMS_POINTER|VMS_MULTIPLY,            \
>> +    .flags        = VMS_VARRAY|VMS_POINTER|VMS_MULTIPLY,              \
>>      .offset       = offsetof(_state, _field),                        \
>>  }
>>  
>> @@ -706,7 +696,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>>      .field_exists = (_test),                                         \
>>      .size_offset  = vmstate_field_offset(_state, _field_size),       \
>>      .info         = &vmstate_info_buffer,                            \
>> -    .flags        = VMS_VBUFFER|VMS_POINTER,                         \
>> +    .flags        = VMS_VARRAY|VMS_POINTER,                          \
>>      .offset       = offsetof(_state, _field),                        \
>>  }
>>  
>> @@ -720,7 +710,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>>      .field_exists = (_test),                                         \
>>      .size_offset  = vmstate_field_offset(_state, _field_size),       \
>>      .info         = &vmstate_info_buffer,                            \
>> -    .flags        = VMS_VBUFFER|VMS_POINTER|VMS_ALLOC,               \
>> +    .flags        = VMS_VARRAY|VMS_POINTER|VMS_ALLOC,                \
>>      .offset       = offsetof(_state, _field),                        \
>>  }
>>  
>> @@ -798,7 +788,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>>      .version_id   = (_version),                                      \
>>      .size_offset  = vmstate_field_offset(_state, _field_size),       \
>>      .info         = &vmstate_info_bitmap,                            \
>> -    .flags        = VMS_VBUFFER|VMS_POINTER,                         \
>> +    .flags        = VMS_VARRAY|VMS_POINTER,                          \
>>      .offset       = offsetof(_state, _field),                        \
>>  }
>>  
>> @@ -1200,9 +1190,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>>  #define VMSTATE_BUFFER_START_MIDDLE(_f, _s, _start) \
>>      VMSTATE_BUFFER_START_MIDDLE_V(_f, _s, _start, 0)
>>  
>> -#define VMSTATE_PARTIAL_VBUFFER(_f, _s, _size)                        \
>> -    VMSTATE_VBUFFER(_f, _s, 0, NULL, _size)
>> -
>>  #define VMSTATE_PARTIAL_VBUFFER_UINT32(_f, _s, _size)                        \
>>      VMSTATE_VBUFFER_UINT32(_f, _s, 0, NULL, _size)
>>  
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index bc8eb3d3ca..f7363a8776 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -102,7 +102,7 @@ static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
>>  
>>      if (field->flags & VMS_ARRAY) {
>>          n_elems = field->num;
>> -    } else if (field->flags & VMS_VARRAY) {
>> +    } else if (field->num_offset.size) {
>
> Hmm, is it better to infer from the data rather than having the explicit
> flag? And if so, can't we remove VMS_VARRAY flag altogether?
>
> From Vladimir's message I though the intent was not only to remove the
> flag, but to remove the definition of VMSTATE_VBUFFER entirely and
> somehow fit that case into VMSTATE_VARRAY, removing size_offset along
> with it.
>
>>          n_elems = vmstate_read_from_offset(opaque,
>>      &field->num_offset); }
>>  
>> @@ -114,17 +114,17 @@ static uint64_t vmstate_size(void *opaque, const VMStateField *field)
>>  {
>>      uint64_t size;
>>  
>> -    if (field->flags & VMS_VBUFFER) {
>> -        size = vmstate_read_from_offset(opaque, &field->size_offset);
>> -        if (field->flags & VMS_MULTIPLY) {
>> -            size *= field->size;
>> -        }
>> -    } else if (field->flags & VMS_ARRAY_OF_POINTER) {
>> +    if (field->flags & VMS_ARRAY_OF_POINTER) {
>>          /*
>>           * For an array of pointer, the each element is always size of a
>>           * host pointer.
>>           */
>>          size = sizeof(void *);
>> +    } else if (field->size_offset.size) {
>> +        size = vmstate_read_from_offset(opaque, &field->size_offset);
>> +        if (field->flags & VMS_MULTIPLY) {
>> +            size *= field->size;
>> +        }
>>      } else {
>>          size = field->size;
>
> Since we're talking about flags, I'd like to be able to assert(size) at
> this point

But size can legitimately be 0 I guess. Nevermind.

