Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810F0CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNCZ-0008Kq-Fy; Sat, 30 Aug 2025 11:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uruyA-0003IK-Q9
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 05:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uruy8-0003gW-My
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 05:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756458023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uM7nWo3HlkGw7Vp7YF5UQq8KgXNNYI2938xsqFzL3d8=;
 b=Gfq/oF7CbibzzgbDO3LM16P8NwLaEfN1mbMEir609yOTQCGAmsE9Op097wsEdvTAcurOL3
 DqK1eNM4CEYC4CcKSaUt1hNaT1mvTthjzgIyK9wTDLb0TqDi9LcrZCWVboMWGMZ0wz23I6
 iH1fMqlu0wtJzxh0Nyl5tr/CUIwCldY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-PFGVrgCYMx2fXByYWpdvNQ-1; Fri, 29 Aug 2025 05:00:17 -0400
X-MC-Unique: PFGVrgCYMx2fXByYWpdvNQ-1
X-Mimecast-MFC-AGG-ID: PFGVrgCYMx2fXByYWpdvNQ_1756458016
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b7d84d8a0so3396985e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 02:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756458016; x=1757062816;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uM7nWo3HlkGw7Vp7YF5UQq8KgXNNYI2938xsqFzL3d8=;
 b=mQVA2fP7ACzMWAr7tlupMYDsWR1DLjbX5py0wbPi/ljtiGYE5EVvlFDjZIgNlDEqZ7
 MkU1RjuCZiBRbBnCvQ5dKA/T75o5ZR35T3FHKSHiL+tD3TcKVn8zKEuDaSaCVYPCJHkG
 CfwMjZoVq8Ufz3qfQ/tG07rGfJ/XLH7Sg4++S8WAGN3UtRdh0vz5Keca062hbLWN7uKF
 cU5vFXn8AA1fVOx1ELbSeA7kxbg6+LYAIA8vAL0sQH4SAMcB93wFb+aH6pza1cOaC7H2
 YzParo7BrVwYDFDUaWBJwpIGjxrsxcGjXnknHQ9VPZqU6c/aSeF6st8ar5zzrQUSzslC
 Ib/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7B4fcjEq+k7XxxS0HFZzBQCxllU2I9sUNYSw40by8UEi3BjpC9utaHojCK12V9Pt602TJuG25+l5/@nongnu.org
X-Gm-Message-State: AOJu0Yyf+5xb+IMgjW2xWRzMePPo7tIf0yYc4mjNUIXQBEIgHXcvR8x3
 IKhkXMKUZoPfR/DDQaz50tWp5tL1DhzwIJ+0me1Pu4XuJSH4MRomQgTS+vnrT9NwrtUJN5hLSyy
 LfY8v0C4/VOzAU3hFFBjoQ9aY6X9yH+KBHfwsg3GhNXBwchyRmlaxlA6n
X-Gm-Gg: ASbGncsrPvLMVtYeDKgE2E3va4AN89d0ACvHZRZTTondpMJo04GZcXpX2NEHkwK9W8h
 0b5r8JyVDBzT7jVu9DqklpxSaOcvcCvMhucSTTZmYor8MF7t5lfzFY8AernSd+0jXuIZwNvc3JG
 iTtNiAljT4dSoupKMyTDzvO5g3qe/7x1VHLlzQQUJZKt4StY0ZQNweAUJMqqIBPstm5NDar4zxF
 LzNUTHZ/5TcPeG8YPIYsLQKInVCTu4NGUwj5GOgahiwBEdyoNKbUjGEMNFvGfB71Fg0AcUp2luG
 511/YDs2Xq+GUerH6Op2VzpS+FaG1cCEXcFpijQMyRN6pf4Gq+4gQJjZcTchPPWbNyfQ
X-Received: by 2002:a05:600c:1f95:b0:453:78f:fa9f with SMTP id
 5b1f17b1804b1-45b5179cfa5mr227352145e9.11.1756458015894; 
 Fri, 29 Aug 2025 02:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfncza+fn3l1Q1zRQprYOSqx7366roZsnYJHBs0yq74/r/vxUCYAH+20pvc2UZ33wImrUlsQ==
X-Received: by 2002:a05:600c:1f95:b0:453:78f:fa9f with SMTP id
 5b1f17b1804b1-45b5179cfa5mr227351725e9.11.1756458015404; 
 Fri, 29 Aug 2025 02:00:15 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-48-43.web.vodafone.de. [109.42.48.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b72c55c1bsm107878085e9.10.2025.08.29.02.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 02:00:14 -0700 (PDT)
Message-ID: <801f322a-6151-40ab-879a-f64e117d6d04@redhat.com>
Date: Fri, 29 Aug 2025 11:00:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/functional: handle URLError when fetching assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250829083156.2570137-1-berrange@redhat.com>
 <20250829083156.2570137-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250829083156.2570137-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/08/2025 10.31, Daniel P. Berrangé wrote:
> We treat most HTTP errors as non-fatal when fetching assets,
> but forgot to handle network level errors. This adds catching
> of URLError so that we retry on failure, and will ultimately
> trigger graceful skipping in the pre-cache task.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index ae2bec3ea5..36f64fe2f6 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -15,7 +15,7 @@
>   from time import sleep
>   from pathlib import Path
>   from shutil import copyfileobj
> -from urllib.error import HTTPError
> +from urllib.error import HTTPError, URLError
>   
>   class AssetError(Exception):
>       def __init__(self, asset, msg, transient=False):
> @@ -171,6 +171,13 @@ def fetch(self):
>                       raise AssetError(self, "Unable to download %s: "
>                                        "HTTP error %d" % (self.url, e.code))
>                   continue
> +            except URLError as e:
> +                # This is typically a network/service level error
> +                # eg urlopen error [Errno 110] Connection timed out>
> +                tmp_cache_file.unlink()
> +                self.log.error("Unable to download %s: URL error %s",
> +                               self.url, e)
> +                continue

Hmm, I don't think we should retry on each and every URLError. For example 
if you have a typo in the server name, you get a "Name or service not known" 
URLError, and it does not make sense to retry in that case.

Also, in case of the server being down, it takes a minute or two 'til the 
urllib gives up, so if you retry multiple times in that case, you can easily 
extend the test time by > 5 minutes (as you can see by the timestamps in the 
example in your cover letter), which is unfortunate, too (considering that 
there is also a timeout setting for the gitlab CI jobs).

I think I'd maybe rather do something like this instead, without retrying 
the download, just marking certain errors as transient:

        except URLError as e:
            tmp_cache_file.unlink()
            msg = str(e.reason)
            self.log.error("Unable to download %s: URL error %s",
                           self.url, msg)
            raise AssetError(self, msg,
                             transient=("Network is unreachable" in msg))

WDYT?

  Thomas


