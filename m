Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58121C48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 00:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfqZQ-0001id-L2; Thu, 29 Feb 2024 19:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfqZM-0001iS-Vz
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 19:16:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfqZL-0004Wg-KK
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 19:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709252166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RRfGLX52A4TERmBP5O2Pj3Ykp9i/Od3PKocJhh2WHkE=;
 b=Qd+AyPIS4QFLGRypTaPH+BA7LfiWe0lDFFChxUN5sBaVeUtzOwcFyqEgR7fIbzWiXbrWSa
 dlLuX2kVFT2KR+BN0A+I6iYvJUV2pXzcMCfCH94q5iZA1s4EXC0EAdPExCKuPXATA/YeoG
 /wYNfVL+cmlan1gJK6rXBy7ey7OB3wg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-KkGRFGNJM7GBh2KXCPXzEw-1; Thu, 29 Feb 2024 19:16:05 -0500
X-MC-Unique: KkGRFGNJM7GBh2KXCPXzEw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so305363a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 16:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709252164; x=1709856964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRfGLX52A4TERmBP5O2Pj3Ykp9i/Od3PKocJhh2WHkE=;
 b=Ur9xPurfdzcvwzf0pLifyg8dfR3R9oUYmdHl95LQDANkH9neQp2ib9OPIqglwdiyoI
 rbgfJxUkTHBKkXO2b7HIXCm8LiE0itcR+MCQikuK/0dXeRiM0zw8zz6rBTa2u+CU6/bf
 6Ulh2GaAy6p1zXPGzNq/5FdQ+Aate7rKjgT9br4wYTLBlPqIfuj4eau0dcHtJW6u3B3W
 oAeRTm5DWDCFHfbHuVeosuHXE8PDl2y8/vx5lp3Tv/ZaF53Xn9CDY64tDEPqQFJryoDd
 Yzv3lRs5q0KcEdzKhY7yHJ0vA5SvyMAhI2uLRdt2cGTHFJqW2jtA472OH3wbjQpOpkmh
 ZjEA==
X-Gm-Message-State: AOJu0YzISM5NsjeB4XUhz2xfNymDm4xwIovD1rxcpjkG2NTcSTjCrtz5
 mhVt/jsbArbOeULqhRCEh4T3YHfT6kULnho2Dugdbi3Kt0xY4hPxCksEANzA3wp1XrdFsux/nSm
 f4Mfddh4TdK2Af365ltg1XQ1iItIiEL7Fo9npBTpPloQxPznhWzJp
X-Received: by 2002:a05:6a00:9295:b0:6e4:68fa:f1ff with SMTP id
 jw21-20020a056a00929500b006e468faf1ffmr329956pfb.0.1709252164143; 
 Thu, 29 Feb 2024 16:16:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqAvtmoB/2liMFgJGZzbPRtzFOvq3ccxqHl8G1aiT3laphisHm9DUuKtpV5HE/P0G+oAWPNw==
X-Received: by 2002:a05:6a00:9295:b0:6e4:68fa:f1ff with SMTP id
 jw21-20020a056a00929500b006e468faf1ffmr329939pfb.0.1709252163782; 
 Thu, 29 Feb 2024 16:16:03 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 k16-20020aa788d0000000b006e4f1e6f145sm1828311pff.33.2024.02.29.16.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 16:16:03 -0800 (PST)
Date: Fri, 1 Mar 2024 08:15:55 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 19/23] migration/multifd: Prepare multifd sync for
 mapped-ram migration
Message-ID: <ZeEeOxGkhC6fDhBR@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-20-farosas@suse.de> <Zd_28lPa5Uq9Kaw2@x1n>
 <87plwfz9v3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plwfz9v3.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 10:19:12AM -0300, Fabiano Rosas wrote:
> > IMHO EOS cannot be accounted as "invalid" here because it always exists.
> > Rather than this trick (then explicitly ignore it below... which is even
> > hackier, IMHO), we can avoid setting EOS in invalid_flags, but explicitly
> > ignore EOS in below code to bypass it for mapped-ram:
> >
> > @@ -4301,7 +4302,12 @@ static int ram_load_precopy(QEMUFile *f)
> >          case RAM_SAVE_FLAG_EOS:
> >              /* normal exit */
> >              if (migrate_multifd() &&
> > -                migrate_multifd_flush_after_each_section()) {
> > +                migrate_multifd_flush_after_each_section() &&
> > +                /*
> > +                 * Mapped-ram migration flushes once and for all after
> > +                 * parsing ramblocks.  Always ignore EOS for it.
> > +                 */
> > +                !migrate_mapped_ram()) {
> >                  multifd_recv_sync_main();
> >              }
> >              break;
> 
> I thought we were already spraying too many migrate_mapped_ram() checks
> all over the code. But wat you said makes sense, I'll change it.

Yep that's not good, but I can't think of anything better yet and
simple. E.g. we could have some flag so ram_save_iterate()/etc. generates
nothing to the stream but only update the pages with the offsets, then we
don't need this at all and EOS can be legally accounted as invalid.  But
that can involve more changes and not helpful on this series to converge.

And it's also the long condition which makes me even more worry.. For the
long run I think we should cleanup most of these "multifd &&
after_flush_each_section && !mapped_ram" at some point..

-- 
Peter Xu


