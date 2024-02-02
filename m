Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F23C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 13:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVtE2-0004z4-50; Fri, 02 Feb 2024 08:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rVtE0-0004yi-CR
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rVtDy-0002IR-Kr
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706879092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RRk46LgmDBRr6S3BZIgtfCxNbsmyFCL3QGHQwinbvg=;
 b=gS04+YP3/UKWmLBS8FJAEQrz9Onk74IslWNaKsZYJUTfRuu0/Lxo3f1GNQec0B8nTIT5q4
 CS1dSRhZ94plI/682V+lgiiz51d3vZOh7JwaawMG7TjsAnlq9wltRetTVQeDzinxOAS4Vi
 wA3Q+rm+PiCvNct5HKBWvU0wd+3jSxk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-_bga17reOZmZn3VUo4hSGw-1; Fri, 02 Feb 2024 08:04:50 -0500
X-MC-Unique: _bga17reOZmZn3VUo4hSGw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-510222349b0so1781419e87.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 05:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706879089; x=1707483889;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5RRk46LgmDBRr6S3BZIgtfCxNbsmyFCL3QGHQwinbvg=;
 b=EqlC3TwuLjloclwkyfD38MbUri7nHp/utKAYou/9jSsL5svMVc+t+Pt6SBlTVHlRIo
 r7SrteOdvP3esfCaibDDFUV542Ztmq0UGm1lsExbo/xEi1LrJvVKGKyVzoSNPqCnkbp7
 bmTsIqCfRsvaFcDIqds+yZtQA4FWXwUKLuJjzuFBLpGVS1TcK6WpWtb1jb7tzXW6Vkla
 z9nBGjDhpgOZvUEM9Jt0z2Aakp1z68wAZGJkcV5UR4FWwQZIPLPQ/Mf/Hu6XLDyWP6FL
 KFrYaRpyggLkmtxN7RU50hd1Ca5dwYAD8HUZen1D8aBA4wZA5oGe/+PloulHo8LxTy1v
 mQZA==
X-Gm-Message-State: AOJu0YzIYM4v2qOCTECm6XPqrcFyK88t94LxJaWvIqfTFqIVhXebx7XF
 I/oNOZYXXK6xLtyOqIpdv0cGKoLZZobm4UUkzSeMfgX8DdXPx0gSybeeNke5mAXDTVRgKxjLgWU
 MDlROgQ66E5n+xYRzQ2BH9KKzEBAZdZBt3eLhrv6/tpHICii/8OPh
X-Received: by 2002:a05:6512:a8b:b0:511:2da1:d095 with SMTP id
 m11-20020a0565120a8b00b005112da1d095mr4347192lfu.51.1706879088962; 
 Fri, 02 Feb 2024 05:04:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp/3RTOVeEaGIP6ibLEf9/Rhoq9mtUT6kBBOHPyKcY36Tk5IDpcTSI4jZKWktztmIemjIVyA==
X-Received: by 2002:a05:6512:a8b:b0:511:2da1:d095 with SMTP id
 m11-20020a0565120a8b00b005112da1d095mr4347181lfu.51.1706879088506; 
 Fri, 02 Feb 2024 05:04:48 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWn1hz0AoeBhAtWDSaJ05SWI9AiZ5LB5AKxxS/Jn7Ppo7W5ozThrUujG8c5U/hPmRm8qi6jCJpk6gNMMzoQA/JTm6j2TmzLhkyTAKZJbYFHxA3uCSs=
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c4b9100b0040e3bdff98asm7236481wmp.23.2024.02.02.05.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Feb 2024 05:04:48 -0800 (PST)
Message-ID: <3e1f0f93-eb6b-4569-9344-846eae20b141@redhat.com>
Date: Fri, 2 Feb 2024 14:04:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] migration: Fix return-path thread exit
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240201184853.890471-1-clg@redhat.com> <Zby7o1O5Ox2NNbbP@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <Zby7o1O5Ox2NNbbP@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
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

Hello Peter,

>> Today, close_return_path_on_source() can perform a shutdown to exit
>> the return-path thread if an error occured. However, migrate_fd_cleanup()
>> does cleanups too early and the shutdown in close_return_path_on_source()
>> fails, leaving the source and destination waiting for an event to occur.
>>
>> This little series tries to fix that. Comments welcome !
> 
> One thing I do agree is that relying on qemu_file_get_error(to_dst_file) in
> close_return_path_on_source() is weird: IMHO we have better way to detect
> "whether the migration has error" now, which is migrate_has_error().

ok. migrate_has_error() looks safe to use in that case. It works fine
with all the prereq VFIO cleanups (that I didn't send yet) and errors
in the setup of dirty tracking are reported correctly to the migration
core subsystem.

> For this specific issue, I think one long standing issue that might be
> relevant is we have two QEMUFile (from_dst_file, to_dst_file) that share
> the same QIOChannel now.  Logically the two QEMUFile should be able to be
> managed separately, say, close() of to_dst_file shouldn't affect the other.
> 
> However I don't think it's the case now, as qemu_fclose(to_dst_file) will
> do qio_channel_close() already, which means there will be a side effect to
> the other QEMUFile that its backing IOC is already closed.
>
> Is this the issue we're facing?  

Yes. The socket is closed before calling close_return_path_on_source()
and ms->rp_state.from_dst_file becomes invalid, the shutdown silently
fails (we should maybe report error in qemu_file_shutdown()) and the
return-path thread does not exits.

> IOW, the close() of to_dst_file will not
> properly kick the other thread who is blocked at reading from_dst_file,
> while the shutdown() will kick it out?

Yes, that's how I understand the comment :

     /*
      * If this is a normal exit then the destination will send a SHUT
      * and the rp_thread will exit, however if there's an error we
      * need to cause it to exit. shutdown(2), if we have it, will
      * cause it to unblock if it's stuck waiting for the destination.
      */

> If so, not sure whether we can somehow relay the real qio_channel_close()
> to until the last user releases it? IOW, conditionally close() the channel> in qio_channel_finalize(), if the channel is still open?  Would that make
> sense?
It's the first time that I look at this code :/ I can't tell. Here is
the closing section :

         qemu_mutex_unlock(&s->qemu_file_lock);
         /*
          * Close the file handle without the lock to make sure the
          * critical section won't block for long.
          */
         migration_ioc_unregister_yank_from_file(tmp);
         qemu_fclose(tmp);
     }


Thanks,

C.


