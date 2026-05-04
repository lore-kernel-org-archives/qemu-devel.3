Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7A7CD3439
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJuqF-0000MV-HI; Mon, 04 May 2026 11:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJuq0-0000KX-Gw
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJupy-0006TF-So
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777907035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lo1jFj/e68GEYR/+5Rq6RJMoW1fwP7Dsj1cnKx0iuM4=;
 b=HsAnvigpXvjCZTAzZHTjTd+7NapUy7qydpe4aR1SSSZw/f8MEdWXvhSo85aEtfpTIOf/sx
 vWs7LsAtTa7DgrYCDDiGNBWkuAPhNdLoKTkixy+40nzAzOta1TQB5r0yCmCqgZJ3lTeAno
 pRQZU0Vpfne/AQfgm+41YLpoJ1B7GWg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-YsZFGRkUNaGlzIxqFRZc_Q-1; Mon, 04 May 2026 11:03:54 -0400
X-MC-Unique: YsZFGRkUNaGlzIxqFRZc_Q-1
X-Mimecast-MFC-AGG-ID: YsZFGRkUNaGlzIxqFRZc_Q_1777907033
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48a7994e8ddso41207435e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777907033; x=1778511833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Lo1jFj/e68GEYR/+5Rq6RJMoW1fwP7Dsj1cnKx0iuM4=;
 b=BK3cY625nt57UKGoeP0Y5rlkm5ORDrtSv/rcy072K0t1s83wYEp+w7Fre69bcJi7z4
 iXQFCGrx50WjAsY21WwyKMV2x9FALYeeUGuBmcf6CWuqo3j6j5uMImThE0fLH/EkmRj4
 wrcGHF0xdUWuvGsmOjeya3aQ1X/t/GuIqZRuTlmzAqD4WJCNJrY4OhFRiXjScvkoHfLs
 3zRJdoNqDlqMc1shL/g47TGIRktIT2hxCZ0XrZ32r+9XtyzBoNFshKuSFSYowZQ6Ztm4
 ARzNcIqYj+MTjfW+762tCW+6e/uMz6B/bDwUrn4mPgMMOcRRLkNNFaFOth7NdnlCkTBs
 t8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777907033; x=1778511833;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lo1jFj/e68GEYR/+5Rq6RJMoW1fwP7Dsj1cnKx0iuM4=;
 b=oqJao8efDb6lUXNZIon0PzMdUBx2iMw9qudgpSO0060liRDkFuTVjbFwQWaF2Fvzrb
 oS7F7VUoscJyu60K0QxYcyfhlm/KH++qozepw+UfR0TfETSFOMtGT3FDpej92GL2CITQ
 w6xJ0JQ6FvFtiIyS2KWOluwdEjPKGuklSDyLDY3/mDtpKCY66YOYaGVv0SjxutyYBU2l
 6GGC0JJ1+vDaGJfP9CZF5R6Q8mNZM63wpDjkjwUPKCvhzTqp/oBjL6u9+SSxldGpfb5z
 T8RfnRoiTu9Ey1YfcOQETxo7ea4JRX2LLdVyqoStbh2JckCMugyWN/fL6/Q3ZTqKhb60
 zigQ==
X-Gm-Message-State: AOJu0Yw5/gljOK+zANBpVxaUJxJR0E0mIwNDWA5s6dzQYY/qBKJGoxBb
 zwiVzJJxhFgTr0XcDFZuFk03FQgkV7/+36AWVtPmxEYWgMiVUPkf9KFbbOd/sKOLLNewy3TPZ/y
 ns27o07M1cBRgmTBC5hQaoO2IED4cVJYAPdnZ+YTBMeJiVg39hR4eaPrT
X-Gm-Gg: AeBDievYJbhSRj7kFQtKdaAGWypmrT5SNiRZvjezbUo6KQfjQ5PIatUaa2KRuYhMute
 ZN/Yddyk93ipgGtLbOC17cluK+5Z5NMn+wYAXw/s5er/NsIhXIkR//bttzRFO0fPSWEtO8BqsmE
 /3DAwL2bpErPv/vEtY6UwX9LDDg1J7R1wq4eNC9pAWXEAgvqkcQuIjn6LU/W7mM8idU8FIHKWOz
 qq1FaB/aFwcLx3DMPXGbTXTVJPtoVsSqyZMu8Z5dOHXFLeoOIX4pQAak5KGtGzlIz+e3g7XISd8
 9R+hVK1bM0oViPhajHF9Pyw0jizGjpbNDdc+3WibnA6m6BOVwhSfVmwH2uhDoKsgpcD9HnvVvG8
 HaBR7YuPLfp/Yfjq2kV70iWbg1YlgUXLANkGO1e/R+5FV0wSf/5YXt0jjv3v/EmZfJDz7ws8=
X-Received: by 2002:a05:600c:c0c5:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-48a9865e95bmr128862165e9.16.1777907032831; 
 Mon, 04 May 2026 08:03:52 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c5:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-48a9865e95bmr128861285e9.16.1777907032276; 
 Mon, 04 May 2026 08:03:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8ebb3dc1sm294140565e9.14.2026.05.04.08.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 08:03:51 -0700 (PDT)
Message-ID: <3071257f-b447-4256-9d64-5d58045a9274@redhat.com>
Date: Mon, 4 May 2026 17:03:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: reject malformed migration capabilities
To: zhaoguohan@kylinos.cn, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Cc: qemu-devel@nongnu.org
References: <20260424031259.289211-1-zhaoguohan@kylinos.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260424031259.289211-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/24/26 05:12, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> check_migr() sets an error when the migration capability is not an object,
> but still returns true.  This lets version negotiation continue with an
> Error set and reports the wrong capability name in the diagnostic.
> 
> Return false for the malformed capability, and report the migration
> capability name.
> 
> Fixes: 36227628d824 ("vfio-user: implement message send infrastructure")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/vfio-user/proxy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 314dfd23d8af..8b7cc36231ab 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -1190,8 +1190,8 @@ static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
>       QDict *qdict = qobject_to(QDict, qobj);
>   
>       if (qdict == NULL) {
> -        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
> -        return true;
> +        error_setg(errp, "malformed %s", VFIO_USER_CAP_MIGR);
> +        return false;
>       }
>       return caps_parse(proxy, qdict, caps_migr, errp);
>   }


Applied to

     https://github.com/legoater/qemu vfio-next

Please base future contributions on this branch.

Thanks,

C.



