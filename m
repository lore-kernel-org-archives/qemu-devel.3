Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D5BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 06:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxL1u-0000bo-Qh; Thu, 18 Apr 2024 02:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxL1s-0000aj-VS
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 02:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxL1p-0000Cr-NP
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 02:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713420827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yADguTo6OtHbKXGyfe5pHI1kNjPau0SNSmuCZPAYh4c=;
 b=RWgIdcnhZn9Il6tQw0hY/c0cLYeRNDXV0YS4K8jfJgIhO2kIJQCfpKtKNqu0oablbQ4jDR
 AHYxd4HTGjLM0FXCUPr20DNTvc6VfgJzDNj1SOXtmTcpRmA5OPUFdNGXxQXLfpNHgczGp4
 5yz/mVP5cQrkR9VyXj/b67BKoHomj3A=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-mxuHy2YvMxekGizAPDpKKg-1; Thu, 18 Apr 2024 02:13:45 -0400
X-MC-Unique: mxuHy2YvMxekGizAPDpKKg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2db6acacdacso4569201fa.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 23:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713420824; x=1714025624;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yADguTo6OtHbKXGyfe5pHI1kNjPau0SNSmuCZPAYh4c=;
 b=LEY/wqmzl5jseDcO90J/w+Y5cryqizU5cKDLduHnYkcwgDJD6N7j+Olw/2Q2AcGS/+
 iWn8kVBcUbSrbmfj/lMqpB9FFiD7JmozkOPX6a/QqMwjrCUMF4sHt4lBE/wLOA7F9tNO
 +lVpzeBq243gAdRpxUTLaNPWjvm4k/17U0Gk9g+fG7i+O8TuKnasRnzIawq4pPbUPutj
 QOB9gpuoczPhd8H76Kpsi3q8BRCOZXQvoLUfWJB/ESAZFZX+xcFvodTcXO5swj5LOzEg
 c5wmsXzsj5IG0E0NXHBS9ea+XJvnDs94qOvd+my9tKqQ4wOCE3p9B6Zph7zylDTSmaQV
 xWZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh7LBKUTOfXSsD0eABW8ZJExI9agxeAwsIrWFKU7nmUqPMdliHvyLoAddUhY5ANhxb4ZCdaWPVVif3Be+dO83qv+8uJ94=
X-Gm-Message-State: AOJu0YytEP9gpapRLrT2otadKVzasK17JGs/U1yvJ/yvciOGDsdKIGVe
 Ls0kprgsiyT2WsRug12siLqJAVspSbc32pz5AAEpNIL7OKy6JBkdMQvtQl6pcxVVTqSFMx7pEWs
 2yEVs1QR1Pwm50jw1/mUx+prai4DVVnI5ighcbiBgjiqyO3zYMjGk
X-Received: by 2002:a2e:868c:0:b0:2d6:c252:27fa with SMTP id
 l12-20020a2e868c000000b002d6c25227famr1249440lji.37.1713420824007; 
 Wed, 17 Apr 2024 23:13:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+R3BW4u8kfEGbt2X/fHtp1w0iCFrUZxzTkXOofOvwoAGdx3m6/V9idjT5OKW5PR04kt61+Q==
X-Received: by 2002:a2e:868c:0:b0:2d6:c252:27fa with SMTP id
 l12-20020a2e868c000000b002d6c25227famr1249404lji.37.1713420823512; 
 Wed, 17 Apr 2024 23:13:43 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-117.web.vodafone.de.
 [109.43.177.117]) by smtp.gmail.com with ESMTPSA id
 t15-20020adfeb8f000000b00349ff2e0345sm934172wrn.70.2024.04.17.23.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 23:13:43 -0700 (PDT)
Message-ID: <c623e08e-d18a-4bf9-bb20-8dcb84ab6bbf@redhat.com>
Date: Thu, 18 Apr 2024 08:13:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] block/gluster: Use URI parsing code from glib
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-10-thuth@redhat.com>
 <zrdtuxegb3kyrp6qobgpygmoydiigpc6tv5e4jk7w7fi7cwvr3@pivj5d3df5uj>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <zrdtuxegb3kyrp6qobgpygmoydiigpc6tv5e4jk7w7fi7cwvr3@pivj5d3df5uj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/04/2024 16.40, Eric Blake wrote:
> On Fri, Apr 12, 2024 at 03:24:11PM +0200, Thomas Huth wrote:
>> Since version 2.66, glib has useful URI parsing functions, too.
>> Use those instead of the QEMU-internal ones to be finally able
>> to get rid of the latter.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   block/gluster.c | 71 ++++++++++++++++++++++++-------------------------
>>   1 file changed, 35 insertions(+), 36 deletions(-)
>>
>> diff --git a/block/gluster.c b/block/gluster.c
>> index cc74af06dc..1c9505f8bb 100644
>> --- a/block/gluster.c
>> +++ b/block/gluster.c
>> @@ -17,7 +17,6 @@
>>   #include "qapi/error.h"
>>   #include "qapi/qmp/qdict.h"
>>   #include "qapi/qmp/qerror.h"
>> -#include "qemu/uri.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/module.h"
>>   #include "qemu/option.h"
>> @@ -289,9 +288,9 @@ static void glfs_clear_preopened(glfs_t *fs)
>>       }
>>   }
>>   
>> -static int parse_volume_options(BlockdevOptionsGluster *gconf, char *path)
>> +static int parse_volume_options(BlockdevOptionsGluster *gconf, const char *path)
> 
> Is it worth mentioning in the commit message that this includes a
> const-correctness tweak?

I can add something like:

"Since g_uri_get_path() returns a const pointer, we also need to tweak the 
parameter of parse_volume_options() (where we use the result of 
g_uri_get_path() as input)"

>> @@ -364,57 +363,57 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
>>       QAPI_LIST_PREPEND(gconf->server, gsconf);
>>   
>>       /* transport */
>> -    if (!uri->scheme || !strcmp(uri->scheme, "gluster")) {
>> +    uri_scheme = g_uri_get_scheme(uri);
>> +    if (!uri_scheme || !strcmp(uri_scheme, "gluster")) {
> 
> Pre-existing, but per RFC 3986, we should probably be using strcasecmp
> for scheme comparisons (I'm not sure if g_uri_parse guarantees a
> lower-case return, even when the user passed in upper case).  That can
> be a separate patch.

As Daniel mentioned, g_uri_get_scheme() returns a lowercase string, so we 
should be fine.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

  Thomas



