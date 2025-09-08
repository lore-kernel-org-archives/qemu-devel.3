Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3700DCA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 09:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvXvs-0001ug-4W; Mon, 08 Sep 2025 05:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvXvn-0001tX-2Q
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 05:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvXvg-0001PS-Gc
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 05:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757322765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H5DedatCWHavDvoZrpKK8PehOpLyFx44MUtfOsHcLfU=;
 b=aQqfTxp0sPQ0yIdXYajSWse59fA1l6H6Xg7nvTSd9BlVhFblu1Hn5CK3GpUnj6CS/gMxZo
 g6QU6lIaMUXrZ64MKFyB8GFczc9yIcX57EOjaokFPaIfult6Fn84N8R8Pw6NoYS6U482NG
 Gpce6Fl32kZDyk3FfPoah20tivuYXt0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-x9qPGwd2O0SYdGv7XU2j1g-1; Mon, 08 Sep 2025 05:12:43 -0400
X-MC-Unique: x9qPGwd2O0SYdGv7XU2j1g-1
X-Mimecast-MFC-AGG-ID: x9qPGwd2O0SYdGv7XU2j1g_1757322762
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b920e0c25so32049925e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 02:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757322762; x=1757927562;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H5DedatCWHavDvoZrpKK8PehOpLyFx44MUtfOsHcLfU=;
 b=w44PEacL9LHi5DL/nlwuEwml5Quu8iVWf1Ztn5vch5xhEFeHRP95sQ++qK0Jw4vESF
 x4kai9gOGuHqoo1G2XwKwNqLtcrt1z8Y/untK9DP/wtAECa9iywP58P2MbWCzs0JUMSY
 pHSzxplO65HNOlXdsKCf8KWOwdl8YhBfsR79i7hs8NJcvWZD5ol6do/qxUmYA9UdADD1
 a6n6Y27glUOVJSXpSRFD6i7j289qnx5vyymCgpmhN1wrx+1yvEDlUZvJifx2b8K5u1SH
 bcSfbXqaFLPGMTT3H6SYs+k+fPnyXhFnP2VYuYcl2nQFkndv/aoVdpwo9qW/X/mPwyKH
 Btzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUk3BOWAgZxcTcJhU2jUtGquXU5oWns2e5B26ema8IoiZhOfIA+CxAshSEofpahCEQFAoYYHXUpzn/@nongnu.org
X-Gm-Message-State: AOJu0Yw6rz9AHLHmoCMYxTFOaLlUibCyHVIkgYxNPMcM9HQLi2V1a275
 sZCZjq3vJJDtcFQxpAnyQKsGo8NGa/RF6rnwHRpSuCIHxdJvmweS4rdNTeL2k519mMzvrckCWq2
 Rul7uzVsPOQmjZiQs2Z6dn43p9tUINREJY2+23FTVpznACIVbHlkCneEK
X-Gm-Gg: ASbGncukZEE6T0O64ikGhrHyBCVCvG/UMgqjn1etbsSMSLvNZ1pkVOnAhwg9ZZXLL3J
 jUylT8duBlSQ7cI2mBGcQI3BiuombIugOvKf+o2YB05OdB6bKEvDh3pUQIn3Ugb1yTN1f3Yy6qs
 AkZAYvp/lUmJ4SXoDO7MJgInyhHhg5t930GoNZ2FIWwXUZ4rXoCQjswcPxwV3XOVDDEHLQn1gCp
 YE61siy+yztPiFLAcGiZTof2SU55hcF3DpJ/OLYu449iTaXZ+huTUJ+NsaUcbXzbAg5XOVJgdxr
 HO9sbHQ9nOWMbB1hSwRWrwpvvDvaBlKG2oOl02leRnqAytV8KCUD9qMIF0qVORBaAMVD3jq5MpZ
 FJ5G0mw==
X-Received: by 2002:a05:600c:1912:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-45de2cf9a5cmr39526165e9.1.1757322762444; 
 Mon, 08 Sep 2025 02:12:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnisDzvToDGNWlrdFaGcylw8y03P/b0yNQySgMB6iaWqScPPEk/XLZ4CAP7VY+3cwWUrPhOQ==
X-Received: by 2002:a05:600c:1912:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-45de2cf9a5cmr39525825e9.1.1757322761975; 
 Mon, 08 Sep 2025 02:12:41 -0700 (PDT)
Received: from [192.168.0.5] (ltea-047-064-114-112.pools.arcor-ip.net.
 [47.64.114.112]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd2304e16sm179056905e9.7.2025.09.08.02.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 02:12:41 -0700 (PDT)
Message-ID: <e43d5fa3-6687-4837-b99c-5d95f0e563f1@redhat.com>
Date: Mon, 8 Sep 2025 11:12:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] tests/guest-debug: Add quiet option to run-tests.py
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, 1844144@gmail.com
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <20250904154640.52687-4-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250904154640.52687-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 04/09/2025 17.46, Gustavo Romero wrote:
> Add a --quiet option to run-tests.py so it can run without printing any
> messages to the stdout.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/guest-debug/run-test.py | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index e051e8947c..cf8b37b8b8 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -39,15 +39,17 @@ def get_args():
>       parser.add_argument("--stderr", help="A file to redirect stderr to")
>       parser.add_argument("--no-suspend", action="store_true",
>                           help="Ask the binary to not wait for GDB connection")
> +    parser.add_argument("--quiet", action="store_true", default=False,
> +                        help="Don't print any messages to stdout")
>   
>       return parser.parse_args()
>   
>   
> -def log(output, msg):
> +def log(output, msg, quiet):
>       if output:
>           output.write(msg + "\n")
>           output.flush()
> -    else:
> +    elif not quiet:
>           print(msg)
>   
>   
> @@ -91,7 +93,7 @@ def log(output, msg):
>               cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
>                   f' {args.binary}'
>   
> -        log(output, "QEMU CMD: %s" % (cmd))
> +        log(output, "QEMU CMD: %s" % (cmd), args.quiet)
>           inferior = subprocess.Popen(shlex.split(cmd))
>   
>       # Now launch gdb with our test and collect the result.
> @@ -117,7 +119,7 @@ def log(output, msg):
>   
>   
>       sleep(1)
> -    log(output, "GDB CMD: %s" % (gdb_cmd))
> +    log(output, "GDB CMD: %s" % (gdb_cmd), args.quiet)
>   
>       gdb_env = dict(os.environ)
>       gdb_pythonpath = gdb_env.get("PYTHONPATH", "").split(os.pathsep)

I can see two more calls to log() in that script, don't you need to change 
these spots, too:

$ grep log tests/guest-debug/run-test.py
def log(output, msg):
     log(output, "QEMU CMD: %s" % (cmd))
     log(output, "GDB CMD: %s" % (gdb_cmd))
         log(output, "GDB crashed? (%d, %d) SKIPPING" % (result, result - 128))
         log(output, "GDB never connected? Killed guest")

?

Maybe you could declare the new parameter with quiet=False by default, so 
that you don't have to worry?

  Thomas


