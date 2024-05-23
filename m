Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C214C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAAGE-0000IO-Tg; Thu, 23 May 2024 11:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sAAGD-0000Hu-W1
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sAAGC-00007p-FV
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716477699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4xfF8F3jYZgZTJq+AmoTKO2Gvqb5XuB2WxtyOrAyLU=;
 b=jTYfhVU5MR06S5OstWOhXmlZawRgXcw5jRYw3DUeUobFFRql9BfOp5MYkDuQuzjAmVfsiz
 uSVzaruEV+PHYIT5zZxGifbSvJViFS0Ke03TJRtXqnmBLzCdozMGwuLreOzhZ3oUhZuary
 WiK2rSKZt6v+aphc4XbzKFYxCQKN1J8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-kunH14JmNECFHVqJANUhpg-1; Thu, 23 May 2024 11:21:38 -0400
X-MC-Unique: kunH14JmNECFHVqJANUhpg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43e0e94fa82so2705061cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716477698; x=1717082498;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M4xfF8F3jYZgZTJq+AmoTKO2Gvqb5XuB2WxtyOrAyLU=;
 b=jOytoSkPszSoa5shk8uJPW+sZdoRRHDTwX7AhNHOx1bIR2rrVNY9Ve+BTRTLCPbFVC
 qqQwd/9uFOBZhS3sng5qk9scHsFg21tGaU4WbFpBeD5YFP7dzhokTWMPj4fD4IBnlaL0
 yq3h2SGxonNWgkAg2F/qPLssznKAoruFLWquvWEC5aueAVllyU6XEVI9IeEVcAvBZNml
 qsQL+LHfqVnbGfy/ytBPdDSCWJwVSn+H1mq6OIea36uEjJL+h2vRoccPOaggF6m9v9uy
 Gaa7qBBbImYvLwfDg2DEa6lrjhEf2fbpNa0xxmn/VGFGNAVy4IEFLSVBdRMPtSaPUDqC
 iFtA==
X-Gm-Message-State: AOJu0YzCX+JoTKrPjjch0DoX+BQ/COSrgOgUNlbYCgtuw3/aOEjNiiUt
 g4wrhjTRMBJ8vsO4Q8OdPzzUvrQDzlbh5LhKJyUDFg40uQNwHxb8NJmZ7sAvCz2qYCeEzDrMqNN
 NyECOHfcYxvMbO9196BC5F5sTjr5ke1fAn1YmOduZh0Fegj5Cw2SK
X-Received: by 2002:a05:622a:1209:b0:43a:f948:30ae with SMTP id
 d75a77b69052e-43f9e0d49femr55636701cf.27.1716477697620; 
 Thu, 23 May 2024 08:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwuQtZqhnOVoSf8yOQTtH2eukOD0CIkN0nGeqbhS3nR/J+PwOWCxp/FFSa2r23VrUZ3u/j4Q==
X-Received: by 2002:a05:622a:1209:b0:43a:f948:30ae with SMTP id
 d75a77b69052e-43f9e0d49femr55636391cf.27.1716477697164; 
 Thu, 23 May 2024 08:21:37 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43faaf0f266sm7325411cf.92.2024.05.23.08.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:21:36 -0700 (PDT)
Date: Thu, 23 May 2024 17:21:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 slp@redhat.com, 
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com, 
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v5 09/13] osdep: move O_DSYNC and O_DIRECT defines from
 file-posix
Message-ID: <jarvr7ltbh767igetsejk426jl5sfq2uswgn4ncdetl46bokew@7aghm5k64bjr>
References: <20240523145522.313012-1-sgarzare@redhat.com>
 <20240523145522.313012-10-sgarzare@redhat.com>
 <Zk9daPZHwpQktl9G@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zk9daPZHwpQktl9G@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 23, 2024 at 04:14:48PM GMT, Daniel P. Berrangé wrote:
>On Thu, May 23, 2024 at 04:55:18PM +0200, Stefano Garzarella wrote:
>> These defines are also useful for vhost-user-blk when it is compiled
>> in some POSIX systems that do not define them, so let's move them to
>> “qemu/osdep.h”.
>>
>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  include/qemu/osdep.h | 14 ++++++++++++++
>>  block/file-posix.c   | 14 --------------
>>  2 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index f61edcfdc2..e165b5cb1b 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -325,6 +325,20 @@ void QEMU_ERROR("code path is reachable")
>>  #define ESHUTDOWN 4099
>>  #endif
>>
>> +/* OS X does not have O_DSYNC */
>> +#ifndef O_DSYNC
>> +#ifdef O_SYNC
>> +#define O_DSYNC O_SYNC
>> +#elif defined(O_FSYNC)
>> +#define O_DSYNC O_FSYNC
>> +#endif
>> +#endif
>> +
>> +/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
>> +#ifndef O_DIRECT
>> +#define O_DIRECT O_DSYNC
>> +#endif
>
>Please don't do this - we can't be confident that all code in
>QEMU will be OK with O_DIRECT being simulated in this way.
>
>I'm not convinced that the O_DSYNC simulation is a good idea
>to do tree-wide either.

I was a little scared, and you and the failing tests on win64 convinced 
me to bring this back as in v4 ;-)

Thanks,
Stefano


