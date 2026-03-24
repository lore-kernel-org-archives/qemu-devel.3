Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE5DF532D5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 04:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4tlx-0000ar-40; Tue, 24 Mar 2026 00:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4tlw-0000ab-7i
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 00:53:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4tlu-0003kl-AR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 00:53:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso6680995e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 21:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774328020; x=1774932820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mBNloe+1G/K4rguGI5/7XbAx90AYey6wnlf+fCB2vCc=;
 b=bL+RBVz6fp83GAGBgCNYeRfm+YOyq2T2cUuz6yQw6V9hX2sKR/SwrRmXD5rDnXf9gv
 Ggxf9hDoK4oeVJ6jOB2zJJKLa72f9crU4kydw6GDWzRcwcsImv5fCU7ui8IvrK4JtFID
 yYefWs2t2dBM497VHhB7RDedpti8ia5duzTR3k5NMgCYWDXXvA248I0q/s9EEEwP/laM
 vN2/tKxojxprmGcmbgqTwE7fI3PCmfqKcHb7wsB1UZsTY2avtWgwyymaCE9bEZYHer+d
 0v8s02Bn4N8MY2tpYA912LZE+Kb+PHIYGYrPUhHdHxEFDQuzzC3oEowfhl9fJFyruT8v
 kpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774328020; x=1774932820;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mBNloe+1G/K4rguGI5/7XbAx90AYey6wnlf+fCB2vCc=;
 b=hOlw3LXnh7tvzkMOJ3HzpHRBlBz3SJvPQwG7pBGGqwCnlVSfoWzysYyKy3z9+9Qsnq
 HfDBrC+zdCIN8gV2sghbdewQ7W2IZ1Oph/27M25Qt+8wLPZr5EC2dEoFB3oQXBbibExC
 x1EtJ9emdEjsqVFgjGHjV/YFiZyeTc/23H/hbQdQIqF/ideOPXLnz/EXjdiCGSdfM/kV
 cSY8cJNlLFlp2dQvCBVnZg2jf3Uoj8iMPbPjcuiqUInm3C3DRShn0LPfPikfH54GXWUY
 K76QhhqpJY1M3t7cytO7lKxpOd1KsXqYaLFgebJyHlyK32nKPqLammPX0urpsJWKYHDw
 kFJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLZjJfq59iH1zlGJaB8Yraw8PuJMHH3pKpoRADucP+Zxsa+rlXqIZvHbdu1m9+z0ibjwUxeKN2ulq1@nongnu.org
X-Gm-Message-State: AOJu0YywsdGYukrDqF96/tmNCCpY3XsWlTtJHD5HY86J1VDfztSiMYJy
 GTmcvO74cRH2N21M+kktx4OvTN5T6IQfRrEXqKal0KFAyP1chVlWIQebBo+LU/0JWtY=
X-Gm-Gg: ATEYQzzAE6SWCXaHobX+2LeVkrP/EePhhOegeFGPVjAvo10YXHpg8BarLJp6vN8SjxV
 vTv3xnNjHQfEw/c0xPyhFE3oN0OsbkV2fh67ehJhLF2NLkk3MhKpRcgsu2eFaJzcXQgME6X2kg8
 LGBo7YF02erZmMl/6qICjP7A8uQ4Wu2Ir3vskVvQ/KrDsAC8i+o5xktERF0+UD/AhZqEEDzQ6te
 rw1ET0KocpXxIcsvdR6xaY81XALiNfEtrpVK4cKDN+FZaheHp9h+RUK608+QmIhMg4lBm844d5S
 uGnAwsO0w1YyIZ72VFCFNKDbySfR3Nl5+f5t05rdYYRDYge694y6Vsl0FtNghg1hcH+jpBPejOf
 xSWRXEwvJ9C5r7cUW4Quer3ZUSrCehi3JJEN1ANLAhqwGq+/mzHmYy5wTbZBkp6+F0ZMglNBagA
 oJ6H0wy+6ZTjG9NjaTtdd3cPTKCr0NKGPG9wF+yHt7G2CO5hlOvqZlWWNNDgxLC3fGIEZEPJ197
 spM
X-Received: by 2002:a05:600c:530f:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-486fee0f92dmr201688035e9.20.1774328019992; 
 Mon, 23 Mar 2026 21:53:39 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116ee57esm21359115e9.14.2026.03.23.21.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 21:53:39 -0700 (PDT)
Message-ID: <27e0e408-eec9-4507-94f8-d8f9c392dc61@linaro.org>
Date: Tue, 24 Mar 2026 05:53:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtQQVRDSF0gYmxvY2svY3VybDogZnJlZSBz?=
 =?UTF-8?Q?-=3Epassword_in_cleanup_paths?=
To: =?UTF-8?B?6LW15Zu95rGX?= <zhaoguohan@kylinos.cn>,
 zhaoguohan_salmon <zhaoguohan_salmon@163.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
References: <764ug638jvkl-7651jdyo6106@nsmail8.2--kylin--1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <764ug638jvkl-7651jdyo6106@nsmail8.2--kylin--1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 24/3/26 04:25, 赵国汗 wrote:
>  > Should we directly call curl_close() here instead? Otherwise
> 
>  > factor a common curl_cleanup() out and reuse?
> 
> Thanks for the suggestion.
> 
> I don't think curl_close() can be used directly from out_noclean, since
> out_noclean is reached from partially initialized states.
> 
> curl_close() assumes a successfully opened instance and tears down the
> aio/curl state via curl_detach_aio_context(), while out_noclean is used
> before curl_attach_aio_context() and, in some cases, before s->sockets is
> initialized.
> 
> So I think reusing curl_close() here would conflate the open-failure and
> normal close paths.
> 
> If we want to deduplicate this later, factoring out only the common field
> cleanup into a small helper should be safer.

Yes, this is what I meant.

Regards,

Phil.

> *主   题：*Re: [PATCH] block/curl: free s->password in cleanup paths
> *日   期：*2026年03月20日17:24
> *发件人：*Philippe Mathieu-Daudé
> *收件人：*zhaoguohan_salmon,Kevin Wolf,Hanna Reitz,Philippe Mathieu-Daudé
> *抄送人：*qemu-block,qemu-devel
> 
> Hi, On 20/3/26 07:30, zhaoguohan_salmon@163.com wrote: > From: GuoHan 
> Zhao <zhaoguohan@kylinos.cn> > > When password-secret is used, 
> curl_open() resolves it with > qcrypto_secret_lookup_as_utf8() and 
> stores the returned buffer in > s->password. > > Unlike s- 
>  >proxypassword, s->password is not freed either in the open > failure 
> path or in curl_close(), so the resolved secret leaks once it > has been 
> allocated. > > Free s->password in both cleanup paths. > > Signed-off- 
> by: GuoHan Zhao <zhaoguohan@kylinos.cn> > --- > block/curl.c | 2 ++ > 1 
> file changed, 2 insertions(+) > > diff --git a/block/curl.c b/block/ 
> curl.c > index 66aecfb20ec6..419df78258bc 100644 > --- a/block/curl.c > 
> +++ b/block/curl.c > @@ -903,6 +903,7 @@ out_noclean: > g_free(s- 
>  >cookie); > g_free(s->url); > g_free(s->username); > + g_free(s- 
>  >password); > g_free(s->proxyusername); > g_free(s->proxypassword); > 
> if (s->sockets) { Should we directly call curl_close() here instead? 
> Otherwise factor a common curl_cleanup() out and reuse? > @@ -1014,6 
> +1015,7 @@ static void curl_close(BlockDriverState *bs) > g_free(s- 
>  >cookie); > g_free(s->url); > g_free(s->username); > + g_free(s- 
>  >password); > g_free(s->proxyusername); > g_free(s->proxypassword); > } 
> </zhaoguohan@kylinos.cn></zhaoguohan@kylinos.cn>
> 
> 
> ---
> 


