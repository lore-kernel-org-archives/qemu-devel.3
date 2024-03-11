Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DBBC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 06:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjZMA-0002oJ-Kz; Mon, 11 Mar 2024 02:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rjZM8-0002ne-LL
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 02:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rjZM6-0000LX-QJ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 02:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710139309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0kZE+bK6s76pYCqdRXYkstSAEcGHqNQ3/tLJbOV3oNk=;
 b=BFozGtXWAIqn1Cgz5otpaRZmRuTzIRNKdGowjwyd3gPvs4ubKvoCb/3CknBFKNIumfMFcp
 tfNo3hbQUB1Erm4TqUiI1cnxvbC3GeTxps3JsnwQ8zUC5KUm4Vab1P5Qo2mfLHSD/ZArv0
 eiI780BBkWs2JHti8INpdKqOVHwmQb4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-TelJ3jLKPKOTuIxEQK_f8w-1; Mon, 11 Mar 2024 02:41:47 -0400
X-MC-Unique: TelJ3jLKPKOTuIxEQK_f8w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33e7ef510aaso1007520f8f.0
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 23:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710139306; x=1710744106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0kZE+bK6s76pYCqdRXYkstSAEcGHqNQ3/tLJbOV3oNk=;
 b=VJKpsWFfm7M87iuj2smO3HTL3KQxliN06lVhXzksTTBUueB0WwpL2KAxcyg8tcFbh3
 xc85K/BlEFsBqzMdxcGZC9aGb9Kv0lsSDLtszakbvUTw2JuKmncWulVOutjOXbVW9OzZ
 sB6EJjzoN8yUmOBAxXn8pOzY3s0snA27Ug+5p84Tw1bt7joTKj/rm1mTQ/VxrwZiGl5d
 lEPwEbfmluaks5DwlVWIrraiuUKoL2/74ZCzfqiAni8L4z9RM7NUsYKHRIYxDmqlzJu9
 lWPE/p5PJ+qQSkaWz6zsclnKEZv81SpwOYFXLCWh7deQcUtTy7yLJMLtSbHCdy+WOZr0
 ajrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBLzCWEZDRQyYJ26Bn3YRXClgIBgoz+eG0IUv5dLReacBbIy6gqiZTvrMR/WT9NibDUicGKIh3SZIMHtTlOr98vmSDcko=
X-Gm-Message-State: AOJu0YyByzW9NwMrcTtQ7Fe2UYZ93AT9+LkziufD/Er4zkA6FWOSPCTJ
 bkv1nbMuFsJjbL2hJkl2qAd5/YmVkqrVOX4EijgfxxzPRf055OtlurMXpacnXS1i7svGiKqo6L1
 9HkoxfMmU/uNoHryGtrqUiun6uUh9rbQXDw1lrElGOpmwVIaLh8pfdb5MKZlLc6wcM+Cjc2rYQq
 vff4AJeAcpVBtunzUziJFPH2SC/kI=
X-Received: by 2002:a05:6000:1b05:b0:33d:5a6f:a856 with SMTP id
 f5-20020a0560001b0500b0033d5a6fa856mr3633821wrz.30.1710139306544; 
 Sun, 10 Mar 2024 23:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG57ErgfsnCuvhWxwUQrlx54UZJJ/2kGIZgtvwWWAZqkc4e4azbzaSisWLSSY4rePpy4ir+vRGRoHC/CblOZaQ=
X-Received: by 2002:a05:6000:1b05:b0:33d:5a6f:a856 with SMTP id
 f5-20020a0560001b0500b0033d5a6fa856mr3633815wrz.30.1710139306119; Sun, 10 Mar
 2024 23:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240307114744.1135711-1-ppandit@redhat.com>
 <ZenGQZE4hlOR6J4V@redhat.com>
 <CAE8KmOzQVFrK3kh6M3-TAm_=hsGB7KP+wjN8synRotd68A_O-Q@mail.gmail.com>
 <ZerU1a6U8Xx0_R6s@redhat.com>
 <CAE8KmOyzt+dhfeJ2ZM=kmy1zFOnhqi74AeGUFsRLAcBYcX8CzQ@mail.gmail.com>
In-Reply-To: <CAE8KmOyzt+dhfeJ2ZM=kmy1zFOnhqi74AeGUFsRLAcBYcX8CzQ@mail.gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 11 Mar 2024 12:11:29 +0530
Message-ID: <CAE8KmOyiRDJd6LYJ4g9PrepBr2BKcu+kG7gP2FGYNC29S0RdAA@mail.gmail.com>
Subject: Re: [PATCH] linux-aio: add IO_CMD_FDSYNC command support
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hello Kevin,

On Fri, 8 Mar 2024 at 17:38, Prasad Pandit <ppandit@redhat.com> wrote:
> I'm trying to test it against the Fedora-26 kernel, which was < 4.13.0, and did not support the AIO_FDSYNC call.

[PATCH v2] -> https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg02495.html

* I've sent v2 of this patch which checks the return value from
'laio_co_submit' function and returns if it is >= zero(0).

* I tested this and previous version of this patch on host kernels
which support IO_CMD_FDSYNC and which don't.
    1) When kernel supports IO_CMD_FDSYNC, everything works well. No issues.

   2) When kernel does _not_ support IO_CMD_FDSYNC
        - With [PATCH v1], guest does not boot, instead it opens a rescue shell
        - With [PATCH v2], guest boots and seems to work fine. But
after some time guest kernel threads seem to hang and show traces like
===
            INFO: task kworker/u2:0:9 blocked for more than 245 seconds.
            INFO: task (tmpfiles):482 blocked for more than 123 seconds.
            INFO: task (tmpfiles):482 blocked for more than 368 seconds.
            INFO: task systemd-random-:477 blocked for more than 368 seconds.
            [  492.932383]       Not tainted 6.6.7-100.fc37.x86_64 #1
            [  492.935404] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
===

* I'm not yet sure how to fix this. I'd appreciate if you've suggestions.

Thank you.
---
  - Prasad


