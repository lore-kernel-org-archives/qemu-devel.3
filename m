Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3A5C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 13:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY4ij-0006Yw-KD; Thu, 08 Feb 2024 08:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rY4if-0006YL-Sc
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 08:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rY4ib-0007Ni-VW
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 08:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707399932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GcKTlB7LrrpFyQv7OWnJaJSF5s+nodIeEU4VFGOnnU=;
 b=GLV2EwV0xV/M2gvx3NksRUVcMipv0fBCdKJq4lZLiyFTWvwBX3wv63H4S67+ebSFFoJ+Y6
 iFh6XRctd423Q1/sbH0kOqLs8vLW+WlQxhZP8V2ES9cvN3sMeO/I16ykpKWpLOuAzgBmxW
 38Hzx4PYGwGPWMluFLBRNduNqZWiNPo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-qHhRkVd6PL-ReBuMh-EcvQ-1; Thu, 08 Feb 2024 08:45:31 -0500
X-MC-Unique: qHhRkVd6PL-ReBuMh-EcvQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7855216bc07so148496085a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 05:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707399930; x=1708004730;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4GcKTlB7LrrpFyQv7OWnJaJSF5s+nodIeEU4VFGOnnU=;
 b=eq9EJgdffPxqD8z2h6wgC+dRD29vn1jffgDBrhS7iqWF0rc+HHAnAUCHsJ3dxWzdDf
 S+6tO8Heh8FeYxxQhkhattdseqHpUfJsAAjgitRtAtZHT9iwXPfhnwRKBueY/9sqs8ro
 cme5DQMooxAJnU/0zBc+EDsMpfbzPXPIDtd16fkmauL1JBdJaQk+NGyQyWj4SzmqCtgU
 1gDUNHOCt21KVxOWv37ZDspYOh+Bsa6kWG+8sPEof+unSpyrA34IB/ri4nLg5q+ccHB8
 2URkWx0Gx4i18BnZUWbYNXfIJlBfTpc7c/6VikH+OLCJ2iUUKIKfX/xwOWOpAR1kcGNl
 nutw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVsg5DaQtQA75fCugNb+gM9Pfm8U9lZ8MHqhoY2XkXH3wCWlwbfPN8nGFs19ugBbtcWw1HxGxdD7uudPVJBWMECucWL00=
X-Gm-Message-State: AOJu0YxA9UjfPabyNNh1Tv26p6l5b8NPDim0pNhjN69ot5+/7pC0Iyq7
 iA+pUYFt+I7YGZVY2asY26Gkrm+F3XnnIGjGjWE75sUt+XJXoLzfgsDlVJksWfU+YhGy9dcEgek
 cySLS31UnUBL5zTPJOnd20FO5Q2K+9VC/1I4M6qdfOqLamt2jace/
X-Received: by 2002:a05:620a:1a90:b0:783:f788:51c6 with SMTP id
 bl16-20020a05620a1a9000b00783f78851c6mr10062554qkb.19.1707399930593; 
 Thu, 08 Feb 2024 05:45:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLzh0Do3OZN1IBmzLt19fv5Xstu/qG3aufk5EtBd0+ndcbmkmx3aO2AnCDIChcnGlRIgxGew==
X-Received: by 2002:a05:620a:1a90:b0:783:f788:51c6 with SMTP id
 bl16-20020a05620a1a9000b00783f78851c6mr10062535qkb.19.1707399930349; 
 Thu, 08 Feb 2024 05:45:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWA5s2sVt8LIBkNeaVE+Je1UWhdE3ja+YYKYUAw/2idyO6rc0SR220mAT69py5kLevXpLSQ1Rs7l1FUFCalpUL0v+tQdwdjbbdV4XJmvYatzwa5zV3zCFWJnwYQ1ESri/Hb
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a05620a04ed00b0078575747a18sm10494qkh.30.2024.02.08.05.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 05:45:30 -0800 (PST)
Message-ID: <fbdb9fbc-c3de-4b0a-be1f-2bed405dfd86@redhat.com>
Date: Thu, 8 Feb 2024 14:45:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] migration: Use migrate_has_error() in
 close_return_path_on_source()
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-14-clg@redhat.com> <87y1bvayu7.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87y1bvayu7.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/8/24 14:07, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> close_return_path_on_source() retrieves the migration error from the
>> the QEMUFile '->to_dst_file' to know if a shutdown is required. This
>> shutdown is required to exit the return-path thread. However, in
>> migrate_fd_cleanup(), '->to_dst_file' is cleaned up before calling
>> close_return_path_on_source() and the shutdown is never performed,
>> leaving the source and destination waiting for an event to occur.
>>
>> Avoid relying on '->to_dst_file' and use migrate_has_error() instead.
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   migration/migration.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index d5f705ceef4c925589aa49335969672c0d761fa2..5f55af3d7624750ca416c4177781241b3e291e5d 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2372,8 +2372,7 @@ static bool close_return_path_on_source(MigrationState *ms)
>>        * cause it to unblock if it's stuck waiting for the destination.
>>        */
>>       WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>> -        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
>> -            qemu_file_get_error(ms->to_dst_file)) {
>> +        if (migrate_has_error(ms) && ms->rp_state.from_dst_file) {
>>               qemu_file_shutdown(ms->rp_state.from_dst_file);
>>           }
>>       }
> 
> Hm, maybe Peter can help defend this, but this assumes that every
> function that takes an 'f' and sets the file error also sets
> migrate_set_error(). I'm not sure we have determined that, have we?

How could we check all the code path ? I agree it is difficult when
looking at the code :/

Thanks,

C.



