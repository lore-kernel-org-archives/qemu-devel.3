Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DCBC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVunr-0006BB-Li; Fri, 02 Feb 2024 09:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rVunp-0006Az-VG
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rVuno-0002Ih-DL
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706885159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQ/EU5JJtOUwFGJV+4BImiebXzCfY5Vu4VG9IyIW6MM=;
 b=dorEKVo1wA2pG59tKEK7n7s2VCedYUBlVIwwYAWSrHOqkI7hrgA62cfO4TECBnK/kgainf
 Zma4Ago/NzbhN/RO2iJsnutNEqEUrk41y6XAcGSstJXARsZkGKthbul7my2T3WXUtNFoiH
 0X6QrAK4GtT++Y0yw71SocOwHEKxCIU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-kjL_Wdb9MeuR880ncI28Dg-1; Fri, 02 Feb 2024 09:45:57 -0500
X-MC-Unique: kjL_Wdb9MeuR880ncI28Dg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-60411f95c44so28749917b3.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 06:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706885157; x=1707489957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FQ/EU5JJtOUwFGJV+4BImiebXzCfY5Vu4VG9IyIW6MM=;
 b=qflc6GM/ZJM9IUzpKyldKRKMfamxNu/dNVM7cP1Mx2mzJZMwKAHU/VrwER24AXines
 88QhjeVe+IjXZ8Gg0BMOGNAHSVe6cAD3ELOFuzrkd+1yDAYEbXd2RUxh7URlhEKh01xY
 Z00y/G6jT09CcFSfDHxfCaAdXpJHEi5D9cAVZ8hyw7JL7B3GYRGSoH+prLfCuxKyBQGA
 +UzrILi1UuCoR8sl0NEvUjN/AX78eGgaZOOap6RAg56kfkJueG8dM3bENa5tLcusclsN
 gRQVXqjngZB5iPkI6YsU5/3PsoQL/5E8uMS9hvGKDolU/txBwDABvD+XKY1mdWekU4X3
 KghA==
X-Gm-Message-State: AOJu0YyPEnbNxcCm7u0VcxD0mjKo6Tno1iZE3udRSqv7VbBQqCJDbC2Y
 qp5cn7QEqffEhdgq0BvE2WtxupE9oAzYBTUqR3b4+EaFg5JbATnJHsYXH+kEcoEqbCVhuyqrVU7
 i248I2nGMHkymBnqEOTFQvx+hTHf3oPj5uhLhC2nuNfYjezZDNXB/
X-Received: by 2002:a0d:e8d2:0:b0:5ff:796e:481f with SMTP id
 r201-20020a0de8d2000000b005ff796e481fmr9237819ywe.11.1706885156892; 
 Fri, 02 Feb 2024 06:45:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4/yv4fggQTOOlWZZqOrlwCcUaW+P6/La6f6YyXsMU90ZbOPFZk9XjF0FQCFAedrdApifh/w==
X-Received: by 2002:a0d:e8d2:0:b0:5ff:796e:481f with SMTP id
 r201-20020a0de8d2000000b005ff796e481fmr9237807ywe.11.1706885156641; 
 Fri, 02 Feb 2024 06:45:56 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWiiCOytoOAzL/8lOYFLns6/j5TNAVAinbqNfO7lzLFJNFc0e7ObfpbAIuIIuH2Qw2QdaCjl7UCfZL9UT2N+67xxqbcFF4=
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 i66-20020a816d45000000b005ff864709aesm450846ywc.42.2024.02.02.06.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Feb 2024 06:45:56 -0800 (PST)
Message-ID: <8e8d811d-9c72-428a-ac7f-3bac556d8585@redhat.com>
Date: Fri, 2 Feb 2024 15:45:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] migration: Add a file_error argument to
 close_return_path_on_source()
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240201184853.890471-1-clg@redhat.com>
 <20240201184853.890471-2-clg@redhat.com> <875xz7hran.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <875xz7hran.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/2/24 15:30, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> close_return_path_on_source() retrieves the migration error from the
>> the QEMUFile '->to_dst_file' to know if a shutdown is required to exit
>> the return-path thread. However, in migrate_fd_cleanup(), '->to_dst_file'
>> is cleaned up before calling close_return_path_on_source() and the
>> shutdown is never performed, leaving the source and destination
>> waiting for an event to occur.
> 
> Isn't this just missing qemu_file_shutdown() at migrate_fd_cleanup?
> 
>      if (s->to_dst_file) {
>          ...
>          migration_ioc_unregister_yank_from_file(tmp);
> +       qemu_file_shutdown(tmp);
>          qemu_fclose(tmp);
>      }
> 

That would make the return-path thread exit indeed. It should not
be necessary when there are no errors though and this is done
outside of the close_return_path_on_source() helper. There could
be side effects.


I took into account Peter's comment and replaced the changes of
PATCH 1 with :

@@ -2372,8 +2372,7 @@ static bool close_return_path_on_source(
       * cause it to unblock if it's stuck waiting for the destination.
       */
      WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
-        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
-            qemu_file_get_error(ms->to_dst_file)) {
+        if (migrate_has_error(ms) && ms->rp_state.from_dst_file) {
              qemu_file_shutdown(ms->rp_state.from_dst_file);
          }
      }

Nevertheless, we need to qemu_file_shutdown() correctly the socket
for this to work and the problem seems more complex than just moving
code as I did in PATCH 2.

Thanks,

C.



